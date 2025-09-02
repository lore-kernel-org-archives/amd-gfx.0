Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6891CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7C810E547;
	Tue,  2 Sep 2025 00:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1tu/aL5/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED8A10E547
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzUifx8V4P6RLNi7nzjaDZBdM8Y/t0nZTs6Ooyk/ARtFUjgQEFQbe/tNVz8CONXS9YH027eK2KGBgQdkAXAxD2OILZ47vawspfbmvgf9Gb2j0TOeEheCDHsudyggC5UqEm7ePPkTGXzTGO5BFVqjys4xIStJvpyKMDCAE7aQH+T2qhZ3zIV2mFWG7rK2hekwXkMEa8gAHo8kgzt7jg9vAiHwPz2xEgpIGwuyuYrnZ+9eUIMpiiW2oeIOOpOte43EhSPpk3P69/YU3gUDEZvhwiiN9uzfFCxDRiYabNJDGhhZCGLY8FSdXjDDH/Qxz/Cjx7aPJG1vtVtgzDKMdy6ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUwKBiJA3y6BTD1/IFCEPd1GMmwjYUTpU+EVNf+ihM4=;
 b=N6b8vPQRBpkWmIOuAipZ27q1U5jZhSwUJzXXQIqgQV6YOhAAuYHRT/qYjtcqvxWnfPDTzb/RCfsNQhwWX4vdW2zNrDyXPjOt4fUik5PTir9qQ6M/jil92Lk1/gpQGFjMRa6630Ai/Is+pU/0w9zuYXvJ1Dj7YKDmBcJCCJTj8baeQibcsoy0dy024yrfSW0JTkMOsYcIjQ1obWE/JjbRWvkFWtOlOzbI2902m+KLmiVeUr3fEzEVmVwfT6t/zcLZQFEWEBPIDAa0fOpPcfDDyyYrAJC3jVHZlrH1+5xp8KbMP1MRmztkaOU/zhZKaV2aKDJ5tjXNVSJ1L64T5akvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUwKBiJA3y6BTD1/IFCEPd1GMmwjYUTpU+EVNf+ihM4=;
 b=1tu/aL5/0mH4iTZ9C5jcYrkBSzjvZic1X9jnUroVB0nChvoxk9KmbGkY/tN4CAjwT8yG/st5eoHUyNiN3Kj7hrJzAC4xByCxnTeuITlVnSQyg1lE5wdldiyiW2KNve1wPzOxqglNhvH9ExuvapTzkPXxJt6srtN1DmRrIWfOO4A=
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 00:46:11 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::27) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 00:46:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:03 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 02/11] drm/amd/display: Add link index in AUX and dpms
Date: Tue, 2 Sep 2025 08:42:47 +0800
Message-ID: <20250902004532.1833436-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 0773a768-1c38-46ed-e7f6-08dde9ba1c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WrGD29SltTQYNcx5qHXjSgN5aNJU22S0L/7eoC7SwWWopCw7qmc8qDd25/2d?=
 =?us-ascii?Q?UCIaSanOXCql/yrsgOmw2V+duBcmt8pVwuViiRHyYNLi7NMPoe7ksqFXp2Lr?=
 =?us-ascii?Q?i/EB64j1C1ES4kqnIHgBDX5iA9mQU8gOBLTQ8/K2YroFaFlPomdDYwLZpORx?=
 =?us-ascii?Q?SNukOzFdt7s2T2zPMHXfc/T9wUFTyhYuLSMOoZ3W4pWuExIrRLeRwc/XRAvK?=
 =?us-ascii?Q?3Mn7hbM6HiCfUx0K7yXVEYua07uA9xJt6dz4r5tLIcGdiRg6EfUJ9dNgSXeu?=
 =?us-ascii?Q?0Sc8QTf4jqRCnJbk//uNHSSsCDxVIg05gADglLnNxiDRRd95YXzX3jFE+FTI?=
 =?us-ascii?Q?VA/t7BZTtD5bNqIDxdVEq1hPWoaLYjHZ4wL94wvTySaxV0oMlup+pa+YlCvA?=
 =?us-ascii?Q?BsFkbaxqb6MbNkqesovz7OpIr8f/rTH4Co4zjBE5XoUpwjydanF/lHCXrUHk?=
 =?us-ascii?Q?9NKy64F4ybzxgN9zn+hy2ZITlNUVHHSRbnYg4driYr5uebvFnqiF0TpCaX4Y?=
 =?us-ascii?Q?CzO9+jJhMCLXm0R4ogW8sAnHQWGbGoiFRNTkSqepd+pKCaay2S4qPpqOStEq?=
 =?us-ascii?Q?xtRPM3eBtoPIkD4AEAwh0KiauzDOWJoGZBSZti6jWBDt3QCYi5X/2L/2cS0C?=
 =?us-ascii?Q?LKPPp2r89jkU2y41TO5ClL61bScMuRfYLTgI/MLpXApJgl/3OFGyuFUyvGMu?=
 =?us-ascii?Q?WmvNhYIdQ36uHg4w+VwgdZbjB7nMWukSu/H4rX4W3Qq6lN0I9x50PFHWewVn?=
 =?us-ascii?Q?B/PHx75XvuSRIhiuVJ1pxDbziU49FzHe6K9OlgQo+t2LhHg3fnb4J23gSwvb?=
 =?us-ascii?Q?YDpJySVHhdzkc51ZjtaypBCJADMrLQJcp9NFlQ3+vXOshi+2dkWYZnVsDsMz?=
 =?us-ascii?Q?4wg1G+01p745kFqy7hZQMqGwhxA7L6Y+Afljg9iNrCzFMM10HXCUIu8aslj2?=
 =?us-ascii?Q?Ka+GeD4iUMpxR2qY/Rif0pwNCEUmVxFGj6AvjNhziKGQisU3jZpgcGb6Lq8t?=
 =?us-ascii?Q?f5AWy7sK8tnzy6vw5OmEK2qMalxkH9wEi/uQGMkDWdjjLB/vC0f1wLzNc9TH?=
 =?us-ascii?Q?dzzSTKs45AVBeP5kqRp9nd8TN8SpKqXSbbmQK81OHbnYx7WDgYGI4Xp4iOOt?=
 =?us-ascii?Q?TugjvXPoMLWTFL9JjAQD5rkHgBRpVZ4Lwz8f3WhlswDD9GjWHreLwRc5WXbO?=
 =?us-ascii?Q?LqIIhFeu/9mAIIazYKAaUCDRZ+aT4DjsCV5rxiYh32eAGrnWi5da6k6+USTp?=
 =?us-ascii?Q?pNBEC1XUB25maeesHqfJEyG9El8Ex91txrn3YgA1/4FgSoBsn/Mx55KH9Qs1?=
 =?us-ascii?Q?cjpON8mcBLv8dCmvK+981ilwMk4yx06FVz4q+yDPQJGrc1rBKRkc8MShKyXL?=
 =?us-ascii?Q?8K5a5nxtU4xW2EwBPLSn9m9cRuWco4oMHnUtqp5aCXkLJ9o196SVN2MTdybv?=
 =?us-ascii?Q?OGKXyuupypQWHWtOytOzk/hbdKZ2945f9Cg8vntaY0dU2P8bNUSobZnnxSUO?=
 =?us-ascii?Q?bRU+a16flKE3Vz0N9iDuQfiGoR+REYiAb9yTvt289KUhLjt0Hu41dseLZQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:10.7253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0773a768-1c38-46ed-e7f6-08dde9ba1c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why & How]
