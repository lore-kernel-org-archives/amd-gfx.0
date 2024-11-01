Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFE5E6B27E
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF7110E9CD;
	Fri,  1 Nov 2024 13:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="da61h52c";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741FA10E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAt1sMrtGL74HgFDpkklESpK6A/PbrMHSUbY2NnWG0eza770z/9Fs4TUimjx+vJPPe/uddP4ivAIB80F5RQGX0vUT0xPEsQ2lpecxHCvVHZRx40WVT9caj+sUGVq2ccdxq+6UoCb6jYoflQ5Fo/jGqOSC56LpGXtBMh0qv3qYDkRvvQLeef/WqU4tAhhV+cOoAoiqme3pWNoQQm6YIQwf+wtkGAqhIG+P2DEZw/PjylBEO8C5tuEgHh2k4I0+TkGjzUCn5euFUMBD5IuP8lD8sLSAAhcSiDzDnEyJz0WUU6Uep8yND5Ok0lFqEb9FSJowwuw3cc0iRU1LcBSJw4wKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlAgyIlnusZpAZidwMEY4gkn9SPw4SCLfv7EwUVxX9Q=;
 b=gvz7tudSQYOvd2Xiw0xgYjsSdEVBYPTv/JRJkhpWxd3/8GGD8pgvBaDDmSeXDzAqf45Pq5pvZvVkE8vlkN9RNCok6B8Ylqk2BB+g/QpmTg41Dq9jeG7XjR0WpNCFy3jeMr2S5f0uRHelO1ew1wwTXVnHpQXM4+vBceZlBRBhoflWJSlTH0+zfhkMBWB90j1F92Q+1ut9I8g24HCzFtovD2Lgioq/2RL2bmwBPjRV8nfUx2wr5lhcIq33KWMPzYLq9COdaEkZHien+Pic1cV7f0q3oJkp55DW2+pu2ZeDPQq5AWuMMenNKBuB2KPaxsmZ2CX24EVj/1o9bW7BMwydVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlAgyIlnusZpAZidwMEY4gkn9SPw4SCLfv7EwUVxX9Q=;
 b=da61h52cufCkQica+6XuRsfKfWz2LLLObLrAoppLbQKuNxnV8cvf3L5nMJqUBXbVS2mYfso0lZTzjxtF0eIvzo3aVKRajGFWyJB0wCMUEDi74BwfIhK9jn3Fl3gBwDT9jHjfBPZ6ZTUHbgeTcCBtzVpiutcPnp7DTL45h/2A/0M=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22; Fri, 1 Nov
 2024 13:50:16 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::d9) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:16 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:13 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 09/17] drm/amd/display: Remove hw w/a toggle if on DP2/HPO
