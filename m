Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6E5CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023F010E84A;
	Wed, 10 Sep 2025 05:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRXCJoh4";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2136110E84A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE9FKN5ZS0UxmNJw7g2gsl034gaIpxEPMzmJxYtvxcAZUJkk5pAeVbHw3fE898sUHbiYxmkE1Yuijg6RkkNBj4YGQCOI/zxlp0MsN4xDz06zBsCQZeYpMiMYOqKsWMdmvXE3ELcJQyzk8I2povbOusH7Qvt4HoHjv/tnekiVhsqL0qY0I1JFXL6TDqxWurqnybpvzmACBBIo4ZrWrS2gQcedzbRoZKaEaptn0/PgwX9VDyDeXOW/XeNTYRlkZ6pePr1UYRyC80mu2JEGKIbkA7NpHrt6EO2FthC4oB79mb1gSTZzRHq+nIPWs5pomkOv9wmHEezJ+iOeuPkfNUQi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmmTeyUfF0mROHOg0C4Kr2OnUA4nZc+7esm7fq/pJ9Q=;
 b=OqBK2S5MTGoNUI3id3ZsVJuPss3p0Whf/CGQBvZvMMkyb4LF152LbEUafQ0ONKxvkaSQsA4Q4OF7t/9qCAJxIPI3eNOe33nK8uUDxeZ3232cLGQZOY8I4e39cUOulOBQ3S0lTYbjSS82Nd665Ae5JWGotRItKvv8Vg4UjleYVuSLKqiLB7NvTX9Y1fUdDrENxPFT51JiWjslmnHik6SJ7W9EiSF0gEKS8iHbbzfYb8Lp7wyTL0a1xBLQTF0MbGHF9Kspz5pHztb/iW4pJTesBsQP2eYsivak37/Gn9C5S/YotAMVaIGXa9zakJfrZE7B8Jstnvw63lD5xGfF9jJBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmmTeyUfF0mROHOg0C4Kr2OnUA4nZc+7esm7fq/pJ9Q=;
 b=gRXCJoh4mYXvGFzYJOdAd9+WpW+r2buKFe584UlzahOyTh/b87sE+Cnw7bOoNxwWGpEQXp4023oCoFzxyumEcQnmXPXS2mO4Y8RftM+GJ/j32fKDawGQqpNiaxq3rijZ/5XQr7ICyZ9V8BGtsljD2vU3eH742z8K+6rrYC3Rl7c=
