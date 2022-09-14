Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C0ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A557C10E7FE;
	Wed, 14 Sep 2022 03:49:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C177710E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVhDdrYP8X0hhIqTMnDuh2hX3h+AbDkJdghj2GJHtK0tTcezet0fz6sn9nwtOVN0Zw4miLxsyvMBsTHT6XAcDRhLXJJ/JoVefvYulpxQUZRW78aFSDqLbwImShj7OcnXQXadF0we7BH2QVzv7SjFqskxEeMvjswI4HGiYU56/0JxGzVmsJzADUc3qUKcMKqloqPmh6eNfYveIXp9hMUmy0VoJWGMTUODPIbh4R1W1Esox2dir7vflwdmrt7HEZ4ulSA7QB28ZwjYyRCDecBwtXtB13KZiqbAxgQej2T2jqKWeSfb9JuV/Ab8Dgn83+hJKy4JsNSvtofBImrc2kFtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSf6qwvhXhDqE0gPA4livK7ENtaDt+cbNef68ftscxY=;
 b=NnTTP1OhkMCXw9uKyst75MeLXcI3+0B1/+uhNU4MC8iRSKSBh0MBdKT9ufgnJkOwD43NScrY8Yk7cH6Bg1MbA3PhB5zoUhnBiENLGQa8bUOKcOKodp8QtpzmA6YMLml7zwVtcpy6yNx38blbvwtLIjhUO0RZ1gow7W/boIoE+98zESDdLdlTuYAilejAJV3HRE1456MV+WLb0RqmgVHQ5yPFOghJNaWUDu5p85WQ78alJyGNU+vjJOeT5RIExah/BZahgamPb6FjDLnOUWg0IOKllwfy7ihUqMhchRbyftgE2s5qCe83Fw712uUkaboUdOlSIDr8A0RO9MsdzgofJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSf6qwvhXhDqE0gPA4livK7ENtaDt+cbNef68ftscxY=;
 b=4XuXxvqEdCp0Po6bqc8z0CVyhuiss5THKx1dpphePVLF4VTqhMtsCGP+LU4ap8w0FoyZVZe8eR+ufMhGzFdSZXrucuieOwsBoB7csyUlxm8ygM33ed8ZecQEdn5jYmVlrj3w6jDTnNS1j0LGu5HphoGJjxX3xbPTw0d/0A8zXlg=
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 03:49:25 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d0) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:49:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:49:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:49:24 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:49:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 06/47] drm/amd/display: Only consider pixle rate div policy
 for DCN32+
Date: Wed, 14 Sep 2022 11:47:27 +0800
Message-ID: <20220914034808.1093521-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c74bc-353c-4587-9f77-08da96041dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cuz2YGgNytGW+wkkJ0WCFkJe925zn+LHSicuDYU6jw+soLrgWB+KvkTzRLTZHLPi2cogWks6fOPLXuqpQKcmwMDE84+e51Yff5VO0rKWoGgQJ1KAFoQx1X4KTexpp/XvX5dXlDQECPiQ0x6kRpQLgx1Wx6GAwi9xmNL/Ofc9EgpA2vxlTFvDOOIRx3TOB+jxlIpMRBaFgtezST+ucnJ+qc7k18Wl2An6yoDuGUTjY3Qg8I2YactLlxwGeMOXQhUIn3p4TLRwwSNPDsBsUVuvPUm2r+JQg1cxSRBENSBNOn7REHb8yIdSxAKrwvaB2uiXGc2lw6vlC64GCyY6Wh6Nidtj3JrnGb/3H3PNU8rm2u5uSIo8TlnOJzyMJ/no8DgktwSsaulwnGIhMS1Mmgr0ct2lrv5EW9bLf9gREzlI2VMdXwSZ3ZtcQaLJ/xi/WV4RAnBI3AhQ5//Sxd/d+i4bp252N01TuGCMV8rg1EXeJ2nA2+x5OZ68BAYs9dGTtSgtzG2hNe2fyWIN/aMbbmStW5CRL81YAto80W6BjMcxENRaRMXkG5I7gTHMl/1zlWXNVsLMY2bP0+JaNqa/Z5EqEPzbPYqniz1/u/VHRnzsQ8NjqjjRE0y2y8Dc5wfmij3FyMngrXmjSgVDLsEGCAhTTYz+9mQWcpuwNryG/ubIWHscCn7YNnQ7xREyUkdhmTiM5Swgto9eGOphoLjt1DDBCtI1eFiZv/G5S/WlF9FevikyLN2ahaAAI/J9niqhpYlfwaq0mG3jbl3i0sAdcHgs+Ul1r2ajJKEF9o36BKLSc1noiE9gizrULAKb1W+lbFP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(40460700003)(426003)(36756003)(316002)(336012)(41300700001)(54906003)(36860700001)(47076005)(186003)(1076003)(83380400001)(70586007)(5660300002)(8676002)(86362001)(4326008)(2616005)(82740400003)(26005)(356005)(8936002)(2906002)(40480700001)(7696005)(70206006)(478600001)(6916009)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:49:24.7543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c74bc-353c-4587-9f77-08da96041dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

