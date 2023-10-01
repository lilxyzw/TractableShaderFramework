#if defined(UNITY_INSTANCING_ENABLED) || defined(UNITY_PROCEDURAL_INSTANCING_ENABLED) || defined(UNITY_STEREO_INSTANCING_ENABLED)
#define UNITY_ANY_INSTANCING_ENABLED
#endif

struct appdata
{
    float3 positionOS : POSITION;
    #ifdef TSF_VERTEX_IN_NORMAL
        float3 normalOS : NORMAL;
    #endif
    #ifdef TSF_VERTEX_IN_TANGENT
        float4 tangentOS : TANGENT;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD0
        float4 uv0 : TEXCOORD0;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD1
        float4 uv1 : TEXCOORD1;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD2
        float4 uv2 : TEXCOORD2;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD3
        float4 uv3 : TEXCOORD3;
    #endif
    #ifdef TSF_VERTEX_IN_COLOR
        float4 color : COLOR;
    #endif
    #ifdef TSF_VERTEX_IN_VERTEXID
        uint vertexID : SV_VERTEXID;
    #endif
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct v2f
{
    float4 positionCS : SV_POSITION;
    #ifdef TSF_PIXEL_IN_TANGENT
        float4 tangentWS : TEXCOORD0;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD0
        float4 uv0 : TEXCOORD1;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD1
        float4 uv1 : TEXCOORD2;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD2
        float4 uv2 : TEXCOORD3;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD3
        float4 uv3 : TEXCOORD4;
    #endif
    #ifdef TSF_PIXEL_IN_COLOR
        float4 color : TEXCOORD5;
    #endif
    #ifdef TSF_PIXEL_IN_POSITION
        float3 positionWS : TEXCOORD6;
    #endif
    #ifdef TSF_PIXEL_IN_NORMAL
        float3 normalWS : TEXCOORD7;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(TSF_PIXEL_IN_FACING)
        #if defined(SHADER_API_GLCORE) || defined(SHADER_API_GLES) || defined(SHADER_API_D3D9)
            float facing : VFACE;
        #elif !defined(SHADER_API_D3D11_9X)
            bool isFrontFace : SV_IsFrontFace;
        #endif
    #endif

    UNITY_FOG_COORDS(8)
    UNITY_VERTEX_INPUT_INSTANCE_ID
    UNITY_VERTEX_OUTPUT_STEREO
};

v2f vert(appdata v)
{
    v2f o;
    UNITY_SETUP_INSTANCE_ID(v);
    UNITY_TRANSFER_INSTANCE_ID(v, o);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

    TSF_AttributeData ad = (TSF_AttributeData)0;
    ad.positionOS = v.positionOS;
    ad.positionWS = mul(UNITY_MATRIX_M, v.positionOS);
    #ifdef TSF_VERTEX_IN_NORMAL
        ad.normalOS = v.normalOS;
        ad.normalWS = UnityObjectToWorldNormal(v.normalOS);
    #endif
    #ifdef TSF_VERTEX_IN_TANGENT
        ad.tangentOS = v.tangentOS.xyzw;
        ad.tangentWS = float4(UnityObjectToWorldDir(v.tangentOS.xyz), v.tangentOS.w);
    #endif
    #if defined(TSF_VERTEX_IN_NORMAL) && defined(TSF_VERTEX_IN_TANGENT)
        ad.bitangentOS = normalize(cross(v.normalOS, v.tangentOS.xyz) * (v.tangentOS.w > 0.0f ? 1.0f : -1.0f) * unity_WorldTransformParams.w);
        ad.bitangentWS = UnityObjectToWorldDir(ad.bitangentOS);
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD0
        ad.uv0 = v.uv0;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD1
        ad.uv1 = v.uv1;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD2
        ad.uv2 = v.uv2;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD3
        ad.uv3 = v.uv3;
    #endif
    #ifdef TSF_VERTEX_IN_COLOR
        ad.color = v.color;
    #endif
    #ifdef TSF_VERTEX_IN_VERTEXID
        ad.vertexID = v.vertexID;
    #endif
    #if UNITY_ANY_INSTANCING_ENABLED && defined(TSF_VERTEX_IN_INSTANCEID)
        ad.instanceID = v.instanceID;
    #endif

    TSF_VertexModify(ad);

    o.positionCS = UnityObjectToClipPos(ad.positionOS.xyz);
    #ifdef TSF_PIXEL_IN_POSITION
        o.positionWS = ad.positionWS;
    #endif
    #ifdef TSF_PIXEL_IN_NORMAL
        o.normalWS = UnityObjectToWorldNormal(ad.normalOS);
    #endif
    #ifdef TSF_PIXEL_IN_TANGENT
        o.tangentWS = float4(UnityObjectToWorldDir(ad.tangentOS.xyz), ad.tangentOS.w);
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD0
        o.uv0 = ad.uv0;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD1
        o.uv1 = ad.uv1;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD2
        o.uv2 = ad.uv2;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD3
        o.uv3 = ad.uv3;
    #endif
    #ifdef TSF_PIXEL_IN_COLOR
        o.color = ad.color;
    #endif

    UNITY_TRANSFER_FOG(o,o.positionCS);
    return o;
}

half4 frag(v2f i) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(i);
    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

    TSF_MeshData md = (TSF_MeshData)0;
    md.col = half4(1,1,1,1);
    md.positionCS = i.positionCS;
    #ifdef TSF_PIXEL_IN_POSITION
        md.positionWS = i.positionWS;
        md.positionOS = mul(unity_WorldToObject, float4(md.positionWS,1));
        md.V = normalize(_WorldSpaceCameraPos.xyz - md.positionWS);
    #endif
    #ifdef TSF_PIXEL_IN_NORMAL
        md.normalWS = i.normalWS;
        md.normalOS = UnityWorldToObjectDir(md.normalWS);
    #endif
    #ifdef TSF_PIXEL_IN_TANGENT
        md.tangentWS = i.tangentWS.xyz;
        md.tangentOS = UnityWorldToObjectDir(md.tangentWS.xyz);
        md.tangentSign = i.tangentWS.w;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD0
        md.uv0 = i.uv0;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD1
        md.uv1 = i.uv1;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD2
        md.uv2 = i.uv2;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD3
        md.uv3 = i.uv3;
    #endif
    #ifdef TSF_PIXEL_IN_COLOR
        md.color = i.color;
    #endif
    #if UNITY_ANY_INSTANCING_ENABLED && defined(TSF_PIXEL_IN_INSTANCEID)
        md.instanceID = i.instanceID;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(TSF_PIXEL_IN_FACING)
        #if defined(SHADER_API_GLCORE) || defined(SHADER_API_GLES) || defined(SHADER_API_D3D9)
            md.isFrontFace = i.facing > 0;
        #elif !defined(SHADER_API_D3D11_9X)
            md.isFrontFace = i.isFrontFace;
        #endif
    #endif
    TSF_CustomData cd = TSF_InitializeCustomData();

    half4 col = TSF_MainShading(md, cd);

    UNITY_APPLY_FOG(i.fogCoord, col);
    return col;
}