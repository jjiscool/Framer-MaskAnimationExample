b=new Layer
	y: 1119
	x: 256
	width: 299
	height: 98
	backgroundColor: "rgba(0,128,255,1)"
	borderRadius: 18
	shadowSpread: 2
	shadowColor: "rgba(0,0,0,1)"
	shadowBlur: 24
btext= new Layer
	width: 500
	y: 35
	x: 35
	html:"<font size=6>Start Animation</font>"
	backgroundColor: ""
	parent: b
backgroundA = new BackgroundLayer
#Layer with Mask
mask = new Layer
	width: 750
	height: 1334
	image: "images/1029163a1-5.jpg"
	name: "mask"
stateA=	
	width:375
	height:667
	path:"M112,157 L150.5,138 L214,155 L242.5,141 L277,178.5 L260.5,206 L203.5,212.5 L189,190 L159.5,216.5 L105,213.5 L99,170.5 L112,157 Z"
stateB=
	width:375
	height:667
	path:"M61.5,187 L165.5,211 L229.5,200 L318,149.5 L292,251.5 L318,321.5 L218.5,285.5 L203,328.5 L174.5,289.5 L93.5,314.5 L114,243.5 L61.5,187 Z" 
options1=
	AnimationName : "A1"
	masklayer:mask
	animation: "ease"
	infinite: "forwards" #forwards or infinite
	time:1
	AnimationEnd:null
# swith Instant stateA
switchInstantPolygonMask = (stateA,options) ->
	GenPath = (D,options,p) ->
		pathlist=D.split(" ")
		output = "polygon("
		for i in [0..pathlist.length-2]
			str=pathlist[i]
			sstr=str.slice(1,)
			if sstr != ""
				xy=sstr.split(",")
				xy[0]=parseFloat(xy[0])*(options.masklayer.width/p.width)+options.masklayer.x
				xy[1]=parseFloat(xy[1])*(options.masklayer.height/p.height)+options.masklayer.y
				if i != pathlist.length-2 
					output+=xy[0]+"px "+xy[1]+"px,"
				else 
					output+=xy[0]+"px "+xy[1]+"px)"
		output
	beginpath=GenPath(stateA.path,options,stateA)
	Utils.insertCSS("[name='"+options.masklayer.name+"'] {animation: "+options.AnimationName+" "+options.time+"s "+options.animation+" "+options.infinite+";}@keyframes "+options.AnimationName+" {100%{-webkit-clip-path:"+beginpath+" }}")
# swith from stateA to stateB
options2=
	AnimationName : "A2"
	masklayer:mask
	animation: "ease"
	infinite: "forwards" #forwards or infinite
	time : 1
	AnimationEnd:null
options3=
	AnimationName : "A3"
	masklayer:mask
	animation: "ease"
	infinite: "forwards" #forwards or infinite
	AnimationEnd:null
	time : 1
switchPolygonMask = (stateA,stateB,options) ->
	GenPath = (D,options,p) ->
		pathlist=D.split(" ")
		output = "polygon("
		for i in [0..pathlist.length-2]
			str=pathlist[i]
			sstr=str.slice(1,)
			if sstr != ""
				xy=sstr.split(",")
				xy[0]=parseFloat(xy[0])*(options.masklayer.width/p.width)+options.masklayer.x
				xy[1]=parseFloat(xy[1])*(options.masklayer.height/p.height)+options.masklayer.y
				if i != pathlist.length-2 
					output+=xy[0]+"px "+xy[1]+"px,"
				else 
					output+=xy[0]+"px "+xy[1]+"px)"
		output
	beginpath=GenPath(stateA.path,options,stateA)
	endpath=GenPath(stateB.path,options,stateB)
	Utils.insertCSS("[name='"+options.masklayer.name+"'] {animation: "+options.AnimationName+" "+options.time+"s "+options.animation+" "+options.infinite+" ;}@keyframes "+options.AnimationName+" {0%{-webkit-clip-path:"+beginpath+" }100%{-webkit-clip-path: "+endpath+"}}")
	

MaskAnimation=switchInstantPolygonMask(stateA,options1)
isStateB=false
b.onTap -> 
	if isStateB == false 
		MaskAnimation.parentNode.removeChild(MaskAnimation);
		MaskAnimation=switchPolygonMask(stateA,stateB,options2)
		isStateB=true
	else 
		MaskAnimation.parentNode.removeChild(MaskAnimation);
		MaskAnimation=switchPolygonMask(stateB,stateA,options3)
		isStateB=false
document.getElementsByName("mask")[0].addEventListener('webkitAnimationEnd',()->
				#print "end"
			)





