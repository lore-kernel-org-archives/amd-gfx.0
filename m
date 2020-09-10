Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDDC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FA221D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gwbI9nlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FA221D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92AF6E953;
	Thu, 10 Sep 2020 13:48:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3D56E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6vah8eBS5ci7ZMrYn/9qynO/M7+qdxQrc/pKn0KqzCHe+tT3+KHwGtFfwpflyDg/cfPZ/+E5k7xyRCqh2kSiGm+FXowtgRO3nfrdGwbcB2bHglbI/FtOiQ/HGW2AwGO5M5Xlr9t8K9h+lC2tIsk3GRQbw4+LYFYIvdGbmq3290mnS+9JcaU0zPEMA+aSYJof0YeGSPKngk5vDvik9CY1+/n0C4KP1UxqL14sHPCWoF00CJ/S2bGSyWwJc8kGfK3E/NnDVfThW4pVxXTpQXoRQ7I+b8msDdziOOOhzcQ4cLV8iTbuEb/iaougH7UEawgvU2ivyomqu3Zhy1ZlgWmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxVhfnK1+wpWlmxY9XCEv26QqhdNJ+XoiZt4ornkrbk=;
 b=ju7WMsd9zKtBTnKTjeezHwl4MYq2Eu9y/N9/ISro5CjiX9Nhb8K4qh+979vUFCT+lyNEr1nREuy9Z7J6jwPO/hLtFZilPVBnVAIFv9dvTW0sQg2PHOiuPZOeV2ICmve3pTs1e1Qa4xyfRt4DcSSeo3oLkMOcyxV170rMfmE1rV3YhKfaCl+WMZTs84HYpxpKvxPmlTudLYx3o9SIunaO0Cdp9lwXaBlWxLdNSO1DC6FpMVJcdPJez+e8tAmeXgnd6lUPFtDLJKLKJOEEsKdO7/j1DHUwp52h8C2p7fRcqANPYmpTbjnybeyAjUns/vRZZzklBQe9dDmzhi33BlvYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxVhfnK1+wpWlmxY9XCEv26QqhdNJ+XoiZt4ornkrbk=;
 b=gwbI9nlr6uW92tTF5zBYE2yzqlYLYiKZ4gnVTlLopU13KddZoqMrOg/jv7nBuImgGdUUBI1HWtu51dQtPrQVhQd8ErDGAx7yqxlHtcrx5bGx1tfLP8/bbBrkr3152i3452ta0gDyKy89CC2Xg4UGyof+WuF9TAuSBW3XY8I4+P8=
Received: from BN4PR12CA0010.namprd12.prod.outlook.com (2603:10b6:403:2::20)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:15 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::57) by BN4PR12CA0010.outlook.office365.com
 (2603:10b6:403:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:14 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:14 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/42] drm/amd/display: remove dc context from transfer
 function
Date: Thu, 10 Sep 2020 09:47:17 -0400
Message-ID: <20200910134723.27410-37-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e8fb35-73f8-4b19-cbc5-08d855902a60
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:
X-Microsoft-Antispam-PRVS: <SN1PR12MB257441D766C0665E23CD709F8B270@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwUm57/CJm/Y0xv7REXPHWBUyV9rNiRp397SjS0GyQxzghkwpkmQQj9eWEeK+UcBshFoxh7kSYvbkBm9Cax8WRI8oBOmc5jAVQW3ZBfUZrSbwRXJZ2nfiPT+XviCh1tc0cmGo2x3usYSApvIQWt/mc1b0BIG06cToMBBVdrTJPkJq1V9jM0jKqY9IiFGSsJlYP08jgJj36aeGANR/hF+muwFzmQBXeKjwlfQp0hSMm1N0R+mRJm3jHAUxtSavAygeeLIYyDN/nr/wo3Hn0OlePwFUzAr64NVa+wcvECCq4+aQMO6LQA94wII0wR76XW8u0O7LPBTafqOexiDgLNrnaoojZsAYL8/MLrTYN2voz8jLzmMjYaZbQDrBKY4mzgCGv1bx1jonrTE6Aj4IggKzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(86362001)(1076003)(426003)(8676002)(82740400003)(356005)(36756003)(83380400001)(81166007)(54906003)(2906002)(47076004)(7696005)(316002)(336012)(4326008)(82310400003)(70206006)(70586007)(6916009)(2616005)(44832011)(26005)(5660300002)(8936002)(478600001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:14.7123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e8fb35-73f8-4b19-cbc5-08d855902a60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
The ctx field of dc_transfer_func is not always populated and therefore
isn't reliable.

[How]
Remove dc context from dc_transfer_func

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c        | 1 -
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c       | 7 +------
 drivers/gpu/drm/amd/display/dc/dc.h                    | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 4 ----
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 4 ----
 5 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6fef9078f3d1..d48fd87d3b95 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -123,7 +123,6 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 		return false;
 	}
 	stream->out_transfer_func->type = TF_TYPE_BYPASS;
