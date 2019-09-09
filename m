From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: issue DC-BTC for arcturus on SMU
 init
Date: Mon, 9 Sep 2019 13:16:36 +0000
Message-ID: <MN2PR12MB329633E823EFA5F505FA4624A2B70@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190909113311.28497-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0365142683=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190909113311.28497-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============0365142683==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329633E823EFA5F505FA4624A2B70MN2PR12MB3296namp_"

--_000_MN2PR12MB329633E823EFA5F505FA4624A2B70MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 9, 2019 7:33 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Li, Candice <Candice.Li-5C7GfCeVMHo@public.gmane.org>; Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>; Quan, E=
van <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: issue DC-BTC for arcturus on SMU in=
it

Need to perform DC-BTC for arcturus on bootup.

Change-Id: I7f048ba17cafe8909c5ee1e00830e4f8527d1a05
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c      |  4 ++--
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c    | 17 ++++++++++++-----
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h  |  6 +++---
 .../gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h  |  3 +--
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h   |  1 +
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c      |  2 +-
 6 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 2602d9fa2d77..f13e134be42e 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1079,8 +1079,8 @@ static int smu_smc_table_hw_init(struct smu_context *=
smu,
         if (ret)
                 return ret;

-       /* issue RunAfllBtc msg */
-       ret =3D smu_run_afll_btc(smu);
+       /* issue Run*Btc msg */
+       ret =3D smu_run_btc(smu);
         if (ret)
                 return ret;

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 61cce5fed29f..7f6fc6d9a181 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -112,8 +112,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_messag=
e_map[SMU_MSG_MAX_COUNT]
         MSG_MAP(PrepareMp1ForShutdown,               PPSMC_MSG_PrepareMp1F=
orShutdown),
         MSG_MAP(SoftReset,                           PPSMC_MSG_SoftReset),
         MSG_MAP(RunAfllBtc,                          PPSMC_MSG_RunAfllBtc)=
,
-       MSG_MAP(RunGfxDcBtc,                         PPSMC_MSG_RunGfxDcBtc)=
,
-       MSG_MAP(RunSocDcBtc,                         PPSMC_MSG_RunSocDcBtc)=
,
+       MSG_MAP(RunDcBtc,                            PPSMC_MSG_RunDcBtc),
         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetD=
ramAddrHigh),
         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetD=
ramAddrLow),
         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetD=
ramSize),
@@ -547,9 +546,17 @@ static int arcturus_append_powerplay_table(struct smu_=
context *smu)
         return 0;
 }

-static int arcturus_run_btc_afll(struct smu_context *smu)
+static int arcturus_run_btc(struct smu_context *smu)
 {
-       return smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc);
+       int ret =3D 0;
+
+       ret =3D smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc);
+       if (ret) {
+               pr_err("RunAfllBtc failed!\n");
+               return ret;
+       }
+
+       return smu_send_smc_msg(smu, SMU_MSG_RunDcBtc);
 }

 static int arcturus_populate_umd_state_clk(struct smu_context *smu)
@@ -2307,7 +2314,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
         /* init dpm */
         .get_allowed_feature_mask =3D arcturus_get_allowed_feature_mask,
         /* btc */
-       .run_afll_btc =3D arcturus_run_btc_afll,
+       .run_btc =3D arcturus_run_btc,
         /* dpm/clk tables */
         .set_default_dpm_table =3D arcturus_set_default_dpm_table,
         .populate_umd_state_clk =3D arcturus_populate_umd_state_clk,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 3c69065b029e..3de88d084615 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -427,7 +427,7 @@ struct pptable_funcs {
         int (*get_smu_table_index)(struct smu_context *smu, uint32_t index=
);
         int (*get_smu_power_index)(struct smu_context *smu, uint32_t index=
);
         int (*get_workload_type)(struct smu_context *smu, enum PP_SMC_POWE=
R_PROFILE profile);
-       int (*run_afll_btc)(struct smu_context *smu);
+       int (*run_btc)(struct smu_context *smu);
         int (*get_allowed_feature_mask)(struct smu_context *smu, uint32_t =
*feature_mask, uint32_t num);
         enum amd_pm_state_type (*get_current_power_state)(struct smu_conte=
xt *smu);
         int (*set_default_dpm_table)(struct smu_context *smu);
@@ -745,8 +745,8 @@ struct smu_funcs
         ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_power_index? (smu)->=
ppt_funcs->get_smu_power_index((smu), (src)) : -EINVAL) : -EINVAL)
 #define smu_workload_get_type(smu, profile) \
         ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_workload_type? (smu)->pp=
