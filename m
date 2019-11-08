From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: allow direct upload save restore list for
 raven2
Date: Fri, 8 Nov 2019 14:37:38 +0000
Message-ID: <DM5PR12MB1820D10E9175BBF6E25A931DF77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191108015432.11840-1-changfeng.zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0338956958=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191108015432.11840-1-changfeng.zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Changfeng" <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============0338956958==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_"

--_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

What about picasso and raven1?
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Cha=
ngfeng <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, November 7, 2019 8:54 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhang, H=
awking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: Zhu, Changfeng <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: allow direct upload save restore list for rave=
n2

From: changzhu <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>

It will cause modprobe atombios stuck problem in raven2 if it doesn't
allow direct upload save restore list from gfx driver.
So it needs to allow direct upload save restore list for raven2
temporarily.

Change-Id: I1fece1b9c61f7a13eec948f34eb60a9120046bc2
Signed-off-by: changzhu <Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 4ed31e9a398c..dde9713c1d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2729,7 +2729,9 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *ad=
ev)
          * And it's needed by gfxoff feature.
          */
         if (adev->gfx.rlc.is_rlc_v2_1) {
-               if (adev->asic_type =3D=3D CHIP_VEGA12)
+               if (adev->asic_type =3D=3D CHIP_VEGA12 ||
+                   (adev->asic_type =3D=3D CHIP_RAVEN &&
+                    adev->rev_id >=3D 8))
                         gfx_v9_1_init_rlc_save_restore_list(adev);
                 gfx_v9_0_enable_save_restore_machine(adev);
         }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
What about picasso and raven1?<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Changfeng &lt;Changfeng.=
Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 8:54 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huang=
@amd.com&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: allow direct upload save restore list f=
or raven2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: changzhu &lt;Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
It will cause modprobe atombios stuck problem in raven2 if it doesn't<br>
allow direct upload save restore list from gfx driver.<br>
So it needs to allow direct upload save restore list for raven2<br>
temporarily.<br>
<br>
Change-Id: I1fece1b9c61f7a13eec948f34eb60a9120046bc2<br>
Signed-off-by: changzhu &lt;Changfeng.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 &#43;&#43;&#43;-<br>
&nbsp;1 file changed, 3 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 4ed31e9a398c..dde9713c1d67 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2729,7 &#43;2729,9 @@ static void gfx_v9_0_init_pg(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * And it's needed by=
 gfxoff feature.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.is_rl=
c_v2_1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA12)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA12 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_RAVE=
N &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id &gt;=3D 8))<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
9_1_init_rlc_save_restore_list(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v9_0_enable_save_restore_machine(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820D10E9175BBF6E25A931DF77B0DM5PR12MB1820namp_--

--===============0338956958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0338956958==--
