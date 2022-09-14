Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F1ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74A710E831;
	Wed, 14 Sep 2022 05:13:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1091810E830
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKWQyogAUoXMtru/A+kjWpKA308XMPSHZS3+HcuCR+5fpXwZ2qq2WtZkDjXDiAXikH/nan4jJfWh7BIsWQwezznIooOz90eD0Fb0y/fcY2MyXT52+xMTW10Qtz8zv0OALhHbJGGzomwjjFkHIenCF16K4f7R0iXeVBO2rPApYXFDG7MHVpNtnu/Uz1kTjkSnNPm8Z1eD2d10DiRaIAQG89SI1LfbCBssa7S2Ubfq13GjDaqSt945RZNpvdiBJLcIz0v0dZ00hKuXVbe40VIy2B5fG95U1qouSGacooGYLegijaEXnKMvxse4wr1dmG2azSKzXG3iFZlaYNtkVtR8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSf6qwvhXhDqE0gPA4livK7ENtaDt+cbNef68ftscxY=;
 b=NMIJA+dvJ4QxTG1wn229kfBDVS9ilJ53P3e44cjdB9rQgLcysqfxDhYeaQ71QCZ0K0bcbckGKgmGELsh7BXKLbZKlUAnYegVUMtiF6i5wj+dZx5mAc1spCvFoXDjBG1T5XsbbBFJ6T/NkMX2n99BKSiqjnIJ2RNEJ5kbSfFgUvTEuMxd/b8EKP0RkG441DHRxQzVTetzHj9ZdsmFoqTN/cukxYefnGpOZ20WU3daLjkRgGC8U1e4B11+hrSoKPonheHaESCYMSLiLDzDxaHoQo10s3MjXJdUy6dPgN/FkPE0J2O6AVtVLb51b90h9DyHwXmy5uyZzRJcx/1BVaE+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSf6qwvhXhDqE0gPA4livK7ENtaDt+cbNef68ftscxY=;
 b=2FzWH1FwBuMmi1AR++SP6sygLOhItYkvZauiD8OFO3L6nfodn9ZesMJZgHXBmV2+wG/9BAkmY7RXvqNSEXVFxdPos+zdjq2QyZwfaSbCrYHDLPIuX2Ddr5Md7Mgi9rp3h+CBfBzFf08P6lKVuXuIMc9TiKq4B/gW5HNRr0Qn7Sg=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:13:36 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ec) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:36 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:12:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 06/47] drm/amd/display: Only consider pixle rate div policy
 for DCN32+
Date: Wed, 14 Sep 2022 13:10:05 +0800
Message-ID: <20220914051046.1131186-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: b23996ad-c9da-4b19-e2e1-08da960fe080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rX/u+1y/1Zi3V2xHOUjzvVXbxnQRLBU2gCjxCu4CRgwoz8ixzpKJLfxcxmllvhn92yypMWYU6cHpnkA9mrLQRPLo5/N+JF1S1vu9LKLPxLtClRkwyT6y4BW6/AauvAPTBFEvzZKtMbn3KwENUg6ZZgQKjISynEAng23o69UF1PriSXPM2WslkV4/sFnkhRzpK36Mc76Zx3kRMvtBent6Z+UftYPhlhRes6yLjSy2Mo+/n2J6MD+dXZUeBPnL1W3mxolhKwCB6toUQebHENjqyGI1zwph+RbojtdVGo75gmFa4lbvJhrBSJQ3UoKSE/YCJDCEyWVlsBsLGdOt5a/q9mPdZK512gp56CcRjy+AadlmTfH7MkZCEg8VleT3H+63GfRu5jL6GGke9Htp8rjYosalRPq1nbCKUm0vbxSJIKSk0SYXtA2J2aU7K3C2Bv48vxQ8bf/jOAZOIXiEFLBPNw6Te8Mcdeq7hGP0vE2xCB0eaz2CvIVxBhwzSkD5EO5OMjr1KiKWUxc47rP86FW6Hj2An/MyQrNhxWh4QpJdJxzpVaClpHqbIad2ojThoEomBys5UIuEwLxAkV99oc26FqGFKlTj1tpiBY5xyeOMMrI7ijMKX5Z+7TiK2C9Q1fzqlp7a8DvanNF9h7E48hPUuiyJ6ZyND1X5/w2KotKEcrF8TozGhjty3ESIYyuOi1e8j0JgrY0cplyAyyIv3Y9qe2NLXBfiSLTBM8huXdVHv+K3R43+R/wNfC8lVsqP2RsD46gGaPw/YPM5HSDVp6+A8VpicmFP/LzRokXCgH0QAJ7R40xn3zKYHoas3USN9+b5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(316002)(82310400005)(41300700001)(54906003)(70586007)(2616005)(7696005)(336012)(36756003)(40480700001)(4326008)(40460700003)(478600001)(186003)(70206006)(2906002)(6666004)(426003)(8936002)(356005)(5660300002)(86362001)(82740400003)(47076005)(1076003)(26005)(8676002)(81166007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:35.9690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23996ad-c9da-4b19-e2e1-08da960fe080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- Only consider pixel rate div policy for DCN32+

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c | 16 ++--------------
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h |  2 --
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c  |  1 -
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 39931d48f385..f4d1b83979fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -343,7 +343,6 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	bool two_pix_per_container = false;
 
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
@@ -364,7 +363,7 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-			if ((odm_combine_factor == 2) || dc->debug.enable_dp_dig_pixel_rate_div_policy)
+			if (odm_combine_factor == 2)
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
@@ -384,21 +383,10 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 		return;
 
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
-	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1
-		|| dcn314_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1)
 		pix_per_cycle = 2;
 
 	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
 		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
 				pix_per_cycle);
 }
-
-bool dcn314_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
-{
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-
-	if (dc_is_dp_signal(pipe_ctx->stream->signal) && !is_dp_128b_132b_signal(pipe_ctx) &&
-		dc->debug.enable_dp_dig_pixel_rate_div_policy)
-		return true;
-	return false;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index d014580592ac..244280298212 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -41,6 +41,4 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
-bool dcn314_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
-
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index fcf67eb3478f..72a563a4c3e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -146,7 +146,6 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn314_set_pixels_per_cycle,
-	.is_dp_dig_pixel_rate_div_policy = dcn314_is_dp_dig_pixel_rate_div_policy,
 };
 
 void dcn314_hw_sequencer_construct(struct dc *dc)
-- 
2.37.3

