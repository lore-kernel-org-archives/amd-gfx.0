Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5EFC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50DA10E402;
	Wed, 17 May 2023 11:40:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E9F10E401
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFlAc07n1737Jk4Ns7uFk+c9N6bQ6I0mPnyQXXrZOXZDc0cYQcr5mlmG+Y/cXlqVWcByQJFJTe/IOPCJcTYNwwDuOfTpRaOPkZOKGXKabwmz1uBmLZ4YFaaoF5+e6+BnDINNXj6ge1yTt+EVBXNqsWDdZRWExQfAlf8qTkGn4GmweczTkvRsVm/IsHfAI0sbfxbW4lqKqrqx5gNICr6PuHL2mutiz38f1OgbBn5tugjbpStOpDAjv8dWTThBG6HwMMpUyaLIPsZmxx9oi165jWAJBjVR2Nu6fNasbde7FJi/Ar9JGk1mbEmZUEuYTeXi6JdskyzaDVzuX2HqaN0SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icm6uGUtC01AJUHzMBdkWgQ77hXdvab22o1GpwBy4AQ=;
 b=a3zXeXPaGinXjmGNsDdbGk1v/qDhIhOPiTY9YEvmJdfCmGT7DggXTcIapuRC9pVPOHQBu4M1yzOHKDn854EkP1T14BaBv/VK79kIXLl34NvXQUX4gOwdaN7tCyAcw17ckT+2DY/Bn53BWWfCnmhpBeTnp2vzcG6EQBR1H9R566CO7Az1DfUFARJRgEzwoR0zA8W8c5Tm8YPDCqxamy9hEd9dL1jMtPv4stg9dLTmlFfxlrCDB40K8JydW+tOP7f+kh3GZAMXuozmCeAYEV3bFILYswRcX1ZtM8i2U09x1Vlmha19R2MtRLf2AtRyJxfnPIAh75KQrZDwfHAkUEfMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icm6uGUtC01AJUHzMBdkWgQ77hXdvab22o1GpwBy4AQ=;
 b=TEIpB8wdfR3URFHhW4IqOaHRC74BEQifGyp9K+ZoY4PYGmqdzNtSg/nLN0dYFUSdWLuL8TdbUTcEl+nbinzZ6JQWrFKmIeisn38Ae5GoKkUeCGTuXIsYQJ//kpnNrVzWEWSECMg2Vl02tHEnOgDafGBC4AbzANw/nlP4mLwFKO4=
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:40:25 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::8) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:40:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:20 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:40:15 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/18] drm/amd/display: Trigger DIO FIFO resync on commit
 streams for DCN32
Date: Wed, 17 May 2023 19:37:20 +0800
Message-ID: <20230517113723.1757259-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|BN9PR12MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: af97146a-f9dd-4b43-4339-08db56cb8196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4haG6H8F4pBUJ0dibSbGi0TGcG9kTTp98wuMgEUp5iCh/uuqnUxIzibB+KSPynTa6nnCMjINjq2uMlDvn1pvhArsFOkJPw41rlSKgxc1fZy6hhcblFbTd60gBHdkGvEQn3e8uvsu+MOhiG2ejcpLEboqeOR20aRV42PQJZDHUBGiCnRdKHrLFrM6HenS7dJIGuIbG8PcvUmN/fO1cmH5Hrvb4i0aneHUK1976fCsa0KhvdmXr4Gi18lqdjmx7BM8JZ4Y/jrlOtifpKyLgX4ry+aPIavsf7zhZodYHmtH74A3JRzYEQ+9gi86LttrZ/p4ra/GRLyBViimvxpVKpctv36huCwvcL80xklZCyrd5GMOtA4Hsexuy4i2cpi1qlp38krROiHXDUqypIhdKPlP7Y3eJZP8Iz5Pbq5ei/z0xHsOt46/CfCqWxedMNC7jt+F37aMVoeXdX56uKzdUA8pqPdU8TqcW+/9AVbdiy8N0DVV9zTldyBGu/y14D7lanU/Rz/cQfV2pg9ySJXyduB0Yb0lpJgk25B01kJTLrQpti3uVsL8DxK047YUlrPpzVgseImpa9AMdMAGY88n1dawZnESyNyp8m7MDbbBJifNP/MWPRsW9mGqKi59IKA8rSRIM6K/N6CeN2pINeGa0y54h7j6Yy1ZAOQSODM0zwiAFtAI1p8gKCYmP33/rKaVBaPeHdadFpA4XB58F5fOkp7GhhrX6rgQXl2zdDawJf7WUnWj75K2jwP5EtesJ8aQKrJoFyGH5wliI3n9yxa4y5ea7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(7696005)(6916009)(4326008)(70586007)(70206006)(478600001)(54906003)(316002)(36756003)(83380400001)(47076005)(1076003)(26005)(186003)(2616005)(336012)(36860700001)(426003)(41300700001)(8936002)(8676002)(5660300002)(2906002)(6666004)(82310400005)(40480700001)(81166007)(82740400003)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:40:25.4734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af97146a-f9dd-4b43-4339-08db56cb8196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Saaem Rizvi <syedsaaem.rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <syedsaaem.rizvi@amd.com>