Received: from MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:39 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::3a) by MN2PR16CA0026.outlook.office365.com
 (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:38 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:30 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Martin
 Leung" <Martin.Leung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 14/15] Revert "drm/amd/display: Reduce Stack Usage by moving
 'audio_output' into 'stream_res' v4"
Date: Wed, 10 Sep 2025 13:22:16 +0800
Message-ID: <20250910052620.2884581-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: cd97ab83-592c-4bff-337f-08ddf02ac1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TuUGgWHs4U4w/bsZkBCrvwG0hSv9On/ohtvW1VfX+cYIMDjeGK1TI+YpZjDc?=
 =?us-ascii?Q?66qWD9F9Dvlv9+8nGaqUclWRkJT/HycM5YhbEOdpwo8wxCDAFwqcU1ZSYfxz?=
 =?us-ascii?Q?PW2Iz/Gr9Eszk8J2Tt0FcKH/f95MKfwJb3t9BSqmgAhON0zpfsMOXf7D8tGI?=
 =?us-ascii?Q?6M1aWZGkawjeI5yb/7Fvo69++hzpI7c9vMxzD1UWiJ0Ouw/1LCDtr3QrHkti?=
 =?us-ascii?Q?QDOlR6TnzbaKLg2wlT4CMREEk7edrZx03Pxlbdx7llyavqXkR3NwDeR5vr7p?=
 =?us-ascii?Q?06CVWjXFsi4iiQz34I9ITUhXSZdODU5VVxuwuWV3gzX6IzRFtTTAH/uqGqDP?=
 =?us-ascii?Q?fzVHH8SP1v3oR2DFBGyBJK+CakkADoaovpXhOOEPvokN5G1pme/nFY3esH7O?=
 =?us-ascii?Q?+6aNFTwhOIlpzne5KUNcTcyAYQZ0v+rW9ITG8vVANm2rNF43wg9Pr0azTXGL?=
 =?us-ascii?Q?t4ALGz3r6dWzEwToRteUHCYCU6fDgk8LCl7G5BZKPTz5i3YBVRF7wmHFwhG3?=
 =?us-ascii?Q?VmgQZ5TKXb5IT37LJSpcub1GHo+3+fZylamnHRJBVJk4kWyyfkvM8f3o/FrK?=
 =?us-ascii?Q?tD8fprbFWSthSA69ZJjP83+sfVm83C/rlDUp7F2wYiI4mmFz8R6ENAu1iRVP?=
 =?us-ascii?Q?qk+ABKsBuEeuQLEy+8byK+JyxNHSjHJ2OgU6pZY6fDrg90OX9ni5F5FsR2Qa?=
 =?us-ascii?Q?C91jsnBg58eWAs+SClrYO8Fe4AkX54+c382JsqoMtl21f/AqI6MSa15w+dEa?=
 =?us-ascii?Q?bC0iJcvhOKydyLWmGMP6FImuj3/pm8ildtf4vY8cMeFbkpDNZrA3uaGVyZaP?=
 =?us-ascii?Q?rcfHUpHImPguDFh0weYIbLgKAiVSz2aIiP1gdHJ0fwoCURV1tZiQvqhYaARj?=
 =?us-ascii?Q?rBaWsvqAZ7ONClVWKNA79yMoBr1eUktOHH4MHVknX1uwCxMkY4fShnjNbM1P?=
 =?us-ascii?Q?d1070Lo48QWib8u/kzKneB86NbQrWtTWaiogOh7dCXwtMh57TxsqsEup5+w3?=
 =?us-ascii?Q?QSfxaOtogs/GMhZ3ayCoIo5BHB9CBVDdQUT1Q5/svxXjrJx+TTfp5wYSt9Sd?=
 =?us-ascii?Q?gqAHalO9/uuZPiGkiR2UXylDCP8hQg1d4E0b8itSeLNctgtNmtdM2lw5D+AS?=
 =?us-ascii?Q?5L7T4AxfzAvfJUNmTRx9TqDi0cNhRe0AGWWerKcazIlcgDyOb8ki7HNYWdWm?=
 =?us-ascii?Q?5pV+X8qEU2aSv3U0dOsqK/+YqtJV5/pkVZnBp8FvIppGiRg0MLuwH60fIDYP?=
 =?us-ascii?Q?3V1vJGj76l6OkXCrFlYSerI6fq5Lr4ACgajuWmNAq5Qnq+S6szfpKgvh25Va?=
 =?us-ascii?Q?YVD3BprO027FvdtsjbzWF4YocTOnP2TQ0Ewmeb/9EkBuf9yxpsMUA0u6TQTO?=
 =?us-ascii?Q?lR8DFC+A81OrGrjkLUsI8rtlTu2UTzlvos6UmqQt/B25Z6S69pm7TjQ/xnIz?=
 =?us-ascii?Q?Xz87W0h8q0OhyImmZBon3sIWPq1WD2oBMZSYZLPlRYw/QUyxRPUwHVKrDSmJ?=
 =?us-ascii?Q?L0KPZ5oNUDWiVmeF2+ajOrvCL6uE7TeEGo9s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:38.7517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd97ab83-592c-4bff-337f-08ddf02ac1d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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

From: Martin Leung <Martin.Leung@amd.com>

This reverts commit 571662266db3 ("drm/amd/display: Reduce Stack Usage by moving 'audio_output' into 'stream_res' v4")

Reason for revert: Causes DP compliance errors

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 32 +++++++++++--------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++-
 .../display/dc/link/accessories/link_dp_cts.c | 13 ++++----
 .../dc/resource/dcn31/dcn31_resource.c        |  5 +--
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 5 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index ea904d52af20..7b4a04704312 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1601,17 +1601,19 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	}
 
 	if (pipe_ctx->stream_res.audio != NULL) {
-		build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
+		struct audio_output audio_output = {0};
 
-		link_hwss->setup_audio_output(pipe_ctx, &pipe_ctx->stream_res.audio_output,
+		build_audio_output(context, pipe_ctx, &audio_output);
+
+		link_hwss->setup_audio_output(pipe_ctx, &audio_output,
 				pipe_ctx->stream_res.audio->inst);
 
 		pipe_ctx->stream_res.audio->funcs->az_configure(
 				pipe_ctx->stream_res.audio,
 				pipe_ctx->stream->signal,
-				&pipe_ctx->stream_res.audio_output.crtc_info,
+				&audio_output.crtc_info,
 				&pipe_ctx->stream->audio_info,
-				&pipe_ctx->stream_res.audio_output.dp_link_info);
+				&audio_output.dp_link_info);
 
 		if (dc->config.disable_hbr_audio_dp2)
 			if (pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio &&
@@ -2385,7 +2387,9 @@ static void dce110_setup_audio_dto(
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
 		if (pipe_ctx->stream_res.audio != NULL) {
-			build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
+			struct audio_output audio_output;
+
+			build_audio_output(context, pipe_ctx, &audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
@@ -2396,14 +2400,14 @@ static void dce110_setup_audio_dto(
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
-						&pipe_ctx->stream_res.audio_output.crtc_info,
-						&pipe_ctx->stream_res.audio_output.pll_info);
+						&audio_output.crtc_info,
+						&audio_output.pll_info);
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&pipe_ctx->stream_res.audio_output.crtc_info,
-					&pipe_ctx->stream_res.audio_output.pll_info);
+					&audio_output.crtc_info,
+					&audio_output.pll_info);
 			break;
 		}
 	}
