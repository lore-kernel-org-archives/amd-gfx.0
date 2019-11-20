From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for reuse
Date: Wed, 20 Nov 2019 14:27:53 +0000
Message-ID: <CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191120104932.16257-1-Dennis.Li@amd.com>,
 <20191120104932.16257-2-Dennis.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0903227820=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191120104932.16257-2-Dennis.Li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

--===============0903227820==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Dennis Li <Dennis.Li-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 20, 2019 5:49 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>; Zha=
ng, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Chen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Cc: Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for reuse

The struct soc15_ras_field_entry will be reused by
other IPs, such as mmhub and gc

v2: rename ras_subblock_regs to gc_ras_fields_vg20,
because the future asic maybe have a different table.

Change-Id: I6c3388a09b5fbf927ad90fcd626baa448d1681a6
Signed-off-by: Dennis Li <dennis.li-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 34 +++++++++------------------
 drivers/gpu/drm/amd/amdgpu/soc15.h    | 12 ++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index c7ae685d6f74..8073fcd4720e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -131,18 +131,6 @@ MODULE_FIRMWARE("amdgpu/renoir_rlc.bin");
 #define mmTCP_CHAN_STEER_5_ARCT                                           =
              0x0b0c
 #define mmTCP_CHAN_STEER_5_ARCT_BASE_IDX                                  =
                      0

