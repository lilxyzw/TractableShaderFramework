#ifdef TSF_VERTEX_IN_NORMAL
    #define ATTRIBUTES_NEED_NORMAL
#endif
#ifdef TSF_VERTEX_IN_TANGENT
    #define ATTRIBUTES_NEED_TANGENT
#endif
#ifdef TSF_VERTEX_IN_TEXCOORD0
    #define ATTRIBUTES_NEED_TEXCOORD0
#endif
#ifdef TSF_VERTEX_IN_TEXCOORD1
    #define ATTRIBUTES_NEED_TEXCOORD1
#endif
#ifdef TSF_VERTEX_IN_TEXCOORD2
    #define ATTRIBUTES_NEED_TEXCOORD2
#endif
#ifdef TSF_VERTEX_IN_TEXCOORD3
    #define ATTRIBUTES_NEED_TEXCOORD3
#endif
#ifdef TSF_VERTEX_IN_COLOR
    #define ATTRIBUTES_NEED_COLOR
#endif
#ifdef TSF_VERTEX_IN_VERTEXID
    #define ATTRIBUTES_NEED_VERTEXID
#endif

#ifdef TSF_PIXEL_IN_POSITION
    #define VARYINGS_NEED_POSITION_WS
#endif
#ifdef TSF_PIXEL_IN_NORMAL
    #define VARYINGS_NEED_NORMAL_WS
#endif
#ifdef TSF_PIXEL_IN_TANGENT
    #define VARYINGS_NEED_TANGENT_WS
#endif
#ifdef TSF_PIXEL_IN_TEXCOORD0
    #define VARYINGS_NEED_TEXCOORD0
#endif
#ifdef TSF_PIXEL_IN_TEXCOORD1
    #define VARYINGS_NEED_TEXCOORD1
#endif
#ifdef TSF_PIXEL_IN_TEXCOORD2
    #define VARYINGS_NEED_TEXCOORD2
#endif
#ifdef TSF_PIXEL_IN_TEXCOORD3
    #define VARYINGS_NEED_TEXCOORD3
#endif
#ifdef TSF_PIXEL_IN_COLOR
    #define VARYINGS_NEED_COLOR
#endif
#ifdef TSF_PIXEL_IN_CULLFACE
    #define VARYINGS_NEED_CULLFACE
#endif

// vertex mod
#define FEATURES_GRAPH_VERTEX
#define PackVaryings(o) PackVaryingsCustom(o, input)

#ifdef SCENEPICKINGPASS
    float4 _SelectionID;
#endif
#ifdef SCENESELECTIONPASS
    int _ObjectId;
    int _PassValue;
#endif

struct Attributes
{
    float3 positionOS : POSITION;
    #ifdef ATTRIBUTES_NEED_NORMAL
        float3 normalOS : NORMAL;
    #endif
    #ifdef ATTRIBUTES_NEED_TANGENT
        float4 tangentOS : TANGENT;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD0
        float4 uv0 : TEXCOORD0;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD1
        float4 uv1 : TEXCOORD1;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD2
        float4 uv2 : TEXCOORD2;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD3
        float4 uv3 : TEXCOORD3;
    #endif
    #ifdef ATTRIBUTES_NEED_COLOR
        float4 color : COLOR;
    #endif
    #ifdef ATTRIBUTES_NEED_VERTEXID
        uint vertexID : VERTEXID_SEMANTIC;
    #endif
    #if UNITY_ANY_INSTANCING_ENABLED
        uint instanceID : INSTANCEID_SEMANTIC;
    #endif
};

struct Varyings
{
    float4 positionCS : SV_POSITION;
    #ifdef VARYINGS_NEED_POSITION_WS
        float3 positionWS;
    #endif
    #ifdef VARYINGS_NEED_NORMAL_WS
        float3 normalWS;
    #endif
    #ifdef VARYINGS_NEED_TANGENT_WS
        float4 tangentWS;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD0
        float4 texCoord0;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD1
        float4 texCoord1;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD2
        float4 texCoord2;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD3
        float4 texCoord3;
    #endif
    #ifdef VARYINGS_NEED_COLOR
        float4 color;
    #endif

