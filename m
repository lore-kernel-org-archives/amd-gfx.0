Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3D0C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4DA10ED56;
	Thu, 20 Apr 2023 23:50:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0325710ED53
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXTu6rSB3g0pPmOaMorpwrmxRaEq3qX2PtsvRhmr0RtGc8kb+ueeHtKicH3FgfR0J79G8W15iYu7ALdD3uVqu5uH782o5X/LOrLKFH23NQFzt66qLe0UpxZuOxynyGtbxnul8jpE2ajHEFskXtp7cCGtwjWpFhCjMs1LNgb1vu4kj0g2TQP6M/qsAjyMifjyXFHO8HQy+y3lvTIsVk3he5QQthnrPrGDWlmo+XXqtnd8g8Lcj02mDoPgaer8Xxqgmw0oqf8JNiLSIGrUlq9J3I1KwNMR0yhzL8v6BtQzTu7ufE1D2lrJZgmbXNCl1sdhncgoRou54PNOK2ymiRxICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq0A2GXOaqiIOCzXeX1OkPD/+fmdYyXmCwlZSpnnR6M=;
 b=ehK8zoJA7mpcYSTEtnA4BJ2DKryh9e27R53ZeYloKPLD5k9be1Ypwtap7cUCS3NAmlQ6OZWRY9Qy5ckJ6TIGqWx3xuUXA8hONuAjFha8AJHrPnNvhxV0qul4clIJDhm2x9ysz5CW+BN/PGr1ezxP3mmD843orTaThuh2tzb4hr7BTIfiEWfPpHExWzktddb2NnFeSHsvLG/9YDjbPda5jNHM/s0vdIgAqaxVf2AMvqZ+c2f3bZ2+0L6tioDwYWRZ9PNBCUrPLny9ZQgLy+Aoyqvmky4nxFjs4e5RpMQgcpo3QxXzNV4Xu0yWWzfvMmZbHjKxNhDx2EJbBm6atg8mjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq0A2GXOaqiIOCzXeX1OkPD/+fmdYyXmCwlZSpnnR6M=;
 b=lx3wj/KQ/S9t93jZs48F35E6fDDk6ZS3K/PknUiWkcU5DRDFzlN3uhU4G8h+57tVrLFxIzu7pIabQjaX86Rbb0DwKI8V3U+q54jGfxCUazbK5m+Kex3K0+gUVHfRGU7Ncqf5fwihWcM2qk46RmzWSQMD8n/kxd3HtRrz06gDsbc=
Received: from DS7PR03CA0355.namprd03.prod.outlook.com (2603:10b6:8:55::30) by
 PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:32 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::9b) by DS7PR03CA0355.outlook.office365.com
 (2603:10b6:8:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 23:50:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: Update scaler recout data for visual
 confirm
Date: Thu, 20 Apr 2023 17:49:43 -0600
Message-ID: <20230420234951.1772270-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b17e184-b582-4fbb-d8c4-08db41fa06d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naWMiv8i4vnZqMhD/+gTvyEYeRCCja6Icwr1ReC5b8hdxzNzxRBGvxkN0+oZzTmDJEcUYWr7ExJaAOCIeqJMTVqznIWFzdqRtHbUzA1mLc6LwMm6hXmhwPFX9ZGTYhwmpTXj/Roolc+GU27tkAlFBtlIQbKJrWO1TuBtAZYuXQTxW8dBwZeE9OFq0fqrF9kaL/j9SNldEk4cFBsU46e6WWi4TJEtP6ePHkWrgOrBgNEWYDgLD5eC5LDx+psM9HcS9M63U1sTX5vJvqI7CYb1h+bw2JoudF/xYls8vwWLgXSoDM2SKsgcAypZDjWgXU6bsAFYPZbcLMoPr379a84JmmTmsqpfrT4iYaCp1E5uuo8mFU2ZVWWC+XjmLRevUC47UsJ5GPs+d2pBeZG40dHJwGVWjzKxi8vuXhnDgwEuWVSe24arm4IQtPH9XaWFS9RHi+Gkroz0D3ttBgJsIFk2S9mE9EpMwB26w29G2W2bB/dlm5ifPWHskeCwoXhGcGbBKwofYdmGCrl4Ek7af/HzrgyU2u/9h3WGYSziAoVtEcz4heKdpHU1N3ngRYj+iVGRxZk0HvsPR2BeBV8UHT1HkW4qXP0Rhc9xXl9xX+cIhJtKF77RJJaRWKm/MwtOwJGplTgsb2DPUvKTQpti+b1Wdg0zj53dcGvTJ4gydVQj80uA2lTSXQXcsg3WtyD9vTi84CC8vCRxBEOP99HNnQQhP1CkavP+KuVOs7aLbRDPP1g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(81166007)(41300700001)(40460700003)(5660300002)(8676002)(2906002)(8936002)(15650500001)(36756003)(82310400005)(86362001)(40480700001)(6666004)(1076003)(26005)(54906003)(478600001)(2616005)(36860700001)(83380400001)(47076005)(336012)(426003)(186003)(16526019)(70586007)(82740400003)(70206006)(316002)(6916009)(4326008)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:31.4386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b17e184-b582-4fbb-d8c4-08db41fa06d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
Our QA found visual confirm color is not as expected for Auto
Color Management feature test after enable it.

[How]
Calculate scaler recout data when visual confirm enabled to update
the visual confirm bar on the display.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c  | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  | 18 +-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2f704e26219c..193e09b05f5a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -69,6 +69,10 @@
 #include "../dcn32/dcn32_resource.h"
 #include "../dcn321/dcn321_resource.h"
 
+#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
+#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
+#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
+
 #define DC_LOGGER_INIT(logger)
 
 enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
@@ -807,6 +811,8 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	struct rect surf_clip = plane_state->clip_rect;
 	bool split_tb = stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
 	int split_count, split_idx;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
 
 	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
 	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
@@ -875,6 +881,18 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
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
+		if (dpp->ctx->dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE)
+			data->recout.height = data->recout.height -
+					2 * (dpp->inst + visual_confirm_rect_height);
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
2.39.2

