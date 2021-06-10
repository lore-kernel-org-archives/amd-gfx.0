Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD8C48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7DA611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7DA611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC6B6ED9D;
	Thu, 10 Jun 2021 16:29:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BEE6EDA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8erq8zzgKNT3wUCjzXE65iEW6A23XinalAKor1eFV0+5Sv63E/8sXRwFlcgQEimRKOMfGf5qljMQae77jJxImcLh5R4RRDy/vJuRPjs1ISCfX8tChr+uWQBriyijOSuGOIygITIi5wrXuhCSXU6Y2/eTnr15/p5i36ktv5YNIF7wKjClsKr8mu1gWS5klaa8UJuG3EgI9O5ph7NURPownqoCZtLE9u4NxiSEmtSTGEBntr/8Es2lt8CMZEEfJmRCkD54lpmx+e+Q9Ql2mRJt0XdFBdXDHU6m3mfjZK7G28DTaRzH7Pfarw6yxNwmU3tJ3uQ5dIcGMKp6kvLm5hkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/oKdGcZksRudriHOLdWQ66wGBxCoGwzKtzM0Yybavo=;
 b=Q5aDWegUQmzEr3bagK5UoyE7uNaqGRAZbe2APsJr+/bEgyqbpmyYUE83rpeIvriVIbx5xsBKaHHZBp3bMJ4G+UzZYeLifPl5SleKwEUBdKkwGEgrPttNQZfGc4U8BWBoLsyHWSMPzjwWCoRUtVQ98rvBE7cUm+9B5m04CgpJw16npz0Csf1q0nuwqxL8AOmACBAsnXPqqkHoFMGVHajIQaEWspvru3GiqClOrgn7GNEyFPzrDCxX9iryykELZ3u2YnYDOQb9OY/2rLUOu4xJ810kdjSU0D1BGnz5elW3O877NZXhmfioq3ItjZby034XDvQtXJFdtq8Z4EYnAd7oIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/oKdGcZksRudriHOLdWQ66wGBxCoGwzKtzM0Yybavo=;
 b=lhSeyM8qK/Czc4w37LLWyW4AZqlgvXZsOM4DP7A1EWB6JRZ3ERbEpCEhfMLKvyU8/C7B2UY32CsBNX6BEgJS2wPGistsiMZlthDEsyr4tVtnEzQaMj4wfabXYtlUoncrZrjo3bEiROgvskO9sRYQ1Bx4UgloYuHSfP0U8VnOTIk=
Received: from MWHPR15CA0068.namprd15.prod.outlook.com (2603:10b6:301:4c::30)
 by BYAPR12MB2630.namprd12.prod.outlook.com (2603:10b6:a03:67::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Thu, 10 Jun
 2021 16:29:45 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::40) by MWHPR15CA0068.outlook.office365.com
 (2603:10b6:301:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:43 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:42 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/24] drm/amd/display: Cover edge-case when changing DISPCLK
 WDIVIDER
Date: Thu, 10 Jun 2021 12:28:37 -0400
Message-ID: <20210610162838.287723-24-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6848ab91-c84e-419b-4745-08d92c2cf4c1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26308299DFEEC5D29B28A03CEB359@BYAPR12MB2630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYbnI3n2Wt5fcs86j4H6mSz0LIctCslVicLHO7dVILyRScBVKe1vVDqKgUBJo+kyta4oDmMEN/3tmq44nadayPbt4aRBAZ6qrSBJvXQhTPAifHh8R1zdfGIO/HS+3EzDGKiZ/anUw9syJ9fkNkTjLXXH7L/C2Pcsu344lxoFQfqGy/TtVbJs/zfz9K5PhNUf67zoRNJxYTBdgilYMBhML8DqKIp4il+9Sq3eok52J4S8WGzbeg/607DCfqoT409NrZ2W0hvX9aYFeEuwbk0sKQgdlo1jyTgXh25Tf1E+N2wtYLccX5GJ8Q+peimUx1um0NZ1HTutnqWGVBBynxJG2J/BuAGWKGgJlUKD3akdBMjVnm59/9CYlOZHMAXQd9KU3BBrd4VoajHYcdYbqmyiYLuN5KExwB7V3eUiVG5rq+UChtrN/K3jb7/DxElOI3E0RfFNpyMHbI5JgAQoKWiOVIov9NoB+GuYyfSxfss1VNEWJJy/K/BPLad1FTjKMwT9JoOsI0SeUJLKkql4fsRTYceZ9m44JA8y+2o6oJtiuEYFBngKBWpvcoaFCjpWkRae2/YgvEjB/suPCAjSWxFfIpcAymyix+OAiXfcrOP50A4/9xoPB5fokqTKV1uaqoUyyooWEdpBAEMprdV5oRZBdp8q3j3tRKXXffDiBKYLiVYchi4+GWuLae4mxu3U/1ol
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(81166007)(47076005)(86362001)(356005)(8676002)(70206006)(83380400001)(70586007)(54906003)(36756003)(82740400003)(1076003)(478600001)(4326008)(8936002)(316002)(5660300002)(426003)(2906002)(186003)(36860700001)(2616005)(336012)(7696005)(6666004)(26005)(6916009)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:44.4507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6848ab91-c84e-419b-4745-08d92c2cf4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2630
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
When changing the DISPCLK_WDIVIDER value from 126 to 127, the change in
clock rate is too great for the FIFOs to handle. This can cause visible
corruption during clock change.

HW has handed down this register sequence to fix the issue.