-struct ras_gfx_subblock_reg {
-       const char *name;
-       uint32_t hwip;
-       uint32_t inst;
-       uint32_t seg;
-       uint32_t reg_offset;
-       uint32_t sec_count_mask;
-       uint32_t sec_count_shift;
-       uint32_t ded_count_mask;
-       uint32_t ded_count_shift;
-};
-
 enum ta_ras_gfx_subblock {
         /*CPC*/
         TA_RAS_BLOCK__GFX_CPC_INDEX_START =3D 0,
@@ -5487,7 +5475,7 @@ static int gfx_v9_0_priv_inst_irq(struct amdgpu_devic=
e *adev,
 }


-static const struct ras_gfx_subblock_reg ras_subblock_regs[] =3D {
+static const struct soc15_ras_field_entry gc_ras_fields_vg20[] =3D {
         { "CPC_SCRATCH", SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_SCRATCH_CNT),
           SOC15_REG_FIELD(CPC_EDC_SCRATCH_CNT, SEC_COUNT),
           SOC15_REG_FIELD(CPC_EDC_SCRATCH_CNT, DED_COUNT)
@@ -6146,29 +6134,29 @@ static int __get_ras_error_count(const struct soc15=
_reg_entry *reg,
         uint32_t i;
         uint32_t sec_cnt, ded_cnt;

-       for (i =3D 0; i < ARRAY_SIZE(ras_subblock_regs); i++) {
-               if(ras_subblock_regs[i].reg_offset !=3D reg->reg_offset ||
-                       ras_subblock_regs[i].seg !=3D reg->seg ||
-                       ras_subblock_regs[i].inst !=3D reg->inst)
+       for (i =3D 0; i < ARRAY_SIZE(gc_ras_fields_vg20); i++) {
+               if(gc_ras_fields_vg20[i].reg_offset !=3D reg->reg_offset ||
+                       gc_ras_fields_vg20[i].seg !=3D reg->seg ||
+                       gc_ras_fields_vg20[i].inst !=3D reg->inst)
                         continue;

                 sec_cnt =3D (value &
-                               ras_subblock_regs[i].sec_count_mask) >>
-                               ras_subblock_regs[i].sec_count_shift;
+                               gc_ras_fields_vg20[i].sec_count_mask) >>
+                               gc_ras_fields_vg20[i].sec_count_shift;
                 if (sec_cnt) {
                         DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %=
d\n",
-                               ras_subblock_regs[i].name,
+                               gc_ras_fields_vg20[i].name,
                                 se_id, inst_id,
                                 sec_cnt);
                         *sec_count +=3D sec_cnt;
                 }

                 ded_cnt =3D (value &
-                               ras_subblock_regs[i].ded_count_mask) >>
-                               ras_subblock_regs[i].ded_count_shift;
+                               gc_ras_fields_vg20[i].ded_count_mask) >>
+                               gc_ras_fields_vg20[i].ded_count_shift;
                 if (ded_cnt) {
                         DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %=
d\n",
-                               ras_subblock_regs[i].name,
+                               gc_ras_fields_vg20[i].name,
                                 se_id, inst_id,
                                 ded_cnt);
                         *ded_count +=3D ded_cnt;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgp=
u/soc15.h
index 9af6c6ffbfa2..344280b869c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -60,6 +60,18 @@ struct soc15_allowed_register_entry {
         bool grbm_indexed;
 };

+struct soc15_ras_field_entry {
+       const char *name;
+       uint32_t hwip;
+       uint32_t inst;
+       uint32_t seg;
+       uint32_t reg_offset;
+       uint32_t sec_count_mask;
+       uint32_t sec_count_shift;
+       uint32_t ded_count_mask;
+       uint32_t ded_count_shift;
+};
+
 #define SOC15_REG_ENTRY(ip, inst, reg)  ip##_HWIP, inst, reg##_BASE_IDX, r=
eg

 #define SOC15_REG_ENTRY_OFFSET(entry)   (adev->reg_offset[entry.hwip][entr=
y.inst][entry.seg] + entry.reg_offset)
--
2.17.1


--_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dennis Li &lt;Dennis.=
Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 20, 2019 5:49 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;T=
ao.Zhou1-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Chen, G=
uchun &lt;Guchun.Chen-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Li, Dennis &lt;Dennis.Li-5C7GfCeVMHo@public.gmane.org&gt;; Li, Dennis &lt;Dennis.Li@a=
md.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for=
 reuse</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The struct soc15_ras_field_entry will be reused by=
<br>
other IPs, such as mmhub and gc<br>
<br>
v2: rename ras_subblock_regs to gc_ras_fields_vg20,<br>
because the future asic maybe have a different table.<br>
<br>
Change-Id: I6c3388a09b5fbf927ad90fcd626baa448d1681a6<br>
Signed-off-by: Dennis Li &lt;dennis.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 34 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;------------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.h&nbsp;&nbsp;&nbsp; | 12 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 23 insertions(&#43;), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index c7ae685d6f74..8073fcd4720e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -131,18 &#43;131,6 @@ MODULE_FIRMWARE(&quot;amdgpu/renoir_rlc.bin&quot;)=
;<br>
&nbsp;#define mmTCP_CHAN_STEER_5_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x0b0c<br>
&nbsp;#define mmTCP_CHAN_STEER_5_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0<br>
&nbsp;<br>
-struct ras_gfx_subblock_reg {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hwip;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seg;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_shift;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_shift;<br>
-};<br>
-<br>
&nbsp;enum ta_ras_gfx_subblock {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*CPC*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__GFX_CPC_INDE=
X_START =3D 0,<br>
@@ -5487,7 &#43;5475,7 @@ static int gfx_v9_0_priv_inst_irq(struct amdgpu_d=
evice *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-static const struct ras_gfx_subblock_reg ras_subblock_regs[] =3D {<br>
&#43;static const struct soc15_ras_field_entry gc_ras_fields_vg20[] =3D {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;CPC_SCRATCH&quot;,=
 SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_SCRATCH_CNT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_FIEL=
D(CPC_EDC_SCRATCH_CNT, SEC_COUNT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_FIEL=
D(CPC_EDC_SCRATCH_CNT, DED_COUNT)<br>
@@ -6146,29 &#43;6134,29 @@ static int __get_ras_error_count(const struct s=
oc15_reg_entry *reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_cnt, ded_cnt;=
<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(ras_s=
ubblock_regs); i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if(ras_subblock_regs[i].reg_offset !=3D reg-&gt;reg_offset ||<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_reg=
s[i].seg !=3D reg-&gt;seg ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_reg=
s[i].inst !=3D reg-&gt;inst)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(g=
c_ras_fields_vg20); i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if(gc_ras_fields_vg20[i].reg_offset !=3D reg-&gt;reg_offset =
||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_field=
s_vg20[i].seg !=3D reg-&gt;seg ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_field=
s_vg20[i].inst !=3D reg-&gt;inst)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sec_cnt =3D (value &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].sec_count_mask) &gt;&g=
t;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].sec_count_shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].sec_count_mask) &=
gt;&gt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].sec_count_shift;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (sec_cnt) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;GFX SubBlock %s, Instance[%d][%d], SEC %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].name,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_id, inst_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sec_cnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sec_=
count &#43;=3D sec_cnt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ded_cnt =3D (value &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].ded_count_mask) &gt;&g=
t;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].ded_count_shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].ded_count_mask) &=
gt;&gt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].ded_count_shift;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ded_cnt) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;GFX SubBlock %s, Instance[%d][%d], DED %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].name,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_id, inst_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ded_cnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ded_=
count &#43;=3D ded_cnt;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgp=
u/soc15.h<br>
index 9af6c6ffbfa2..344280b869c4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
@@ -60,6 &#43;60,18 @@ struct soc15_allowed_register_entry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool grbm_indexed;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct soc15_ras_field_entry {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hwip;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_shift;<br>
&#43;};<br>
&#43;<br>
&nbsp;#define SOC15_REG_ENTRY(ip, inst, reg)&nbsp; ip##_HWIP, inst, reg##_B=
ASE_IDX, reg<br>
&nbsp;<br>
&nbsp;#define SOC15_REG_ENTRY_OFFSET(entry)&nbsp;&nbsp; (adev-&gt;reg_offse=
t[entry.hwip][entry.inst][entry.seg] &#43; entry.reg_offset)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_--

--===============0903227820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0903227820==--
