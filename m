Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC13C5516E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 08:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C966A10E802;
	Fri, 20 Feb 2026 08:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="lHL6qqEn";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD1610E1E4;
 Fri, 20 Feb 2026 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=vB5gf81ns3pROnZ/W69kxFt1SWynkuQmH4qkmea41fw=; b=lHL6qqEn93T65THumbvJ0Tsxnc
 6zAxJDG/5E7swh16QfqWan8Co4ED23sNagQrLWnm/Q3MxIbJ87krS5QdOixk6zhIiwv5Oh6a80wIr
 l0qirpqSYCqdWqtQ3lp5r0cND6wvrI1uaJUfx+FP5/b3GowRCC9gID4fxfpwM8DhuEE5tiqUdAY0u
 M2Bcq1Z6jf99ua5apF7tN7u78vHFDhYEZ5HoSNMr9M3bhBtJmts72LFX5Tt5NoRJqS1oWgOy+Dvy8
 6IC+ba6n2OYYHlVngG6EpLmVDexVmdzM+EpYsm1YNRZccQ2Xm+OeIPRaYaujIxM/4Dhsp8U6V574K
 qgQv8xKA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vtKMw-0000000DKX2-1ewU; Fri, 20 Feb 2026 06:52:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/3] drm/amd/display: dmub_cmd.h: correct typos and spellos
Date: Thu, 19 Feb 2026 22:51:53 -0800
Message-ID: <20260220065205.1036179-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 08:45:29 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix spelling issues that are reported by codespell:

dmub_cmd.h:332: alighment ==> alignment
dmub_cmd.h:3684: optimzations ==> optimizations
dmub_cmd.h:4491: isntance ==> instance
dmub_cmd.h:4514: optimzations ==> optimizations
dmub_cmd.h:4604: isntance ==> instance
dmub_cmd.h:4643: isntance ==> instance
dmub_cmd.h:4679: isntance ==> instance
dmub_cmd.h:4699: isntance ==> instance
dmub_cmd.h:4719: isntance ==> instance
dmub_cmd.h:4735: isntance ==> instance
dmub_cmd.h:4749: isntance ==> instance
dmub_cmd.h:4795: isntance ==> instance
dmub_cmd.h:4903: isntance ==> instance
dmub_cmd.h:4936: isntance ==> instance
dmub_cmd.h:5066: re-use ==> reuse
dmub_cmd.h:6552: isntance ==> instance
dmub_cmd.h:6630: isntance ==> instance
dmub_cmd.h:6639: optimzations ==> optimizations
dmub_cmd.h:6720: isntance ==> instance
dmub_cmd.h:6742: isntance ==> instance

and fix a few that I found:

dicated		==> dictated (7x)
afftet		==> after (is this correct?)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Questions:
(a) Is one of "negative" or "pos" incorrect?

	/**
	 * Dark negative gain.
	 */
	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 184B

(b) Is one of "min" or "Maximum" incorrect?

	uint16_t min_frame_rate;	/**< Maximum frame rate */

(c) Is one of "max" or "Minimum" incorrect?

	uint16_t max_frame_rate;	/**< Minimum frame rate */

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>


 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h |   56 +++++++-------
 1 file changed, 28 insertions(+), 28 deletions(-)

