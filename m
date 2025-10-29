Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BBACCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9749C10E0D3;
	Wed, 29 Oct 2025 03:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIL63WTg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799A310E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4/L+SoZ2SP6pjcmrDF9hRgvKlK0HSUN6lmC4v833pjscZ+lor1cjTJ3iH0UP8LT542bc+OInQxFkSi8Mv1ccfzOrR42JRr/0UB4mMIeAlBtyOPwGfkwUr97Vd8QzuXIi1qhbbyTVzdjjoVYUVoOhD3MIAYsR6UMopYyKlzQOaICpa71q5PmkGRXRdY34VclFbDrkorhzEJOTutPicwpIsriaVyVf5thr2u41yG0YYSdXKUw21/1uYmiFclwpbUsLb9+Jh2WY34qXj4UB9EOMXGl8eyzAtp84NoEHnBFgcCS+qu+CprXPza/SxSZIfGSTXebnZhvaprcDaCdyUp7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpzVe9LxGvuHxDI6NByETohXaId41cm82++QyNLszC8=;
 b=JsMYlXtbNU6k1ZjysExSLIu6JSPjQsYuQHI9Iw1azNVGBRXwwPycNlQ++3zuJdJG7onP6XJUSZMl2lcboHpgNp7WHh7bj86lhXD33ShibW1aaLgWAWYXFaivMET2wzTbqWPyHDp2sv0VhLACQcrCFdhozXEKz582yt+5+Nl6PNfeEtS3wt+jMgKL+mnsHWVqRscJUEe3iN35icO2E2amUk5ovF6HceXwF4hoqCwOSX08WUxcO7R15lZ7HJkWw2m+d78jKn67W+zDCvgt/6OZCMWvhOpEnf8E6ZqdH3ZtcinTl9RUsn2XQdYRrCsiZGO4w8ffWsBTtVy2EMWbrFYlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpzVe9LxGvuHxDI6NByETohXaId41cm82++QyNLszC8=;
 b=TIL63WTgk6gLsll5mOlrfRCyONxocPD4GSfcx7vnctf1/pa+O322oXRTnMyJoy3PCCTC9ef48Jl+P5dg1dfxFlw8KJINKQuyaKdE9tB2nQw7AVm8RQcnXH63tGJsZXCf6PDADHkyFX/ScqyCt37tyrP1zWDJ/aXuoTVhEtoOrKc=
