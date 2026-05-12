Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BACD4F25
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E998010EB4C;
	Tue, 12 May 2026 14:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1hdRFfW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C05C310E0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5vyOTWOWxOaXXv8wQ/ZMTBwJ4ky5BqAT758FgBB5aRQTV8p7Lp9MV5ZkI4SmbGMfRn8RTdFXAdWeqZvYqm3MBitnJ0R7T2KzCNNLG2pzCJL1W9xDCxxVhmvGLBD0nCgwtlRyOJ4vmZH91qaSDlWEFwijcKQPMrd7UwWbneMv41myhuKH7IHuQiQjuC7g18le9efjhrT8mx1hIUOr6mnWZYQKUot02hrLK5mZq/C8HTCSymohEOv/Q4d5+EgonDE+TNm9HM/eHdmts2oCr9hYRI5Zo1V8Asv9AlU1XupKkiR90agR/rJw6avHtsiDCVl2jdVElGrcici5/4E5+JACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCt6UiycqUvaCTWXG33omJ3eonCs1DolBzVo+hNqUa4=;
 b=MJN6O/WyMGSF1FWB7hcptQGaLic0PZSjS1Lo8d3xDdoiyyKyOClvo/ZYqEQ9NGzGm7GL6uC7Hls6FtleXUKPU6+LJoutrNYGLPXtPfdgYdFNc75sNFntyqnTEqWWeXC4XCKodfT++fVB9Jw07EL2xulSIsU7M5RY5GDzRSEPDzTUz+s4z1fZL8PlW7FNhFeJgpXDYj7XoxRpcNPzzyG5t4bw/176w8Y9OJ37QeAGmSl/nJMPTS5QADaqkrf5WnpMyHUVLA9Uzt2xcDA1aafGmSExajBKd9LBijWm7N9WxR/w7Xue7K/DdOi0K2o7H9fykThZf4atpSu0BwG387w1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCt6UiycqUvaCTWXG33omJ3eonCs1DolBzVo+hNqUa4=;
 b=q1hdRFfWFFFo50TvuR8eyIYfPjVh4l+DvO2tJ0oCkqRNnLxyb63EVldEJ2XypolDrEzHDTUWZcLE+CjI17TF1TfFsZ35aqeCgcy3DNkWzOytKYxnIzfGzxCsMEtQzIBKFkZrQTRJu6uebJ0gTdetDIVcq175Srijd33CX9qVLN8=
Received: from MN2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:208:e8::37)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:23:19 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::f8) by MN2PR20CA0024.outlook.office365.com
 (2603:10b6:208:e8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 14:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 14:23:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:23:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 07:23:16 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 09:23:15 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v4 01/13] drm/amd/display: Add HDMI FRL definitions to includes
