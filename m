Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF7CE7F13B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E85A10E443;
	Tue, 26 Sep 2023 21:54:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D812F10E442
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abkRMSf6Xs3TjrVuQ8OaQU+S7rpGP0CUwfpDm1/qf18nHi9oFUcStetIZsAoFwGBAXg/LAp8hn7RtE77hsIa0S61Qt/nYBp3rS2loe/ypJ5BSloDU8BuchYi5UD59hUEf82UyGvm6LwGasarMHk7XfyR/HdpoVQ9t0f74rkxbrP1pw5BW5yH0/NZjHty/1VoKC4YkzzvK+K9zc85v8MoZmL4YiBDb+msApNjyduBaGOwnhHPUTp0tEyzbmhE1eF2kcZ8jIWed4jge3M9ajnulOOPck1asa6noL5sYnl4RpsLQGvnu7HsLi3VznPliddOGrVQIPMejTKUFzGKVWIQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t0fZhsu4KenwkonBYiZvxLRdMrGn1KfCMoLWVSUNtA=;
 b=Xm2KrXn5JapSnqCll0UC28jWsdA9n5xCPZLn+81KcSVpLvw7kfG9r7qQV3gyk747BhbwB8+JTVznKKkkROvtNYlSYGebVByc78u2Rwx2sIhpscs1CZ1X/JZ7AWLog39Pbi+mT6w8INENBkfCg7GgyD9DSAkA38QAthabtN97et+ZUs/917za2bRxFWtjSubgPt/SxQioGZEHSzgsY9G9kSFQIzxonE7Sfee/D9e/+oYRcgJ20+73I43n7/xWbas+tXohuapbo4Bz7B+eFOoorF6RN5cjGjyk8m2Mn9ekjVD2IbEJXHxSub4OO5mMgimUeKiqTjI5XAVF/vQ/PWhRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t0fZhsu4KenwkonBYiZvxLRdMrGn1KfCMoLWVSUNtA=;
 b=uIJ+rsSoi9E4RXwbjOxsCEKv5F82Kn/m+vn6orqvpRRuXeJYRqRILs52h3G1wlT97zZkyZ7F3YtUCnXfFu5aFFgaN5dvt/NauzKJkpAY/hsrRFz6OfibfgeP46Tz4tMnTBPWLz6hdffs3DU3SXhs0y46ee2xo/E6NM3HpgBbzc4=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:53:55 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::5b) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:55 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:54 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: Adjust code style for dmub_cmd.h