--- linux-next-20260218.orig/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ linux-next-20260218/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -329,7 +329,7 @@ union dmub_addr {
 
 /* Flattened structure containing SOC BB parameters stored in the VBIOS
  * It is not practical to store the entire bounding box in VBIOS since the bounding box struct can gain new parameters.
- * This also prevents alighment issues when new parameters are added to the SoC BB.
+ * This also prevents alignment issues when new parameters are added to the SoC BB.
  * The following parameters should be added since these values can't be obtained elsewhere:
  * -dml2_soc_power_management_parameters
  * -dml2_soc_vmin_clock_limits
@@ -3484,7 +3484,7 @@ enum dmub_cmd_psr_type {
 
 	/**
 	 * Set PSR level.
-	 * PSR level is a 16-bit value dicated by driver that
+	 * PSR level is a 16-bit value dictated by driver that
 	 * will enable/disable different functionality.
 	 */
 	DMUB_CMD__PSR_SET_LEVEL			= 4,
@@ -3641,7 +3641,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	union dmub_psr_debug_flags debug;
 	/**
-	 * 16-bit value dicated by driver that will enable/disable different functionality.
+	 * 16-bit value dictated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
 	/**
@@ -3681,7 +3681,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint8_t aux_inst;
 	/**
-	 * Determines if SMU optimzations are enabled/disabled.
+	 * Determines if SMU optimizations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -3798,7 +3798,7 @@ struct dmub_rb_cmd_psr_copy_settings {
  */
 struct dmub_cmd_psr_set_level_data {
 	/**
-	 * 16-bit value dicated by driver that will enable/disable different functionality.
+	 * 16-bit value dictated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
 	/**
@@ -4176,7 +4176,7 @@ struct dmub_rb_cmd_update_cursor_info {
  */
 struct dmub_cmd_psr_set_vtotal_data {
 	/**
-	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when screen idle..
+	 * 16-bit value dictated by driver that indicates the vtotal in PSR active requirement when screen idle..
 	 */
 	uint16_t psr_vtotal_idle;
 	/**
@@ -4190,7 +4190,7 @@ struct dmub_cmd_psr_set_vtotal_data {
 	 */
 	uint8_t panel_inst;
 	/*
-	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
+	 * 16-bit value dictated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
 	 */
 	uint16_t psr_vtotal_su;
 	/**
@@ -4488,7 +4488,7 @@ struct dmub_cmd_replay_copy_settings_dat
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4511,7 +4511,7 @@ struct dmub_cmd_replay_copy_settings_dat
 	 */
 	uint8_t dpphy_inst;
 	/**
-	 * Determines if SMU optimzations are enabled/disabled.
+	 * Determines if SMU optimizations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -4601,7 +4601,7 @@ struct dmub_rb_cmd_smart_power_oled_enab
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4640,7 +4640,7 @@ struct dmub_rb_cmd_replay_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4676,7 +4676,7 @@ struct dmub_rb_cmd_replay_enable {
 struct dmub_cmd_replay_set_power_opt_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4696,7 +4696,7 @@ struct dmub_cmd_replay_set_power_opt_dat
 struct dmub_cmd_replay_set_timing_sync_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4716,7 +4716,7 @@ struct dmub_cmd_replay_set_timing_sync_d
 struct dmub_cmd_replay_set_pseudo_vtotal {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4732,7 +4732,7 @@ struct dmub_cmd_replay_set_pseudo_vtotal
 struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4746,7 +4746,7 @@ struct dmub_cmd_replay_disabled_adaptive
 struct dmub_cmd_replay_set_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4783,7 +4783,7 @@ struct dmub_rb_cmd_replay_set_power_opt
  */
 struct dmub_cmd_replay_set_coasting_vtotal_data {
 	/**
-	 * 16-bit value dicated by driver that indicates the coasting vtotal.
+	 * 16-bit value dictated by driver that indicates the coasting vtotal.
 	 */
 	uint16_t coasting_vtotal;
 	/**
@@ -4792,12 +4792,12 @@ struct dmub_cmd_replay_set_coasting_vtot
 	uint8_t cmd_version;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
 	/**
-	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
+	 * 16-bit value dictated by driver that indicates the coasting vtotal high byte part.
 	 */
 	uint16_t coasting_vtotal_high;
 	/**
@@ -4900,7 +4900,7 @@ struct dmub_rb_cmd_replay_set_general_cm
 struct dmub_cmd_replay_frameupdate_timer_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4933,7 +4933,7 @@ struct dmub_rb_cmd_replay_set_frameupdat
 union dmub_replay_cmd_set {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -5063,7 +5063,7 @@ struct dmub_hw_lock_inst_flags {
 	uint8_t opp_inst;
 	/**
 	 * OTG HW instance for global update lock.
-	 * TODO: Remove, and re-use otg_inst.
+	 * TODO: Remove, and reuse otg_inst.
 	 */
 	uint8_t dig_inst;
 	/**
@@ -6549,7 +6549,7 @@ struct dmub_cmd_pr_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6627,7 +6627,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6636,7 +6636,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint8_t dpphy_inst;
 	/**
-	 * Determines if SMU optimzations are enabled/disabled.
+	 * Determines if SMU optimizations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -6644,7 +6644,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint32_t line_time_in_ns;
 	/*
-	 * Use FSFT afftet pixel clk
+	 * Use FSFT after pixel clk
 	 */
 	uint32_t pix_clk_100hz;
 	/*
@@ -6717,7 +6717,7 @@ union dmub_pr_runtime_flags {
 struct dmub_cmd_pr_update_state_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6739,7 +6739,7 @@ struct dmub_cmd_pr_update_state_data {
 struct dmub_cmd_pr_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
