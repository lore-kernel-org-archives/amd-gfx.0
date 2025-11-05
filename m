Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81503CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF0910E77B;
	Wed,  5 Nov 2025 15:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gnLcKy3A";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9610010E777
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7NJe8wKfo6mcqaojvI6tqlT5XMJfvg41eWv1J3lfpdrnITaZuR4X1V0IrHKddRyA2iuNizOQCJ2/yRFFqAt/uBrBu3O6iOvrMFZ/em0zQba3VJ/6tLDPH+ICkWZMvgT0TMYysEInNEePrwH+BDe2evmDSkCpTlPsZXwpUNJe6dOPtV5X37HjJHx4bmlH8WRw1UW2qUd42pdNdbq965rreCD6HwwhmLEyVt3aEtugSf7DWhsG6HR63c5KRHRQSMKtbbGcycRqkn3yi1d0ioNHA/UyVp/TtRx5o6aiEY8Mqfpfs7LYqAQWlG1N05q5Lf6yfyP5npDi9ppvgh7fyAEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHScRbVFKJNRNM5EK5wAoEfwUKTFiu6QrFJ1u9o+lt8=;
 b=REZz28D7WkIBxZwiD9nVlu3/soqMoOvW7UVLt3zVN33ap0VqHESx0W+i2CLHdlJtig7FXkHKEtj1NutDDo4NSvglJ9XIdZKlPwBIqyZ+ef5sh7u821oR/wz6gpZp90Fv+4wdR8aWIGXwGU/pFzvjkqOCyz47fnMopidj2T+tNV1tQckSfj3D8FgxgHycUuKvSP9nJVyOdiKwfM3tdfkAfNFr88PPDUZAxtzOTiIX+3N0bbvlu1MWjyK9Fw2vQu89EeH3rCD3MKaafD0K3oWX4sGNCS9OybBexF6hKuY3NGU60o/TdDHGuix+WgdzIDw4OrO1xqcM1nbezgzhSxnkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHScRbVFKJNRNM5EK5wAoEfwUKTFiu6QrFJ1u9o+lt8=;
 b=gnLcKy3A3Oe/RscyMTsFRSzlkJbSTzEN1mZmVI8/aqTiAj7bQ9EdnMkp4EW7P8bX7hb8lMf91cF1EqfK0fRwBEPqZym24AdYJR2QIm72G1H4Ts/Xn+WJSrCDbGw4IpbjEVza191uH64JYr2BZZfUMTnpfJZmFvW7Wm0eUxT/iKM=
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 15:41:25 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::34) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 5 Nov 2025 15:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 15:41:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:41:03 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:41:03 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:41:03 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.1.35.0
Date: Wed, 5 Nov 2025 10:36:27 -0500
Message-ID: <20251105154035.883188-13-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef22ee8-ff11-4251-a130-08de1c81c764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M1KqCCk5c5rJuO7uUc25gzwbDtSrIsfYi7F/fko/W6r1AVxGE1/VDZJrPOJP?=
 =?us-ascii?Q?OYVu34rIx5KyMUr82KgOFO6kKRgUrpC1iEoDmOs+j/6gSNYKC1DjQDF5Qlit?=
 =?us-ascii?Q?U4tqwTSTXu9lRnE2EpJ1/l2BGcDpbJ0KiklfJH/IO+2sgq75M083rozxDzFL?=
 =?us-ascii?Q?MtaAp7Pppl6+MUf2NRaUTGgWU0r/Jw40pO5GjbyAZcwrpkcImC1lFNqKz8X2?=
 =?us-ascii?Q?u0qAAINOEWc5nN6+gJMgYdawCJvmiB/mFwzfS95sDV+adz28IYQGKvenIICl?=
 =?us-ascii?Q?NjJJfIKGZNZqg2ZoxuCAcV22POv9lgPyNT75J5cm1JguEacndj+u4tHRzSWp?=
 =?us-ascii?Q?OBbyslhhVK2Ue2tzeRedWoe1Gl6JWEKoofIkjYwI3tAI3chtLfgbhkthFnXF?=
 =?us-ascii?Q?UxbdpZIe9xuOH+XHw0HSqurr4jbWQcDiuNcRkhoEOjFHn1uOv/JJ9ZssArit?=
 =?us-ascii?Q?Fyh/7j98KUKnqM3dyHWvy0bgz3Vv9I5GTSjg3uQHJVKdsP7tgxFVAqjVBGAc?=
 =?us-ascii?Q?7tBMyKbc+2P5eowtyl+1Igi+hY6FzfbZw2M/GUrNfEqa4kubkvBgVu1uSws6?=
 =?us-ascii?Q?CgGEYXIS2Mc7CVBCjOtS62Wq7H0eIwjnn+R1O8hR9t+gq0pq2hgtEMzYumb0?=
 =?us-ascii?Q?UXKGYwbhRcMEXhGumTrV8L1YdeuvToANSE7XlkY2w1liL1FZSjyo77VLa/Oc?=
 =?us-ascii?Q?jsfW6GURhgvv1v7GgMoWkMplPKQXSh4pWGUc43wWNEVtKMjvMg2oKOK3ZERq?=
 =?us-ascii?Q?nseh1c7TWCrdo7iYDcNLiRJ8mcLpfoXD6X/YcpCGsBvzLYKajtk0662i6nNS?=
 =?us-ascii?Q?p2RHuapUOuAxnfER+TWRJxGPBkqu5iiV0n9tqOYD/tSjEsqMjDvDW87GCnUt?=
 =?us-ascii?Q?lKjQksRTl7IpzY2F5+mLtFNYG1Kb+V3v7mTiPBDNQnmJusvnMm+x/XJHRS78?=
 =?us-ascii?Q?+sBf4BQR0jHsmt4uft5pzD7w4xFBP70F2dJuehV21LAis1z5fQnI5oAPEoDT?=
 =?us-ascii?Q?Zvq9U063tyDwFQsy9wm0ZXp3lWboQmkjhIMpXFdee50D1AmMy20QItEj0DyT?=
 =?us-ascii?Q?Ovm7d6Q2B4liXP0+SinNxeHVtupdBYBOVWBd+hMDA5vWoRLU8Sobmu5wopgG?=
 =?us-ascii?Q?l1hurEKGJznI9MstffNHXnYhYLRihqC+XHo8EOy+Ip8NACMHmN0mipJmQboV?=
 =?us-ascii?Q?+m04+TfO60HG2bQ7qYBxXWGbvU/TQMExQGLkRFcZFNVgATZdYlv2p1vgGg7S?=
 =?us-ascii?Q?oy8tRVQYY03wf2gQatdneRbzixIrp7wxc+/elPoXNXIAD8oMcMIVvSSg0Odi?=
 =?us-ascii?Q?vr1frbQIYKLrqMKZ5SgeMhZSPf5dbSdOWONx442YcB4GC83qj56OYPaQOmt0?=
 =?us-ascii?Q?Zo6Ts4BP/v4oDq/U5X1epdGfOys0lGUq5xnKvuNUdHcsXwyhRFoeo6B8b/l6?=
 =?us-ascii?Q?LQct37AhWQoBcIn8+w7FapeOQBmcRbwT1Vue55ioJ5/ZfkmFfmoaEJf07svR?=
 =?us-ascii?Q?sNMQkkNHVynluBxVzK4ay0FBCky0J39YO086f3SrhECUnbx8FiefGU5XlJEA?=
 =?us-ascii?Q?4riVmXGHlDl55Y+94cM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:25.3471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef22ee8-ff11-4251-a130-08de1c81c764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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

