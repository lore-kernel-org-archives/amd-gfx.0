From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: support BOOTUP_DEFAULT power profile
 mode
Date: Fri, 28 Dec 2018 03:12:48 +0000
Message-ID: <BN6PR12MB1809D5881E0667A20DD8807AF7B70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181227075038.22063-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956238503=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181227075038.22063-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1956238503==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D5881E0667A20DD8807AF7B70BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D5881E0667A20DD8807AF7B70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, December 27, 2018 2:50:38 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH] drm/amd/powerplay: support BOOTUP_DEFAULT power profile mo=
de

This can avoid unexpected profile mode change after running
compute workload.

Change-Id: I138e8747e4f588a6fb38b9c68f765bb653556dc0
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 13 +++++-----
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   | 24 ++++++++++---------
 .../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c  |  8 ++++---
 .../drm/amd/powerplay/hwmgr/vega10_hwmgr.c    | 12 ++++++----
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 10 +++++---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  2 +-
 6 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 1479ea1dc3e7..789c4f288485 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -127,12 +127,13 @@ enum amd_pp_task {
 };

 enum PP_SMC_POWER_PROFILE {
-       PP_SMC_POWER_PROFILE_FULLSCREEN3D =3D 0x0,
-       PP_SMC_POWER_PROFILE_POWERSAVING  =3D 0x1,
-       PP_SMC_POWER_PROFILE_VIDEO        =3D 0x2,
-       PP_SMC_POWER_PROFILE_VR           =3D 0x3,
-       PP_SMC_POWER_PROFILE_COMPUTE      =3D 0x4,
-       PP_SMC_POWER_PROFILE_CUSTOM       =3D 0x5,
+       PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT =3D 0x0,
+       PP_SMC_POWER_PROFILE_FULLSCREEN3D =3D 0x1,
+       PP_SMC_POWER_PROFILE_POWERSAVING  =3D 0x2,
+       PP_SMC_POWER_PROFILE_VIDEO        =3D 0x3,
+       PP_SMC_POWER_PROFILE_VR           =3D 0x4,
+       PP_SMC_POWER_PROFILE_COMPUTE      =3D 0x5,
+       PP_SMC_POWER_PROFILE_CUSTOM       =3D 0x6,
 };

 enum {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index 0173d0480024..310b102a9292 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -64,17 +64,19 @@ static int ci_set_asic_special_caps(struct pp_hwmgr *hw=
mgr);

 static void hwmgr_init_workload_prority(struct pp_hwmgr *hwmgr)
 {
-       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 2;
-       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 0;
-       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] =3D 1;
-       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 3;
-       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 4;
-
-       hwmgr->workload_setting[0] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
-       hwmgr->workload_setting[1] =3D PP_SMC_POWER_PROFILE_VIDEO;
-       hwmgr->workload_setting[2] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-       hwmgr->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VR;
-       hwmgr->workload_setting[4] =3D PP_SMC_POWER_PROFILE_COMPUTE;
+       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0;
+       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
+       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
+       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
+       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 4;
+       hwmgr->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
+
+       hwmgr->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+       hwmgr->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+       hwmgr->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
+       hwmgr->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
+       hwmgr->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
+       hwmgr->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
 }

 int hwmgr_early_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index d91390459326..c8f5c00dd1e7 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -77,8 +77,9 @@
 #define PCIE_BUS_CLK                10000
 #define TCLK                        (PCIE_BUS_CLK / 10)

