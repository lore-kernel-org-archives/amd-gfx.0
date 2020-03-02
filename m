Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780FC3F2D7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C5C21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VuCmuexA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C5C21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2104B6E5C3;
	Mon,  2 Mar 2020 16:47:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426BB6E5BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYjIQ9gz4sPj9cfStF8Gi8BtN+wJFtRlCBRuaOxhc5I7lDAyvwUETWHsmyQdLnmi7ZF9i0W8VBueEXe6llvq0rbSNcNNq+STzzJLADU/00L61X2yh9PjaXIlB+1LnnzzRIX7LMAOtAl9ZbXuo+8+E0BEYe4xL115ejgfEmxixEIV4WFBp+jaEk+JeeGDhn3ndCR/niRsxzNt/34TYd5MdzxyiupQ0ANMw/qCbAeNjaFy1s0sYDOM8U/xg3GCW3k/M9KoqMKWF9dbS+SiRATm6NuW1DPUv9q1WyN9Pj8gVJ1gjMCFPjCGQSxd7Dk9kKPkl7wH9m3miWn/nv9yzJ7FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03BaWyzgCRA+bDMHwUaCEU4WXv3jJCqAQ5zu5LE9nT0=;
 b=Brazeeo5+xYSlBYzdhWPvX92r/zri160tbe3Df4M7/KFZzqQUMG4idtMNW1oDK6c6KwCG+LL4dpNlI58lsHEDuC/58uXjyUPYpc7bQR4PFId9drqjqtTUJiYQeb82rTzdOIvSOiCR+BHKeXla55ATeSTFZ+pi8N8dB5vBoDouiBCqTV2XBXdA6FYKLagvy1yC21d3WI3y6EhCai/2/abboCm5bI4FI8wL/B1lFpbFmucQZHqPRqSWNBX8kRGugbBJASw0Bt9xRu7x++1sf5N39BhQanyIi5z/6nd2PvE+i9zzCee9Dg8zmGTSJ059qNpSp/b/1GvcmQqVPLLEnqSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03BaWyzgCRA+bDMHwUaCEU4WXv3jJCqAQ5zu5LE9nT0=;
 b=VuCmuexAGJ1UwBx40NBMbzb8qoaTxRD2+s+AVkMK4uYLxuLsVRnq6MelAfpUoIW4zvft/8POuvqIKEu7xl49vFAORaa6X5SYMlSzVicHgeh+HzdSfxlUfc3PJRP+YSckKXQVXcEJ1GtOIFwcgzYXrLtRHvxeLaT4fTaVkM0ed90=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:47:54 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/22] drm/amd/display: add worst case dcc meta pitch to fake
 plane
Date: Mon,  2 Mar 2020 11:47:19 -0500
Message-Id: <20200302164736.89429-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 185789f0-7865-4269-1a43-08d7bec973fd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25409D69AF2F0059FE75C91D98E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lj5LRmTewiROi8osUf7AMP1scZHw+OrSxV6p1dp7RE3lPCj672Sq0aFatvJK06a7J5ctGKa98MpsgxJTJwl0j0UUfeheKd6b+mEfVK6HKwcDoRCt8YpFfsvUPaz5ivTOuxPifdg/pt8tpzd3ZzDNyGHHH36yNkv+GXDHD/Q2HOFmMgGuZMEWjakVbadukTN0HE+GoZmFXq9Cu81tR/Q+6yckPWuXFuTIar9p6pT2n6IzqqAyoSE4Trt4NLFoqzMwxaZBe+o74eG1zacd4mhBfnfIU7l3Vft2pniPktlkuyAJpC87YW39YM2sTiIAF4vmhZIB5JoXqlzNUhE5C9lNNwCtEfpMPwelQBu0Dv3HTUOMblMMiHfbciGIjaDk+vHcblodWzMdiyFUtZ44ZMdYc7HXLVatykbRSC3HtZzzQ8nLVJnDiDCFtLAx/3Gvo9mg
X-MS-Exchange-AntiSpam-MessageData: 4yswgfvgXn80iJCMCseAjhYxysYZRRPXj2qGXiAjon9lqabgKtMtP+y5zntVZFplCHAc175HqcdY3QWOl1H1WMvC6dOhEHzlCeVsYeDjNQFxF4ClwrylEyiSAyMpgIueci8ZZr9By1PM+xCs+8ByIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185789f0-7865-4269-1a43-08d7bec973fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:54.2734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ8FFe9eBuPLWfHYApu50jQfQgoFNvU662PhpdB136DFjVb/7yt7UpcLQueutfXrL9WF4bgjurKT2aydOm19zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Joseph Gravenor <joseph.gravenor@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joseph Gravenor <joseph.gravenor@amd.com>

[why]
When we have single channel memory, we can not light up 2 4k displays
with a 1080p edp, because we don't have enough bw by a small margin.
this small margin comes from dcc meta being too large. We however don't
have this dcc meta when we create fake planes so, before the flip we
will not filter out the mode for 2 4k displays with a 1080p edp

