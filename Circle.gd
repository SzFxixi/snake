@tool
extends Sprite2D


# 可在编辑器中实时调整的参数（可视化）
@export var circle_radius: float = 30.0  # 圆的半径（像素）
@export var circle_color: Color = Color(1, 0, 0)  # 填充色（默认红色）
@export var outline_width: float = 2.0  # 描边宽度（0=无描边）
@export var outline_color: Color = Color(0, 0, 0)  # 描边色（默认黑色）
@export var anti_aliased: bool = true  # 抗锯齿（边缘更平滑）


# 重写CanvasItem的_draw方法，在节点渲染时画圆
func _draw() -> void:
	# 1. 绘制描边（空心圆）：如果描边宽度>0才画
	if outline_width > 0:
		draw_circle(
			Vector2.ZERO,  # 圆心（Node2D的本地原点，即节点的position位置）
			circle_radius + outline_width,  # 描边的半径（填充圆半径+描边宽度）
			outline_color,  # 描边颜色
			false,
			outline_width,  # 描边的粗细
			anti_aliased  # 抗锯齿
		)
	
	# 2. 绘制实心填充圆
	draw_circle(
		Vector2.ZERO,  # 圆心（和节点position对齐）
		circle_radius,  # 填充圆的半径
		circle_color,  # 填充颜色
		true,
		0.0,  # 填充模式（0=实心，大于0=空心）
		anti_aliased  # 抗锯齿
	)
