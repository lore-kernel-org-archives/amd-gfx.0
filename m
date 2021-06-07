Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A8C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0572560FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0572560FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9446E937;
	Mon,  7 Jun 2021 16:48:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817CC6E937
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfsNUuYDXsmCODbzZLCRWEu616EFptZYPyZjV4E+RZNfZWefX/1rG1V5Z0+Mm7Jdsegy6uKXwY4R1uDNlPKeClFsW/GbXPWY/YkKxoaosDYManeZMhc/JUEXE8rPeS1MKV7Q6q5F6WIob2+QX9EOPI8ng9/KkcruUu48WFzO4FizTEydyAyZYepXo6LRf3ruNwNNnW21Nw1s//cUCnfrL4sLFlU5UJDdOabcnLYz7VhsBkWJletbFI8Kq0vszT3Dq6J+qva9mjM4pTSwtaqtVbNCZTMU2mLI9W15E92etFgXYKran5IrFSQW3pAquALVvM5PeN2d6hSJz7J9uWvVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL0Dtl4lS6hwIYv83hKLVpdEMw+5v2pHzQc99gLRDNU=;
 b=i5mZB4ebpnPXvcdnF5lnfda/w/vviRsd6/0qrpHtRcGOhtNlBmTRzamA2nafBtwPRwLVUqYkDK3ZMiW66os/vIef8LC85GZSD0wl7WIlNLU3tZar028wuCjjAvDaDNKMo8g9Liur3w+ZcCIJu+R1NkhZmfW7ZurA0RVkeIIwkYi5QSQkEjSLRX5qtZKhASt5BfugmBZiMUTHM+h9R5mykMRkvE3OjyvKFHm+Er4CYTXg6cWHwcKkdh3078DLnp9BR+y8EJF/1uiFJaM6hqNBU9AmILgieN6f+uObcPOijt7JQJjSflhMhQx7MKo7weBnlM0nXWohkCji0t+hfBZrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL0Dtl4lS6hwIYv83hKLVpdEMw+5v2pHzQc99gLRDNU=;
 b=iMQSzgCa30uEi2dTV+iQZ0rqxiv07kITyJAULG25nuzFpZpCtgAU8HCbM8DUedUPRIR6aUfgHDgwobmBYzXtClZkI09JWekJzTxVW64X01q/JeE7uOjBVae43AXbYQBEgm5HssDBItUhK0RckO1SlAl1ALeCZwPnwr/hcifW2S0=
Received: from BN6PR13CA0048.namprd13.prod.outlook.com (2603:10b6:404:13e::34)
 by DM5PR1201MB0059.namprd12.prod.outlook.com (2603:10b6:4:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 16:48:31 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::87) by BN6PR13CA0048.outlook.office365.com
 (2603:10b6:404:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:30 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:27 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/30] drm/amd/display: Return last used DRR VTOTAL from DC
Date: Tue, 8 Jun 2021 00:46:57 +0800
Message-ID: <20210607164714.311325-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a18c1c3-8bfd-4eba-fe09-08d929d414b0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00593D569E6148266F3D642EFF389@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6cjZ76n1TEdPPTQPGm9KiLM072hBolWTKzYPuxrThxxC5AawR8hnEsG8/0dt2eXjACBXaQ3nXEfuHv4tys4Hj3QZ0Xn/S9eFyRBCWD99yJqjJzV/uOITBXC1wuIsrWkm5RElR9HNti31zcIH97Ikm9MuXesf94In8ZL38I0HKA/4/jajXEw0Onbr+AsSww8oAybxo5bolwNE6XxQWfloQdOQcqv3NeE/AMtqfeNjL/X/CMit/fmrtO6Hgww5gmhoiJrYbcWYmcUmPRbgxhNKHJ+gkliKpgbXCFDjtd3XOHMSvHEiMjJ6thfdi6fTuPNSQEMRtbdwdBjmY3WEqc6xV8GmZe/3qjEjvds1Zb+jO/5ZQ+tHAd4UZrCNnGDzy909EC9kjauMh29hTLuQaCxPnATXLsoxhpOzB+6Hub3p4fib8IP9X3m1yA0CWcpeFqGr0ta4L39dcbJiG/lQKA4uftDZgXNq4KXaLUf6+A/36L0ZjIuYqT/pMf0Ev0wqbd0WG+cOs/mfofHWa+4BI7QH5gkw3fh6iot8+5XHiuEWyvaIYLF3WrgDaCmH5RxHxMgXqQFCCB608/hB08q6wUzqSsvCzwu9D7hvA/hxz3cLtd+XakcV+5GdGnumSuQI1oECFUpvLfNheJvRVHdvU2b0dgEcobdLVJR2IYUyhbIE7SShjDrKIYL1Ir7ZgIBCK0h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(70586007)(70206006)(81166007)(5660300002)(8676002)(7696005)(36756003)(83380400001)(6666004)(1076003)(8936002)(44832011)(86362001)(336012)(356005)(16526019)(82310400003)(26005)(6916009)(47076005)(186003)(4326008)(2906002)(82740400003)(478600001)(316002)(2616005)(36860700001)(426003)(54906003)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:30.6155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a18c1c3-8bfd-4eba-fe09-08d929d414b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
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
Cc: Stylon Wang <stylon.wang@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Jayendran Ramani <Jayendran.Ramani@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jayendran Ramani <Jayendran.Ramani@amd.com>

