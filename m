Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCEAC2D0C7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D352173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RNDeDyPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D352173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2782F6EB93;
	Wed, 11 Dec 2019 15:33:47 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C00C6EB84
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrxkkLA+EwOG4mOM69jHXANdgrzJEX/TroUj9qOafIrG7r99bvhq32VB7mP25hlnV4IxHn3zv2JtAhantbkeIGfpM0c8L4ilsxkzfM8T4xWpT6zKD/Uh5LKEYSVPLcBamYPa2liW4rxYH4b/1ERxk19LqAfjUk4rA15xSItEc4fr1Q87ZpfdAa0oj7lGy76R07uChFmcdDFbiVuSgZoqrGDyuxnNIhEi5bI2BMHoJFPtXulP52n5ycEM5F5YNmhq5fU3GUqOFs0v6aCP4NGoiRgruVa5MoUKZ+1uZsEy0KmtUscqAkBEX3zjOqcGgTqdcg+LAOwzKxc1Gbfb4GfCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvml0RsTyX53AgWPHhFVTO88pc90Dmv39xDNjZU3R0k=;
 b=d/ArGbLtrI58ppNTQqHHFDP3PCiH/AJLkTnOaMohlGoIPxF/rjp5r3YnBA3NN7sXHlSY1XdArLz8bBG3yh9WdoFeQegFZuABOmK+P5uYfTKRiukFrLfe3dT2aPYcx/L37XsKeL4Q0u9yqjLIaDNCEk81d1DkD3cOrcdznrmK807mkw76rtWWGpaAw9KPAdETXJzDE5YT5IQ70IRzkVVYIRvbeTmSETfC1gwMswV2AdSDFXVe7ZHz8ZkdutuATrOBpvNgI/IEdcA0isHAUVI3ym9mXitT1geXE4jCFNmYEtC7wzPZOe/aPV4/nr3M6owZjVBgIduyLJhKO7f0GqAekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvml0RsTyX53AgWPHhFVTO88pc90Dmv39xDNjZU3R0k=;
 b=RNDeDyPCSXUasSW69Rvxet+JJ5vxsSl5RUaSfiQplNvkue/hSm0B1talSX+cuegmn+PDv3ZKokb4FyoCKQmTTLhvtyiEeTm8alhFsnmrnX9GYFFUeNM94+YcLvlLFIAwH5zuaoh+9xjDUeBTkcFsiQGRLrG4+M2CSEBNH7G9Gls=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:41 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/39] drm/amd/display: fix 270 degree rotation for mixed-SLS
 mode
Date: Wed, 11 Dec 2019 10:32:42 -0500
Message-Id: <20191211153253.2291112-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ea93ad1-516b-4392-2f02-08d77e4f801e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24915F6758F7EC2F1ADFFB69985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZPaDfBDQm/Jq3lpxfYGDQnZjpdlF2zItjXN9eXh4nkSdBadd34mbyDS12EEs7MTw82AgwcsTIdjFj6BvgozG4kxEegF9+7bHS/wUWx8j/EN6+rUhmlgNleay7WcZvPaM8KxBS0AYHxRKCkTqKTuO47QPX4AeUN44kmCkbgj2v8dLnQxP54G82ybjuPTZjFbA1gE3q4JTqaDIM7LY8RPgOakzLUx52RRtwLH8iHnSuGZ0qfwElrjUcG0o9mSAD1DZUBHkRQq815X+2HRDbgRMngLfMZlsXeLvf8bFTnYKGnxB1X5Y/J9D6poOQoCjntngENE/iJrICZ8tdIzq6Lkw1FwYgJgOCmhHGoeVydruuSx5baZcWWxFquMwMMBMokqs992accXyhICmM70uTYe/OMc/A7YY5IW7m+FaZUBr4euRQjWeoIaJq1SV/Mu4n+p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea93ad1-516b-4392-2f02-08d77e4f801e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:41.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP+UTdxHwZ+pahMMZU8No0SG0Ys0QnbYQLMOvHphHmtML9cWyxIk48urwC78egy8PYCzoejAzzmpio2H4UB/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, Samson Tam <Samson.Tam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
When we rotate 270 in mixed SLS mode, the recouts occupy the
right side of the display.  So all the recout_skip_v values
are relative to the left side of the display.  This causes
adjust_vp_and_init_for_seamless_clip() to incorrectly increase
the data->viewport.height for that recout.  The rotation looks
like the bottom half is duplicated twice.