t_funcs->get_workload_type((smu), (profile)) : -EINVAL) : -EINVAL)
-#define smu_run_afll_btc(smu) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->run_afll_btc? (smu)->ppt_func=
s->run_afll_btc((smu)) : 0) : 0)
+#define smu_run_btc(smu) \
+       ((smu)->ppt_funcs? ((smu)->ppt_funcs->run_btc? (smu)->ppt_funcs->ru=
n_btc((smu)) : 0) : 0)
 #define smu_get_allowed_feature_mask(smu, feature_mask, num) \
         ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_allowed_feature_mask? (s=
mu)->ppt_funcs->get_allowed_feature_mask((smu), (feature_mask), (num)) : 0)=
 : 0)
 #define smu_set_deep_sleep_dcefclk(smu, clk) \
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/g=
pu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index 78e5927b7711..e3291259b249 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -95,8 +95,7 @@

 //BTC
 #define PPSMC_MSG_RunAfllBtc                     0x30
-#define PPSMC_MSG_RunGfxDcBtc                    0x31
-#define PPSMC_MSG_RunSocDcBtc                    0x32
+#define PPSMC_MSG_RunDcBtc                       0x31

 //Debug
 #define PPSMC_MSG_DramLogSetDramAddrHigh         0x33
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_types.h
index b0dd05d431dd..ab8c92a60fc4 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -114,6 +114,7 @@
        __SMU_DUMMY_MAP(PowerDownJpeg),                \
        __SMU_DUMMY_MAP(BacoAudioD3PME),               \
        __SMU_DUMMY_MAP(ArmD3),                        \
