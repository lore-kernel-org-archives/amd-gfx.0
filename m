From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: should break if already get the best size
Date: Fri, 23 Nov 2018 19:34:21 +0000
Message-ID: <BN6PR12MB18098F780A02FF1CEAE32D07F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542889986-13261-1-git-send-email-Monk.Liu@amd.com>,
 <BN7PR12MB2770EAF767A7AFC6CE0A6ADCFBD40@BN7PR12MB2770.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1425819476=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN7PR12MB2770EAF767A7AFC6CE0A6ADCFBD40-Zx/IyJUqfGIGZxRL2V81NwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1425819476==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18098F780A02FF1CEAE32D07F7D40BN6PR12MB1809namp_"

--_000_BN6PR12MB18098F780A02FF1CEAE32D07F7D40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please add a proper patch description.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 23, 2018 4:44:31 AM
To: Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm: should break if already get the best size


Tested-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


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
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Monk Liu=
 <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, November 22, 2018 8:33 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Monk
Subject: [PATCH] drm: should break if already get the best size

Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BN6PR12MB18098F780A02FF1CEAE32D07F7D40BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Please add a proper patch descrip=
tion.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
<b>Sent:</b> Friday, November 23, 2018 4:44:31 AM<br>
<b>To:</b> Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm: should break if already get the best size<=
/font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quo=
t;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,=
&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p style=3D"margin-top:0; margin-bottom:0">Tested-by: <span>Rex Zhu &lt;Rex=
.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span>Without this patch, if we =
search&nbsp;node via rb tree.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span>For example: we insert 999=
9 different node with rand size, size range in (1-9999).</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span><span>the key in root node=
 is 5587</span>.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span>if we try to find the node=
 with key equal to 5587 or
<span id=3D"x_ms-rterangepaste-start"></span><span>7381</span><span id=3D"x=
_ms-rterangepaste-end"></span>,</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span></span><span></span></p>
<div>
<div>Loop:<br>
node-&gt;key is <span style=3D"color:rgb(255,0,0)">5587</span><br>
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
node-&gt;key is 5586</div>
</div>
<br>
<p></p>
<p style=3D"margin-top:0; margin-bottom:0"><span></span></p>
<div>Find the best node, key is <span style=3D"color:rgb(255,0,0)">5587 <sp=
an style=3D"color:rgb(255,0,0)">
<i><span style=3D"color:rgb(0,0,0)">(Loop 14 levels)</span></i></span></spa=
n></div>
<br>
<p></p>
<div>Loop:<br>
node-&gt;key is 5587<br>
node-&gt;key is <i><span style=3D"color:rgb(255,0,0)">7381</span></i><br>
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
node-&gt;key is 7379</div>
<div><br>
find the best node, key is <span style=3D"color:rgb(255,0,0)"><i>7381. <spa=
n style=3D"color:rgb(0,0,0)">
(Loop 13 levels)</span></i></span></div>
<div><br>
</div>
<div><br>
</div>
<div></div>
<p></p>
<p style=3D"margin-top:0; margin-bottom:0"><span>With this patch:</span></p=
>
<p style=3D"margin-top:0; margin-bottom:0"><span>we don't need to go down i=
f we found the right node that size equal to we needed.
<br>
</span></p>
<span style=3D"color:rgb(255,0,0)"></span><br>
<div>
<div><br>
</div>
<br>
Best Regards</div>
<div>Rex </div>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Monk Liu &lt;Monk.Liu@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, November 22, 2018 8:33 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Liu, Monk<br>
<b>Subject:</b> [PATCH] drm: should break if already get the best size</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Signed-off-by: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk760696" class=3D"x_OWAAutoLink">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15429546487490.27167628664524557" style=3D"margin-bo=
ttom:20px; overflow:auto; width:100%; text-indent:0px">
<table id=3D"LPContainer_15429546487480.43424038956412636" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width:90%; background-color:rgb(255,255,25=
5); overflow:auto; padding-top:20px; padding-bottom:20px; margin-top:20px; =
border-top:1px dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,20=
0,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"x_TextCell_15429546487480.3675019534019166" colspan=3D"2" style=
=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPRemovePreviewContainer_15429546487480.5161007281621218"></div>
<div id=3D"LPTitle_15429546487480.227571535890579" style=3D"top:0px; color:=
rgb(0,120,215); font-weight:400; font-size:21px; font-family:&quot;wf_segoe=
-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-height:2=
1px">
<a id=3D"LPUrlAnchor_15429546487490.48298712321952375" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration:none">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15429546487490.8445715815323509" style=3D"margin:10px=
 0px 16px; color:rgb(102,102,102); font-weight:400; font-family:&quot;wf_se=
goe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,=
sans-serif; font-size:14px; line-height:14px">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15429546487490.22150885879568194" style=3D"display=
:block; color:rgb(102,102,102); font-weight:400; font-family:&quot;wf_segoe=
-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,san=
s-serif; font-size:14px; line-height:20px; max-height:100px; overflow:hidde=
n">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18098F780A02FF1CEAE32D07F7D40BN6PR12MB1809namp_--

--===============1425819476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1425819476==--
