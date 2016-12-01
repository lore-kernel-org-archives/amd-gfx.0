From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: refine pg code for gfx_v8.
Date: Thu, 1 Dec 2016 13:24:23 +0000
Message-ID: <BN6PR12MB176436BACAD823BEA856AE02F78F0@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <1480580677-32303-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1991516436=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1480580677-32303-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1991516436==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB176436BACAD823BEA856AE02F78F0BN6PR12MB1764namp_"

--_000_BN6PR12MB176436BACAD823BEA856AE02F78F0BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Rex,


Given how often we diagnose problems by disabling PG/CG I'd have to offer m=
y NAK to this patch since it prevents me from disabling PG via the command =
line.


Any reason you want to make it permanently enabled?


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, December 1, 2016 03:24
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amdgpu: refine pg code for gfx_v8.

1. bit CP_PG_DISABLE was reversed.
2. load RLC_SRM_INDEX_CNTL_ADDR/DATA_x pairs
   with valid addr/data.
3. always init gfx pg.
4. delete repeated check for pg mask.

Change-Id: I9fcc8d1f79f5fa1803cb2625aa292188a656ae6b
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 85 +++++++++++++++----------------=
----
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index c02ae07..fee8c2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3948,8 +3948,10 @@ static int gfx_v8_0_init_save_restore_list(struct am=
dgpu_device *adev)
         temp =3D mmRLC_SRM_INDEX_CNTL_ADDR_0;
         data =3D mmRLC_SRM_INDEX_CNTL_DATA_0;
         for (i =3D 0; i < sizeof(unique_indices) / sizeof(int); i++) {
-               amdgpu_mm_wreg(adev, temp + i, unique_indices[i] & 0x3FFFF,=
 false);
-               amdgpu_mm_wreg(adev, data + i, unique_indices[i] >> 20, fal=
se);
+               if (unique_indices[i] !=3D 0) {
+                       amdgpu_mm_wreg(adev, temp + i, unique_indices[i] & =
0x3FFFF, false);
+                       amdgpu_mm_wreg(adev, data + i, unique_indices[i] >>=
 20, false);
+               }
         }
         kfree(register_list_format);