[How]
recout.x values are being adjusted based on
stream->timing.h_border_left.  Instead of using h_border_left,
use dst.x to represent the border.  Shift dst.x by the amount of
stream->timing.h_border_left and set
stream->timing.h_border_left to 0.  Do all the calculations
and then revert stream->timing.h_border_left and
stream->dst.x back to their original values.
When calculating pipe_ctx->plane_res.scl_data.h_active,
make sure to use the original stream->timing.h_border_left
value.

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 57 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 51e0f4472dbd..64a0e08fd019 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -940,11 +940,51 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 
 }
 
+/*
+ * When handling 270 rotation in mixed SLS mode, we have
+ * stream->timing.h_border_left that is non zero.  If we are doing
+ * pipe-splitting, this h_border_left value gets added to recout.x and when it
+ * calls calculate_inits_and_adj_vp() and
+ * adjust_vp_and_init_for_seamless_clip(), it can cause viewport.height for a
+ * pipe to be incorrect.
+ *
+ * To fix this, instead of using stream->timing.h_border_left, we can use
+ * stream->dst.x to represent the border instead.  So we will set h_border_left
+ * to 0 and shift the appropriate amount in stream->dst.x.  We will then
+ * perform all calculations in resource_build_scaling_params() based on this
+ * and then restore the h_border_left and stream->dst.x to their original
+ * values.
+ *
+ * shift_border_left_to_dst() will shift the amount of h_border_left to
+ * stream->dst.x and set h_border_left to 0.  restore_border_left_from_dst()
+ * will restore h_border_left and stream->dst.x back to their original values
+ * We also need to make sure pipe_ctx->plane_res.scl_data.h_active uses the
+ * original h_border_left value in its calculation.
+ */
+int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
+{
+	int store_h_border_left = pipe_ctx->stream->timing.h_border_left;
+
+	if (store_h_border_left) {
+		pipe_ctx->stream->timing.h_border_left = 0;
+		pipe_ctx->stream->dst.x += store_h_border_left;
+	}
+	return store_h_border_left;
+}
+
+void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
+                                  int store_h_border_left)
+{
+	pipe_ctx->stream->dst.x -= store_h_border_left;
+	pipe_ctx->stream->timing.h_border_left = store_h_border_left;
+}
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	bool res = false;
+	int store_h_border_left = shift_border_left_to_dst(pipe_ctx);
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	/* Important: scaling ratio calculation requires pixel format,
 	 * lb depth calculation requires recout and taps require scaling ratios.
@@ -957,8 +997,14 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 
 	calculate_viewport(pipe_ctx);
 
-	if (pipe_ctx->plane_res.scl_data.viewport.height < 16 || pipe_ctx->plane_res.scl_data.viewport.width < 16)
+	if (pipe_ctx->plane_res.scl_data.viewport.height < 16 ||
+		pipe_ctx->plane_res.scl_data.viewport.width < 16) {
+		if (store_h_border_left) {
+			restore_border_left_from_dst(pipe_ctx,
+				store_h_border_left);
+		}
 		return false;
+	}
 
 	calculate_recout(pipe_ctx);
 
@@ -971,8 +1017,10 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	pipe_ctx->plane_res.scl_data.recout.x += timing->h_border_left;
 	pipe_ctx->plane_res.scl_data.recout.y += timing->v_border_top;
 
-	pipe_ctx->plane_res.scl_data.h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
-	pipe_ctx->plane_res.scl_data.v_active = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
+	pipe_ctx->plane_res.scl_data.h_active = timing->h_addressable +
+		store_h_border_left + timing->h_border_right;
+	pipe_ctx->plane_res.scl_data.v_active = timing->v_addressable +
+		timing->v_border_top + timing->v_border_bottom;
 
 	/* Taps calculations */
 	if (pipe_ctx->plane_res.xfm != NULL)
@@ -1019,6 +1067,9 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 				plane_state->dst_rect.x,
 				plane_state->dst_rect.y);
 
+	if (store_h_border_left)
+		restore_border_left_from_dst(pipe_ctx, store_h_border_left);
+
 	return res;
 }
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
