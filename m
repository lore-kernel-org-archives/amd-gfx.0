From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix a bogus warning
Date: Thu, 17 Aug 2017 21:03:32 +0000
Message-ID: <DM5PR12MB1257A35DEC0C4086F7D9D16EF2830@DM5PR12MB1257.namprd12.prod.outlook.com>
References: <1503002652-19818-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0969967303=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1503002652-19818-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0969967303==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1257A35DEC0C4086F7D9D16EF2830DM5PR12MB1257namp_"

--_000_DM5PR12MB1257A35DEC0C4086F7D9D16EF2830DM5PR12MB1257namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 17, 2017 4:44 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu: fix a bogus warning

Don't validate the default value.  Prevents a needless
warning. Also fix a spelling typo in the warning message.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2554ddf..1a459ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1077,8 +1077,9 @@ static void amdgpu_check_arguments(struct amdgpu_devi=
ce *adev)
         }

         /* valid range is between 4 and 9 inclusive */
-       if (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4) {
-               dev_warn(adev->dev, "valid rang is between 4 and 9\n");
+       if (amdgpu_vm_fragment_size !=3D -1 &&
+           (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4)) {
+               dev_warn(adev->dev, "valid range is between 4 and 9\n");
                 amdgpu_vm_fragment_size =3D -1;
         }

--
2.5.5

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_DM5PR12MB1257A35DEC0C4086F7D9D16EF2830DM5PR12MB1257namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Reviewed-by: Alex Xie &lt;<span class=3D"highlight" id=3D"0.433518398008=
889" name=3D"searchHitInReadingPane">AlexBin.Xie-5C7GfCeVMHo@public.gmane.org</span>&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri, sans-serif" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Thursday, August 17, 2017 4:44 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix a bogus warning</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Don't validate the default value.&nbsp; Prevents a=
 needless<br>
warning. Also fix a spelling typo in the warning message.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 &#43;&#43;&#43;--<br>
&nbsp;1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 2554ddf..1a459ac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1077,8 &#43;1077,9 @@ static void amdgpu_check_arguments(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* valid range is between =
4 and 9 inclusive */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_fragment_size &gt; 9 ||=
 amdgpu_vm_fragment_size &lt; 4) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;valid rang is between 4 and 9\n&quo=
t;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_fragment_size !=3D =
-1 &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_v=
m_fragment_size &gt; 9 || amdgpu_vm_fragment_size &lt; 4)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;valid range is between 4 and 9\=
n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vm_fragment_size =3D -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.5.5<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a id=3D"LPlnk419353" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15030037728530.5153393889696549" style=3D"width: 100=
%; text-indent: 0px; overflow: auto; margin-bottom: 20px;">
<table id=3D"LPContainer_15030037728430.2494249700643958" role=3D"presentat=
ion" style=3D"width: 90%; overflow: auto; padding-top: 20px; padding-bottom=
: 20px; margin-top: 20px; border-top-color: rgb(200, 200, 200); border-bott=
om-color: rgb(200, 200, 200); border-top-width: 1px; border-bottom-width: 1=
px; border-top-style: dotted; border-bottom-style: dotted; position: relati=
ve; background-color: rgb(255, 255, 255);" cellspacing=3D"0">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15030037728460.275720586653841" style=3D"padding: 0px; v=
ertical-align: top; display: table-cell; position: relative;" colspan=3D"2"=
>
<div id=3D"LPRemovePreviewContainer_15030037728460.2127731179166057"></div>
<div id=3D"LPTitle_15030037728460.6198405029115783" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); line-height: 21px; font-family: &quot;wf_segoe-ui_ligh=
t&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quot;Segoe U=
I&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 21px; font=
-weight: 400;">
<a id=3D"LPUrlAnchor_15030037728490.6208476016845332" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15030037728490.9838872304113444" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); line-height: 14px; font-family: &quo=
t;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma=
,Arial,sans-serif; font-size: 14px; font-weight: 400;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15030037728510.22017633024383798" style=3D"color: =
rgb(102, 102, 102); line-height: 20px; overflow: hidden; font-family: &quot=
;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif; font-size: 14px; font-weight: 400; display: block; max-he=
ight: 100px;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
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

--_000_DM5PR12MB1257A35DEC0C4086F7D9D16EF2830DM5PR12MB1257namp_--

--===============0969967303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0969967303==--