[How]
Add call to get the last used VTOTAL from DC

Signed-off-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 42 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 ++
 .../dc/dce110/dce110_timing_generator.c       |  1 +
 .../dc/dce120/dce120_timing_generator.c       |  1 +
 .../display/dc/dce80/dce80_timing_generator.c |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 10 ++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |  9 +++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  6 ++-
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 12 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a368e7c5245d..3430f3001ade 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -325,6 +325,48 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	return ret;
 }
 
+/**
+ *****************************************************************************
+ *  Function: dc_stream_get_last_vrr_vtotal
+ *
+ *  @brief
+ *     Looks up the pipe context of dc_stream_state and gets the
+ *     last VTOTAL used by DRR (Dynamic Refresh Rate)
+ *
+ *  @param [in] dc: dc reference
+ *  @param [in] stream: Initial dc stream state
+ *  @param [in] adjust: Updated parameters for vertical_total_min and
+ *  vertical_total_max
+ *****************************************************************************
+ */
+bool dc_stream_get_last_used_drr_vtotal(struct dc *dc,
+		struct dc_stream_state *stream,
+		uint32_t *refresh_rate)
+{
+	bool status = false;
+
+	int i = 0;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream && pipe->stream_res.tg) {
+			/* Only execute if a function pointer has been defined for
+			 * the DC version in question
+			 */
+			if (pipe->stream_res.tg->funcs->get_last_used_drr_vtotal) {
+				pipe->stream_res.tg->funcs->get_last_used_drr_vtotal(pipe->stream_res.tg, refresh_rate);
+
+				status = true;
+
+				break;
+			}
+		}
+	}
+
+	return status;
+}
+
 bool dc_stream_get_crtc_position(struct dc *dc,
 		struct dc_stream_state **streams, int num_streams,
 		unsigned int *v_pos, unsigned int *nom_v_pos)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 0ab1a33dae84..b8ebc1f09538 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -465,6 +465,10 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 				struct dc_stream_state *stream,
 				struct dc_crtc_timing_adjust *adjust);
 
