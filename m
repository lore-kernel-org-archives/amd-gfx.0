From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce ring
Date: Fri, 14 Oct 2016 12:53:03 +0000
Message-ID: <CY4PR12MB1768CDAC43129C814D75DCE0F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1476449341-2673-1-git-send-email-ernstp@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1384887848=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476449341-2673-1-git-send-email-ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Ernst_Sj=F6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1384887848==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768CDAC43129C814D75DCE0F7DF0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768CDAC43129C814D75DCE0F7DF0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Does your tree have


2f3d686d0ee95332d8888169c7b6788bb2d9f5ad

780605db12c52f2c22d4d2cc05ceb7d2a9d55579


in it?  Those are fixes for when the third ring were added.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Ernst Sj=
=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, October 14, 2016 08:49
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Ernst Sj=F6strand
Subject: [PATCH] amdgpu: Fix failing boot after support for third vce ring

My Fiji class Fury fails to boot after commit
6f0359ff73076483902de0c17f9649bf55651e2a
"drm/amdgpu/vce3: add support for third vce ring"
This commits reverts the number of vce rings back to 2,
but leaves the other changes intact.

Signed-off-by: Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 3f899e3..6f5eb64 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -358,7 +358,7 @@ static int vce_v3_0_early_init(void *handle)
             (AMDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))
                 return -ENOENT;

-       adev->vce.num_rings =3D 3;
+       adev->vce.num_rings =3D 2;

         vce_v3_0_set_ring_funcs(adev);
         vce_v3_0_set_irq_funcs(adev);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB1768CDAC43129C814D75DCE0F7DF0CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Does your tree have&nbsp;</p>
<p><br>
</p>
<p><span>2f3d686d0ee95332d8888169c7b6788bb2d9f5ad</span><br>
</p>
<p><span><span>780605db12c52f2c22d4d2cc05ceb7d2a9d55579</span><br>
</span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>in it? &nbsp;Those are fixes for when the third ring were ad=
ded.</span></span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>Tom</span></span></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Ernst Sj=F6strand &lt;ernst=
p@gmail.com&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 08:49<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Ernst Sj=F6strand<br>
<b>Subject:</b> [PATCH] amdgpu: Fix failing boot after support for third vc=
e ring</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">My Fiji class Fury fails to boot after commit<br>
6f0359ff73076483902de0c17f9649bf55651e2a<br>
&quot;drm/amdgpu/vce3: add support for third vce ring&quot;<br>
This commits reverts the number of vce rings back to 2,<br>
but leaves the other changes intact.<br>
<br>
Signed-off-by: Ernst Sj=F6strand &lt;ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 3f899e3..6f5eb64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -358,7 &#43;358,7 @@ static int vce_v3_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (A=
MDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vce.num_rings =3D 3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vce.num_rings =3D 2;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_set_ring_funcs(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_set_irq_funcs(ade=
v);<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk959250" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14764495470470.9881266530783932" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14764495470450.11026149163994892" cellspacing=3D"0=
" style=3D"width: 90%; background-color: rgb(255, 255, 255); position: rela=
tive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: =
20px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted =
rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14764495470460.7288026297683508" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14764495470460.16427690046159027"></div=
>
<div id=3D"LPTitle_14764495470460.741636132433581" style=3D"top: 0px; color=
: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_s=
egoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quo=
t;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-hei=
ght: 21px;">
<a id=3D"LPUrlAnchor_14764495470460.2698087919077241" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14764495470460.18698958466014992" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14764495470460.6448197846508978" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768CDAC43129C814D75DCE0F7DF0CY4PR12MB1768namp_--

--===============1384887848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1384887848==--