[WHY and HOW]
Currently, on DCN32 we have an old workaround to resolve a DIO FIFO
speed issue when writing to the OTG DIVIDER register. However, this
workaround is not safe as we should be applying the DIO FIFO rampup
logic when the OTG re disabled along with the encoders. This new
workaround accounts for this. If the workaround sequence is incorrect,
like it is was, there is a chance we might hang.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 21 ++++-----------
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h |  5 ++--
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 27 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 5 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index ffbb739d85b6..11e28e056cf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -42,18 +42,14 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
-/* This function is a workaround for writing to OTG_PIXEL_RATE_DIV
- * without the probability of causing a DIG FIFO error.
- */
-static void dccg32_wait_for_dentist_change_done(
+static void dccg32_trigger_dio_fifo_resync(
 	struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t dispclk_rdivider_value = 0;
 
-	uint32_t dentist_dispclk_value = REG_READ(DENTIST_DISPCLK_CNTL);
-
-	REG_WRITE(DENTIST_DISPCLK_CNTL, dentist_dispclk_value);
-	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, &dispclk_rdivider_value);
+	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
 }
 
 static void dccg32_get_pixel_rate_div(
@@ -124,29 +120,21 @@ static void dccg32_set_pixel_rate_div(
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG0_PIXEL_RATE_DIVK1, k1,
 				OTG0_PIXEL_RATE_DIVK2, k2);
-
-		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	case 1:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG1_PIXEL_RATE_DIVK1, k1,
 				OTG1_PIXEL_RATE_DIVK2, k2);
-
-		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	case 2:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG2_PIXEL_RATE_DIVK1, k1,
 				OTG2_PIXEL_RATE_DIVK2, k2);
-
-		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	case 3:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG3_PIXEL_RATE_DIVK1, k1,
 				OTG3_PIXEL_RATE_DIVK2, k2);
-
-		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -352,6 +340,7 @@ static const struct dccg_funcs dccg32_funcs = {
 	.otg_add_pixel = dccg32_otg_add_pixel,
 	.otg_drop_pixel = dccg32_otg_drop_pixel,
 	.set_pixel_rate_div = dccg32_set_pixel_rate_div,
+	.trigger_dio_fifo_resync = dccg32_trigger_dio_fifo_resync,
 };
 
 struct dccg *dccg32_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
index 8071ab98d708..cf5508718122 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
@@ -112,8 +112,9 @@
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_EN, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
-	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
-
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh)
 
 struct dccg *dccg32_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 2de910e0ce75..ed651619b818 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1175,6 +1175,33 @@ void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 				pix_per_cycle);
 }
 
+void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
+{
+	uint8_t i;
+	struct pipe_ctx *pipe = NULL;
+	bool otg_disabled[MAX_PIPES] = {false};
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->top_pipe || pipe->prev_odm_pipe)
+			continue;
+
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
+			reset_sync_context_for_pipe(dc, context, i);
+			otg_disabled[i] = true;
+		}
+	}
+
+	hws->ctx->dc->res_pool->dccg->funcs->trigger_dio_fifo_resync(hws->ctx->dc->res_pool->dccg);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (otg_disabled[i])
+			pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+	}
+}
+
 void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 6694c1d14aa3..6dbe929cf599 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -75,6 +75,8 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
+void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
+
 void dcn32_subvp_pipe_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 6f9a165c1eab..8356b31e1d9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -153,6 +153,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
+	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 };
 
-- 
2.25.1

