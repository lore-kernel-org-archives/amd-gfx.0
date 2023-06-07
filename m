Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD6AC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1AC10E4E1;
	Wed,  7 Jun 2023 12:17:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF6D10E4DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft18lirqAq1KqFA0WQDUsaMQH6TLdT/xpKQdtEiKn+yFhTVoHwWUG1hi2yUJg2Qa1mNJeQNNxKviAmD1szB2kPBA+wHPYeCcAshYu5QSOFHDZjAZHWra48cdCwJWPEy4ImshmYZOpn2a2oMThcc9vzP49HTcn6IAHyD64i/CbRDzw5dIlk4dNY6gYqvdAsDhB/ROv5YRjytmSTCrepNDsGMJReaRchRjDyUyS4JdHDlTxJvkjCxcas0ZtbBT42W8Z6/zL0XmLXeX1wEuWh0K+slmLyBORKrGquqG45U1W0uqUzSkh2xSW1hqySMAr6YMaHRuwCSI9MUqvqZKgOJU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RswkBCMzo/5gBR5Ge9RtWWhfb1Z3FLuN4bVM3fDZT78=;
 b=bAnWhgCPG7wM5eBgZzLYZbN7QxMzzij78NQk47s4OG63dgmC6NmRpXaghXLKt9TnBaxetCEdOaDFDLcZn4pCT+coSKn8Shx80VMgD3JCjQa2ooCXkLxSd+yTfWjfc6nbfPH1PWDNlGbfsuk2IJHBa3+sm5bXuH9Kmo1ob7ArBikCQLNWhuiq3vbBHv3AnJAIKkjZuu4QSheY9qgfYQZYxAy7kELinN0nYDF8Y2+zumN2FOTAXuXuv3xbpscAH974SLZOLP4TCRKAwvMgKJX3Ju3K+g1zi05R4IyOeyA5fG3bCILd2XwU6NlvpmRH5Npvq8Mj+hTrPR1omJyIfrtrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RswkBCMzo/5gBR5Ge9RtWWhfb1Z3FLuN4bVM3fDZT78=;
 b=wTJgNdT/uqTK3XLrQ8LIzHhKGoY8XlZtBdSoz98KDnVcOarsd9kYKhYbAl8IIOrfa7djnmrn9gZ04057z45XKXq0+Ultf7zbK7vlgCVWo9jdaSgcgfvMrPFcR++RrCKqVE9ZKqnbKXpc5Dr1TTzEJvWV0K3uUYuW/flBkwKHSVg=
Received: from CY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:930::9) by
 DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 12:17:27 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::39) by CY5PR13CA0023.outlook.office365.com
 (2603:10b6:930::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:27 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:23 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/20] drm/amd/display: fix pixel rate update sequence
Date: Wed, 7 Jun 2023 20:15:47 +0800
Message-ID: <20230607121548.1479290-20-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d2fa2d-fe2b-4593-5cf8-08db675128a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bXm0pVE59y03I2w0Ih9Q4TZZ/K6Ln0xyPLFByWcydKRQ+NHIr0xjfPD/FbJWyl0zsvrSQ+QTA5Z2DigCgKSXti/ec/GH1VvzIdXWIGlrUF8A5c1n8bTapJazD56WvTTEzgvNrmqCO90CgXaiXzL2RKAZUfelWIN/xvV77o6ZnOsjdFzkpllsaMKilCBDaUifxjGJjYIJckq7drV/WLorJTdZl0CeHNAky41PEjAKyqhj8WNDn5wACXUvypahCc93g6Ij7u5tedJBuZ+MrKpmCbH4LHPrZvDy232QzvF0eZXOdaDB/gCNFElZAy0gouY1F7bNbt9ja22RBZ7zUuXhNkOySfTMhkLeGqFLIjVaZiaXKhTe29yducKM2h22AY2hTgeUPOcK/RslxkBWnN2yB87K7jPMTcF0BVdE+HhzYA2xSnnJPK65nzkgmiC3lnfbcijUf62zm+VtEsMjoVITs1j1KQ0YtcIsmOun6l9eXUYcLaZGnK08lMiOKafs+uyu5nWdkbuP2sKv+iMeR9DCX1RLvdEh02GrtobzniW+BxS1Ufeha30bIAy4IKVuo218v1sKR4IHs8AJ3cP/nZXx3/pGtHDQFHm+QCLCe0esahpKVQ+YwfrkwGN90tW9L72uWDtJ8BRk5zKbhF0C8ljcY+MIbr+iCpDV5LdvJCRCdat2TY0IC9JEGUW0y3WkbIZMd2QLIoqzYJRRxzTDcsewVs5reu8XzKATkiNNLhNh4kypxibmx52VhbbWVWxxVYGilbn8QlBk2E4NuqaoWvClg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(82740400003)(2906002)(356005)(81166007)(70586007)(70206006)(54906003)(36756003)(5660300002)(8936002)(86362001)(8676002)(44832011)(41300700001)(15650500001)(6916009)(4326008)(40480700001)(316002)(478600001)(40460700003)(426003)(336012)(2616005)(26005)(1076003)(16526019)(186003)(36860700001)(66899021)(82310400005)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:27.3860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d2fa2d-fe2b-4593-5cf8-08db675128a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

The k1/k2 pixel rate dividers in dccg should only be updated on stream enable
and do not actually depend on whether odm combine is active.

This removes an on flip update of these and fixes the calculate function
to ignore odm status for dp steams.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 -----------
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  9 ++-------
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  8 ++------
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer_private.h |  2 +-
 6 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 20f668d28364..eaf9e9ccad2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1741,17 +1741,6 @@ static void dcn20_program_pipe(
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
-
-		if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
-			unsigned int k1_div, k2_div;
-
-			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
-
-			dc->res_pool->dccg->funcs->set_pixel_rate_div(
-				dc->res_pool->dccg,
-				pipe_ctx->stream_res.tg->inst,
-				k1_div, k2_div);
-		}
 	}
 
 	if (pipe_ctx->update_flags.bits.odm)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 4d2820ffe468..32a1c3105089 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -337,14 +337,13 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
 
-unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
+void dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
-	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
+	get_odm_config(pipe_ctx, NULL);
 
 	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
@@ -362,15 +361,11 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-			if (odm_combine_factor == 2)
-				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
 
 	if ((*k1_div == PIXEL_RATE_DIV_NA) && (*k2_div == PIXEL_RATE_DIV_NA))
 		ASSERT(false);
-
-	return odm_combine_factor;
 }
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index eafcc4ea6d24..3841da67a737 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -37,7 +37,7 @@ void dcn314_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool po
 
 void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
-unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
+void dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index e5bd76c6b1d3..c586468872e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1141,10 +1141,9 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	}
 }
 
-unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
+void dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
 	// For phantom pipes, use the same programming as the main pipes
@@ -1152,7 +1151,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
 	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
-	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
 	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
@@ -1170,15 +1168,13 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-			if ((odm_combine_factor == 2) || dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+			if (dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
 
 	if ((*k1_div == PIXEL_RATE_DIV_NA) && (*k2_div == PIXEL_RATE_DIV_NA))
 		ASSERT(false);
-
-	return odm_combine_factor;
 }
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 2d2628f31bed..bf9bffabe0c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -71,7 +71,7 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context);
 
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
 
-unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
+void dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 4ca4192c1e12..a151865a3a20 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -156,7 +156,7 @@ struct hwseq_private_funcs {
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
 	void (*update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
-	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
+	void (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
 			unsigned int *k1_div,
 			unsigned int *k2_div);
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
-- 
2.40.1