+bool dc_stream_get_last_used_drr_vtotal(struct dc *dc,
+		struct dc_stream_state *stream,
+		uint32_t *refresh_rate);
+
 bool dc_stream_get_crtc_position(struct dc *dc,
 				 struct dc_stream_state **stream,
 				 int num_streams,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index d88a74559edd..27cbb5b42c7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -2231,6 +2231,7 @@ static const struct timing_generator_funcs dce110_tg_funcs = {
 				dce110_timing_generator_enable_advanced_request,
 		.set_drr =
 				dce110_timing_generator_set_drr,
+		.get_last_used_drr_vtotal = NULL,
 		.set_static_screen_control =
 			dce110_timing_generator_set_static_screen_control,
 		.set_test_pattern = dce110_timing_generator_set_test_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index b57c466124e7..4af0c70098c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -1190,6 +1190,7 @@ static const struct timing_generator_funcs dce120_tg_funcs = {
 		.tear_down_global_swap_lock = dce120_timing_generator_tear_down_global_swap_lock,
 		.enable_advanced_request = dce120_timing_generator_enable_advanced_request,
 		.set_drr = dce120_timing_generator_set_drr,
+		.get_last_used_drr_vtotal = NULL,
 		.set_static_screen_control = dce120_timing_generator_set_static_screen_control,
 		.set_test_pattern = dce120_timing_generator_set_test_pattern,
 		.arm_vert_intr = dce120_arm_vert_intr,
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
index 397e7f94e1e8..b8fd43dc010b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
@@ -209,6 +209,7 @@ static const struct timing_generator_funcs dce80_tg_funcs = {
 		.tear_down_global_swap_lock =
 				dce110_timing_generator_tear_down_global_swap_lock,
 		.set_drr = dce110_timing_generator_set_drr,
+		.get_last_used_drr_vtotal = NULL,
 		.set_static_screen_control =
 			dce110_timing_generator_set_static_screen_control,
 		.set_test_pattern = dce110_timing_generator_set_test_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 677663cc7bff..d61acf9598a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1543,6 +1543,7 @@ static const struct timing_generator_funcs dcn10_tg_funcs = {
 		.unlock = optc1_unlock,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
+		.get_last_used_drr_vtotal = NULL,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.set_test_pattern = optc1_set_test_pattern,
 		.program_stereo = optc1_program_stereo,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index cabfe83fd634..7d087d46d7c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -171,6 +171,7 @@ struct dcn_optc_registers {
 	uint32_t OPTC_DATA_FORMAT_CONTROL;
 	uint32_t OPTC_BYTES_PER_PIXEL;
 	uint32_t OPTC_WIDTH_CONTROL;
+	uint32_t OTG_DRR_CONTROL;
 	uint32_t OTG_BLANK_DATA_COLOR;
 	uint32_t OTG_BLANK_DATA_COLOR_EXT;
 	uint32_t OTG_DRR_TRIGGER_WINDOW;
@@ -517,7 +518,8 @@ struct dcn_optc_registers {
 	type OTG_CRC_DSC_MODE;\
 	type OTG_CRC_DATA_STREAM_COMBINE_MODE;\
 	type OTG_CRC_DATA_STREAM_SPLIT_MODE;\
-	type OTG_CRC_DATA_FORMAT;
+	type OTG_CRC_DATA_FORMAT;\
+	type OTG_V_TOTAL_LAST_USED_BY_DRR;
 
 
 struct dcn_optc_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 3139d90017ee..7fa9fc656b0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -520,6 +520,14 @@ bool optc2_configure_crc(struct timing_generator *optc,
 	return optc1_configure_crc(optc, params);
 }
 
+
+void optc2_get_last_used_drr_vtotal(struct timing_generator *optc, uint32_t *refresh_rate)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_GET(OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, refresh_rate);
+}
+
 static struct timing_generator_funcs dcn20_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -553,6 +561,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.lock_doublebuffer_disable = optc2_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
+		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
@@ -591,4 +600,3 @@ void dcn20_timing_generator_init(struct optc *optc1)
 	optc1->min_h_sync_width = 4;//	Minimum HSYNC = 8 pixels asked By HW in the first place for no actual reason. Oculus Rift S will not light up with 8 as it's hsyncWidth is 6. Changing it to 4 to fix that issue.
 	optc1->min_v_sync_width = 1;
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
index 3dee2ec2a1bb..be19a6885fbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
@@ -42,7 +42,8 @@
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SR(DWB_SOURCE_SELECT),\
-	SRI(OTG_MANUAL_FLOW_CONTROL, OTG, inst)
+	SRI(OTG_MANUAL_FLOW_CONTROL, OTG, inst), \
+	SRI(OTG_DRR_CONTROL, OTG, inst)
 
 #define TG_COMMON_MASK_SH_LIST_DCN2_0(mask_sh)\
 	TG_COMMON_MASK_SH_LIST_DCN(mask_sh),\
@@ -75,10 +76,14 @@
 	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_SEGMENT_WIDTH, mask_sh),\
 	SF(DWB_SOURCE_SELECT, OPTC_DWB0_SOURCE_SELECT, mask_sh),\
 	SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh),\
-	SF(OTG0_OTG_MANUAL_FLOW_CONTROL, MANUAL_FLOW_CONTROL, mask_sh)
+	SF(OTG0_OTG_MANUAL_FLOW_CONTROL, MANUAL_FLOW_CONTROL, mask_sh), \
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn20_timing_generator_init(struct optc *optc);
 
+void optc2_get_last_used_drr_vtotal(struct timing_generator *optc,
+		uint32_t *refresh_rate);
+
 bool optc2_enable_crtc(struct timing_generator *optc);
 
 void optc2_set_gsl(struct timing_generator *optc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index ac478bdcfb2a..f37e8254df21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -315,6 +315,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
+		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index 379616831636..736e63bc80c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -87,7 +87,8 @@
 	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
 	SR(GSL_SOURCE_SELECT),\
-	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst)
+	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
+	SRI(OTG_DRR_CONTROL, OTG, inst)
 
 
 #define OPTC_COMMON_REG_LIST_DCN3_0(inst) \
@@ -233,7 +234,8 @@
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL2, MANUAL_FLOW_CONTROL_SEL, mask_sh)
+	SF(OTG0_OTG_GLOBAL_CONTROL2, MANUAL_FLOW_CONTROL_SEL, mask_sh),\
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_0(mask_sh)\
 	OPTC_COMMON_MASK_SH_LIST_DCN3_BASE(mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 9ff68b67780c..59d1a41bfbfe 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -223,6 +223,7 @@ struct timing_generator_funcs {
 	void (*enable_advanced_request)(struct timing_generator *tg,
 					bool enable, const struct dc_crtc_timing *timing);
 	void (*set_drr)(struct timing_generator *tg, const struct drr_params *params);
+	void (*get_last_used_drr_vtotal)(struct timing_generator *optc, uint32_t *refresh_rate);
 	void (*set_static_screen_control)(struct timing_generator *tg,
 						uint32_t event_triggers,
 						uint32_t num_frames);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
