Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1159C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9A410E313;
	Thu, 25 Jul 2024 18:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4FSTHzN";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59B410E313
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRCF+tgUoXpuxXRlu07apsANpWTD62aupUFq65Qnfliqkarkstl4o9a4kSdo7jV5KKkqF0s0/2PhziPiw8oVGscKxOC7TPK3YnxL18bkEyMZq2KzqBxR/CCTvR/xn6uMSne/7zqBLgtOs4Xj8eNtZDJLhNL5Uh/lwbDJEodIeuDxNiW0uVGM0WERhbEdSkYaAei36t/RN7Sa2Velxgq5mUDKqkhVNO63GRj0ILkuF8SA4aWPmvQQXkGhxjrFatwTQMQwKKFChvZA62+uiwYo1BgB2PSn9iU8rTDv+MzijOhgD7gdFOmEac4qMlhgup6xJ97gF6lr70yj2PWadUYhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sAm3Kpuv29BwtZjChqsq6Pn+b+7j7LzocoTzY6sE/A=;
 b=iAE3TPuxosUXV5BVOvHnkgrxoIuIZDfKglPSKp/B7EzcQuAjojdq+kb3tbHfdCzSLSzD3LYXHqlIl/LXKKBiaYO3igbjHeqRu2qZ6W3cImSn5GZl8w+FQNq4/V8z4uv7l/9LWkhh+pYdcVb97z35llmiZI+x6a3P352YmhsYl+KZ78ondbkEEXbjQyogOxK4snmYH1ihiSNBP2owckiZDXeFXCSYQ6YtdzQoemGcyEs3zSG4mmowO9hac6LrT7vDP15iD17pevPbTTmMHEPi+w4ICwnfkraAVWUb3bFpisfY83X4ILwbPrF/yQLaigpkOXuv7zMnc68a4+wfTRUOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sAm3Kpuv29BwtZjChqsq6Pn+b+7j7LzocoTzY6sE/A=;
 b=S4FSTHzN+8UvsxIgZX9cnFgMvqvVaDhg6Jplmp1LiwdSe/E4jMT1AYsDLHDvA4HWajLZHHm6v2T5u8hIMSaNreUkuwsEYcL0MEYc1pV9DP8+9eQtgL+DH26PLWcy/CgyA/dxvHv7DJ1Y30I9DV1TZdN89AIJ9UWqM1+0rdopPt4=
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:03:55 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::5c) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:55 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Xi Liu <xi.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 11/39] drm/amd/display: restore immediate_disable_crtc for w/a
Date: Thu, 25 Jul 2024 12:00:55 -0600
Message-ID: <20240725180309.105968-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9fc9e2-f60d-4b6d-da84-08dcacd42651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SU5U01tAG3q+4qtq3nG61nNTEu+2q5IzPziVZCAZnQVuNUU66EIZ7a2EeQdD?=
 =?us-ascii?Q?B/wPyaGriLZkDX+ETxfOLtJHQKDRjO1HyKRKH7BwyVKOsTnUjZdUFxvIs7hl?=
 =?us-ascii?Q?zSKOe8qfFbPLz1NoMm4fpGR9OjK2guCei5Nghqclq3OGRoxRL1y3zwHC+QDy?=
 =?us-ascii?Q?4X5EDFGamfEZDgHBm1lDtybiuiIx7WttSy/KD1AnCSNglxf2xCO4Mjob3Qk/?=
 =?us-ascii?Q?o8bE+uQNZSOkTwHZbJ9Cxp3Zs/jCHnBn/jK1vepxfi+YsD78xE8DsDGi+MyH?=
 =?us-ascii?Q?NeqG6FD+9d6LSEp9RK96sYUb7VgVqBJ5hCuLLy3C+24LHsu0BZJDgQ6BNkiG?=
 =?us-ascii?Q?RJZgFCue18HxUyVJuXlu5t/1ZUZ41jhA/eWnhqRxHaN9H6dDflZbpoii83zi?=
 =?us-ascii?Q?n57zZe5THp6h3MMbQBLRkMDsMveo2WGHVYfrgojll8wrrIa5kyHfe3wf+pfJ?=
 =?us-ascii?Q?79yopMt225epig7TpA4u9mGPT+IihHnr+TWtMFfM+c69RaZse+61/oRrqw6u?=
 =?us-ascii?Q?bYI9bqDLbaBQVISBQ3V8n1SKJ/lvY2q0sv+DjCZWjAix7q0DUk0I7sj8XKFE?=
 =?us-ascii?Q?7PFgv9EnTCHcsgFe3otOkExsFgbuo6Dfq/0za6v9guTPty+losJTqslMlIGA?=
 =?us-ascii?Q?KQCvDB6rZRb1FPaZS5ARU8I/GnsLBDwXEjx/x9t8H1UwzyYp2o5gBvS7TjJJ?=
 =?us-ascii?Q?T5+vcz5fUy3ZkrZgkJ3OhqOckTqTcaj8O8bP2fRIPUm7Iy4G/siUzxUJcsny?=
 =?us-ascii?Q?QWvisUy/aGmQWOiFVUfBrM1Gv4o5REHTxRoJ9ySvVCAwY9hSNOrn8zJXZmNp?=
 =?us-ascii?Q?d79CJfxSO7B1MLwzYn37Kjew6nCGlca5DJ0k6LifCiXskQ7EF3pGHx5Dh2y7?=
 =?us-ascii?Q?RYjSRcS0Xj4qSyBXxau/gqvIgE1CuBXP/mKNbdAWL7Hc9k2Gx+akhvBbzgbE?=
 =?us-ascii?Q?d1Rq9KVR3unKzLUwu3hFAdJTtfRvf5F/p7MkoQfvY4dH4kO3OstIzoSQWZP+?=
 =?us-ascii?Q?ihSkHrOG7Ip7D1Fdv4VZz/gr19uk3h1BqjboOXQ+f41Z9Etw4Y+YRJNXjyol?=
 =?us-ascii?Q?u5vVs9reVeUmBGcpPmj7o1oGSBbUb7FMqx9kOIrh3vjNPqM3OkpaJqZVW0q8?=
 =?us-ascii?Q?B0eK8ujcsTSxF5jkeLEEsTfQKr4TVjtlAAt5HMuLqU/KPVsIP7D6OiGuaIuL?=
 =?us-ascii?Q?MvExDrQA6lxSE0G7B7nqolnZucKQa/b8bXKtL8sEVoskc5N28dQ26Fkd9DyM?=
 =?us-ascii?Q?Fjkyao2+mNuC+Jbn44tym9USeJ7FJ3SJnDRliNXB3wCN6s7OovPcOg/MvIxe?=
 =?us-ascii?Q?IHD5bKK+s8u+hD7SBDm6JcnDCHe9kQ4rngvToQqz9LTbpa2WMduAhfE6DkW3?=
 =?us-ascii?Q?JUOSoNxi0/zXYqT9Y62cD5kvRkDNag2sLI7X6D66bvkh2vXdODNFM56Jo+KS?=
 =?us-ascii?Q?BIAZ3RtHhIpO5I8+rdHncO82cL4GZ7yh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:55.3054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9fc9e2-f60d-4b6d-da84-08dcacd42651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
