﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/SingleColor"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
		
			struct v2f {
				half3 worldNormal : TEXCOORD0;
				float4 pos : SV_POSITION;	
			};

			v2f vert(float4 vertex : POSITION, float3 normal : NORMAL)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(vertex);
				// UnityCG.cginc file contains function to transform
				// normal from object to world space, use that
				o.worldNormal = UnityObjectToWorldNormal(normal);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 c = 0;
			// normal is a 3D vector with xyz components; in -1..1
			// range. To display it as color, bring the range into 0..1
			// and put into red, green, blue components
			c.rgb = i.worldNormal*0.5 + 0.5;
			return c;
			}
			ENDCG
		}
	}
}