[HOW]
The sequence, from HW:
a.	127 -> 126
Read  DIG_FIFO_CAL_AVERAGE_LEVEL
FIFO level N = DIG_FIFO_CAL_AVERAGE_LEVEL / 4
Set DCCG_FIFO_ERRDET_OVR_EN = 1
Write 1 to OTGx_DROP_PIXEL for (N-4) times
Set DCCG_FIFO_ERRDET_OVR_EN = 0
Write DENTIST_DISPCLK_RDIVIDER = 126

Because of frequency stepping, sequence a can be executed to change the
divider from 127 to any other divider value.

b.	126 -> 127
Read  DIG_FIFO_CAL_AVERAGE_LEVEL
FIFO level N = DIG_FIFO_CAL_AVERAGE_LEVEL / 4
Set DCCG_FIFO_ERRDET_OVR_EN = 1
Write 1 to OTGx_ADD_PIXEL for (12-N) times
Set DCCG_FIFO_ERRDET_OVR_EN = 0
Write DENTIST_DISPCLK_RDIVIDER = 127

Because of frequency stepping, divider must first be set from any other
divider value to 126 before executing sequence b.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 68 ++++++++++++++++++-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h  |  3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  4 +-
 3 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 59d17195bc22..9d1db74de36d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -123,7 +123,7 @@ void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 	}
 }
 
-void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr)
+void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct dc_state *context)
 {
 	int dpp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dppclk_khz;
@@ -132,6 +132,68 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr)
 
 	uint32_t dppclk_wdivider = dentist_get_did_from_divider(dpp_divider);
 	uint32_t dispclk_wdivider = dentist_get_did_from_divider(disp_divider);
+	uint32_t current_dispclk_wdivider;
+	uint32_t i;
+
+	REG_GET(DENTIST_DISPCLK_CNTL,
+			DENTIST_DISPCLK_WDIVIDER, &current_dispclk_wdivider);
+
+	/* When changing divider to or from 127, some extra programming is required to prevent corruption */
+	if (current_dispclk_wdivider == 127 && dispclk_wdivider != 127) {
+		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			uint32_t fifo_level;
+			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
+			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+			int32_t N;
+			int32_t j;
+
+			if (!pipe_ctx->stream)
+				continue;
+			/* Virtual encoders don't have this function */
+			if (!stream_enc->funcs->get_fifo_cal_average_level)
+				continue;
+			fifo_level = stream_enc->funcs->get_fifo_cal_average_level(
+					stream_enc);
+			N = fifo_level / 4;
+			dccg->funcs->set_fifo_errdet_ovr_en(
+					dccg,
+					true);
+			for (j = 0; j < N - 4; j++)
+				dccg->funcs->otg_drop_pixel(
+						dccg,
+						pipe_ctx->stream_res.tg->inst);
+			dccg->funcs->set_fifo_errdet_ovr_en(
+					dccg,
+					false);
+		}
+	} else if (dispclk_wdivider == 127 && current_dispclk_wdivider != 127) {
+		REG_UPDATE(DENTIST_DISPCLK_CNTL,
+				DENTIST_DISPCLK_WDIVIDER, 126);
+		REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 100);
+		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
+			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+			uint32_t fifo_level;
+			int32_t N;
+			int32_t j;
+
+			if (!pipe_ctx->stream)
+				continue;
+			/* Virtual encoders don't have this function */
+			if (!stream_enc->funcs->get_fifo_cal_average_level)
+				continue;
+			fifo_level = stream_enc->funcs->get_fifo_cal_average_level(
+					stream_enc);
+			N = fifo_level / 4;
+			dccg->funcs->set_fifo_errdet_ovr_en(dccg, true);
+			for (j = 0; j < 12 - N; j++)
+				dccg->funcs->otg_add_pixel(dccg,
+						pipe_ctx->stream_res.tg->inst);
+			dccg->funcs->set_fifo_errdet_ovr_en(dccg, false);
+		}
+	}
 
 	REG_UPDATE(DENTIST_DISPCLK_CNTL,
 			DENTIST_DISPCLK_WDIVIDER, dispclk_wdivider);
@@ -251,11 +313,11 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (dpp_clock_lowered) {
 			// if clock is being lowered, increase DTO before lowering refclk
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
-			dcn20_update_clocks_update_dentist(clk_mgr);
+			dcn20_update_clocks_update_dentist(clk_mgr, context);
 		} else {
 			// if clock is being raised, increase refclk before lowering DTO
 			if (update_dppclk || update_dispclk)
-				dcn20_update_clocks_update_dentist(clk_mgr);
+				dcn20_update_clocks_update_dentist(clk_mgr, context);
 			// always update dtos unless clock is lowered and not safe to lower
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
index 0b9c045b0c8e..d254d0b6fba1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
@@ -50,7 +50,8 @@ void dcn2_get_clock(struct clk_mgr *clk_mgr,
 			enum dc_clock_type clock_type,
 			struct dc_clock_config *clock_cfg);
 
-void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr);
+void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr,
+					struct dc_state *context);
 
 void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 652fa89fae5f..513676a6f52b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -334,11 +334,11 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (dpp_clock_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
-			dcn20_update_clocks_update_dentist(clk_mgr);
+			dcn20_update_clocks_update_dentist(clk_mgr, context);
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
-				dcn20_update_clocks_update_dentist(clk_mgr);
+				dcn20_update_clocks_update_dentist(clk_mgr, context);
 			/* There is a check inside dcn20_update_clocks_update_dpp_dto which ensures
 			 * that we do not lower dto when it is not safe to lower. We do not need to
 			 * compare the current and new dppclk before calling this function.*/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