Received: from CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::8)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 03:12:12 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::5) by CH0P221CA0019.outlook.office365.com
 (2603:10b6:610:11c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:12:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:12:02 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:12:01 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:11:48 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.1.34.0
Date: Wed, 29 Oct 2025 11:03:00 +0800
Message-ID: <20251029030935.2785560-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd11bde-aafe-4708-4654-08de1698f492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Et/lDcCNUta3ONfNDFdENSopMWHqX6ZkgCdGSuWI2g1XIuW85lbTwsEaotX2?=
 =?us-ascii?Q?bWe9t6BVBSYGWq/DzJ87lD68/eKwhd1QXAo6mllYHd4aYYhFQdcBqqbi5sib?=
 =?us-ascii?Q?VSLasT5DYBuXsxaywKRyIN6SPHk5auuOaZx4enUbb/kNhP3X8PDGiTZ/Lfqf?=
 =?us-ascii?Q?DNG8Dt1i3gKuq4y1NSzqrAl5k8BYqHcbfnO27ZTMcDbBpJs4eFPG5aG3cMHH?=
 =?us-ascii?Q?2FeA1jMqBu9mvspbWeLtX26E4H1ni068OHNvc26aHalkRrcMqZYfn2Xt8l8Z?=
 =?us-ascii?Q?nplPgPGCT37y4eN0B5CacX5q7wcH5q4qzwug7Hy1+Bxf23iPzCCDroStBdg/?=
 =?us-ascii?Q?dL7jkXADXpNT9u0qISajvoCza3XZRB1qw6uFSWcnG1BcxTUOcqbA83w+FbzH?=
 =?us-ascii?Q?BRIjlmuuRzyicKmGG271I+TkUBT2pO9SV2rd2JgA66+S1MthjbFuB54gNNFD?=
 =?us-ascii?Q?Je9P7Vt2dIA7yKhGA3+jpGdyJAPDnifopmbygTzdwKxMo+leETcaZPjKTFVV?=
 =?us-ascii?Q?lgaLkDaJD3CxZIWBTHLp7i3t3ToLyVjoWJXoEX1sp1JvyJ3qt83wPmf1NVH2?=
 =?us-ascii?Q?OQEpa+Ek9KD2Ofd7geFD5vOyGWoAoAOSECjnwYwVzis+4aAkHA3NSRnv/5F0?=
 =?us-ascii?Q?6EA254YMNFz8Kmp3md2Q4lS6Rge7KXnhDYfVpVcm2jp+/kFHPaQnttgfEdgJ?=
 =?us-ascii?Q?Xc33hdfHNeVzW6QLMbHcdap1BAujSA90tLLLDj5KF3xie+fxK1YB8HBEGBzk?=
 =?us-ascii?Q?ww4svCV1JCfwFgfPXmlHZf3w+etefo6XUMhQ0q9k5FcgbTN3YRIkxEqu8BsC?=
 =?us-ascii?Q?IucuO0jRVxdDfiCi5CQZJ/92O0DfFCN4H2FoGXhzkDcbVHuCK/107a+w8mG3?=
 =?us-ascii?Q?O2R7pyUjtG40YFsTdLA+qSEFMEpzgHpixlD2Acxvq9fRhsnOxSqU7YHROhVl?=
 =?us-ascii?Q?HnBGnl1Wx+ZdMwEdvzt0QvCV0a/m28EXkojT+09P2X6MaCHiaJYaP6l2FfRC?=
 =?us-ascii?Q?9xQJn/2x67iz3xUkHcoZ4GwXwRX6lwHcnVkcguZVkIAFjNhmrPApHg4uWAJA?=
 =?us-ascii?Q?XuPo+r3osnj2OURDRmpdRi2ciw0fHM9sv6zB1F28RAT7Ujglmuyje+iLJMt0?=
 =?us-ascii?Q?C5kds7mkLbbrEG3cd061oqttQqtpMwur//NQZ+KmsTyitH5nm0Xgi82PnM1I?=
 =?us-ascii?Q?pwwA/pMJq3Hj7MyLyp7N/D3KZkRTpJOZJar6G3KRiAwawWyUGWeeTzycvQ0B?=
 =?us-ascii?Q?21mjQ8+yRsi2VIJ5WwxA3C3UYvg2Wol8M7RuJqfGaKSypzZ2/xb+JFafGklI?=
 =?us-ascii?Q?wGZmNb8/5n7eOkdPsT1+9P42Wq8YzuvK5+NlV2AdPtENxcCnWHNCv7q6wdyw?=
 =?us-ascii?Q?xmvYuTPIyEDTI80Mc5essJKMKyJpwyXehFr03u73jSeFicO5PxpyKbF/gQe6?=
 =?us-ascii?Q?rFE0WO6fERjc9hvZk3TruU16IoTy7fm8l3P3/Rfxkvpg4qV1SJk+KcKTS2NU?=
 =?us-ascii?Q?BDNjFPgK+y+iSEnnqgQVubpODJctNWS2+B0bumHbWkADHbv5xtWLohkRe6ad?=
 =?us-ascii?Q?Jjt8H6u1Wyl4zRPxluU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:12:12.6737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd11bde-aafe-4708-4654-08de1698f492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Release hightlights

  DCN35/36
    * Dynamically clock gate before and after prefetch

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 439 ++++++++++++++++--
 1 file changed, 407 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ae6e17a26bbb..a0ffa046d8c2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -599,6 +599,104 @@ union replay_hw_flags {
 	uint32_t u32All;
 };
 
+/**
+ * Flags that can be set by driver to change some Panel Replay behaviour.
+ */
+union pr_debug_flags {
+	struct {
+		/**
+		 * 0x1 (bit 0)
+		 * Enable visual confirm in FW.
+		 */
+		uint32_t visual_confirm : 1;
+
+		/**
+		 * 0x2 (bit 1)
+		 * @skip_crc: Set if need to skip CRC.
+		 */
+		uint32_t skip_crc : 1;
+
+		/**
+		 * 0x4 (bit 2)
+		 * @force_link_power_on: Force disable ALPM control
+		 */
+		uint32_t force_link_power_on : 1;
+
+		/**
+		 * 0x8 (bit 3)
+		 * @force_phy_power_on: Force phy power on
+		 */
+		uint32_t force_phy_power_on : 1;
+
+		/**
+		 * 0x10 (bit 4)
+		 * @skip_crtc_disabled: CRTC disable skipped
+		 */
+		uint32_t skip_crtc_disabled : 1;
+
+		/*
+		 * 0x20 (bit 5)
+		 * @visual_confirm_rate_control: Enable Visual Confirm rate control detection
+		 */
+		uint32_t visual_confirm_rate_control : 1;
+
+		uint32_t reserved : 26;
+	} bitfields;
+
+	uint32_t u32All;
+};
+
+union pr_hw_flags {
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
+		/**
+		 * @is_alpm_initialized: Indicates whether ALPM is initialized
+		 */
+		uint32_t is_alpm_initialized : 1;
+		/**
+		 * @alpm_mode: Indicates ALPM mode selected
+		 */
+		uint32_t alpm_mode : 2;
+	} bitfields;
+
+	uint32_t u32All;
+};
+
 union fw_assisted_mclk_switch_version {
 	struct {
 		uint8_t minor : 5;
@@ -1732,9 +1830,15 @@ enum dmub_cmd_type {
 	DMUB_CMD__CURSOR_OFFLOAD = 92,
 
 	/**
-	 * Command type used for all SMART_POWER_HDR commands.
+	 * Command type used for all SMART_POWER_OLED commands.
+	 */
+	DMUB_CMD__SMART_POWER_OLED = 93,
+
+	/**
+	 * Command type use for all Panel Replay commands.
 	 */
-	DMUB_CMD__SMART_POWER_HDR = 93,
+	DMUB_CMD__PR = 94,
+
 
 	/**
 	 * Command type use for VBIOS shared commands.
@@ -4147,6 +4251,33 @@ enum replay_state {
 	REPLAY_STATE_INVALID		= 0xFF,
 };
 
+/**
+ * Definition of a panel replay state
+ */
+enum pr_state {
+	PR_STATE_0									= 0x00, // State 0 steady state
+	// Pending SDP and Unlock before back to State 0
+	PR_STATE_0_PENDING_SDP_AND_UNLOCK			= 0x01,
+	PR_STATE_1									= 0x10, // State 1
+	PR_STATE_2									= 0x20, // State 2 steady state
+	// Pending frame transmission before transition to State 2
+	PR_STATE_2_PENDING_FRAME_TRANSMISSION		= 0x30,
+	// Active and Powered Up
+	PR_STATE_2_POWERED							= 0x31,
+	// Active and Powered Down, but need to blank HUBP after DPG_EN latch
+	PR_STATE_2_PENDING_HUBP_BLANK				= 0x32,
+	// Active and Pending Power Up
+	PR_STATE_2_PENDING_POWER_UP					= 0x33,
+	// Active and Powered Up, Pending DPG latch
+	PR_STATE_2_PENDING_LOCK_FOR_DPG_POWER_ON	= 0x34,
+	// Active and Powered Up, Pending SDP and Unlock
+	PR_STATE_2_PENDING_SDP_AND_UNLOCK			= 0x35,
+	// Pending transmission of AS SDP for timing sync, but no rfb update
+	PR_STATE_2_PENDING_AS_SDP					= 0x36,
+	// Invalid
+	PR_STATE_INVALID							= 0xFF,
+};
+
 /**
  * Replay command sub-types.
  */
@@ -4197,6 +4328,25 @@ enum dmub_cmd_replay_type {
 	DMUB_CMD__REPLAY_SET_GENERAL_CMD = 16,
 };
 
+/*
+ * Panel Replay sub-types
+ */
+enum dmub_cmd_panel_replay_type {
+	DMUB_CMD__PR_ENABLE = 0,
+	DMUB_CMD__PR_COPY_SETTINGS = 1,
+	DMUB_CMD__PR_UPDATE_STATE = 2,
+	DMUB_CMD__PR_GENERAL_CMD = 3,
+};
+
+enum dmub_cmd_panel_replay_state_update_subtype {
+	PR_STATE_UPDATE_COASTING_VTOTAL = 0x1,
+	PR_STATE_UPDATE_SYNC_MODE = 0x2,
+};
+
+enum dmub_cmd_panel_replay_general_subtype {
+	PR_GENERAL_CMD_DEBUG_OPTION = 0x1,
+};
+
 /**
  * Replay general command sub-types.
  */
@@ -4349,17 +4499,13 @@ struct dmub_cmd_replay_set_version_data {
 	 */
 	uint8_t panel_inst;
 	/**
-	 * PSR version that FW should implement.
+	 * Replay version that FW should implement.
 	 */
 	enum replay_version version;
-	/**
-	 * PSR control version.
-	 */
-	uint8_t cmd_version;
 	/**
 	 * Explicit padding to 4 byte boundary.
 	 */
-	uint8_t pad[2];
+	uint8_t pad[3];
 };
 
 /**
@@ -4405,11 +4551,11 @@ enum replay_enable {
 };
 
 /**
- * Data passed from driver to FW in a DMUB_CMD__SMART_POWER_HDR_ENABLE command.
+ * Data passed from driver to FW in a DMUB_CMD__SMART_POWER_OLED_ENABLE command.
  */
-struct dmub_rb_cmd_smart_power_hdr_enable_data {
+struct dmub_rb_cmd_smart_power_oled_enable_data {
 	/**
-	 * SMART_POWER_HDR enable or disable.
+	 * SMART_POWER_OLED enable or disable.
 	 */
 	uint8_t enable;
 	/**
@@ -4789,53 +4935,53 @@ union dmub_replay_cmd_set {
 };
 
 /**
- * SMART POWER HDR command sub-types.
+ * SMART POWER OLED command sub-types.
  */
-enum dmub_cmd_smart_power_hdr_type {
+enum dmub_cmd_smart_power_oled_type {
 
 	/**
-	 * Enable/Disable SMART_POWER_HDR.
+	 * Enable/Disable SMART_POWER_OLED.
 	 */
-	DMUB_CMD__SMART_POWER_HDR_ENABLE = 1,
+	DMUB_CMD__SMART_POWER_OLED_ENABLE = 1,
 	/**
-	 * Get current MaxCLL value if SMART POWER HDR is enabled.
+	 * Get current MaxCLL value if SMART POWER OLED is enabled.
 	 */
-	DMUB_CMD__SMART_POWER_HDR_GETMAXCLL = 2,
+	DMUB_CMD__SMART_POWER_OLED_GETMAXCLL = 2,
 };
 
 /**
- * Definition of a DMUB_CMD__SMART_POWER_HDR command.
+ * Definition of a DMUB_CMD__SMART_POWER_OLED command.
  */
-struct dmub_rb_cmd_smart_power_hdr_enable {
+struct dmub_rb_cmd_smart_power_oled_enable {
 	/**
 	 * Command header.
 	 */
 	struct dmub_cmd_header header;
 
-	struct dmub_rb_cmd_smart_power_hdr_enable_data data;
+	struct dmub_rb_cmd_smart_power_oled_enable_data data;
 };
 
-struct dmub_cmd_smart_power_hdr_getmaxcll_input {
+struct dmub_cmd_smart_power_oled_getmaxcll_input {
 	uint8_t panel_inst;
 	uint8_t pad[3];
 };
 
-struct dmub_cmd_smart_power_hdr_getmaxcll_output {
+struct dmub_cmd_smart_power_oled_getmaxcll_output {
 	uint16_t current_max_cll;
 	uint8_t pad[2];
 };
 
 /**
- * Definition of a DMUB_CMD__SMART_POWER_HDR command.
+ * Definition of a DMUB_CMD__SMART_POWER_OLED command.
  */
-struct dmub_rb_cmd_smart_power_hdr_getmaxcll {
+struct dmub_rb_cmd_smart_power_oled_getmaxcll {
 	struct dmub_cmd_header header; /**< Command header */
 	/**
-	 * Data passed from driver to FW in a DMUB_CMD__SMART_POWER_HDR_GETMAXCLL command.
+	 * Data passed from driver to FW in a DMUB_CMD__SMART_POWER_OLED_GETMAXCLL command.
 	 */
-	union dmub_cmd_smart_power_hdr_getmaxcll_data {
-		struct dmub_cmd_smart_power_hdr_getmaxcll_input input; /**< Input */
-		struct dmub_cmd_smart_power_hdr_getmaxcll_output output; /**< Output */
+	union dmub_cmd_smart_power_oled_getmaxcll_data {
+		struct dmub_cmd_smart_power_oled_getmaxcll_input input; /**< Input */
+		struct dmub_cmd_smart_power_oled_getmaxcll_output output; /**< Output */
 		uint32_t output_raw; /**< Raw data output */
 	} data;
 };
@@ -6368,6 +6514,223 @@ struct dmub_rb_cmd_cursor_offload_stream_cntl {
 	struct dmub_cmd_cursor_offload_stream_data data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PR_ENABLE command.
+ */
+struct dmub_cmd_pr_enable_data {
+	/**
+	 * Panel Replay enable or disable.
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
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__PR_ENABLE command.
+ * Panel Replay enable/disable is controlled using action in data.
+ */
+struct dmub_rb_cmd_pr_enable {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	struct dmub_cmd_pr_enable_data data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PR_COPY_SETTINGS command.
+ */
+struct dmub_cmd_pr_copy_settings_data {
+	/**
+	 * Flags that can be set by driver to change some replay behaviour.
+	 */
+	union pr_debug_flags debug;
+
+	/**
+	 * @flags: Flags used to determine feature functionality.
+	 */
+	union pr_hw_flags flags;
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
+	/*
+	 * Use FSM state for Replay power up/down
+	 */
+	uint8_t use_phy_fsm;
+	/*
+	 * Use FSFT afftet pixel clk
+	 */
+	uint32_t pix_clk_100hz;
+	/*
+	 * Use Original pixel clock
+	 */
+	uint32_t sink_pix_clk_100hz;
+	/**
+	 * Use for AUX-less ALPM LFPS wake operation
+	 */
+	struct dmub_alpm_auxless_data auxless_alpm_data;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__PR_COPY_SETTINGS command.
+ */
+struct dmub_rb_cmd_pr_copy_settings {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__PR_COPY_SETTINGS command.
+	 */
+	struct dmub_cmd_pr_copy_settings_data data;
+};
+
+struct dmub_cmd_pr_update_state_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+
+	uint8_t pad[3]; // align to 4-byte boundary
+	/*
+	 * Update flags to control the update behavior.
+	 */
+	uint32_t update_flag;
+	/**
+	 * state/data to set.
+	 */
+	uint32_t coasting_vtotal;
+	uint32_t sync_mode;
+};
+
+struct dmub_cmd_pr_general_cmd_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * subtype: PR general cmd sub type
+	 */
+	uint8_t subtype;
+
+	uint8_t pad[2];
+	/**
+	 * config data by different subtypes
+	 */
+	union {
+		uint32_t u32All;
+	} data;
+};
+
+/**
+ * Definition of a DMUB_CMD__PR_UPDATE_STATE command.
+ */
+struct dmub_rb_cmd_pr_update_state {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__PR_UPDATE_STATE command.
+	 */
+	struct dmub_cmd_pr_update_state_data data;
+};
+
+/**
+ * Definition of a DMUB_CMD__PR_GENERAL_CMD command.
+ */
+struct dmub_rb_cmd_pr_general_cmd {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__PR_GENERAL_CMD command.
+	 */
+	struct dmub_cmd_pr_general_cmd_data data;
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -6710,13 +7073,25 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_cursor_offload_stream_cntl cursor_offload_stream_ctnl;
 	/**
-	 * Definition of a DMUB_CMD__SMART_POWER_HDR_ENABLE command.
+	 * Definition of a DMUB_CMD__SMART_POWER_OLED_ENABLE command.
 	 */
-	struct dmub_rb_cmd_smart_power_hdr_enable smart_power_hdr_enable;
+	struct dmub_rb_cmd_smart_power_oled_enable smart_power_oled_enable;
 	/**
-	 * Definition of a DMUB_CMD__DMUB_CMD__SMART_POWER_HDR_GETMAXCLL command.
+	 * Definition of a DMUB_CMD__DMUB_CMD__SMART_POWER_OLED_GETMAXCLL command.
 	 */
-	struct dmub_rb_cmd_smart_power_hdr_getmaxcll smart_power_hdr_getmaxcll;
+	struct dmub_rb_cmd_smart_power_oled_getmaxcll smart_power_oled_getmaxcll;
+	/*
+	 * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
+	 */
+	struct dmub_rb_cmd_pr_copy_settings pr_copy_settings;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_ENABLE command.
+	 */
+	struct dmub_rb_cmd_pr_enable pr_enable;
+
+	struct dmub_rb_cmd_pr_update_state pr_update_state;
+
+	struct dmub_rb_cmd_pr_general_cmd pr_general_cmd;
 };
 
 /**
-- 
2.43.0

