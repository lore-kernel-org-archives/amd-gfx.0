Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F35C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E4810E740;
	Wed,  7 May 2025 02:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMoirKTh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 215E910E740
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvZw6HaJqrUkIrNbypyCe9fTpra04+XqBmEBAOoSj8TS7RCyDLhRV3aTXCfuyv+q66oCdSz/kbmXLMEHkevUva3uXdcQ/k0B/3te4/elMvC0vdImoskaOlKBKKnNyJnW9v9yB5D09tjbfwXZ8o97P1eDu/z9L2BqebsX7bbmDDLh0y2PsRQcjVXDYsbAC71WsTNAm0vaaPmloTdimh6+mUYma83wvteAqOvImwDxrQ6OdMQFnbLJUY48G3xLm/3ebCHk2LTUzzgv1YxjZx6BkNHAf1NfT/d2kRhjAsanBl/b/iwRQGUA88JRQ96L52PxozYTu0HZi3vihib+jySLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Nn0kdqKHuZIfAPBP8HYsqF5OP4/rXXG+PJCoUZgl0M=;
 b=rgHUI2/FegnVD65x7ljzICiuwCfl/LWl8KRrKNqCOFHxBVcPWySrD9612oyv3hQTymlO0+SdzX9x1sExddmwt7YuyAmdli4leXiLZ0+24LwGZ0DJvO+yKbjSR81NfBKAL51bz3ZWT90WYWtSLSbmcKoZ4myFMh+myNNLEYsEocD+h0njjMyiCDtbWmMkXbhSEZdA6+PKv1qtc7lAimcIFCVAs8gReULIO3sr5/X6xe+HkOA2KAJJqlEsTo4GqK0zn/qSyBFPiddUubnYYjTw+W++a2pEui18jmbS3Rpy7IoFGDb5A/yZtv7M11aF8yFgs/75pta3VmyEF8mrD07mTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Nn0kdqKHuZIfAPBP8HYsqF5OP4/rXXG+PJCoUZgl0M=;
 b=YMoirKThq2B+EeulQc8WL3G/emj8JvG+2huZsiiaHem4sBSXeqGVZOZ2nrRUChNShHM5XHABMCW3tzXeKCoNffh+RFraWg6wclqPkUEJ/QxpI1Di5holc8Su6Fsxs9aaUhP8jNt9qtsVL5WBPnVolgQZCTd0nxIRWnx9KE1B/Fg=
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 02:43:59 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::ec) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 7 May 2025 02:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:57 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:54 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/14] drm/amd/display: [FW Promotion] Release 0.1.10.0
Date: Wed, 7 May 2025 10:34:55 +0800
Message-ID: <20250507024242.1928299-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fc4e9e-66aa-4b6f-fb4e-08dd8d110485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UBzLFLVSflzj0hfHucvaPZHCkVRTERlzaflNzaAPzFv0DEdS+wBhYb7K99eh?=
 =?us-ascii?Q?zYqnphevmFqiwETuc1KhjPNIx5+eDI9CVIB/4g50jW+y1eJoqhSBv/JadxxM?=
 =?us-ascii?Q?0QilyrkzyiKxkVYlyajEKB1nFCDJhgHDq2OmNfl9eMvnMJyNb/CP0r2krbwM?=
 =?us-ascii?Q?RQ3X361Spe9tkmzM+BMqAHUgnXKLMbxYyi7GVc9x5G77ooQoZuPUS2VWCmdl?=
 =?us-ascii?Q?R97gr021VhQAGEME1mbSbY3R7DtoF2rCglQk3ElDndcBDL4LJG6qHrAgw/rZ?=
 =?us-ascii?Q?MMYamt2lMrPQzpMjwjowIFB+4J/SVrE4eC7Z8/sp9scEuQkMci0sKokps6PH?=
 =?us-ascii?Q?Ozs0KWR92LHHGKwmstjkIbQnsRib+BrqUMvXPI5DuFFkugzzKTB/xEHdFd5W?=
 =?us-ascii?Q?GG5wiuzauQDsczxltconzcLQ1opofsJYeQDzCp8t6x+Wg+y0VLy7DnFKU8uY?=
 =?us-ascii?Q?54DFktDFlcHxYEjj3TLk8FonojGQmKQzWqyIpPL+Z+Q5hPWU/WZ+wkGeW3Ja?=
 =?us-ascii?Q?GwrPVsbEN5FPGRqqS1hu14UuHSXGPmHl42IZrunH+1QVEEHVpYzj2pNTIy4n?=
 =?us-ascii?Q?roUDvhHQISZUK3/mo/PLN3sKMe3MhxAV4amLT9AyeWi3ZWp14iBiMNMZtZZ2?=
 =?us-ascii?Q?nTlO88W/noA5W+wpJU9B9TAryhPTjZUHNUaIhkuXXhX3WPSaaF2MXySg+lIX?=
 =?us-ascii?Q?P63KzTvpT38ocSgAIO0s6GJCu12ljhyGa1eIu/Y2Cm39DAof2bZgntryIWjV?=
 =?us-ascii?Q?aDg1QB4hZEbrp8E/yK7hJCUn3dWTd4Abex1u8G+v938/5JZKKvTo1rM7uYlK?=
 =?us-ascii?Q?pXMKDuZsbox2+RaSH6EKJhRURMAJ+bGjzStfURZMxK6MduPM/8jDhUdK3sCF?=
 =?us-ascii?Q?n1AR+UA4zNCjEEmO6jZiTDh9jrM8cBnwN/6S8DBkKl5JDwgj8ggiETkSlu0b?=
 =?us-ascii?Q?SGi3Z87QB8Sv2P4aarpsp2Wye2oTTgnEtgYnmtL8YN3w8Umn3gummFI6NDOT?=
 =?us-ascii?Q?HZ3fqX5r7k7DOY95cJDJes2/RmCTkELwHr8v+vqytGvieHUuP9vA5CROD6kL?=
 =?us-ascii?Q?LPn6cv9MEWIJg5LRR0ABHmey/B18LxxY3GITxp6DbufxDcL/dprdjflHDIQJ?=
 =?us-ascii?Q?le6w5r47VNWK8xCblw1FpZDVYhSOSAeuXpZKMPeKvNrW7pETTLeostEwgcHz?=
 =?us-ascii?Q?on5ERM+eQcfbbQ6jObh34g+aIzItNdaWdmJIKXlU9Kux/GnR0jnSN8zzjyF8?=
 =?us-ascii?Q?0oDX8z0jmsKeX1uI3JskgOQ4jzj11DziGINvIZEdXcN3oSZsip4gZIcp06Gg?=
 =?us-ascii?Q?a9kjLjRWKGdvpury3XOcWNUGs3UCAYXzLCsyXmLTwBOMdhvPBJjhOFl7Q1Qs?=
 =?us-ascii?Q?KUeqr9Fh3E4vl3uT841hwWQxtWhLD7a9fpZX/WAaFVcYxA+QmljVxMnuHyCX?=
 =?us-ascii?Q?T53KkHGwqdD1VbhImRQutQ4/th/Tv+WfuHwnhG5eNuus0zbGDfxlGg+h4Dxk?=
 =?us-ascii?Q?91SFRu3vLZg4hUpj7t4a7DZpu2HJnK0v/O/w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:58.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fc4e9e-66aa-4b6f-fb4e-08dd8d110485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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

