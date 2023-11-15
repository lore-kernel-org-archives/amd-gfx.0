Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C8DC072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CEE10E589;
	Wed, 15 Nov 2023 19:44:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A6F10E588
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyXwib+ofCHJ/HiQNNYgqkPpIHRHaBMhaZYc4hcdAeOc3oKvzNL+tFYM2to4hi7e52Kjmn1Uea36y1bZ9IlxA3UCY/O3f5Wa459eRJiwYbZVuO6vgF67WmLPwjMmeB7AiuG7B8SaQdu7cwDMpe56WcRAFX3Aee5I6fJlTmtaemwf/WcTwOSlgJVUiomeEr3bxvmC0uCWWSvI0JPm8ki9x/1tTehvf4IdhjfHo4jNOKgp9My60+0j7Qi5Hya292UZ2r20oHuGkAPb8nkS9iHMYtQrv6IT1XADBuU8FWpECZeSCAfF7BH6TlrC7fHJoRO/RnGFmvLXvrp0BzmH+DzWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrWJSLQu2dOtOvDx6wP5SMdjFibXvL+O5Ji28bN5e1o=;
 b=m8fMHiqbc1iDYGN1QCZDzmqDboDTXnerh7EKHfm1MH+XQ7zUStK1Gl3CTk0DT+cdXopmWVtQ9XxlCnfGlAGf2caZb1bHJI9M9ZoZTNGtXj7as7D0UIKQwERvtaiDiQD0BasN0b/RW6hpUPMGfAVbrl6MIm4w87aQUUf0aLKRJSVHVHxE4KzsJXZsMe0wdAVGjerOIQOR7gkTUZGI/DXECBwu2NWwM5jOzxQypcJCTArL2ctEtYkGEGzeEC6LYdaV6Tuzn8BFao8j1NRdCUq87hSTwrlhKSRfhamwiyWOFOe782FeuDlcCwHPMSWvLG7KnXWfSNcTVWiZz2C9Irl62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrWJSLQu2dOtOvDx6wP5SMdjFibXvL+O5Ji28bN5e1o=;
 b=MA780yzWt1JIBlnwDZ3F3oOfGfQm9mCVi9N5dh45jr9gU9npn+pU4jPOHOOJ6yRKxaECaH57pAHidHcXoqz/QjpAVymIazjIAs4uSh9u8b5miH9GJ61hISMvh5fTD8yL4RLjjie83p0QmT1BORpR2WsJ10sG5jrV3rDbDIkHJi0=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:34 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::f1) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:34 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:30 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/35] drm/amd/display: Disable Timing sync check in
 Full-Screen Video Case
