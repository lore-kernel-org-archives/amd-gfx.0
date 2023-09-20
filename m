Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE57CE79CE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 13:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DFF10E4B3;
	Wed, 20 Sep 2023 13:42:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BD310E4B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 13:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBwH8Ho5ZzShyNSX06P6e68PN8+L/BdoOQfxoSju/B1m4kURdhnnM7mRsmTV8Aag5+zo9EcIdnMxpmyy9MVrgJS+z06tUSjOtWG4hvyCKm4o1s4FfZ3T2lPljmTSvXcyhQmg+63wFMuI9EtU3g5/kJbUZ0o6S/lVAhJ2JbfRAQFW4tlJVVPDKaCTz2SMCzupI9oB6bSKPMcfwi9unBSKiRfNEkJ3qnbZJ7tx4hSMW3/ZZAtcY8LieA7YoJM2DD8M9SBWcnlHW/vuhbGaw1gWRyc/7Wx5n4kCx4YeERRp6PievbCYPuUuvO/zmpHL9oemPJe1zK4i9qXZ0suVizQQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAbB4j9pw47ssRMBJkVUoJMXfsivmiKQ0g3tWc+v6/4=;
 b=YwHLl/1FlfXua8hvytFj6h7tG3owk9M3/cD3J39mV4AMijFBYK6IMhOv93iB61Kj68jpunUsklVmmziZaE2Ejd94rHCWVqWFgO9Aod/THfQgyZZOpTm74SiV672qdRFDdH7KBJQp/1zI9z31f0sHiF4OTL/ut74JNx29rb3+KsvpLslPMHMlS/EYfaraqYnyxL0Y6ZahwLsj+Oojk3jkxfuLVhxpqLI7VptZTPY8T+2UZ5VQYDPwIVIFzGoZpz2RvtvyZhwzNp43WP3GqhrnT2qUCNrtIAokKkWSLqojtQxbgzaL6zAI9mJEQLv6rsWZtz39gi9ZjdDJv7j/v1Gb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAbB4j9pw47ssRMBJkVUoJMXfsivmiKQ0g3tWc+v6/4=;
 b=zqLBnAKuHva2Ea5FHhYxFh8Vq7BAPtsVpbt5P4r0WHAiNV9+t1uQXc4ua7Ad5ZBbY7sAxfVW+D6WkiwlXF/FPYQgPd4EQhCMzAXC6GC6xZFxa3EkfkDgCNMTLUuATXSnKaafLD4k5/67f1HsMDyJzDyhbu0/EB0sOgDQ6uzlUns=
Received: from MN2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:208:15e::36)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 13:42:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::c9) by MN2PR17CA0023.outlook.office365.com
 (2603:10b6:208:15e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 13:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 13:42:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 08:41:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix some style issues
Date: Wed, 20 Sep 2023 09:41:09 -0400
Message-ID: <20230920134109.2641560-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc45d67-ece7-4062-8d80-08dbb9df5e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LaKNIo7n+s8MYWWyKPp5WHGCQHw0AbS8sQv9VYFOO+JQOHWVeOLJKKYG2/g0zDzWgZGz4exEKWZojFg0aAfAg/7S4no5FeFwu5dNX6ObPND9dpbB/faLYP9ZNoUrqa6BZedwGhqa/9ap5q49p0XmSFVs6pb3HlUsBfMeHwWy6cZcu6vWupI0M+NhPp1T9qPoO7YFTMpVlmvs17btmpywj6CYA/K4qpxlpLYDlW0ifvAgv/voH8BpgCQ1aQz6XCbr5HjSKnC0xfozOJoAjy+kb+73HGkxbOqlF09uU6c2nKAq4xTe7Vt2VShgiI2iqj2dXCP019uWi45qEokw7u1sdH+KsFsz704DG7Kb5LQxOIo9GCdWkuKelQQeMBFoqt9cIodXNYx0G3jIUCin0ti/desPjHHNjqb0k4zu1xtlSqiOUgEl52We5ldZSHirBkAATZS6FkwB4kAxR3m2UDCVMZUbqntpLJjMB6ps7sUL4IF3bjMaoLM5vgerVQrcKsOBeUU+6XZIe9vF0QumUvy/0mTjwuiAjtIdkH4ZpJhinO8/sEYRGPKnetXrtkOt/rIisE0s8RxPrGbuj6BwpYdUNk1+JYRUqHp3MWaIicp5igcCrCi9TldOXEkx48HhzglxyxSzC/ro+91gL43CXjoHVk9Kb7FSAAkhQtCs78C7EfrebW3H+MuZgbllA3G8R42rSwHruqcRWEt3HDmQR7wdIShJLQds80ioLGL5UN93kOx2BJvM93Y0vd9tSQgMfVThbcpDqdtdD9BryucGYJYqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(6666004)(83380400001)(82740400003)(81166007)(86362001)(356005)(36860700001)(36756003)(2616005)(47076005)(1076003)(16526019)(26005)(40480700001)(6916009)(316002)(70206006)(70586007)(54906003)(41300700001)(336012)(2906002)(5660300002)(8936002)(8676002)(4326008)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:42:01.1175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc45d67-ece7-4062-8d80-08dbb9df5e26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Stylon Wang <stylon.wang@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes a few style issues:
- Only calculate the dto_params and dp_hpo_inst when dccg is present.
- Fix indentation
- Drop empty else block

Fixes: 7f7925e25828 ("drm/amd/display: Fix MST recognizes connected displays as one")
Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
Cc: Michel Dänzer <michel@daenzer.net>
Cc: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 13 ++++++-------
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  |  3 +--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index baecaaf96968..0276db0afab3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1175,18 +1175,17 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
-	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
 		dto_params.otg_inst = tg->inst;
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-		if (dccg) {
-			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
-			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-		}
+
+		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
+		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
-				link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 19ab08f5122e..fd3f5d437c8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2729,8 +2729,7 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-	} else {
-		}
+	}
 	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
-- 
2.41.0

