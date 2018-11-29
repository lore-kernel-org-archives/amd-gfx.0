From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 09/16] drm/amd/display: fbc state could not reach while
 enable fbc
Date: Thu, 29 Nov 2018 16:27:12 +0000
Message-ID: <BN6PR12MB18092FE3F45C1039E19F2F5AF7D20@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1543506743-4674-1-git-send-email-sunpeng.li@amd.com>,
 <1543506743-4674-10-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082952222=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543506743-4674-10-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>

--===============0082952222==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18092FE3F45C1039E19F2F5AF7D20BN6PR12MB1809namp_"

--_000_BN6PR12MB18092FE3F45C1039E19F2F5AF7D20BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Do you think this will fix this bug?

https://bugs.freedesktop.org/show_bug.cgi?id=3D108577

If so, we can re-enable fbc.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of sunpeng.=
li-5C7GfCeVMHo@public.gmane.org <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, November 29, 2018 10:52:16 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wu, Hersen
Subject: [PATCH 09/16] drm/amd/display: fbc state could not reach while ena=
ble fbc

From: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>

   [WHY] fbc is within the data path from memory to dce. while
   re-configure mc dmif, fbc should be enabled. otherwise, fbc
   may not be enabled properly.

   [HOW] before re-configure mc dmif, disable fbc, only after
   dmif re-configuration fully done, enable fbc again.

Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>
Acked-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/display/dc/dce110/dce110_compressor.c  | 91 ++++++++----------=
----
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    | 57 ++++++++------
 drivers/gpu/drm/amd/display/dc/inc/compressor.h    |  1 +
 3 files changed, 66 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/dr=
ivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index 1f7f250..52d50e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -64,65 +64,37 @@ static const struct dce110_compressor_reg_offsets reg_o=
ffsets[] =3D {

 static const uint32_t dce11_one_lpt_channel_max_resolution =3D 2560 * 1600=
;

-enum fbc_idle_force {
-       /* Bit 0 - Display registers updated */
-       FBC_IDLE_FORCE_DISPLAY_REGISTER_UPDATE =3D 0x00000001,
-
-       /* Bit 2 - FBC_GRPH_COMP_EN register updated */
-       FBC_IDLE_FORCE_GRPH_COMP_EN =3D 0x00000002,
-       /* Bit 3 - FBC_SRC_SEL register updated */
-       FBC_IDLE_FORCE_SRC_SEL_CHANGE =3D 0x00000004,
-       /* Bit 4 - FBC_MIN_COMPRESSION register updated */
-       FBC_IDLE_FORCE_MIN_COMPRESSION_CHANGE =3D 0x00000008,
-       /* Bit 5 - FBC_ALPHA_COMP_EN register updated */
-       FBC_IDLE_FORCE_ALPHA_COMP_EN =3D 0x00000010,
-       /* Bit 6 - FBC_ZERO_ALPHA_CHUNK_SKIP_EN register updated */
-       FBC_IDLE_FORCE_ZERO_ALPHA_CHUNK_SKIP_EN =3D 0x00000020,
-       /* Bit 7 - FBC_FORCE_COPY_TO_COMP_BUF register updated */
-       FBC_IDLE_FORCE_FORCE_COPY_TO_COMP_BUF =3D 0x00000040,
-
-       /* Bit 24 - Memory write to region 0 defined by MC registers. */
-       FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION0 =3D 0x01000000,
-       /* Bit 25 - Memory write to region 1 defined by MC registers */
-       FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION1 =3D 0x02000000,
-       /* Bit 26 - Memory write to region 2 defined by MC registers */
-       FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION2 =3D 0x04000000,
-       /* Bit 27 - Memory write to region 3 defined by MC registers. */
-       FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION3 =3D 0x08000000,
-
-       /* Bit 28 - Memory write from any client other than MCIF */
-       FBC_IDLE_FORCE_MEMORY_WRITE_OTHER_THAN_MCIF =3D 0x10000000,
-       /* Bit 29 - CG statics screen signal is inactive */
-       FBC_IDLE_FORCE_CG_STATIC_SCREEN_IS_INACTIVE =3D 0x20000000,
-};
-
-
 static uint32_t align_to_chunks_number_per_line(uint32_t pixels)
 {
         return 256 * ((pixels + 255) / 256);
 }

-static void reset_lb_on_vblank(struct dc_context *ctx)
+static void reset_lb_on_vblank(struct compressor *compressor, uint32_t crt=
c_inst)
 {
-       uint32_t value, frame_count;
+       uint32_t value;
+       uint32_t frame_count;
+       uint32_t status_pos;
         uint32_t retry =3D 0;
-       uint32_t status_pos =3D
-                       dm_read_reg(ctx, mmCRTC_STATUS_POSITION);
+       struct dce110_compressor *cp110 =3D TO_DCE110_COMPRESSOR(compressor=
);
+
+       cp110->offsets =3D reg_offsets[crtc_inst];
+
+       status_pos =3D dm_read_reg(compressor->ctx, DCP_REG(mmCRTC_STATUS_P=
OSITION));


         /* Only if CRTC is enabled and counter is moving we wait for one f=
rame. */
-       if (status_pos !=3D dm_read_reg(ctx, mmCRTC_STATUS_POSITION)) {
+       if (status_pos !=3D dm_read_reg(compressor->ctx, DCP_REG(mmCRTC_STA=
TUS_POSITION))) {
                 /* Resetting LB on VBlank */
-               value =3D dm_read_reg(ctx, mmLB_SYNC_RESET_SEL);
+               value =3D dm_read_reg(compressor->ctx, DCP_REG(mmLB_SYNC_RE=
SET_SEL));
                 set_reg_field_value(value, 3, LB_SYNC_RESET_SEL, LB_SYNC_R=
ESET_SEL);
                 set_reg_field_value(value, 1, LB_SYNC_RESET_SEL, LB_SYNC_R=
ESET_SEL2);
-               dm_write_reg(ctx, mmLB_SYNC_RESET_SEL, value);
+               dm_write_reg(compressor->ctx, DCP_REG(mmLB_SYNC_RESET_SEL),=
 value);

-               frame_count =3D dm_read_reg(ctx, mmCRTC_STATUS_FRAME_COUNT)=
;
+               frame_count =3D dm_read_reg(compressor->ctx, DCP_REG(mmCRTC=
_STATUS_FRAME_COUNT));


                 for (retry =3D 10000; retry > 0; retry--) {
-                       if (frame_count !=3D dm_read_reg(ctx, mmCRTC_STATUS=
_FRAME_COUNT))
+                       if (frame_count !=3D dm_read_reg(compressor->ctx, D=
CP_REG(mmCRTC_STATUS_FRAME_COUNT)))
                                 break;
                         udelay(10);
                 }
@@ -130,13 +102,11 @@ static void reset_lb_on_vblank(struct dc_context *ctx=
)
                         dm_error("Frame count did not increase for 100ms.\=
n");

                 /* Resetting LB on VBlank */
-               value =3D dm_read_reg(ctx, mmLB_SYNC_RESET_SEL);
+               value =3D dm_read_reg(compressor->ctx, DCP_REG(mmLB_SYNC_RE=
SET_SEL));
                 set_reg_field_value(value, 2, LB_SYNC_RESET_SEL, LB_SYNC_R=
ESET_SEL);
                 set_reg_field_value(value, 0, LB_SYNC_RESET_SEL, LB_SYNC_R=
ESET_SEL2);
-               dm_write_reg(ctx, mmLB_SYNC_RESET_SEL, value);
-
+               dm_write_reg(compressor->ctx, DCP_REG(mmLB_SYNC_RESET_SEL),=
 value);
         }
-
 }

 static void wait_for_fbc_state_changed(
@@ -226,10 +196,10 @@ void dce110_compressor_enable_fbc(
                 uint32_t addr;
                 uint32_t value, misc_value;

-
                 addr =3D mmFBC_CNTL;
                 value =3D dm_read_reg(compressor->ctx, addr);
                 set_reg_field_value(value, 1, FBC_CNTL, FBC_GRPH_COMP_EN);
+               /* params->inst is valid HW CRTC instance start from 0 */
                 set_reg_field_value(
                         value,
                         params->inst,
@@ -238,8 +208,10 @@ void dce110_compressor_enable_fbc(

                 /* Keep track of enum controller_id FBC is attached to */
                 compressor->is_enabled =3D true;
-               compressor->attached_inst =3D params->inst;
-               cp110->offsets =3D reg_offsets[params->inst];
+               /* attached_inst is SW CRTC instance start from 1
+                * 0 =3D CONTROLLER_ID_UNDEFINED means not attached crtc
+                */
+               compressor->attached_inst =3D params->inst + CONTROLLER_ID_=
D0;

                 /* Toggle it as there is bug in HW */
                 set_reg_field_value(value, 0, FBC_CNTL, FBC_GRPH_COMP_EN);
@@ -268,9 +240,10 @@ void dce110_compressor_enable_fbc(
 void dce110_compressor_disable_fbc(struct compressor *compressor)
 {
         struct dce110_compressor *cp110 =3D TO_DCE110_COMPRESSOR(compresso=
r);
+       uint32_t crtc_inst =3D 0;

         if (compressor->options.bits.FBC_SUPPORT) {
-               if (dce110_compressor_is_fbc_enabled_in_hw(compressor, NULL=
)) {
+               if (dce110_compressor_is_fbc_enabled_in_hw(compressor, &crt=
c_inst)) {
                         uint32_t reg_data;
                         /* Turn off compression */
                         reg_data =3D dm_read_reg(compressor->ctx, mmFBC_CN=
TL);
@@ -284,8 +257,10 @@ void dce110_compressor_disable_fbc(struct compressor *=
compressor)
                         wait_for_fbc_state_changed(cp110, false);
                 }

-               /* Sync line buffer  - dce100/110 only*/
-               reset_lb_on_vblank(compressor->ctx);
+               /* Sync line buffer which fbc was attached to dce100/110 on=
ly */
+               if (crtc_inst > CONTROLLER_ID_UNDEFINED && crtc_inst < CONT=
ROLLER_ID_D3)
+                       reset_lb_on_vblank(compressor,
+                                       crtc_inst - CONTROLLER_ID_D0);
         }
 }

@@ -328,6 +303,8 @@ void dce110_compressor_program_compressed_surface_addre=
ss_and_pitch(
         uint32_t compressed_surf_address_low_part =3D
                 compressor->compr_surface_address.addr.low_part;

+       cp110->offsets =3D reg_offsets[params->inst];
+
         /* Clear content first. */
         dm_write_reg(
                 compressor->ctx,
@@ -410,13 +387,7 @@ void dce110_compressor_set_fbc_invalidation_triggers(
         value =3D dm_read_reg(compressor->ctx, addr);
         set_reg_field_value(
                 value,
-               fbc_trigger |
-               FBC_IDLE_FORCE_GRPH_COMP_EN |
-               FBC_IDLE_FORCE_SRC_SEL_CHANGE |
-               FBC_IDLE_FORCE_MIN_COMPRESSION_CHANGE |
-               FBC_IDLE_FORCE_ALPHA_COMP_EN |
-               FBC_IDLE_FORCE_ZERO_ALPHA_CHUNK_SKIP_EN |
-               FBC_IDLE_FORCE_FORCE_COPY_TO_COMP_BUF,
+               fbc_trigger,
                 FBC_IDLE_FORCE_CLEAR_MASK,
                 FBC_IDLE_FORCE_CLEAR_MASK);
         dm_write_reg(compressor->ctx, addr, value);
@@ -549,7 +520,7 @@ void dce110_compressor_construct(struct dce110_compress=
or *compressor,
         compressor->base.channel_interleave_size =3D 0;
         compressor->base.dram_channels_num =3D 0;
         compressor->base.lpt_channels_num =3D 0;
-       compressor->base.attached_inst =3D 0;
+       compressor->base.attached_inst =3D CONTROLLER_ID_UNDEFINED;
         compressor->base.is_enabled =3D false;
         compressor->base.funcs =3D &dce110_compressor_funcs;

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 2f062ba..6349ba7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1766,12 +1766,13 @@ static void set_static_screen_control(struct pipe_c=
tx **pipe_ctx,
  *  Check if FBC can be enabled
  */
 static bool should_enable_fbc(struct dc *dc,
-                             struct dc_state *context,
-                             uint32_t *pipe_idx)
+               struct dc_state *context,
+               uint32_t *pipe_idx)
 {
         uint32_t i;
         struct pipe_ctx *pipe_ctx =3D NULL;
         struct resource_context *res_ctx =3D &context->res_ctx;
+       unsigned int underlay_idx =3D dc->res_pool->underlay_pipe_index;


         ASSERT(dc->fbc_compressor);
@@ -1786,14 +1787,28 @@ static bool should_enable_fbc(struct dc *dc,

         for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
                 if (res_ctx->pipe_ctx[i].stream) {
+
                         pipe_ctx =3D &res_ctx->pipe_ctx[i];
-                       *pipe_idx =3D i;
-                       break;
+
+                       if (!pipe_ctx)
+                               continue;
+
+                       /* fbc not applicable on underlay pipe */
+                       if (pipe_ctx->pipe_idx !=3D underlay_idx) {
+                               *pipe_idx =3D i;
+                               break;
+                       }
                 }
         }

-       /* Pipe context should be found */
-       ASSERT(pipe_ctx);
+       if (i =3D=3D dc->res_pool->pipe_count)
+               return false;
+
+       if (!pipe_ctx->stream->sink)
+               return false;
+
+       if (!pipe_ctx->stream->sink->link)
+               return false;

         /* Only supports eDP */
         if (pipe_ctx->stream->sink->link->connector_signal !=3D SIGNAL_TYP=
E_EDP)
@@ -1817,8 +1832,9 @@ static bool should_enable_fbc(struct dc *dc,
 /*
  *  Enable FBC
  */
-static void enable_fbc(struct dc *dc,
-                      struct dc_state *context)
+static void enable_fbc(
+               struct dc *dc,
+               struct dc_state *context)
 {
         uint32_t pipe_idx =3D 0;

@@ -1828,10 +1844,9 @@ static void enable_fbc(struct dc *dc,
                 struct compressor *compr =3D dc->fbc_compressor;
                 struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[p=
ipe_idx];

-
                 params.source_view_width =3D pipe_ctx->stream->timing.h_ad=
dressable;
                 params.source_view_height =3D pipe_ctx->stream->timing.v_a=
ddressable;
-
+               params.inst =3D pipe_ctx->stream_res.tg->inst;
                 compr->compr_surface_address.quad_part =3D dc->ctx->fbc_gp=
u_addr;

                 compr->funcs->surface_address_and_pitch(compr, &params);
@@ -2046,10 +2061,10 @@ enum dc_status dce110_apply_ctx_to_hw(
                         return status;
         }

-       dcb->funcs->set_scratch_critical_state(dcb, false);
-
         if (dc->fbc_compressor)
-               enable_fbc(dc, context);
+               enable_fbc(dc, dc->current_state);
+
+       dcb->funcs->set_scratch_critical_state(dcb, false);

         return DC_OK;
 }
@@ -2408,7 +2423,6 @@ static void dce110_program_front_end_for_pipe(
         struct dc_plane_state *plane_state =3D pipe_ctx->plane_state;
         struct xfm_grph_csc_adjustment adjust;
         struct out_csc_color_matrix tbl_entry;
-       unsigned int underlay_idx =3D dc->res_pool->underlay_pipe_index;
         unsigned int i;
         DC_LOGGER_INIT();
         memset(&tbl_entry, 0, sizeof(tbl_entry));
@@ -2449,15 +2463,6 @@ static void dce110_program_front_end_for_pipe(

         program_scaler(dc, pipe_ctx);

-       /* fbc not applicable on Underlay pipe */
-       if (dc->fbc_compressor && old_pipe->stream &&
-           pipe_ctx->pipe_idx !=3D underlay_idx) {
-               if (plane_state->tiling_info.gfx8.array_mode =3D=3D DC_ARRA=
Y_LINEAR_GENERAL)
-                       dc->fbc_compressor->funcs->disable_fbc(dc->fbc_comp=
ressor);
-               else
-                       enable_fbc(dc, dc->current_state);
-       }
-
         mi->funcs->mem_input_program_surface_config(
                         mi,
                         plane_state->format,
@@ -2534,6 +2539,9 @@ static void dce110_apply_ctx_for_surface(
         if (num_planes =3D=3D 0)
                 return;

+       if (dc->fbc_compressor)
+               dc->fbc_compressor->funcs->disable_fbc(dc->fbc_compressor);
+
         for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
                 struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[i=
];
                 struct pipe_ctx *old_pipe_ctx =3D &dc->current_state->res_=
ctx.pipe_ctx[i];
@@ -2576,6 +2584,9 @@ static void dce110_apply_ctx_for_surface(
                         (pipe_ctx->plane_state || old_pipe_ctx->plane_stat=
e))
                         dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
         }
+
+       if (dc->fbc_compressor)
+               enable_fbc(dc, dc->current_state);
 }

 static void dce110_power_down_fe(struct dc *dc, struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/compressor.h b/drivers/gpu/=
drm/amd/display/dc/inc/compressor.h
index bcb18f5..7a147a9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/compressor.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/compressor.h
@@ -77,6 +77,7 @@ struct compressor_funcs {
 };
 struct compressor {
         struct dc_context *ctx;
+       /* CONTROLLER_ID_D0 + instance, CONTROLLER_ID_UNDEFINED =3D 0 */
         uint32_t attached_inst;
         bool is_enabled;
         const struct compressor_funcs *funcs;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18092FE3F45C1039E19F2F5AF7D20BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Do you think this will fix this b=
ug?</p>
<p style=3D"margin-top:0;margin-bottom:0"><a href=3D"https://bugs.freedeskt=
op.org/show_bug.cgi?id=3D108577" class=3D"OWAAutoLink" id=3D"LPlnk860565" p=
reviewremoved=3D"true">https://bugs.freedesktop.org/show_bug.cgi?id=3D10857=
7</a></p>
<p style=3D"margin-top:0;margin-bottom:0">If so, we can re-enable fbc.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of sunpeng.li-5C7GfCeVMHo@public.gmane.org &lt;sunpen=
g.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, November 29, 2018 10:52:16 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wu, Hersen<br>
<b>Subject:</b> [PATCH 09/16] drm/amd/display: fbc state could not reach wh=
ile enable fbc</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&nbsp;&nbsp; [WHY] fbc is within the data path from memory to dce. while<br=
>
&nbsp;&nbsp; re-configure mc dmif, fbc should be enabled. otherwise, fbc<br=
>
&nbsp;&nbsp; may not be enabled properly.<br>
<br>
&nbsp;&nbsp; [HOW] before re-configure mc dmif, disable fbc, only after<br>
&nbsp;&nbsp; dmif re-configuration fully done, enable fbc again.<br>
<br>
Signed-off-by: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Roman Li &lt;Roman.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/display/dc/dce110/dce110_compressor.c&nbsp; | 91 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;--------------<br>
&nbsp;.../amd/display/dc/dce110/dce110_hw_sequencer.c&nbsp;&nbsp;&nbsp; | 5=
7 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/compressor.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 1 &#43;<br>
&nbsp;3 files changed, 66 insertions(&#43;), 83 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/dr=
ivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c<br>
index 1f7f250..52d50e2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c=
<br>
@@ -64,65 &#43;64,37 @@ static const struct dce110_compressor_reg_offsets r=
eg_offsets[] =3D {<br>
&nbsp;<br>
&nbsp;static const uint32_t dce11_one_lpt_channel_max_resolution =3D 2560 *=
 1600;<br>
&nbsp;<br>
-enum fbc_idle_force {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 0 - Display registers updated =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_DISPLAY_REGISTER_UPDAT=
E =3D 0x00000001,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 2 - FBC_GRPH_COMP_EN register =
updated */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_GRPH_COMP_EN =3D 0x000=
00002,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 3 - FBC_SRC_SEL register updat=
ed */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_SRC_SEL_CHANGE =3D 0x0=
0000004,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 4 - FBC_MIN_COMPRESSION regist=
er updated */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_MIN_COMPRESSION_CHANGE=
 =3D 0x00000008,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 5 - FBC_ALPHA_COMP_EN register=
 updated */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_ALPHA_COMP_EN =3D 0x00=
000010,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 6 - FBC_ZERO_ALPHA_CHUNK_SKIP_=
EN register updated */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_ZERO_ALPHA_CHUNK_SKIP_=
EN =3D 0x00000020,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 7 - FBC_FORCE_COPY_TO_COMP_BUF=
 register updated */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_FORCE_COPY_TO_COMP_BUF=
 =3D 0x00000040,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 24 - Memory write to region 0 =
defined by MC registers. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION=
0 =3D 0x01000000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 25 - Memory write to region 1 =
defined by MC registers */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION=
1 =3D 0x02000000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 26 - Memory write to region 2 =
defined by MC registers */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION=
2 =3D 0x04000000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 27 - Memory write to region 3 =
defined by MC registers. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_MEMORY_WRITE_TO_REGION=
3 =3D 0x08000000,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 28 - Memory write from any cli=
ent other than MCIF */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_MEMORY_WRITE_OTHER_THA=
N_MCIF =3D 0x10000000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 29 - CG statics screen signal =
is inactive */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_CG_STATIC_SCREEN_IS_IN=
ACTIVE =3D 0x20000000,<br>
-};<br>
-<br>
-<br>
&nbsp;static uint32_t align_to_chunks_number_per_line(uint32_t pixels)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 256 * ((pixels &#43=
; 255) / 256);<br>
&nbsp;}<br>
&nbsp;<br>
-static void reset_lb_on_vblank(struct dc_context *ctx)<br>
&#43;static void reset_lb_on_vblank(struct compressor *compressor, uint32_t=
 crtc_inst)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value, frame_count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t frame_count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status_pos;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retry =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status_pos =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_read_reg(ctx,=
 mmCRTC_STATUS_POSITION);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce110_compressor *cp110 =
=3D TO_DCE110_COMPRESSOR(compressor);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp110-&gt;offsets =3D reg_offsets=
[crtc_inst];<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status_pos =3D dm_read_reg(compre=
ssor-&gt;ctx, DCP_REG(mmCRTC_STATUS_POSITION));<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only if CRTC is enabled=
 and counter is moving we wait for one frame. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status_pos !=3D dm_read_reg(ctx, =
mmCRTC_STATUS_POSITION)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status_pos !=3D dm_read_reg(c=
ompressor-&gt;ctx, DCP_REG(mmCRTC_STATUS_POSITION))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Resetting LB on VBlank */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D dm_read_reg(ctx, mmLB_SYNC_RESET_SEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; value =3D dm_read_reg(compressor-&gt;ctx, DCP_REG(mmLB_SYNC_=
RESET_SEL));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(value, 3, LB_SYNC_RESET_SEL, LB_S=
YNC_RESET_SEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(value, 1, LB_SYNC_RESET_SEL, LB_S=
YNC_RESET_SEL2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm_write_reg(ctx, mmLB_SYNC_RESET_SEL, value);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dm_write_reg(compressor-&gt;ctx, DCP_REG(mmLB_SYNC_RESET_SEL=
), value);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; frame_count =3D dm_read_reg(ctx, mmCRTC_STATUS_FRAME_COUNT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; frame_count =3D dm_read_reg(compressor-&gt;ctx, DCP_REG(mmCR=
TC_STATUS_FRAME_COUNT));<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (retry =3D 10000; retry &gt; 0; retry--) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frame_count =
!=3D dm_read_reg(ctx, mmCRTC_STATUS_FRAME_COUNT))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frame_co=
unt !=3D dm_read_reg(compressor-&gt;ctx, DCP_REG(mmCRTC_STATUS_FRAME_COUNT)=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(10);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -130,13 &#43;102,11 @@ static void reset_lb_on_vblank(struct dc_context =
*ctx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_er=
ror(&quot;Frame count did not increase for 100ms.\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Resetting LB on VBlank */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D dm_read_reg(ctx, mmLB_SYNC_RESET_SEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; value =3D dm_read_reg(compressor-&gt;ctx, DCP_REG(mmLB_SYNC_=
RESET_SEL));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(value, 2, LB_SYNC_RESET_SEL, LB_S=
YNC_RESET_SEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(value, 0, LB_SYNC_RESET_SEL, LB_S=
YNC_RESET_SEL2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm_write_reg(ctx, mmLB_SYNC_RESET_SEL, value);<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dm_write_reg(compressor-&gt;ctx, DCP_REG(mmLB_SYNC_RESET_SEL=
), value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void wait_for_fbc_state_changed(<br>
@@ -226,10 &#43;196,10 @@ void dce110_compressor_enable_fbc(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t value, misc_value;<br>
&nbsp;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; addr =3D mmFBC_CNTL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; value =3D dm_read_reg(compressor-&gt;ctx, addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(value, 1, FBC_CNTL, FBC_GRPH_COMP=
_EN);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* params-&gt;inst is valid HW CRTC instance start from 0 */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; param=
s-&gt;inst,<br>
@@ -238,8 &#43;208,10 @@ void dce110_compressor_enable_fbc(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Keep track of enum controller_id FBC is attached t=
o */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; compressor-&gt;is_enabled =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; compressor-&gt;attached_inst =3D params-&gt;inst;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cp110-&gt;offsets =3D reg_offsets[params-&gt;inst];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* attached_inst is SW CRTC instance start from 1<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * 0 =3D CONTROLLER_ID_UNDEFINED means not attached crt=
c<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; compressor-&gt;attached_inst =3D params-&gt;inst &#43; CONTR=
OLLER_ID_D0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Toggle it as there is bug in HW */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_reg_field_value(value, 0, FBC_CNTL, FBC_GRPH_COMP=
_EN);<br>
@@ -268,9 &#43;240,10 @@ void dce110_compressor_enable_fbc(<br>
&nbsp;void dce110_compressor_disable_fbc(struct compressor *compressor)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce110_compressor *=
cp110 =3D TO_DCE110_COMPRESSOR(compressor);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t crtc_inst =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (compressor-&gt;options=
.bits.FBC_SUPPORT) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dce110_compressor_is_fbc_enabled_in_hw(compressor, NULL)) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dce110_compressor_is_fbc_enabled_in_hw(compressor, &amp;=
crtc_inst)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t reg_data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tu=
rn off compression */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_d=
ata =3D dm_read_reg(compressor-&gt;ctx, mmFBC_CNTL);<br>
@@ -284,8 &#43;257,10 @@ void dce110_compressor_disable_fbc(struct compress=
or *compressor)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_=
for_fbc_state_changed(cp110, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Sync line buffer&nbsp; - dce100/110 only*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reset_lb_on_vblank(compressor-&gt;ctx);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Sync line buffer which fbc was attached to dce100/110 onl=
y */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (crtc_inst &gt; CONTROLLER_ID_UNDEFINED &amp;&amp; crtc_i=
nst &lt; CONTROLLER_ID_D3)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_lb_on_=
vblank(compressor,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; crtc_inst - CONTROLLER_ID_D0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
@@ -328,6 &#43;303,8 @@ void dce110_compressor_program_compressed_surface_a=
ddress_and_pitch(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t compressed_surf_a=
ddress_low_part =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; compressor-&gt;compr_surface_address.addr.low_part;<b=
r>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp110-&gt;offsets =3D reg_offsets=
[params-&gt;inst];<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear content first. */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_write_reg(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; compressor-&gt;ctx,<br>
@@ -410,13 &#43;387,7 @@ void dce110_compressor_set_fbc_invalidation_trigge=
rs(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D dm_read_reg(comp=
ressor-&gt;ctx, addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_reg_field_value(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; value,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fbc_trigger |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FBC_IDLE_FORCE_GRPH_COMP_EN |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FBC_IDLE_FORCE_SRC_SEL_CHANGE |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FBC_IDLE_FORCE_MIN_COMPRESSION_CHANGE |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FBC_IDLE_FORCE_ALPHA_COMP_EN |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FBC_IDLE_FORCE_ZERO_ALPHA_CHUNK_SKIP_EN |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FBC_IDLE_FORCE_FORCE_COPY_TO_COMP_BUF,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fbc_trigger,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_CLEAR_MASK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; FBC_IDLE_FORCE_CLEAR_MASK);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_write_reg(compressor-&g=
t;ctx, addr, value);<br>
@@ -549,7 &#43;520,7 @@ void dce110_compressor_construct(struct dce110_comp=
ressor *compressor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.channe=
l_interleave_size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.dram_c=
hannels_num =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.lpt_ch=
annels_num =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.attached_inst =3D=
 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.attached_inst=
 =3D CONTROLLER_ID_UNDEFINED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.is_ena=
bled =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compressor-&gt;base.funcs =
=3D &amp;dce110_compressor_funcs;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
index 2f062ba..6349ba7 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer=
.c<br>
@@ -1766,12 &#43;1766,13 @@ static void set_static_screen_control(struct pi=
pe_ctx **pipe_ctx,<br>
&nbsp; *&nbsp; Check if FBC can be enabled<br>
&nbsp; */<br>
&nbsp;static bool should_enable_fbc(struct dc *dc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc_state *context,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t *pipe_idx)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dc_state *context,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t *pipe_idx)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipe_ctx =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource_context *r=
es_ctx =3D &amp;context-&gt;res_ctx;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int underlay_idx =3D dc-=
&gt;res_pool-&gt;underlay_pipe_index;<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(dc-&gt;fbc_compress=
or);<br>
@@ -1786,14 &#43;1787,28 @@ static bool should_enable_fbc(struct dc *dc,<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dc-&g=
t;res_pool-&gt;pipe_count; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (res_ctx-&gt;pipe_ctx[i].stream) {<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_=
ctx =3D &amp;res_ctx-&gt;pipe_ctx[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pipe_idx =3D i;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pipe_ct=
x)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fbc not a=
pplicable on underlay pipe */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx=
-&gt;pipe_idx !=3D underlay_idx) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pipe_idx =3D i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Pipe context should be found */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(pipe_ctx);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D dc-&gt;res_pool-&gt;=
pipe_count)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pipe_ctx-&gt;stream-&gt;sink=
)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pipe_ctx-&gt;stream-&gt;sink=
-&gt;link)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only supports eDP */<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream-&g=
t;sink-&gt;link-&gt;connector_signal !=3D SIGNAL_TYPE_EDP)<br>
@@ -1817,8 &#43;1832,9 @@ static bool should_enable_fbc(struct dc *dc,<br>
&nbsp;/*<br>
&nbsp; *&nbsp; Enable FBC<br>
&nbsp; */<br>
-static void enable_fbc(struct dc *dc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *conte=
xt)<br>
&#43;static void enable_fbc(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dc *dc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dc_state *context)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pipe_idx =3D 0;<b=
r>
&nbsp;<br>
@@ -1828,10 &#43;1844,9 @@ static void enable_fbc(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct compressor *compr =3D dc-&gt;fbc_compressor;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipe_ctx =3D &amp;context-&gt;res_ct=
x.pipe_ctx[pipe_idx];<br>
&nbsp;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; params.source_view_width =3D pipe_ctx-&gt;stream-&gt;=
timing.h_addressable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; params.source_view_height =3D pipe_ctx-&gt;stream-&gt=
;timing.v_addressable;<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; params.inst =3D pipe_ctx-&gt;stream_res.tg-&gt;inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; compr-&gt;compr_surface_address.quad_part =3D dc-&gt;=
ctx-&gt;fbc_gpu_addr;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; compr-&gt;funcs-&gt;surface_address_and_pitch(compr, =
&amp;params);<br>
@@ -2046,10 &#43;2061,10 @@ enum dc_status dce110_apply_ctx_to_hw(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n status;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcb-&gt;funcs-&gt;set_scratch_critica=
l_state(dcb, false);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;fbc_compressor)=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enable_fbc(dc, context);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; enable_fbc(dc, dc-&gt;current_state);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcb-&gt;funcs-&gt;set_scratch_cri=
tical_state(dcb, false);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_OK;<br>
&nbsp;}<br>
@@ -2408,7 &#43;2423,6 @@ static void dce110_program_front_end_for_pipe(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_state *pla=
ne_state =3D pipe_ctx-&gt;plane_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xfm_grph_csc_adjust=
ment adjust;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct out_csc_color_matri=
x tbl_entry;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int underlay_idx =3D dc-&gt;=
res_pool-&gt;underlay_pipe_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_LOGGER_INIT();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;tbl_entry, 0, =
sizeof(tbl_entry));<br>
@@ -2449,15 &#43;2463,6 @@ static void dce110_program_front_end_for_pipe(<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; program_scaler(dc, pipe_ct=
x);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fbc not applicable on Underlay pip=
e */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;fbc_compressor &amp;&amp; =
old_pipe-&gt;stream &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;=
pipe_idx !=3D underlay_idx) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (plane_state-&gt;tiling_info.gfx8.array_mode =3D=3D DC_ARRAY_=
LINEAR_GENERAL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;fbc_compr=
essor-&gt;funcs-&gt;disable_fbc(dc-&gt;fbc_compressor);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_fbc(dc, d=
c-&gt;current_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mi-&gt;funcs-&gt;mem_input=
_program_surface_config(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mi,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane=
_state-&gt;format,<br>
@@ -2534,6 &#43;2539,9 @@ static void dce110_apply_ctx_for_surface(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (num_planes =3D=3D 0)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;fbc_compressor)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dc-&gt;fbc_compressor-&gt;funcs-&gt;disable_fbc(dc-&gt;fbc_c=
ompressor);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dc-&g=
t;res_pool-&gt;pipe_count; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipe_ctx =3D &amp;context-&gt;res_ct=
x.pipe_ctx[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *old_pipe_ctx =3D &amp;dc-&gt;current=
_state-&gt;res_ctx.pipe_ctx[i];<br>
@@ -2576,6 &#43;2584,9 @@ static void dce110_apply_ctx_for_surface(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pipe=
_ctx-&gt;plane_state || old_pipe_ctx-&gt;plane_state))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&g=
t;hwss.pipe_control_lock(dc, pipe_ctx, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;fbc_compressor)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; enable_fbc(dc, dc-&gt;current_state);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void dce110_power_down_fe(struct dc *dc, struct pipe_ctx *pipe=
_ctx)<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/compressor.h b/drivers/gpu/=
drm/amd/display/dc/inc/compressor.h<br>
index bcb18f5..7a147a9 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/compressor.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/compressor.h<br>
@@ -77,6 &#43;77,7 @@ struct compressor_funcs {<br>
&nbsp;};<br>
&nbsp;struct compressor {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CONTROLLER_ID_D0 &#43; instanc=
e, CONTROLLER_ID_UNDEFINED =3D 0 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t attached_inst;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct compressor_fu=
ncs *funcs;<br>
-- <br>
2.7.4<br>
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

--_000_BN6PR12MB18092FE3F45C1039E19F2F5AF7D20BN6PR12MB1809namp_--

--===============0082952222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0082952222==--
