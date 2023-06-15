Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF24EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE9910E19C;
	Thu, 15 Jun 2023 20:39:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C27110E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/ptymWzmJppXSOQsJ5AwHVRlVkSAMFG9Ve0lexntSLRNPFjXYao3i8hcgL8nloo6Aw3Qqk/9GdxfrswfOSgnEUUSundS9plR9sA5Ftuum3q9KXUb7s5cvFD+ZZ0GkiseVq1m9kZK5Bl2nA+JUZor2CnblqgtZ6omkNbZcDsjxtQcM2/4hED0E+WN7WwoEPrvj0yYFUHsMuu2jhBFYRaAsSehNbHFFbuHM1HfT//X26y4gsMKsPUIBvXpYfS4rE1+HfwiGnMoQXivyZksVKgj+3X06TArcAGDVJmqB+LVRpeNdq7LvJzfrgUFXpGC56mF1uiocHiF6A/7gjZ0nj0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LsXIFUjxizluqGTalay8FjpGOuQ9fsDnQ9j008uvZs=;
 b=annL0JX3T388AQTlUF55qVO4yR+7LmLl1dLprL7rNgHgnOZTatO4blbr7YOSCc5s7TsxDJAh5MUqbGJMa5vG8EV0YRUoL/m4RpJR51QDC701Zsr2cChy8XnEEsgnkjDm7p5Fl+TpOfq1uygBeoFv/briUn8iRvwuXAc8RS/qyHZyzHB6fL9JJ6DBNmZQ1vTwiKqzfxlIpax4DIU/PCIGOtZXVcxr8818LRv2u/mMx8sDldbgCHfr+2yA4CpeAt/HM973cMAT4Q+1WWRv3xpY8FenrCoPSfbNo7H8f3rOXTwJeCzNBuLjvZpIEj9BTooS09yTI1sKQDQjPmCBL5LaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LsXIFUjxizluqGTalay8FjpGOuQ9fsDnQ9j008uvZs=;
 b=d6e9iNNxFSjNl4Vt2xKRjIu9b0hirLsh6xeX5gKSKlDxbgG+7ZNYvVitbEkOaRTiBUaWcVxaxJUsrx34X50d09e6TV1y9gxI5CzLs365uDbFZmauzInG/aVmBCv8/5B1QlRnDpFQGFxvXfmH8kn8y61eL9rCSA6w6H0mshE5jAE=
Received: from BY5PR17CA0064.namprd17.prod.outlook.com (2603:10b6:a03:167::41)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 20:39:53 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:167:cafe::71) by BY5PR17CA0064.outlook.office365.com
 (2603:10b6:a03:167::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Thu, 15 Jun 2023 20:39:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:51 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:51 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amd/display: Add structs for Freesync Panel Replay
Date: Thu, 15 Jun 2023 16:39:25 -0400
Message-ID: <20230615203930.1715722-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|MW3PR12MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abee983-8e99-4d2b-f817-08db6de0abf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Q6U4OSciM96s9a9+CmU4ShuBSYt7xuPQXVVGxdk2VY5Amzv/bYkTVlqTXQaaGpe3BbbLZ5uYBbQ3Gg5hkB+6BmeHB9Fsn1Nv8LX/lz51K7/r+Q3Kxuy4KfYTgL51oE4TIqJUX1x+aDQL0/FDcY+314nZ3LmTizqZ10R0JEB1xk7XAaK75aX2O6LDJjG6wR3Lrimv/S7BEYbsuA+JZjr9FrnP0/cCc4cPNGHsuUbBHGCpNMtEdgIaRzCmxyCym3VO3EoDiQ0P4EhJbcyvRSklSPEl0RpDmWa6i65Qjl9VomIspvs8hZOFngo6yu7JcuIUokZYwyGsW1gt1j0EdAM5PK2sb7jD7dNKA9UcRUqpWKaYm+cyqowPQYD4HIO+8k2LIb+6fZABtD4ZQzv3QJWTy56lZdgMpey1lOyyOvodj3rygkfCxvVPt0V5EvHVp/TFjhueeycL8rmwmh9774vqm6M+m2YtK577Rp7jwLWUczYjj1Sl+r2A6Yl6ttWE7NeSxsVCMx8k5l1TFMoHqSrxFjWkwOWA0ytRINUa0aoB1Zq+05Mo8FFWZXeRll5aDMlLuKqzm58n40wbt7EtiiRebnBjhPZ3aEAmvCIgYetXB6KU7GydV0HYxfxzFdtK/y34bD3JifaXS8B3y6oafsPv4PxE9/NWv8FN897p65aofVO7MXeA1B88mwCHd4crvQcmHEaKA9LVkk961VVXNkpojaD1Fb3X0cAXxEecCU7s2iPMkys9lDrgbK+AyvuXYiMc84RyDJw43NiqGtXf091fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(478600001)(8936002)(40480700001)(41300700001)(316002)(7696005)(8676002)(1076003)(186003)(4326008)(6636002)(70206006)(70586007)(110136005)(6666004)(26005)(2616005)(47076005)(83380400001)(40460700003)(36860700001)(336012)(426003)(30864003)(2906002)(356005)(82740400003)(81166007)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:52.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abee983-8e99-4d2b-f817-08db6de0abf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 408 ++++++++++++++++++
 5 files changed, 500 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 26d05e225088..c3a41db3c91c 100644
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
@@ -1505,6 +1506,8 @@ struct dc_link {
 
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
index af1f50742371..64bb8ac00788 100644
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
@@ -3576,6 +3968,22 @@ union dmub_rb_cmd {
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
-- 
2.25.1

