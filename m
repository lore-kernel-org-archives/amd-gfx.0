From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: move getting pcie info to common code
Date: Sat, 10 Mar 2018 00:27:09 +0000
Message-ID: <CY4PR12MB1687743EE6D5199D46709157FBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180309202523.5269-1-alexander.deucher@amd.com>,
 <20180309202523.5269-5-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0732361294=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180309202523.5269-5-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

--===============0732361294==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687743EE6D5199D46709157FBDD0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687743EE6D5199D46709157FBDD0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org>

Best Regards
Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Saturday, March 10, 2018 4:25 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH 5/5] drm/amdgpu: move getting pcie info to common code

No need to replicate it in several places.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/cik.c           | 2 --
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 2 --
 drivers/gpu/drm/amd/amdgpu/vi.c            | 2 --
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 7d987dda478b..a243d8850768 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1082,8 +1082,6 @@ struct amdgpu_wb {
 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
 void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);

-void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
-
 /*
  * SDMA
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index db0670289a3d..97cb5e8c3306 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -87,6 +87,8 @@ static const char *amdgpu_asic_name[] =3D {
         "LAST",
 };

+static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
+
 bool amdgpu_device_is_px(struct drm_device *dev)
 {
         struct amdgpu_device *adev =3D dev->dev_private;
@@ -1880,6 +1882,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (adev->rio_mem =3D=3D NULL)
                 DRM_INFO("PCI I/O BAR is not found.\n");

+       amdgpu_device_get_pcie_info(adev);
+
         /* early init functions */
         r =3D amdgpu_device_ip_early_init(adev);
         if (r)
@@ -2757,7 +2761,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
         return r;
 }

-void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
+static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 {
         u32 mask;
         int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c
index f14dd1b073e9..71b35623b32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1887,8 +1887,6 @@ static int cik_common_early_init(void *handle)
                 return -EINVAL;
         }

-       amdgpu_device_get_pcie_info(adev);
-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index b2cf0bea41d2..28b0dbf85986 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -691,8 +691,6 @@ static int soc15_common_early_init(void *handle)
                 xgpu_ai_mailbox_set_irq_funcs(adev);
         }

-       amdgpu_device_get_pcie_info(adev);
-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c
index dec7de3be78a..e7cf752c3c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1097,8 +1097,6 @@ static int vi_common_early_init(void *handle)
                 xgpu_vi_mailbox_set_irq_funcs(adev);
         }

-       amdgpu_device_get_pcie_info(adev);
-
         return 0;
 }

--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB1687743EE6D5199D46709157FBDD0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><font face=3D"wf_segoe-ui_normal,=
Segoe UI,Segoe WP,Tahoma,Arial,sans-serif,serif,EmojiFont" size=3D"2" color=
=3D"#212121"><span style=3D"font-size: 14.67px;">Reviewed-by: Rex Zhu&lt;re=
zhu-5C7GfCeVMHo@public.gmane.org&gt;</span></font><br style=3D"font-family: Calibri, Helvetica, =
sans-serif; font-size: 16px;">
<br style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 16px;"=
>
<font face=3D"wf_segoe-ui_normal,Segoe UI,Segoe WP,Tahoma,Arial,sans-serif,=
serif,EmojiFont" size=3D"2" color=3D"#212121"><span style=3D"font-size: 14.=
67px;">Best Regards</span></font><br style=3D"font-family: Calibri, Helveti=
ca, sans-serif; font-size: 16px;">
<font face=3D"wf_segoe-ui_normal,Segoe UI,Segoe WP,Tahoma,Arial,sans-serif,=
serif,EmojiFont" size=3D"2" color=3D"#212121"><span style=3D"font-size: 14.=
67px;">Rex</span></font><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Saturday, March 10, 2018 4:25 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 5/5] drm/amdgpu: move getting pcie info to common co=
de</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">No need to replicate it in several places.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 &#43;&#43;&#43;&#43;&#=
43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 --<br>
&nbsp;5 files changed, 5 insertions(&#43;), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 7d987dda478b..a243d8850768 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1082,8 &#43;1082,6 @@ struct amdgpu_wb {<br>
&nbsp;int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);<br>
&nbsp;void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);<br>
&nbsp;<br>
-void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);<br>
-<br>
&nbsp;/*<br>
&nbsp; * SDMA<br>
&nbsp; */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index db0670289a3d..97cb5e8c3306 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -87,6 &#43;87,8 @@ static const char *amdgpu_asic_name[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LAST&quot;,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);<b=
r>
&#43;<br>
&nbsp;bool amdgpu_device_is_px(struct drm_device *dev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev-&gt;dev_private;<br>
@@ -1880,6 &#43;1882,8 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;rio_mem =3D=
=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;PCI I/O BAR is not found.\n&quot;);<br=
>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(adev)=
;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* early init functions */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_ear=
ly_init(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -2757,7 &#43;2761,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)<br>
&#43;static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c<br>
index f14dd1b073e9..71b35623b32d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cik.c<br>
@@ -1887,8 &#43;1887,6 @@ static int cik_common_early_init(void *handle)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(adev);<br=
>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index b2cf0bea41d2..28b0dbf85986 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -691,8 &#43;691,6 @@ static int soc15_common_early_init(void *handle)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xgpu_ai_mailbox_set_irq_funcs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(adev);<br=
>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c<br>
index dec7de3be78a..e7cf752c3c87 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -1097,8 &#43;1097,6 @@ static int vi_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xgpu_vi_mailbox_set_irq_funcs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(adev);<br=
>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk863893" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15206416219470.955329253052114" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15206416219400.5446731156916085" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15206416219420.7553303327322662" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15206416219420.06675227560661545"></div=
>
<div id=3D"LPTitle_15206416219430.0061818582597907845" style=3D"top: 0px; c=
olor: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: =
wf_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, =
&quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line=
-height: 21px;">
<a id=3D"LPUrlAnchor_15206416219440.3264214525317315" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15206416219440.40113735661384475" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15206416219460.7243346062609148" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
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
</div>
</body>
</html>

--_000_CY4PR12MB1687743EE6D5199D46709157FBDD0CY4PR12MB1687namp_--

--===============0732361294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0732361294==--
