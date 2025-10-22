Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792F0CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B2F10E705;
	Wed, 22 Oct 2025 07:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tOdiyDEg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB8710E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS1gmW8e5PbSjWuqOVMJeocgHMXKAX7WPxqjMIHbcWAi/bzXPw8g33mnKTGoUThbUt3fprg/XHjNPp1bzHR9H01qjjv+udemH53zimXK1DhkdBPW35+ThdlV/PV4eut8iODN5NVLUpCJm+d0BRqp7YAlWifi8J4EGxfMXnoZxHvEsO1VH6r9Qg4MQdqMkPTBNbQsZSEjUfAZbVl7T+pk0eI24GNqoBhYqYzwq554me0TfBT+Hiuh7l7EpXVRxlc3ZZMAAi5Hi8HI9ee/BxwBF2CYjNTbCugcGlF+DRxnuipVDJYvtoMXp8BECm2REnFpEWT+UGVnjO/RwP0SESJPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFjtVxqaqaBDGD7B/VFkROU3UsZwTwDs/gSatIcOb5Y=;
 b=qP/ixKx+V5X0LcIRFidb07noDJuhE7EKxUZZMQw338ugjyGnXrR8hwTbbv9zvNGwei2FWYWcv5kbNohzWb7gtU6U0f2fM4JxclRfwzmFBtQIPii86HJI8tKEai348WuZCBKpdFAJokADbATpDLz0emU9WPlKboewseDKCZ4gAJ8h+aLlcyDa5dO+kIggsYoyFJfGiS6jeMET4pL3xjFZ0WxDP1BexsW0Jj5pJ2zeeKVdRbn5yMmlXa3h9RidkvMkEz0cB2ZbXZRkxeY2IOIkOIedyQ4b5gl7tTHNHIYzkUvNr1peec0RVCbVXSlCnPo7mEd2m10bD817XCZTvgXSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFjtVxqaqaBDGD7B/VFkROU3UsZwTwDs/gSatIcOb5Y=;
 b=tOdiyDEgZh3HNPLVSoJZzmbOEFuC4tGWBrqCyWGqcpo76LAGn+3Xdsdx94a0RiWWeszeQhe7lPZOpwVbW3dguCLBl4U748E2tbfOrcdVtd91MqQOusYk5AAN0V0qCfGjPDKVcAzocHDhQ39HsRZq+o42ED5bUsA35VFi1Wzwjgk=
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Wed, 22 Oct
 2025 07:35:33 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::94) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:17 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:17 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:35:14 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 19/20] drm/amd/display: [FW Promotion] Release 0.1.33.0
