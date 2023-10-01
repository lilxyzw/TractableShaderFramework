/*
#define TSF_VERTEX_IN_NORMAL
#define TSF_VERTEX_IN_TANGENT
#define TSF_VERTEX_IN_TEXCOORD0
#define TSF_VERTEX_IN_TEXCOORD1
#define TSF_VERTEX_IN_TEXCOORD2
#define TSF_VERTEX_IN_TEXCOORD3
#define TSF_VERTEX_IN_COLOR
#define TSF_VERTEX_IN_VERTEXID

#define TSF_PIXEL_IN_POSITION
#define TSF_PIXEL_IN_NORMAL
#define TSF_PIXEL_IN_TANGENT
#define TSF_PIXEL_IN_TEXCOORD0
#define TSF_PIXEL_IN_TEXCOORD1
#define TSF_PIXEL_IN_TEXCOORD2
#define TSF_PIXEL_IN_TEXCOORD3
#define TSF_PIXEL_IN_COLOR
#define TSF_PIXEL_IN_FACING
*/

struct TSF_AttributeData
{
    float3 positionOS;
    float3 positionWS;
    #ifdef TSF_VERTEX_IN_NORMAL
        float3 normalOS;
        float3 normalWS;
    #endif
    #ifdef TSF_VERTEX_IN_TANGENT
        float4 tangentOS;
        float4 tangentWS;
    #endif
    #if defined(TSF_VERTEX_IN_NORMAL) && defined(TSF_VERTEX_IN_TANGENT)
        float3 bitangentOS;
        float3 bitangentWS;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD0
        float4 uv0;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD1
        float4 uv1;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD2
        float4 uv2;
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD3
        float4 uv3;
    #endif
    #ifdef TSF_VERTEX_IN_COLOR
        float4 color;
    #endif
    #ifdef TSF_VERTEX_IN_VERTEXID
        uint vertexID;
    #endif
    #ifdef TSF_VERTEX_IN_INSTANCEID
        uint instanceID;
    #endif
};

TSF_AttributeData TSF_InitializeAttributeData()
{
    TSF_AttributeData ad;
    ad.positionOS = float3(0,0,0);
    #ifdef TSF_VERTEX_IN_NORMAL
        ad.normalOS = float3(0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_TANGENT
        ad.tangentOS = float4(0,0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD0
        ad.uv0 = float4(0,0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD1
        ad.uv1 = float4(0,0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD2
        ad.uv2 = float4(0,0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_TEXCOORD3
        ad.uv3 = float4(0,0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_COLOR
        ad.color = float4(0,0,0,0);
    #endif
    #ifdef TSF_VERTEX_IN_VERTEXID
        ad.vertexID = 0;
    #endif
    #ifdef TSF_VERTEX_IN_INSTANCEID
        ad.instanceID = 0;
    #endif
    return ad;
}

struct TSF_MeshData
{
    half4 col;
    float4 positionCS;
    #ifdef TSF_PIXEL_IN_POSITION
        float3 positionOS;
        float3 positionWS;
        half3 V;
    #endif
    #ifdef TSF_PIXEL_IN_NORMAL
        half3 normalOS;
        half3 normalWS;
    #endif
    #ifdef TSF_PIXEL_IN_TANGENT
        half3 tangentOS;
        half3 tangentWS;
        half tangentSign;
    #endif
    #if defined(TSF_PIXEL_IN_NORMAL) && defined(TSF_PIXEL_IN_TANGENT)
        half3 bitangentOS;
        half3 bitangentWS;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD0
        float4 uv0;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD1
        float4 uv1;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD2
        float4 uv2;
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD3
        float4 uv3;
    #endif
    #ifdef TSF_PIXEL_IN_COLOR
        half4 color;
    #endif
};

TSF_MeshData TSF_InitializeMeshData()
{
    TSF_MeshData md;
    md.col = half4(0,0,0,0);
    md.positionCS = float4(0,0,0,0);
    #ifdef TSF_PIXEL_IN_POSITION
        md.positionOS = float3(0,0,0);
        md.positionWS = float3(0,0,0);
        md.V = half3(0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_NORMAL
        md.normalOS = half3(0,0,0);
        md.normalWS = half3(0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_TANGENT
        md.tangentOS = half3(0,0,0);
        md.tangentWS = half3(0,0,0);
        md.tangentSign = 0;
    #endif
    #if defined(TSF_PIXEL_IN_NORMAL) && defined(TSF_PIXEL_IN_TANGENT)
        md.bitangentOS = half3(0,0,0);
        md.bitangentWS = half3(0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD0
        md.uv0 = float4(0,0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD1
        md.uv1 = float4(0,0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD2
        md.uv2 = float4(0,0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_TEXCOORD3
        md.uv3 = float4(0,0,0,0);
    #endif
    #ifdef TSF_PIXEL_IN_COLOR
        md.color = half4(0,0,0,0);
    #endif
    return md;
}