Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293DEEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A353A10E646;
	Wed,  6 Sep 2023 12:52:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8B810E646
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIXrPrKdfrnt2pUMaK+CeoX3j+vUtzzFZY9/AZiHIeCbmZVwMWQhFP8lbgUOk1KMC4XH85xCdSShxALZt/uqIdQx+xpQNXHc88P2iMF8ITWy/XqDKEH68Q43mhGGPpz2Adli0ooiKVjTmR/vNidiJQzzyuQw3InstsD0agaauR/syBoJPpjcio8CDg83eb1U1MvJK/Rl2aesJCMK5VqB2NNoR57TTmgJf5Qr/Z2gUkHyuY0wtEPBpfMZVVbkFGM7+/tKjU0tlY0k6ev6SndpbBH9+KND2Adk0Uhl+rqmmyf0cIJlRR9yrbzY8sXRl/wZGsx8QPG7O71zAphd38C/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFbWDsOvvBdYNBZvo8TjMq88wx4S7u5hCegF0vtv2SA=;
 b=jQ6UYMUZ0XY68WR2WsDTWWEZoNUD2blG/7j5cgEMfIkueAnz4EWfZuNA9a8dqzt0b6VUT1nTVij18KxUA9hVIPu5Z5tviH9DJFqpTTQUIMHl4CNO/0YGD4m97PzrRixKjoPl8TULEC36Ulbpgw6KRAWhx+oMgCOMxmODxWYinUfdkDzIv5x4jdd5T3tYikXwgwIS4+XSew168DI4OXJVirSPY9Ns8wZ9JJ1FvkAIddVSqtFjmT+dKlVnXA/63gzIrB2WvkzWV6V9H7YXI9gGEbLxyowZosT7ZID06G7RLa+SqSF5yM5HVzB5PoNC1BEtEbYYsZFABSmdzX7O64vUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFbWDsOvvBdYNBZvo8TjMq88wx4S7u5hCegF0vtv2SA=;
 b=SxbsdeVqaHy3JhpQhToGiqPuhhufKrBGTHtpgyqEfb1Pp57d07ky4nUmwev30enine8P94ZIR3cQnwD4ejbLZLjp/pJOY5ZhBe0Mstp6BMZm5Y8LtaMj26JeQ7qytLEzInvfxoPZ3aIXV/7lFDojGZ3BUdWZwfPC0/qVcO2LEl4=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:52:04 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::29) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
 Transport; Wed, 6 Sep 2023 12:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:52:04 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:59 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/28] drm/amd/display: minior logging improvements
Date: Wed, 6 Sep 2023 20:28:30 +0800
Message-ID: <20230906124915.586250-26-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 5860a8c9-a3d3-4742-c0d0-08dbaed8122d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwOQxJ9sxpn6rpL7LXgGUFXpfb90f8hST5ejVijN7/uyfxlep4sUgglBwOe8/S9uF22ApLN20aNO7iZvY+idcvH9fDDlYzndwz3XBuREnCn8LcPH5vkLq629Jph91unAGBXFaa62YlFrqy4ezHiM3yMAIiUpbwN5RSJgHQsDUO6tRsGr3IRa+9RwnEwXf5ZCzuI5cha7h4aCA90NOU65b49LPldoyR4F7ZVwjt6IXc1XPibXkxLvAcoGWsitKBwIZfcx5imUhO/OoWKqXrTJXlSNu6bL+0bYjmKVgpDpfw82qljsScJFFBzZR/0MdZzrX2Nydig+pr5lfAYpLXOcC4+1lc6TOr+3DETsYVaECAzoc71HmrPZF27ozcgmRe9E3RcDr/rYEqKHdICOKUIi31/e59qxTjYZuzqGbAXDbAK27LW5P3wsKCQQYELkdzY1Fvs9EVgDg1SVT+Pxs0ZC2x2cpY9560J5nm/jDbumiDREWIbAicgpmXx1apO/qpjrfnHymBqXyWX931++ppCqoSJzQ/ovjv67coSELdM3VkLySolDg0TtbR8GQbaNvhNo7yzP87NXllGQmm5o0iuhkLvYo/zqKLYe4jugkaNng8aE7lGTarKwax1+pwjMC42PJw4TkWY4tr7QrS5uD9oHZIKSpVpgNHlXq9rgKaMxFeSBuqXYWEeN5oYO1f7GGD4YSl6MI+u9PcTmPoykBI/X6ydjMtlmqeV2tWItAV+KT+F5VWoAXgdGNbJdRq79mcJbZ/iAZ+XM4x9tdHNnflzCvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(44832011)(2616005)(83380400001)(26005)(16526019)(336012)(426003)(36860700001)(4326008)(7696005)(5660300002)(8676002)(8936002)(47076005)(81166007)(1076003)(6666004)(356005)(82740400003)(478600001)(54906003)(86362001)(41300700001)(40460700003)(36756003)(2906002)(70586007)(316002)(70206006)(6916009)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:52:04.3745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5860a8c9-a3d3-4742-c0d0-08dbaed8122d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
- Add minimial transition log with reason and base state.
- Do not log set dpms interfaces for virtual signal in stream.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  7 +++++++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 10 ++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8e8362026825..a857de5ebe85 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4069,6 +4069,13 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		return true;
 	}
 
+	DC_LOG_DC("%s base = %s state, reason = %s\n", __func__,
+			dc->current_state == transition_base_context ? "current" : "new",
+			subvp_in_use ? "Subvp In Use" :
+			odm_in_use ? "ODM in Use" :
+			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID ? "MPC in Use" :
+			"Unknown");
+
 	if (!dc->config.is_vmin_only_asic) {
 		tmp_mpc_policy = dc->debug.pipe_split_policy;
 		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index cd9dd270b05f..d8327911c467 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2269,6 +2269,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
+	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
+		return;
 
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
@@ -2281,9 +2283,6 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
-		return;
-
 	if (!pipe_ctx->stream->sink->edid_caps.panel_patch.skip_avmute) {
 		if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
 			set_avmute(pipe_ctx, true);
@@ -2382,6 +2381,8 @@ void link_set_dpms_on(
 
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
+	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
+		return;
 
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
@@ -2394,9 +2395,6 @@ void link_set_dpms_on(
 		}
 	}
 
-	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
-		return;
-
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
-- 
2.42.0