Add the link index in DP AUX transfer and DPMS functions.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c    | 17 +++++++++++++----
 .../drm/amd/display/dc/link/link_detection.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c |  9 +++++----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index bb4ac5042c80..673bb87d2c17 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -725,14 +725,18 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 	for (i = 0; i < AUX_MAX_RETRIES; i++) {
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 					LOG_FLAG_I2cAux_DceAux,
-					"dce_aux_transfer_with_retries: link_index=%u: START: retry %d of %d: address=0x%04x length=%u write=%d mot=%d",
+					"dce_aux_transfer_with_retries: link_index=%u: START: retry %d of %d: "
+					"address=0x%04x length=%u write=%d mot=%d is_i2c=%d is_dpia=%d ddc_hw_inst=%d",
 					ddc && ddc->link ? ddc->link->link_index : UINT_MAX,
 					i + 1,
 					(int)AUX_MAX_RETRIES,
 					payload->address,
 					payload->length,
 					(unsigned int) payload->write,
-					(unsigned int) payload->mot);
+					(unsigned int) payload->mot,
+					payload->i2c_over_aux,
+					(ddc->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) ? true : false,
+					ddc->link->ddc_hw_inst);
 		if (payload->write)
 			dce_aux_log_payload("  write", payload->data, payload->length, 16);
 
@@ -746,7 +750,9 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 					LOG_FLAG_I2cAux_DceAux,
-					"dce_aux_transfer_with_retries: link_index=%u: END: retry %d of %d: address=0x%04x length=%u write=%d mot=%d: ret=%d operation_result=%d payload->reply=%u",
+					"dce_aux_transfer_with_retries: link_index=%u: END: retry %d of %d: "
+					"address=0x%04x length=%u write=%d mot=%d: ret=%d operation_result=%d "
+					"payload->reply=%u  is_i2c=%d is_dpia=%d ddc_hw_inst=%d",
 					ddc && ddc->link ? ddc->link->link_index : UINT_MAX,
 					i + 1,
 					(int)AUX_MAX_RETRIES,
@@ -756,7 +762,10 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 					(unsigned int) payload->mot,
 					ret,
 					(int)operation_result,
-					(unsigned int) *payload->reply);
+					(unsigned int) *payload->reply,
+					payload->i2c_over_aux,
+					(ddc->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) ? true : false,
+					ddc->link->ddc_hw_inst);
 		if (!payload->write)
 			dce_aux_log_payload("  read", payload->data, ret > 0 ? ret : 0, 16);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 827b630daf49..b717e430051a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -656,7 +656,7 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 		return true;
 
 	is_in_alt_mode = link->link_enc->funcs->is_in_alt_mode(link->link_enc);
-	DC_LOG_DC("DP Alt mode state on HPD: %d\n", is_in_alt_mode);
+	DC_LOG_DC("DP Alt mode state on HPD: %d  Link=%d\n", is_in_alt_mode, link->link_index);
 
 	if (is_in_alt_mode)
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index cb80b4599936..08ee8d2f777b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2358,9 +2358,9 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream->sink) {
 		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
-			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x\n", __func__,
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d\n", __func__,
 			pipe_ctx->stream->sink->edid_caps.display_name,
-			pipe_ctx->stream->signal);
+			pipe_ctx->stream->signal, link->link_index);
 		}
 	}
 
@@ -2473,9 +2473,10 @@ void link_set_dpms_on(
 	if (pipe_ctx->stream->sink) {
 		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
-			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x\n", __func__,
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d\n", __func__,
 			pipe_ctx->stream->sink->edid_caps.display_name,
-			pipe_ctx->stream->signal);
+			pipe_ctx->stream->signal,
+			link->link_index);
 		}
 	}
 
-- 
2.43.0