Date: Wed, 22 Oct 2025 15:30:31 +0800
Message-ID: <20251022073332.666119-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c59468a-3eef-40c4-12ed-08de113d95c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oDYNA5Ok/OVHskIokKb6kDhibWo4+37CyA3USICPG/HZKvbYCDucpX/0YtY/?=
 =?us-ascii?Q?B9ddpM/eFiTxDVX03JjC2Q00pSbUznwLhU1L85RHjS2Gv0uHnSntYJpLi7KS?=
 =?us-ascii?Q?jZUBIw9xC+wEj6k5sD0cM2O1/kag202V2O9Zyri67DHa4gft7X8f73q5Ojnl?=
 =?us-ascii?Q?I5SFjsWCKR+XVSs2QXH6j6nTvgLcGqRgIMcqwo7296JwnjnLItVy1AKb7D1G?=
 =?us-ascii?Q?NTtwDPq3FYlzhBl98fht6iRRmU/3EbwiqK7XikHxyWZyl7uqjG2AwIpNzc8B?=
 =?us-ascii?Q?f580YIc0zz1TweRLtH2oWJjSwriUPgLo+raebpk+QhgWpWK3XgIGFQbLAxmr?=
 =?us-ascii?Q?hCTN9mbPYJquyZ1eggJKlM9PSu9ql1/Aj/IEsJelFdoqySGo19ijSI1ZaCbn?=
 =?us-ascii?Q?LdQUIf3RaPdDYUA2cbbuQ4Mm9fbDcaNXOjedCbtptnbqF8eY7YE6xYBRJ0vh?=
 =?us-ascii?Q?vzgsaFlV6d2IrrnLcfnTLDF8FqcI0iTVZ1jo8GZMh5Yyg7Czi7P1nwXh4SJv?=
 =?us-ascii?Q?EqpB6up2lEIOg1kWp7QRI0nxJBGVo3joOOmMGK5GBVBNnhi0aStKjar41VQr?=
 =?us-ascii?Q?m6ef0wzK2+37o1atnZvwE3BZ+27w9zjUkKc1keBpQkm2A5lKzKMbxZGyIX4X?=
 =?us-ascii?Q?8/85h3CU87i+EX11WPGQY68gsa/yI0witMmii5eL5LAe3gPFQM8786SqjETF?=
 =?us-ascii?Q?XNEjYnOY3nb4OhF3lLrxO9iq45OqnBGuSAeJJE72YNymz7oVoPk4f4F9pvNM?=
 =?us-ascii?Q?NOhZTEOhhjAWUVe2wYsmNQS5PNjWDLvd/TRpctkL3rTewKtpddeKP4laHJuz?=
 =?us-ascii?Q?BChpGEzfXk7fMpHbkdhw14L38lMpqbOaP2WF3OW1sfvuigGC57Z7saCwe95U?=
 =?us-ascii?Q?cNgTaSkf8R1tctL/WAQAxbM2hipSHKQw/XbDcZA8CtVnHy0Hr+1gL6CyRcgi?=
 =?us-ascii?Q?g14AkTFKaKko54SH+QMd6MdlE+DbkwaXrGC9zLmcXFCQWiIUBbOlAlpMw7GK?=
 =?us-ascii?Q?wPhLLtD5txpj1omCghy6d0M5BPlxgZTKoMhTawVR1T4rWet4TyEL3y3i+DlZ?=
 =?us-ascii?Q?feljqosiLLhy6Pq6ZFIFwE7W2aKMIo1q8JNQk3rWmU+NAiwHqWN2vQ5y8S7C?=
 =?us-ascii?Q?hfLBNg7Fiuf9dpARmfJSf9/kW2hTbwyA/qa9RYitPH/mbKyvwiECJLCIpqnZ?=
 =?us-ascii?Q?ves+sHv2B0yvlvnqO7lEIQTmJnj+nid+HhNoI5oJl82rwntAUVTwyWyoztVq?=
 =?us-ascii?Q?6ZZQ+fppN6bbAAunwYJyJFQi1EiOpjGlTaGMOUnZr22VRajeXMGNV9rQ5AMq?=
 =?us-ascii?Q?rL15ccfzWa5wBEKIqy4Pt6h/Nh50XOrSinwMfvOiwBaqRL9NDDtZ6U2ZKuHq?=
 =?us-ascii?Q?MiijelB8i/wDgggs1dw9V/vLcIZ5sicuc1dtihnKvB7Uw0gKNQcTz6LAFOU5?=
 =?us-ascii?Q?HRODWguxDcHfzB4DSNGuSSgYeXNKoWXqtJas6BjlwZIv8GQ+tPwV+jaH0F9B?=
 =?us-ascii?Q?AcdxOqTbOV+NYwyudFFrCXWeWcsz4f3AyS/A1/EntuY2JxYxI1uA5eZ6brVy?=
 =?us-ascii?Q?9EK980hvDv9C8cpFHW9JR1/Pmb/Tta8MPCfMQCpD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:33.5797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c59468a-3eef-40c4-12ed-08de113d95c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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

[Why & How]
- Extend reply debug flags, define a new bit as debug_log_enabled
- Replace the padding to frame_skip_number in struct
  dmub_cmd_replay_set_coasting_vtotal_data

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c0a833ae606b..ae6e17a26bbb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -485,7 +485,13 @@ union replay_debug_flags {
 		 */
 		uint32_t enable_visual_confirm_debug : 1;
 
-		uint32_t reserved : 18;
+		/**
+		 * 0x4000 (bit 14)
+		 * @debug_log_enabled: Debug Log Enabled
+		 */
+		uint32_t debug_log_enabled : 1;
+
+		uint32_t reserved : 17;
 	} bitfields;
 
 	uint32_t u32All;
@@ -4620,9 +4626,9 @@ struct dmub_cmd_replay_set_coasting_vtotal_data {
 	 */
 	uint16_t coasting_vtotal_high;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * frame skip number.
 	 */
-	uint8_t pad[2];
+	uint16_t frame_skip_number;
 };
 
 /**
-- 
2.43.0

