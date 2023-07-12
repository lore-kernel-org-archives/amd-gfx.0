Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1541EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEBB10E5AC;
	Wed, 12 Jul 2023 17:13:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5963010E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmhe0d3LCsHeZND3K2iBAwDZm/8PzFVfKgsA9JcCutlss+t3iCDKkWwKA4QQRHpskUJvrtQvbBaW2aA2NpHGKgrZhpfsfCsK9tae4U5S7bPSLUhZ1jnRSqMayPzzS5d09q2iS75LEvcNv2Ypuv0m1KV1Elu9I+lpFmHh5trv+Nv2gV9H7CS3XXgtbyj3fijHNws92yJRNExUaeexDlHlwClZbeXNP0j69axs7GEboYlMc9f1RSskMQ6k5s9y7ZUqRojAgu/I+wXzDGy9vfsgYiOLNhTfZoqihtLi/CrmmJq2A/H1Fi+CdwSpeZizyLzDB/usPr4e9ooK/dtQpEGxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6qF30uJe38BjnYXRuhySaFhm/0Z1ZsMPLP4Mq2Zwb4=;
 b=ErzU3vgVVVdySqqx8416t2hBNZLfktgBoMxXDMRgB9GOVAxenQT1nrwAf/a4M4WoJuiz4TSxzBo9w5sRMmHWHB4gnTKLUWKst4gywu0koyQtzQuHGcniM8cPrcNVX6tMeaZ8fdLV1jksBFKZ/pGwr48+PVeQl1pGJqoJtInsStjnD0mKzZsVJUXDKb7i++BW0gs3EYv466a4Dqs+ARl9ditzfEQwz2kkJVIcg5EzBEQaJpeT8yBkX8tHmeKCmareIR96dvhK+ohjaDT1FmZG31k//cHzCMO+3tkykYrolBZpaHmFqyfd5o7HnVfnRsQv+GPyzA6DTV47e2HjBAi2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6qF30uJe38BjnYXRuhySaFhm/0Z1ZsMPLP4Mq2Zwb4=;
 b=oAW3zqv9sJ2ZQ3EtENt19VbzALWfDTaqoCYTEE2uaSXCNUB2+iCWd1rwsCuPps7i9JKmmum+moBsRlraT47o8k2SU3TE4vPDheCX/M15C+jGEqN3988DN665wbHo1XWoW1dv5rtlotRiZ+s/brff/8FyWP6WDprztckjBWba1ic=
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Wed, 12 Jul
 2023 17:13:18 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::da) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:13:17 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:13 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/33] drm/amd/display: Update scaler recout data for visual
 confirm
Date: Thu, 13 Jul 2023 01:11:16 +0800
Message-ID: <20230712171137.3398344-13-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: c6587b98-fa51-463c-5ace-08db82fb4952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/5+hFKopIyCJsJ7IKWMp1Rc7WYN6SF0tRUlvTy/VkOqgBjF2zhKf33xVRqHFctTnbIHwTwJSnMcSCLQpm53Zuy5EYaomZLvRqjiSArFdOinQ++lqdnJE4xsgv7q66u//FY/+uZW2wnwuJvbp/M51tEk9XmDPQ/+dtxFUZo2Kn/Mr0EEKeKNEkkqjsvSmgJhrprJ+z6J6x8klBw+aCjPfkhJqXis1pbtmmwdKbTF8ExxroFFddSIXYVbxUdHkB5f72CO7Q48d1K18sC1RpZrhHNCcphG53cQs4m05UGnmKWVCBbhtrXGZbXoyR0YAugUYJ0mWte1ErmnO8AwcwR9iX4zTySDI27IBrm+eaSDSIbRv1Jrwy2oZt1fe4UnI2rte9AkSpyvc96NN32AE6x+UKUntJKIuSfa78h8jHEi8LD13YxSjQq/2Cyy8famMPOWWph1WAPV9qug9o1bo18E/nPtRs9I2YGwUDfHoUV5kv0lksH3RWaCD2EAlXxjEedNE3HhyMaHER4l30bKjwIQ8AbUsyIrim3mpDVR8UuEBDEzHeqHYoG6JCT6+kprgAYHiFU3SzqZHMLA/egkTRCx9iFHbUuhKKC/kC3ZPEAOZhYAb+dkTzS8bVo8MWsy1twn43sGxZinJgC533b25QLwRmjU6D73BD+UDqMa8WwuvDKW4yBDOjQFQ+cXLxUHhciQvM1dvh/U7mVU/B2FxO5aoPjsvWX1AFH7Z1SVbf9Ih0hi6CkcQtNyASTL53mwLODyGx8ZsfzbwmD06U8vUosKmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(316002)(41300700001)(8936002)(8676002)(478600001)(54906003)(7696005)(70586007)(6916009)(70206006)(4326008)(36860700001)(83380400001)(1076003)(426003)(336012)(47076005)(82740400003)(356005)(81166007)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(26005)(5660300002)(2616005)(2906002)(15650500001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:18.1124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6587b98-fa51-463c-5ace-08db82fb4952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Ma <hanghong.ma@amd.com>