@@ -2423,15 +2427,15 @@ static void dce110_setup_audio_dto(
 				continue;
 
 			if (pipe_ctx->stream_res.audio != NULL) {
-				build_audio_output(context,
-						   pipe_ctx,
-						   &pipe_ctx->stream_res.audio_output);
+				struct audio_output audio_output = {0};
+
+				build_audio_output(context, pipe_ctx, &audio_output);
 
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&pipe_ctx->stream_res.audio_output.crtc_info,
-					&pipe_ctx->stream_res.audio_output.pll_info);
+					&audio_output.crtc_info,
+					&audio_output.pll_info);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f49549147d99..d11893f8c916 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -228,7 +228,8 @@ struct resource_funcs {
 	enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		uint8_t pipe_count,
-		struct pipe_ctx *pipes);
+		struct pipe_ctx *pipes,
+		struct audio_output *audio_output);
 };
 
 struct audio_support{
@@ -360,8 +361,6 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
-
-	struct audio_output audio_output;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 23f41c99fa38..9e33bf937a69 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
-
+	struct audio_output audio_output[MAX_PIPES];
 	struct dc_stream_state *streams_on_link[MAX_PIPES];
 	int num_streams_on_link = 0;
 
@@ -101,7 +101,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
-				*pipes);
+				*pipes, &audio_output[0]);
 		for (i = 0; i < count; i++) {
 			pipes[i]->clock_source->funcs->program_pix_clk(
 					pipes[i]->clock_source,
@@ -113,16 +113,15 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				const struct link_hwss *link_hwss = get_link_hwss(
 					link, &pipes[i]->link_res);
 
-				link_hwss->setup_audio_output(pipes[i],
-							      &pipes[i]->stream_res.audio_output,
-							      pipes[i]->stream_res.audio->inst);
+				link_hwss->setup_audio_output(pipes[i], &audio_output[i],
+						pipes[i]->stream_res.audio->inst);
 
 				pipes[i]->stream_res.audio->funcs->az_configure(
 						pipes[i]->stream_res.audio,
 						pipes[i]->stream->signal,
-						&pipes[i]->stream_res.audio_output.crtc_info,
+						&audio_output[i].crtc_info,
 						&pipes[i]->stream->audio_info,
-						&pipes[i]->stream_res.audio_output.dp_link_info);
+						&audio_output[i].dp_link_info);
 
 				if (link->dc->config.disable_hbr_audio_dp2 &&
 						pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio &&
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ca17e5d8fdc2..3ed7f50554e2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2239,7 +2239,8 @@ struct resource_pool *dcn31_create_resource_pool(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes)
+	struct pipe_ctx *pipes,
+	struct audio_output *audio_output)
 {
 	struct dc_state *state = link->dc->current_state;
 	int i;
@@ -2254,7 +2255,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 
 		// Setup audio
 		if (pipes[i].stream_res.audio != NULL)
-			build_audio_output(state, &pipes[i], &pipes[i].stream_res.audio_output);
+			build_audio_output(state, &pipes[i], &audio_output[i]);
 	}
 #else
 	/* This DCN requires rate divider updates and audio reprogramming to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index 7e8fde65528f..c32c85ef0ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -69,7 +69,8 @@ unsigned int dcn31_get_det_buffer_size(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes);
+	struct pipe_ctx *pipes,
+	struct audio_output *audio_output);
 
 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
-- 
2.43.0