Date: Fri, 1 Nov 2024 09:49:32 -0400
Message-ID: <20241101134940.1426653-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: f185f1fc-1df6-40ce-1a4f-08dcfa7c1dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?61Se5R0PFBG9ZlqPlbYp0cOHB08fmlxsXGbV2530Ug1H1VVeTLAqQCSqSq4h?=
 =?us-ascii?Q?3yZxwZU1GzOH2vZtnVaDpLNieaOWd915D4I+nTqPbJiZrDaReJ1nunWniCx3?=
 =?us-ascii?Q?TeZ6oNX/7tAM/iudhAxhC8gyBXyJVCmiLX714aunanaC5rngVJKg9NdxAfXc?=
 =?us-ascii?Q?U7nJht/0lXIXBjBF6i1T5oyxAvFNGr6VOsxaVvdKVFBof442uiGsy1jvIcpd?=
 =?us-ascii?Q?lr1xBS6i187VKtqgqcf20/6bEbDYYxSLvlPOq6rZj7ThhBDvU9L+0Kd25fXN?=
 =?us-ascii?Q?o9dFXnlAlERxSVgMins9OICEEokmjuKYZ0HFDk0kIaRYvWcCSQObgXprZ6Lq?=
 =?us-ascii?Q?HrYs+Z4igdJwhj56yDvgFuLzm2tzH9jx54JtyhDHY0fcjPyLb1FjC0B+VFoi?=
 =?us-ascii?Q?voK8B2Nxhif3Es+6cXmSF7eaXzEp+WHGFqFzCSBsJ4f9jnMYGjef3o0mPia4?=
 =?us-ascii?Q?ktlAl5FUaNIR4eFh8+B/U+oD8EL0ZVnuuLOXdfmAbE1xE/zBrnXgRQE0/q2w?=
 =?us-ascii?Q?V6I1x6Yo/VgDPcAFf4KgIoT2tV/ekNmemmZHylG1Wx37+wKGQRlFs0IFXiTR?=
 =?us-ascii?Q?ZTTF8tr0v+tppEL5zz4qPLPJgvZTLuq87wsV/V9CveYIf3ugE028xrWYcVrb?=
 =?us-ascii?Q?9oepDTz6CBd3oipAOisIfo6hnltXRrv1X4gFqFikhYb60lbJIHbPTPONxSQJ?=
 =?us-ascii?Q?xok+ER10fTQNIMPrb1Yyh0Pedtndy/vFbp/xBEKkLMJNMfB9vv6oJPdCr4S3?=
 =?us-ascii?Q?U+DMcKgncdekdlQhWgVYZFkqn9O9Rb4FiWS/fDOhPboXo/5udza9fT/zkM4Y?=
 =?us-ascii?Q?iGt4uJNOshycXygubAa7NDVWDgvf+QXl23v3fn00YPJBNHKdNe3B0lqrFACt?=
 =?us-ascii?Q?w+vlIxqj6wFNxUHrCWiWDajPG0QG9soSABwPDfRXoET9dqDVbBdOczsfauLw?=
 =?us-ascii?Q?qTc7Jndg6ETTRjwvlG/nK/ComDKcC2jYTXgNcObaojsUet+HM5uX1yc8JPMu?=
 =?us-ascii?Q?Og8zLiCY7xcDsXPGavsOnapYTdbrfpeKGVwl/mnU8whw4wncVPxb5LNVR/H5?=
 =?us-ascii?Q?oYSDXCmru+hIuwnziz1oJQwGEjNgyiHIEY8X2n94VFhiifEMq/ZAkKGwk6me?=
 =?us-ascii?Q?eD8n4gsCdTfZvaVEN+xs5Nvj0kypLpmRiYlP/krBn0cZ+tvC0KjZa9jMxq2K?=
 =?us-ascii?Q?OgGhi9YjD0ItMpNRFMtfAmUNPstdwBtYh4Ycdc3mJ38H3vVMJuEyaYk4Wj1N?=
 =?us-ascii?Q?MrU0bUgQWbY+jv0AFiqr+ul8RP9leZ5gA3OiITo9TLe86j3Cwazp6ooqwUJX?=
 =?us-ascii?Q?zWgFV7pA1rdXcx0VH+k6nqSPgbwZz/YymZEhm0TGnDl/8gqwcypMSVzCchFh?=
 =?us-ascii?Q?T2z+RrFRtk0VyKEnsyjfqcSdZhkwleEufcw16y7TODIk27rhDA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:16.1488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f185f1fc-1df6-40ce-1a4f-08dcfa7c1dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
Applying a hw w/a only relevant to DIG FIFO causing corruption
using HPO, do not apply the w/a if on DP2/HPO

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 1d4fe0de0f67..07b49b4030f9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -133,6 +133,8 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+		struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+		struct dccg *dccg = clk_mgr_internal->dccg;
 		struct pipe_ctx *pipe = safe_to_lower
 			? &context->res_ctx.pipe_ctx[i]
 			: &dc->current_state->res_ctx.pipe_ctx[i];
@@ -149,8 +151,13 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		new_pipe->stream_res.stream_enc &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
-			!pipe->stream->link_enc) && !stream_changed_otg_dig_on) {
+		bool has_active_hpo = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(old_pipe) && dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(new_pipe);
+
+		if (!has_active_hpo && !dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe) &&
+					(pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
+					!pipe->stream->link_enc) && !stream_changed_otg_dig_on)) {
+
+
 			/* This w/a should not trigger when we have a dig active */
 			if (disable) {
 				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
-- 
2.34.1