[how]
Change get_default_swizzle_mode to something more general so we don't
end up with a separate function for every missing field in the fake
plane. Add a reasonable dcc meta to the fake plane when it is filled in,
so we filter out modes that don't have enough bandwidth. To do this, we
take the screen width and align it to 1024(8k 60)

Signed-off-by: Joseph Gravenor <joseph.gravenor@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |  4 ++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c |  4 ++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c |  4 ++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 6 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 572ce3842535..3a1a5aef524d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2171,10 +2171,10 @@ enum dc_status dc_validate_global_state(
 			if (pipe_ctx->stream != stream)
 				continue;
 
-			if (dc->res_pool->funcs->get_default_swizzle_mode &&
+			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
 					pipe_ctx->plane_state->tiling_info.gfx9.swizzle == DC_SW_UNKNOWN) {
-				result = dc->res_pool->funcs->get_default_swizzle_mode(pipe_ctx->plane_state);
+				result = dc->res_pool->funcs->patch_unknown_plane_state(pipe_ctx->plane_state);
 				if (result != DC_OK)
 					return result;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 3b71898e859e..95fda0b7523e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1233,7 +1233,7 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 	return DC_OK;
 }
 
-static enum dc_status dcn10_get_default_swizzle_mode(struct dc_plane_state *plane_state)
+static enum dc_status dcn10_patch_unknown_plane_state(struct dc_plane_state *plane_state)
 {
 	enum dc_status result = DC_OK;
 
@@ -1295,7 +1295,7 @@ static const struct resource_funcs dcn10_res_pool_funcs = {
 	.validate_plane = dcn10_validate_plane,
 	.validate_global = dcn10_validate_global,
 	.add_stream_to_ctx = dcn10_add_stream_to_ctx,
-	.get_default_swizzle_mode = dcn10_get_default_swizzle_mode,
+	.patch_unknown_plane_state = dcn10_patch_unknown_plane_state,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 34483853e889..8a81ae562f6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3027,7 +3027,7 @@ static struct dc_cap_funcs cap_funcs = {
 };
 
 
-enum dc_status dcn20_get_default_swizzle_mode(struct dc_plane_state *plane_state)
+enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_state)
 {
 	enum dc_status result = DC_OK;
 
@@ -3053,7 +3053,7 @@ static struct resource_funcs dcn20_res_pool_funcs = {
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
-	.get_default_swizzle_mode = dcn20_get_default_swizzle_mode,
+	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
 	.populate_dml_pipes = dcn20_populate_dml_pipes_from_context,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index f5893840b79b..5eadca0ae7ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -159,7 +159,7 @@ enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state
 enum dc_status dcn20_add_stream_to_ctx(struct dc *dc, struct dc_state *new_ctx, struct dc_stream_state *dc_stream);
 enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc, struct dc_state *dc_ctx, struct dc_stream_state *dc_stream);
 enum dc_status dcn20_remove_stream_from_ctx(struct dc *dc, struct dc_state *new_ctx, struct dc_stream_state *dc_stream);
-enum dc_status dcn20_get_default_swizzle_mode(struct dc_plane_state *plane_state);
+enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_state);
 
 void dcn20_patch_bounding_box(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index de9047dd811d..cae3f49416b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1730,6 +1730,19 @@ static int dcn21_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
+enum dc_status dcn21_patch_unknown_plane_state(struct dc_plane_state *plane_state)
+{
+	enum dc_status result = DC_OK;
+
+	if (plane_state->ctx->dc->debug.disable_dcc == DCC_ENABLE) {
+		plane_state->dcc.enable = 1;
+		/* align to our worst case block width */
+		plane_state->dcc.meta_pitch = ((plane_state->src_rect.width + 1023) / 1024) * 1024;
+	}
+	result = dcn20_patch_unknown_plane_state(plane_state);
+	return result;
+}
+
 static struct resource_funcs dcn21_res_pool_funcs = {
 	.destroy = dcn21_destroy_resource_pool,
 	.link_enc_create = dcn21_link_encoder_create,
@@ -1739,7 +1752,7 @@ static struct resource_funcs dcn21_res_pool_funcs = {
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
-	.get_default_swizzle_mode = dcn20_get_default_swizzle_mode,
+	.patch_unknown_plane_state = dcn21_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.update_bw_bounding_box = update_bw_bounding_box
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f285b76888fb..d523fc9547e7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -124,7 +124,7 @@ struct resource_funcs {
 				struct dc *dc,
 				struct dc_state *new_ctx,
 				struct dc_stream_state *stream);
-	enum dc_status (*get_default_swizzle_mode)(
+	enum dc_status (*patch_unknown_plane_state)(
 			struct dc_plane_state *plane_state);
 
 	struct stream_encoder *(*find_first_free_match_stream_enc_for_link)(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
