From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/display: rename DCN1_0 kconfig to DCN
Date: Fri, 1 Nov 2019 18:11:06 +0000
Message-ID: <BN6SPR00MB1823DB22084D7F576D6E021F7620@BN6SPR00MB182.namprd12.prod.outlook.com>
References: <20191101180514.6828-1-Bhawanpreet.Lakha@amd.com>,
 <20191101180514.6828-3-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0286138176=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191101180514.6828-3-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0286138176==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6SPR00MB1823DB22084D7F576D6E021F7620BN6SPR00MB182namp_"

--_000_BN6SPR00MB1823DB22084D7F576D6E021F7620BN6SPR00MB182namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Bhawanpr=
eet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 1, 2019 2:05 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amd/display: rename DCN1_0 kconfig to DCN

Since dcn20 and dcn21 are under dcn1 it doesnt make sense to
have it named dcn1.

Change it to "dcn" to make it generic

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/Kconfig           |  4 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++++----
 drivers/gpu/drm/amd/display/dc/Makefile       |  4 ++--
 .../display/dc/bios/command_table_helper2.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 ++++----
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.h |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 10 +++++-----
 .../amd/display/dc/dce/dce_stream_encoder.c   | 20 +++++++++----------
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  4 ++--
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |  2 +-
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |  4 ++--
 .../drm/amd/display/dc/gpio/hw_translate.c    |  4 ++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  6 +++---
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |  2 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/os_types.h     |  2 +-
 29 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig
index b5a9bfe8998c..78f40690a109 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,13 +6,13 @@ config DRM_AMD_DC
         bool "AMD DC - Enable new display engine"
         default y
         select SND_HDA_COMPONENT if SND_HDA_CORE
-       select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_EN=
ABLE_COMPARISONS)
+       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABL=
E_COMPARISONS)
         help
           Choose this option if you want to use the new display engine
           support for AMDGPU. This adds required support for Vega and
           Raven ASICs.

-config DRM_AMD_DC_DCN1_0
+config DRM_AMD_DC_DCN
         def_bool n
         help
           Raven, Navi and Renoir family support for display engine
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 441ad43ce9a9..72e7a1245bd8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -72,7 +72,7 @@
 #include <drm/drm_audio_component.h>
 #include <drm/drm_hdcp.h>

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"

 #include "dcn/dcn_1_0_offset.h"
@@ -1866,7 +1866,7 @@ static int dce110_register_irq_handlers(struct amdgpu=
_device *adev)
         return 0;
 }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 {
@@ -2455,7 +2455,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)
                         goto fail;
                 }
                 break;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case CHIP_RAVEN:
         case CHIP_NAVI12:
         case CHIP_NAVI10:
@@ -2679,7 +2679,7 @@ static int dm_early_init(void *handle)
                 adev->mode_info.num_hpd =3D 6;
                 adev->mode_info.num_dig =3D 6;
                 break;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case CHIP_RAVEN:
                 adev->mode_info.num_crtc =3D 4;
                 adev->mode_info.num_hpd =3D 4;
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/=
display/dc/Makefile
index 1feba4190284..ee9b83e5c51a 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -25,7 +25,7 @@

 DC_LIBS =3D basics bios calcs clk_mgr dce gpio irq virtual

-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 DC_LIBS +=3D dcn20
 DC_LIBS +=3D dsc
 DC_LIBS +=3D dcn10 dml
@@ -50,7 +50,7 @@ include $(AMD_DC)
 DISPLAY_CORE =3D dc.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o =
\
 dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_strea=
m.o

-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 DISPLAY_CORE +=3D dc_vm_helper.o
 endif

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/=
drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 47bb802b7164..7388c987c595 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -55,7 +55,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
         case DCE_VERSION_11_22:
                 *h =3D dal_cmd_tbl_helper_dce112_get_table2();
                 return true;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case DCN_VERSION_1_0:
         case DCN_VERSION_1_01:
                 *h =3D dal_cmd_tbl_helper_dce112_get_table2();
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/dr=
m/amd/display/dc/calcs/Makefile
index e59a7f356188..927e46075aa7 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -47,7 +47,7 @@ CFLAGS_dcn_calc_math.o :=3D $(calcs_ccflags) -Wno-tautolo=
gical-compare

 BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o

-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 BW_CALCS +=3D dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
 endif

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/=
drm/amd/display/dc/clk_mgr/Makefile
index de01543f0161..3cd283195091 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -63,7 +63,7 @@ CLK_MGR_DCE120 =3D dce120_clk_mgr.o
 AMD_DAL_CLK_MGR_DCE120 =3D $(addprefix $(AMDDALPATH)/dc/clk_mgr/dce120/,$(=
CLK_MGR_DCE120))

 AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCE120)
-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 ##########################################################################=
#####
 # DCN10
 ##########################################################################=
