Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC547EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C457A89D7C;
	Mon, 10 Jul 2023 19:27:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B8C10E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c13XBM1xlUXmLhgHDssrkholsFwW4kiXWA7M3VakXSrI0GEDbx2nfQXtbldjn8psbD1Cj4ZF9vOrsy6v4rG4UkzQd/uktc6a76U0SXJI3kTZBukFc0D5zNNNU67VXIGpQ4KhwVn+wQwWwDNuo6+5NxpQtD6ZXVfA/4CNMtoJY9pkgI4lt23/Ehc4fjIGLggybT1toruqiAWVkcc9r7zwcsNR7/XKV3D2x66G5x6mjvu7EbL04txRZiHCCWzE5j31DKTd5TfPEJuOH9eOjAQJ7czRV+nCkXDhVJKWrssZw7jXiVIncH1BI9mCA8Eb4ZPYLCB4vFXp76JoYC0XQ0fDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvNuZZUqPxpVw6h0MhriV0bmlDxBUqVlLA2n2n0atmk=;
 b=Q1dyYUVyAO7idw/BL+2A0vi1Ef6iTXdob/vPd8jRB1MqD2Na7cHSDZo8Q/SXJeDDFPP0V15O0HFkm8zmrTCzrmlpYEt/pTKzkFioFQ1aqglQzxce21nUlmWVT3XVPO/NjKAjwEP5iLBnF5sdhqXU05Uf9ope6DNuk8hgajPO93xnzjvjrUWz2ZZpxFRcaVOt22ZVYooo93gxJIdEfYgummetRiMB1ihbsFJoAsOa//AsPLGLRM2eqr14I5QoBVVi13G7n8igycMYGNrX4/eKYzPOle8tP8jEuF7jC6412suForb3MW5EMhOhDUjio38TvVlRnlsbMdcAm0/tTrVHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvNuZZUqPxpVw6h0MhriV0bmlDxBUqVlLA2n2n0atmk=;
 b=wLxJVir7vIbs1TRH3kvkm5cCkoofuxFVPKeIWXqmVrTOrcCMyTsTQhuRp/jSwz98g+rfEtTqKtjjx59xD4ee7hC4CQbNarhIv0Y5H1Aj2w9vhPAJ7GGSEQsgI/sonjbuQdigIQgfLDKhC/15Emikk1hFE9VUaQH3EHiXAVzoBvE=