+       __SMU_DUMMY_MAP(RunDcBtc),                     \
        __SMU_DUMMY_MAP(RunGfxDcBtc),                  \
        __SMU_DUMMY_MAP(RunSocDcBtc),                  \
        __SMU_DUMMY_MAP(SetMemoryChannelEnable),       \
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 929f61891dfa..e9ecc3f7aab1 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3145,7 +3145,7 @@ static const struct pptable_funcs vega20_ppt_funcs =
=3D {
         .get_smu_table_index =3D vega20_get_smu_table_index,
         .get_smu_power_index =3D vega20_get_pwr_src_index,
         .get_workload_type =3D vega20_get_workload_type,
-       .run_afll_btc =3D vega20_run_btc_afll,
+       .run_btc =3D vega20_run_btc_afll,
         .get_allowed_feature_mask =3D vega20_get_allowed_feature_mask,
         .get_current_power_state =3D vega20_get_current_power_state,
         .set_default_dpm_table =3D vega20_set_default_dpm_table,
--
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB329633E823EFA5F505FA4624A2B70MN2PR12MB3296namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Monday, September 9, 2019 7:33 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li-5C7GfCeVMHo@public.gmane.org&gt;; Gui, Jack &lt;Jack.Gui@a=
md.com&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: issue DC-BTC for arcturus on=
 SMU init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Need to perform DC-BTC for arcturus on bootup.<br>
<br>
Change-Id: I7f048ba17cafe8909c5ee1e00830e4f8527d1a05<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp;&nbsp; | 17 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp; |&nbsp; 6 &#43;&=
#43;&#43;---<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h&nbsp; |&nbsp; 3 &#43;-=
-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_types.h&nbsp;&nbsp; |&nbsp; 1 &=
#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 2 &#43;-<br>
&nbsp;6 files changed, 20 insertions(&#43;), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 2602d9fa2d77..f13e134be42e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1079,8 &#43;1079,8 @@ static int smu_smc_table_hw_init(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* issue RunAfllBtc msg */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_run_afll_btc(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* issue Run*Btc msg */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_run_btc(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 61cce5fed29f..7f6fc6d9a181 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -112,8 &#43;112,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_me=
ssage_map[SMU_MSG_MAX_COUNT]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForShutd=
own,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_PrepareMp1ForShutdown),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SoftReset,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
PSMC_MSG_SoftReset),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunAfllBtc,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_RunAfllBtc),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunGfxDcBtc,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_RunGfxDcBtc)=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunSocDcBtc,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_RunSocDcBtc)=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunDcBtc,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPS=
MC_MSG_RunDcBtc),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_DramLogSetDramAddrHigh),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
Low,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramAddrLow),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramSize),<br>
@@ -547,9 &#43;546,17 @@ static int arcturus_append_powerplay_table(struct =
smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int arcturus_run_btc_afll(struct smu_context *smu)<br>
&#43;static int arcturus_run_btc(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg(smu, SMU_MSG_=
RunAfllBtc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg(smu, SMU=
_MSG_RunAfllBtc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;RunAfllBtc failed!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg(smu, SMU_=
MSG_RunDcBtc);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int arcturus_populate_umd_state_clk(struct smu_context *smu)<b=
r>
@@ -2307,7 &#43;2314,7 @@ static const struct pptable_funcs arcturus_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init dpm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =
=3D arcturus_get_allowed_feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* btc */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_afll_btc =3D arcturus_run_btc_af=
ll,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_btc =3D arcturus_run_btc,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dpm/clk tables */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 arcturus_set_default_dpm_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_umd_state_clk =
=3D arcturus_populate_umd_state_clk,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 3c69065b029e..3de88d084615 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -427,7 &#43;427,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_smu_table_index)=
(struct smu_context *smu, uint32_t index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_smu_power_index)=
(struct smu_context *smu, uint32_t index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_workload_type)(s=
truct smu_context *smu, enum PP_SMC_POWER_PROFILE profile);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*run_afll_btc)(struct smu_contex=
t *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*run_btc)(struct smu_context=
 *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_allowed_feature_=
mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type (*g=
et_current_power_state)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_default_dpm_tabl=
e)(struct smu_context *smu);<br>
@@ -745,8 &#43;745,8 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((sm=
u)-&gt;ppt_funcs-&gt;get_smu_power_index? (smu)-&gt;ppt_funcs-&gt;get_smu_p=
ower_index((smu), (src)) : -EINVAL) : -EINVAL)<br>
&nbsp;#define smu_workload_get_type(smu, profile) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((sm=
u)-&gt;ppt_funcs-&gt;get_workload_type? (smu)-&gt;ppt_funcs-&gt;get_workloa=
d_type((smu), (profile)) : -EINVAL) : -EINVAL)<br>
-#define smu_run_afll_btc(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;run_afll_btc? (smu)-&gt;ppt_funcs-&gt;run_afll_btc((smu)) : 0) : =
0)<br>
&#43;#define smu_run_btc(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;=
ppt_funcs-&gt;run_btc? (smu)-&gt;ppt_funcs-&gt;run_btc((smu)) : 0) : 0)<br>
&nbsp;#define smu_get_allowed_feature_mask(smu, feature_mask, num) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((sm=
u)-&gt;ppt_funcs-&gt;get_allowed_feature_mask? (smu)-&gt;ppt_funcs-&gt;get_=
allowed_feature_mask((smu), (feature_mask), (num)) : 0) : 0)<br>
&nbsp;#define smu_set_deep_sleep_dcefclk(smu, clk) \<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/g=
pu/drm/amd/powerplay/inc/arcturus_ppsmc.h<br>
index 78e5927b7711..e3291259b249 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h<br>
@@ -95,8 &#43;95,7 @@<br>
&nbsp;<br>
&nbsp;//BTC<br>
&nbsp;#define PPSMC_MSG_RunAfllBtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x30<br>
-#define PPSMC_MSG_RunGfxDcBtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x31<=
br>
-#define PPSMC_MSG_RunSocDcBtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x32<=
br>
&#43;#define PPSMC_MSG_RunDcBtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x31<br>
&nbsp;<br>
&nbsp;//Debug<br>
&nbsp;#define PPSMC_MSG_DramLogSetDramAddrHigh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x33<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_types.h<br>
index b0dd05d431dd..ab8c92a60fc4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
@@ -114,6 &#43;114,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(PowerDownJpeg),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BacoAudioD3PME),=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ArmD3),&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RunDcBtc),&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RunGfxDcBtc),&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RunSocDcBtc),&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetMemoryChannel=
Enable),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 929f61891dfa..e9ecc3f7aab1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -3145,7 &#43;3145,7 @@ static const struct pptable_funcs vega20_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_table_index =3D v=
ega20_get_smu_table_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_power_index =3D v=
ega20_get_pwr_src_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_workload_type =3D veg=
a20_get_workload_type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_afll_btc =3D vega20_run_btc_afll=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_btc =3D vega20_run_btc_afll,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =
=3D vega20_get_allowed_feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_power_state =
=3D vega20_get_current_power_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 vega20_set_default_dpm_table,<br>
-- <br>
2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329633E823EFA5F505FA4624A2B70MN2PR12MB3296namp_--

--===============0365142683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0365142683==--