-	stream->out_transfer_func->ctx = stream->ctx;
 
 	stream->stream_id = stream->ctx->dc_stream_id_count;
 	stream->ctx->dc_stream_id_count++;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index ea1229a3e2b2..3d7d27435f15 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -48,22 +48,17 @@ static void dc_plane_construct(struct dc_context *ctx, struct dc_plane_state *pl
 	plane_state->in_transfer_func = dc_create_transfer_func();
 	if (plane_state->in_transfer_func != NULL) {
 		plane_state->in_transfer_func->type = TF_TYPE_BYPASS;
-		plane_state->in_transfer_func->ctx = ctx;
 	}
 	plane_state->in_shaper_func = dc_create_transfer_func();
 	if (plane_state->in_shaper_func != NULL) {
 		plane_state->in_shaper_func->type = TF_TYPE_BYPASS;
-		plane_state->in_shaper_func->ctx = ctx;
 	}
 
 	plane_state->lut3d_func = dc_create_3dlut_func();
-	if (plane_state->lut3d_func != NULL) {
-		plane_state->lut3d_func->ctx = ctx;
-	}
+
 	plane_state->blend_tf = dc_create_transfer_func();
 	if (plane_state->blend_tf != NULL) {
 		plane_state->blend_tf->type = TF_TYPE_BYPASS;
-		plane_state->blend_tf->ctx = ctx;
 	}
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9d7d5dd9e820..d9b22d6a985a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -745,7 +745,6 @@ struct dc_transfer_func {
 	enum dc_transfer_func_predefined tf;
 	/* FP16 1.0 reference level in nits, default is 80 nits, only for PQ*/
 	uint32_t sdr_ref_white_level;
-	struct dc_context *ctx;
 	union {
 		struct pwl_params pwl;
 		struct dc_transfer_func_distributed_points tf_pts;
@@ -772,7 +771,6 @@ struct dc_3dlut {
 	struct tetrahedral_params lut_3d;
 	struct fixed31_32 hdr_multiplier;
 	union dc_3dlut_state state;
-	struct dc_context *ctx;
 };
 /*
  * This structure is filled in by dc_surface_get_status and contains
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 47a39eb9400b..7a00fe525dfb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -325,8 +325,6 @@ bool cm_helper_translate_curve_to_hw_format(
 	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
 		return false;
 
-	PERF_TRACE_CTX(output_tf->ctx);
-
 	corner_points = lut_params->corner_points;
 	rgb_resulted = lut_params->rgb_resulted;
 	hw_points = 0;
@@ -524,8 +522,6 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
 		return false;
 
-	PERF_TRACE_CTX(output_tf->ctx);
-
 	corner_points = lut_params->corner_points;
 	rgb_resulted = lut_params->rgb_resulted;
 	hw_points = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index a139a87a1a81..41a1d0e9b7e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -122,8 +122,6 @@ bool cm3_helper_translate_curve_to_hw_format(
 	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
 		return false;
 
-	PERF_TRACE_CTX(output_tf->ctx);
-
 	corner_points = lut_params->corner_points;
 	rgb_resulted = lut_params->rgb_resulted;
 	hw_points = 0;
@@ -314,8 +312,6 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
 		return false;
 
-	PERF_TRACE_CTX(output_tf->ctx);
-
 	corner_points = lut_params->corner_points;
 	rgb_resulted = lut_params->rgb_resulted;
 	hw_points = 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
