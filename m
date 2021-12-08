Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFC2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152126E417;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E086E223
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zyz1x9nzF4nB;
 Tue,  7 Dec 2021 17:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926795; bh=xlAML4N38SMKQiC+HmQb3sI1DT6PRWQnqpObat81yA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Imtw5QiIUFAiCiAncJaSpyzlZP5kP8y8k98MvzJOvRxOSS5ur0RUrCKlr1ERU5Yc9
 ohsSLfUC0a/1EG8sV0Mm71YmrLlHP0IIm/JRRW3LNGn66U3oQAma9QwAR1+DMrUBEY
 hqjQu7pE1KXo3Q0fKkQJtHMz6elhzovhJUGuhALg=
X-Riseup-User-ID: E8DF065C39CE15E47B29F1956F0B9166EC58A5DB4315DA01E79878586CECF298
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zyw5DQXz5w50;
 Tue,  7 Dec 2021 17:26:32 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 06/10] drm/amd/display: fix function scopes
Date: Tue,  7 Dec 2021 22:25:25 -0300
Message-Id: <20211208012529.372478-7-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This turns previously global functions into static, thus removing
compile-time warnings such as:

 warning: no previous prototype for 'get_highest_allowed_voltage_level'
 [-Wmissing-prototypes]
 742 | unsigned int get_highest_allowed_voltage_level(uint32_t chip_family, uint32_t hw_internal_rev, uint32_t pci_revision_id)
     |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 warning: no previous prototype for 'rv1_vbios_smu_send_msg_with_param'
 [-Wmissing-prototypes]
 102 | int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
     |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++--
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  4 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  5 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 14 ++---
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  4 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  6 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 10 ++--
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  9 +--
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  5 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 16 +++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |  5 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  8 +--
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 21 ++++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |  5 +-
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  7 +--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  8 +--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 21 ++++---
 .../drm/amd/display/dc/dcn201/dcn201_dccg.c   |  3 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubp.c   |  7 +--
 .../display/dc/dcn201/dcn201_link_encoder.c   |  7 ++-
 .../amd/display/dc/dcn201/dcn201_resource.c   | 19 +++----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 16 +++---
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |  9 ++-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 34 +++++------
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  8 +--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 27 ++++-----
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 13 ++---
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c | 10 ++--
 .../amd/display/dc/dcn301/dcn301_resource.c   | 56 +++++++++----------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  2 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 10 ++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  4 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  3 +-
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |  7 +--
 .../dc/irq/dcn201/irq_service_dcn201.c        |  7 +--
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  7 +--
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |  7 +--
 48 files changed, 225 insertions(+), 231 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 26c65c72eb75..85472d0121c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -632,7 +632,8 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
  * Copies dmub notification to DM which is to be read by AUX command.
  * issuing thread and also signals the event to wake up the thread.
  */
-void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
+static void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct
+					dmub_notification *notify)
 {
 	if (adev->dm.dmub_notify)
 		memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
@@ -648,7 +649,8 @@ void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notific
  * Dmub Hpd interrupt processing callback. Gets displayindex through the
  * ink index and calls helper to do the processing.
  */
-void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
+static void dmub_hpd_callback(struct amdgpu_device *adev, struct
+			      dmub_notification *notify)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct amdgpu_dm_connector *hpd_aconnector = NULL;
@@ -705,8 +707,11 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
  * to dmub interrupt handling thread
  * Return: true if successfully registered, false if there is existing registration
  */
-bool register_dmub_notify_callback(struct amdgpu_device *adev, enum dmub_notification_type type,
-dmub_notify_interrupt_callback_t callback, bool dmub_int_thread_offload)
+static bool register_dmub_notify_callback(struct amdgpu_device *adev, enum
+					  dmub_notification_type type,
+					  dmub_notify_interrupt_callback_t
+					  callback, bool
+					  dmub_int_thread_offload)
 {
 	if (callback != NULL && type < ARRAY_SIZE(adev->dm.dmub_thread_offload)) {
 		adev->dm.dmub_callback[type] = callback;
@@ -11614,8 +11619,10 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 	return value;
 }
 
-int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux, struct dc_context *ctx,
-	uint8_t status_type, uint32_t *operation_result)
+static int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux, struct
+						dc_context *ctx, uint8_t
+						status_type, uint32_t
+						*operation_result)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	int return_status = -1;
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index c8b0a2f05b4d..ec19678a0702 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -739,7 +739,9 @@ static void hack_bounding_box(struct dcn_bw_internal_vars *v,
 		hack_force_pipe_split(v, context->streams[0]->timing.pix_clk_100hz);
 }
 