-static const struct profile_mode_setting smu7_profiling[6] =3D
-                                       {{1, 0, 100, 30, 1, 0, 100, 10},
+static const struct profile_mode_setting smu7_profiling[7] =3D
+                                       {{0, 0, 0, 0, 0, 0, 0, 0},
+                                        {1, 0, 100, 30, 1, 0, 100, 10},
                                          {1, 10, 0, 30, 0, 0, 0, 0},
                                          {0, 0, 0, 0, 1, 10, 16, 31},
                                          {1, 0, 11, 50, 1, 0, 100, 10},
@@ -4889,7 +4890,8 @@ static int smu7_get_power_profile_mode(struct pp_hwmg=
r *hwmgr, char *buf)
         uint32_t i, size =3D 0;
         uint32_t len;

-       static const char *profile_name[6] =3D {"3D_FULL_SCREEN",
+       static const char *profile_name[7] =3D {"BOOTUP_DEFAULT",
+                                       "3D_FULL_SCREEN",
                                         "POWER_SAVING",
                                         "VIDEO",
                                         "VR",
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 79c86247d0ac..91e3bbe6d61d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -804,9 +804,9 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)

         hwmgr->backend =3D data;

-       hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_VIDEO];
-       hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;
-       hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;
+       hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_BOOTUP_DEFAULT];
+       hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+       hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;

         vega10_set_default_registry_data(hwmgr);
         data->disable_dpm_mask =3D 0xff;
@@ -4668,13 +4668,15 @@ static int vega10_get_power_profile_mode(struct pp_=
hwmgr *hwmgr, char *buf)
 {
         struct vega10_hwmgr *data =3D hwmgr->backend;
         uint32_t i, size =3D 0;
-       static const uint8_t profile_mode_setting[5][4] =3D {{70, 60, 1, 3,=
},
+       static const uint8_t profile_mode_setting[6][4] =3D {{70, 60, 0, 0,=
},
+                                               {70, 60, 1, 3,},
                                                 {90, 60, 0, 0,},
                                                 {70, 60, 0, 0,},
                                                 {70, 90, 0, 0,},
                                                 {30, 60, 0, 6,},
                                                 };
-       static const char *profile_name[6] =3D {"3D_FULL_SCREEN",
+       static const char *profile_name[7] =3D {"BOOTUP_DEFAULT",
+                                       "3D_FULL_SCREEN",
                                         "POWER_SAVING",
                                         "VIDEO",
                                         "VR",
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 26154f9b2178..264ce8fe545f 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -390,9 +390,9 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)

         hwmgr->backend =3D data;

-       hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_VIDEO];
-       hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;
-       hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;
+       hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_BOOTUP_DEFAULT];
+       hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+       hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;

         vega20_set_default_registry_data(hwmgr);

@@ -3261,6 +3261,9 @@ static int conv_power_profile_to_pplib_workload(int p=
ower_profile)
         int pplib_workload =3D 0;

         switch (power_profile) {
+       case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT:
+               pplib_workload =3D WORKLOAD_DEFAULT_BIT;
+               break;
         case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
                 pplib_workload =3D WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
                 break;
@@ -3290,6 +3293,7 @@ static int vega20_get_power_profile_mode(struct pp_hw=
mgr *hwmgr, char *buf)
         uint32_t i, size =3D 0;
         uint16_t workload_type =3D 0;
         static const char *profile_name[] =3D {
+                                       "BOOTUP_DEFAULT",
                                         "3D_FULL_SCREEN",
                                         "POWER_SAVING",
                                         "VIDEO",
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 0d298a0409f5..8cb831b6a016 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -705,7 +705,7 @@ enum PP_TABLE_VERSION {
 /**
  * The main hardware manager structure.
  */
-#define Workload_Policy_Max 5
+#define Workload_Policy_Max 6

 struct pp_hwmgr {
         void *adev;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809D5881E0667A20DD8807AF7B70BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, December 27, 2018 2:50:38 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: support BOOTUP_DEFAULT power pro=
file mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This can avoid unexpected profile mode change afte=
r running<br>
compute workload.<br>
<br>
Change-Id: I138e8747e4f588a6fb38b9c68f765bb653556dc0<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; | 13 &#4=
3;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp; | 24 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp; |&nbsp; 8 &#43;&#4=
3;&#43;&#43;---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega10_hwmgr.c&nbsp;&nbsp;&nbsp; | 12 &#4=
3;&#43;&#43;&#43;&#43;&#43;----<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 10 &#4=
3;&#43;&#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;-<br>
&nbsp;6 files changed, 40 insertions(&#43;), 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 1479ea1dc3e7..789c4f288485 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -127,12 &#43;127,13 @@ enum amd_pp_task {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum PP_SMC_POWER_PROFILE {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_FULLSCREEN3D =3D=
 0x0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_POWERSAVING&nbsp=
; =3D 0x1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_VIDEO&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_VR&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x3,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_COMPUTE&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 0x4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_CUSTOM&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x5,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_BOOTUP_DEFAU=
LT =3D 0x0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_FULLSCREEN3D=
 =3D 0x1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_POWERSAVING&=
nbsp; =3D 0x2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_VIDEO&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_VR&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x4,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_COMPUTE&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x5,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_CUSTOM&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x6,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum {<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index 0173d0480024..310b102a9292 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -64,17 &#43;64,19 @@ static int ci_set_asic_special_caps(struct pp_hwmgr=
 *hwmgr);<br>
&nbsp;<br>
&nbsp;static void hwmgr_init_workload_prority(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC_POW=
ER_PROFILE_FULLSCREEN3D] =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC_POW=
ER_PROFILE_POWERSAVING] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC_POW=
ER_PROFILE_VIDEO] =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC_POW=
ER_PROFILE_VR] =3D 3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC_POW=
ER_PROFILE_COMPUTE] =3D 4;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[0] =3D PP_=
SMC_POWER_PROFILE_POWERSAVING;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[1] =3D PP_=
SMC_POWER_PROFILE_VIDEO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[2] =3D PP_=
SMC_POWER_PROFILE_FULLSCREEN3D;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[3] =3D PP_=
SMC_POWER_PROFILE_VR;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[4] =3D PP_=
SMC_POWER_PROFILE_COMPUTE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC=
_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC=
_POWER_PROFILE_FULLSCREEN3D] =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC=
_POWER_PROFILE_POWERSAVING] =3D 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC=
_POWER_PROFILE_VIDEO] =3D 3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC=
_POWER_PROFILE_VR] =3D 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority[PP_SMC=
_POWER_PROFILE_COMPUTE] =3D 5;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[0] =3D=
 PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[1] =3D=
 PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[2] =3D=
 PP_SMC_POWER_PROFILE_POWERSAVING;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[3] =3D=
 PP_SMC_POWER_PROFILE_VIDEO;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[4] =3D=
 PP_SMC_POWER_PROFILE_VR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[5] =3D=
 PP_SMC_POWER_PROFILE_COMPUTE;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int hwmgr_early_init(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index d91390459326..c8f5c00dd1e7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -77,8 &#43;77,9 @@<br>
&nbsp;#define PCIE_BUS_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000<br>
&nbsp;#define TCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (PCIE_BUS_CLK / 10)<br>
&nbsp;<br>
-static const struct profile_mode_setting smu7_profiling[6] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; {{1, 0, 100, 30, 1, 0, 100, 10},<br>
&#43;static const struct profile_mode_setting smu7_profiling[7] =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; {{0, 0, 0, 0, 0, 0, 0, 0},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; {1, 0, 100, 30, 1, 0, 100, 10},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {1, 10, 0, 30, 0, 0, 0, 0},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {0, 0, 0, 0, 1, 10, 16, 31},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {1, 0, 11, 50, 1, 0, 100, 10},<br>
@@ -4889,7 &#43;4890,8 @@ static int smu7_get_power_profile_mode(struct pp_=
hwmgr *hwmgr, char *buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, size =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t len;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *profile_name[6] =
=3D {&quot;3D_FULL_SCREEN&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *profile_name[7=
] =3D {&quot;BOOTUP_DEFAULT&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;3D_FULL_SCREEN&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;POWER_SAVING&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;VIDEO&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;VR&quot;,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 79c86247d0ac..91e3bbe6d61d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -804,9 &#43;804,9 @@ static int vega10_hwmgr_backend_init(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;backend =3D data=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt;&lt=
; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_VIDEO];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D PP_S=
MC_POWER_PROFILE_VIDEO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_profile_mode =
=3D PP_SMC_POWER_PROFILE_VIDEO;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt=
;&lt; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D =
PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_profile_m=
ode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_set_default_registr=
y_data(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;disable_dpm_mask =
=3D 0xff;<br>
@@ -4668,13 &#43;4668,15 @@ static int vega10_get_power_profile_mode(struct=
 pp_hwmgr *hwmgr, char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, size =3D 0;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const uint8_t profile_mode_set=
ting[5][4] =3D {{70, 60, 1, 3,},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const uint8_t profile_mode=
_setting[6][4] =3D {{70, 60, 0, 0,},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {70, 60, 1, 3,},<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {90, 60, 0,=
 0,},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {70, 60, 0,=
 0,},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {70, 90, 0,=
 0,},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {30, 60, 0,=
 6,},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *profile_name[6] =
=3D {&quot;3D_FULL_SCREEN&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *profile_name[7=
] =3D {&quot;BOOTUP_DEFAULT&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;3D_FULL_SCREEN&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;POWER_SAVING&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;VIDEO&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;VR&quot;,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 26154f9b2178..264ce8fe545f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -390,9 &#43;390,9 @@ static int vega20_hwmgr_backend_init(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;backend =3D data=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt;&lt=
; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_VIDEO];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D PP_S=
MC_POWER_PROFILE_VIDEO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_profile_mode =
=3D PP_SMC_POWER_PROFILE_VIDEO;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt=
;&lt; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D =
PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_profile_m=
ode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_default_registr=
y_data(hwmgr);<br>
&nbsp;<br>
@@ -3261,6 &#43;3261,9 @@ static int conv_power_profile_to_pplib_workload(i=
nt power_profile)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pplib_workload =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (power_profile) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_BOOTUP_=
DEFAULT:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_DEFAULT_BIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_=
FULLSCREEN3D:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -3290,6 &#43;3293,7 @@ static int vega20_get_power_profile_mode(struct p=
p_hwmgr *hwmgr, char *buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, size =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t workload_type =3D=
 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *profile=
_name[] =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;BOOTUP_DEFAULT&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;3D_FULL_SCREEN&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;POWER_SAVING&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;VIDEO&quot;,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 0d298a0409f5..8cb831b6a016 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -705,7 &#43;705,7 @@ enum PP_TABLE_VERSION {<br>
&nbsp;/**<br>
&nbsp; * The main hardware manager structure.<br>
&nbsp; */<br>
-#define Workload_Policy_Max 5<br>
&#43;#define Workload_Policy_Max 6<br>
&nbsp;<br>
&nbsp;struct pp_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *adev;<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809D5881E0667A20DD8807AF7B70BN6PR12MB1809namp_--

--===============1956238503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1956238503==--
