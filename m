Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F4DC30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DAF10EB66;
	Thu, 27 Jun 2024 21:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hwlmaxpx";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4F410EB64
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ79s2yG0ST2NRK7wxM0AGAU2cE9+/nkJuRUpBdLE4UyaXlGX+YUFNPka7V+pzXGr10XNNz/48ZBmeDACjBuwjUIb8NZhzszJ3oCuUA0fNsLDLMZ5pMuIwSi0SS/ArhBbgGnu9amVo4fORuLAwRqlf6JYL4hIfjE08O3aKVHBEp2d7ooqg3nnD2ZKRtHe6JNqL/mudMWyOVLflFoMlgdio202bmEzo4a47gRh0UzfrGIxcIC3QCnfSVXlG0RmXHiJZVcO2kNV1SC0QmDtuWWBjLsSwTFGm2Lu5lAEf9pQD2alGE43ryKrZBLB8G2Firm/cTwytF2XHzOWQwUNXkMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPK9yXdJn1OYSopOyvwE6BFTYhWaudKKPyTpFbpFySo=;
 b=hluENpUpT3SIXM/WcIzu+L1veopLSMz5N8M4U5iJa0RkSZwlz5GctrvCDUa+oEKV76IgsnqGc+T4+M4Am60yeXW0Oufh6yE4PyRFimIOWqinwVD4eaGrrXROj03Fwy0EMZZFr6kZ0VP48n05+/NnrIqyfUREDRGZ9luMseyaNEX/xIsvKvxvndAA8Dd0Fy0kw/TwzbeUPtztebU30eW75+gC4uenxyBrrpTAItI6S9yHfgiWyjEnMtDEDnYfXViHgHTVcYlsGaLZiVKG+XvrY3fC8H3ZXckMY2hOpjGLyQN/j5DBahHsz0/TR6+zD+AT0+S5U4lGKmyP2V8IF24ZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPK9yXdJn1OYSopOyvwE6BFTYhWaudKKPyTpFbpFySo=;
 b=Hwlmaxpx7NU1c3YtoKOLEUnfFAE9bfoYnapOSXGbgp0CfQ859IB0UCy3E6nV6Ch/rZhSznBkpAyexWNXIz6nH5MQW6sOQBi+tb12nITwABKyNq6PDu9ekIuT75Sd4xEGmIG/pSJuZzA6UPlAFS01pBatmBzy90aueBbdN2SuufE=
Received: from PH8PR05CA0016.namprd05.prod.outlook.com (2603:10b6:510:2cc::17)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 21:14:43 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::9d) by PH8PR05CA0016.outlook.office365.com
 (2603:10b6:510:2cc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:40 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:40 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 19/26] drm/amd/display: fix a crash when clock source is
 reference for non otg master pipe
