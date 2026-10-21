Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAC606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZLFBnHEY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD6510F942;
	Wed, 21 Oct 2026 06:26:19 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7815E10F942
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3QlM08aFh16huriw3xudILJeC5FL+sKgZUSnZuS5p3fZRDFWo00RZAEjEcTvwkFBAQbW/6pzZg3/1JpcUzBSx+vCj/HqxLocNXXmKSppD7CjbROwAF5vfP2Ojkqh110+RUhRPTKouDj/2fGozHMqMVf0L8XYAn87inbZgWLRNnue6huulKx5zW+SLW/DhpzQFBffoq3Rj/tJ5riSPSv91yLzY0AkcGz8u5FGWMCqqmPXX9niZNoH3o4izNJ5/YmSycEPurZPETN9Xez2mFXqsirtVUm++rwUY8RtFIV2tbJAWSJP/4wIW7uFIDkovAxS7nYg8e9k67dz6h5b3mYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CzSVz+NS+nOaj96U3zHBTWT1hz0GU29S0WJi4PlbK0=;
 b=Ux2jLX8id1Kp5FZzwZIF49Tr3ylSKqY9Mx0cUk4S/bKDoOnmZYx6QrTt05zSQUNH9QtY1UBgUvLYJTm8ciXsl/d9I4ea52sTTmwIGXMitBL+YtmZWtWQz0LEElL6xdhHWmqBJr72DzzHv3Dyj+YX62L0FI2IJgWrAYLS4UmxpNSFvoX5qXjKs5Ho4PNUCpJJCcMTP9krrbww5RDSwRnY0HwNje3aVEP0Wu/xEb9ZJRA0188QjC+a0oHfuO0H8jaIjPynnvYQ1aEc647AelNNZMLsDpYpMnbDzNW6guxd8gca+Aejap+MGfxY3DHrQkbvw7sS/6ezfTXimmScqK9A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CzSVz+NS+nOaj96U3zHBTWT1hz0GU29S0WJi4PlbK0=;
 b=ZLFBnHEYMSS2sGI41ePJS00LO9WazCo+o9mlQyGDKphzOSJcg5LrXeUgT9KgR0WPK8g6JmQ0kr6R1gswsqytcfJSTfGUWw0+jNvc9pDxIkuaw445bKV8gq0Glejm0EzzaiRWJdeXN00ICfY2MO78f2EKUXEPAqDcUYuJIRQ+mbU=
Received: from BY3PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:39b::30)
 by LV1PR12MB365848.namprd12.prod.outlook.com (2603:10b6:408:50d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:08 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::59) by BY3PR05CA0055.outlook.office365.com
 (2603:10b6:a03:39b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:26:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:06 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 12/49] drm/amd/display: Fix QoS bandwidth fields copied from
 DML
