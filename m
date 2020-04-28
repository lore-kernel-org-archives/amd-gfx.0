Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7495BC8300C
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 06:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FB520757
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 06:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FB520757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE746ECAE;
	Wed, 29 Apr 2020 06:45:36 +0000 (UTC)
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Tue, 28 Apr 2020 22:00:57 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C696E9BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 22:00:57 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNOZO-1jnzWf0ECw-00OsmQ; Tue, 28 Apr 2020 23:55:43 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] amdgpu: fix gcc-4.8 build warnings
Date: Tue, 28 Apr 2020 23:54:27 +0200
Message-Id: <20200428215541.4144749-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:i1PSi7lDLRUoZn/s8e+nf63pIYSQOtNY+L6yTmkwMTH93YBNi8b
 WeTZZLFfPl0ZMqNvNH6RAwU6VH+KM1UEu2w/X1SXTt2t/e1r+eMa5bSJiUjuzkzgWVGDhY2
 QQqnJg2MJ50Ec5uE0SnSFh1nsBt9y9jzuAviAa5Y3o7xGkoKW6KzXko74aHunSpW2AtEWdA
 p32o3fuYNDSMN1kdBya3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ETXahhEAHQI=:WimIETtnswhfszMhjpyBbH
 uVlUJEW3q/qTXrNVCDn3JEJtbqKkCLWlH1OpWYGgJMjRh8v4BH9XbsjMTJ9Q+HaKTkGoS4F6w
 Q1Tki145GR7OFtYVlZkZByjYUu8JW1AA+bBXOTUdBWc8s2mbTKiTNjIEPL6WfEqSJX7OzQX7n
 O84PjfpBBbPvoUKD5zcLiY4FuYi3EenC1HCSiVir5/NQtl+Uv1elkeWzrWggZSUyd5KX8nbwG
 dH6GsOGbJUKpH2PTXRWM26wvIHjH/Ua/sYZx/+weumFs4Y2hwQq8bitZpBoRAgbwtxTOIH4wq
 5cYmukBI1Edg1EX4zrBlxGqyp9jTlJVUHfNdVptbrZuHbghEXhoKFKB3hCw/KLhP3yifwL8gk
 Yz8RjKrlob2tJ9HRpv4F5YFvug+UuWip1FHydVUWF+z8mTQGO66aRIGecvqSFfNBEkEHjEqOp
 0EXC+rNfcZZWOHhiBvgM4wj49UjfjQjHX4ONGcXBUuCcTMGZqf2WDPdR5wszDnFP7khm81fYs
 drkeqRSlMVp0oiXEfCFkB3FKgIst4tWuaaOXcOPS6xC/n/cIgHpwwc1ITi9zXlvs/6Rwre2tA
 3j74BMSQ5hfebYWt+YCUxDZM2Q79rmEEJha5oHOPVsRNFxVVjxg01LIR8ckpfaHEkudtFPXwB
 hX6uw5RSJWqa8wozARyBNpeIKku/ZrUPTMjZxhfnJh/F5SGpQwgqVF36aZ/2zW29Aj3Tdta4I
 qd/qn5ECI2wXFBHIi0GRV0GQX8Uxq4VjYMB4XGjtA1bqcbdvdakb2tBXb/6SVIKhhfaLrnvBW
 zXLL6c2wUep25r+wfLlowk7eFQNw0beKRLziw2JJgJhUxLxVSQ=
X-Mailman-Approved-At: Wed, 29 Apr 2020 06:45:35 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Older compilers warn about initializers with incorrect curly
braces:

drivers/gpu/drm/drm_dp_mst_topology.c: In function 'drm_dp_mst_dsc_aux_for_port':
drivers/gpu/drm/drm_dp_mst_topology.c:5497:9: error: missing braces around initializer [-Werror=missing-braces]
  struct drm_dp_desc desc = { 0 };
         ^