Date: Wed, 15 Nov 2023 14:40:33 -0500
Message-ID: <20231115194332.39469-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f4b417-ec9a-4651-55bf-08dbe6134b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afbAfyDTUf6EHtQhogRX6br7Ii2/R6DJxmXEJtvELtasKszLq0M41LUbx5yQPrn3lrrgS/or2mETk5xalap+QoAb7lMAsiMhYQD8nP2/d1OiK0DWEb3Ki0GxpyKfTqPFYE05LUjy39q2wGY0/DXJIGpG1DAAbNI6H+vvw4oVuLkUfVcq+96xezwojAvG3sWnraL3cPxDYgtjq5yTZutSfAEvd/HUk94OenShz41A70n6VzNPLyLzk3zkl3bnFmE0Q5En5oi5fr1EsKEUOCTI/dcpjSKRFIBTtGamYTgICz4/C4dX/XXXZQLtbls7Yyn6Wdy/u1S1gPjMhDMDSq/wSFevP2z4+9yg9tNdsrEH1pKhljhKCVraJGpaEmlcMfosG5dUmVXm33pSIddZ0k5FpSHsqVOEghQWrSnC9+4pH5wSJWja2Nv6eK4WcFqWTmOurmjYtlruFLQsEIgHJ5tJ/q0MuV7di7VnvXYGLf9zezwz5DgQyiBDr4LXEQsJjzjQ/FzhfHCSO9UnAuE8bnSZCt9a05sUSJEjHsokFLiZrPwpuxWk79CYE5WMl4fdRdqoeJHMkuFkjtUsxp1Iwl2j0pPugAS399amEJ0TjOJNubZkHrCa1eRZkDss3Zhr0WEsz9yfgNjxJwY2aK09KIS2wR6tdvf2897eJsutk8O2ndR1WI1njMlRTTr7Qk1YTpKz9AjoK3JPtUO+pXq8V1XLJKaZC3r9L6+coh/67IJGr9Hqo08CtaJd9+pYlyrges3aimuh0S9N4KyfcA82L04cYKSz143UQxPf0S3eBRBq3nmz8i0WFdRlqJiYRwhCL39f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(2906002)(356005)(81166007)(47076005)(36860700001)(40480700001)(83380400001)(5660300002)(86362001)(336012)(82740400003)(16526019)(26005)(2616005)(1076003)(44832011)(426003)(8936002)(478600001)(4326008)(8676002)(40460700003)(316002)(70206006)(6916009)(70586007)(54906003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:34.3500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f4b417-ec9a-4651-55bf-08dbe6134b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Dennis Chan <dennis.chan@amd.com>, wayne.lin@amd.com,
 Robin Chen <robin.chen@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Chan <dennis.chan@amd.com>

[why]
If Panel max link off frame count is low, it will cause low residency
for Replay, then Disabled timing sync check in Full screen Video Case.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 66 +++++++++++++------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  9 ++-
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index a2f6c994a2a9..7313cfe69498 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1018,6 +1018,12 @@ enum replay_coasting_vtotal_type {
 	PR_COASTING_TYPE_NUM,
 };
 
+enum replay_link_off_frame_count_level {
+	PR_LINK_OFF_FRAME_COUNT_FAIL = 0x0,
+	PR_LINK_OFF_FRAME_COUNT_GOOD = 0x2,
+	PR_LINK_OFF_FRAME_COUNT_BEST = 0x6,
+};
+
 /*
  * This is general Interface for Replay to
  * set an 32 bit variable to dmub
@@ -1041,26 +1047,48 @@ union replay_error_status {
 };
 
 struct replay_config {
-	bool replay_supported;                          // Replay feature is supported
-	unsigned int replay_power_opt_supported;        // Power opt flags that are supported
-	bool replay_smu_opt_supported;                  // SMU optimization is supported
-	unsigned int replay_enable_option;              // Replay enablement option
-	uint32_t debug_flags;                           // Replay debug flags
-	bool replay_timing_sync_supported; // Replay desync is supported
-	bool force_disable_desync_error_check;             // Replay desync is supported
-	bool received_desync_error_hpd; //Replay Received Desync Error HPD.
-	union replay_error_status replay_error_status; // Replay error status
-};
-
-/* Replay feature flags */
+	/* Replay feature is supported */
+	bool replay_supported;
+	/* Power opt flags that are supported */
+	unsigned int replay_power_opt_supported;
+	/* SMU optimization is supported */
+	bool replay_smu_opt_supported;
+	/* Replay enablement option */
+	unsigned int replay_enable_option;
+	/* Replay debug flags */
+	uint32_t debug_flags;
+	/* Replay sync is supported */
+	bool replay_timing_sync_supported;
+	/* Replay Disable desync error check. */
+	bool force_disable_desync_error_check;
+	/* Replay Received Desync Error HPD. */
+	bool received_desync_error_hpd;
+	/* Replay feature is supported long vblank */
+	bool replay_support_fast_resync_in_ultra_sleep_mode;
+	/* Replay error status */
+	union replay_error_status replay_error_status;
+};
+
+/* Replay feature flags*/
 struct replay_settings {
-	struct replay_config config;            // Replay configuration
-	bool replay_feature_enabled;            // Replay feature is ready for activating
-	bool replay_allow_active;               // Replay is currently active
-	unsigned int replay_power_opt_active;   // Power opt flags that are activated currently
-	bool replay_smu_opt_enable;             // SMU optimization is enabled
-	uint16_t coasting_vtotal;               // Current Coasting vtotal
-	uint16_t coasting_vtotal_table[PR_COASTING_TYPE_NUM]; // Coasting vtotal table
+	/* Replay configuration */
+	struct replay_config config;
+	/* Replay feature is ready for activating */
+	bool replay_feature_enabled;
+	/* Replay is currently active */
+	bool replay_allow_active;
+	/* Replay is currently active */
+	bool replay_allow_long_vblank;
+	/* Power opt flags that are activated currently */
+	unsigned int replay_power_opt_active;
+	/* SMU optimization is enabled */
+	bool replay_smu_opt_enable;
+	/* Current Coasting vtotal */
+	uint16_t coasting_vtotal;
+	/* Coasting vtotal table */
+	uint16_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
+	/* Maximum link off frame count */
+	enum replay_link_off_frame_count_level link_off_frame_count_level;
 };
 
 /* To split out "global" and "per-panel" config settings.
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d1becbb5aa29..a08073fc92ae 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3056,15 +3056,14 @@ struct dmub_cmd_replay_set_timing_sync_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
-
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * REPLAY set_timing_sync
 	 */
-	uint8_t pad[3];
+	uint8_t timing_sync_supported;
 	/**
-	 * REPLAY set_timing_sync
+	 * Explicit padding to 4 byte boundary.
 	 */
-	bool timing_sync_supported;
+	uint8_t pad[2];
 };
 
 /**
-- 
2.42.0