Received: from BN9PR03CA0395.namprd03.prod.outlook.com (2603:10b6:408:111::10)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:27:37 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::5) by BN9PR03CA0395.outlook.office365.com
 (2603:10b6:408:111::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 19:27:36 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jul
 2023 12:27:36 -0700
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:36 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 01/10] drm/amd/display: Add structs for Freesync Panel Replay
Date: Mon, 10 Jul 2023 15:27:24 -0400
Message-ID: <20230710192733.1344403-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 317195ec-ef66-4550-8376-08db817bb7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZenfdobyoI0kJ9LTzid8O9aoqx7C1IdhP4q/mqBaRju6wyRct2uNusfx0Ipp1+zYuvrH088q79qgLKkULaDW/t1n9+/13qh2yKjxfqOXycc/VzqNf+Ym8+XyscNogNwDjjCQbRyu2zT50+MT++p+DWxulL9mRazbs6Yh0jk1c6OW/Ujz3xmH91dW4QyjBET4CpVhbUOjSOEa/dWF5yUU0c3rkRDhfhgIUfLGZN0qo04HMmL+yyw+TPovLs0wWiln9QENetZcEHG0EQ2DS6ZvAPoc+GmGlU1VWvZKltJlRVaTliq0952dvtBp6pVsaWKsYmt60hbMDbZzpO6Pz26ha26yDjoldTEkW+9sLX5venPFqjlnivTan87q59OPIiMW5r4Ce+NxE6MmuEADlNQZtxIUMLNgot6JU8WhjzmxpZsAD3JXy3UIllLVmPAGP63FnmGVjAE18sWUI3G6zVRy+zEMxgNkmZJcActr0JIgTXcs1n3hNHFexmJSMByg7hOdZaIA/aiHNxCKzhbP5qb6L6yaJyvcaP89J0AwY5zd84LcYRWU6eajwTlRvj7fTnDBRsf/xHeKin3CxdHAmRdR4+JbY41aPYIUWSh35ZxWV/FcyXFFmVQiqK1o28i+lv5+x8aWkuz+oaFNLm9qc+lPYIwSOYDBF9hr78HKexgrjeqoWavaD53lK9mP4Xebrsk4E49r74wzjWpSDq0LDXfETTnw38HEzErrAmWdZE8KfLEA9Kl/dCKddKYKL/9aVcc5t4kf8qif610jgkt3NLcYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(7696005)(110136005)(36860700001)(47076005)(426003)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2616005)(2906002)(30864003)(70206006)(82310400005)(186003)(70586007)(1076003)(26005)(336012)(81166007)(82740400003)(356005)(8676002)(316002)(5660300002)(4326008)(41300700001)(6636002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:36.8493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317195ec-ef66-4550-8376-08db817bb7e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In some instances, the GPU is transmitting repeated frame to the sink
without any updates or changes in the content. These repeat transmission
are wasteful, resulting in power draw in different aspects of the system

1. DCN is fetching the frame of data from DF/UMC/DRAM. This memory traffic
prevents power down of parts of this HW path.

2. GPU is transmitting pixel data to the display through the main link of
the DisplayPort interface. This prevents power down of both the Source
transmitter (TX) and the Sink receiver (RX)

The concepts of utilizing replay is similar to PSR, but there is a benefit of:
	Source and Sink remaining synchronized which allows for
        	- lower latency when switching from replay to live frames
	        - enable the possibility of more use cases
		- easy control of the sink's refresh rate during replay

Due to Source and Sink remaining timing synchronized, Replay can be activated
in more UI scenarios.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 412 ++++++++++++++++++
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   3 +-
 14 files changed, 516 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 26d05e225088..3a7208a86541 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -428,6 +428,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SWAPCHAIN = 6,
 	VISUAL_CONFIRM_FAMS = 7,
 	VISUAL_CONFIRM_SWIZZLE = 9,
+	VISUAL_CONFIRM_REPLAY = 12,
 	VISUAL_CONFIRM_SUBVP = 14,
 	VISUAL_CONFIRM_MCLK_SWITCH = 16,
 };
