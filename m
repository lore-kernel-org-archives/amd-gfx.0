Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB5CE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1381310E042;
	Fri, 20 Dec 2024 21:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F8YnSzVs";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A592D10E042
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM1oEawcx0HXXd/hPIIjVytZ0JamD2F4uzrNdQZjsKUEo2QvN2u6eS1EFoq3WJzC5jAratDfOZw8w3BVbXynmmM0e3R4VkCFJBaRIlFe1Ylee8QSTBqtjfULLMbmYx76/Dx6K5GNb6DQzAIBJzdbOa8V4yMKL/PJ6B0ziz7VGwAlcCdyzhQsmeEXOS5WMBFPCz1ZOyi4vwFu6gIb/TRe2d3gjJGH0Q7Kyw7G9nLLTuuIYpzuRinpqBnWV7xo1wfIf0Cp1zsXVHgDTRNmYoZU/BR0JAPXRRQJPNYBlfWAhnah33FkBqu6SXYekBxe6lmEd6IwzW7BmzR+rtGooDDOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNHNepo0so4ibqBTEdly3euK695OYh7VaGfepQ/h0aY=;
 b=rCAtt8gzwJZZSAMrOs+2p6IfGlVciaa2N44dtCUEFbQJeXO3e2zJrOqqMdAMj8WbATEAkcwBM5rpfBcCgfesS6SBls+BKSpyar6XAha4g3lOMGi1NQRb89nOG2B6zpBrpQ6jGAiE1xDG2TSA9XfwgVZD0se9THL+m+ntPtkZsN+/j8ujLryq/uBxN6qrYhtIVXkfr5ZJu7z2oy7XItfJYn1yrAiCmjHLgd/lTDzBD0gIKgmnIiufYX1/A17NNmZN30vDDFxoXq5XvRSi1JgVV86M+u1hWI9CqLZwfTck1/zB9ZlwGfHaAbNREziLoFvKJIxp+GD6uf2gYCmqj0VoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNHNepo0so4ibqBTEdly3euK695OYh7VaGfepQ/h0aY=;
 b=F8YnSzVsDdeLLXcHLaNrcXgVEebwjC/V1v82ME+fwatVqoE8746lnYLt1WWE/IBo4fN80qKcVctAKZzvJbK+xzc3jGtst8GN/dgmwUwBVORqu3nP/pkkXe/L7QhLQEJgfGUlH/MTjNj8DxRBN23NE9MOt75OHtgzXEoGJCwhofs=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 21:50:48 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::bf) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 21:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:47 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:46 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 01/28] drm/amd/display: update sequential pg logic DCN35