[Why]
Visual confirm color is not as expected for Autoa Color Management
feature test.

[How]
Calculate scaler recout data when visual confirm enabled to update
the visual confirm bar on the display.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 22 +++++++++++++++++++
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 18 +--------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index de3b891cba51..2d8a8c8ff47d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4304,7 +4304,8 @@ static bool full_update_required(struct dc_surface_update *srf_updates,
 				srf_updates[i].in_transfer_func ||
 				srf_updates[i].func_shaper ||
 				srf_updates[i].lut3d_func ||
-				srf_updates[i].blend_tf))
+				srf_updates[i].blend_tf ||
+				srf_updates[i].surface->force_full_update))
 			return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2f3d9a698486..1859350dffc6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -69,6 +69,9 @@
 #include "../dcn32/dcn32_resource.h"
 #include "../dcn321/dcn321_resource.h"
 
+#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
+#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
+#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
 
 #define DC_LOGGER_INIT(logger)
 
@@ -808,6 +811,8 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	struct rect surf_clip = plane_state->clip_rect;
 	bool split_tb = stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
 	int split_count, split_idx;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
 
 	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
 	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
@@ -876,6 +881,23 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 				data->recout.width = data->h_active - data->recout.x;
 		}
 	}
+
+	/* Check bounds to ensure the VC bar height was set to a sane value */
+	if (dpp != NULL) {
+		if ((dpp->ctx->dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_RECT_HEIGHT_MIN) &&
+			(dpp->ctx->dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_RECT_HEIGHT_MAX)) {
+			visual_confirm_rect_height = dpp->ctx->dc->debug.visual_confirm_rect_height;
+		}
+
+		if (dpp->ctx->dc->debug.visual_confirm !=
+		    VISUAL_CONFIRM_DISABLE)
+			data->recout.height = data->recout.height -
+				2 * ((pipe_ctx->prev_odm_pipe ||
+				      (pipe_ctx->top_pipe &&
+				      pipe_ctx->top_pipe->plane_state ==
+				      pipe_ctx->plane_state)) +
+				     visual_confirm_rect_height);
+	}
 }
 
 static void calculate_scaling_ratios(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index b33955928bd0..7e140c35a0ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -39,9 +39,6 @@
 #define BLACK_OFFSET_RGB_Y 0x0
 #define BLACK_OFFSET_CBCR  0x8000
 
-#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
-#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
-#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
 
 #define REG(reg)\
 	dpp->tf_regs->reg
@@ -591,18 +588,6 @@ static void dpp1_dscl_set_manual_ratio_init(
 static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
 				 const struct rect *recout)
 {
-	int visual_confirm_on = 0;
-	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
-
-	if (dpp->base.ctx->dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE)
-		visual_confirm_on = 1;
-
-	/* Check bounds to ensure the VC bar height was set to a sane value */
-	if ((dpp->base.ctx->dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_RECT_HEIGHT_MIN) &&
-			(dpp->base.ctx->dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_RECT_HEIGHT_MAX)) {
-		visual_confirm_rect_height = dpp->base.ctx->dc->debug.visual_confirm_rect_height;
-	}
-
 	REG_SET_2(RECOUT_START, 0,
 		  /* First pixel of RECOUT in the active OTG area */
 		  RECOUT_START_X, recout->x,
@@ -613,8 +598,7 @@ static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
 		  /* Number of RECOUT horizontal pixels */
 		  RECOUT_WIDTH, recout->width,
 		  /* Number of RECOUT vertical lines */
-		  RECOUT_HEIGHT, recout->height
-			 - visual_confirm_on * 2 * (dpp->base.inst + visual_confirm_rect_height));
+		  RECOUT_HEIGHT, recout->height);
 }
 
 /**
-- 
2.34.1

