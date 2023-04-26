Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85330C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B22810E530;
	Wed, 26 Apr 2023 16:28:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9F310E46E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1D0t69qaQlpvhWwi2RyZGx5eyEKABwK6+842FZBO2e5Dl6yEnlTxJlwWGF7Y+HNAMmg+9p8PqtTmDGzRH81DNDrax+5tRDSGWK/OYnoVybwJ/TTZ4gFFx8VzDnuw+CSWVW0sbymJpeCcbgxJYV8XAXMk70V7mO6yCkOQ148JpuFPXtNhZIKnzBncZSiIWv/UBQ1WhPM8Jfn2SZ4fDlAxMYDpsCco7kbyTCFPVbUa26Bz+c+WIyPCsYjIeXBHjwgeWDoiXIxXczEL9U4q7/5MHZhQmYk87aq/s8ny9s8TG/R4Gj/Yh+vpTcpt3Lg6lYJokq3JHrtN0X/kpS02fIWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuJJ/SOK8AyeM1pNqubtWHoJcBAizLly7qN+8/+Jgk8=;
 b=J7zu2nGyQj1R3K/1DA6PZ9YnX+jP/iSfhBOz5rOjY3jjiGghxESCdNwjDfu2C49S0GhoECRB0tcNkdNLVC7ByaLYqf5Wlv9trOA4lcodZ0cIWMtwzlKdXLZlJn4t2taON1GMgzEzI3B/QysrTmaoMLRZQjZ58LMSKydLr7oux9ngyGmIOQ1mhPRKyjs4dw103qLGuvBuxS36l9uTUik/Qo1G0YgeBYKlp6kTQboiV4TcCKdGJ+zofiUOomJh4fbfqpCi4Auig5Y37Y3xxJB91pbbt3Syz9NfGPwRtVJziHMvRzIRWdEsjW8sqyNIPUiiXH+PiQfIsBPZjwtRkOlenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuJJ/SOK8AyeM1pNqubtWHoJcBAizLly7qN+8/+Jgk8=;
 b=doXurGLeiIw3zz9AJpGr6msEOi17xWCOE0mBpxHv/AgyrtYPRCKJDxTHQtJ+jlbKEyUfmfuQ2Vu8XUNWbhZ3k5JTBDBhUFltY0JOSrx8SqZOjACsPTFMonHL4q9cqagIrA/rt5jyeLq3riXnukhQt6Ev0Saf3Of7sVtWZPGfKek=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 26 Apr
 2023 16:28:07 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::4a) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 16:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 16:28:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:06 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:28:03 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd/display: revert "Update scaler recout data for
 visual confirm"
Date: Thu, 27 Apr 2023 00:27:09 +0800
Message-ID: <20230426162712.895717-6-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 38db0877-0bec-4cfa-ff63-08db467337ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8wrmKGjvhnBzd4Pn0l7RWqwOnwGiahTHVQbQSicV/ft02HcSc9IEWPH8Ii69BWJTmim0r/jsaNwr+btlvHi+MX3v04wapHEau4lv8f+/XOF7IptuP9icf0cnxH4IVYVZBg1Ke3OmenbH2QT9Pr2lshSIslDlxTqd7m/h+6xdJ1/bZTaJcwnhf9mOq2mNN+AveAvFft0SfQ6Os0+fZySF9XdP7GWP0/jZmsByeDX3nH2L0+FbI+W7/d6UI5MJJXVlONHcavkp0bRFoVjwqzMPYu3VbagxLPZluaBxEmLGNNMdd4+Pg09P6ibiFZ/UT2cXm1AitLsMKdllqpDpdPa7SzMM7zvKB5EMdAV0FRz4OeQxzcXPD6bnUXmo1s+rxm5bXWfooqrQdFdaSbNiki3cUkgrAzFM+WCg02yQSY71xi7UXsi6gbexxYbnO9zL39dG2tZ4s8TK1cVyh36tq5KZXUj3l6azeZGnRMVbC27ORUR879iEDTUMJUV6xAK6QGpD8brZBhO0qjqHdG5HLvZpqJkwJ5wSIWjVH5ttxxgy0qk+HMeAMZIk/KAuVvJFwYdHIB8jxqMe/1LUuZR8eltLhdhgbgY/FcwVRGHPLZ5Hr2sL8XzYFDJA1/9xcXz9vpTf+qXzTCyeTo5zyAtdTFRl/Cik133fa+6zRLVbUXfGptVlTcUrtXIrbWljFqhu3t1gPHwEhM6FaUXFSNY/qzQ3NXCvNjX8jQApQ9PhSIQnqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(478600001)(86362001)(36756003)(2616005)(36860700001)(426003)(336012)(40480700001)(83380400001)(40460700003)(82740400003)(7696005)(26005)(1076003)(186003)(70206006)(316002)(82310400005)(356005)(6916009)(2906002)(70586007)(8676002)(8936002)(5660300002)(4326008)(41300700001)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:28:07.5606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38db0877-0bec-4cfa-ff63-08db467337ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Ma <hanghong.ma@amd.com>