@@ -3965,20 +3967,16 @@ static void gfx_v8_0_init_power_gating(struct amdgp=
u_device *adev)
 {
         uint32_t data;

-       if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
-                             AMD_PG_SUPPORT_GFX_SMG |
-                             AMD_PG_SUPPORT_GFX_DMG)) {
-               WREG32_FIELD(CP_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x60);
+       WREG32_FIELD(CP_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x60);

-               data =3D REG_SET_FIELD(0, RLC_PG_DELAY, POWER_UP_DELAY, 0x1=
0);
-               data =3D REG_SET_FIELD(data, RLC_PG_DELAY, POWER_DOWN_DELAY=
, 0x10);
-               data =3D REG_SET_FIELD(data, RLC_PG_DELAY, CMD_PROPAGATE_DE=
LAY, 0x10);
-               data =3D REG_SET_FIELD(data, RLC_PG_DELAY, MEM_SLEEP_DELAY,=
 0x10);
-               WREG32(mmRLC_PG_DELAY, data);
+       data =3D REG_SET_FIELD(0, RLC_PG_DELAY, POWER_UP_DELAY, 0x10);
+       data =3D REG_SET_FIELD(data, RLC_PG_DELAY, POWER_DOWN_DELAY, 0x10);
+       data =3D REG_SET_FIELD(data, RLC_PG_DELAY, CMD_PROPAGATE_DELAY, 0x1=
0);
+       data =3D REG_SET_FIELD(data, RLC_PG_DELAY, MEM_SLEEP_DELAY, 0x10);
+       WREG32(mmRLC_PG_DELAY, data);

-               WREG32_FIELD(RLC_PG_DELAY_2, SERDES_CMD_DELAY, 0x3);
-               WREG32_FIELD(RLC_AUTO_PG_CTRL, GRBM_REG_SAVE_GFX_IDLE_THRES=
HOLD, 0x55f0);
-       }
+       WREG32_FIELD(RLC_PG_DELAY_2, SERDES_CMD_DELAY, 0x3);
+       WREG32_FIELD(RLC_AUTO_PG_CTRL, GRBM_REG_SAVE_GFX_IDLE_THRESHOLD, 0x=
55f0);
 }

 static void cz_enable_sck_slow_down_on_power_up(struct amdgpu_device *adev=
,
@@ -3995,41 +3993,35 @@ static void cz_enable_sck_slow_down_on_power_down(s=
truct amdgpu_device *adev,

 static void cz_enable_cp_power_gating(struct amdgpu_device *adev, bool ena=
ble)
 {
-       WREG32_FIELD(RLC_PG_CNTL, CP_PG_DISABLE, enable ? 1 : 0);
+       WREG32_FIELD(RLC_PG_CNTL, CP_PG_DISABLE, enable ? 0 : 1);
 }

 static void gfx_v8_0_init_pg(struct amdgpu_device *adev)
 {
-       if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
-                             AMD_PG_SUPPORT_GFX_SMG |
-                             AMD_PG_SUPPORT_GFX_DMG |
-                             AMD_PG_SUPPORT_CP |
-                             AMD_PG_SUPPORT_GDS |
-                             AMD_PG_SUPPORT_RLC_SMU_HS)) {
-               gfx_v8_0_init_csb(adev);
-               gfx_v8_0_init_save_restore_list(adev);
-               gfx_v8_0_enable_save_restore_machine(adev);
-
-               if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
-                   (adev->asic_type =3D=3D CHIP_STONEY)) {
-                       WREG32(mmRLC_JUMP_TABLE_RESTORE, adev->gfx.rlc.cp_t=
able_gpu_addr >> 8);
-                       gfx_v8_0_init_power_gating(adev);
-                       WREG32(mmRLC_PG_ALWAYS_ON_CU_MASK, adev->gfx.cu_inf=
o.ao_cu_mask);
-                       if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
-                               cz_enable_sck_slow_down_on_power_up(adev, t=
rue);
-                               cz_enable_sck_slow_down_on_power_down(adev,=
 true);
-                       } else {
-                               cz_enable_sck_slow_down_on_power_up(adev, f=
alse);
-                               cz_enable_sck_slow_down_on_power_down(adev,=
 false);
-                       }
-                       if (adev->pg_flags & AMD_PG_SUPPORT_CP)
-                               cz_enable_cp_power_gating(adev, true);
-                       else
-                               cz_enable_cp_power_gating(adev, false);
-               } else if (adev->asic_type =3D=3D CHIP_POLARIS11) {
-                       gfx_v8_0_init_power_gating(adev);
+       gfx_v8_0_init_csb(adev);
+       gfx_v8_0_init_save_restore_list(adev);
+       gfx_v8_0_enable_save_restore_machine(adev);
+
+       if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
+           (adev->asic_type =3D=3D CHIP_STONEY)) {
+               WREG32(mmRLC_JUMP_TABLE_RESTORE, adev->gfx.rlc.cp_table_gpu=
_addr >> 8);
+               gfx_v8_0_init_power_gating(adev);
+               WREG32(mmRLC_PG_ALWAYS_ON_CU_MASK, adev->gfx.cu_info.ao_cu_=
mask);
+               if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
+                       cz_enable_sck_slow_down_on_power_up(adev, true);
+                       cz_enable_sck_slow_down_on_power_down(adev, true);
+               } else {
+                       cz_enable_sck_slow_down_on_power_up(adev, false);
+                       cz_enable_sck_slow_down_on_power_down(adev, false);
                 }
+               if (adev->pg_flags & AMD_PG_SUPPORT_CP)
+                       cz_enable_cp_power_gating(adev, true);
+               else
+                       cz_enable_cp_power_gating(adev, false);
+       } else if (adev->asic_type =3D=3D CHIP_POLARIS11) {
+               gfx_v8_0_init_power_gating(adev);
         }
