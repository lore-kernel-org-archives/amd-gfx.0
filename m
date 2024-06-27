Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4A1C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2E110EB46;
	Thu, 27 Jun 2024 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqUZ7SFT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5788D10EB53
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeEEbtKZYwOrX0d5NxXFm//NNdnksixsSIPE8WBd+t5yeWUVnpTuxcdK2ClCCpbShmuRzg8+rZ+LolYjYpO6sPV8NjupNKphIA3EbUbIAhF89Y1TpOXskA1no4086T1sJPDAK7jZnEsOVRxFm9IbinarJ/nvwv4RuigYjeUDoUP/VLV5Hi/3f6mSu6S8lQ2GCwR146O02EnZULzWp6cSXIXUzBZRdRLRK1sTrt+uH4AMwS5LSWTrmuG2MJPTx6X0SDAJTFi1XjCtpPFPs/XvhKuTkRypcCTbnjNNRwN7RoPNWBsELm8GQp3TshYt2pPeb9nrlU2/AllUu55S1oZuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTHBex+9M/BUEu2QKDH43jskXQbc0lL4T4b9Cztge+Y=;
 b=ZQp6QPxf821PdrHepXmz9mbIxPRk/44OIvNPb091ZuPFnItPtdjNKegyr9cGol/SvRMCUBrRHZ6kNv0vJb5DnQT1h/uG+UKdOC15iTkmgzaSbnWhWOovp7dX8AIgkfoq7jnS8HDv8Jn+IC3LIG/b6irkeKG83VTEvLkVW4N0lzYA7uaJ8c9Btn8NCKDstNZGnCrNDV1qKmIlZYKgeFaOwG+bRkYe8mtpXzgMzX0fzKGjf8riiZBtgcbSuwWojE2vKi5dAWTATh+g5I1UXF8lffuhKfLyflHE5O9WuwSeFVst982Epl6PFPvGE6EvkInAE0BvPPC1PuTr0MAesJfO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTHBex+9M/BUEu2QKDH43jskXQbc0lL4T4b9Cztge+Y=;
 b=VqUZ7SFTfwWHUWwXlHWkVnYZ3erMOUj2oyzwABT2UuBkJhpHPo1QfyS375/HeXNm3VpKfJcssG4fIqVc8ViQpjlGcTyIrC/cRIcMuR4NM3VBm0ViXUK/v9CNe2Mw0G8a4l4M4iroMpS8tKfiRteTz9KwqAsNsN6EmuC0QHzivIU=
Received: from PH3PEPF00004098.namprd05.prod.outlook.com (2603:10b6:518:1::44)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 21:13:58 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH3PEPF00004098.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Thu, 27 Jun 2024 21:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:13:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:55 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:55 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sung Joon Kim <sungjoon.kim@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/26] drm/amd/display: Choose HUBP unbounded request based on
 DML output
