Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18682ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701F210E7E2;
	Wed, 14 Sep 2022 03:26:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA20410E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq0oHql66qKbaU/e6ieV4aUxHp6Aez1h8VIIDJviNEoKyQQ9yv5gyxm3Akn7iDBykh1Ol0+uce/tfAUyGFEECXOkdl/Z5/sgyX4Pk5RstuHTMgPTR0ooznLWc7ZPvPR89AMbrfnxmV+mVtSdezoLDQK3A8nWo50Rti74WFtj5t6XOWFLwWroaXTWYpTwjwwZJcGfajhLu1kv6uYUeiJepf41PiVEcbxsTbi9HK+4idycWk5nDRCuVhG/bt7MhqgsHq4cA4byxSGT4W5zosXuqmyf/wZQfXyWBmR8tonlrb6xQkpL2QGyQv09WCXBNPrmwYSDip9R7VHmP7SxCUhsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSf6qwvhXhDqE0gPA4livK7ENtaDt+cbNef68ftscxY=;
 b=Kd/Px3mvi//H9y+ntHdfQ+vf/OeoAh5KuLio64srEQQh/EMQl04KC4mHU5YVhp/YEJARt4N9z3at3Z51yi6JX8HlmpOri/6/WF15Fe4SIbsNc+g6aJbU84DwV7UAW5FdpIdhg+6adEpRpMBeQq9P546WJwqariNteMc6LjgKrRg2mirszF/n0nzVMbRMkQtoPSfFpayHkQ5NcTDu2+KbT7APXSyCaTQHoDYAFKJsz6SJlzY0IxQjuG+wBIbhNoHJXn1kLywV8GCd3gacIGtb82By35groZuGvH/eTQRoTUB1mFkLe2nMMiQ9omtzZJSEZYmNVA/W1PGfXFOuyS790Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSf6qwvhXhDqE0gPA4livK7ENtaDt+cbNef68ftscxY=;
 b=hzlFJSpDDsFdhZc43cPblIobheb5MIFTOjfjNPeqTHjMGzpsinPis+p1Snu9bTwwZvwZ1z/aWT1TYLiQxLJlLW95NfYSeKH58t8JsG5z1RgBCxigm3FUNVIzED3KNpc/2jquWXwVmEKR1GSyEmUTEjkfX21GbQbRhtoxH+rHq9g=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 03:26:25 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::9) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:26:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:26:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/47] drm/amd/display: Only consider pixle rate div policy
 for DCN32+
Date: Wed, 14 Sep 2022 11:24:00 +0800
Message-ID: <20220914032441.1075031-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 318498a7-61b4-4828-cf0a-08da9600e740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azNh6j0XCTmmRTRdfvwO7US5hqO4l6EoE+2Gf1dmf/s8qrFo3pZB57RVsHn9Km2SF6ria11A7SinuL7D7f87Lv0HXLPg7tP9KfGwyEh5GEXSjLWuqWexuqaGIxR0bpY+wdChgNUe1dDzC7Ou/sHaJHgCqt8Pea99k/O34K2qyULSYOP3Mhyss61Sqi1phGhGAdKjYq8CVqoSeay+Fee/CancU6Z2Gg8KABESI4bTB3hdO1haZfWuvpbiEU9lwoNgrYcOoLpqzQWjwVsfD/bQaRrzHdbZPc4JwZqKdtCQbTlcbn3t9l9XGyUpFZfDOwt+T66rWnnHMSmOS3vqevLnjUC1OR/POfLZ/ji3z0RmWAW0m378yvdWq94++65Kq/Pvhe55TR3dxe4HTmw391UHpYV3cPrZkgmiQGFYtjeZjJM4niSlUedQa3lIK557uFCiRbYUgsefHweg2ecB43yF99oyipgcR1yd9zyDaaoW2fqOpeWX0CZcd1znsuMcFYk1L6XIgkTHq+WRxG5Suk5R2OKOD111A4zfLvezT3xkq/I+Ko3d/rkeqH3HC7UCQ+yPe6d6qV+6XHM+S9/z3LTU08QY4mhQLKGIMDXj+QQCS++XZB6lhFHV2IhuDu2ThliR/F6S8ahy82BPZm9NdCLYbgb8KzcxeCtp2vJcB8xMJL+Uge45gfYhcW8r0iYQ96ZmQhji+PqfK70gi0IncHF99uP+d7mhJFdRdFNw4MTFfrfM6ubcHcmPnh/O7SFdDraXMWyFE+8orTmwSLDDqGh4/ykOg9LVQWXp0WPQt9F+xMzsbImuZnknwdT6of8RU67bQnDkH7beOIRjXrU/+HTk98+rI9SmkcvfTxH9NjEcc0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(426003)(47076005)(83380400001)(356005)(2906002)(26005)(70206006)(82740400003)(5660300002)(336012)(40480700001)(186003)(6666004)(1076003)(82310400005)(2616005)(36756003)(40460700003)(81166007)(478600001)(316002)(4326008)(70586007)(86362001)(54906003)(6916009)(8676002)(36860700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:26:24.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318498a7-61b4-4828-cf0a-08da9600e740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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