+
 }

 static void gfx_v8_0_rlc_stop(struct amdgpu_device *adev)
@@ -5570,14 +5562,11 @@ static int gfx_v8_0_set_powergating_state(void *han=
dle,
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         bool enable =3D (state =3D=3D AMD_PG_STATE_GATE) ? true : false;

-       if (!(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
-               return 0;
-
         switch (adev->asic_type) {
         case CHIP_CARRIZO:
         case CHIP_STONEY:
-               if (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)
-                       cz_update_gfx_cg_power_gating(adev, enable);
+
+               cz_update_gfx_cg_power_gating(adev, enable);

                 if ((adev->pg_flags & AMD_PG_SUPPORT_GFX_SMG) && enable)
                         gfx_v8_0_enable_gfx_static_mg_power_gating(adev, t=
rue);
--
1.9.1

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




--_000_BN6PR12MB176436BACAD823BEA856AE02F78F0BN6PR12MB1764namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Rex,</p>
<p><br>
</p>
<p>Given how often we diagnose problems by disabling PG/CG I'd have to offe=
r my NAK to this patch since it prevents me from disabling PG via the comma=
nd line.</p>
<p><br>
</p>
<p>Any reason you want to make it permanently enabled?</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Thursday, December 1, 2016 03:24<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amdgpu: refine pg code for gfx_v8.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">1. bit CP_PG_DISABLE was reversed.<br>
2. load RLC_SRM_INDEX_CNTL_ADDR/DATA_x pairs<br>
&nbsp;&nbsp; with valid addr/data.<br>
3. always init gfx pg.<br>
4. delete repeated check for pg mask.<br>
<br>
Change-Id: I9fcc8d1f79f5fa1803cb2625aa292188a656ae6b<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 85 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------------------<br>
&nbsp;1 file changed, 37 insertions(&#43;), 48 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index c02ae07..fee8c2a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -3948,8 &#43;3948,10 @@ static int gfx_v8_0_init_save_restore_list(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D mmRLC_SRM_INDEX_C=
NTL_ADDR_0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D mmRLC_SRM_INDEX_C=
NTL_DATA_0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; sizeo=
f(unique_indices) / sizeof(int); i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mm_wreg(adev, temp &#43; i, unique_indices[i] &amp; 0x3FF=
FF, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mm_wreg(adev, data &#43; i, unique_indices[i] &gt;&gt; 20=
, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (unique_indices[i] !=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wr=
eg(adev, temp &#43; i, unique_indices[i] &amp; 0x3FFFF, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wr=
eg(adev, data &#43; i, unique_indices[i] &gt;&gt; 20, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(register_list_format=
);<br>
&nbsp;<br>
@@ -3965,20 &#43;3967,16 @@ static void gfx_v8_0_init_power_gating(struct a=
mdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; (AMD_PG_S=
UPPORT_GFX_PG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_SMG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_DMG)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_FIELD(CP_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x60);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(CP_RB_WPTR_POLL_CNTL=
, IDLE_POLL_COUNT, 0x60);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(0, RLC_PG_DELAY, POWER_UP_DELAY, 0x10);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, RLC_PG_DELAY, POWER_DOWN_DELAY, 0x1=
0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, RLC_PG_DELAY, CMD_PROPAGATE_DELAY, =
0x10);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, RLC_PG_DELAY, MEM_SLEEP_DELAY, 0x10=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(mmRLC_PG_DELAY, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(0, RLC_PG_=
DELAY, POWER_UP_DELAY, 0x10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, RLC_=
PG_DELAY, POWER_DOWN_DELAY, 0x10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, RLC_=
PG_DELAY, CMD_PROPAGATE_DELAY, 0x10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, RLC_=
PG_DELAY, MEM_SLEEP_DELAY, 0x10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_PG_DELAY, data);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_FIELD(RLC_PG_DELAY_2, SERDES_CMD_DELAY, 0x3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_FIELD(RLC_AUTO_PG_CTRL, GRBM_REG_SAVE_GFX_IDLE_THRESHOLD,=
 0x55f0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_DELAY_2, SERD=
ES_CMD_DELAY, 0x3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_AUTO_PG_CTRL, GR=
BM_REG_SAVE_GFX_IDLE_THRESHOLD, 0x55f0);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void cz_enable_sck_slow_down_on_power_up(struct amdgpu_device =
*adev,<br>
@@ -3995,41 &#43;3993,35 @@ static void cz_enable_sck_slow_down_on_power_do=
wn(struct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;static void cz_enable_cp_power_gating(struct amdgpu_device *adev, boo=
l enable)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, CP_PG_DISAB=
LE, enable ? 1 : 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, CP_PG_D=
ISABLE, enable ? 0 : 1);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v8_0_init_pg(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; (AMD_PG_S=
UPPORT_GFX_PG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_SMG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_DMG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_CP |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GDS |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_RLC_SMU_HS)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v8_0_init_csb(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v8_0_init_save_restore_list(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v8_0_enable_save_restore_machine(adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_CARRIZO) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_STONEY))=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_JUM=
P_TABLE_RESTORE, adev-&gt;gfx.rlc.cp_table_gpu_addr &gt;&gt; 8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_po=
wer_gating(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_PG_=
ALWAYS_ON_CU_MASK, adev-&gt;gfx.cu_info.ao_cu_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_=
flags &amp; AMD_PG_SUPPORT_RLC_SMU_HS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sck_slow_down_on_power_up(adev, t=
rue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sck_slow_down_on_power_down(adev,=
 true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sck_slow_down_on_power_up(adev, f=
alse);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sck_slow_down_on_power_down(adev,=
 false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_=
flags &amp; AMD_PG_SUPPORT_CP)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_cp_power_gating(adev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_cp_power_gating(adev, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (adev-&gt;asic_type =3D=3D CHIP_POLARIS11) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_po=
wer_gating(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_csb(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_save_restore_list(a=
dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_enable_save_restore_mach=
ine(adev);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CH=
IP_CARRIZO) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_STONEY)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmRLC_JUMP_TABLE_RESTORE, adev-&gt;gfx.rlc.cp_table_g=
pu_addr &gt;&gt; 8);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v8_0_init_power_gating(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmRLC_PG_ALWAYS_ON_CU_MASK, adev-&gt;gfx.cu_info.ao_c=
u_mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_RLC_SMU_HS) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sc=
k_slow_down_on_power_up(adev, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sc=
k_slow_down_on_power_down(adev, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sc=
k_slow_down_on_power_up(adev, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_sc=
k_slow_down_on_power_down(adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_CP)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_cp=
_power_gating(adev, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_enable_cp=
_power_gating(adev, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;asic_type =3D=
=3D CHIP_POLARIS11) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v8_0_init_power_gating(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v8_0_rlc_stop(struct amdgpu_device *adev)<br>
@@ -5570,14 &#43;5562,11 @@ static int gfx_v8_0_set_powergating_state(void =
*handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable =3D (state =3D=
=3D AMD_PG_STATE_GATE) ? true : false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pg_flags &amp; AMD_PG_=
SUPPORT_GFX_PG))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_GFX_PG)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_update_gfx_cg=
_power_gating(adev, enable);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; cz_update_gfx_cg_power_gating(adev, enable);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_GFX_SMG) =
&amp;&amp; enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
8_0_enable_gfx_static_mg_power_gating(adev, true);<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk673551" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14805986103560.2303328502092905" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14805986103510.928282809078228" cellspacing=3D"0" =
style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relati=
ve; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 20=
px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rg=
b(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14805986103530.5299249391541836" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14805986103540.9670587046814567"></div>
<div id=3D"LPTitle_14805986103540.19756975909973828" style=3D"top: 0px; col=
or: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_14805986103550.2422724483276617" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14805986103550.8026698469598559" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14805986103550.03961792031288636" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
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

--_000_BN6PR12MB176436BACAD823BEA856AE02F78F0BN6PR12MB1764namp_--

--===============1991516436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1991516436==--