Date: Fri, 20 Dec 2024 16:48:28 -0500
Message-ID: <20241220214855.2608618-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: e314a28f-2d2a-4891-39f2-08dd21405d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otc4AdafAxvGVg+SDRcIwUxFn/K/kQ0PQd3KDQ81SXIHWK+eyYzgMzCBBsmK?=
 =?us-ascii?Q?XTGvyHdX2rG89LYg+Vc+IULJ2UbonAY8UBcWFoEicdSYmJ4BbYR3YReKVIyK?=
 =?us-ascii?Q?CQggVQy/ni3S2nlRN3Zl+egxSpJ9X1OE5vLzcwj3Cmfavu+As806neUCpOcI?=
 =?us-ascii?Q?i1W9oQxd7Yw3lzJW+M8OwItHykLwlBAER6WtEmHXN3NrdOxheibq2P1TaZRL?=
 =?us-ascii?Q?ypQ7BCwcocu27l3arrZ3i5NbFdej9bOYEIavYfbYIajbMdpHcgx4M/k3UGBo?=
 =?us-ascii?Q?LcuJ6PdyU5L8+wFoqQtqYWZr1qEA7ZX7kDINH2sVm5Rtfh8KB01uaI74Dfi7?=
 =?us-ascii?Q?LgjDm/UfK42zjgl/5rE7hLLyAKlXzOyh6jAh5ke9AeOkUAWfue/CeILpyfhH?=
 =?us-ascii?Q?EAupIOrxCfBrtruuS9k5KKJ8Y6ig9X/87IhTypeY8Rh+GFBuxOvFs0lj4o5o?=
 =?us-ascii?Q?eBlBDyBggeK/jw8FaEv/Q+ukkwKS6SQCnOh3KO+yO1DM1aKAHJvWV9CXYlmd?=
 =?us-ascii?Q?Ibl2w7j+PsjjC2WDQ1vn9LCY8eQk8TGJoqxnLxYXGSwV9/Kbt6a/+UcsaNyo?=
 =?us-ascii?Q?nk6+NhltN7Dy2cOF/lNrsrsrM0CPsqUh1OpoUlmOiJ303tnv9vd+MVNJaf9I?=
 =?us-ascii?Q?4Aavn2vmW9EoAFXcfS8vx+Ow1mtQV10HdceNOBSj25K3NP6fvEOqPyyO5eAA?=
 =?us-ascii?Q?xUsuW69qMcuHQYe0tirYZRXGejTJNZi7lyjNXpn4WxDyDOsEFhZH/+56dd/S?=
 =?us-ascii?Q?4qlzFKpFns0QRofamjIBUvfdOOl73OHNpqjNqXXGVD/CDq+T9Qv72Bqr+Gyh?=
 =?us-ascii?Q?6xIx8aVOJjEOfoO+EUelTrZXCg6xLfe95UO53wlGlF1lNHC7ew8RyAvFlQaT?=
 =?us-ascii?Q?T80VO4yKqQjIakfnxsyx3UkHe1yVSSEcfqClDokgyMlLV3D9Sl7HK1vX5AMI?=
 =?us-ascii?Q?x2ZqvqwRkjhLakkome9/4XuVzgXbO6ns9owOaDgSqdjwU2BTJvuAkd6DxRr/?=
 =?us-ascii?Q?DvYotS2ZsBOMOw2QaG9mjOkVJYc3DvTy6gEGf9pSVONSdrwEjeoj+/JAg3JE?=
 =?us-ascii?Q?wEwZungSORlMAyCr3RtfUa3yP5zZHg9JCRke0g7mp+eGLe9k+S1S7XvisCh7?=
 =?us-ascii?Q?gdwCQsftsPoTJ1nvJWM8kx7FO1V+IiVwaYcZMFir7YnAKucGOSikDGQ++y+b?=
 =?us-ascii?Q?ZF3MrzBigqhMNjuSdc1r8Zd2cP8gmbHvxwU737zAja/XvEBP1hoFdLVIdyFN?=
 =?us-ascii?Q?vMQso8TnCTCleQgMqvqi2f+VaJSpaU9kGr3pxSJs7+2sMDeAXVykEFBSWXfL?=
 =?us-ascii?Q?Tap6DpQfS59NA3kYDsUw7D7dCuqdLu1r6RyEw7THQsVYV/NrJzmVjHcJyKpk?=
 =?us-ascii?Q?5flgD5/Q2mOQ/sUaMkfT6fh2Apg9pHlolNg79IlYHpzEPHFTVj9+83P9p3+F?=
 =?us-ascii?Q?vmgVXnjahyfP1stqKXZ271srL4dSJaz3bR+/fCxBYE016SBAFc/V7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:47.9950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e314a28f-2d2a-4891-39f2-08dd21405d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
No check for HUBP/DPP power gating when DSC instance is still running. Avoid HUBP/DPP to
power gate when corresponding DSC block is still running in the power gating calculation.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index d5f76cc69c73..8207fea4f99a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1032,8 +1032,13 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_MPCC][pipe_ctx->plane_res.mpcc_inst] = false;
 
-		if (pipe_ctx->stream_res.dsc)
+		if (pipe_ctx->stream_res.dsc) {
 			update_state->pg_pipe_res_update[PG_DSC][pipe_ctx->stream_res.dsc->inst] = false;
+			if (dc->caps.sequential_ono) {
+				update_state->pg_pipe_res_update[PG_HUBP][pipe_ctx->stream_res.dsc->inst] = false;
+				update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->stream_res.dsc->inst] = false;
+			}
+		}
 
 		if (pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_OPP][pipe_ctx->stream_res.opp->inst] = false;
-- 
2.34.1