Date: Tue, 12 May 2026 10:22:55 -0400
Message-ID: <20260512142308.131260-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512142308.131260-1-harry.wentland@amd.com>
References: <20260512142308.131260-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 53525576-55df-462e-63a2-08deb0320349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799003|56012099003|22082099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: 4viAQ7tvITNo0tuxCYjke4pjEPfaFX6ILG6G9D5dtE4xeNbbv19pdCJ4in5pH6HDtzp0VAL6tQQnq9dCQOHGA4NfsYYrdSbaCOyL9hn3GHBYlJ+IFbRlKGhLb8r4Zef0oEXHB+ujN02llfqHePUf21OZ5WethSVyhiCPVu5FaMg7vVCosh0cFHKzVcqYFwtyv/s8CghM9YHxCO9jDXKnN1SC9jUEj4AasVjak7VB70xAH8NFldK3qlu3L2QBgkkz2KpsjWUJKVMRoPaKi5IB/NUIDBYS5CNs4pnsUoSD29wkS6fqD8+0wyEGI0RL6ANqFFLg3U0ee+fLW5Vnw/WZfbLjx6JUbtENxknZA1n9/UVhmybL5n00kF69N6QnHC61i+stJby4QYuOesGNtxya7t72w6EpFCV1w8oZ+AdX8pEWXzmgHHS02JHQ1qazlyMVf9F1xXFWilb/CLntkIdsbTx0dMTrWyzoI5T5stu8z+3aWjenwmd0DZhpnDoHGN87s0hAKhCdGLcjqwfWgr1ObwitU3rm0hv6fhyixMFFM0D7B8pWneSanoIabdd9209NDUsQ8ONvZb268W7HwdJAD5bIiN3F9uY64cs2ifiNj2fY9Q/fzjaO8kN1sNqboXdb7J5FcK+Z/80r1nlk+0VIIqIgwVYon7IzGLC5csZAa4sufaQ29awgK+tHRLA96bQfSPwJCNk3IoI+NmkblGwdcSDyBgbjj+GO0S9godY9/iQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799003)(56012099003)(22082099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OIUhhznAucgfdgna60hiDvmiGnqy+mZiwM/LE509K2ylShQxAvpYHj1eCqqy4H7ctc70BuHLsoNVcLZ01i7WHZm7qH1IS6TDONeQFimDokEEpjqVKHzE6zeEbmawFe49JLV3gnrjrBBSY7Rp3q48cs3WJzGJc23KSIuzrAcl9fpx3oT7/YT8vhlj7r/usAHXFm2iDYaSdQ6EqZeLId9vdg3wUFbXOuIB6yjhQbanQ5H7/qAJaQAe6yANVLkK/+WsTBFO2Ctdl1nN1zextrC69W7rqOMQ3LPZIUXOHxbO7InZeh2CurU1bCyZ/keBc78yVuT3XgO4YCOQ/VMUKh14xmnwIs9eOcmDocK3Qu4Dcnw71UQ4miBHeVDdDbl/zyYJowsdsl12RCe07+1zlWizmcDaQYi/6MtJabQLONZcg1l6tdVEXDO7qA5RydT/Iafw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:23:18.2759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53525576-55df-462e-63a2-08deb0320349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

This patch adds all relevant includes in DC that are
used by the HDMI FRL implementation in DC.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           | 121 ++++++++++
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    | 162 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   8 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  24 ++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   1 +
 .../drm/amd/display/dc/dm_services_types.h    |   1 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h | 173 +++++++++++++
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  10 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  | 176 ++++++++++++++
 .../amd/display/dc/inc/hw/stream_encoder.h    | 227 ++++++++++++++++++
 .../amd/display/dc/inc/hw/timing_generator.h  |   6 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |  15 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   7 +
 .../gpu/drm/amd/display/include/audio_types.h |   1 +
 .../amd/display/include/bios_parser_types.h   |  14 +-
 .../drm/amd/display/include/logger_types.h    |   2 +
 .../drm/amd/display/include/signal_types.h    |  12 +-
 20 files changed, 966 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0b6fad65bc0..0cbb60325875 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -46,6 +46,8 @@
 
 #include "dmub/inc/dmub_cmd.h"
 
+#include "dml/dml1_frl_cap_chk.h"
+
 #include "sspl/dc_spl_types.h"
 
 struct abm_save_restore;
@@ -84,6 +86,49 @@ struct dcn_dccg_reg_state;
 
 #define NUM_FAST_FLIPS_TO_STEADY_STATE 20
 
+struct frl_cap_chk_intermediates_fixed31_32 {
+	int      c_frl_sb;
+	struct fixed31_32   overhead_sb;
+	struct fixed31_32   overhead_rs;
+	struct fixed31_32   overhead_map;
+	struct fixed31_32   overhead_min;
+	struct fixed31_32   overhead_max;
+	struct fixed31_32   f_pixel_clock_max;
+	struct fixed31_32   t_line;
+	struct fixed31_32   r_bit_min;
+	struct fixed31_32   r_frl_char_min;
+	struct fixed31_32   c_frl_line;
+	struct fixed31_32   ap;
+	struct fixed31_32   r_ap;
+	struct fixed31_32   avg_audio_packets_line;
+	struct fixed31_32   margin;
+	int      audio_packets_line;
+	int      blank_audio_min;
+};
+
+struct frl_cap_chk_params_fixed31_32 {
+	int      lanes;
+	struct fixed31_32   f_pixel_clock_nominal;   /* Pixel Clock rate (Hz)  */
+	struct fixed31_32   r_bit_nominal;           /* FRL bitrate (bps) */
+	int      audio_packet_type;
+	struct fixed31_32   f_audio;                 /* Audio rate (Hz) */
+	int      h_active;                /* Active pixels per line */
+	int      h_blank;                 /* Blanking pixels per line */
+	int      bpc;                     /* Bits per component */
+	int      vic;                     /* Video Identification Code */
+
+	enum hdmi_frl_pixel_encoding    pixel_encoding;
+
+	bool     compressed;              /* set to true if DSC is enabled */
+	bool     bypass_hc_target_calc;   /* debug only */
+	int      layout;
+	int      acat;    /* not supported */
+
+	/* outputs */
+	struct frl_dml_borrow_params borrow_params;
+	int      average_tribyte_rate;
+};
+
 /* Display Core Interfaces */
 struct dc_versions {
 	const char *dc_ver;
@@ -332,6 +377,7 @@ struct dc_caps {
 	bool ips_v2_support;
 	uint32_t num_of_internal_disp;
 	enum dp_protocol_version max_dp_protocol_version;
+	bool hdmi_hpo;
 	unsigned int mall_size_per_mem_channel;
 	unsigned int mall_size_total;
 	unsigned int cursor_cache_size;
@@ -537,6 +583,8 @@ struct dc_config {
 	int smart_mux_version;
 	bool ignore_dpref_ss;
 	bool enable_mipi_converter_optimization;
+	bool force_hdmi21_frl_enc_enable;
+	bool skip_frl_pretraining;
 	bool use_default_clock_table;
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
@@ -1096,6 +1144,18 @@ struct dc_debug_options {
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
+	bool force_vrr;
+	bool force_fva;
+	int max_frl_rate;
+	int  force_frl_rate;
+	bool ignore_ffe;
+	int  select_ffe;
+	int  limit_ffe;
+	bool force_frl_always;
+	bool force_frl_max;
+	bool apply_vsdb_rcc_wa;
+	bool enable_hdmi_idcc;
+
 	bool enable_dram_clock_change_one_display_vactive;
 	/* TODO - remove once tested */
 	bool legacy_dp2_lt;
@@ -1635,6 +1695,7 @@ struct dc_scratch_space {
 	bool edp_sink_present;
 
 	struct dp_trace dp_trace;
+	volatile bool is_link_locked;
 
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
@@ -1649,6 +1710,7 @@ struct dc_scratch_space {
 	 * management of the override pointers.
 	 */
 	struct dc_link_training_overrides preferred_training_settings;
+	struct dc_hdmi_frl_link_training_overrides preferred_hdmi_frl_settings;
 	struct dp_audio_test_data audio_test_data;
 
 	enum gpio_ddc_line ddc_hw_inst;
@@ -1694,6 +1756,12 @@ struct dc_scratch_space {
 
 	struct panel_cntl *panel_cntl;
 	struct link_encoder *link_enc;
+	struct hpo_frl_link_encoder *hpo_frl_link_enc;
+	struct dc_hdmi_frl_link_settings frl_reported_link_cap;
+	struct dc_hdmi_frl_link_settings frl_verified_link_cap;
+	struct dc_hdmi_frl_link_settings frl_link_settings;
+	struct dc_hdmi_frl_flags frl_flags;
+	union hdmi_idcc_cable_id hdmi_cable_id;
 	struct graphics_object_id link_id;
 
 	/* External encoder eg. NUTMEG or TRAVIS used on CIK APUs. */
@@ -2033,6 +2101,17 @@ struct dc_plane_state *dc_get_surface_for_mpcc(struct dc *dc,
 
 
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
+bool dc_set_fva_vrr_adjust(struct dc *dc,
+	struct dc_stream_state *stream,
+	struct fva_adj *fva_adj,
+	struct dc_crtc_timing_adjust *vrr_adj);
+
+int dc_get_hw_max_fva_factor(struct dc *dc,
+		struct dc_stream_state *stream,
+		unsigned int max_pixel_clock);
+
+void dc_set_vstartup_start(struct dc *dc,
+		struct dc_stream_state *stream);
 
 void dc_set_disable_128b_132b_stream_overhead(bool disable);
 
@@ -2244,6 +2323,12 @@ enum dc_status dc_link_dp_read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data);
 
+bool dc_link_frl_poll_status_flag(struct dc_link *link);
+bool dc_link_frl_margin_check_uncompressed_video(
+		const struct dc_link *link,
+		struct frl_cap_chk_params_fixed31_32 *params,
+		struct frl_cap_chk_intermediates_fixed31_32 *inter);
+
 /* The function clears recorded DP RX states in the link. DM should call this
  * function when it is resuming from S3 power state to previously connected links.
  *
@@ -2268,6 +2353,12 @@ uint32_t dc_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_setting);
 
+/* The function returns effective HDMI FRL bandwidth given link rate.
+ * return - total effective link bandwidth in kbps.
+ */
+uint32_t dc_link_frl_bandwidth_kbps(const struct dc_link *link,
+		enum hdmi_frl_link_rate link_rate);
+
 struct dp_audio_bandwidth_params {
 	const struct dc_crtc_timing *crtc_timing;
 	enum dp_link_encoding link_encoding;
@@ -2319,6 +2410,8 @@ void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
  */
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
 
+void dc_link_wait_for_unlocked(struct dc_link *link);
+
 /* TODO: this is not meant to be exposed to DM. Should switch to stream update
  * interface i.e stream_update->dsc_config
  */
@@ -2372,6 +2465,16 @@ const struct dc_link_settings *dc_link_get_link_cap(const struct dc_link *link);
  */
 enum dc_link_encoding_format dc_link_get_highest_encoding_format(const struct dc_link *link);
 
+/* get max frl link settings the link can enable with all things considered.
+ * (i.e TX/RX capabilities and link verification result.
+ *
+ * @link - a link with FRL RX connection
+ * return - max frl link settings the link can enable.
+ *
+ */
+struct dc_hdmi_frl_link_settings *dc_link_get_frl_link_cap(
+		struct dc_link *link);
+
 /* Check if a RX (ex. DP sink, MST hub, passive or active dongle) is connected
  * to a link with dp connector signal type.
  * @link - a link with dp connector signal type
@@ -2421,6 +2524,16 @@ void dc_link_set_preferred_link_settings(struct dc *dc,
 		struct dc_link_settings *link_setting,
 		struct dc_link *link);
 
+/* Force FRL link settings to always use a specific value until reboot to a
+ * specific link. If link has already been enabled, the interface will also
+ * switch to desired link settings immediately. This is a debug interface to
+ * generic FRL issue trouble shooting.
+ */
+void dc_link_set_preferred_frl_link_settings(struct dc *dc,
+		struct dc_hdmi_frl_link_settings *link_setting,
+		struct dc_hdmi_frl_link_training_overrides *lt_overrides,
+		struct dc_link *link);
+
 /* Force DP link to customize a specific link training behavior by overriding to
  * standard DP specs defined protocol. This is a debug interface to trouble shoot
  * display specific link training issues or apply some display specific
@@ -3094,6 +3207,14 @@ struct dc_register_software_state {
 		uint32_t symclk32_le_enable[2];          /* SYMCLK32_LE_CNTL->SYMCLK32_LE0_EN from dccg31_enable_symclk32_le() enable */
 		uint32_t symclk32_le_gate_disable[2];    /* DCCG_GATE_DISABLE_CNTL3->SYMCLK32_LE0_GATE_DISABLE from debug.root_clock_optimization.bits.symclk32_le */
 
+		/* HDMI Clock Control */
+		uint32_t hdmicharclk_enable;             /* HDMICHARCLK0_CLOCK_CNTL->HDMICHARCLK0_EN from dccg31_enable_hdmicharclk() */
+		uint32_t hdmicharclk_src_sel;            /* HDMICHARCLK0_CLOCK_CNTL->HDMICHARCLK0_SRC_SEL from dccg31_enable_hdmicharclk() phypll_inst source */
+		uint32_t hdmistreamclk_src_sel;          /* HDMISTREAMCLK_CNTL->HDMISTREAMCLK0_SRC_SEL from dccg31_set_hdmistreamclk() src selection */
+		uint32_t hdmistreamclk_dto_force_dis;    /* HDMISTREAMCLK_CNTL->HDMISTREAMCLK0_DTO_FORCE_DIS from dccg31_set_hdmistreamclk() DTO force bypass */
+		uint32_t hdmistreamclk_dto_phase;        /* HDMISTREAMCLK0_DTO_PARAM->HDMISTREAMCLK0_DTO_PHASE from dccg31_disable_hdmistreamclk() */
+		uint32_t hdmistreamclk_dto_modulo;       /* HDMISTREAMCLK0_DTO_PARAM->HDMISTREAMCLK0_DTO_MODULO from dccg31_disable_hdmistreamclk() */
+
 		/* DPIA Clock Control */
 		uint32_t dpiaclk_540m_dto_modulo;        /* DPIACLK_540M_DTO_MODULO->DPIA 540MHz DTO modulo */
 		uint32_t dpiaclk_540m_dto_phase;         /* DPIACLK_540M_DTO_PHASE->DPIA 540MHz DTO phase */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index fcd3ab4b0045..afd21eb6bbcd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -65,19 +65,65 @@ struct dp_hdmi_dongle_signature_data {
 #define HDMI_SCDC_CONFIG_1 0x31
 #define HDMI_SCDC_SOURCE_TEST_REQ 0x35
 #define HDMI_SCDC_STATUS_FLAGS 0x40
+#define HDMI_SCDC_LTP_REQ 0x41
 #define HDMI_SCDC_ERR_DETECT 0x50
 #define HDMI_SCDC_TEST_CONFIG 0xC0
 
 #define HDMI_SCDC_MANUFACTURER_OUI 0xD0
 #define HDMI_SCDC_DEVICE_ID 0xDB
 
+/* IDCC defines (HDMI 2.0) */
+#define HDMI_IDCC_ADDRESS 0x50
+#define HDMI_IDCC_MARKER0 0xAE
+#define HDMI_IDCC_MARKER1 0x6E
+#define HDMI_IDCC_MARKER2 0x60
+
+enum hdmi_idcc_scope {
+	HDMI_IDCC_SCOPE_WRITE = 0x00,
+	HDMI_IDCC_SCOPE_RW_CA = 0x01,
+	HDMI_IDCC_SCOPE_RW_SINK = 0x02,
+};
+
+union hdmi_idcc_source_id {
+	struct {
+		uint8_t SI_PCA_n:1;
+		uint8_t AC_n:1;
+		uint8_t RESERVED:6;
+	} bits;
+	uint8_t raw;
+};
+
+union hdmi_idcc_cable_id {
+	struct {
+		uint8_t Cat1_n:1;
+		uint8_t Cat2_n:1;
+		uint8_t Cat3_n:1;
+		uint8_t Cat4_n:1;
+		uint8_t RESERVED:4;
+		uint8_t HEAC_n:1;
+		uint8_t PCA_DEP_n:1;
+		uint8_t MonoDir_n:1;
+		uint8_t MonoDirErr_n:1;
+		uint8_t PCA_ON_n:1;
+		uint8_t no_DeEmphasis_n:1;
+		uint8_t no_PreShoot_n:1;
+		uint8_t RESERVED2:1;
+		uint8_t RND_bits_7_0:8;
+		uint8_t RND_bits_15_8:8;
+	} bits;
+	uint8_t raw[4];
+};
 union hdmi_scdc_update_read_data {
 	uint8_t byte[2];
 	struct {
 		uint8_t STATUS_UPDATE:1;
 		uint8_t CED_UPDATE:1;
 		uint8_t RR_TEST:1;
-		uint8_t RESERVED:5;
+		uint8_t SOURCE_TEST_UPDATE:1;
+		uint8_t FRL_START:1;
+		uint8_t FLT_UPDATE:1;
+		uint8_t RSED_UPDATE:1;
+		uint8_t RESERVED:1;
 		uint8_t RESERVED2:8;
 	} fields;
 };
@@ -89,7 +135,19 @@ union hdmi_scdc_status_flags_data {
 		uint8_t CH0_LOCKED:1;
 		uint8_t CH1_LOCKED:1;
 		uint8_t CH2_LOCKED:1;
-		uint8_t RESERVED:4;
+		uint8_t LANE3_LOCKED:1;
+		uint8_t RESERVED:1;
+		uint8_t FLT_READY:1;
+	} fields;
+};
+
+union hdmi_scdc_LTP_req_data {
+	uint8_t byte[2];
+	struct {
+		uint8_t LN0_LTP_REQ:4;
+		uint8_t LN1_LTP_REQ:4;
+		uint8_t LN2_LTP_REQ:4;
+		uint8_t LN3_LTP_REQ:4;
 	} fields;
 };
 
@@ -106,10 +164,12 @@ union hdmi_scdc_ced_data {
 		uint8_t CH2_7HIGH:7;
 		uint8_t CH2_VALID:1;
 		uint8_t CHECKSUM:8;
-		uint8_t RESERVED:8;
-		uint8_t RESERVED2:8;
-		uint8_t RESERVED3:8;
-		uint8_t RESERVED4:4;
+		uint8_t LN3_8LOW:8;
+		uint8_t LN3_7HIGH:7;
+		uint8_t LN3_VALID:1;
+		uint8_t RSC_8LOW:8;
+		uint8_t RSC_7HIGH:7;
+		uint8_t RSC_VALID:1;
 	} fields;
 };
 
@@ -130,4 +190,94 @@ union hdmi_scdc_device_id_data {
 	} fields;
 };
 
+union hdmi_scdc_configuration {
+	uint8_t byte[2];
+	struct {
+		uint8_t RR_ENABLE:1;
+		uint8_t FLT_NO_RETRAIN:1;
+		uint8_t RESERVED:6;
+		uint8_t FRL_RATE:4;
+		uint8_t FFE_LEVELS:4;
+	} fields;
+};
+
+union hdmi_scdc_source_test_req {
+	uint8_t byte;
+	struct {
+		uint8_t RESERVED:1;
+		uint8_t TXFFE_PRESHOOT:1;
+		uint8_t TXFFE_DEEMPHASIS:1;
+		uint8_t TXFFE_NOFFE:1;
+		uint8_t RESERVED2:1;
+		uint8_t FLT_NO_TIMEOUT:1;
+		uint8_t DSC_FRL_MAX:1;
+		uint8_t FRL_MAX:1;
+	} fields;
+};
+
+union hdmi_scdc_test_config_Data {
+	uint8_t byte;
+	struct {
+		uint8_t TEST_READ_REQUEST_DELAY:7;
+		uint8_t TEST_READ_REQUEST: 1;
+	} fields;
+};
+
+enum hdmi_frl_borrow_mode {
+	BORROW_MODE_NONE,
+	BORROW_MODE_FROM_ACTIVE,
+	BORROW_MODE_FROM_BLANK
+};
+
+enum link_result {
+	LINK_RESULT_UNKNOWN = 0,
+	LINK_RESULT_SUCCESS,
+	LINK_RESULT_LOWER_LINKRATE,
+	LINK_RESULT_TIMEOUT,
+	LINK_RESULT_FALLBACK
+};
+
+enum hdmi_frl_link_rate {
+	HDMI_FRL_LINK_RATE_DISABLE = 0,
+	HDMI_FRL_LINK_RATE_3GBPS,
+	HDMI_FRL_LINK_RATE_6GBPS,
+	HDMI_FRL_LINK_RATE_6GBPS_4LANE,
+	HDMI_FRL_LINK_RATE_8GBPS,
+	HDMI_FRL_LINK_RATE_10GBPS,
+	HDMI_FRL_LINK_RATE_12GBPS,
+	HDMI_FRL_LINK_RATE_16GBPS,
+	HDMI_FRL_LINK_RATE_20GBPS,
+	HDMI_FRL_LINK_RATE_24GBPS
+};
+
+struct frl_borrow_params {
+	int audio_packets_line;
+	int hc_active_target;
+	int hc_blank_target;
+	enum hdmi_frl_borrow_mode borrow_mode;
+};
+
+struct dc_hdmi_frl_link_settings {
+	enum hdmi_frl_link_rate frl_link_rate;
+	uint8_t frl_num_lanes;
+	struct frl_borrow_params borrow_params;
+	int average_tribyte_rate;
+};
+
+struct dc_hdmi_frl_flags {
+	int  force_frl_rate;
+	bool ignore_ffe;
+	int  select_ffe;
+	int  limit_ffe;
+	bool force_frl_always;
+	bool force_frl_max;
+	bool apply_vsdb_rcc_wa;
+};
+
+struct dc_hdmi_frl_link_training_overrides {
+	bool force_frl_always;
+	bool force_frl_max;
+	uint8_t max_retries;
+	bool valid;
+};
 #endif /* DC_HDMI_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index c2ca08d26e37..c13a824c9d35 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -886,6 +886,8 @@ struct dc_dsc_config {
 	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
 	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
 	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
+	bool is_vic_all_bpp; /* indicate of DSC_ALL_BPP = 1 */
+	uint32_t total_chunk_kbytes; /* total chunk kbytes in EDID */
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
 	uint32_t mst_pbn; /* pbn of display on dsc mst hub */
 	const struct dc_dsc_rc_params_override *rc_params_ovrd; /* DM owned memory. If not NULL, apply custom dsc rc params */
@@ -1162,6 +1164,12 @@ struct tg_color {
 	uint16_t color_b_cb;
 };
 
+struct fva_adj {
+	unsigned int pixel_clock_100hz;
+	unsigned int max_pixel_clock_100hz;
+	unsigned int fva_factor;
+};
+
 enum symclk_state {
 	SYMCLK_OFF_TX_OFF,
 	SYMCLK_ON_TX_ON,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 3ec49f4e277f..4ed1efa17270 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -77,6 +77,7 @@ struct dc_perf_trace {
 };
 
 #define NUM_PIXEL_FORMATS 10
+#define DTBCLK_LIMIT 2920
 
 enum tiling_mode {
 	TILING_MODE_INVALID,
@@ -174,6 +175,14 @@ struct dc_panel_patch {
 	unsigned int max_dsc_target_bpp_limit;
 	unsigned int embedded_tiled_slave;
 	unsigned int disable_fams;
+	unsigned int hdmi_spe_handling;
+	unsigned int block_420_Freesync;
+	unsigned int block_10g;
+	unsigned int hdmi_comp_manual;
+	unsigned int hdmi_comp_auto;
+	unsigned int force_frl;
+	unsigned int vsdb_rcc_wa;
+	unsigned int delay_hdmi_link_training;
 	unsigned int skip_avmute;
 	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
@@ -221,6 +230,17 @@ struct dc_edid_caps {
 	bool scdc_present;
 	bool analog;
 
+	/*HDMI 2.1 caps*/
+	uint8_t max_frl_rate;
+	bool frl_dsc_support;
+	bool frl_dsc_10bpc;
+	bool frl_dsc_12bpc;
+	bool frl_dsc_all_bpp;
+	bool frl_dsc_native_420;
+	uint8_t frl_dsc_max_slices;
+	uint8_t frl_dsc_max_frl_rate;
+	uint8_t frl_dsc_total_chunk_kbytes;
+
 	struct dc_panel_patch panel_patch;
 };
 
@@ -545,6 +565,7 @@ struct audio_info {
 struct audio_check {
 	unsigned int audio_packet_type;
 	unsigned int max_audiosample_rate;
+	unsigned int max_channel_count;
 	unsigned int acat;
 };
 enum dc_infoframe_type {
@@ -929,6 +950,9 @@ struct dsc_dec_dpcd_caps {
 	uint32_t branch_overall_throughput_0_mps; /* In MPs */
 	uint32_t branch_overall_throughput_1_mps; /* In MPs */
 	uint32_t branch_max_line_width;
+	bool is_frl; /* Decoded format */
+	bool is_vic_all_bpp;
+	uint32_t total_chunk_kbytes;
 	bool is_dp; /* Decoded format */
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index f4d3f04ec857..cb20bfe9c1c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -41,6 +41,7 @@ struct cp_psp_stream_config {
 	uint8_t phy_idx;
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
+	uint8_t frl_enabled;
 	uint8_t dp2_enabled;
 	uint8_t usb4_enabled;
 	void *dm_stream_ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index 3b093b8699ab..e676e395cabf 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -292,6 +292,7 @@ struct dm_process_phy_transition_init_params {
 	enum dc_link_rate display_port_link_rate;
 	uint32_t transition_bitmask;
 	uint8_t hdmi_frl_num_lanes;
+	enum hdmi_frl_link_rate hdmi_frl_link_rate;
 };
 
 struct dm_process_phy_transition_input_params {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
new file mode 100644
index 000000000000..debe4c1dc0f7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DML1_FRL_CAP_CHK_H__
+#define __DML1_FRL_CAP_CHK_H__
+
+#include "os_types.h"
+
+#define TB_BORROWED_MAX	  400
+#define C_FRL_CB	  510
+#define TOLERANCE_FRL_BIT 300    /* ppm */
+#define ACR_RATE_MAX	  1500
+
+enum hdmi_frl_pixel_encoding {
+	HDMI_FRL_PIXEL_ENCODING_444,
+	HDMI_FRL_PIXEL_ENCODING_422,
+	HDMI_FRL_PIXEL_ENCODING_420
+};
+
+enum frl_cap_chk_result {
+	FRL_CAP_CHK_OK = 0,
+
+	FRL_CAP_CHK_ERROR_AUDIO_BW   = -1,
+	FRL_CAP_CHK_ERROR_BORROW     = -2,
+	FRL_CAP_CHK_ERROR_MAX_BORROW = -3,
+	FRL_CAP_CHK_ERROR_MARGIN     = -4,
+
+	FRL_CAP_CHK_ERROR_UNSUPPORTED_AUDIO = -1000
+};
+
+enum frl_borrow_mode {
+	FRL_BORROW_MODE_NONE,
+	FRL_BORROW_MODE_FROM_ACTIVE,
+	FRL_BORROW_MODE_FROM_BLANK
+};
+
+enum frl_link_rate {
+	FRL_LINK_RATE_DISABLE = 0,
+	FRL_LINK_RATE_3GBPS,
+	FRL_LINK_RATE_6GBPS,
+	FRL_LINK_RATE_6GBPS_4LANE,
+	FRL_LINK_RATE_8GBPS,
+	FRL_LINK_RATE_10GBPS,
+	FRL_LINK_RATE_12GBPS,
+	FRL_LINK_RATE_16GBPS,
+	FRL_LINK_RATE_20GBPS,
+	FRL_LINK_RATE_24GBPS
+};
+
+struct frl_dml_borrow_params {
+	int audio_packets_line;
+	int hc_active_target;
+	int hc_blank_target;
+	enum frl_borrow_mode borrow_mode;
+};
+
+struct frl_primary_format {
+	uint32_t vic;
+	uint32_t frl_rate;
+	uint32_t frl_lanes;
+	uint32_t hc_active;
+	uint32_t hc_blank;
+};
+
+struct frl_cap_chk_intermediates {
+	int      c_frl_sb;
+	double   overhead_sb;
+	double   overhead_rs;
+	double   overhead_map;
+	double   overhead_min;
+	double   overhead_max;
+	double   f_pixel_clock_max;
+	double   t_line;
+	double   r_bit_min;
+	double   r_frl_char_min;
+	double   c_frl_line;
+	double   ap;
+	double   r_ap;
+	double   avg_audio_packets_line;
+	int      audio_packets_line;
+	int      blank_audio_min;
+};
+
+struct frl_cap_chk_params {
+	int      lanes;
+	double   f_pixel_clock_nominal;   /* Pixel Clock rate (Hz)  */
+	double   r_bit_nominal;           /* FRL bitrate (bps) */
+	int      audio_packet_type;
+	double   f_audio;                 /* Audio rate (Hz) */
+	int      h_active;                /* Active pixels per line */
+	int      h_blank;                 /* Blanking pixels per line */
+	int      bpc;                     /* Bits per component */
+	int      vic;                     /* Video Identification Code */
+
+	enum hdmi_frl_pixel_encoding    pixel_encoding;
+
+	bool     compressed;              /* set to true if DSC is enabled */
+	bool     bypass_hc_target_calc;   /* debug only */
+	bool     allow_all_bpp;           /* dsc_all_bpp */
+
+	/* DSC parameters */
+	int      slices;
+	int      slice_width;
+	double   bpp_target;
+	bool     is_ovt;
+	int      layout;
+	int      acat;    /* not supported */
+
+	/* outputs */
+	struct frl_dml_borrow_params borrow_params;
+	int      average_tribyte_rate;
+};
+
+enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params);
+
+enum frl_cap_chk_result dml1_frl_cap_chk_inter(struct frl_cap_chk_params *params,
+					       struct frl_cap_chk_intermediates *inter);
+
+enum frl_cap_chk_result dml1_frl_cap_chk_common(struct frl_cap_chk_intermediates *inter,
+						struct frl_cap_chk_params *params);
+
+enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params *params,
+						      struct frl_cap_chk_intermediates *inter);
+
+enum frl_cap_chk_result dml1_frl_cap_chk_compressed(struct frl_cap_chk_params *params,
+						    struct frl_cap_chk_intermediates *inter);
+#endif
+
+void frl_modified_pix_clock_for_dsc_padding(const int hc_active_target,
+	const int hc_blank_target,
+	const uint8_t frl_num_lanes,
+	const uint32_t pix_clk_100hz,
+	const int frl_link_rate,
+	const uint32_t h_addressable,
+	const uint32_t h_border_left,
+	const uint32_t h_border_right,
+	const uint32_t h_total,
+	const uint32_t h_addressable_otg,
+	uint32_t *pix_clk_100hz_otg,
+	uint32_t *h_total_otg);
+
+int frl_modify_borrow_mode_for_dsc_padding(const uint32_t pix_clk_100hz,
+	const uint32_t h_active,
+	const uint32_t h_active_padded,
+	const uint32_t h_blank,
+	const uint32_t h_blank_padded,
+	const int hc_active,
+	const int hc_blank,
+	const uint8_t frl_num_lanes,
+	const int frl_link_rate);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 82085d9c3f40..388f801f4582 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -48,6 +48,8 @@ enum dc_status {
 	DC_FAIL_DSC_VALIDATE = 16,
 	DC_NO_DSC_RESOURCE = 17,
 	DC_FAIL_UNSUPPORTED_1 = 18,
+	DC_FAIL_HDMI_FRL_LINK_TRAINING = 19,
+	DC_NO_HDMI_FRL_LINK_BANDWIDTH = 20,
 	DC_FAIL_CLK_EXCEED_MAX = 21,
 	DC_FAIL_CLK_BELOW_MIN = 22, /*THIS IS MIN PER IP*/
 	DC_FAIL_CLK_BELOW_CFG_REQUIRED = 23, /*THIS IS hard_min in PPLIB*/
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index a99e1937f8ce..cbbc1fb4b3dd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -82,6 +82,9 @@ struct resource_funcs {
 	/* Create a minimal link encoder object with no dc_link object
 	 * associated with it. */
 	struct link_encoder *(*link_enc_create_minimal)(struct dc_context *ctx, enum engine_id eng_id);
+	struct hpo_frl_link_encoder *(*hpo_frl_link_enc_create)(
+			enum engine_id eng_id,
+			struct dc_context *ctx);
 	enum dc_status (*validate_bandwidth)(
 					struct dc *dc,
 					struct dc_state *context,
@@ -285,6 +288,10 @@ struct resource_pool {
 	/* Number of USB4 DPIA (DisplayPort Input Adapter) link objects created.*/
 	unsigned int usb4_dpia_count;
 
+	unsigned int hpo_frl_stream_enc_count;
+	struct hpo_frl_stream_encoder *hpo_frl_stream_enc[MAX_HDMI_FRL_ENCODERS];
+	unsigned int hpo_frl_link_enc_count;
+	struct hpo_frl_link_encoder *hpo_frl_link_enc[MAX_HDMI_FRL_ENCODERS];
 	unsigned int hpo_dp_stream_enc_count;
 	struct hpo_dp_stream_encoder *hpo_dp_stream_enc[MAX_HPO_DP2_ENCODERS];
 	unsigned int hpo_dp_link_enc_count;
@@ -351,6 +358,7 @@ struct stream_resource {
 	struct display_stream_compressor *dsc;
 	struct timing_generator *tg;
 	struct stream_encoder *stream_enc;
+	struct hpo_frl_stream_encoder *hpo_frl_stream_enc;
 	struct hpo_dp_stream_encoder *hpo_dp_stream_enc;
 	struct audio *audio;
 
@@ -394,6 +402,7 @@ struct plane_resource {
 struct link_resource {
 	struct link_encoder *dio_link_enc;
 	struct hpo_dp_link_encoder *hpo_dp_link_enc;
+	struct hpo_frl_link_encoder *hpo_frl_link_enc;
 };
 
 struct link_config {
@@ -531,6 +540,9 @@ struct resource_context {
 	struct link_enc_cfg_context link_enc_cfg_ctx;
 	unsigned int dio_link_enc_to_link_idx[MAX_LINK_ENCODERS];
 	int dio_link_enc_ref_cnts[MAX_LINK_ENCODERS];
+	bool is_hpo_frl_stream_enc_acquired[MAX_HDMI_FRL_ENCODERS];
+	unsigned int hpo_frl_link_enc_to_link_idx[MAX_HDMI_FRL_ENCODERS];
+	int hpo_frl_link_enc_ref_cnts[MAX_HDMI_FRL_ENCODERS];
 	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index d6f5e01a0b66..6db7c8753081 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -228,6 +228,16 @@ struct dccg_funcs {
 	void (*allow_clock_gating)(struct dccg *dccg, bool allow);
 	void (*enable_memory_low_power)(struct dccg *dccg, bool enable);
 	bool (*is_s0i3_golden_init_wa_done)(struct dccg *dccg);
+	void (*enable_hdmicharclk)(struct dccg *dccg, int hpo_inst, int phypll_inst);
+	void (*disable_hdmicharclk)(struct dccg *dccg, int hpo_inst);
+	void (*set_hdmistreamclk)(
+			struct dccg *dccg,
+			enum streamclk_source src,
+			uint32_t otg_inst);
+
+	void (*set_hdmistreamclk_root_clock_gating)(
+			struct dccg *dccg,
+			bool enable);
 	void (*set_dpstreamclk_root_clock_gating)(
 			struct dccg *dccg,
 			int dp_hpo_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 51581c10fd6b..176d048a64e7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -76,6 +76,7 @@
 #define MAX_LINK_ENCODERS (MAX_DIG_LINK_ENCODERS + MAX_DAC_LINK_ENCODERS)
 
 #define MAX_DWB_PIPES	1
+#define MAX_HDMI_FRL_ENCODERS	2
 #define MAX_HPO_DP2_ENCODERS	4
 #define MAX_HPO_DP2_LINK_ENCODERS	4
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 5abbf485d273..e7727ed3300c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -67,6 +67,13 @@ struct encoder_feature_support {
 			uint32_t IS_UHBR13_5_CAPABLE:1;
 			uint32_t IS_UHBR20_CAPABLE:1;
 			uint32_t DP_IS_USB_C:1;
+			uint32_t IS_HDMI_FRL_CAPABLE:1;
+			uint32_t IS_FRL_8G_CAPABLE:1;
+			uint32_t IS_FRL_10G_CAPABLE:1;
+			uint32_t IS_FRL_12G_CAPABLE:1;
+			uint32_t IS_FRL_16G_CAPABLE:1;
+			uint32_t IS_FRL_20G_CAPABLE:1;
+			uint32_t IS_FRL_24G_CAPABLE:1;
 		} bits;
 		uint32_t raw;
 	} flags;
@@ -78,6 +85,11 @@ struct encoder_feature_support {
 	bool fec_supported;
 };
 
+enum phy_source_select {
+	PHY_SOURCE_DIG,
+	PHY_SOURCE_HPO
+};
+
 struct link_encoder {
 	const struct link_encoder_funcs *funcs;
 	int32_t aux_channel_offset;
@@ -93,6 +105,7 @@ struct link_encoder {
 	struct gpio *hpd_gpio;
 	enum hpd_source_id hpd_source;
 	bool usbc_combo_phy;
+	uint8_t txffe_state;
 };
 
 struct link_enc_state {
@@ -104,6 +117,12 @@ struct link_enc_state {
 
 };
 
+struct frl_txffe {
+	uint32_t   amplitude[4];
+	uint32_t   pre_emphasis[4];
+	uint32_t   post_emphasis[4];
+};
+
 enum encoder_type_select {
 	ENCODER_TYPE_DIG = 0,
 	ENCODER_TYPE_HDMI_FRL = 1,
@@ -172,6 +191,43 @@ struct link_encoder_funcs {
 	enum signal_type (*get_dig_mode)(
 		struct link_encoder *enc);
 
+	void (*dpcstx_set_order_invert_18_bit)(
+		struct link_encoder *enc,
+		bool invert);
+
+	void (*set_phy_source)(
+		struct link_encoder *enc,
+		enum phy_source_select src_sel,
+		uint32_t hpo_inst);
+
+	void (*dpcs_initialize_phy)(
+		struct link_encoder *enc,
+		uint32_t hpo_inst,
+		enum hdmi_frl_link_rate frl_link_rate);
+
+	void (*dpcs_configure_phypll)(
+		struct link_encoder *enc,
+		uint32_t hpo_inst,
+		enum hdmi_frl_link_rate frl_link_rate);
+
+	void (*dpcs_configure_dpcs)(
+		struct link_encoder *enc);
+
+	void (*dpcs_enable_dpcs)(
+		struct link_encoder *enc);
+	void (*prog_eq_setting)(
+		struct link_encoder *enc,
+		uint8_t FFE_Level,
+		bool de_emphasis_only,
+		bool pre_shoot_only,
+		bool no_ffe,
+		const struct dc_hdmi_frl_link_settings *link_settings);
+	void (*get_txffe)(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
+	void (*set_txffe)(
+		struct link_encoder *enc,
+		struct frl_txffe *lane_settings);
 	void (*set_dio_phy_mux)(
 		struct link_encoder *enc,
 		enum encoder_type_select sel,
@@ -207,6 +263,126 @@ enum link_enc_cfg_mode {
 	LINK_ENC_CFG_TRANSIENT /* During commit state - use state to be committed. */
 };
 
+struct hpo_frl_link_encoder {
+	const struct hpo_frl_link_encoder_funcs *funcs;
+	struct dc_context *ctx;
+	int inst;
+};
+
+/**
+ * @hpo_frl_link_enc_state - FRL data from the device
+ *
+ * This struct is used to store FRL information retrieved from the hardware.
+ * This is used as a parameter for the read_state function.
+ */
+struct hpo_frl_link_enc_state {
+	/**
+	 * @link_enc_enabled: 0 means disable and 1 enabled.
+	 */
+	uint32_t link_enc_enabled;
+
+	/**
+	 * @link_active:
+	 *
+	 * If link training is enable this field should be set to 1.
+	 */
+	uint32_t link_active;
+
+	/**
+	 * @lane_count: FRL lane count.
+	 */
+	uint32_t lane_count;
+};
+
+/***
+ * @hpo_frl_link_encoder_funcs - FRL encoder functions
+ *
+ * DC handles FRL as an encoder; each ASIC may have some peculiarities in
+ * setting FRL. Thus, this struct, adds all the necessary callbacks that each
+ * DCN version must implement.
+ */
+struct hpo_frl_link_encoder_funcs {
+	/**
+	 * @setup_link_encoder:
+	 *
+	 * This function is responsible for setup the ASIC to use FRL, i.e., it
+	 * contains a register configuration. This function implementation
+	 * expects the enablement of the link clock, lane count configuration,
+	 * any reset/cleanup, and, finally, the enablement of the link.
+	 */
+	void (*setup_link_encoder)(struct hpo_frl_link_encoder *enc,
+				   int lane_count);
+
+	/**
+	 * @disable_link_encoder:
+	 *
+	 * Disable the FRL link. Note that this function must do the reverse of
+	 * the setup_link_encoder.
+	 */
+	void (*disable_link_encoder)(struct hpo_frl_link_encoder *enc);
+
+	/**
+	 * @set_hdmi_training_pattern:
+	 *
+	 * Register level configuration for each lane.
+	 */
+	void (*set_hdmi_training_pattern)(struct hpo_frl_link_encoder *enc,
+					  uint32_t lane0_pattern,
+					  uint32_t lane1_pattern,
+					  uint32_t lane2_pattern,
+					  uint32_t lane3_pattern);
+
+	/**
+	 * @get_hdmi_training_pattern:
+	 *
+	 * Retrieve from the registers each of the lane pattern configurations.
+	 */
+	void (*get_hdmi_training_pattern)(struct hpo_frl_link_encoder *enc,
+					  uint32_t *lane0_pattern,
+					  uint32_t *lane1_pattern,
+					  uint32_t *lane2_pattern,
+					  uint32_t *lane3_pattern);
+
+	/**
+	 * @enable_frl_phy_output:
+	 *
+	 * Based on the parameters, this function should fill out the
+	 * bp_transmitter_control struct and use it to enable the FRL PHY link
+	 * via VBIOS.
+	 */
+	void (*enable_frl_phy_output)(struct hpo_frl_link_encoder *hpo_enc,
+				      struct link_encoder *enc,
+				      enum clock_source_id clock_source,
+				      enum hdmi_frl_link_rate frl_link_rate);
+
+	/**
+	 * @enable_output:
+	 *
+	 * Enable FRL by sending the enable packet training.
+	 */
+	void (*enable_output)(struct hpo_frl_link_encoder *enc);
+
+	/**
+	 * @read_state:
+	 *
+	 * Get the FRL information from registers and fill it out in the
+	 * hpo_frl_link_enc_state struct.
+	 */
+	void (*read_state)(struct hpo_frl_link_encoder *enc,
+			   struct hpo_frl_link_enc_state *state);
+
+	/**
+	 * @destroy:
+	 *
+	 * Destroy encoder object.
+	 */
+	void (*destroy)(struct hpo_frl_link_encoder **enc);
+
+	void (*apply_vsdb_rcc_wa)(
+		struct hpo_frl_link_encoder *enc);
+
+};
+
 enum dp2_link_mode {
 	DP2_LINK_TRAINING_TPS1,
 	DP2_LINK_TRAINING_TPS2,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index a9bf960dacbc..22d5f291c7db 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -71,6 +71,16 @@ enum dynamic_metadata_mode {
 	dmdata_dolby_vision
 };
 
+struct frl_audio_clock_info {
+	uint32_t frl_character_clock_kHz;
+	uint32_t n_32khz;
+	uint32_t cts_32khz;
+	uint32_t n_44khz;
+	uint32_t cts_44khz;
+	uint32_t n_48khz;
+	uint32_t cts_48khz;
+};
+
 struct enc_sdp_line_num {
 	/* Adaptive Sync SDP */
 	bool adaptive_sync_line_num_valid;
@@ -278,6 +288,223 @@ struct stream_encoder_funcs {
 	uint32_t (*get_pixels_per_cycle)(struct stream_encoder *enc);
 };
 
+/**
+ * @hpo_frl_stream_encoder_state - Stream encoder parameters
+ */
+struct hpo_frl_stream_encoder_state {
+	uint32_t stream_enc_enabled;
+	uint32_t otg_inst;
+	uint32_t color_depth;
+	uint32_t num_odm_segments;
+	uint32_t h_active;
+	uint32_t h_blank;
+	uint32_t borrow_mode;
+	enum dc_pixel_encoding pixel_format;
+};
+
+/**
+ * @hpo_frl_stream_encoder - Encoder stream instance
+ *
+ * This struct keeps the reference to the struct with the FRL stream encoder
+ * callbacks. Additionally, it has other references that simplify the stream
+ * configuration.
+ */
+struct hpo_frl_stream_encoder {
+	/**
+	 * @funcs: callback functions for using FRL stream encoder.
+	 */
+	const struct hpo_frl_stream_encoder_funcs *funcs;
+
+	/**
+	 * @stream_enc_inst: Instance ID reference.
+	 */
+	uint32_t stream_enc_inst;
+
+	/**
+	 * @ctx: DC context.
+	 */
+	struct dc_context *ctx;
+
+	/**
+	 * @bp: Bios parser reference.
+	 */
+	struct dc_bios *bp;
+
+	/**
+	 * @id: ID to the Engine object type.
+	 */
+	enum engine_id id;
+
+	/**
+	 * @afmt:
+	 *
+	 * Audio Formatter (AFMT) reference used for select the correct audio
+	 * reference.
+	 */
+	struct afmt *afmt;
+
+	/**
+	 * @vpg:
+	 *
+	 * The VBI Packet Generator (VPG) reference which is used for
+	 * generating the HDMI data island packet headers for ISRC1 and generic
+	 * packages.
+	 */
+	struct vpg *vpg;
+
+	/**
+	 * @afmt:
+	 *
+	 * Audio Pattern Generator (APG) reference used for select the correct audio
+	 * reference.
+	 */
+	struct apg *apg;
+};
+
+/**
+ * @hpo_frl_stream_encoder_funcs - FRL stream encoder functions callbacks
+ *
+ * DC must set up the FRL encoder and the stream encoder; however, each ASIC
+ * may have some quirks in setting FRL. Thus, this struct, adds all the encoder
+ * stream interfaces for setup the FRL stream encoder.
+ */
+struct hpo_frl_stream_encoder_funcs {
+	/**
+	 * @hdmi_frl_enable:
+	 *
+	 * This callback initializes a new FRL stream by enabling HDMI Dispclk,
+	 * SOCCLK, and HDMI stream clock. Additionally, this callback is also
+	 * used to initialize some debug options, such as the CRC validation.
+	 * Finally, it must setup the OTG instance.
+	 */
+	void (*hdmi_frl_enable)(struct hpo_frl_stream_encoder *enc,
+				int otg_inst);
+
+	/**
+	 * @hdmi_frl_unblank:
+	 *
+	 * Ensure that the FIFO video stream is active, reset the necessary
+	 * FIFO registers, enable HDMI tribyte encoder, and finally, adjust the
+	 * clock ramp registers for FIFO. Notice that all the configuration
+	 * made by this function it is at the register level.
+	 */
+	void (*hdmi_frl_unblank)(struct hpo_frl_stream_encoder *enc,
+				 int otg_inst);
+
+	/**
+	 * @hdmi_frl_blank:
+	 *
+	 * This callback is a register-level configuration that must disable
+	 * the clock ramp adjuster FIFO, disable the HDMI Tribyte encoder, and
+	 * disable the stream clocks (dispclk, socclk, and hdmistreamclk).
+	 */
+	void (*hdmi_frl_blank)(struct hpo_frl_stream_encoder *enc);
+
+	/**
+	 * @hdmi_frl_fifo_odm_enabled:
+	 *
+	 * This callback checks if the FIFO ODM Combine mode is enabled
+	 */
+	bool (*hdmi_frl_fifo_odm_enabled)(struct hpo_frl_stream_encoder *enc);
+
+	/**
+	 * @hdmi_frl_set_stream_attribute:
+	 *
+	 * This callback should be invoked only after the link is trained. The
+	 * implementation should configure the pixel encode, color depth, ODM
+	 * mode, configure horizontal blank/active size, configure borrow
+	 * parameters, enable general control packet, enable/setup audio, and
+	 * AVMute.
+	 */
+	void (*hdmi_frl_set_stream_attribute)(struct hpo_frl_stream_encoder *enc,
+					      struct dc_crtc_timing *crtc_timing,
+					      struct frl_borrow_params *borrow_params,
+					      int odm_combine_num_segments);
+
+	/**
+	 * @update_hdmi_info_packets:
+	 *
+	 * Update the HDMI packet control option.
+	 */
+	void (*update_hdmi_info_packets)(struct hpo_frl_stream_encoder *enc,
+					 const struct encoder_info_frame *info_frame);
+
+	/**
+	 * @stop_hdmi_info_packets:
+	 *
+	 * Update HDMI info packet (avi, vendoer, gamut, spd, hdrsmd, hfvsif,
+	 * vtem, etc).
+	 */
+	void (*stop_hdmi_info_packets)(struct hpo_frl_stream_encoder *enc);
+
+	/**
+	 * @audio_mute_control:
+	 *
+	 * Just mute the audio.
+	 */
+	void (*audio_mute_control)(struct hpo_frl_stream_encoder *enc,
+				   bool mute);
+
+	/**
+	 * @hdmi_audio_setup:
+	 *
+	 * Setup HDMI audio based on the Azila info.
+	 */
+	void (*hdmi_audio_setup)(struct hpo_frl_stream_encoder *enc,
+				 unsigned int az_inst,
+				 struct audio_info *info,
+				 struct audio_crtc_info *audio_crtc_info);
+
+	/**
+	 * @hdmi_audio_disable:
+	 *
+	 * Disable audio.
+	 */
+	void (*hdmi_audio_disable)(struct hpo_frl_stream_encoder *enc);
+
+	/**
+	 * @set_avmute:
+	 *
+	 * Disable AVmute at the register-level.
+	 */
+	void (*set_avmute)(struct hpo_frl_stream_encoder *enc, bool enable);
+
+	/**
+	 * @validate_hdmi_frl_output:
+	 *
+	 * Validate FRL inputs, DSC, audio parameters, FRL capacity, and borrow
+	 * parameters.
+	 */
+	bool (*validate_hdmi_frl_output)(struct hpo_frl_stream_encoder *enc,
+					 const struct dc_crtc_timing *timing,
+					 const struct audio_check *audio,
+					 struct dc_hdmi_frl_link_settings *frl_link_settings,
+					 unsigned int dsc_max_rate);
+
+	/**
+	 * @read_state:
+	 *
+	 * Fill out the hpo_frl_stream_encoder_state with the info retrieved
+	 * from ASIC registers.
+	 */
+	void (*read_state)(struct hpo_frl_stream_encoder *enc,
+			   struct hpo_frl_stream_encoder_state *state);
+
+	/**
+	 * @set_dynamic_metadata:
+	 *
+	 * Metadata configuration that sets:
+	 *  - Using Enfine or disable DME.
+	 *  - HUBP setup for the physical instance that has the DME enabled.
+	 *  - Metadata packet type.
+	 *  - Ensure OTG master update locks in the changing DME configuration.
+	 */
+	void (*set_dynamic_metadata)(struct hpo_frl_stream_encoder *enc,
+				     bool enable_dme,
+				     uint32_t hubp_requestor_id,
+				     enum dynamic_metadata_mode dmdata_mode);
+};
+
 struct hpo_dp_stream_encoder_state {
 	uint32_t stream_enc_enabled;
 	uint32_t vid_stream_enabled;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 3a80369cde16..e4e17f630e97 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -106,6 +106,7 @@ enum crc_selection {
 
 enum otg_out_mux_dest {
 	OUT_MUX_DIO = 0,
+	OUT_MUX_HPO_FRL = 1,
 	OUT_MUX_HPO_DP = 2,
 };
 
@@ -493,6 +494,11 @@ struct timing_generator_funcs {
 	void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
 	void (*set_drr_trigger_window)(struct timing_generator *optc,
 			uint32_t window_start, uint32_t window_end);
+	int (*set_fva_factor)(struct timing_generator *optc, struct fva_adj *fva_adj);
+	int (*get_max_hw_supported_fva_factor)(struct timing_generator *optc,
+		struct dc_crtc_timing *timing,
+		unsigned int max_pixclk_100hz);
+	void (*set_vstartup_dsc_frl)(struct timing_generator *optc);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t limit);
 	void (*align_vblanks)(struct timing_generator *master_optc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index d0609443af49..23202c2114bb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -144,6 +144,10 @@ struct link_service {
 	enum dc_status (*validate_dp_tunnel_bandwidth)(
 		const struct dc *dc,
 		const struct dc_state *new_ctx);
+	uint32_t (*frl_link_bandwidth_kbps)(enum hdmi_frl_link_rate link_rate);
+	bool (*frl_margin_check_uncompressed_video)(
+		struct frl_cap_chk_params_fixed31_32 *params,
+		struct frl_cap_chk_intermediates_fixed31_32 *inter);
 
 	uint32_t (*dp_required_hblank_size_bytes)(
 		const struct dc_link *link,
@@ -164,6 +168,7 @@ struct link_service {
 	void (*set_dsc_on_stream)(struct pipe_ctx *pipe_ctx, bool enable);
 	bool (*set_dsc_enable)(struct pipe_ctx *pipe_ctx, bool enable);
 	bool (*update_dsc_config)(struct pipe_ctx *pipe_ctx);
+	void (*wait_for_unlocked)(struct dc_link *link);
 
 
 	/*************************** DDC **************************************/
@@ -311,6 +316,16 @@ struct link_service {
 	void (*edp_set_panel_power)(struct dc_link *link, bool powerOn);
 
 
+	/*************************** HDMI FRL *********************************/
+	bool (*hdmi_frl_poll_status_flag)(struct dc_link *link);
+	struct dc_hdmi_frl_link_settings *(*hdmi_frl_get_verified_link_cap)(
+			struct dc_link *link);
+	void (*hdmi_frl_set_preferred_link_settings)(struct dc *dc,
+			struct dc_hdmi_frl_link_settings *link_setting,
+			struct dc_hdmi_frl_link_training_overrides *lt_overrides,
+			struct dc_link *link);
+
+
 	/*************************** DP CTS ************************************/
 	void (*dp_handle_automated_test)(struct dc_link *link);
 	bool (*dp_set_test_pattern)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index cecd3282a29f..6352e078b132 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -57,6 +57,7 @@ struct resource_caps {
 	int num_dsc;
 	unsigned int num_dig_link_enc; // Total number of DIGs (digital encoders) in DIO (Display Input/Output).
 	unsigned int num_usb4_dpia; // Total number of USB4 DPIA (DisplayPort Input Adapters).
+	int num_hpo_frl;
 	int num_hpo_dp_stream_encoder;
 	int num_hpo_dp_link_encoder;
 	int num_mpc_3dlut;
@@ -86,6 +87,10 @@ struct resource_create_funcs {
 	struct stream_encoder *(*create_stream_encoder)(
 			enum engine_id eng_id, struct dc_context *ctx);
 
+	struct hpo_frl_stream_encoder *(*create_hpo_frl_stream_encoder)(
+			enum engine_id eng_id, struct dc_context *ctx);
+	struct hpo_frl_link_encoder *(*create_hpo_frl_link_encoder)(
+			enum engine_id eng_id, struct dc_context *ctx);
 	struct hpo_dp_stream_encoder *(*create_hpo_dp_stream_encoder)(
 			enum engine_id eng_id, struct dc_context *ctx);
 	struct hpo_dp_link_encoder *(*create_hpo_dp_link_encoder)(
@@ -604,6 +609,8 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format);
 bool get_temp_dp_link_res(struct dc_link *link,
 		struct link_resource *link_res,
 		struct dc_link_settings *link_settings);
+bool get_temp_frl_link_res(struct dc_link *link,
+		struct link_resource *link_res);
 
 void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 	struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/include/audio_types.h b/drivers/gpu/drm/amd/display/include/audio_types.h
index 6699ad4fa825..2a0f1a9c30a5 100644
--- a/drivers/gpu/drm/amd/display/include/audio_types.h
+++ b/drivers/gpu/drm/amd/display/include/audio_types.h
@@ -56,6 +56,7 @@ struct audio_crtc_info {
 	uint16_t refresh_rate;
 	uint8_t pixel_repetition;
 	bool interlaced;
+	uint32_t frl_character_clock_kHz; /* in KHz */
 };
 struct azalia_clock_info {
 	uint32_t pixel_clock_in_10khz;
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index b5d97b394131..aeeac1f0c2c3 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -329,7 +329,11 @@ struct bp_encoder_cap_info {
 	uint32_t DP_UHBR13_5_EN:1;
 	uint32_t DP_UHBR20_EN:1;
 	uint32_t DP_IS_USB_C:1;
-	uint32_t RESERVED:27;
+	uint32_t IS_HDMI_FRL_CAPABLE:1;
+	uint32_t FRL_8G_EN:1;
+	uint32_t FRL_10G_EN:1;
+	uint32_t FRL_12G_EN:1;
+	uint32_t RESERVED:19;
 };
 
 struct bp_soc_bb_info {
@@ -346,7 +350,13 @@ struct bp_connector_speed_cap_info {
 	uint32_t DP_UHBR13_5_EN:1;
 	uint32_t DP_UHBR20_EN:1;
 	uint32_t DP_IS_USB_C:1;
-	uint32_t RESERVED:28;
+	uint32_t FRL_8G_EN:1;
+	uint32_t FRL_10G_EN:1;
+	uint32_t FRL_12G_EN:1;
+	uint32_t FRL_16G_EN:1;
+	uint32_t FRL_20G_EN:1;
+	uint32_t FRL_24G_EN:1;
+	uint32_t RESERVED:19;
 };
 
 #endif /*__DAL_BIOS_PARSER_TYPES_H__ */
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 177acb0574f1..a11bfb2e7cdd 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -62,6 +62,8 @@
 #define DC_LOG_ALL_TF_CHANNELS(...) pr_debug("[GAMMA]:"__VA_ARGS__)
 #define DC_LOG_DSC(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
+#define DC_LOG_HDMI_FRL(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
+#define DC_LOG_HDMI_FRL_LTP(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DWB(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DP2(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_AUTO_DPM_TEST(...) pr_debug("[AutoDPMTest]: "__VA_ARGS__)
diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index 3a2c2d2fb629..9b134aa3e275 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -30,6 +30,8 @@
 #define TMDS_MIN_PIXEL_CLOCK 25000
 /* Maximum pixel clock, in KHz. For TMDS signal is 165.00 MHz */
 #define TMDS_MAX_PIXEL_CLOCK 165000
+/* Maximum pixel clock, in KHz. For HDMI2 TMDS signal is 600 MHz */
+#define HDMI2_TMDS_MAX_PIXEL_CLOCK 600000
 
 enum signal_type {
 	SIGNAL_TYPE_NONE		= 0L,		/* no signal */
@@ -41,6 +43,7 @@ enum signal_type {
 	SIGNAL_TYPE_DISPLAY_PORT	= (1 << 5),
 	SIGNAL_TYPE_DISPLAY_PORT_MST	= (1 << 6),
 	SIGNAL_TYPE_EDP			= (1 << 7),
+	SIGNAL_TYPE_HDMI_FRL		= (1 << 8),
 	SIGNAL_TYPE_VIRTUAL		= (1 << 9),	/* Virtual Display */
 };
 
@@ -65,6 +68,8 @@ static inline const char *signal_type_to_string(const int type)
 		return "Display Port: MST";
 	case SIGNAL_TYPE_EDP:
 		return "Embedded Display Port";
+	case SIGNAL_TYPE_HDMI_FRL:
+		return "HDMI: FRL";
 	case SIGNAL_TYPE_VIRTUAL:
 		return "Virtual";
 	default:
@@ -78,9 +83,14 @@ static inline bool dc_is_hdmi_tmds_signal(enum signal_type signal)
 	return (signal == SIGNAL_TYPE_HDMI_TYPE_A);
 }
 
+static inline bool dc_is_hdmi_frl_signal(enum signal_type signal)
+{
+	return ((signal == SIGNAL_TYPE_HDMI_FRL));
+}
+
 static inline bool dc_is_hdmi_signal(enum signal_type signal)
 {
-	return (signal == SIGNAL_TYPE_HDMI_TYPE_A);
+	return (dc_is_hdmi_tmds_signal(signal) || dc_is_hdmi_frl_signal(signal));
 }
 
 static inline bool dc_is_dp_sst_signal(enum signal_type signal)
-- 
2.54.0

