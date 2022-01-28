Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329F6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA7310E715;
	Fri, 28 Jan 2022 14:05:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D87310E715
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXNVKQbm88Z1Z2fVdVfZzcQsuL2BXxTmW6GPbvsmtQjTMMs+kU7erQpkZBZVIk9DmE94Q4XyVv+W1nYHqqhQd0jhveY8uH6Xpuurysy4cIVLgCnFS00rZog0WzWpRNK6JB4lkAbQdnCpCqssLg9tFvaT7wrB/65SJbE5XchdXy+XAgHkYMwTIOmEcRHAOBNmCOAmLv/XEyRxIkV9gFS4DxWsfByY2RsW0qdZPjnmkoSmJt7HvMGGXUMRkDuOJ0t49fP0L0Czt4avXRq9cia6QoYlnvbTG3LnJOLoa0qk5NJcV4tPM9/piG+2orj8uaWOSirRuiEk3zcLJknYVJtaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42YU7MxpA+BB0NF+BaAjL/Zb/VMye52FFy7s++KjC1U=;
 b=UpVwkt4n0EZYPEvFC1GCInsb1pKCLg6pb28eNalVhH+BQGjuqGtl2bb462j+ZLcojKzBP1lvCtyewaNks61oDE0nXuegEsWXorGoFZOOE+srHgiWEHZSjVwch6upNDhSk3y/bNbTm9Cp2eSYCPSxfODFBWE/b/e193ySg5zqT9ImhMhHViSLURgt6hxLp5CdkNDhGZWXBHa2+GlDhNnQAhEbtNDd8rqByuhJ2Q4S0w8+hewpX017bAhsSpoNlxJfAwKWqGfO683LsCmoy7b/6mDPiE2WvD2xsGyqR4+mVGFDqPcdLzuMwRUScGTTYqGJrTYVVsLS+ZOCOZUY4nq9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42YU7MxpA+BB0NF+BaAjL/Zb/VMye52FFy7s++KjC1U=;
 b=iN0Vs7JvzJorQYqgKn+PGnqgbmGDEEyyZz6NdVNyqpzStmcpKI+QUBbjOnL2pDnBB2r7MxFAUwdVXy2g0KLMezhwhw6yV6UWj6913JbNc7NDLCbcFXSTrS2DM95hZ2JJgByWBSnMAOk8KNkWyIVOYWWvnzhJHql4eI5N8rzURT8=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by CH2PR12MB4808.namprd12.prod.outlook.com (2603:10b6:610:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:05:18 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::d5) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:18 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:12 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/17] drm/amd/display: revert "Reset fifo after enable otg"
Date: Fri, 28 Jan 2022 22:03:59 +0800
Message-ID: <20220128140411.3683309-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0260b510-b63d-4e3a-28be-08d9e2673751
X-MS-TrafficTypeDiagnostic: CH2PR12MB4808:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48081B430F5F99E64795C03DFF229@CH2PR12MB4808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrRiLwHezlyN23I/tWzlFH9MN4w62qweZxxvj2nLAtUVl1ZgAOHDBEwcCsUeR/bx6eht5nz5algiTdULjP18D1Ji3S6Iln6BFPZWzob/WQUDdAejiEIcUYMVo4IL+3pDluTUJPtH54uGMJkM0001l2dMODIP/7QgF+zTE9ljeM/gjjWyBiA0/OOWTAww8zCXWwhLZIT2DevmOwrrWeyhS8G6HogIEsWYrGOYohjWYkPuyWe+MGE9JTNJQEzjYmK/lrqrmATvZMAhm1YMlLeZSJCASq/sBQsio1llf0udjUAQzGy3a7BMU+tIAqiAYzGtZNZHfx8vVjCIIWOyM0i8veweQhIHBsoUW3h2sy5im0xgWA4GRNH9DpTCzVzqsaZK90BfdxUygTwpZlRLd9bT2dsD6G2msLVmfUBt+Dwl+bJtQnPy3Xgh2c6NsCLBSAsaURVMWMlYwOc0QJnUUKn4gA7cj57T1OpaVSLTAiakcqlIlmjUYw9mhuIdvkP26J5NTuxqFsuGvhaSOqY8AHR6e2fm1OY1Boye8fYghrLSF28LmbYAB8BTpLNUXpnpM3aafaniOz7480zSrg2WA4UsjT2TOCzIc+ytxG/Jreo28Qz/S0Z3fwQ3NoDN9ZUufXSx0deKHjIG1U36NasZT575JMb2DYeg/9/EZpfi1sQLKNhjPUfKQDEEbkz7SA6mIcTN4gXAQ4vlQIgSz3yeyO7axQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(70206006)(70586007)(2906002)(86362001)(8676002)(2616005)(4326008)(356005)(40460700003)(81166007)(426003)(54906003)(1076003)(8936002)(16526019)(186003)(26005)(508600001)(6916009)(336012)(6666004)(7696005)(316002)(36860700001)(83380400001)(44832011)(47076005)(36756003)(5660300002)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:18.6116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0260b510-b63d-4e3a-28be-08d9e2673751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4808
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Zhan Liu <Zhan.Liu@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <Zhan.Liu@amd.com>

