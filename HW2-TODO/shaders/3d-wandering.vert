#version 300 es

// attribute每顶点各用的属性，IN variable
in vec4 vPosition; //顶点位置
in vec4 vColor;//顶点颜色

// uniform所用顶点公用的数据，IN variable
uniform int u_Flag;
uniform mat4 u_ModelMatrix;
uniform mat4 u_ViewMatrix;
uniform mat4 u_ProjectionMatrix;

// varying传递下去的变量，OUT varible
out vec4 fColor;


// MVP初始为单位矩阵
mat4 MVP = mat4(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0 
);

void main() {
    // 根据 u_Flag 选择变换矩阵
    if(u_Flag == 1){ 
        MVP = u_ProjectionMatrix * u_ViewMatrix * u_ModelMatrix; 
    }
    else { // 绘制坐标轴
        MVP = u_ProjectionMatrix * u_ViewMatrix;
    }  

    // 将MVP复合变换矩阵作用于该顶点计算坐标，以及传递顶点原色
    gl_Position = MVP * vPosition;     
    fColor = vColor;
}