    #if UNITY_ANY_INSTANCING_ENABLED
        uint instanceID : CUSTOM_INSTANCE_ID;
    #endif
    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
    #endif
    #if defined(UNITY_STEREO_INSTANCING_ENABLED)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
    #endif
};

struct PackedVaryings
{
    float4 positionCS : SV_POSITION;
    #ifdef VARYINGS_NEED_TANGENT_WS
        float4 tangentWS : TEXCOORD0;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD0
        float4 texCoord0 : TEXCOORD1;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD1
        float4 texCoord1 : TEXCOORD2;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD2
        float4 texCoord2 : TEXCOORD3;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD3
        float4 texCoord3 : TEXCOORD4;
    #endif
    #ifdef VARYINGS_NEED_COLOR
        float4 color : TEXCOORD5;
    #endif
    #ifdef VARYINGS_NEED_POSITION_WS
        float3 positionWS : TEXCOORD6;
    #endif
    #ifdef VARYINGS_NEED_NORMAL_WS
        float3 normalWS : TEXCOORD7;
    #endif

    #if UNITY_ANY_INSTANCING_ENABLED
        uint instanceID : CUSTOM_INSTANCE_ID;
    #endif
    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
    #endif
    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
    #endif
};

PackedVaryings PackVaryingsCustom(Varyings input, Attributes at)
{
    PackedVaryings output = (PackedVaryings)0;
    output.positionCS = input.positionCS;
    #ifdef VARYINGS_NEED_TANGENT_WS
        output.tangentWS = input.tangentWS;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD0
        output.texCoord0 = input.texCoord0;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD1
        output.texCoord1 = input.texCoord1;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD2
        output.texCoord2 = input.texCoord2;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD3
        output.texCoord3 = input.texCoord3;
    #endif
    #ifdef VARYINGS_NEED_COLOR
        output.color = input.color;
    #endif
    #ifdef VARYINGS_NEED_POSITION_WS
        output.positionWS = input.positionWS;
    #endif
    #ifdef VARYINGS_NEED_NORMAL_WS
        output.normalWS = input.normalWS;
    #endif

    #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
    #endif
    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
    #endif
    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
    #endif
    return output;
}

Varyings UnpackVaryings(PackedVaryings input)
{
    Varyings output;
    output.positionCS = input.positionCS;
    #ifdef VARYINGS_NEED_TANGENT_WS
        output.tangentWS = input.tangentWS;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD0
        output.texCoord0 = input.texCoord0;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD1
        output.texCoord1 = input.texCoord1;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD2
        output.texCoord2 = input.texCoord2;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD3
        output.texCoord3 = input.texCoord3;
    #endif
    #ifdef VARYINGS_NEED_COLOR
        output.color = input.color;
    #endif
    #ifdef VARYINGS_NEED_POSITION_WS
        output.positionWS = input.positionWS;
    #endif
    #ifdef VARYINGS_NEED_NORMAL_WS
        output.normalWS = input.normalWS;
    #endif

    #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
    #endif
    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
    #endif
    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
    #endif
    return output;
}

struct VertexDescriptionInputs
{
    TSF_AttributeData ad;
};

struct SurfaceDescriptionInputs
{
    TSF_MeshData md;

    #if UNITY_ANY_INSTANCING_ENABLED
        uint instanceID : CUSTOM_INSTANCE_ID;
    #endif
    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
    #endif
    #if defined(UNITY_STEREO_INSTANCING_ENABLED)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
    #endif
};

struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    TSF_AttributeData ad = (TSF_AttributeData)0;

    ad.positionOS = input.positionOS;
    ad.positionWS = TransformObjectToWorld(input.positionOS);
    #ifdef ATTRIBUTES_NEED_NORMAL
        ad.normalOS = input.normalOS;
        ad.normalWS = TransformObjectToWorldNormal(input.normalOS);
    #endif
    #ifdef ATTRIBUTES_NEED_TANGENT
        ad.tangentOS = input.tangentOS.xyzw;
        ad.tangentWS = float4(TransformObjectToWorldDir(input.tangentOS.xyz), input.tangentOS.w);
    #endif
    #if defined(ATTRIBUTES_NEED_NORMAL) && defined(ATTRIBUTES_NEED_TANGENT)
        ad.bitangentOS = normalize(cross(input.normalOS, input.tangentOS.xyz) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
        ad.bitangentWS = TransformObjectToWorldDir(ad.bitangentOS);
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD0
        ad.uv0 = input.uv0;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD1
        ad.uv1 = input.uv1;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD2
        ad.uv2 = input.uv2;
    #endif
    #ifdef ATTRIBUTES_NEED_TEXCOORD3
        ad.uv3 = input.uv3;
    #endif
    #ifdef ATTRIBUTES_NEED_COLOR
        ad.color = input.color;
    #endif
    #ifdef ATTRIBUTES_NEED_VERTEXID
        ad.vertexID = input.vertexID;
    #endif
    #if UNITY_ANY_INSTANCING_ENABLED && defined(TSF_VERTEX_IN_INSTANCEID)
        ad.instanceID = input.instanceID;
    #endif

    VertexDescriptionInputs output;
    output.ad = ad;

    return output;
}

struct SurfaceDescription
{
    half3 BaseColor;
    half Alpha;
    half AlphaClipThreshold;
};

SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    TSF_MeshData md = (TSF_MeshData)0;

    #if defined(VARYINGS_NEED_NORMAL_WS)
        const float renormFactor = 1.0 / length(input.normalWS);
    #elif defined(VARYINGS_NEED_TANGENT_WS)
        const float renormFactor = 1.0 / length(input.tangentWS.xyz);
    #endif

    md.col = half4(1,1,1,1);
    md.positionCS = input.positionCS;
    #ifdef VARYINGS_NEED_POSITION_WS
        md.positionWS = input.positionWS;
        md.positionOS = TransformWorldToObject(input.positionWS);
        md.V = normalize(_WorldSpaceCameraPos.xyz - md.positionWS);
    #endif
    #ifdef VARYINGS_NEED_NORMAL_WS
        md.normalWS = renormFactor * input.normalWS.xyz;
        md.normalOS = normalize(mul(md.normalWS, (float3x3)UNITY_MATRIX_M));;
    #endif
    #ifdef VARYINGS_NEED_TANGENT_WS
        md.tangentWS = renormFactor * input.tangentWS.xyz;
        md.tangentOS = TransformWorldToObjectDir(md.tangentWS.xyz);
        md.tangentSign = input.tangentWS.w;
    #endif
    #if defined(VARYINGS_NEED_NORMAL_WS) && defined(VARYINGS_NEED_TANGENT_WS)
        float3 bitangentWS = cross(input.normalWS.xyz, input.tangentWS.xyz) * (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        md.bitangentWS = renormFactor * bitangentWS;
        md.bitangentOS = TransformWorldToObjectDir(md.bitangentWS);
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD0
        md.uv0 = input.texCoord0;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD1
        md.uv1 = input.texCoord1;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD2
        md.uv2 = input.texCoord2;
    #endif
    #ifdef VARYINGS_NEED_TEXCOORD3
        md.uv3 = input.texCoord3;
    #endif
    #ifdef VARYINGS_NEED_COLOR
        md.color = input.color;
    #endif

    SurfaceDescriptionInputs output = (SurfaceDescriptionInputs)0;
    output.md = md;
    #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
    #endif
    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
    #endif
    #if defined(UNITY_STEREO_INSTANCING_ENABLED)
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
    #endif
    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = IS_FRONT_VFACE(input.cullFace, true, false);
    #endif

    return output;
}

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs input)
{
    TSF_AttributeData ad = input.ad;
    TSF_VertexModify(ad);
    VertexDescription description = (VertexDescription)0;
    description.Position = ad.positionOS;
    #ifdef ATTRIBUTES_NEED_NORMAL
        description.Normal = ad.normalOS;
    #endif
    #ifdef ATTRIBUTES_NEED_TANGENT
        description.Tangent = ad.tangentOS.xyz;
    #endif
    return description;
}

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs input)
{
    TSF_MeshData md = input.md;
    TSF_CustomData cd = TSF_InitializeCustomData();

    half4 col = TSF_MainShading(md, cd);

    SurfaceDescription surface = (SurfaceDescription)0;
    surface.BaseColor = col.rgb;
    surface.Alpha = col.a;
    surface.AlphaClipThreshold = 0.0;
    return surface;
}