-unsigned int get_highest_allowed_voltage_level(uint32_t chip_family, uint32_t hw_internal_rev, uint32_t pci_revision_id)
+static unsigned int get_highest_allowed_voltage_level(uint32_t chip_family,
+						      uint32_t hw_internal_rev,
+						      uint32_t pci_revision_id)
 {
 	/* for low power RV2 variants, the highest voltage level we want is 0 */
 	if ((chip_family == FAMILY_RV) &&
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 76ec8ec92efd..60761ff3cbf1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -34,7 +34,7 @@
 #include "rv1_clk_mgr_vbios_smu.h"
 #include "rv1_clk_mgr_clk.h"
 
-void rv1_init_clocks(struct clk_mgr *clk_mgr)
+static void rv1_init_clocks(struct clk_mgr *clk_mgr)
 {
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 2108bff49d4e..9f35f2e8f971 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -409,7 +409,7 @@ void dcn2_init_clocks(struct clk_mgr *clk_mgr)
 	clk_mgr->clks.prev_p_state_change_support = true;
 }
 
-void dcn2_enable_pme_wa(struct clk_mgr *clk_mgr_base)
+static void dcn2_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct pp_smu_funcs_nv *pp_smu = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index db9950244c7b..f7f46b886162 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -74,9 +74,8 @@ static const struct clk_mgr_mask clk_mgr_mask = {
 	CLK_COMMON_MASK_SH_LIST_DCN201_BASE(_MASK)
 };
 
-void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr,
-			struct dc_state *context,
-			bool safe_to_lower)
+static void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr, struct dc_state
+				       *context, bool safe_to_lower)
 {
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ac2d4c4f04e4..5dad77a5376d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -56,9 +56,7 @@
 
 
 /* TODO: evaluate how to lower or disable all dcn clocks in screen off case */
-int rn_get_active_display_cnt_wa(
-		struct dc *dc,
-		struct dc_state *context)
+static int rn_get_active_display_cnt_wa(struct dc *dc, struct dc_state *context)
 {
 	int i, display_count;
 	bool tmds_present = false;
@@ -88,7 +86,7 @@ int rn_get_active_display_cnt_wa(
 	return display_count;
 }
 
-void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
+static void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
@@ -122,7 +120,7 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 }
 
 
-void rn_update_clocks(struct clk_mgr *clk_mgr_base,
+static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
 {
@@ -438,7 +436,7 @@ static void rn_dump_clk_registers(struct clk_state_registers_and_bypass *regs_an
 }
 
 /* This function produce translated logical clk state values*/
-void rn_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
+static void rn_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
 {
 	struct clk_state_registers_and_bypass sb = { 0 };
 	struct clk_log_info log_info = { 0 };
@@ -448,14 +446,14 @@ void rn_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
 	s->dprefclk_khz = sb.dprefclk * 1000;
 }
 
-void rn_enable_pme_wa(struct clk_mgr *clk_mgr_base)
+static void rn_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
 	rn_vbios_smu_enable_pme_wa(clk_mgr);
 }
 
-void rn_init_clocks(struct clk_mgr *clk_mgr)
+static void rn_init_clocks(struct clk_mgr *clk_mgr)
 {
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 	// Assumption is that boot state always supports pstate
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 9f7eed6688c4..0c963fc0523f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -86,7 +86,9 @@ static uint32_t rn_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsig
 }
 
 
-int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
+static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
+					    unsigned int msg_id,
+					    unsigned int param)
 {
 	uint32_t result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index 6ea642615854..c8cea4fa8c53 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -88,9 +88,9 @@ static uint32_t dcn301_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, u
 	return res_val;
 }
 
-int dcn301_smu_send_msg_with_param(
-		struct clk_mgr_internal *clk_mgr,
-		unsigned int msg_id, unsigned int param)
+static int dcn301_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
+					  unsigned int msg_id, unsigned int
+					  param)
 {
 	uint32_t result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 3eee32faa208..547a89a99fc0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -89,9 +89,8 @@ static int vg_get_active_display_cnt_wa(
 	return display_count;
 }
 
-void vg_update_clocks(struct clk_mgr *clk_mgr_base,
-			struct dc_state *context,
-			bool safe_to_lower)
+static void vg_update_clocks(struct clk_mgr *clk_mgr_base, struct dc_state
+			     *context, bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
@@ -368,7 +367,8 @@ static void vg_dump_clk_registers(struct clk_state_registers_and_bypass *regs_an
 }
 
 /* This function produce translated logical clk state values*/
-void vg_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
+static void vg_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states
+			      *s)
 {
 
 	struct clk_state_registers_and_bypass sb = { 0 };
@@ -386,7 +386,7 @@ static void vg_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	dcn301_smu_enable_pme_wa(clk_mgr);
 }
 
-void vg_init_clocks(struct clk_mgr *clk_mgr)
+static void vg_init_clocks(struct clk_mgr *clk_mgr)
 {
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 	// Assumption is that boot state always supports pstate
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index a13ff1783b9b..2235ade2cae7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -540,10 +540,11 @@ static unsigned int find_clk_for_voltage(
 	return clock;
 }
 
-void dcn31_clk_mgr_helper_populate_bw_params(
-		struct clk_mgr_internal *clk_mgr,
-		struct integrated_info *bios_info,
-		const DpmClocks_t *clock_table)
+static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal
+						    *clk_mgr, struct
+						    integrated_info *bios_info,
+						    const DpmClocks_t
+						    *clock_table)
 {
 	int i, j;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 8c2b77eb9459..c738b80ebd6e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -95,9 +95,9 @@ static uint32_t dcn31_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 	return res_val;
 }
 
-int dcn31_smu_send_msg_with_param(
-		struct clk_mgr_internal *clk_mgr,
-		unsigned int msg_id, unsigned int param)
+static int dcn31_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
+					 unsigned int msg_id, unsigned int
+					 param)
 {
 	uint32_t result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9639d7a7f03e..c95ad837c337 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3416,7 +3416,8 @@ static void dc_log_vcp_x_y(const struct dc_link *link, struct fixed31_32 avg_tim
 /*
  * Payload allocation/deallocation for SST introduced in DP2.0
  */
-enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool allocate)
+static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool
+						 allocate)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
index 91fdfcd8a14e..9a7539aca69b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -120,7 +120,7 @@ void dpp_read_state(struct dpp *dpp_base,
 }
 
 /* Program gamut remap in bypass mode */