Date: Thu, 27 Jun 2024 17:13:22 -0400
Message-ID: <20240627211329.26386-20-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: ab11479f-8026-4e72-a180-08dc96ee2a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a74qU7kC17QALOZO+U0jBIt3zh9X3X2uOHdj0F9XSi7tzEo5anYv7x6G2flv?=
 =?us-ascii?Q?ssneJ6tf9n7KK28DYtn8Gt8G4dEtub1xhGbaPVOXFfgSHscoJbURYqHdsUl5?=
 =?us-ascii?Q?H8y9ZbRb5C47C1uqTFbj7baCcaoeAzjKRgm+dRcV31C7Rv7crf4Kz/nsLvXB?=
 =?us-ascii?Q?oI2BYy+aVU89CirFEJveg+9csFpf+z1HI4MhEUq4UamQjsGaFOxdWMQuup5Z?=
 =?us-ascii?Q?ADEOTcSeF+08pnE/ruMhWUh5/yq1z1zn7SnC70K4M/kv9Yrvqyvp/6NYFM0g?=
 =?us-ascii?Q?WXKSBRqNr8xSlJ7otbkf1m52N+R8/g1v5mw5FEYPJsahrGhyZlkNF37Tl1IN?=
 =?us-ascii?Q?q7vl+RTLEjHKFmX0vWS6gCJnAnHF1/sVO2fvaruLVdT6V4/ztNumWMRKZZHQ?=
 =?us-ascii?Q?Pn/pwr3bvM4J+usFegf1TrJlu8p9EiJbKzuGwjVAJOKrw4b6LCAqBYIPbJv5?=
 =?us-ascii?Q?AdoxKWBTSKFlzATozCkGzk1P3LiHGRxGhjv6MqoztUH25Jm+gdO9/CLIlzZ1?=
 =?us-ascii?Q?X4T2s5BxTLMfLL8byodYjHwb05SnyTCA/GtRYiJbgUAefxPNgxKVJgUhdgwI?=
 =?us-ascii?Q?CsPi/e/AkR4QjHIuWRlORlM9p3sUuwnvvldyDFuUPhUBeyQTlyy2McKZN9vm?=
 =?us-ascii?Q?+6f7zlGXp9KQ26vvVPd12v7LR2nnZNXIZKimX1IJpqj0xDsfl9tZ+PS8YK1r?=
 =?us-ascii?Q?QrhdIAByrcPYSsgpFKcq25o/u775iDpbabOPdu3rg5wogkMVzZqcdFq8PPs/?=
 =?us-ascii?Q?srbmBS9CGg1lWSfLO/jcytqDE+S3987ahy/xXRSgSJ9e41Z3ZGNa/9HGFFum?=
 =?us-ascii?Q?UpV+FrlBLqYTPHS0moH5m7N8/Jd2eiFleo93bNJgJPxB8IJZzQWWhCHcO/nr?=
 =?us-ascii?Q?JLLfuzHTop+EkkeTeYvibymXYoCXcycJzLj7QdEdKj+OOxOu+EPjBv+GiS06?=
 =?us-ascii?Q?HMd9fNERgnMSz9MH2W9ru1/5f5rsZnT2KOQ87b41zenGsts4/twX00TUEqZx?=
 =?us-ascii?Q?4mTpsFwF6p4bK33+aHUm8CLy5QQYg1IapMwpnCcpEXzKiskctckPrbQQ3Gmx?=
 =?us-ascii?Q?vnIi1IJirCkUdAbHFXiwIycq/mJskTLb80WbP1bfSVpFLBcYficBjZU+pjkT?=
 =?us-ascii?Q?snN05AKvw1IMQGhYv7BNaX+xI84Jz5OOOUGI4vMKQQXFahJLekflJtxxwkBa?=
 =?us-ascii?Q?nUP1Db91rlDNYLRZdG275BuyO/Kky4/nK4KlJs7QXogQmtfgafKPfr1WbvtM?=
 =?us-ascii?Q?0Gkm1PwHvRHy4pqgxbJOiZXpFPI5zRNO/pMLDkbimkXv58K8tChoPa5reg8f?=
 =?us-ascii?Q?mvExdo1xUcs43mr9ZDqm2+UQOVe9sVMgr+fNQSCFPuwMrjCBAMnVQ8K17cis?=
 =?us-ascii?Q?kvrNwlU+bWzAEyfdWfmT7Mgcb4E1MIHuBvDIHX/y9ncpKx47CeIAMX+Fconj?=
 =?us-ascii?Q?pw1GwYf14ZAVYJw7mcbosYLi6EVFHTW8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:42.9499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab11479f-8026-4e72-a180-08dc96ee2a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The function enumerates all pipes without checking pipe type. It is only
supposed to call program pixel clock for OTG master pipe only.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 606b2411eee9..45fe17a46890 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -306,27 +306,29 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 			struct dc_state *context,
 			int ref_dtbclk_khz)
 {
-	struct dccg *dccg = clk_mgr->dccg;
-	uint32_t tg_mask = 0;
 	int i;
+	struct dccg *dccg = clk_mgr->dccg;
+	struct pipe_ctx *otg_master;
+	bool use_hpo_encoder;
 
-	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-		/* use mask to program DTO once per tg */
-		if (pipe_ctx->stream_res.tg &&
-				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
-			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
-
-			if (dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-				pipe_ctx->clock_source->funcs->program_pix_clk(
-						pipe_ctx->clock_source,
-						&pipe_ctx->stream_res.pix_clk_params,
-						dccg->ctx->dc->link_srv->dp_get_encoding_format(&pipe_ctx->link_config.dp_link_settings),
-						&pipe_ctx->pll_settings);
-			}
 
-		}
+	for (i = 0; i < context->stream_count; i++) {
+		otg_master = resource_get_otg_master_for_stream(
+				&context->res_ctx, context->streams[i]);
+		ASSERT(otg_master);
+		ASSERT(otg_master->clock_source);
+		ASSERT(otg_master->clock_source->funcs->program_pix_clk);
+		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
+
+		use_hpo_encoder = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master);
+		if (!use_hpo_encoder)
+			continue;
+
+		otg_master->clock_source->funcs->program_pix_clk(
+				otg_master->clock_source,
+				&otg_master->stream_res.pix_clk_params,
+				dccg->ctx->dc->link_srv->dp_get_encoding_format(&otg_master->link_config.dp_link_settings),
+				&otg_master->pll_settings);
 	}
 }
 
-- 
2.34.1

