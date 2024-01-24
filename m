Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CBDC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C5A10F639;
	Wed, 24 Jan 2024 07:03:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D231010F639
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAN9UwYkj3/Iu6yXhbdJuVLpwrKMCh/nQdv6mmVkrLd+0D2h1x65hFF7A+ClY9WRiJKvflxPy8XJsj+h332WyoQZ2mApfDPzPHGo3udXFmqDCc6jdOASa7Cag+jcUTRy0rG2iQQ4fMgXCrodsMSTknsECcWTSMLAf2rNRp6Vn93+1xNeN/an2Vqk+HDyHrWzs60mTY12dsMzjvFM+v26DIHtzSgiKMvEjAzJf8bbQODc5rPtuthM0XHk0P3pPO4kqKLmcYG0sZAqrcjdkmXhiIxvOdf7olp+Y4FMD5Nebw0IQG/RsfPSMeFv/ycSVqFnGYQ35YEhrNAKEcK3FSMhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czyuDSV/i+Oj664V8d9f45MPQyezKkPrknwGEmr+yjk=;
 b=bSR6gTk5bsNXbC7Bl8Tamp2vJ3QEH1/NqgLE6T3eiNC0m9NJwPilSAS/qhM9uriJqZqvdEqa65PwfhkYPOZH9I11iG9VLOx1troxeRINf6/LPob6ATQpquTAr/KQk3xmUhfZkRdjGdeiQHHGHqBF9b0jFlUMyQHpx77BM9n+ZyhLUkSKjZJcqRWrgmcDnMgeLXujDpIbYd52LeWvJwQmrBHNc4cgYXbETiqUKiJjMNGOeT4HVV8eEg1RWlXjKWD+vTLh+UOJjpumlNCWdCvv90/nflQzTSsKbzPRZnfe9DVpZ2o+STNI3Va3oyLEAOfC++Y3rdGNp7CG1aqzM3fX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czyuDSV/i+Oj664V8d9f45MPQyezKkPrknwGEmr+yjk=;
 b=1P+eWHcuk7shT5bzjGaYLCarcmP7KssSxJ8yucbxa6i4KrevosMJPeErcu6+V0oT9LJISDDpK02bgfH6H/rL8FgRkcioe5hBqJCReivyQqwKniFHmCkMfR63Ms78lXu2Fc/H69+iy73EE+rzInvhPrvmnkoGO5DhIefKa4cTBmY=
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:02:58 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::c1) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:51 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:48 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: Fix DPSTREAM CLK on and off sequence
Date: Wed, 24 Jan 2024 15:01:50 +0800
Message-ID: <20240124070159.1900622-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 300d91d3-20d2-4503-bd5e-08dc1caa7ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cj6TQF0dyyKDcMTb19hYMAwyUka9oki67vhuOWkjKO+rvP91bU/8161tOkjRK1SYK75tGH0OfGtcH+m4mUnRvev/+3EU9U6Kfb+Qq3M8nQfYZB41Tq/28oyMZm47Bf3uF8dSJqY23BrChBQG4T2Bi/c20uJfJQVCK8EFMI167kZXhQk7Vp7n8YisjwXs8ucrrTCgPIBRWFni10J7nOAzghWdbg3QYuZkMyu1sbPgXd81RvN91dOyee+/QBE5HVk3Sj5oC85++kkTpacKDf6t6keaXpRm5iHSg12CZvl8lVNiJ8nytN8pV3aTFA+unBiKvQgya3e0WLJ51e+FRk0ZWrU9EYK/O9roq3pwjYseJPgdP+blK856KiTs7eSvg1vlEnF9ADfDeIkBj+FALkG6EGu375fFWXFB29wzvptaYmrqP34DUwPAQc74x5ITshSdKwSIqLlfUkTTfAAQxBcroatnjtNI5LJrWoAidlH7w1OPcQ8E0DB+1BQtzso+QFAN3u6qQPliEL9BV37UVt97DR8eCFeIZ0hFmIWD8dBXkF46Cw3Qglsp9jQQ1aMoiJunc6dRyIvQHUxoITalcHcRkLVTEDNPFVzVthmplFfha3zFx7jkZkdhiJSRjQerf1kC+0FO0+hUEUu8F2eI0WdAoK7PzqTYpLKGZact8YCj1boiW3O+5mZ9K2xCStnotk6Upuhjqso1iyAblt+84xIFYjQQ/PeE0pBAQ8dPG03EFzs/XHUjtZt5iUrm8hsOgafEusiNQYx++4zcFEOt/dRxdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(54906003)(70206006)(70586007)(316002)(1076003)(6916009)(2616005)(40480700001)(40460700003)(5660300002)(426003)(336012)(7696005)(26005)(478600001)(6666004)(83380400001)(36756003)(2906002)(36860700001)(41300700001)(81166007)(356005)(47076005)(86362001)(8936002)(8676002)(4326008)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:57.8479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d91d3-20d2-4503-bd5e-08dc1caa7ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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
Cc: Charlene Liu <charlene.liu@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, chiahsuan.chung@amd.com,
 Daniel
 Miess <daniel.miess@amd.com>, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why]
Secondary DP2 display fails to light up in some instances

[How]
Clock needs to be on when DPSTREAMCLK*_EN =1. This change
moves dtbclk_p enable/disable point to make sure this is
the case

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index db71a261e9da..88170ab0ec7e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1183,9 +1183,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
 
-		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
+		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 1ffdaa38c932..d26353dafc1c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2895,18 +2895,17 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	}
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-		dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, dp_hpo_inst);
-
-		phyd32clk = get_phyd32clk_src(link);
-		dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
-
 		dto_params.otg_inst = tg->inst;
 		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
 		dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+		dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, dp_hpo_inst);
+
+		phyd32clk = get_phyd32clk_src(link);
+		dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 	} else {
 		if (dccg->funcs->enable_symclk_se)
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
-- 
2.34.1