-void dpp_set_gamut_remap_bypass(struct dcn10_dpp *dpp)
+static void dpp_set_gamut_remap_bypass(struct dcn10_dpp *dpp)
 {
 	REG_SET(CM_GAMUT_REMAP_CONTROL, 0,
 			CM_GAMUT_REMAP_MODE, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index e31a6f1516bb..4ea7f003fa2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -555,9 +555,8 @@ static enum lb_memory_config dpp1_dscl_find_lb_memory_config(struct dcn10_dpp *d
 	return LB_MEMORY_CONFIG_0;
 }
 
-void dpp1_dscl_set_scaler_auto_scale(
-	struct dpp *dpp_base,
-	const struct scaler_data *scl_data)
+static void dpp1_dscl_set_scaler_auto_scale(struct dpp *dpp_base, const struct
+					    scaler_data *scl_data)
 {
 	enum lb_memory_config lb_config;
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a2b925cc4132..e5a2790546d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -77,7 +77,7 @@
 #define PGFSM_POWER_ON 0
 #define PGFSM_POWER_OFF 2
 
-void print_microsec(struct dc_context *dc_ctx,
+static void print_microsec(struct dc_context *dc_ctx,
 	struct dc_log_buffer_ctx *log_ctx,
 	uint32_t ref_cycle)
 {
@@ -132,7 +132,8 @@ static void log_mpc_crc(struct dc *dc,
 		REG_READ(DPP_TOP0_DPP_CRC_VAL_B_A), REG_READ(DPP_TOP0_DPP_CRC_VAL_R_G));
 }
 
-void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_ctx)
+static void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx
+				   *log_ctx)
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct dcn_hubbub_wm wm;
@@ -1972,7 +1973,7 @@ static bool wait_for_reset_trigger_to_occur(
 	return rc;
 }
 
-uint64_t reduceSizeAndFraction(
+static uint64_t reduceSizeAndFraction(
 	uint64_t *numerator,
 	uint64_t *denominator,
 	bool checkUint32Bounary)
@@ -2023,7 +2024,7 @@ uint64_t reduceSizeAndFraction(
 	return ret;
 }
 
-bool is_low_refresh_rate(struct pipe_ctx *pipe)
+static bool is_low_refresh_rate(struct pipe_ctx *pipe)
 {
 	uint32_t master_pipe_refresh_rate =
 		pipe->stream->timing.pix_clk_100hz * 100 /
@@ -2032,7 +2033,8 @@ bool is_low_refresh_rate(struct pipe_ctx *pipe)
 	return master_pipe_refresh_rate <= 30;
 }
 
-uint8_t get_clock_divider(struct pipe_ctx *pipe, bool account_low_refresh_rate)
+static uint8_t get_clock_divider(struct pipe_ctx *pipe, bool
+				 account_low_refresh_rate)
 {
 	uint32_t clock_divider = 1;
 	uint32_t numpipes = 1;
@@ -2052,7 +2054,7 @@ uint8_t get_clock_divider(struct pipe_ctx *pipe, bool account_low_refresh_rate)
 	return clock_divider;
 }
 
-int dcn10_align_pixel_clocks(
+static int dcn10_align_pixel_clocks(
 	struct dc *dc,
 	int group_size,
 	struct pipe_ctx *grouped_pipes[])
@@ -2344,7 +2346,7 @@ static void mmhub_read_vm_context0_settings(struct dcn10_hubp *hubp1,
 }
 
 
-void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
+static void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 	struct vm_system_aperture_param apt = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
index d54d731415d7..69f79584c7e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
@@ -348,9 +348,8 @@ void opp1_program_stereo(
 	*/
 }
 
-void opp1_program_oppbuf(
-	struct output_pixel_processor *opp,
-	struct oppbuf_params *oppbuf)
+static void opp1_program_oppbuf(struct output_pixel_processor *opp, struct
+				oppbuf_params *oppbuf)
 {
 	struct dcn10_opp *oppn10 = TO_DCN10_OPP(opp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 3d2a2848857a..478ea88ad535 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -136,8 +136,8 @@ void optc1_setup_vertical_interrupt2(
  * Start offset begins with vstartup and goes for x number of clocks,
  * end offset starts from end of vupdate to x number of clocks.
  */
-void optc1_set_vupdate_keepout(struct timing_generator *optc,
-			       struct vupdate_keepout_params *params)
+static void optc1_set_vupdate_keepout(struct timing_generator *optc, struct
+				      vupdate_keepout_params *params)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -876,7 +876,7 @@ void optc1_set_static_screen_control(
 			OTG_STATIC_SCREEN_FRAME_COUNT, num_frames);
 }
 
-void optc1_setup_manual_trigger(struct timing_generator *optc)
+static void optc1_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -894,7 +894,7 @@ void optc1_setup_manual_trigger(struct timing_generator *optc)
 			OTG_TRIGA_CLEAR, 1);
 }
 
-void optc1_program_manual_trigger(struct timing_generator *optc)
+static void optc1_program_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 19a2dd619ec7..521a085acd09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -686,9 +686,8 @@ static struct output_pixel_processor *dcn10_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dcn10_aux_engine_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_aux *dcn10_aux_engine_create(struct dc_context *ctx, uint32_t
+					       inst)
 {
 	struct aux_engine_dce110 *aux_engine =
 		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
@@ -724,9 +723,8 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
 };
 
-struct dce_i2c_hw *dcn10_i2c_hw_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_i2c_hw *dcn10_i2c_hw_create(struct dc_context *ctx, uint32_t
+					      inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
 		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
@@ -805,8 +803,9 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS4_CAPABLE = true
 };
 
-struct link_encoder *dcn10_link_encoder_create(
-	const struct encoder_init_data *enc_init_data)
+static struct link_encoder *dcn10_link_encoder_create(const struct
+						      encoder_init_data
+						      *enc_init_data)
 {
 	struct dcn10_link_encoder *enc10 =
 		kzalloc(sizeof(struct dcn10_link_encoder), GFP_KERNEL);
@@ -847,7 +846,7 @@ static struct panel_cntl *dcn10_panel_cntl_create(const struct panel_cntl_init_d
 	return &panel_cntl->base;
 }
 
-struct clock_source *dcn10_clock_source_create(
+static struct clock_source *dcn10_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -945,7 +944,7 @@ static const struct resource_create_funcs res_create_maximus_funcs = {
 	.create_hwseq = dcn10_hwseq_create,
 };
 
-void dcn10_clock_source_destroy(struct clock_source **clk_src)
+static void dcn10_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
@@ -1122,7 +1121,7 @@ static enum dc_status build_mapped_resource(
 	return DC_OK;
 }
 
-enum dc_status dcn10_add_stream_to_ctx(
+static enum dc_status dcn10_add_stream_to_ctx(
 		struct dc *dc,
 		struct dc_state *new_ctx,
 		struct dc_stream_state *dc_stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index a9e420c7d75a..0b63a83a573f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -251,9 +251,8 @@ static void dpp2_cnv_setup (
 
 }
 
-void dpp2_cnv_set_bias_scale(
-		struct dpp *dpp_base,
-		struct  dc_bias_and_scale *bias_and_scale)
+static void dpp2_cnv_set_bias_scale(struct dpp *dpp_base, struct
+				    dc_bias_and_scale *bias_and_scale)
 {
 	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index 880954ac0b02..994fb732a7cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -527,7 +527,7 @@ static const uint16_t filter_12tap_16p_183[108] = {
 	0, 84, 16328, 16032, 416, 1944, 1944, 416, 16032, 16328, 84, 0,
 };
 
-const uint16_t *wbscl_get_filter_3tap_16p(struct fixed31_32 ratio)
+static const uint16_t *wbscl_get_filter_3tap_16p(struct fixed31_32 ratio)
 {
 	if (ratio.value < dc_fixpt_one.value)
 		return filter_3tap_16p_upscale;
@@ -539,7 +539,7 @@ const uint16_t *wbscl_get_filter_3tap_16p(struct fixed31_32 ratio)
 		return filter_3tap_16p_183;
 }
 
-const uint16_t *wbscl_get_filter_4tap_16p(struct fixed31_32 ratio)
+static const uint16_t *wbscl_get_filter_4tap_16p(struct fixed31_32 ratio)
 {
 	if (ratio.value < dc_fixpt_one.value)
 		return filter_4tap_16p_upscale;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 5adf42a7cc27..b06c730f280f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -192,9 +192,8 @@ void hubp2_vready_at_or_After_vsync(struct hubp *hubp,
 	REG_UPDATE(DCHUBP_CNTL, HUBP_VREADY_AT_OR_AFTER_VSYNC, value);
 }
 
-void hubp2_program_requestor(
-		struct hubp *hubp,
-		struct _vcs_dpi_display_rq_regs_st *rq_regs)
+static void hubp2_program_requestor(struct hubp *hubp, struct
+				    _vcs_dpi_display_rq_regs_st *rq_regs)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
@@ -1285,7 +1284,7 @@ void hubp2_read_state(struct hubp *hubp)
 
 }
 
-void hubp2_validate_dml_output(struct hubp *hubp,
+static void hubp2_validate_dml_output(struct hubp *hubp,
 		struct dc_context *ctx,
 		struct _vcs_dpi_display_rq_regs_st *dml_rq_regs,
 		struct _vcs_dpi_display_dlg_regs_st *dml_dlg_attr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e6af99ae3d9f..f791d5fe929d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1080,10 +1080,8 @@ static void dcn20_power_on_plane(
 	}
 }
 
-void dcn20_enable_plane(
-	struct dc *dc,
-	struct pipe_ctx *pipe_ctx,
-	struct dc_state *context)
+static void dcn20_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx, struct
+			       dc_state *context)
 {
 	//if (dc->debug.sanity_checks) {
 	//	dcn10_verify_allow_pstate_change_high(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 947eb0df3f12..8b5b7f68a107 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -400,10 +400,8 @@ static void mpc20_program_ogam_pwl(
 
 }
 
-void apply_DEDCN20_305_wa(
-		struct mpc *mpc,
-		int mpcc_id, enum dc_lut_mode current_mode,
-		enum dc_lut_mode next_mode)
+static void apply_DEDCN20_305_wa(struct mpc *mpc, int mpcc_id, enum dc_lut_mode
+				 current_mode, enum dc_lut_mode next_mode)
 {
 	struct dcn20_mpc *mpc20 = TO_DCN20_MPC(mpc);
 
@@ -525,7 +523,7 @@ static void mpc2_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
 	mpcc->sm_cfg.enable = false;
 }
 
-struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
+static struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 {
 	struct mpcc *tmp_mpcc = tree->opp_list;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 8c34751b0e58..01a1eca32e91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -77,7 +77,7 @@ bool optc2_enable_crtc(struct timing_generator *optc)
  * for V_TOTAL, H_TOTAL, VTOTAL_MIN, VTOTAL_MAX, VTOTAL_MIN_SEL and VTOTAL_MAX_SEL registers
  * Options: anytime, start of frame, dp start of frame (range timing)
  */
-void optc2_set_timing_db_mode(struct timing_generator *optc, bool enable)
+static void optc2_set_timing_db_mode(struct timing_generator *optc, bool enable)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -111,8 +111,8 @@ void optc2_set_gsl(struct timing_generator *optc,
 
 
 /* Use the gsl allow flip as the master update lock */
-void optc2_use_gsl_as_master_update_lock(struct timing_generator *optc,
-		   const struct gsl_params *params)
+static void optc2_use_gsl_as_master_update_lock(struct timing_generator *optc,
+						const struct gsl_params *params)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -121,8 +121,8 @@ void optc2_use_gsl_as_master_update_lock(struct timing_generator *optc,
 }
 
 /* You can control the GSL timing by limiting GSL to a window (X,Y) */
-void optc2_set_gsl_window(struct timing_generator *optc,
-		   const struct gsl_params *params)
+static void optc2_set_gsl_window(struct timing_generator *optc, const struct
+				 gsl_params *params)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -157,9 +157,8 @@ void optc2_set_gsl_source_select(
 }
 
 /* DSC encoder frame start controls: x = h position, line_num = # of lines from vstartup */
-void optc2_set_dsc_encoder_frame_start(struct timing_generator *optc,
-					int x_position,
-					int line_num)
+static void optc2_set_dsc_encoder_frame_start(struct timing_generator *optc, int
+					      x_position, int line_num)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -293,8 +292,8 @@ void optc2_get_optc_source(struct timing_generator *optc,
 		*num_of_src_opp = 1;
 }
 
-void optc2_set_dwb_source(struct timing_generator *optc,
-		uint32_t dwb_pipe_inst)
+static void optc2_set_dwb_source(struct timing_generator *optc, uint32_t
+				 dwb_pipe_inst)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -306,7 +305,7 @@ void optc2_set_dwb_source(struct timing_generator *optc,
 				OPTC_DWB1_SOURCE_SELECT, optc->inst);
 }
 
-void optc2_align_vblanks(
+static void optc2_align_vblanks(
 	struct timing_generator *optc_master,
 	struct timing_generator *optc_slave,
 	uint32_t master_pixel_clock_100Hz,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c
index f5bf04f7da25..d1de4f8ea713 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c
@@ -44,7 +44,8 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
-void dccg201_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
+static void dccg201_update_dpp_dto(struct dccg *dccg, int dpp_inst, int
+				   req_dppclk)
 {
 	/* vbios handles it */
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
index 6b6f74d4afd1..522bd7f593dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
@@ -55,7 +55,7 @@ static void hubp201_program_surface_config(
 	hubp1_program_pixel_format(hubp, format);
 }
 
-void hubp201_program_deadline(
+static void hubp201_program_deadline(
 		struct hubp *hubp,
 		struct _vcs_dpi_display_dlg_regs_st *dlg_attr,
 		struct _vcs_dpi_display_ttu_regs_st *ttu_attr)
@@ -63,9 +63,8 @@ void hubp201_program_deadline(
 	hubp1_program_deadline(hubp, dlg_attr, ttu_attr);
 }
 
-void hubp201_program_requestor(
-		struct hubp *hubp,
-		struct _vcs_dpi_display_rq_regs_st *rq_regs)
+static void hubp201_program_requestor(struct hubp *hubp, struct
+				      _vcs_dpi_display_rq_regs_st *rq_regs)
 {
 	struct dcn201_hubp *hubp201 = TO_DCN201_HUBP(hubp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
index a65e8f7801db..66141827740e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
@@ -50,8 +50,9 @@
 #define IND_REG(index) \
 	(enc10->link_regs->index)
 
-void dcn201_link_encoder_get_max_link_cap(struct link_encoder *enc,
-	struct dc_link_settings *link_settings)
+static void dcn201_link_encoder_get_max_link_cap(struct link_encoder *enc,
+						 struct dc_link_settings
+						 *link_settings)
 {
 	uint32_t value1, value2;
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
@@ -66,7 +67,7 @@ void dcn201_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	}
 }
 
-bool dcn201_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+static bool dcn201_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 {
 	uint32_t value;
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 0fa381088d1d..767a8f84b629 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -672,9 +672,8 @@ static struct output_pixel_processor *dcn201_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dcn201_aux_engine_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_aux *dcn201_aux_engine_create(struct dc_context *ctx, uint32_t
+						inst)
 {
 	struct aux_engine_dce110 *aux_engine =
 		kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);
@@ -706,9 +705,8 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)
 };
 
-struct dce_i2c_hw *dcn201_i2c_hw_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_i2c_hw *dcn201_i2c_hw_create(struct dc_context *ctx, uint32_t
+					       inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
 		kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);
@@ -789,8 +787,9 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS4_CAPABLE = true
 };
 
-struct link_encoder *dcn201_link_encoder_create(
-	const struct encoder_init_data *enc_init_data)
+static struct link_encoder *dcn201_link_encoder_create(const struct
+						       encoder_init_data
+						       *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
@@ -811,7 +810,7 @@ struct link_encoder *dcn201_link_encoder_create(
 	return &enc10->base;
 }
 
-struct clock_source *dcn201_clock_source_create(
+static struct clock_source *dcn201_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -906,7 +905,7 @@ static const struct resource_create_funcs res_create_maximus_funcs = {
 	.create_hwseq = dcn201_hwseq_create,
 };
 
-void dcn201_clock_source_destroy(struct clock_source **clk_src)
+static void dcn201_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index 36044cb8ec83..c5e200d09038 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -680,7 +680,7 @@ void hubbub21_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, &s->dram_clk_chanage);
 }
 
-void hubbub21_apply_DEDCN21_147_wa(struct hubbub *hubbub)
+static void hubbub21_apply_DEDCN21_147_wa(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 3de1bcf9b3d8..670492216485 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -183,7 +183,7 @@ static void hubp21_setup(
 
 }
 
-void hubp21_set_viewport(
+static void hubp21_set_viewport(
 	struct hubp *hubp,
 	const struct rect *viewport,
 	const struct rect *viewport_c)
@@ -225,8 +225,9 @@ void hubp21_set_viewport(
 		  SEC_VIEWPORT_Y_START_C, viewport_c->y);
 }
 
-void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
-		struct vm_system_aperture_param *apt)
+static void hubp21_set_vm_system_aperture_settings(struct hubp *hubp, struct
+						   vm_system_aperture_param
+						   *apt)
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 
@@ -248,7 +249,7 @@ void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
 			SYSTEM_ACCESS_MODE, 0x3);
 }
 
-void hubp21_validate_dml_output(struct hubp *hubp,
+static void hubp21_validate_dml_output(struct hubp *hubp,
 		struct dc_context *ctx,
 		struct _vcs_dpi_display_rq_regs_st *dml_rq_regs,
 		struct _vcs_dpi_display_dlg_regs_st *dml_dlg_attr,
@@ -664,7 +665,8 @@ static void program_surface_flip_and_addr(struct hubp *hubp, struct surface_flip
 			flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS);
 }
 
-void dmcub_PLAT_54186_wa(struct hubp *hubp, struct surface_flip_registers *flip_regs)
+static void dmcub_PLAT_54186_wa(struct hubp *hubp, struct surface_flip_registers
+				*flip_regs)
 {
 	struct dc_dmub_srv *dmcub = hubp->ctx->dmub_srv;
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
@@ -697,7 +699,7 @@ void dmcub_PLAT_54186_wa(struct hubp *hubp, struct surface_flip_registers *flip_
 	PERF_TRACE();  // TODO: remove after performance is stable.
 }
 
-bool hubp21_program_surface_flip_and_addr(
+static bool hubp21_program_surface_flip_and_addr(
 		struct hubp *hubp,
 		const struct dc_plane_address *address,
 		bool flip_immediate)
@@ -805,7 +807,7 @@ bool hubp21_program_surface_flip_and_addr(
 	return true;
 }
 
-void hubp21_init(struct hubp *hubp)
+static void hubp21_init(struct hubp *hubp)
 {
 	// DEDCN21-133: Inconsistent row starting line for flip between DPTE and Meta
 	// This is a chicken bit to enable the ECO fix.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
index aa46c35b05a2..439a7de4aaba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
@@ -203,7 +203,7 @@ static bool update_cfg_data(
 	return true;
 }
 
-bool dcn21_link_encoder_acquire_phy(struct link_encoder *enc)
+static bool dcn21_link_encoder_acquire_phy(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 	int value;
@@ -277,7 +277,7 @@ void dcn21_link_encoder_enable_dp_output(
 
 }
 
-void dcn21_link_encoder_enable_dp_mst_output(
+static void dcn21_link_encoder_enable_dp_mst_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
@@ -288,9 +288,8 @@ void dcn21_link_encoder_enable_dp_mst_output(
 	dcn10_link_encoder_enable_dp_mst_output(enc, link_settings, clock_source);
 }
 
-void dcn21_link_encoder_disable_output(
-	struct link_encoder *enc,
-	enum signal_type signal)
+static void dcn21_link_encoder_disable_output(struct link_encoder *enc, enum
+					      signal_type signal)
 {
 	dcn10_link_encoder_disable_output(enc, signal);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index da6031cef244..5e50c264bff8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -784,9 +784,8 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)
 };
 
-struct dce_i2c_hw *dcn21_i2c_hw_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_i2c_hw *dcn21_i2c_hw_create(struct dc_context *ctx, uint32_t
+					      inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
 		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
@@ -1093,7 +1092,7 @@ static void patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 	}
 }
 
-void dcn21_calculate_wm(
+static void dcn21_calculate_wm(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int *out_pipe_cnt,
@@ -1390,7 +1389,7 @@ static noinline bool dcn21_validate_bandwidth_fp(struct dc *dc,
  * with DC_FP_START()/DC_FP_END(). Use the same approach as for
  * dcn20_validate_bandwidth in dcn20_resource.c.
  */
-bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
+static bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
 	bool voltage_supported;
@@ -1480,8 +1479,8 @@ static struct hubbub *dcn21_hubbub_create(struct dc_context *ctx)
 	return &hubbub->base;
 }
 
-struct output_pixel_processor *dcn21_opp_create(
-	struct dc_context *ctx, uint32_t inst)
+static struct output_pixel_processor *dcn21_opp_create(struct dc_context *ctx,
+						       uint32_t inst)
 {
 	struct dcn20_opp *opp =
 		kzalloc(sizeof(struct dcn20_opp), GFP_KERNEL);
@@ -1496,9 +1495,9 @@ struct output_pixel_processor *dcn21_opp_create(
 	return &opp->base;
 }
 
-struct timing_generator *dcn21_timing_generator_create(
-		struct dc_context *ctx,
-		uint32_t instance)
+static struct timing_generator *dcn21_timing_generator_create(struct dc_context
+							      *ctx, uint32_t
+							      instance)
 {
 	struct optc *tgn10 =
 		kzalloc(sizeof(struct optc), GFP_KERNEL);
@@ -1518,7 +1517,7 @@ struct timing_generator *dcn21_timing_generator_create(
 	return &tgn10->base;
 }
 
-struct mpc *dcn21_mpc_create(struct dc_context *ctx)
+static struct mpc *dcn21_mpc_create(struct dc_context *ctx)
 {
 	struct dcn20_mpc *mpc20 = kzalloc(sizeof(struct dcn20_mpc),
 					  GFP_KERNEL);
@@ -1545,8 +1544,8 @@ static void read_dce_straps(
 }
 
 
-struct display_stream_compressor *dcn21_dsc_create(
-	struct dc_context *ctx, uint32_t inst)
+static struct display_stream_compressor *dcn21_dsc_create(struct dc_context
+							  *ctx, uint32_t inst)
 {
 	struct dcn20_dsc *dsc =
 		kzalloc(sizeof(struct dcn20_dsc), GFP_KERNEL);
@@ -1683,9 +1682,9 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
-struct stream_encoder *dcn21_stream_encoder_create(
-	enum engine_id eng_id,
-	struct dc_context *ctx)
+static struct stream_encoder *dcn21_stream_encoder_create(enum engine_id eng_id,
+							  struct dc_context
+							  *ctx)
 {
 	struct dcn10_stream_encoder *enc1 =
 		kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
@@ -1917,7 +1916,8 @@ static int dcn21_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-enum dc_status dcn21_patch_unknown_plane_state(struct dc_plane_state *plane_state)
+static enum dc_status dcn21_patch_unknown_plane_state(struct dc_plane_state
+						      *plane_state)
 {
 	enum dc_status result = DC_OK;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 7aa9aaf5db4c..56750e558d49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -50,9 +50,9 @@
 	enc1->base.ctx
 
 
-void convert_dc_info_packet_to_128(
-	const struct dc_info_packet *info_packet,
-	struct dc_info_packet_128 *info_packet_128)
+static void convert_dc_info_packet_to_128(const struct dc_info_packet
+					  *info_packet, struct
+					  dc_info_packet_128 *info_packet_128)
 {
 	unsigned int i;
 
@@ -489,7 +489,7 @@ static void enc3_dp_set_odm_combine(
 }
 
 /* setup stream encoder in dvi mode */
-void enc3_stream_encoder_dvi_set_stream_attribute(
+static void enc3_stream_encoder_dvi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index c1d967ed6551..65b67cf31e18 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -41,8 +41,7 @@
 	dpp->tf_shift->field_name, dpp->tf_mask->field_name
 
 
-void dpp30_read_state(struct dpp *dpp_base,
-		struct dcn_dpp_state *s)
+static void dpp30_read_state(struct dpp *dpp_base, struct dcn_dpp_state *s)
 {
 	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
 
@@ -373,7 +372,7 @@ void dpp3_set_cursor_attributes(
 }
 
 
-bool dpp3_get_optimal_number_of_taps(
+static bool dpp3_get_optimal_number_of_taps(
 		struct dpp *dpp,
 		struct scaler_data *scl_data,
 		const struct scaling_taps *in_taps)
@@ -474,9 +473,8 @@ bool dpp3_get_optimal_number_of_taps(
 	return true;
 }
 
-void dpp3_cnv_set_bias_scale(
-		struct dpp *dpp_base,
-		struct  dc_bias_and_scale *bias_and_scale)
+static void dpp3_cnv_set_bias_scale(struct dpp *dpp_base, struct
+				    dc_bias_and_scale *bias_and_scale)
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
@@ -488,8 +486,7 @@ void dpp3_cnv_set_bias_scale(
 	REG_UPDATE(FCNV_FP_SCALE_B, FCNV_FP_SCALE_B, bias_and_scale->scale_blue);
 }
 
-void dpp3_deferred_update(
-	struct dpp *dpp_base)
+static void dpp3_deferred_update(struct dpp *dpp_base)
 {
 	int bypass_state;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
@@ -751,8 +748,8 @@ static enum dc_lut_mode dpp3_get_blndgam_current(struct dpp *dpp_base)
 		return mode;
 }
 
-bool dpp3_program_blnd_lut(
-	struct dpp *dpp_base, const struct pwl_params *params)
+static bool dpp3_program_blnd_lut(struct dpp *dpp_base, const struct pwl_params
+				  *params)
 {
 	enum dc_lut_mode current_mode;
 	enum dc_lut_mode next_mode;
@@ -1164,9 +1161,8 @@ static void dpp3_program_shaper_lutb_settings(
 }
 
 
-bool dpp3_program_shaper(
-		struct dpp *dpp_base,
-		const struct pwl_params *params)
+static bool dpp3_program_shaper(struct dpp *dpp_base, const struct pwl_params
+				*params)
 {
 	enum dc_lut_mode current_mode;
 	enum dc_lut_mode next_mode;
@@ -1355,9 +1351,8 @@ static void dpp3_select_3dlut_ram_mask(
 	REG_SET(CM_3DLUT_INDEX, 0, CM_3DLUT_INDEX, 0);
 }
 
-bool dpp3_program_3dlut(
-		struct dpp *dpp_base,
-		struct tetrahedral_params *params)
+static bool dpp3_program_3dlut(struct dpp *dpp_base, struct tetrahedral_params
+			       *params)
 {
 	enum dc_lut_mode mode;
 	bool is_17x17x17;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
index 1c4b171c68ad..7a93eff183d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
@@ -100,7 +100,7 @@ static void mmhubbub3_warmup_mcif(struct mcif_wb *mcif_wb,
 	REG_UPDATE(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB_WARMUP_EN, false);
 }
 
-void mmhubbub3_config_mcif_buf(struct mcif_wb *mcif_wb,
+static void mmhubbub3_config_mcif_buf(struct mcif_wb *mcif_wb,
 		struct mcif_buf_params *params,
 		unsigned int dest_height)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 95149734378b..0ce0d6165f43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1362,7 +1362,7 @@ uint32_t mpcc3_acquire_rmu(struct mpc *mpc, int mpcc_id, int rmu_idx)
 	return -1;
 }
 
-int mpcc3_release_rmu(struct mpc *mpc, int mpcc_id)
+static int mpcc3_release_rmu(struct mpc *mpc, int mpcc_id)
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int rmu_idx;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 48ca4ad0b720..2afd76a6ce5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -875,7 +875,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.use_max_lb = true
 };
 
-void dcn30_dpp_destroy(struct dpp **dpp)
+static void dcn30_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
 	*dpp = NULL;
@@ -992,7 +992,7 @@ static struct mpc *dcn30_mpc_create(
 	return &mpc30->base;
 }
 
-struct hubbub *dcn30_hubbub_create(struct dc_context *ctx)
+static struct hubbub *dcn30_hubbub_create(struct dc_context *ctx)
 {
 	int i;
 
@@ -1143,9 +1143,9 @@ static struct afmt *dcn30_afmt_create(
 	return &afmt3->base;
 }
 
-struct stream_encoder *dcn30_stream_encoder_create(
-	enum engine_id eng_id,
-	struct dc_context *ctx)
+static struct stream_encoder *dcn30_stream_encoder_create(enum engine_id eng_id,
+							  struct dc_context
+							  *ctx)
 {
 	struct dcn10_stream_encoder *enc1;
 	struct vpg *vpg;
@@ -1179,8 +1179,7 @@ struct stream_encoder *dcn30_stream_encoder_create(
 	return &enc1->base;
 }
 
-struct dce_hwseq *dcn30_hwseq_create(
-	struct dc_context *ctx)
+static struct dce_hwseq *dcn30_hwseq_create(struct dc_context *ctx)
 {
 	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
index 736bda30abc3..ad0df1a72a90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
@@ -93,7 +93,7 @@ static unsigned int dcn301_get_16_bit_backlight_from_pwm(struct panel_cntl *pane
 	return (uint32_t)(current_backlight);
 }
 
-uint32_t dcn301_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
+static uint32_t dcn301_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 {
 	struct dcn301_panel_cntl *dcn301_panel_cntl = TO_DCN301_PANEL_CNTL(panel_cntl);
 	uint32_t value;
@@ -147,7 +147,7 @@ uint32_t dcn301_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	return current_backlight;
 }
 
-void dcn301_panel_cntl_destroy(struct panel_cntl **panel_cntl)
+static void dcn301_panel_cntl_destroy(struct panel_cntl **panel_cntl)
 {
 	struct dcn301_panel_cntl *dcn301_panel_cntl = TO_DCN301_PANEL_CNTL(*panel_cntl);
 
@@ -155,7 +155,7 @@ void dcn301_panel_cntl_destroy(struct panel_cntl **panel_cntl)
 	*panel_cntl = NULL;
 }
 
-bool dcn301_is_panel_backlight_on(struct panel_cntl *panel_cntl)
+static bool dcn301_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 {
 	struct dcn301_panel_cntl *dcn301_panel_cntl = TO_DCN301_PANEL_CNTL(panel_cntl);
 	uint32_t value;
@@ -165,7 +165,7 @@ bool dcn301_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 	return value;
 }
 
-bool dcn301_is_panel_powered_on(struct panel_cntl *panel_cntl)
+static bool dcn301_is_panel_powered_on(struct panel_cntl *panel_cntl)
 {
 	struct dcn301_panel_cntl *dcn301_panel_cntl = TO_DCN301_PANEL_CNTL(panel_cntl);
 	uint32_t pwr_seq_state, dig_on, dig_on_ovrd;
@@ -177,7 +177,7 @@ bool dcn301_is_panel_powered_on(struct panel_cntl *panel_cntl)
 	return (pwr_seq_state == 1) || (dig_on == 1 && dig_on_ovrd == 1);
 }
 
-void dcn301_store_backlight_level(struct panel_cntl *panel_cntl)
+static void dcn301_store_backlight_level(struct panel_cntl *panel_cntl)
 {
 	struct dcn301_panel_cntl *dcn301_panel_cntl = TO_DCN301_PANEL_CNTL(panel_cntl);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 907bc4e1978b..10ad5c2803f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -717,15 +717,13 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.use_max_lb = false,
 };
 
-void dcn301_dpp_destroy(struct dpp **dpp)
+static void dcn301_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
 	*dpp = NULL;
 }
 
-struct dpp *dcn301_dpp_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dpp *dcn301_dpp_create(struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn3_dpp *dpp =
 		kzalloc(sizeof(struct dcn3_dpp), GFP_KERNEL);
@@ -741,8 +739,8 @@ struct dpp *dcn301_dpp_create(
 	kfree(dpp);
 	return NULL;
 }
-struct output_pixel_processor *dcn301_opp_create(
-	struct dc_context *ctx, uint32_t inst)
+static struct output_pixel_processor *dcn301_opp_create(struct dc_context *ctx,
+							uint32_t inst)
 {
 	struct dcn20_opp *opp =
 		kzalloc(sizeof(struct dcn20_opp), GFP_KERNEL);
@@ -757,9 +755,8 @@ struct output_pixel_processor *dcn301_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dcn301_aux_engine_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_aux *dcn301_aux_engine_create(struct dc_context *ctx, uint32_t
+						inst)
 {
 	struct aux_engine_dce110 *aux_engine =
 		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
@@ -793,9 +790,8 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)
 };
 
-struct dce_i2c_hw *dcn301_i2c_hw_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct dce_i2c_hw *dcn301_i2c_hw_create(struct dc_context *ctx, uint32_t
+					       inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
 		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
@@ -829,7 +825,7 @@ static struct mpc *dcn301_mpc_create(
 	return &mpc30->base;
 }
 
-struct hubbub *dcn301_hubbub_create(struct dc_context *ctx)
+static struct hubbub *dcn301_hubbub_create(struct dc_context *ctx)
 {
 	int i;
 
@@ -860,9 +856,9 @@ struct hubbub *dcn301_hubbub_create(struct dc_context *ctx)
 	return &hubbub3->base;
 }
 
-struct timing_generator *dcn301_timing_generator_create(
-		struct dc_context *ctx,
-		uint32_t instance)
+static struct timing_generator *dcn301_timing_generator_create(struct dc_context
+							       *ctx, uint32_t
+							       instance)
 {
 	struct optc *tgn10 =
 		kzalloc(sizeof(struct optc), GFP_KERNEL);
@@ -894,8 +890,9 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS4_CAPABLE = true
 };
 
-struct link_encoder *dcn301_link_encoder_create(
-	const struct encoder_init_data *enc_init_data)
+static struct link_encoder *dcn301_link_encoder_create(const struct
+						       encoder_init_data
+						       *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -915,7 +912,9 @@ struct link_encoder *dcn301_link_encoder_create(
 	return &enc20->enc10.base;
 }
 
-struct panel_cntl *dcn301_panel_cntl_create(const struct panel_cntl_init_data *init_data)
+static struct panel_cntl *dcn301_panel_cntl_create(const struct
+						   panel_cntl_init_data
+						   *init_data)
 {
 	struct dcn301_panel_cntl *panel_cntl =
 		kzalloc(sizeof(struct dcn301_panel_cntl), GFP_KERNEL);
@@ -997,9 +996,9 @@ static struct afmt *dcn301_afmt_create(
 	return &afmt3->base;
 }
 
-struct stream_encoder *dcn301_stream_encoder_create(
-	enum engine_id eng_id,
-	struct dc_context *ctx)
+static struct stream_encoder *dcn301_stream_encoder_create(enum engine_id
+							   eng_id, struct
+							   dc_context *ctx)
 {
 	struct dcn10_stream_encoder *enc1;
 	struct vpg *vpg;
@@ -1033,8 +1032,7 @@ struct stream_encoder *dcn301_stream_encoder_create(
 	return &enc1->base;
 }
 
-struct dce_hwseq *dcn301_hwseq_create(
-	struct dc_context *ctx)
+static struct dce_hwseq *dcn301_hwseq_create(struct dc_context *ctx)
 {
 	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_KERNEL);
 
@@ -1182,9 +1180,7 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		dcn_dccg_destroy(&pool->base.dccg);
 }
 
-struct hubp *dcn301_hubp_create(
-	struct dc_context *ctx,
-	uint32_t inst)
+static struct hubp *dcn301_hubp_create(struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn20_hubp *hubp2 =
 		kzalloc(sizeof(struct dcn20_hubp), GFP_KERNEL);
@@ -1201,7 +1197,8 @@ struct hubp *dcn301_hubp_create(
 	return NULL;
 }
 
-bool dcn301_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
+static bool dcn301_dwbc_create(struct dc_context *ctx, struct resource_pool
+			       *pool)
 {
 	int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
@@ -1226,7 +1223,8 @@ bool dcn301_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 	return true;
 }
 
-bool dcn301_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
+static bool dcn301_mmhubbub_create(struct dc_context *ctx, struct resource_pool
+				   *pool)
 {
 	int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 815481a3ef54..ea4f8e06b07c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -462,7 +462,7 @@ void dccg31_set_physymclk(
 }
 
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
-void dccg31_set_dtbclk_dto(
+static void dccg31_set_dtbclk_dto(
 		struct dccg *dccg,
 		int dtbclk_inst,
 		int req_dtbclk_khz,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 80bb09db5e4c..71c359f9cdd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -174,7 +174,7 @@ void dcn31_link_encoder_set_dio_phy_mux(
 	}
 }
 
-void enc31_hw_init(struct link_encoder *enc)
+static void enc31_hw_init(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 3b3721386571..83ece02380a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -65,7 +65,7 @@ static uint32_t dcn31_get_16_bit_backlight_from_pwm(struct panel_cntl *panel_cnt
 	return cmd.panel_cntl.data.current_backlight;
 }
 
-uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
+static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 {
 	struct dcn31_panel_cntl *dcn31_panel_cntl = TO_DCN31_PANEL_CNTL(panel_cntl);
 	struct dc_dmub_srv *dc_dmub_srv = panel_cntl->ctx->dmub_srv;
@@ -96,7 +96,7 @@ uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	return cmd.panel_cntl.data.current_backlight;
 }
 
-void dcn31_panel_cntl_destroy(struct panel_cntl **panel_cntl)
+static void dcn31_panel_cntl_destroy(struct panel_cntl **panel_cntl)
 {
 	struct dcn31_panel_cntl *dcn31_panel_cntl = TO_DCN31_PANEL_CNTL(*panel_cntl);
 
@@ -104,7 +104,7 @@ void dcn31_panel_cntl_destroy(struct panel_cntl **panel_cntl)
 	*panel_cntl = NULL;
 }
 
-bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
+static bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 {
 	union dmub_rb_cmd cmd;
 
@@ -114,7 +114,7 @@ bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 	return cmd.panel_cntl.data.is_backlight_on;
 }
 
-bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
+static bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
 {
 	union dmub_rb_cmd cmd;
 
@@ -124,7 +124,7 @@ bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
 	return cmd.panel_cntl.data.is_powered_on;
 }
 
-void dcn31_store_backlight_level(struct panel_cntl *panel_cntl)
+static void dcn31_store_backlight_level(struct panel_cntl *panel_cntl)
 {
 	union dmub_rb_cmd cmd;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 04b52c9d18da..42eb977a424d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1272,7 +1272,9 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 	return &enc20->enc10.base;
 }
 
-struct panel_cntl *dcn31_panel_cntl_create(const struct panel_cntl_init_data *init_data)
+static struct panel_cntl *dcn31_panel_cntl_create(const struct
+						  panel_cntl_init_data
+						  *init_data)
 {
 	struct dcn31_panel_cntl *panel_cntl =
 		kzalloc(sizeof(struct dcn31_panel_cntl), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 46c433c0bcb0..c0b377e38e24 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1711,7 +1711,8 @@ void dml21_rq_dlg_get_dlg_reg(
 	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
 }
 
-void dml_rq_dlg_get_arb_params(struct display_mode_lib *mode_lib, display_arb_params_st *arb_param)
+static void dml_rq_dlg_get_arb_params(struct display_mode_lib *mode_lib,
+				      display_arb_params_st *arb_param)
 {
 	memset(arb_param, 0, sizeof(*arb_param));
 	arb_param->max_req_outstanding = 256;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index 34f43cb650f8..d62927c1a747 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -40,10 +40,9 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-enum dc_irq_source to_dal_irq_source_dcn10(
-		struct irq_service *irq_service,
-		uint32_t src_id,
-		uint32_t ext_id)
+static enum dc_irq_source to_dal_irq_source_dcn10(struct irq_service
+						  *irq_service, uint32_t src_id,
+						  uint32_t ext_id)
 {
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index a47f68634fc3..960c3c91fd5c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -39,10 +39,9 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-enum dc_irq_source to_dal_irq_source_dcn201(
-		struct irq_service *irq_service,
-		uint32_t src_id,
-		uint32_t ext_id)
+static enum dc_irq_source to_dal_irq_source_dcn201(struct irq_service
+						   *irq_service, uint32_t
+						   src_id, uint32_t ext_id)
 {
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 78940cb20e10..3addc7fabdb1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -40,10 +40,9 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-enum dc_irq_source to_dal_irq_source_dcn21(
-		struct irq_service *irq_service,
-		uint32_t src_id,
-		uint32_t ext_id)
+static enum dc_irq_source to_dal_irq_source_dcn21(struct irq_service
+						  *irq_service, uint32_t src_id,
+						  uint32_t ext_id)
 {
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
index 38e0ade60c7b..fe5efc6f7baa 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
@@ -36,10 +36,9 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-enum dc_irq_source to_dal_irq_source_dcn31(
-		struct irq_service *irq_service,
-		uint32_t src_id,
-		uint32_t ext_id)
+static enum dc_irq_source to_dal_irq_source_dcn31(struct irq_service
+						  *irq_service, uint32_t src_id,
+						  uint32_t ext_id)
 {
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
-- 
2.34.1