Refactoring some IPS and panel replay structs

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 50 +++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 76e9dcc15466..b66bd10cdc9b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -550,6 +550,11 @@ union replay_hw_flags {
 		 * @is_alpm_initialized: Indicates whether ALPM is initialized
 		 */
 		uint32_t is_alpm_initialized : 1;
+
+		/**
+		 * @alpm_mode: Indicates ALPM mode selected
+		 */
+		uint32_t alpm_mode : 2;
 	} bitfields;
 
 	uint32_t u32All;
@@ -742,6 +747,14 @@ enum dmub_ips_disable_type {
 	DMUB_IPS_DISABLE_IPS2_Z10 = 4,
 	DMUB_IPS_DISABLE_DYNAMIC = 5,
 	DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF = 6,
+	DMUB_IPS_DISABLE_Z8_RETENTION = 7,
+};
+
+enum dmub_ips_rcg_disable_type {
+	DMUB_IPS_RCG_ENABLE = 0,
+	DMUB_IPS0_RCG_DISABLE = 1,
+	DMUB_IPS1_RCG_DISABLE = 2,
+	DMUB_IPS_RCG_DISABLE = 3
 };
 
 #define DMUB_IPS1_ALLOW_MASK 0x00000001
@@ -820,11 +833,12 @@ enum dmub_shared_state_feature_id {
  */
 union dmub_shared_state_ips_fw_signals {
 	struct {
-		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 */
+		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 or IPS0 RCG */
 		uint32_t ips2_commit : 1; /**< 1 if in IPS2 */
 		uint32_t in_idle : 1; /**< 1 if DMCUB is in idle */
 		uint32_t detection_required : 1; /**< 1 if detection is required */
-		uint32_t reserved_bits : 28; /**< Reversed */
+		uint32_t ips1z8_commit: 1; /**< 1 if in IPS1 Z8 Retention */
+		uint32_t reserved_bits : 27; /**< Reversed */
 	} bits;
 	uint32_t all;
 };
@@ -839,7 +853,10 @@ union dmub_shared_state_ips_driver_signals {
 		uint32_t allow_ips2 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_z10 : 1; /**< 1 if Z10 is allowed */
 		uint32_t allow_idle: 1; /**< 1 if driver is allowing idle */
-		uint32_t reserved_bits : 27; /**< Reversed bits */
+		uint32_t allow_ips0_rcg : 1; /**< 1 is IPS0 RCG is allowed */
+		uint32_t allow_ips1_rcg : 1; /**< 1 is IPS1 RCG is allowed */
+		uint32_t allow_ips1z8 : 1; /**< 1 is IPS1 Z8 Retention is allowed */
+		uint32_t reserved_bits : 24; /**< Reversed bits */
 	} bits;
 	uint32_t all;
 };