Date: Thu, 27 Jun 2024 17:13:08 -0400
Message-ID: <20240627211329.26386-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaee7d5-405f-4848-eb4d-08dc96ee0f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TUZcdsUzTF04eCg5FpPXhrBqP+TzxFxurHZYl9AVdHezW4yPnjRib4wYencP?=
 =?us-ascii?Q?IBF517H8xmb7R6pdXTNaZWxeC5/y6KqZLupX63TncUXJevQTtqlFQnHnQ1iG?=
 =?us-ascii?Q?0IpQOSKWfqt5W3cUqTqrjW0rIOj9W8P10BhOWhjwWugj2c6/T/k2c++YIUkD?=
 =?us-ascii?Q?o6qIhcTO0V3n8VQtDttjhL+mb3yRl/9IQhNOoaUe1CNK2AOuWfOQIjApKk/V?=
 =?us-ascii?Q?yvRGsscx6PEsGUBTaGhxcEUMsr0gHM87VB/RS0HJhuf7cz9054O45yvbF54O?=
 =?us-ascii?Q?snkfRFc2RahDyJQuXOC+EdcCsbTJH2jgA5XAxya29PFE6p865TRQPY1mm+QO?=
 =?us-ascii?Q?dEdsbt3kWgA7l6C1wMdg5gxpvM8F4G6DDGdtl9ll4xDHorzakpJoGx0frpYu?=
 =?us-ascii?Q?LgXyHHez3x9yJbj7ap2BTHtfzEPWUb4h7n2+FL0p1UeZzhAAuqZ0xz6zhRBr?=
 =?us-ascii?Q?tjogNEteRF8HHtlk3+u1hFHH8UQOlK46A1Q5kSUpVY9TRJ2vKJvrLaVGChpc?=
 =?us-ascii?Q?tl+UWK5OBd45dT1hAQr8f9Wo+68gpQ1nvESMDwkwoAQPRv1PdP8ewidt8Sjz?=
 =?us-ascii?Q?s4KvBiC4QoLEmRd4jMqLO2HMle/VoJPKf8dKb+kBHgTMFQv4EvFH1zyBT2Eu?=
 =?us-ascii?Q?VmM2hFjJ5cB5RXbsGRZd9y0q6MkZDp7/xWPUA25FjeLtEa0EYSU7MIwatK+K?=
 =?us-ascii?Q?4IWDDr6/00uG0Y2qAYhOCy5Jzoje6V2+ZJxJWdGbUw3/4+e2glvwsYGY7X2Q?=
 =?us-ascii?Q?uBquVsRrosUV3ixdNIESm3PTcoSiz+5rw67JTmX1FHV5hg9fI1GGm3CSz1cg?=
 =?us-ascii?Q?waQCDjSSedgFS3zAtiBNhwTeW25jFRd4V528h/Ih21iRzMgBq8TMteYzVPmH?=
 =?us-ascii?Q?GfOOZCYo58L0E3Kpm8dZDawg70MImdbDtIgw+BBpxTarcAV3Kw02dBZktRpB?=
 =?us-ascii?Q?2wWYYQjzHsiEnoOjcFSsHkDJqRBx+DAUzVqJMrhe1xXHGwXF/zRMeu8bDqkO?=
 =?us-ascii?Q?gIIRPaPdHRgjybDoDPfemsbVXkmwW7hQxxhDIw0hE9QBVicleOakHZsWZPZU?=
 =?us-ascii?Q?18N9UHP8cR/JKO1Q14mAIlOP6XJ5Tvl+gfIuBoqzByDBRKh1WZUt7CSXCfBG?=
 =?us-ascii?Q?e/wEzjLXpeCA4sXFfQ8rT41VjElpGPHfNyOZ2VRnKeodgd8SlGCTNzI4Vn+I?=
 =?us-ascii?Q?K0YUEtTYORWhOsnb47Dx12tDH8jNlP9jUB70zzYHIEMKOYLtqNPL2gwtxBda?=
 =?us-ascii?Q?nPIVdBX5q8meTZPEAoghSWh2B22dUAV/1RMT+Fx55pSF6YT7a01XNDq1pPGv?=
 =?us-ascii?Q?17DjefyLGhCsXK7KCWCWbm8rt/1m8WQihzwg1vijCd24swXVZ38yR6gSc/zs?=
 =?us-ascii?Q?4AA+ynj4dNDorsEvFit5443+uxq0OZb6Uq3MzDxlk/OANMQVk+6MbLMpL+Yu?=
 =?us-ascii?Q?dArf1LPU20HZu3Il++gT2ozwKqUOZVA7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:13:57.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaee7d5-405f-4848-eb4d-08dc96ee0f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
Previously, we decide on the unbounded request
purely based on pipe_cnt which is a wrong variable
to use to determine how many pipes are in "use".
DML already accounts for number of pipes in use
along with other various factors and is a more reliable
method of determination.

[how]
Use UnboundedRequestEnabledThisState to decide
on unbounbded_req_enabled.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 0f8b3336e26d..d91948d6ff97 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -288,7 +288,6 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 {
 	unsigned int dc_pipe_ctx_index, dml_pipe_idx, plane_id;
 	enum mall_stream_type pipe_mall_type;
-	bool unbounded_req_enabled = false;
 	struct dml2_calculate_rq_and_dlg_params_scratch *s = &in_ctx->v20.scratch.calculate_rq_and_dlg_params_scratch;
 
 	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = (unsigned int)in_ctx->v20.dml_core_ctx.mp.DCFCLKDeepSleep * 1000;
@@ -302,14 +301,6 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
 		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
 
-	unbounded_req_enabled = in_ctx->v20.dml_core_ctx.ms.UnboundedRequestEnabledThisState;
-
-	if (unbounded_req_enabled && pipe_cnt > 1) {
-		// Unbounded requesting should not ever be used when more than 1 pipe is enabled.
-		//ASSERT(false);
-		unbounded_req_enabled = false;
-	}
-
 	context->bw_ctx.bw.dcn.compbuf_size_kb = in_ctx->v20.dml_core_ctx.ip.config_return_buffer_size_in_kbytes;
 
 	for (dc_pipe_ctx_index = 0; dc_pipe_ctx_index < pipe_cnt; dc_pipe_ctx_index++) {
@@ -344,7 +335,8 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].unbounded_req = false;
 		} else {
 			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].det_buffer_size_kb = dml_get_det_buffer_size_kbytes(&context->bw_ctx.dml2->v20.dml_core_ctx, dml_pipe_idx);
-			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].unbounded_req = unbounded_req_enabled;
+			// Unbounded requesting should not ever be used when more than 1 pipe is enabled.
+			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].unbounded_req = in_ctx->v20.dml_core_ctx.ms.UnboundedRequestEnabledThisState;
 		}
 
 		context->bw_ctx.bw.dcn.compbuf_size_kb -= context->res_ctx.pipe_ctx[dc_pipe_ctx_index].det_buffer_size_kb;
-- 
2.34.1

