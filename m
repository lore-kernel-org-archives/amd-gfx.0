From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm: should break if already get the best size
Date: Mon, 26 Nov 2018 07:44:50 +0000
Message-ID: <CY4PR1201MB0245E0A12D3CF9DCFA91A7D684D70@CY4PR1201MB0245.namprd12.prod.outlook.com>
References: <1542889986-13261-1-git-send-email-Monk.Liu@amd.com>,
 <BN7PR12MB2770EAF767A7AFC6CE0A6ADCFBD40@BN7PR12MB2770.namprd12.prod.outlook.com>
 <BN6PR12MB18098F780A02FF1CEAE32D07F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1506049070=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18098F780A02FF1CEAE32D07F7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1506049070==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0245E0A12D3CF9DCFA91A7D684D70CY4PR1201MB0245_"

--_000_CY4PR1201MB0245E0A12D3CF9DCFA91A7D684D70CY4PR1201MB0245_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok, will send a v2 version with description

From: Deucher, Alexander
Sent: Saturday, November 24, 2018 3:34 AM
To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx@lists=
.freedesktop.org
Subject: Re: [PATCH] drm: should break if already get the best size


Please add a proper patch description.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.=
Zhu-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, November 23, 2018 4:44:31 AM
To: Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org>
Subject: Re: [PATCH] drm: should break if already get the best size


Tested-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>



Without this patch, if we search node via rb tree.



For example: we insert 9999 different node with rand size, size range in (1=
-9999).



the key in root node is 5587.



if we try to find the node with key equal to 5587 or 7381,


Loop:
node->key is 5587
node->key is 2273
node->key is 3706
node->key is 4892
node->key is 5296
node->key is 5461
node->key is 5519
node->key is 5549
node->key is 5570
node->key is 5581
node->key is 5584
node->key is 5585
node->key is 5586
node->key is 5586

Find the best node, key is 5587 (Loop 14 levels)

Loop:
node->key is 5587
node->key is 7381
node->key is 6474
node->key is 7034
node->key is 7228
node->key is 7314
node->key is 7339
node->key is 7349
node->key is 7372
node->key is 7377
node->key is 7378
node->key is 7379
node->key is 7379

find the best node, key is 7381. (Loop 13 levels)



With this patch:

we don't need to go down if we found the right node that size equal to we n=
eeded.



Best Regards
Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Mon=
k.Liu-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, November 22, 2018 8:33 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Liu, Monk
Subject: [PATCH] drm: should break if already get the best size

Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/drm_mm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 3cc5fbd..369fd9b 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -318,6 +318,8 @@ static struct drm_mm_node *best_hole(struct drm_mm *mm,=
 u64 size)
                 if (size <=3D node->hole_size) {
                         best =3D node;
                         rb =3D rb->rb_right;
+                       if (size =3D=3D node->hole_size)
+                               break;
                 } else {
                         rb =3D rb->rb_left;
                 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>. Yo=
u can subscribe to the list, or change your existing subscription, in the s=
ections below.



--_000_CY4PR1201MB0245E0A12D3CF9DCFA91A7D684D70CY4PR1201MB0245_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Ok, will send a v2 version with description <o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander <br>
<b>Sent:</b> Saturday, November 24, 2018 3:34 AM<br>
<b>To:</b> Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org=
&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm: should break if already get the best size<=
o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Please add a proper patch d=
escription.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Zhu, Rex &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<b=
r>
<b>Sent:</b> Friday, November 23, 2018 4:44:31 AM<br>
<b>To:</b> Liu, Monk; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm: should break if already get the best size<=
/span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Tested-by: Rex Zhu &lt;<a h=
ref=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Without this patch, if we s=
earch&nbsp;node via rb tree.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">For example: we insert 9999=
 different node with rand size, size range in (1-9999).<o:p></o:p></span></=
p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">the key in root node is 558=
7.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">if we try to find the node =
with key equal to 5587 or 7381,<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Loop:<b=
r>
node-&gt;key is </span><span style=3D"font-size:12.0pt;color:red">5587</spa=
n><span style=3D"font-size:12.0pt;color:black"><br>
node-&gt;key is 2273<br>
node-&gt;key is 3706<br>
node-&gt;key is 4892<br>
node-&gt;key is 5296<br>
node-&gt;key is 5461<br>
node-&gt;key is 5519<br>
node-&gt;key is 5549<br>
node-&gt;key is 5570<br>
node-&gt;key is 5581<br>
node-&gt;key is 5584<br>
node-&gt;key is 5585<br>
node-&gt;key is 5586<br>
node-&gt;key is 5586<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Find th=
e best node, key is
</span><span style=3D"font-size:12.0pt;color:red">5587 </span><i><span styl=
e=3D"font-size:12.0pt;color:black">(Loop 14 levels)</span></i><span style=
=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Loop:<b=
r>
node-&gt;key is 5587<br>
node-&gt;key is </span><i><span style=3D"font-size:12.0pt;color:red">7381</=
span></i><span style=3D"font-size:12.0pt;color:black"><br>
node-&gt;key is 6474<br>
node-&gt;key is 7034<br>
node-&gt;key is 7228<br>
node-&gt;key is 7314<br>
node-&gt;key is 7339<br>
node-&gt;key is 7349<br>
node-&gt;key is 7372<br>
node-&gt;key is 7377<br>
node-&gt;key is 7378<br>
node-&gt;key is 7379<br>
node-&gt;key is 7379<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><br>
find the best node, key is </span><i><span style=3D"font-size:12.0pt;color:=
red">7381.
</span></i><i><span style=3D"font-size:12.0pt;color:black">(Loop 13 levels)=
</span></i><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<p><span style=3D"font-size:12.0pt;color:black">With this patch:<o:p></o:p>=
</span></p>
<p><span style=3D"font-size:12.0pt;color:black">we don't need to go down if=
 we found the right node that size equal to we needed.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><br>
Best Regards<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Rex <o:=
p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;color:black">
<hr size=3D"3" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Monk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;=
<br>
<b>Sent:</b> Thursday, November 22, 2018 8:33 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Liu, Monk<br>
<b>Subject:</b> [PATCH] drm: should break if already get the best size</spa=
n><span style=3D"font-size:12.0pt;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Signed-off-by: Monk Liu =
&lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/drm_mm.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c<br>
index 3cc5fbd..369fd9b 100644<br>
--- a/drivers/gpu/drm/drm_mm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/drm_mm.c<br>
@@ -318,6 &#43;318,8 @@ static struct drm_mm_node *best_hole(struct drm_mm =
*mm, u64 size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (size &lt;=3D node-&gt;hole_size) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; best =
=3D node;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rb =
=3D rb-&gt;rb_right;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size =3D=
=3D node-&gt;hole_size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rb =
=3D rb-&gt;rb_left;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1542954=
6487490.27167628664524557">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div id=3D"LPTitle_15429546487480.227571535890579">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
sans-serif;color:#0078D7"><a href=3D"https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decoration:none">am=
d-gfx
 Info Page - freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_15429=
546487490.8445715815323509">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_15429546487490.22150885879568194">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">To see the collection of prior postings to the list, visit the a=
md-gfx Archives.. Using amd-gfx: To post a message
 to all the list members, send email to <a href=3D"mailto:amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>. You can subscribe to the list, or change=
 your existing subscription, in the sections below.<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR1201MB0245E0A12D3CF9DCFA91A7D684D70CY4PR1201MB0245_--

--===============1506049070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1506049070==--