@@ -868,7 +885,9 @@ struct dmub_shared_state_ips_fw {
 	uint32_t ips1_exit_count; /**< Exit counter for IPS1 */
 	uint32_t ips2_entry_count; /**< Entry counter for IPS2 */
 	uint32_t ips2_exit_count; /**< Exit counter for IPS2 */
-	uint32_t reserved[55]; /**< Reversed, to be updated when adding new fields. */
+	uint32_t ips1_z8ret_entry_count; /**< Entry counter for IPS1 Z8 Retention */
+	uint32_t ips1_z8ret_exit_count; /**< Exit counter for IPS1 Z8 Retention */
+	uint32_t reserved[53]; /**< Reversed, to be updated when adding new fields. */
 }; /* 248-bytes, fixed */
 
 /**
@@ -1256,6 +1275,10 @@ enum dmub_gpint_command {
 	 * DESC: Setup debug configs.
 	 */
 	DMUB_GPINT__SETUP_DEBUG_MODE = 136,
+	/**
+	 * DESC: Initiates IPS wake sequence.
+	 */
+	DMUB_GPINT__IPS_DEBUG_WAKE = 137,
 };
 
 /**
@@ -3616,6 +3639,12 @@ struct dmub_rb_cmd_psr_set_power_opt {
 	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
 };
 
+enum dmub_alpm_mode {
+	ALPM_AUXWAKE = 0,
+	ALPM_AUXLESS = 1,
+	ALPM_UNSUPPORTED = 2,
+};
+
 /**
  * Definition of Replay Residency GPINT command.
  * Bit[0] - Residency mode for Revision 0
@@ -3749,6 +3778,15 @@ enum dmub_cmd_replay_general_subtype {
 	REPLAY_GENERAL_CMD_SET_LOW_RR_ACTIVATE,
 };
 
+struct dmub_alpm_auxless_data {
+	uint16_t lfps_setup_ns;
+	uint16_t lfps_period_ns;
+	uint16_t lfps_silence_ns;
+	uint16_t lfps_t1_t2_override_us;
+	short lfps_t1_t2_offset_us;
+	uint8_t lttpr_count;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__REPLAY_COPY_SETTINGS command.
  */
@@ -3819,6 +3857,10 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * Use FSM state for Replay power up/down
 	 */
 	uint8_t use_phy_fsm;
+	/**
+	 * Use for AUX-less ALPM LFPS wake operation
+	 */
+	struct dmub_alpm_auxless_data auxless_alpm_data;
 };
 
 /**
-- 
2.43.0