Date: Wed, 21 Oct 2026 14:22:18 +0800
Message-ID: <20261021062519.674697-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|LV1PR12MB365848:EE_
X-MS-Office365-Filtering-Correlation-Id: 129c5800-0d11-4744-241a-08df2f3c30fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|30052699003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fD7tNTPowwHReJkkJGixLqLzNblsPclxGajW6hvsdjIV91mgNMsDoRdnTqx7pjZ3uRgu6vVPe7VrWvJZzp/dUAXpb/A93TppNtHG1sbfKV/oFmrk35WmuAZ0HH2EYVJCqjWRC2Qord5DBFy/miFrv+G1sSfdt/diAFvqNqk2QVT/6jEnzclIru8IKdjPydeSTwUPNq5C96y5rI4Nf4rCLIIJ2m9+h3yCXPTEsqS3aV1u3HomEDh0Kq/7xG/s4t+4vMvUmhLE9pwPnAA4OIZm4C0fLW0VKArze1WNp8XnECeHEgp290n6gQZhstTjXsM8wn4uR+9Z4u+A15H5E55C4exmbNFh4lIkwdorFEJSTx/D6bBcq/iH9b0/sGCt2N8j/yVm9YMi32KArVRCW2+jUhT24v96qYMQLD7gLD6zxA0dyjDY2FOnb2cE+v10QpOw07WWFQAY0Yaahw+oha2BuV9hPiRUozhCTIplpwW3gC+2KWvf0fLXAmRnx8r331NcFaof6LhW3kj9tFtilbBt05e2sGmt8oRsi6RfWduaWTrMcybFk156M+7PtSG0KvaBjSVZ3svp0qGVO5iXRnP2RWrU0G2iyLXRhZ0CXcMPD0m8DdrPXY4Yj9LTcL9FoibpOPiRO/b3hXbOV2+XKNfo3MXE+rQngrKZmOo89OXWf7E8QUh3KNySncQKoSfJZTRvByNo7JF8J6tzBTaGmTiqvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(30052699003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X8N28WFPDgA46orTR+IGc4zuWtZfqn3LULxtn7OADGyRSlIIqPSzy7WgcKqMkxxrygTi9RhdGT5Wlp06TbAUZtSwWPLYQgL3KC3i//H+PNEabaf8MW/vJ8OvmoYYHJP13ezDGto4IQLEdLH8093foL7oeqhsIr6lDkCE8LCrq4AkQ4tT9z3GZs7EphhRnnUbI5c+tpC0BP5rfaaNHKsj5TQNL8W2IlKrgLSXnAGGWj4ai/hzOesoi0NcjJNww/U7Hi707r+iyetv7BE/d6CU0Ald6X/T7mLn/ZDmug/xiY5kTydYYCqxM3IPFmLJ1I9u9wIjxgvfi8mTwwmFReIpL1yhFG4A0n60qZHLY0uKXCjQXoC7GapoFJM0QPN/QAH3uRggJ4kGpYsS3HG1pfwPPlNVeGtvgwyRe50Rj1r/3kjwq4/moREHYclgOG4c8KdV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:07.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129c5800-0d11-4744-241a-08df2f3c30fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB365848
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The QoS request message is never sent. The DML translation writes
the bandwidth lower bounds to fields the clock manager does not
read, so the clock manager never sees a change.

[How]
Write the bandwidth lower bounds to the fields the clock manager
consumes, and reset the same fields when initializing min clocks.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dml2_wrapper/dml21_wrapper/dml21_translation_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 366767f4413e..7181fc71e4c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -1027,8 +1027,8 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_dramclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz;
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_fclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz;
 	context->bw_ctx.bw.dcn.clk.utm_latency_ub_index = 0; /* TODO - derive from qos model */
-	context->bw_ctx.bw.dcn.clk.utm_nominal_bandwidth_lb_Kbps = (unsigned int) in_ctx->v21.mode_programming.programming->qos_bound.bandwidth_lb.dcn5.non_urgent_bandwidth_kbps;
-	context->bw_ctx.bw.dcn.clk.utm_urgent_bandwidth_lb_Kbps = (unsigned int) in_ctx->v21.mode_programming.programming->qos_bound.bandwidth_lb.dcn5.urgent_bandwidth_kbps;
+	context->bw_ctx.bw.dcn.clk.utm_nominal_bandwidth_lb_KBps = (unsigned int) in_ctx->v21.mode_programming.programming->qos_bound.bandwidth_lb.dcn5.non_urgent_bandwidth_kbps;
+	context->bw_ctx.bw.dcn.clk.utm_urgent_bandwidth_lb_KBps = (unsigned int) in_ctx->v21.mode_programming.programming->qos_bound.bandwidth_lb.dcn5.urgent_bandwidth_kbps;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.base_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.base_percent_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_efficiency;
@@ -1168,8 +1168,8 @@ void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_s
 	min_clocks->subvp_prefetch_fclk_khz = 0;
 	min_clocks->phyclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.phyclk.clk_values_khz[lowest_dpm_state_index];
 	min_clocks->utm_latency_ub_index = 0; /* TODO - derive from qos model */
-	min_clocks->utm_nominal_bandwidth_lb_Kbps = 0;
-	min_clocks->utm_urgent_bandwidth_lb_Kbps = 0;
+	min_clocks->utm_nominal_bandwidth_lb_KBps = 0;
+	min_clocks->utm_urgent_bandwidth_lb_KBps = 0;
 	min_clocks->stutter_efficiency.base_efficiency = 1;
 	min_clocks->stutter_efficiency.low_power_efficiency = 1;
 	min_clocks->stutter_efficiency.z8_stutter_efficiency = 1;
-- 
2.43.0