#####
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 740d92bd4481..a7c4c1d1fc59 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -132,7 +132,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ct=
x, struct pp_smu_funcs *p
                         dce120_clk_mgr_construct(ctx, clk_mgr);
                 break;

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case FAMILY_RV:
                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev)) {
                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index 4d1a8f706633..a940ca7d59db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -565,7 +565,7 @@ static void destruct(struct dc *dc)
         kfree(dc->bw_dceip);
         dc->bw_dceip =3D NULL;

-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         kfree(dc->dcn_soc);
         dc->dcn_soc =3D NULL;

@@ -584,7 +584,7 @@ static bool construct(struct dc *dc,
         struct dc_context *dc_ctx;
         struct bw_calcs_dceip *dc_dceip;
         struct bw_calcs_vbios *dc_vbios;
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         struct dcn_soc_bounding_box *dcn_soc;
         struct dcn_ip_params *dcn_ip;
 #endif
@@ -616,7 +616,7 @@ static bool construct(struct dc *dc,
         }

         dc->bw_vbios =3D dc_vbios;
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         dcn_soc =3D kzalloc(sizeof(*dcn_soc), GFP_KERNEL);
         if (!dcn_soc) {
                 dm_error("%s: failed to create dcn_soc\n", __func__);
@@ -1295,7 +1295,7 @@ struct dc_state *dc_create_state(struct dc *dc)
          * initialize and obtain IP and SOC the base DML instance from DC =
is
          * initially copied into every context
          */
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_=
lib));
 #endif

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/d=
rm/amd/display/dc/core/dc_debug.c
index b9227d5de3a3..85a52a16295a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -347,7 +347,7 @@ void context_clock_trace(
                 struct dc *dc,
                 struct dc_state *context)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         DC_LOGGER_INIT(dc->ctx->logger);
         CLOCK_TRACE("Current: dispclk_khz:%d  max_dppclk_khz:%d  dcfclk_kh=
z:%d\n"
                         "dcfclk_deep_sleep_khz:%d  fclk_khz:%d  socclk_khz=
:%d\n",
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index eb6def649dec..0cc4bed0b983 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2580,7 +2580,7 @@ bool dc_link_setup_psr(struct dc_link *link,

         psr_context->psr_level.u32all =3D 0;

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         /*skip power down the single pipe since it blocks the cstate*/
         if (ASICREV_IS_RAVEN(link->ctx->asic_id.hw_internal_rev))
                 psr_context->psr_level.bits.SKIP_CRTC_DISABLE =3D true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index 162e512831b7..89b5f86cd40b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -46,7 +46,7 @@
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/dcn10_resource.h"
 #endif
 #include "dcn20/dcn20_resource.h"
@@ -95,7 +95,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id=
 asic_id)
                 else
                         dc_version =3D DCE_VERSION_12_0;
                 break;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case FAMILY_RV:
                 dc_version =3D DCN_VERSION_1_0;
                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev))
@@ -154,7 +154,7 @@ struct resource_pool *dc_create_resource_pool(struct dc=
  *dc,
                                 init_data->num_virtual_links, dc);
                 break;

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case DCN_VERSION_1_0:
         case DCN_VERSION_1_01:
                 res_pool =3D dcn10_create_resource_pool(init_data, dc);