Change all instances in the amd gpu driver to using the GNU empty
initializer extension.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        | 2 +-
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c      | 4 ++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 6 +++---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c         | 6 +++---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c         | 8 ++++----
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f4417981bff..81ce3103d751 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8695,7 +8695,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 {
 	struct dc_link *link = stream->link;
 	unsigned int vsync_rate_hz = 0;
-	struct dc_static_screen_params params = {0};
+	struct dc_static_screen_params params = { };
 	/* Calculate number of static frames before generating interrupt to
 	 * enter PSR.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 37fa7b48250e..5484a316eaa8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -294,7 +294,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	struct atom_display_object_path_v2 *object;
 	struct atom_common_record_header *header;
 	struct atom_i2c_record *record;
-	struct atom_i2c_record dummy_record = {0};
+	struct atom_i2c_record dummy_record = { };
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!info)
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 8edc2506d49e..5e186c135921 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -113,7 +113,7 @@ static void encoder_control_dmcub(
 		struct dc_dmub_srv *dmcub,
 		struct dig_encoder_stream_setup_parameters_v1_5 *dig)
 {
-	struct dmub_rb_cmd_digx_encoder_control encoder_control = { 0 };
+	struct dmub_rb_cmd_digx_encoder_control encoder_control = { };
 
 	encoder_control.header.type = DMUB_CMD__VBIOS;
 	encoder_control.header.sub_type = DMUB_CMD__VBIOS_DIGX_ENCODER_CONTROL;
@@ -339,7 +339,7 @@ static void set_pixel_clock_dmcub(
 		struct dc_dmub_srv *dmcub,
 		struct set_pixel_clock_parameter_v1_7 *clk)
 {
-	struct dmub_rb_cmd_set_pixel_clock pixel_clock = { 0 };
+	struct dmub_rb_cmd_set_pixel_clock pixel_clock = { };
 
 	pixel_clock.header.type = DMUB_CMD__VBIOS;
 	pixel_clock.header.sub_type = DMUB_CMD__VBIOS_SET_PIXEL_CLOCK;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 24c5765890fa..ee3ef5094fd1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -698,7 +698,7 @@ void rn_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dc_debug_options *debug = &ctx->dc->debug;
-	struct dpm_clocks clock_table = { 0 };
+	struct dpm_clocks clock_table = { };
 
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn21_funcs;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9ef9e50a34fa..7cbfe740a947 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2683,9 +2683,9 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 
 static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video)
 {
-	union audio_test_mode            dpcd_test_mode = {0};
-	struct audio_test_pattern_type   dpcd_pattern_type = {0};
-	union audio_test_pattern_period  dpcd_pattern_period[AUDIO_CHANNELS_COUNT] = {0};
+	union audio_test_mode            dpcd_test_mode = { };
+	struct audio_test_pattern_type   dpcd_pattern_type = { };
+	union audio_test_pattern_period  dpcd_pattern_period[AUDIO_CHANNELS_COUNT] = { };
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_AUDIO_OPERATOR_DEFINED;
 
 	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 84d7ac5dd206..dfa541f0b0d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1253,9 +1253,9 @@ void hubp2_validate_dml_output(struct hubp *hubp,
 		struct _vcs_dpi_display_ttu_regs_st *dml_ttu_attr)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	struct _vcs_dpi_display_rq_regs_st rq_regs = {0};
-	struct _vcs_dpi_display_dlg_regs_st dlg_attr = {0};
-	struct _vcs_dpi_display_ttu_regs_st ttu_attr = {0};
+	struct _vcs_dpi_display_rq_regs_st rq_regs = { };
+	struct _vcs_dpi_display_dlg_regs_st dlg_attr = { };
+	struct _vcs_dpi_display_ttu_regs_st ttu_attr = { };
 	DC_LOGGER_INIT(ctx->logger);
 	DC_LOG_DEBUG("DML Validation | Running Validation");
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 63044ae06327..509b07c24758 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -449,7 +449,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 	.use_urgent_burst_bw = 0
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
+struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { };
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index d285ba622d61..654ea81b8ad6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -365,9 +365,9 @@ void hubp21_validate_dml_output(struct hubp *hubp,
 		struct _vcs_dpi_display_ttu_regs_st *dml_ttu_attr)
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	struct _vcs_dpi_display_rq_regs_st rq_regs = {0};
-	struct _vcs_dpi_display_dlg_regs_st dlg_attr = {0};
-	struct _vcs_dpi_display_ttu_regs_st ttu_attr = {0};
+	struct _vcs_dpi_display_rq_regs_st rq_regs = { };
+	struct _vcs_dpi_display_dlg_regs_st dlg_attr = { };
+	struct _vcs_dpi_display_ttu_regs_st ttu_attr = { };
 	DC_LOGGER_INIT(ctx->logger);
 	DC_LOG_DEBUG("DML Validation | Running Validation");
 
@@ -778,7 +778,7 @@ void dmcub_PLAT_54186_wa(struct hubp *hubp, struct surface_flip_registers *flip_
 {
 	struct dc_dmub_srv *dmcub = hubp->ctx->dmub_srv;
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa = { 0 };
+	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa = { };
 
 	PLAT_54186_wa.header.type = DMUB_CMD__PLAT_54186_WA;
 	PLAT_54186_wa.flip.DCSURF_PRIMARY_SURFACE_ADDRESS = flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
