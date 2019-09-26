From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: add IH cg support on soc15 project
Date: Thu, 26 Sep 2019 08:54:04 +0000
Message-ID: <MN2PR12MB329667CC068A0E76AE17E199A2860@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1569487656-24977-1-git-send-email-kenneth.feng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0993931912=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569487656-24977-1-git-send-email-kenneth.feng-5C7GfCeVMHo@public.gmane.org>
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
To: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0993931912==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329667CC068A0E76AE17E199A2860MN2PR12MB3296namp_"

--_000_MN2PR12MB329667CC068A0E76AE17E199A2860MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kenneth =
Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 26, 2019 4:47 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: add IH cg support on soc15 project

enable/disable IH clock gating on soc15 projects.

Signed-off-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  3 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             | 39 ++++++++++++++++++=
++++
 .../amd/include/asic_reg/oss/osssys_4_0_sh_mask.h  |  4 +++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 58818761..e40410e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1166,7 +1166,8 @@ static int soc15_common_early_init(void *handle)
                         AMD_CG_SUPPORT_SDMA_MGCG |
                         AMD_CG_SUPPORT_SDMA_LS |
                         AMD_CG_SUPPORT_MC_MGCG |
-                       AMD_CG_SUPPORT_MC_LS;
+                       AMD_CG_SUPPORT_MC_LS |
+                       AMD_CG_SUPPORT_IH_CG;
                 adev->pg_flags =3D 0;
                 adev->external_rev_id =3D adev->rev_id + 0x32;
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c
index 14e0b04..5cb7e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -675,10 +675,49 @@ static int vega10_ih_soft_reset(void *handle)
         return 0;
 }

+static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
+                                              bool enable)
+{
+       uint32_t data, def, field_val;
+
+       if (adev->cg_flags & AMD_CG_SUPPORT_IH_CG) {
+               def =3D data =3D RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL);
+               field_val =3D enable ? 0 : 1;
+               /**
+                * Vega10 does not have IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERR=
IDE
+                * and IH_BUFFER_MEM_CLK_SOFT_OVERRIDE field.
+                */
+               if (adev->asic_type > CHIP_VEGA10) {
+                       data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE=
, field_val);
+                       data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    IH_BUFFER_MEM_CLK_SOFT_OVERRIDE, field=
_val);
+               }
+
+               data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    DBUS_MUX_CLK_SOFT_OVERRIDE, field_val)=
;
+               data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    OSSSYS_SHARE_CLK_SOFT_OVERRIDE, field_=
val);
+               data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    LIMIT_SMN_CLK_SOFT_OVERRIDE, field_val=
);
+               data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    DYN_CLK_SOFT_OVERRIDE, field_val);
+               data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
+                                    REG_CLK_SOFT_OVERRIDE, field_val);
+               if (def !=3D data)
+                       WREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL, data);
+       }
+}
+
 static int vega10_ih_set_clockgating_state(void *handle,
                                           enum amd_clockgating_state state=
)
 {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+
+       vega10_ih_update_clockgating_state(adev,
+                               state =3D=3D AMD_CG_STATE_GATE ? true : fal=
se);
         return 0;
+
 }

 static int vega10_ih_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h
index dc9895a..096d878 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h
@@ -588,11 +588,15 @@
 #define IH_STORM_CLIENT_LIST_CNTL__CLIENT30_IS_STORM_CLIENT_MASK          =
                                    0x40000000L
 #define IH_STORM_CLIENT_LIST_CNTL__CLIENT31_IS_STORM_CLIENT_MASK          =
                                    0x80000000L
 //IH_CLK_CTRL
+#define IH_CLK_CTRL__IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE__SHIFT        =
                                     0x19
+#define IH_CLK_CTRL__IH_BUFFER_MEM_CLK_SOFT_OVERRIDE__SHIFT               =
                                                0x1a
 #define IH_CLK_CTRL__DBUS_MUX_CLK_SOFT_OVERRIDE__SHIFT                    =
                                    0x1b
 #define IH_CLK_CTRL__OSSSYS_SHARE_CLK_SOFT_OVERRIDE__SHIFT                =
                                    0x1c
 #define IH_CLK_CTRL__LIMIT_SMN_CLK_SOFT_OVERRIDE__SHIFT                   =
                                    0x1d
 #define IH_CLK_CTRL__DYN_CLK_SOFT_OVERRIDE__SHIFT                         =
                                    0x1e
 #define IH_CLK_CTRL__REG_CLK_SOFT_OVERRIDE__SHIFT                         =
                                    0x1f
+#define IH_CLK_CTRL__IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE_MASK          =
                                    0x02000000L