@@ -901,6 +902,7 @@ struct dc_debug_options {
 	uint32_t fpo_vactive_max_blank_us;
 	bool enable_legacy_fast_update;
 	bool disable_dc_mode_overwrite;
+	bool replay_skip_crtc_disabled;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
@@ -1505,6 +1507,8 @@ struct dc_link {
 
 	struct psr_settings psr_settings;
 
+	struct replay_settings replay_settings;
+
 	/* Drive settings read from integrated info table */
 	struct dc_lane_settings bios_forced_drive_settings;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 55139d7bf422..cfaa39c5dd16 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1117,6 +1117,11 @@ struct edp_psr_info {
 	uint8_t force_psrsu_cap;
 };
 
+struct replay_info {
+	uint8_t pixel_deviation_per_line;
+	uint8_t max_deviation_line;
+};
+
 struct dprx_states {
 	bool cable_id_written;
 };
@@ -1236,6 +1241,8 @@ struct dpcd_caps {
 	uint8_t edp_rev;
 	union edp_alpm_caps alpm_caps;
 	struct edp_psr_info psr_info;
+
+	struct replay_info pr_info;
 };
 
 union dpcd_sink_ext_caps {
@@ -1276,6 +1283,28 @@ union dpcd_psr_configuration {
 	unsigned char raw;
 };
 
+union replay_enable_and_configuration {
+	struct {
+		unsigned char FREESYNC_PANEL_REPLAY_MODE              :1;
+		unsigned char TIMING_DESYNC_ERROR_VERIFICATION        :1;
+		unsigned char STATE_TRANSITION_ERROR_DETECTION        :1;
+		unsigned char RESERVED0                               :1;
+		unsigned char RESERVED1                               :4;
+	} bits;
+	unsigned char raw;
+};
+
+union dpcd_replay_configuration {
+	struct {
+		unsigned char STATE_TRANSITION_ERROR_STATUS    : 1;
+		unsigned char DESYNC_ERROR_STATUS              : 1;
+		unsigned char SINK_DEVICE_REPLAY_STATUS        : 3;
+		unsigned char SINK_FRAME_LOCKED                : 2;
+		unsigned char RESERVED                         : 1;
+	} bits;
+	unsigned char raw;
+};
+
 union dpcd_alpm_configuration {
 	struct {
 		unsigned char ENABLE                    : 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0ce7728a5a4b..b77ceb442fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1014,6 +1014,45 @@ struct psr_settings {
 	unsigned int psr_power_opt;
 };
 
+enum replay_coasting_vtotal_type {
+	PR_COASTING_TYPE_NOM = 0,
+	PR_COASTING_TYPE_STATIC,
+	PR_COASTING_TYPE_FULL_SCREEN_VIDEO,
+	PR_COASTING_TYPE_TEST_HARNESS,
+	PR_COASTING_TYPE_NUM,
+};
+
+union replay_error_status {
+	struct {
+		unsigned char STATE_TRANSITION_ERROR    :1;
+		unsigned char LINK_CRC_ERROR            :1;
+		unsigned char DESYNC_ERROR              :1;
+		unsigned char RESERVED                  :5;
+	} bits;
+	unsigned char raw;
+};
+
+struct replay_config {
+	bool replay_supported;                          // Replay feature is supported
+	unsigned int replay_power_opt_supported;        // Power opt flags that are supported
+	bool replay_smu_opt_supported;                  // SMU optimization is supported
+	unsigned int replay_enable_option;              // Replay enablement option
+	uint32_t debug_flags;                           // Replay debug flags
+	bool replay_timing_sync_supported;             // Replay desync is supported
+	union replay_error_status replay_error_status; // Replay error status
+};
+
+/* Replay feature flags */
+struct replay_settings {
+	struct replay_config config;            // Replay configuration
+	bool replay_feature_enabled;            // Replay feature is ready for activating
+	bool replay_allow_active;               // Replay is currently active
+	unsigned int replay_power_opt_active;   // Power opt flags that are activated currently
+	bool replay_smu_opt_enable;             // SMU optimization is enabled
+	uint16_t coasting_vtotal;               // Current Coasting vtotal
+	uint16_t coasting_vtotal_table[PR_COASTING_TYPE_NUM]; // Coasting vtotal table
+};
+
 /* To split out "global" and "per-panel" config settings.
  * Add a struct dc_panel_config under dc_link
  */
@@ -1040,9 +1079,11 @@ struct dc_panel_config {
 	struct psr {
 		bool disable_psr;
 		bool disallow_psrsu;
+		bool disallow_replay;
 		bool rc_disable;
 		bool rc_allow_static_screen;
 		bool rc_allow_fullscreen_VPB;
+		unsigned int replay_enable_option;
 	} psr;
 	/* ABM */
 	struct varib {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d693ea42d033..0df459506296 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -660,6 +660,7 @@ static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
 			.disallow_psrsu = false,
+			.disallow_replay = false,
 		},
 		.ilr = {
 			.optimize_edp_link_rate = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 1a0284a068b2..519f86793897 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -732,6 +732,7 @@ static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
 		.disallow_psrsu = false,
+		.disallow_replay = false,
 	},
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 7dc065ea247a..39c9a334a10d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -102,6 +102,7 @@ static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
 			.disallow_psrsu = false,
+			.disallow_replay = false,
 		},
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 6d9761395288..16416c1eedc4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -85,6 +85,7 @@ static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
 			.disallow_psrsu = false,
+			.disallow_replay = false,
 		},
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index fc33b5fcabe1..abcb5bd465ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -896,6 +896,7 @@ static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
 		.disallow_psrsu = false,
+		.disallow_replay = false,
 	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index a840b008d660..4e788fa207d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -870,6 +870,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_z9_disable_interface = true,
 	.minimum_z8_residency_time = 2000,
 	.psr_skip_crtc_disable = true,
+	.replay_skip_crtc_disabled = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.timing_trace = false,
@@ -945,6 +946,7 @@ static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
 		.disallow_psrsu = false,
+		.disallow_replay = false,
 	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index f1153941907e..7c82f3cfd604 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -895,6 +895,7 @@ static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
 		.disallow_psrsu = false,
+		.disallow_replay = false,
 	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 707cf28bbceb..34682e6ae8c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -891,6 +891,7 @@ static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
 		.disallow_psrsu = false,
+		.disallow_replay = false,
 	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 034610b74a37..bc0c26a5f228 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -304,6 +304,8 @@ struct resource_pool {
 	struct dmcu *dmcu;
 	struct dmub_psr *psr;
 
+	struct dmub_replay *replay;
+
 	struct abm *multiple_abms[MAX_PIPES];
 
 	const struct resource_funcs *funcs;
@@ -572,6 +574,23 @@ struct dc_state {
 	} perf_params;
 };
 
+struct replay_context {
+	/* ddc line */
+	enum channel_id aux_inst;
+	/* Transmitter id */
+	enum transmitter digbe_inst;
+	/* Engine Id is used for Dig Be source select */
+	enum engine_id digfe_inst;
+	/* Controller Id used for Dig Fe source select */
+	enum controller_id controllerId;
+	unsigned int line_time_in_ns;
+};
+
+enum dc_replay_enable {
+	DC_REPLAY_DISABLE			= 0,
+	DC_REPLAY_ENABLE			= 1,
+};
+
 struct dc_bounding_box_max_clk {
 	int max_dcfclk_mhz;
 	int max_dispclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index af1f50742371..219418b2e883 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -248,6 +248,112 @@ union dmub_psr_debug_flags {
 	uint32_t u32All;
 };
 
+/**
+ * Flags that can be set by driver to change some Replay behaviour.
+ */
+union replay_debug_flags {
+	struct {
+		/**
+		 * Enable visual confirm in FW.
+		 */
+		uint32_t visual_confirm : 1;
+
+		/**
+		 * @skip_crc: Set if need to skip CRC.
+		 */
+		uint32_t skip_crc : 1;
+
+		/**
+		 * @force_link_power_on: Force disable ALPM control
+		 */
+		uint32_t force_link_power_on : 1;
+
+		/**
+		 * @force_phy_power_on: Force phy power on
+		 */
+		uint32_t force_phy_power_on : 1;
+
+		/**
+		 * @timing_resync_disabled: Disabled Replay normal sleep mode timing resync
+		 */
+		uint32_t timing_resync_disabled : 1;
+
+		/**
+		 * @skip_crtc_disabled: CRTC disable skipped
+		 */
+		uint32_t skip_crtc_disabled : 1;
+
+		/**
+		 * @force_defer_one_frame_update: Force defer one frame update in ultra sleep mode
+		 */
+		uint32_t force_defer_one_frame_update : 1;
+		/**
+		 * @disable_delay_alpm_on: Force disable delay alpm on
+		 */
+		uint32_t disable_delay_alpm_on : 1;
+		/**
+		 * @disable_desync_error_check: Force disable desync error check
+		 */
+		uint32_t disable_desync_error_check : 1;
+		/**
+		 * @disable_desync_error_check: Force disable desync error check
+		 */
+		uint32_t disable_dmub_save_restore : 1;
+
+		uint32_t reserved : 22;
+	} bitfields;
+
+	uint32_t u32All;
+};
+
+union replay_hw_flags {
+	struct {
+		/**
+		 * @allow_alpm_fw_standby_mode: To indicate whether the
+		 * ALPM FW standby mode is allowed
+		 */
+		uint32_t allow_alpm_fw_standby_mode : 1;
+
+		/*
+		 * @dsc_enable_status: DSC enable status in driver
+		 */
+		uint32_t dsc_enable_status : 1;
+
+		/**
+		 * @fec_enable_status: receive fec enable/disable status from driver
+		 */
+		uint32_t fec_enable_status : 1;
+
+		/*
+		 * @smu_optimizations_en: SMU power optimization.
+		 * Only when active display is Replay capable and display enters Replay.
+		 * Trigger interrupt to SMU to powerup/down.
+		 */
+		uint32_t smu_optimizations_en : 1;
+
+		/**
+		 * @otg_powered_down: Flag to keep track of OTG power state.
+		 */
+		uint32_t otg_powered_down : 1;
+
+		/**
+		 * @phy_power_state: Indicates current phy power state
+		 */
+		uint32_t phy_power_state : 1;
+
+		/**
+		 * @link_power_state: Indicates current link power state
+		 */
+		uint32_t link_power_state : 1;
+		/**
+		 * Use TPS3 signal when restore main link.
+		 */
+		uint32_t force_wakeup_by_tps3 : 1;
+	} bitfields;
+
+	uint32_t u32All;
+};
+
 /**
  * DMUB visual confirm color
  */
@@ -565,6 +671,21 @@ enum dmub_gpint_command {
 	 */
 	DMUB_GPINT__PSR_RESIDENCY = 9,
 
+	/**
+	 * DESC: Get REPLAY state from FW.
+	 * RETURN: REPLAY state enum. This enum may need to be converted to the legacy REPLAY state value.
+	 */
+	DMUB_GPINT__GET_REPLAY_STATE = 13,
+
+	/**
+	 * DESC: Start REPLAY residency counter. Stop REPLAY resdiency counter and get value.
+	 * ARGS: We can measure residency from various points. The argument will specify the residency mode.
+	 *       By default, it is measured from after we powerdown the PHY, to just before we powerup the PHY.
+	 * RETURN: REPLAY residency in milli-percent.
+	 */
+	DMUB_GPINT__REPLAY_RESIDENCY = 14,
+
+
 	/**
 	 * DESC: Notifies DMCUB detection is done so detection required can be cleared.
 	 */
@@ -763,6 +884,11 @@ enum dmub_cmd_type {
 	 * Command type used for all VBIOS interface commands.
 	 */
 
+	/**
+	 * Command type used for all REPLAY commands.
+	 */
+	DMUB_CMD__REPLAY = 83,
+
 	/**
 	 * Command type used for all SECURE_DISPLAY commands.
 	 */
@@ -2496,6 +2622,272 @@ struct dmub_cmd_psr_set_power_opt_data {
 	uint32_t power_opt;
 };
 
+#define REPLAY_RESIDENCY_MODE_SHIFT            (0)
+#define REPLAY_RESIDENCY_ENABLE_SHIFT          (1)
+
+#define REPLAY_RESIDENCY_MODE_MASK             (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
+# define REPLAY_RESIDENCY_MODE_PHY             (0x0 << REPLAY_RESIDENCY_MODE_SHIFT)
+# define REPLAY_RESIDENCY_MODE_ALPM            (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
+
+#define REPLAY_RESIDENCY_ENABLE_MASK           (0x1 << REPLAY_RESIDENCY_ENABLE_SHIFT)
+# define REPLAY_RESIDENCY_DISABLE              (0x0 << REPLAY_RESIDENCY_ENABLE_SHIFT)
+# define REPLAY_RESIDENCY_ENABLE               (0x1 << REPLAY_RESIDENCY_ENABLE_SHIFT)
+
+enum replay_state {
+	REPLAY_STATE_0			= 0x0,
+	REPLAY_STATE_1			= 0x10,
+	REPLAY_STATE_1A			= 0x11,
+	REPLAY_STATE_2			= 0x20,
+	REPLAY_STATE_3			= 0x30,
+	REPLAY_STATE_3INIT		= 0x31,
+	REPLAY_STATE_4			= 0x40,
+	REPLAY_STATE_4A			= 0x41,
+	REPLAY_STATE_4B			= 0x42,
+	REPLAY_STATE_4C			= 0x43,
+	REPLAY_STATE_4D			= 0x44,
+	REPLAY_STATE_4B_LOCKED		= 0x4A,
+	REPLAY_STATE_4C_UNLOCKED	= 0x4B,
+	REPLAY_STATE_5			= 0x50,
+	REPLAY_STATE_5A			= 0x51,
+	REPLAY_STATE_5B			= 0x52,
+	REPLAY_STATE_5A_LOCKED		= 0x5A,
+	REPLAY_STATE_5B_UNLOCKED	= 0x5B,
+	REPLAY_STATE_6			= 0x60,
+	REPLAY_STATE_6A			= 0x61,
+	REPLAY_STATE_6B			= 0x62,
+	REPLAY_STATE_INVALID		= 0xFF,
+};
+
+/**
+ * Replay command sub-types.
+ */
+enum dmub_cmd_replay_type {
+	/**
+	 * Copy driver-calculated parameters to REPLAY state.
+	 */
+	DMUB_CMD__REPLAY_COPY_SETTINGS		= 0,
+	/**
+	 * Enable REPLAY.
+	 */
+	DMUB_CMD__REPLAY_ENABLE			= 1,
+	/**
+	 * Set Replay power option.
+	 */
+	DMUB_CMD__SET_REPLAY_POWER_OPT		= 2,
+	/**
+	 * Set coasting vtotal.
+	 */
+	DMUB_CMD__REPLAY_SET_COASTING_VTOTAL	= 3,
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__REPLAY_COPY_SETTINGS command.
+ */
+struct dmub_cmd_replay_copy_settings_data {
+	/**
+	 * Flags that can be set by driver to change some replay behaviour.
+	 */
+	union replay_debug_flags debug;
+
+	/**
+	 * @flags: Flags used to determine feature functionality.
+	 */
+	union replay_hw_flags flags;
+
+	/**
+	 * DPP HW instance.
+	 */
+	uint8_t dpp_inst;
+	/**
+	 * OTG HW instance.
+	 */
+	uint8_t otg_inst;
+	/**
+	 * DIG FE HW instance.
+	 */
+	uint8_t digfe_inst;
+	/**
+	 * DIG BE HW instance.
+	 */
+	uint8_t digbe_inst;
+	/**
+	 * AUX HW instance.
+	 */
+	uint8_t aux_inst;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * @pixel_deviation_per_line: Indicate the maximum pixel deviation per line compare
+	 * to Source timing when Sink maintains coasting vtotal during the Replay normal sleep mode
+	 */
+	uint8_t pixel_deviation_per_line;
+	/**
+	 * @max_deviation_line: The max number of deviation line that can keep the timing
+	 * synchronized between the Source and Sink during Replay normal sleep mode.
+	 */
+	uint8_t max_deviation_line;
+	/**
+	 * Length of each horizontal line in ns.
+	 */
+	uint32_t line_time_in_ns;
+	/**
+	 * PHY instance.
+	 */
+	uint8_t dpphy_inst;
+	/**
+	 * Determines if SMU optimzations are enabled/disabled.
+	 */
+	uint8_t smu_optimizations_en;
+	/**
+	 * Determines if timing sync are enabled/disabled.
+	 */
+	uint8_t replay_timing_sync_supported;
+	/*
+	 * Use FSM state for Replay power up/down
+	 */
+	uint8_t use_phy_fsm;
+};
+
+/**
+ * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
+ */
+struct dmub_rb_cmd_replay_copy_settings {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__REPLAY_COPY_SETTINGS command.
+	 */
+	struct dmub_cmd_replay_copy_settings_data replay_copy_settings_data;
+};
+
+/**
+ * Replay disable / enable state for dmub_rb_cmd_replay_enable_data.enable
+ */
+enum replay_enable {
+	/**
+	 * Disable REPLAY.
+	 */
+	REPLAY_DISABLE				= 0,
+	/**
+	 * Enable REPLAY.
+	 */
+	REPLAY_ENABLE				= 1,
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__REPLAY_ENABLE command.
+ */
+struct dmub_rb_cmd_replay_enable_data {
+	/**
+	 * Replay enable or disable.
+	 */
+	uint8_t enable;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Phy state to enter.
+	 * Values to use are defined in dmub_phy_fsm_state
+	 */
+	uint8_t phy_fsm_state;
+	/**
+	 * Phy rate for DP - RBR/HBR/HBR2/HBR3.
+	 * Set this using enum phy_link_rate.
+	 * This does not support HDMI/DP2 for now.
+	 */
+	uint8_t phy_rate;
+};
+
+/**
+ * Definition of a DMUB_CMD__REPLAY_ENABLE command.
+ * Replay enable/disable is controlled using action in data.
+ */
+struct dmub_rb_cmd_replay_enable {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	struct dmub_rb_cmd_replay_enable_data data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__SET_REPLAY_POWER_OPT command.
+ */
+struct dmub_cmd_replay_set_power_opt_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
+	/**
+	 * REPLAY power option
+	 */
+	uint32_t power_opt;
+};
+
+/**
+ * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
+ */
+struct dmub_rb_cmd_replay_set_power_opt {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
+	 */
+	struct dmub_cmd_replay_set_power_opt_data replay_set_power_opt_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__REPLAY_SET_COASTING_VTOTAL command.
+ */
+struct dmub_cmd_replay_set_coasting_vtotal_data {
+	/**
+	 * 16-bit value dicated by driver that indicates the coasting vtotal.
+	 */
+	uint16_t coasting_vtotal;
+	/**
+	 * REPLAY control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+};
+
+/**
+ * Definition of a DMUB_CMD__REPLAY_SET_COASTING_VTOTAL command.
+ */
+struct dmub_rb_cmd_replay_set_coasting_vtotal {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_COASTING_VTOTAL command.
+	 */
+	struct dmub_cmd_replay_set_coasting_vtotal_data replay_set_coasting_vtotal_data;
+};
+
 /**
  * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
  */
@@ -2586,6 +2978,10 @@ enum hw_lock_client {
 	 * PSR SU is the client of HW Lock Manager.
 	 */
 	HW_LOCK_CLIENT_PSR_SU		= 1,
+	/**
+         * Replay is the client of HW Lock Manager.
+         */
+        HW_LOCK_CLIENT_REPLAY           = 4,
 	/**
 	 * Invalid client.
 	 */
@@ -3576,6 +3972,22 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
 	 */
 	struct dmub_rb_cmd_idle_opt_dcn_notify_idle idle_opt_notify_idle;
+	/*
+	 * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
+	 */
+	struct dmub_rb_cmd_replay_copy_settings replay_copy_settings;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_ENABLE command.
+	 */
+	struct dmub_rb_cmd_replay_enable replay_enable;
+	/**
+	 * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
+	 */
+	struct dmub_rb_cmd_replay_set_power_opt replay_set_power_opt;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_COASTING_VTOTAL command.
+	 */
+	struct dmub_rb_cmd_replay_set_coasting_vtotal replay_set_coasting_vtotal;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index c062a44db078..f72023a296a0 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -172,6 +172,7 @@ enum dpcd_psr_sink_states {
 #define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
 #define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
 #define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
-#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED	0x340
+#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED     0x340
+#define DP_SINK_PR_REPLAY_STATUS                0x378
 
 #endif /* __DAL_DPCD_DEFS_H__ */
-- 
2.25.1