immediate_disable_crtc does not reset ODM.  if switching to disable_crtc
which will disable ODM as well.  i.e. need to restore ODM mem cfg at
reenable it at end of w/a.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Xi (Alex) Liu <xi.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c    | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 2d5bd5c7ab94..e075b2720f96 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -149,8 +149,8 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 			!pipe->stream->link_enc) && !stream_changed_otg_dig_on) {
 			/* This w/a should not trigger when we have a dig active */
 			if (disable) {
-				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->disable_crtc)
-					pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 6bbbf313b2bb..4b6446ed4ce4 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -149,7 +149,9 @@ static bool optc31_disable_crtc(struct timing_generator *optc)
 
 	return true;
 }
-
+/*
+ * Immediate_Disable_Crtc - this is to temp disable Timing generator without reset ODM.
+ */
 bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -162,10 +164,12 @@ bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 			VTG0_ENABLE, 0);
 
 	/* CRTC disabled, so disable  clock. */
-	REG_WAIT(OTG_CLOCK_CONTROL,
+	if (optc->ctx->dce_environment != DCE_ENV_DIAG)
+		REG_WAIT(OTG_CLOCK_CONTROL,
 			OTG_BUSY, 0,
 			1, 100000);
 
+
 	/* clear the false state */
 	optc1_clear_optc_underflow(optc);
 
-- 
2.43.0