Summary for changes in firmware:
* Use panel_inst instead of otg_inst when getting fw state
* Contrast strength improves when HDR desktop mode
* Ensure pipes have no outstanding HUBP requests prior to IPS RCG entry
* Check for vm request and vm idle status in IPS1/2 entry sequence

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 067949d6eeb8..815b4ec82c11 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -491,7 +491,13 @@ union replay_debug_flags {
 		 */
 		uint32_t debug_log_enabled : 1;
 
-		uint32_t reserved : 17;
+		/**
+		 * 0x8000 (bit 15)
+		 * @enable_sub_feature_visual_confirm: Enable Sub Feature Visual Confirm
+		 */
+		uint32_t enable_sub_feature_visual_confirm : 1;
+
+		uint32_t reserved : 16;
 	} bitfields;
 
 	uint32_t u32All;
@@ -4363,6 +4369,7 @@ enum dmub_cmd_replay_general_subtype {
 	REPLAY_GENERAL_CMD_DISABLED_DESYNC_ERROR_DETECTION,
 	REPLAY_GENERAL_CMD_UPDATE_ERROR_STATUS,
 	REPLAY_GENERAL_CMD_SET_LOW_RR_ACTIVATE,
+	REPLAY_GENERAL_CMD_VIDEO_CONFERENCING,
 };
 
 struct dmub_alpm_auxless_data {
-- 
2.43.0

