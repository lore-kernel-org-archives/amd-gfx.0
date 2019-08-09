From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu/powerplay: update Arcturus smu version in
 new place
Date: Fri, 9 Aug 2019 11:29:03 +0000
Message-ID: <MN2PR12MB32969CB86F6926508B5B8FBDA2D60@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1565350043-7146-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0164662370=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565350043-7146-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
To: "Ma, Le" <Le.Ma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0164662370==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32969CB86F6926508B5B8FBDA2D60MN2PR12MB3296namp_"

--_000_MN2PR12MB32969CB86F6926508B5B8FBDA2D60MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Le Ma <l=
e.ma-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 9, 2019 7:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/amdgpu/powerplay: update Arcturus smu version in n=
ew place

Follow patch below:
    drm/amd/powerplay: re-define smu interface version for smu v11

Change-Id: Id78651209adc7a094f4c19ba965dcded37dd3ba7
Signed-off-by: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c                 | 1 -
 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h | 2 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h                | 1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c                    | 3 +++
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index cff3777..e6fcbdf 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1918,6 +1918,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
         struct smu_table_context *smu_table =3D &smu->smu_table;

         smu->ppt_funcs =3D &arcturus_ppt_funcs;
-       smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION;
         smu_table->table_count =3D TABLE_COUNT;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index c7a7953..b99e98c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x08
+//#define SMU11_DRIVER_IF_VERSION 0x08

 #define PPTABLE_ARCTURUS_SMU_VERSION 4

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index ee8542d..acbb83d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,6 +27,7 @@

 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x08
 #define SMU11_DRIVER_IF_VERSION_NV10 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x34

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 91dfae1..3b8e58e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -275,6 +275,9 @@ static int smu_v11_0_check_fw_version(struct smu_contex=
t *smu)
         case CHIP_VEGA20:
                 smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_VG20;
                 break;
+       case CHIP_ARCTURUS:
+               smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_ARCT;
+               break;
         case CHIP_NAVI10:
                 smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_NV10;
                 break;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB32969CB86F6926508B5B8FBDA2D60MN2PR12MB3296namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Le Ma &lt;le.ma-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<b>Sent:</b> Friday, August 9, 2019 7:27 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu/powerplay: update Arcturus smu versi=
on in new place</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Follow patch below:<br>
&nbsp;&nbsp;&nbsp; drm/amd/powerplay: re-define smu interface version for s=
mu v11<br>
<br>
Change-Id: Id78651209adc7a094f4c19ba965dcded37dd3ba7<br>
Signed-off-by: Le Ma &lt;le.ma-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1=
 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h | 2 &#43=
;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 &#43=
;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&nbsp;4 files changed, 5 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index cff3777..e6fcbdf 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -1918,6 &#43;1918,5 @@ void arcturus_set_ppt_funcs(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp=
;arcturus_ppt_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIV=
ER_IF_VERSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_count =
=3D TABLE_COUNT;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h<br>
index c7a7953..b99e98c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturu=
s.h<br>
@@ -27,7 &#43;27,7 @@<br>
&nbsp;// *** IMPORTANT ***<br>
&nbsp;// SMU TEAM: Always increment the interface version if<br>
&nbsp;// any structure is changed in this file<br>
-#define SMU11_DRIVER_IF_VERSION 0x08<br>
&#43;//#define SMU11_DRIVER_IF_VERSION 0x08<br>
&nbsp;<br>
&nbsp;#define PPTABLE_ARCTURUS_SMU_VERSION 4<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index ee8542d..acbb83d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -27,6 &#43;27,7 @@<br>
&nbsp;<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_VG20 0x13<br>
&#43;#define SMU11_DRIVER_IF_VERSION_ARCT 0x08<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV10 0x33<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV14 0x34<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 91dfae1..3b8e58e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -275,6 &#43;275,9 @@ static int smu_v11_0_check_fw_version(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_VG=
20;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_ARCT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_NV=
10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB32969CB86F6926508B5B8FBDA2D60MN2PR12MB3296namp_--

--===============0164662370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0164662370==--
