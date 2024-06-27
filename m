Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772B9C30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A5F10EB5B;
	Thu, 27 Jun 2024 21:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1W+sr1OK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6D010EB5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwfuWq3bgMgMLJlsk3LwEB9daN+j/m6dn0wAg5vOtgvQLQV2fQPdSnhr+kyBPsvdIWEdyKIfQKjUgiomF5T1r8SkNAl5LnGOGFBwsF0L1lkdE5Yl1nrBpszieLrf+Wmv2MpPpeI31hy1/G2Iiz8WMOjfEfgHScVIM3XLC6EwuEHQEKPeAyhiABhBocxKjlGuwBLeShB58KfA7jrwlvr6gHPRdMoVtHIo8rds/qGeqTYAyIKWZjm5lnW5Tgwqo2dGybL6Q/7qAhdZBlOE8+CfCbH013wZeaOSkn6Bx9jhil0kKP7lhOcUzi28DVfOBpfQ3i9XYSjMXAJbZUgHUmBjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Bc67df2bVVyvnT/5jJXyZEeg3MQjdsQAukrb3JK0Y=;
 b=EMUNSrvfKLBNdTsYpUjBZ6+XVLQH5JNHNTmF9lhr7pw792629AbNHtNFMK3IFGNq2vvKdsfrjkkpsLFsrAsRtmEMh/fVc7PcbW5kVkLiSBFghFDVCACRXh+l3VA5Cr4ceNDf9w+fdCJI1Wj6/0fbL+VQ5bHwyfQt9EByTF0IozYWl7rwRLzMNO1nEE2slr0yq4SamAJDuidxWc0gXmbQpgxltLR4AgVzKy2TaqIz/xPvtnfsxk89OT7un9+NyD7HSNmpEvax8yrI+ZUcm12Tt5Is3wh4MkgT2rJZl2yqXGIRCMGIWghP4ksCfoYIzxUa2GHdeBylszA8LIWi9yEjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0Bc67df2bVVyvnT/5jJXyZEeg3MQjdsQAukrb3JK0Y=;
 b=1W+sr1OK80iAQFwGEEc/yDbgDuNtYYTwnl74cyxB/453FkQs4QsJi0fi+oFD32gwUZpucHFLSt+2fAHmzZ4kLv02oLB/a+3pVxULR7opQdThEKd5iamrz/WEqpTmZ5Zjke/2zEpkuB6T/ACLShBNi06ww1akhbdkHZRrH+dQgCo=
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 21:14:37 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::ed) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:36 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:35 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Paul Hsieh <paul.hsieh@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 16/26] drm/amd/display: un-block 8k with single dimm
Date: Thu, 27 Jun 2024 17:13:19 -0400
Message-ID: <20240627211329.26386-17-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcd6c75-41b0-4db9-9472-08dc96ee2648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZGEoZn6ic3ye0/vrN0g0xKVK79O2ZX4gb9gaz+K22CbvDTwHYpMdSEzi4llR?=
 =?us-ascii?Q?49nd76n9mednPydT3P0y0qqodN+A6Pir2Dtlt6u4vFOeA1OCiSN4LstaYtSL?=
 =?us-ascii?Q?IE8vFUZEbZ8ia05ihMvfG/TdfdnXBAKBByBkjFppgUUcBDrJ0uWPPc2vV00M?=
 =?us-ascii?Q?B1m6IbHY9WlXuUDNG+TLKB8jUKF0oldb72oEMxm502ag2T0F/731wvh8e+Ja?=
 =?us-ascii?Q?i4x9Pn25zxr9143K71YUm/OVGZwOrI22CijqzVLFuIK0clxuwjHvAcSyIgJo?=
 =?us-ascii?Q?RTV/rZyegR6LCT1A6Xo3qZTX9ktrZR9Xfxy8iKyOPL720Da08EQak5xT7WYD?=
 =?us-ascii?Q?YWiHpverJssS89fm3KOAg0n+gOHoP5vSrUI8nB2xVe1JDd/G4h+U6fEGun+u?=
 =?us-ascii?Q?xVFn0a1rnKXuZzggb/PQQqWhj9nxgMqzG6Te8UMyQrh5hxRXfT5DU09WI+jK?=
 =?us-ascii?Q?q+IYqBhz4cIvGqgMt/5z1PrmPu8ylPKP6Q0F83JjBge4vnAm+PvQTsZeW2wh?=
 =?us-ascii?Q?QFh2CvvzjZhd8/M9ssZZt4AucRdh3ELMLci8RN5Q/sNY1E48lGFmwAcccuhv?=
 =?us-ascii?Q?nRFLX18DE+lkj9QlViCzWHgbGpufXae7s18V3t5XO5fTQCp2WHuvgMc1fDRB?=
 =?us-ascii?Q?NxHi6nCFaeSbIjDcAglCmwvlCZS4USUhKAABNx4bh0R6X5G1dWYyrpboYQaK?=
 =?us-ascii?Q?YuaDaPcNjQMOojY8rYUq9JdJcrlPxW049OpXQKqym+u4dsb6u1EDjj0mBbKz?=
 =?us-ascii?Q?zRCsv+rnK2UdD5Z52hdqpS2RZ3RJ2JBwZXXkleMQ85v8DGVZKbnK2vPIe3h3?=
 =?us-ascii?Q?bPklFbIvYILM5eWnLiA5DhveCHxflPb7DE4ncGiwGEQ6RV6gtLYK4KkyUMnQ?=
 =?us-ascii?Q?OSs9pTB7YEa/dIrXD+MsA6ROOaLXCoekgOTtZPB3R5puFJmhuG2cTz29rXlj?=
 =?us-ascii?Q?p8+FpgAkpDFgCV9P2vYSPP5mJKqlrchpCOTMiQYT68wbzGjFN52KtGA85VjV?=
 =?us-ascii?Q?Hz4urUxoTJwF/Up/zqNWj3Z6mFXDAGXAtZrWDw0u4zANZ/Y02qWEHArcM7Dc?=
 =?us-ascii?Q?n1K+kXpuIUAt6hMDDU5JBDZajHfRwa7jzPlAtMY4XyN0i+s8SDW3tHD5uvkG?=
 =?us-ascii?Q?9CZb/VT+kpur3VJ5Slg1w0wRA3VSi8cYDLMqMTnTl7QlvT4jMLW4Q30QkGyI?=
 =?us-ascii?Q?7WYFZlt41P8qlM1+s8qftVvHyvoRx35LBBngNqGlQn4ywrslfmufqCWHrcUp?=
 =?us-ascii?Q?V/eJn5Fr3HciyPdMtC7hDrHNPtExkr85JhmuySVhldlYOpMVvdhY1Nznd/Yh?=
 =?us-ascii?Q?iuLBvUSutcpJS6OItH0eLdT02gc4b8qR0xUQ++Cp+4Vs9cWcWCurYzyVv0kT?=
 =?us-ascii?Q?YiMERredr2jWEsZS1uZ7FnoMQEPKXL0vYUVFuGfIr7hfK2azPOpBH5A7Wj8x?=
 =?us-ascii?Q?DssgWke25BLE25LjHoldmLcjIE+Aqklq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:36.5472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcd6c75-41b0-4db9-9472-08dc96ee2648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