@@ -1192,7 +1192,7 @@ static struct pipe_ctx *acquire_free_pipe_for_head(
         return pool->funcs->acquire_idle_pipe_for_layer(context, pool, hea=
d_pipe->stream);
 }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static int acquire_first_split_pipe(
                 struct resource_context *res_ctx,
                 const struct resource_pool *pool,
@@ -1273,7 +1273,7 @@ bool dc_add_plane_to_context(

                 free_pipe =3D acquire_free_pipe_for_head(context, pool, he=
ad_pipe);

-       #if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+       #if defined(CONFIG_DRM_AMD_DC_DCN)
                 if (!free_pipe) {
                         int pipe_idx =3D acquire_first_split_pipe(&context=
->res_ctx, pool, stream);
                         if (pipe_idx >=3D 0)
@@ -1947,7 +1947,7 @@ enum dc_status resource_map_pool_resources(
                 /* acquire new resources */
                 pipe_idx =3D acquire_first_free_pipe(&context->res_ctx, po=
ol, stream);

-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         if (pipe_idx < 0)
                 pipe_idx =3D acquire_first_split_pipe(&context->res_ctx, p=
ool, stream);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_stream.c
index dc05c14530b0..371d49e9b745 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -32,7 +32,7 @@
 #include "resource.h"
 #include "ipp.h"
 #include "timing_generator.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/dcn10_hw_sequencer.h"
 #endif

@@ -235,7 +235,7 @@ struct dc_stream_status *dc_stream_get_status(

 static void delay_cursor_until_vupdate(struct pipe_ctx *pipe_ctx, struct d=
c *dc)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         unsigned int vupdate_line;
         unsigned int lines_to_vupdate, us_to_vupdate, vpos, nvpos;
         struct dc_stream_state *stream =3D pipe_ctx->stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index 290ee6b1cbed..98f55521ea8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -488,7 +488,7 @@ struct dc {
         /* Inputs into BW and WM calculations. */
         struct bw_calcs_dceip *bw_dceip;
         struct bw_calcs_vbios *bw_vbios;
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         struct dcn_soc_bounding_box *dcn_soc;
         struct dcn_ip_params *dcn_ip;
         struct display_mode_lib dml;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 898decadb8e6..2e992fbc0d71 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -905,7 +905,7 @@ static bool dce112_program_pix_clk(
         struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(clock_source)=
;
         struct bp_pixel_clock_parameters bp_pc_params =3D {0};

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
                 unsigned int inst =3D pix_clk_params->controller_id - CONT=
ROLLER_ID_D0;
                 unsigned dp_dto_ref_100hz =3D 7000000;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 8d0d07db5190..51bd25079606 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -97,7 +97,7 @@
         CS_SF(PHYPLLA_PIXCLK_RESYNC_CNTL, PHYPLLA_DCCG_DEEP_COLOR_CNTL, ma=
sk_sh),\
         CS_SF(OTG0_PIXEL_RATE_CNTL, DP_DTO0_ENABLE, mask_sh)

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)

 #define CS_COMMON_REG_LIST_DCN1_0(index, pllid) \
                 SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/dr=
m/amd/display/dc/dce/dce_dmcu.c
index d01fb2f55535..e619e67e6b51 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -324,7 +324,7 @@ static void dce_get_psr_wait_loop(
         return;
 }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void dcn10_get_dmcu_version(struct dmcu *dmcu)
 {
         struct dce_dmcu *dmcu_dce =3D TO_DCE_DMCU(dmcu);
@@ -794,7 +794,7 @@ static bool dcn20_unlock_phy(struct dmcu *dmcu)
         return true;
 }

-#endif //(CONFIG_DRM_AMD_DC_DCN1_0)
+#endif //(CONFIG_DRM_AMD_DC_DCN)

 static const struct dmcu_funcs dce_funcs =3D {
         .dmcu_init =3D dce_dmcu_init,
@@ -807,7 +807,7 @@ static const struct dmcu_funcs dce_funcs =3D {
         .is_dmcu_initialized =3D dce_is_dmcu_initialized
 };

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static const struct dmcu_funcs dcn10_funcs =3D {
         .dmcu_init =3D dcn10_dmcu_init,
         .load_iram =3D dcn10_dmcu_load_iram,
@@ -864,7 +864,7 @@ static void dce_dmcu_construct(
         dmcu_dce->dmcu_mask =3D dmcu_mask;
 }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void dcn21_dmcu_construct(
                 struct dce_dmcu *dmcu_dce,
                 struct dc_context *ctx,
@@ -905,7 +905,7 @@ struct dmcu *dce_dmcu_create(
         return &dmcu_dce->base;
 }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 struct dmcu *dcn10_dmcu_create(
         struct dc_context *ctx,
         const struct dce_dmcu_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 2baaac1e5156..451574971b96 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -137,7 +137,7 @@ static void dce110_update_generic_info_packet(
                         AFMT_GENERIC0_UPDATE, (packet_index =3D=3D 0),
                         AFMT_GENERIC2_UPDATE, (packet_index =3D=3D 2));
         }
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         if (REG(AFMT_VBI_PACKET_CONTROL1)) {
                 switch (packet_index) {
                 case 0:
@@ -231,7 +231,7 @@ static void dce110_update_hdmi_info_packet(
                                 HDMI_GENERIC1_SEND, send,
                                 HDMI_GENERIC1_LINE, line);
                 break;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case 4:
                 if (REG(HDMI_GENERIC_PACKET_CONTROL2))
                         REG_UPDATE_3(HDMI_GENERIC_PACKET_CONTROL2,
@@ -278,7 +278,7 @@ static void dce110_stream_encoder_dp_set_stream_attribu=
te(
         bool use_vsc_sdp_for_colorimetry,
         uint32_t enable_sdp_splitting)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         uint32_t h_active_start;
         uint32_t v_active_start;
         uint32_t misc0 =3D 0;
@@ -330,7 +330,7 @@ static void dce110_stream_encoder_dp_set_stream_attribu=
te(
                 if (enc110->se_mask->DP_VID_M_DOUBLE_VALUE_EN)
                         REG_UPDATE(DP_VID_TIMING, DP_VID_M_DOUBLE_VALUE_EN=
, 1);

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
                 if (enc110->se_mask->DP_VID_N_MUL)
                         REG_UPDATE(DP_VID_TIMING, DP_VID_N_MUL, 1);
 #endif
@@ -341,7 +341,7 @@ static void dce110_stream_encoder_dp_set_stream_attribu=
te(
                 break;
         }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         if (REG(DP_MSA_MISC))
                 misc1 =3D REG_READ(DP_MSA_MISC);
 #endif
@@ -375,7 +375,7 @@ static void dce110_stream_encoder_dp_set_stream_attribu=
te(
         /* set dynamic range and YCbCr range */


-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         switch (hw_crtc_timing.display_color_depth) {
         case COLOR_DEPTH_666:
                 colorimetry_bpc =3D 0;
@@ -455,7 +455,7 @@ static void dce110_stream_encoder_dp_set_stream_attribu=
te(
                                 DP_DYN_RANGE, dynamic_range_rgb,
                                 DP_YCBCR_RANGE, dynamic_range_ycbcr);

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
                 if (REG(DP_MSA_COLORIMETRY))
                         REG_SET(DP_MSA_COLORIMETRY, 0, DP_MSA_MISC0, misc0=
);

@@ -490,7 +490,7 @@ static void dce110_stream_encoder_dp_set_stream_attribu=
te(
                                 hw_crtc_timing.v_front_porch;


-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
                 /* start at begining of left border */
                 if (REG(DP_MSA_TIMING_PARAM2))
                         REG_SET_2(DP_MSA_TIMING_PARAM2, 0,
@@ -787,7 +787,7 @@ static void dce110_stream_encoder_update_hdmi_info_pack=
ets(
                 dce110_update_hdmi_info_packet(enc110, 3, &info_frame->hdr=
smd);
         }

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         if (enc110->se_mask->HDMI_DB_DISABLE) {
                 /* for bring up, disable dp double  TODO */
                 if (REG(HDMI_DB_CONTROL))
@@ -825,7 +825,7 @@ static void dce110_stream_encoder_stop_hdmi_info_packet=
s(
                 HDMI_GENERIC1_LINE, 0,
                 HDMI_GENERIC1_SEND, 0);

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         /* stop generic packets 2 & 3 on HDMI */
         if (REG(HDMI_GENERIC_PACKET_CONTROL2))
                 REG_SET_6(HDMI_GENERIC_PACKET_CONTROL2, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 811896a43b67..3f5fbad587e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1223,7 +1223,7 @@ static void program_scaler(const struct dc *dc,
 {
         struct tg_color color =3D {0};

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         /* TOFPGA */
         if (pipe_ctx->plane_res.xfm->funcs->transform_set_pixel_storage_de=
pth =3D=3D NULL)
                 return;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c b/drivers/gpu=
/drm/amd/display/dc/dcn10/dcn10_dwb.c
index 64b31edc8cf6..b6391a5ead78 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
@@ -23,7 +23,7 @@
  *
  */

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)

 #include "reg_helper.h"
 #include "resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h b/drivers/gpu=
/drm/amd/display/dc/dcn10/dcn10_dwb.h
index c175edd0bae7..d56ea7c8171e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h
@@ -24,7 +24,7 @@
 #ifndef __DC_DWBC_DCN10_H__
 #define __DC_DWBC_DCN10_H__

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)

 /* DCN */
 #define BASE_INNER(seg) \
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/=
amd/display/dc/dml/Makefile
index 58c9eb1b6a06..e4da4df9cd11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -43,7 +43,7 @@ endif

 CFLAGS_display_mode_lib.o :=3D $(dml_ccflags)

-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_display_mode_vba.o :=3D $(dml_ccflags)
 CFLAGS_display_mode_vba_20.o :=3D $(dml_ccflags)
 CFLAGS_display_rq_dlg_calc_20.o :=3D $(dml_ccflags)
@@ -62,7 +62,7 @@ CFLAGS_dml_common_defs.o :=3D $(dml_ccflags)
 DML =3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_ca=
lc.o \
         dml_common_defs.o

-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 DML +=3D display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_m=
ode_vba_20.o
 DML +=3D dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML +=3D dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm=
/amd/display/dc/gpio/Makefile
index 013cfac4ff55..202baa210cc8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -61,7 +61,7 @@ AMD_DISPLAY_FILES +=3D $(AMD_DAL_GPIO_DCE120)
 ##########################################################################=
#####
 # DCN 1x
 ##########################################################################=
#####
-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 GPIO_DCN10 =3D hw_translate_dcn10.o hw_factory_dcn10.o

 AMD_DAL_GPIO_DCN10 =3D $(addprefix $(AMDDALPATH)/dc/gpio/dcn10/,$(GPIO_DCN=
10))
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu=
/drm/amd/display/dc/gpio/hw_factory.c
index fb2d66729ca3..d2d36d48caaa 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -45,7 +45,7 @@
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/hw_factory_dcn10.h"
 #endif
 #include "dcn20/hw_factory_dcn20.h"
@@ -86,7 +86,7 @@ bool dal_hw_factory_init(
         case DCE_VERSION_12_1:
                 dal_hw_factory_dce120_init(factory);
                 return true;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case DCN_VERSION_1_0:
         case DCN_VERSION_1_01:
                 dal_hw_factory_dcn10_init(factory);
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/g=
pu/drm/amd/display/dc/gpio/hw_translate.c
index 55acfda9ea63..5d396657a1ee 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -43,7 +43,7 @@
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/hw_translate_dcn10.h"
 #endif
 #include "dcn20/hw_translate_dcn20.h"
@@ -81,7 +81,7 @@ bool dal_hw_translate_init(
         case DCE_VERSION_12_1:
                 dal_hw_translate_dce120_init(translate);
                 return true;
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         case DCN_VERSION_1_0:
         case DCN_VERSION_1_01:
                 dal_hw_translate_dcn10_init(translate);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h
index c98d887cc6e2..e0aac234537f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -33,7 +33,7 @@
 #include "dc_bios_types.h"
 #include "mem_input.h"
 #include "hubp.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "mpc.h"
 #endif
 #include "dwb.h"
@@ -290,7 +290,7 @@ struct pipe_ctx {
         struct pipe_ctx *next_odm_pipe;
         struct pipe_ctx *prev_odm_pipe;

-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         struct _vcs_dpi_display_dlg_regs_st dlg_regs;
         struct _vcs_dpi_display_ttu_regs_st ttu_regs;
         struct _vcs_dpi_display_rq_regs_st rq_regs;
@@ -368,7 +368,7 @@ struct dc_state {

         /* Note: these are big structures, do *not* put on stack! */
         struct dm_pp_display_configuration pp_display_cfg;
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0
+#ifdef CONFIG_DRM_AMD_DC_DCN
         struct dcn_bw_internal_vars dcn_bw_vars;
 #endif

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/=
amd/display/dc/inc/hw/dwb.h
index aed67754e81b..735f41901b88 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -54,7 +54,7 @@ enum dwb_source {
 /* DCN1.x, DCN2.x support 2 pipes */
 enum dwb_pipe {
         dwb_pipe0 =3D 0,
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
         dwb_pipe1,
 #endif
         dwb_pipe_max_num,
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/=
amd/display/dc/irq/Makefile
index c26300c3936d..0f682ac53bb2 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -60,7 +60,7 @@ AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCE12)
 ##########################################################################=
#####
 # DCN 1x
 ##########################################################################=
#####
-ifdef CONFIG_DRM_AMD_DC_DCN1_0
+ifdef CONFIG_DRM_AMD_DC_DCN
 IRQ_DCN1 =3D irq_service_dcn10.o

 AMD_DAL_IRQ_DCN1 =3D $(addprefix $(AMDDALPATH)/dc/irq/dcn10/,$(IRQ_DCN1))
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu=
/drm/amd/display/dc/irq/irq_service.c
index 0878550a8178..33053b9fe6bd 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -38,7 +38,7 @@
 #include "dce120/irq_service_dce120.h"


-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/irq_service_dcn10.h"
 #endif

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/am=
d/display/dc/os_types.h
index 30ec80ac6fc8..bf53f7bb140f 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -48,7 +48,7 @@

 #define dm_error(fmt, ...) DRM_ERROR(fmt, ##__VA_ARGS__)

-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include <asm/fpu/api.h>
 #endif

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6SPR00MB1823DB22084D7F576D6E021F7620BN6SPR00MB182namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Bhawanpreet Lakha &lt;Bhawanp=
reet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 1, 2019 2:05 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/display: rename DCN1_0 kconfig to DCN</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since dcn20 and dcn21 are under dcn1 it doesnt mak=
e sense to<br>
have it named dcn1.<br>
<br>
Change it to &quot;dcn&quot; to make it generic<br>
<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |&nbsp; 8 &#43;&#43;&#4=
3;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/display/dc/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;.../display/dc/bios/command_table_helper2.c&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/calcs/Makefile |&nbsp; 2 &#43;-<br>
&nbsp;.../gpu/drm/amd/display/dc/clk_mgr/Makefile&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;.../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 8 &#43;&#43;&#43;&#43;----<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_debug.c&nbsp;&nbsp;&nbsp; |&nbsp; =
2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c |&nbsp; 2 &#43;-<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_resource.c | 12 &#43;&#43;&#43;&#4=
3;&#43;------<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_stream.c&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;.../drm/amd/display/dc/dce/dce_clock_source.c |&nbsp; 2 &#43;-<br>
&nbsp;.../drm/amd/display/dc/dce/dce_clock_source.h |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 10 &#43;&#43;&#43;&#4=
3;&#43;-----<br>
&nbsp;.../amd/display/dc/dce/dce_stream_encoder.c&nbsp;&nbsp; | 20 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;.../display/dc/dce110/dce110_hw_sequencer.c&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;.../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;.../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/display/dc/dml/Makefile&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/display/dc/gpio/Makefile&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;.../gpu/drm/amd/display/dc/gpio/hw_factory.c&nbsp; |&nbsp; 4 &#43;&#4=
3;--<br>
&nbsp;.../drm/amd/display/dc/gpio/hw_translate.c&nbsp;&nbsp;&nbsp; |&nbsp; =
4 &#43;&#43;--<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/core_types.h&nbsp;&nbsp; |&nbsp; 6 &#4=
3;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/irq/Makefile&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;.../gpu/drm/amd/display/dc/irq/irq_service.c&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/display/dc/os_types.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;-<br>
&nbsp;29 files changed, 61 insertions(&#43;), 61 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig<br>
index b5a9bfe8998c..78f40690a109 100644<br>
--- a/drivers/gpu/drm/amd/display/Kconfig<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/Kconfig<br>
@@ -6,13 &#43;6,13 @@ config DRM_AMD_DC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;AMD DC - Enable=
 new display engine&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select SND_HDA_COMPONENT i=
f SND_HDA_CORE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select DRM_AMD_DC_DCN1_0 if X86 &amp;=
&amp; !(KCOV_INSTRUMENT_ALL &amp;&amp; KCOV_ENABLE_COMPARISONS)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select DRM_AMD_DC_DCN if X86 &amp=
;&amp; !(KCOV_INSTRUMENT_ALL &amp;&amp; KCOV_ENABLE_COMPARISONS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this op=
tion if you want to use the new display engine<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; support for AM=
DGPU. This adds required support for Vega and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Raven ASICs.<b=
r>
&nbsp;<br>
-config DRM_AMD_DC_DCN1_0<br>
&#43;config DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def_bool n<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Raven, Navi an=
d Renoir family support for display engine<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 441ad43ce9a9..72e7a1245bd8 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -72,7 &#43;72,7 @@<br>
&nbsp;#include &lt;drm/drm_audio_component.h&gt;<br>
&nbsp;#include &lt;drm/drm_hdcp.h&gt;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;ivsrcid/dcn/irqsrcs_dcn_1_0.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;dcn/dcn_1_0_offset.h&quot;<br>
@@ -1866,7 &#43;1866,7 @@ static int dce110_register_irq_handlers(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;/* Register IRQ sources and initialize IRQ callbacks */<br>
&nbsp;static int dcn10_register_irq_handlers(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
@@ -2455,7 &#43;2455,7 @@ static int amdgpu_dm_initialize_drm_device(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
fail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
@@ -2679,7 &#43;2679,7 @@ static int dm_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_hpd =3D 6;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_dig =3D 6;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_crtc =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_hpd =3D 4;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/=
display/dc/Makefile<br>
index 1feba4190284..ee9b83e5c51a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/Makefile<br>
@@ -25,7 &#43;25,7 @@<br>
&nbsp;<br>
&nbsp;DC_LIBS =3D basics bios calcs clk_mgr dce gpio irq virtual<br>
&nbsp;<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;DC_LIBS &#43;=3D dcn20<br>
&nbsp;DC_LIBS &#43;=3D dsc<br>
&nbsp;DC_LIBS &#43;=3D dcn10 dml<br>
@@ -50,7 &#43;50,7 @@ include $(AMD_DC)<br>
&nbsp;DISPLAY_CORE =3D dc.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_si=
nk.o \<br>
&nbsp;dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_=
stream.o<br>
&nbsp;<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;DISPLAY_CORE &#43;=3D dc_vm_helper.o<br>
&nbsp;endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/=
drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c<br>
index 47bb802b7164..7388c987c595 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2=
.c<br>
@@ -55,7 &#43;55,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_11_22:<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *h =3D dal_cmd_tbl_helper_dce112_get_table2();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_01:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *h =3D dal_cmd_tbl_helper_dce112_get_table2();<br>
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/dr=
m/amd/display/dc/calcs/Makefile<br>
index e59a7f356188..927e46075aa7 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
@@ -47,7 &#43;47,7 @@ CFLAGS_dcn_calc_math.o :=3D $(calcs_ccflags) -Wno-tau=
tological-compare<br>
&nbsp;<br>
&nbsp;BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o<br>
&nbsp;<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;BW_CALCS &#43;=3D dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o<br>
&nbsp;endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/=
drm/amd/display/dc/clk_mgr/Makefile<br>
index de01543f0161..3cd283195091 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile<br>
@@ -63,7 &#43;63,7 @@ CLK_MGR_DCE120 =3D dce120_clk_mgr.o<br>
&nbsp;AMD_DAL_CLK_MGR_DCE120 =3D $(addprefix $(AMDDALPATH)/dc/clk_mgr/dce12=
0/,$(CLK_MGR_DCE120))<br>
&nbsp;<br>
&nbsp;AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_CLK_MGR_DCE120)<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;#####################################################################=
##########<br>
&nbsp;# DCN10<br>
&nbsp;#####################################################################=
##########<br>
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
index 740d92bd4481..a7c4c1d1fc59 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
@@ -132,7 &#43;132,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context=
 *ctx, struct pp_smu_funcs *p<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce12=
0_clk_mgr_construct(ctx, clk_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_RV:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rn_cl=
k_mgr_construct(ctx, clk_mgr, pp_smu, dccg);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index 4d1a8f706633..a940ca7d59db 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -565,7 &#43;565,7 @@ static void destruct(struct dc *dc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dc-&gt;bw_dceip);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;bw_dceip =3D NULL;<=
br>
&nbsp;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dc-&gt;dcn_soc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dcn_soc =3D NULL;<b=
r>
&nbsp;<br>
@@ -584,7 &#43;584,7 @@ static bool construct(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *dc_ctx;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bw_calcs_dceip *dc_=
dceip;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bw_calcs_vbios *dc_=
vbios;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_soc_bounding_bo=
x *dcn_soc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_ip_params *dcn_=
ip;<br>
&nbsp;#endif<br>
@@ -616,7 &#43;616,7 @@ static bool construct(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;bw_vbios =3D dc_vbi=
os;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn_soc =3D kzalloc(sizeof=
(*dcn_soc), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dcn_soc) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm_error(&quot;%s: failed to create dcn_soc\n&quot;, =
__func__);<br>
@@ -1295,7 &#43;1295,7 @@ struct dc_state *dc_create_state(struct dc *dc)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * initialize and obt=
ain IP and SOC the base DML instance from DC is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * initially copied i=
nto every context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;context-&gt;bw=
_ctx.dml, &amp;dc-&gt;dml, sizeof(struct display_mode_lib));<br>
&nbsp;#endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/d=
rm/amd/display/dc/core/dc_debug.c<br>
index b9227d5de3a3..85a52a16295a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c<br>
@@ -347,7 &#43;347,7 @@ void context_clock_trace(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_state *context)<br>
&nbsp;{<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_LOGGER_INIT(dc-&gt;ctx-=
&gt;logger);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLOCK_TRACE(&quot;Current:=
 dispclk_khz:%d&nbsp; max_dppclk_khz:%d&nbsp; dcfclk_khz:%d\n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;dcfclk_deep_sleep_khz:%d&nbsp; fclk_khz:%d&nbsp; socclk_khz:%d\n&quot;,<br=
>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index eb6def649dec..0cc4bed0b983 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -2580,7 &#43;2580,7 @@ bool dc_link_setup_psr(struct dc_link *link,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psr_context-&gt;psr_level.=
u32all =3D 0;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*skip power down the sing=
le pipe since it blocks the cstate*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_RAVEN(link-=
&gt;ctx-&gt;asic_id.hw_internal_rev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psr_context-&gt;psr_level.bits.SKIP_CRTC_DISABLE =3D =
true;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c<br>
index 162e512831b7..89b5f86cd40b 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
@@ -46,7 &#43;46,7 @@<br>
&nbsp;#include &quot;dce100/dce100_resource.h&quot;<br>
&nbsp;#include &quot;dce110/dce110_resource.h&quot;<br>
&nbsp;#include &quot;dce112/dce112_resource.h&quot;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;dcn10/dcn10_resource.h&quot;<br>
&nbsp;#endif<br>
&nbsp;#include &quot;dcn20/dcn20_resource.h&quot;<br>
@@ -95,7 &#43;95,7 @@ enum dce_version resource_parse_asic_id(struct hw_asi=
c_id asic_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_ve=
rsion =3D DCE_VERSION_12_0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_RV:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc_version =3D DCN_VERSION_1_0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev))<br>
@@ -154,7 &#43;154,7 @@ struct resource_pool *dc_create_resource_pool(struc=
t dc&nbsp; *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data-&gt;num_virtual_links,=
 dc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_01:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; res_pool =3D dcn10_create_resource_pool(init_data, dc=
);<br>
@@ -1192,7 &#43;1192,7 @@ static struct pipe_ctx *acquire_free_pipe_for_hea=
d(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pool-&gt;funcs-&gt;=
acquire_idle_pipe_for_layer(context, pool, head_pipe-&gt;stream);<br>
&nbsp;}<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;static int acquire_first_split_pipe(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct resource_context *res_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct resource_pool *pool,<br>
@@ -1273,7 &#43;1273,7 @@ bool dc_add_plane_to_context(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; free_pipe =3D acquire_free_pipe_for_head(context, poo=
l, head_pipe);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN1_0)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!free_pipe) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int p=
ipe_idx =3D acquire_first_split_pipe(&amp;context-&gt;res_ctx, pool, stream=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p=
ipe_idx &gt;=3D 0)<br>
@@ -1947,7 &#43;1947,7 @@ enum dc_status resource_map_pool_resources(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* acquire new resources */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe_idx =3D acquire_first_free_pipe(&amp;context-&gt=
;res_ctx, pool, stream);<br>
&nbsp;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_idx &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe_idx =3D acquire_first_split_pipe(&amp;context-&g=
t;res_ctx, pool, stream);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_stream.c<br>
index dc05c14530b0..371d49e9b745 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c<br>
@@ -32,7 &#43;32,7 @@<br>
&nbsp;#include &quot;resource.h&quot;<br>
&nbsp;#include &quot;ipp.h&quot;<br>
&nbsp;#include &quot;timing_generator.h&quot;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;dcn10/dcn10_hw_sequencer.h&quot;<br>
&nbsp;#endif<br>
&nbsp;<br>
@@ -235,7 &#43;235,7 @@ struct dc_stream_status *dc_stream_get_status(<br>
&nbsp;<br>
&nbsp;static void delay_cursor_until_vupdate(struct pipe_ctx *pipe_ctx, str=
uct dc *dc)<br>
&nbsp;{<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vupdate_line;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int lines_to_vupd=
ate, us_to_vupdate, vpos, nvpos;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *st=
ream =3D pipe_ctx-&gt;stream;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index 290ee6b1cbed..98f55521ea8a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -488,7 &#43;488,7 @@ struct dc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Inputs into BW and WM c=
alculations. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bw_calcs_dceip *bw_=
dceip;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bw_calcs_vbios *bw_=
vbios;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_soc_bounding_bo=
x *dcn_soc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_ip_params *dcn_=
ip;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct display_mode_lib dm=
l;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
index 898decadb8e6..2e992fbc0d71 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
@@ -905,7 &#43;905,7 @@ static bool dce112_program_pix_clk(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce110_clk_src *clk=
_src =3D TO_DCE110_CLK_SRC(clock_source);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bp_pixel_clock_para=
meters bp_pc_params =3D {0};<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_FPGA_MAXIMUS_DC(clo=
ck_source-&gt;ctx-&gt;dce_environment)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned int inst =3D pix_clk_params-&gt;controller_i=
d - CONTROLLER_ID_D0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned dp_dto_ref_100hz =3D 7000000;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.h<br>
index 8d0d07db5190..51bd25079606 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h<br>
@@ -97,7 &#43;97,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CS_SF(PHYPLLA_PIXCLK_RESYN=
C_CNTL, PHYPLLA_DCCG_DEEP_COLOR_CNTL, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CS_SF(OTG0_PIXEL_RATE_CNTL=
, DP_DTO0_ENABLE, mask_sh)<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;<br>
&nbsp;#define CS_COMMON_REG_LIST_DCN1_0(index, pllid) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/dr=
m/amd/display/dc/dce/dce_dmcu.c<br>
index d01fb2f55535..e619e67e6b51 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c<br>
@@ -324,7 &#43;324,7 @@ static void dce_get_psr_wait_loop(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;}<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;static void dcn10_get_dmcu_version(struct dmcu *dmcu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_dmcu *dmcu_dce =
=3D TO_DCE_DMCU(dmcu);<br>
@@ -794,7 &#43;794,7 @@ static bool dcn20_unlock_phy(struct dmcu *dmcu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
-#endif //(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#endif //(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;<br>
&nbsp;static const struct dmcu_funcs dce_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmcu_init =3D dce_dmcu_in=
it,<br>
@@ -807,7 &#43;807,7 @@ static const struct dmcu_funcs dce_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dmcu_initialized =3D d=
ce_is_dmcu_initialized<br>
&nbsp;};<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;static const struct dmcu_funcs dcn10_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmcu_init =3D dcn10_dmcu_=
init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_iram =3D dcn10_dmcu_=
load_iram,<br>
@@ -864,7 &#43;864,7 @@ static void dce_dmcu_construct(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmcu_dce-&gt;dmcu_mask =3D=
 dmcu_mask;<br>
&nbsp;}<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;static void dcn21_dmcu_construct(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dce_dmcu *dmcu_dce,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
@@ -905,7 &#43;905,7 @@ struct dmcu *dce_dmcu_create(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;dmcu_dce-&gt;b=
ase;<br>
&nbsp;}<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;struct dmcu *dcn10_dmcu_create(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dce_dmcu_regi=
sters *regs,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<br>
index 2baaac1e5156..451574971b96 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<b=
r>
@@ -137,7 &#43;137,7 @@ static void dce110_update_generic_info_packet(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AFMT_=
GENERIC0_UPDATE, (packet_index =3D=3D 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AFMT_=
GENERIC2_UPDATE, (packet_index =3D=3D 2));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG(AFMT_VBI_PACKET_CO=
NTROL1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (packet_index) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0:<br>
@@ -231,7 &#43;231,7 @@ static void dce110_update_hdmi_info_packet(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDMI_GENERIC1_SEND, send,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDMI_GENERIC1_LINE, line);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (REG(HDMI_GENERIC_PACKET_CONTROL2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_U=
PDATE_3(HDMI_GENERIC_PACKET_CONTROL2,<br>
@@ -278,7 &#43;278,7 @@ static void dce110_stream_encoder_dp_set_stream_att=
ribute(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_vsc_sdp_for_color=
imetry,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t enable_sdp_splitt=
ing)<br>
&nbsp;{<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t h_active_start;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t v_active_start;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t misc0 =3D 0;<br>
@@ -330,7 &#43;330,7 @@ static void dce110_stream_encoder_dp_set_stream_att=
ribute(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (enc110-&gt;se_mask-&gt;DP_VID_M_DOUBLE_VALUE_EN)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_U=
PDATE(DP_VID_TIMING, DP_VID_M_DOUBLE_VALUE_EN, 1);<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (enc110-&gt;se_mask-&gt;DP_VID_N_MUL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_U=
PDATE(DP_VID_TIMING, DP_VID_N_MUL, 1);<br>
&nbsp;#endif<br>
@@ -341,7 &#43;341,7 @@ static void dce110_stream_encoder_dp_set_stream_att=
ribute(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG(DP_MSA_MISC))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; misc1 =3D REG_READ(DP_MSA_MISC);<br>
&nbsp;#endif<br>
@@ -375,7 &#43;375,7 @@ static void dce110_stream_encoder_dp_set_stream_att=
ribute(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set dynamic range and Y=
CbCr range */<br>
&nbsp;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (hw_crtc_timing.dis=
play_color_depth) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COLOR_DEPTH_666:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; colorimetry_bpc =3D 0;<br>
@@ -455,7 &#43;455,7 @@ static void dce110_stream_encoder_dp_set_stream_att=
ribute(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DP_DYN_RANGE, dynamic_range_rgb,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DP_YCBCR_RANGE, dynamic_range_yc=
bcr);<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (REG(DP_MSA_COLORIMETRY))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_S=
ET(DP_MSA_COLORIMETRY, 0, DP_MSA_MISC0, misc0);<br>
&nbsp;<br>
@@ -490,7 &#43;490,7 @@ static void dce110_stream_encoder_dp_set_stream_att=
ribute(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_crtc_timing.v_front_porch;<br=
>
&nbsp;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* start at begining of left border */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (REG(DP_MSA_TIMING_PARAM2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_S=
ET_2(DP_MSA_TIMING_PARAM2, 0,<br>
@@ -787,7 &#43;787,7 @@ static void dce110_stream_encoder_update_hdmi_info_=
packets(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dce110_update_hdmi_info_packet(enc110, 3, &amp;info_f=
rame-&gt;hdrsmd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enc110-&gt;se_mask-&gt=
;HDMI_DB_DISABLE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* for bring up, disable dp double&nbsp; TODO */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (REG(HDMI_DB_CONTROL))<br>
@@ -825,7 &#43;825,7 @@ static void dce110_stream_encoder_stop_hdmi_info_pa=
ckets(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; HDMI_GENERIC1_LINE, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; HDMI_GENERIC1_SEND, 0);<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop generic packets 2 =
&amp; 3 on HDMI */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG(HDMI_GENERIC_PACKE=
T_CONTROL2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; REG_SET_6(HDMI_GENERIC_PACKET_CONTROL2, 0,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
index 811896a43b67..3f5fbad587e7 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer=
.c<br>
@@ -1223,7 &#43;1223,7 @@ static void program_scaler(const struct dc *dc,<b=
r>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tg_color color =3D =
{0};<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TOFPGA */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;plane_res=
.xfm-&gt;funcs-&gt;transform_set_pixel_storage_depth =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c b/drivers/gpu=
/drm/amd/display/dc/dcn10/dcn10_dwb.c<br>
index 64b31edc8cf6..b6391a5ead78 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c<br>
@@ -23,7 &#43;23,7 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;<br>
&nbsp;#include &quot;reg_helper.h&quot;<br>
&nbsp;#include &quot;resource.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h b/drivers/gpu=
/drm/amd/display/dc/dcn10/dcn10_dwb.h<br>
index c175edd0bae7..d56ea7c8171e 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h<br>
@@ -24,7 &#43;24,7 @@<br>
&nbsp;#ifndef __DC_DWBC_DCN10_H__<br>
&nbsp;#define __DC_DWBC_DCN10_H__<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;<br>
&nbsp;/* DCN */<br>
&nbsp;#define BASE_INNER(seg) \<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/=
amd/display/dc/dml/Makefile<br>
index 58c9eb1b6a06..e4da4df9cd11 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
@@ -43,7 &#43;43,7 @@ endif<br>
&nbsp;<br>
&nbsp;CFLAGS_display_mode_lib.o :=3D $(dml_ccflags)<br>
&nbsp;<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;CFLAGS_display_mode_vba.o :=3D $(dml_ccflags)<br>
&nbsp;CFLAGS_display_mode_vba_20.o :=3D $(dml_ccflags)<br>
&nbsp;CFLAGS_display_rq_dlg_calc_20.o :=3D $(dml_ccflags)<br>
@@ -62,7 &#43;62,7 @@ CFLAGS_dml_common_defs.o :=3D $(dml_ccflags)<br>
&nbsp;DML =3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_d=
lg_calc.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_common_defs.o<br>
&nbsp;<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;DML &#43;=3D display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/=
display_mode_vba_20.o<br>
&nbsp;DML &#43;=3D dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_=
20v2.o<br>
&nbsp;DML &#43;=3D dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21=
.o<br>
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm=
/amd/display/dc/gpio/Makefile<br>
index 013cfac4ff55..202baa210cc8 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/gpio/Makefile<br>
@@ -61,7 &#43;61,7 @@ AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_GPIO_DCE120)<br>
&nbsp;#####################################################################=
##########<br>
&nbsp;# DCN 1x<br>
&nbsp;#####################################################################=
##########<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;GPIO_DCN10 =3D hw_translate_dcn10.o hw_factory_dcn10.o<br>
&nbsp;<br>
&nbsp;AMD_DAL_GPIO_DCN10 =3D $(addprefix $(AMDDALPATH)/dc/gpio/dcn10/,$(GPI=
O_DCN10))<br>
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu=
/drm/amd/display/dc/gpio/hw_factory.c<br>
index fb2d66729ca3..d2d36d48caaa 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c<br>
@@ -45,7 &#43;45,7 @@<br>
&nbsp;#include &quot;dce80/hw_factory_dce80.h&quot;<br>
&nbsp;#include &quot;dce110/hw_factory_dce110.h&quot;<br>
&nbsp;#include &quot;dce120/hw_factory_dce120.h&quot;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;dcn10/hw_factory_dcn10.h&quot;<br>
&nbsp;#endif<br>
&nbsp;#include &quot;dcn20/hw_factory_dcn20.h&quot;<br>
@@ -86,7 &#43;86,7 @@ bool dal_hw_factory_init(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_12_1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dal_hw_factory_dce120_init(factory);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_01:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dal_hw_factory_dcn10_init(factory);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/g=
pu/drm/amd/display/dc/gpio/hw_translate.c<br>
index 55acfda9ea63..5d396657a1ee 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c<br>
@@ -43,7 &#43;43,7 @@<br>
&nbsp;#include &quot;dce80/hw_translate_dce80.h&quot;<br>
&nbsp;#include &quot;dce110/hw_translate_dce110.h&quot;<br>
&nbsp;#include &quot;dce120/hw_translate_dce120.h&quot;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;dcn10/hw_translate_dcn10.h&quot;<br>
&nbsp;#endif<br>
&nbsp;#include &quot;dcn20/hw_translate_dcn20.h&quot;<br>
@@ -81,7 &#43;81,7 @@ bool dal_hw_translate_init(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_12_1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dal_hw_translate_dce120_init(translate);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_01:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dal_hw_translate_dcn10_init(translate);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h<br>
index c98d887cc6e2..e0aac234537f 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
@@ -33,7 &#43;33,7 @@<br>
&nbsp;#include &quot;dc_bios_types.h&quot;<br>
&nbsp;#include &quot;mem_input.h&quot;<br>
&nbsp;#include &quot;hubp.h&quot;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;mpc.h&quot;<br>
&nbsp;#endif<br>
&nbsp;#include &quot;dwb.h&quot;<br>
@@ -290,7 &#43;290,7 @@ struct pipe_ctx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *next_odm_=
pipe;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *prev_odm_=
pipe;<br>
&nbsp;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct _vcs_dpi_display_dl=
g_regs_st dlg_regs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct _vcs_dpi_display_tt=
u_regs_st ttu_regs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct _vcs_dpi_display_rq=
_regs_st rq_regs;<br>
@@ -368,7 &#43;368,7 @@ struct dc_state {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Note: these are big str=
uctures, do *not* put on stack! */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_pp_display_confi=
guration pp_display_cfg;<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_bw_internal_var=
s dcn_bw_vars;<br>
&nbsp;#endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/=
amd/display/dc/inc/hw/dwb.h<br>
index aed67754e81b..735f41901b88 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h<br>
@@ -54,7 &#43;54,7 @@ enum dwb_source {<br>
&nbsp;/* DCN1.x, DCN2.x support 2 pipes */<br>
&nbsp;enum dwb_pipe {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwb_pipe0 =3D 0,<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwb_pipe1,<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwb_pipe_max_num,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/=
amd/display/dc/irq/Makefile<br>
index c26300c3936d..0f682ac53bb2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/irq/Makefile<br>
@@ -60,7 &#43;60,7 @@ AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_IRQ_DCE12)<br>
&nbsp;#####################################################################=
##########<br>
&nbsp;# DCN 1x<br>
&nbsp;#####################################################################=
##########<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&#43;ifdef CONFIG_DRM_AMD_DC_DCN<br>
&nbsp;IRQ_DCN1 =3D irq_service_dcn10.o<br>
&nbsp;<br>
&nbsp;AMD_DAL_IRQ_DCN1 =3D $(addprefix $(AMDDALPATH)/dc/irq/dcn10/,$(IRQ_DC=
N1))<br>
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu=
/drm/amd/display/dc/irq/irq_service.c<br>
index 0878550a8178..33053b9fe6bd 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c<br>
@@ -38,7 &#43;38,7 @@<br>
&nbsp;#include &quot;dce120/irq_service_dce120.h&quot;<br>
&nbsp;<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;dcn10/irq_service_dcn10.h&quot;<br>
&nbsp;#endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/am=
d/display/dc/os_types.h<br>
index 30ec80ac6fc8..bf53f7bb140f 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/os_types.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/os_types.h<br>
@@ -48,7 &#43;48,7 @@<br>
&nbsp;<br>
&nbsp;#define dm_error(fmt, ...) DRM_ERROR(fmt, ##__VA_ARGS__)<br>
&nbsp;<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &lt;asm/fpu/api.h&gt;<br>
&nbsp;#endif<br>
&nbsp;<br>
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

--_000_BN6SPR00MB1823DB22084D7F576D6E021F7620BN6SPR00MB182namp_--

--===============0286138176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0286138176==--