[Why]
This change causes regression, that prevents some systems
from lighting up internal displays.

[How]
Revert this patch until a new solution is ready.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 .../amd/display/dc/dce110/dce110_hw_sequencer.c   |  5 -----
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c   | 15 ---------------
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h   |  3 ---
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c   |  2 --
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c   |  2 --
 .../drm/amd/display/dc/inc/hw/stream_encoder.h    |  4 ----
 6 files changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 72dd41e7a7d6..f28d6c15a4e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1567,11 +1567,6 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
 
-	if (dc_is_embedded_signal(pipe_ctx->stream->signal) &&
-		pipe_ctx->stream_res.stream_enc->funcs->reset_fifo)
-		pipe_ctx->stream_res.stream_enc->funcs->reset_fifo(
-			pipe_ctx->stream_res.stream_enc);
-
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index bf4436d7aaab..b0c08ee6bc2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -902,19 +902,6 @@ void enc1_stream_encoder_stop_dp_info_packets(
 
 }
 
-void enc1_stream_encoder_reset_fifo(
-	struct stream_encoder *enc)
-{
-	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-
-	/* set DIG_START to 0x1 to reset FIFO */
-	REG_UPDATE(DIG_FE_CNTL, DIG_START, 1);
-	udelay(100);
-
-	/* write 0 to take the FIFO out of reset */
-	REG_UPDATE(DIG_FE_CNTL, DIG_START, 0);
-}
-
 void enc1_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc)
@@ -1600,8 +1587,6 @@ static const struct stream_encoder_funcs dcn10_str_enc_funcs = {
 		enc1_stream_encoder_send_immediate_sdp_message,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
-	.reset_fifo =
-		enc1_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index a146a41f68e9..687d7e4bf7ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -626,9 +626,6 @@ void enc1_stream_encoder_send_immediate_sdp_message(
 void enc1_stream_encoder_stop_dp_info_packets(
 	struct stream_encoder *enc);
 
-void enc1_stream_encoder_reset_fifo(
-	struct stream_encoder *enc);
-
 void enc1_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index 8a70f92795c2..aab25ca8343a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -593,8 +593,6 @@ static const struct stream_encoder_funcs dcn20_str_enc_funcs = {
 		enc1_stream_encoder_send_immediate_sdp_message,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
-	.reset_fifo =
-		enc1_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 8daa12730bc1..a04ca4a98392 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -789,8 +789,6 @@ static const struct stream_encoder_funcs dcn30_str_enc_funcs = {
 		enc3_stream_encoder_update_dp_info_packets,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
-	.reset_fifo =
-		enc1_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 36ec56524afd..678c2065e5e8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -164,10 +164,6 @@ struct stream_encoder_funcs {
 	void (*stop_dp_info_packets)(
 		struct stream_encoder *enc);
 
-	void (*reset_fifo)(
-		struct stream_encoder *enc
-	);
-
 	void (*dp_blank)(
 		struct dc_link *link,
 		struct stream_encoder *enc);
-- 
2.34.1