+#define IH_CLK_CTRL__IH_BUFFER_MEM_CLK_SOFT_OVERRIDE_MASK                 =
                                        0x04000000L
 #define IH_CLK_CTRL__DBUS_MUX_CLK_SOFT_OVERRIDE_MASK                      =
                                    0x08000000L
 #define IH_CLK_CTRL__OSSSYS_SHARE_CLK_SOFT_OVERRIDE_MASK                  =
                                    0x10000000L
 #define IH_CLK_CTRL__LIMIT_SMN_CLK_SOFT_OVERRIDE_MASK                     =
                                    0x20000000L
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB329667CC068A0E76AE17E199A2860MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div id=3D"appendonsend" style=3D"font-family: Calibri, Arial, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 26, 2019 4:47 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: add IH cg support on soc15 project<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">enable/disable IH clock gating on soc15 projects.<=
br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_ih.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 39 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;<br>
&nbsp;.../amd/include/asic_reg/oss/osssys_4_0_sh_mask.h&nbsp; |&nbsp; 4 &#4=
3;&#43;&#43;<br>
&nbsp;3 files changed, 45 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 58818761..e40410e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -1166,7 &#43;1166,8 @@ static int soc15_common_early_init(void *handle)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_SDMA_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_SDMA_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_MC_MGCG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_M=
C_LS;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPO=
RT_MC_LS |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPO=
RT_IH_CG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id &#43; 0x=
32;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c<br>
index 14e0b04..5cb7e23 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
@@ -675,10 &#43;675,49 @@ static int vega10_ih_soft_reset(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void vega10_ih_update_clockgating_state(struct amdgpu_device *a=
dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, def, field_val;<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_C=
G_SUPPORT_IH_CG) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; field_val =3D enable ? 0 : 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Vega10 does not have IH_RETRY_INT_CAM_MEM_CLK_SOFT_O=
VERRIDE<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * and IH_BUFFER_MEM_CLK_SOFT_OVERRIDE field.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;asic_type &gt; CHIP_VEGA10) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_RETRY_=
INT_CAM_MEM_CLK_SOFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_BUFFER=
_MEM_CLK_SOFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBUS_MUX_=
CLK_SOFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OSSSYS_SH=
ARE_CLK_SOFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LIMIT_SMN=
_CLK_SOFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DYN_CLK_S=
OFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_CLK_S=
OFT_OVERRIDE, field_val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (def !=3D data)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15=
(OSSSYS, 0, mmIH_CLK_CTRL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int vega10_ih_set_clockgating_state(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (s=
truct amdgpu_device *)handle;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_update_clockgating_stat=
e(adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE ? true :=
 false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega10_ih_set_powergating_state(void *handle,<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h<br>
index dc9895a..096d878 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_ma=
sk.h<br>
@@ -588,11 &#43;588,15 @@<br>
&nbsp;#define IH_STORM_CLIENT_LIST_CNTL__CLIENT30_IS_STORM_CLIENT_MASK&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40000000L<br>
&nbsp;#define IH_STORM_CLIENT_LIST_CNTL__CLIENT31_IS_STORM_CLIENT_MASK&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000L<br>
&nbsp;//IH_CLK_CTRL<br>
&#43;#define IH_CLK_CTRL__IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE__SHIFT&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x19<br>
&#43;#define IH_CLK_CTRL__IH_BUFFER_MEM_CLK_SOFT_OVERRIDE__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1a<br>
&nbsp;#define IH_CLK_CTRL__DBUS_MUX_CLK_SOFT_OVERRIDE__SHIFT&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x1b<br>
&nbsp;#define IH_CLK_CTRL__OSSSYS_SHARE_CLK_SOFT_OVERRIDE__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1c=
<br>
&nbsp;#define IH_CLK_CTRL__LIMIT_SMN_CLK_SOFT_OVERRIDE__SHIFT&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x1d<br>
&nbsp;#define IH_CLK_CTRL__DYN_CLK_SOFT_OVERRIDE__SHIFT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1e<br>
&nbsp;#define IH_CLK_CTRL__REG_CLK_SOFT_OVERRIDE__SHIFT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1f<br>
&#43;#define IH_CLK_CTRL__IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE_MASK&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02000000L<br>
&#43;#define IH_CLK_CTRL__IH_BUFFER_MEM_CLK_SOFT_OVERRIDE_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x04000000L<br>
&nbsp;#define IH_CLK_CTRL__DBUS_MUX_CLK_SOFT_OVERRIDE_MASK&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x08000000L<br>
&nbsp;#define IH_CLK_CTRL__OSSSYS_SHARE_CLK_SOFT_OVERRIDE_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x10000000L<br>
&nbsp;#define IH_CLK_CTRL__LIMIT_SMN_CLK_SOFT_OVERRIDE_MASK&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x20000000L<br>
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

--_000_MN2PR12MB329667CC068A0E76AE17E199A2860MN2PR12MB3296namp_--

--===============0993931912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0993931912==--