Driver doesn't validate multi-display with scaling when OS calls DDI.
This behavior causes the validated result to be a mismatch
between some automated test cases.
To address this issue, some workaround was added that caused issues in 8k.

[How]
Since the origin issue had been root caused,
revert the previous workaround and unblock 8k with a single dimm.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 .../dc/resource/dcn314/dcn314_resource.c      | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index da73e842c55c..169924d0a839 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1695,25 +1695,6 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
-static bool filter_modes_for_single_channel_workaround(struct dc *dc,
-		struct dc_state *context)
-{
-	// Filter 2K@240Hz+8K@24fps above combination timing if memory only has single dimm LPDDR
-	if (dc->clk_mgr->bw_params->vram_type == 34 &&
-	    dc->clk_mgr->bw_params->num_channels < 2 &&
-	    context->stream_count > 1) {
-		int total_phy_pix_clk = 0;
-
-		for (int i = 0; i < context->stream_count; i++)
-			if (context->res_ctx.pipe_ctx[i].stream)
-				total_phy_pix_clk += context->res_ctx.pipe_ctx[i].stream->phy_pix_clk;
-
-		if (total_phy_pix_clk >= (1148928+826260)) //2K@240Hz+8K@24fps
-			return true;
-	}
-	return false;
-}
-
 bool dcn314_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -1732,9 +1713,6 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 	if (!pipes)
 		goto validate_fail;
 
-	if (filter_modes_for_single_channel_workaround(dc, context))
-		goto validate_fail;
-
 	DC_FP_START();
 	// do not support self refresh only
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, false);
-- 
2.34.1

