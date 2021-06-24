//first shader structure - written in a language called ShaderLab
Shader "Holistic/HelloShader" { //Holistic is the folder, HelloShader is the name
	Properties{
		_myColour ("Example Colour", Color) = (1,1,1,1) //input fields  - this is a Color Picker
		_myEmission ("Example Emission", Color) = (1,1,1,1)
		_myNormal("Example Normal", Color) = (1,1,1,1)
	}

		SubShader{ //this is where the magic happens - the processing - CG/HLSL language
			CGPROGRAM
				//#pragma tells us how we are going to use the shader, contains "surface" (surface shader), name of function (surf), type of lighting (Lambert)
				#pragma surface surf Lambert 

				struct Input { //input data from model mesh (vertices, normals, etc)
					float2 uvMainTex;
				};
				
				//declare all of your variables here!  Just because you put them in Properties above does not mean you will be able to see them in the functions below!
				fixed4 _myColour; //properties that you want available to the shader function (array of 4 float values in this case)
				fixed4 _myEmission;
				fixed4 _myNormal;
	
				void surf(Input IN, inout SurfaceOutput o) { //takes in input structure, the output structure, and what we are changing, Lambert uses SurfaceOutput
					o.Albedo = _myColour.rgb; //changing Albedo color to the color in the color picker, this basically turns the object to that color
					o.Emission = _myEmission.rgb; //changes the light emissions to this color, lose all of the detail on the model, a flat looking model
					o.Normal = _myNormal.rgb;
				}
			ENDCG
		}
		FallBack "Diffuse" //for inferior GPUs - a fallback - less GPU heavy effect should the machine be incapable of running your code
}