Date: Tue, 26 Sep 2023 17:47:03 -0400
Message-ID: <20230926215335.200765-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e619fa0-15ac-4258-fab5-08dbbedb148f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdBVbPLpDnHn/NZbTYD2SnpdgYyOOjqSopAQlDs/4EvAAAadg44HhsbdiiFFo4UpV8B/8tJv3Gf1IEsoAlxQmSqkCLg23iRJpTTSYQEdVCJuAYDnTsnz00isBxIwmo866ii1znl/yPaNVpHGtzbH9grIqu3jSh2Ec58UYeYjtUaoIuA2C8CC0/Eum5FaV0S5GwcC8sZZ/k7zVAfd1Blb0IzSJfN6On34E9T+N9A2K0fMJLTkbnOHhnJ0fzmAqDoUtPbIt2etHfoW9VbKsKA293KuVFDEr1X/svrfDazxGp3VV9ZipJTtmaysSj/6rqeLRahA0URgDl7QUKzKsVdwYWZRLr5SarfGhu5MJGM8xArMaVUIZwrhjHAmMcqu0Frb97tb++o2UE+cfHObkS8QaukZ/SZM6/qdT+ze4vsvpiPF1XRtFuP6SVoW5hfz39XUaAZIN0cWYZrk4S0Nytg3A/Z3qma283pwzJofz8u803UBvqjvJZ1FPVKYCRojWDJTEiLyIOKESoy9Bh7jQnKMtuqeFOMcgXFxUE00mWHFCfI576jRdvHShNxhVSVr4DClCsuc6Xj+ICjfbVCVCYRNOqgpx1qtksHdLKJooiMItyAFBxUtCM2Td8BZ6bailoUQ/kMPzgjj+71Fsrab+ekNsXqJXSMbzUMBmbsQ3w3/oPNrXL6rBTlXhAM5y6CgWBY/zEupjeg/dbfqtbv0Wa3aSrXPoA4FlNPG5awHG1R1kMN92Lx5KG3r+jfbIKK8jkl8gypKgcusZ8fnJ4WKhs7QMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(86362001)(336012)(1076003)(426003)(2616005)(6666004)(478600001)(36756003)(36860700001)(7696005)(47076005)(83380400001)(81166007)(82740400003)(356005)(40480700001)(26005)(8676002)(4326008)(44832011)(8936002)(70586007)(41300700001)(5660300002)(54906003)(70206006)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:55.4371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e619fa0-15ac-4258-fab5-08dbbedb148f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Make some formatting changes and rearranging of definitions for consistency.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 162 +++++++++---------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 25b59accb843..50686fef97f5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -464,7 +464,8 @@ union replay_hw_flags {
 };
 
 /**
- * DMUB visual confirm color
+ * DMUB feature capabilities.
+ * After DMUB init, driver will query FW capabilities prior to enabling certain features.
  */
 struct dmub_feature_caps {
 	/**
@@ -641,7 +642,7 @@ union dmub_fw_boot_options {
 		uint32_t enable_dpia: 1; /**< 1 if DPIA should be enabled */
 		uint32_t invalid_vbios_data: 1; /**< 1 if VBIOS data table is invalid */
 		uint32_t dpia_supported: 1; /**< 1 if DPIA is supported on this platform */
-		uint32_t sel_mux_phy_c_d_phy_f_g: 1; /**< 1 if PHYF/PHYG should be enabled */
+		uint32_t sel_mux_phy_c_d_phy_f_g: 1; /**< 1 if PHYF/PHYG should be enabled on DCN31 */
 		/**< 1 if all root clock gating is enabled and low power memory is enabled*/
 		uint32_t power_optimization: 1;
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
@@ -787,6 +788,11 @@ enum dmub_gpint_command {
 	 */
 	DMUB_GPINT__PSR_RESIDENCY = 9,
 
+	/**
+	 * DESC: Notifies DMCUB detection is done so detection required can be cleared.
+	 */
+	DMUB_GPINT__NOTIFY_DETECTION_DONE = 12,
+
 	/**
 	 * DESC: Get REPLAY state from FW.
 	 * RETURN: REPLAY state enum. This enum may need to be converted to the legacy REPLAY state value.
@@ -801,11 +807,6 @@ enum dmub_gpint_command {
 	 */
 	DMUB_GPINT__REPLAY_RESIDENCY = 14,
 
-
-	/**
-	 * DESC: Notifies DMCUB detection is done so detection required can be cleared.
-	 */
-	DMUB_GPINT__NOTIFY_DETECTION_DONE = 12,
 	/**
 	 * DESC: Updates the trace buffer lower 32-bit mask.
 	 * ARGS: The new mask
@@ -991,8 +992,9 @@ enum dmub_cmd_type {
 	 * Command type used for all panel control commands.
 	 */
 	DMUB_CMD__PANEL_CNTL = 74,
+
 	/**
-	 * Command type used for <TODO:description>
+	 * Command type used for all CAB commands.
 	 */
 	DMUB_CMD__CAB_FOR_SS = 75,
 
@@ -1017,7 +1019,6 @@ enum dmub_cmd_type {
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
-
 	/**
 	 * Command type used for all REPLAY commands.
 	 */
@@ -1240,6 +1241,28 @@ struct dmub_rb_cmd_PLAT_54186_wa {
 	struct dmub_cmd_PLAT_54186_wa flip; /**< Flip data */
 };
 
+/**
+ * enum dmub_cmd_mall_type - MALL commands
+ */
+enum dmub_cmd_mall_type {
+	/**
+	 * Allows display refresh from MALL.
+	 */
+	DMUB_CMD__MALL_ACTION_ALLOW = 0,
+	/**
+	 * Disallows display refresh from MALL.
+	 */
+	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
+	/**
+	 * Cursor copy for MALL.
+	 */
+	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
+	/**
+	 * Controls DF requests.
+	 */
+	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
+};
+
 /**
  * struct dmub_rb_cmd_mall - MALL command data.
  */
@@ -2078,28 +2101,6 @@ enum psr_version {
 	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
 };
 
-/**
- * enum dmub_cmd_mall_type - MALL commands
- */
-enum dmub_cmd_mall_type {
-	/**
-	 * Allows display refresh from MALL.
-	 */
-	DMUB_CMD__MALL_ACTION_ALLOW = 0,
-	/**
-	 * Disallows display refresh from MALL.
-	 */
-	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
-	/**
-	 * Cursor copy for MALL.
-	 */
-	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
-	/**
-	 * Controls DF requests.
-	 */
-	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
-};
-
 /**
  * PHY Link rate for DP.
  */
@@ -2760,6 +2761,20 @@ struct dmub_cmd_psr_set_power_opt_data {
 	uint32_t power_opt;
 };
 
+/**
+ * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
+ */
+struct dmub_rb_cmd_psr_set_power_opt {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
+	 */
+	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
+};
+
 #define REPLAY_RESIDENCY_MODE_SHIFT            (0)
 #define REPLAY_RESIDENCY_ENABLE_SHIFT          (1)
 
@@ -3048,20 +3063,6 @@ struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal {
 	struct dmub_cmd_replay_set_coasting_vtotal_data replay_set_coasting_vtotal_data;
 };
 
-/**
- * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
- */
-struct dmub_rb_cmd_psr_set_power_opt {
-	/**
-	 * Command header.
-	 */
-	struct dmub_cmd_header header;
-	/**
-	 * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
-	 */
-	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
-};
-
 /**
  * Set of HW components that can be locked.
  *
@@ -3694,17 +3695,16 @@ struct dmub_rb_cmd_query_feature_caps {
  */
 struct dmub_cmd_visual_confirm_color_data {
 	/**
-	 * DMUB feature capabilities.
-	 * After DMUB init, driver will query FW capabilities prior to enabling certain features.
+	 * DMUB visual confirm color
 	 */
-struct dmub_visual_confirm_color visual_confirm_color;
+	struct dmub_visual_confirm_color visual_confirm_color;
 };
 
 /**
  * Definition of a DMUB_CMD__GET_VISUAL_CONFIRM_COLOR command.
  */
 struct dmub_rb_cmd_get_visual_confirm_color {
- /**
+	/**
 	 * Command header.
 	 */
 	struct dmub_cmd_header header;
@@ -3714,38 +3714,6 @@ struct dmub_rb_cmd_get_visual_confirm_color {
 	struct dmub_cmd_visual_confirm_color_data visual_confirm_color_data;
 };
 
-struct dmub_optc_state {
-	uint32_t v_total_max;
-	uint32_t v_total_min;
-	uint32_t tg_inst;
-};
-
-struct dmub_rb_cmd_drr_update {
-		struct dmub_cmd_header header;
-		struct dmub_optc_state dmub_optc_state_req;
-};
-
-struct dmub_cmd_fw_assisted_mclk_switch_pipe_data {
-	uint32_t pix_clk_100hz;
-	uint8_t max_ramp_step;
-	uint8_t pipes;
-	uint8_t min_refresh_in_hz;
-	uint8_t pipe_count;
-	uint8_t pipe_index[4];
-};
-
-struct dmub_cmd_fw_assisted_mclk_switch_config {
-	uint8_t fams_enabled;
-	uint8_t visual_confirm_enabled;
-	uint16_t vactive_stretch_margin_us; // Extra vblank stretch required when doing FPO + Vactive
-	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_FPO_STREAMS];
-};
-
-struct dmub_rb_cmd_fw_assisted_mclk_switch {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_fw_assisted_mclk_switch_config config_data;
-};
-
 /**
  * enum dmub_cmd_panel_cntl_type - Panel control command.
  */
@@ -3784,6 +3752,38 @@ struct dmub_rb_cmd_panel_cntl {
 	struct dmub_cmd_panel_cntl_data data; /**< payload */
 };
 
+struct dmub_optc_state {
+	uint32_t v_total_max;
+	uint32_t v_total_min;
+	uint32_t tg_inst;
+};
+
+struct dmub_rb_cmd_drr_update {
+	struct dmub_cmd_header header;
+	struct dmub_optc_state dmub_optc_state_req;
+};
+
+struct dmub_cmd_fw_assisted_mclk_switch_pipe_data {
+	uint32_t pix_clk_100hz;
+	uint8_t max_ramp_step;
+	uint8_t pipes;
+	uint8_t min_refresh_in_hz;
+	uint8_t pipe_count;
+	uint8_t pipe_index[4];
+};
+
+struct dmub_cmd_fw_assisted_mclk_switch_config {
+	uint8_t fams_enabled;
+	uint8_t visual_confirm_enabled;
+	uint16_t vactive_stretch_margin_us; // Extra vblank stretch required when doing FPO + Vactive
+	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_FPO_STREAMS];
+};
+
+struct dmub_rb_cmd_fw_assisted_mclk_switch {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_fw_assisted_mclk_switch_config config_data;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
  */
-- 
2.42.0

