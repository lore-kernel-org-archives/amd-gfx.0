Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9EBCCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF38113B75;
	Thu, 30 Jun 2022 19:14:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5046311A3A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLqtO9O0CBXus9f6F7llmlf7MawgRZAGvR5g3qu6qnuaBDaxhTg4gLYga0GCxOQhwHJTNOavOdBe2wD42laziZ39gU/JN9zVxJoAMz6f6NxUjAAqvrrRtPOaEGzc+R6YcVk8QAUUYiszXZ/erlil0UfemtN8p8R15exLzIj7qn9GZIlL37rSjOmaqcH8r0up8g0GCp48cX5Bjo/OThYjOXQWSWWLv5dsbc4u5ECI/DwKgE4O3KoniPbdqZl0cBn5rf57ZojjqFpHwlt2exrw6BMsRijj9HzLqJGlXi7AXOCiBJmAZuTAfCdubYUeCD92ESfihQirC2cvvJM9gbDLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/jDT8sKLXNd0YJAZXChDgGrK0ULQ7JDns8qBCu7BFo=;
 b=haIQnwL06ZZ/gmOPNA7VIgEtE0AoQSGJvdg240piFYH5Jp6gKA5hYx8YzGvgevKJtzd1umdqV0ZvSQprWp6oV9RPm6rI0EA+uJSAPIzhi3MFX5KyUL8LKJsA4FYxpMUAMCTC1hNn3sEQqiVY7Y+ckLjHOWqTV5Rf1fwpiJ4z9z0vGuKglk7u5Loq4uWW2v9KcjmYP4OAPEeqGkXPcJs9atszvMmzXKtockKXXXZVCM9NNzOyVtF5vo8Pl7OGHuDURfVfFBJTpZaVAhFn0jpwt4CM/HelL23+htYJfkfvCptW2dwAqpvd6Sj5WxITuB2+gREgYWK5uEAwMNPLcwdndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/jDT8sKLXNd0YJAZXChDgGrK0ULQ7JDns8qBCu7BFo=;
 b=2H5F7uI/8DpTl4ICiO/QuKk51bnhnsI+RBJNjC+5krCKhBoAXVhecFZBqUZnRYlct8ADmG95O/h7tl4fVjj9PzwSk7T1RScLDspfPHYHfyht7ytxQa9y1GoDC0PUQX6st+ew7+zVZetVSXSFfmrzSfAYG6YxKkgur6W5svItOdY=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Thu, 30 Jun
 2022 19:13:59 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::e7) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:59 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/40] drm/amd/display: Switch to correct DTO on HDMI
Date: Thu, 30 Jun 2022 15:12:50 -0400
Message-ID: <20220630191322.909650-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd5f0ef2-5ee2-4776-86de-08da5accaf86
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cvZFJ2ZMnj4eAflUu+eJ2yQkOMVVooc3xht81onWucd0D48+l+aNNuooaI6Tzu4c3lUVLKzb7s+oSDXvwg0EGFUVCbIO1+YCxt99A1+EWNjl0lI8tJrZF4dB6lwzq9To7YS7dHw818DgKFtF0F8YuWlU0H36qkb4PAVhmdroX1r8w8m5U6Eq9SKtNS0niLLYY0qBM2SlcpKGTnYOajPGdNuLbOMhW0N4a7D3vNI4WJ9xCDNoi13ltNx8HzSlEVaOg0D9it35/A3rTHZApaVMz0F0EhuH4ucA3XjzqxkyrRRq1qXhu8lC4sI7j1KwAfefpqllJkwzNdp8/0QU9rDHgv9N1fowl80UEfo0If0AtcT3fuLOkXBgFoxDtBPVB2nlGBQtKyk0VEHQ9xAMCuVDY6i39t9DF9P6xHCs5yLszzfRnl+5/0/xUxX8plwQTZ9k08Nqk5Sdg5UZKQMEXSEHBTfx961UesNuLjMyjnzsXp7hok7TrWXkk/wO42DUza1fdmqWWFJx2u/kvzq3H7f0E35NV+3X++ASVktHheK/8B959hGr6H+scTK5UTJrW2N+SLTnsY69DEhK4C5YeAETUZHM8h7A4XDrdpPVFZpFB0093/rlEIdTQwWmd3yEfrf3xDe7N7shUnheYN/vUDYRqXq8kdcnKGiWacfGZA1TJ/ehDDAOrqIGNYzYxD7uV95+t+FaEg3iIt44x5VRJhWZeQCnnwQEpShhF6h/SrHOKKZrDJoWZxiYEjPW0aIi+bSW2comtU58uGK7XVu+BiFUF9ushWUNWbM8/00lfk7uqEzzFmk29/aUfCHUZC5kkAvmbuyZIsuhxoAgP9S0gCdjb7BuThsjcbGFSt+0dKxDGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(41300700001)(83380400001)(356005)(336012)(82310400005)(81166007)(478600001)(426003)(82740400003)(47076005)(36860700001)(40480700001)(2906002)(40460700003)(26005)(7696005)(6666004)(2616005)(8676002)(1076003)(6916009)(36756003)(4326008)(70206006)(70586007)(316002)(16526019)(186003)(8936002)(5660300002)(86362001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:59.0222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5f0ef2-5ee2-4776-86de-08da5accaf86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
For Pixel Rate control, when on HDMI, HDMI DTO should be selected
instead of DP DTO.

[How]
Pass HDMI parameter for HDMI stream, and select correct DTO.

Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c            | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 4e8059f20007..a49e84d58892 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -318,6 +318,8 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 				if (pipe_ctx->stream_res.audio != NULL)
 					dto_params.req_audio_dtbclk_khz = 24000;
 			}
+			if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
+				dto_params.is_hdmi = true;
 
 			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
 			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 152a76ad7957..12fc3afd9acd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -171,6 +171,9 @@ void dccg32_set_dtbclk_dto(
 		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
 				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
 				PIPE_DTO_SRC_SEL[params->otg_inst], 1);
+		if (params->is_hdmi)
+			REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				PIPE_DTO_SRC_SEL[params->otg_inst], 0);
 
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
@@ -188,6 +191,7 @@ static void dccg32_set_valid_pixel_rate(
 	dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
 	dto_params.otg_inst = otg_inst;
 	dto_params.pixclk_khz = pixclk_khz;
+	dto_params.is_hdmi = true;
 
 	dccg32_set_dtbclk_dto(dccg, &dto_params);
 }
-- 
2.25.1