This reverts commit 8552024d1e2a008b6df544845d09120cfea9508b.

A regression is found on this change, so revert it for the time being
and resubmit when issue is fixed.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c  | 17 -----------------
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  | 18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 193e09b05f5a..7e1e5532f88f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -69,9 +69,6 @@
 #include "../dcn32/dcn32_resource.h"
 #include "../dcn321/dcn321_resource.h"
 
-#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
-#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
-#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
 
 #define DC_LOGGER_INIT(logger)
 
@@ -811,8 +808,6 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	struct rect surf_clip = plane_state->clip_rect;
 	bool split_tb = stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
 	int split_count, split_idx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
 
 	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
 	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
@@ -881,18 +876,6 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 				data->recout.width = data->h_active - data->recout.x;
 		}
 	}
-
-	/* Check bounds to ensure the VC bar height was set to a sane value */
-	if (dpp != NULL) {
-		if ((dpp->ctx->dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_RECT_HEIGHT_MIN) &&
-			(dpp->ctx->dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_RECT_HEIGHT_MAX)) {
-			visual_confirm_rect_height = dpp->ctx->dc->debug.visual_confirm_rect_height;
-		}
-
-		if (dpp->ctx->dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE)
-			data->recout.height = data->recout.height -
-					2 * (dpp->inst + visual_confirm_rect_height);
-	}
 }
 
 static void calculate_scaling_ratios(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 7e140c35a0ce..b33955928bd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -39,6 +39,9 @@
 #define BLACK_OFFSET_RGB_Y 0x0
 #define BLACK_OFFSET_CBCR  0x8000
 
+#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
+#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
+#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
 
 #define REG(reg)\
 	dpp->tf_regs->reg
@@ -588,6 +591,18 @@ static void dpp1_dscl_set_manual_ratio_init(
 static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
 				 const struct rect *recout)
 {
+	int visual_confirm_on = 0;
+	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
+
+	if (dpp->base.ctx->dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE)
+		visual_confirm_on = 1;
+
+	/* Check bounds to ensure the VC bar height was set to a sane value */
+	if ((dpp->base.ctx->dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_RECT_HEIGHT_MIN) &&
+			(dpp->base.ctx->dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_RECT_HEIGHT_MAX)) {
+		visual_confirm_rect_height = dpp->base.ctx->dc->debug.visual_confirm_rect_height;
+	}
+
 	REG_SET_2(RECOUT_START, 0,
 		  /* First pixel of RECOUT in the active OTG area */
 		  RECOUT_START_X, recout->x,
@@ -598,7 +613,8 @@ static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
 		  /* Number of RECOUT horizontal pixels */
 		  RECOUT_WIDTH, recout->width,
 		  /* Number of RECOUT vertical lines */
-		  RECOUT_HEIGHT, recout->height);
+		  RECOUT_HEIGHT, recout->height
+			 - visual_confirm_on * 2 * (dpp->base.inst + visual_confirm_rect_height));
 }
 
 /**
-- 
2.34.1

