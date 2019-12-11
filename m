Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E97FC2D0C8
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AB72077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2bptd48h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AB72077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CF96EB86;
	Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FC96EB86
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwbbCmIePLSZhq9pzbr+bhaqiKAj+QeJTbhRY+GUX+WSgXKvZzUPJNvFasu1c7iVAblArtu4TX7qVCeTEDgZuUXM8/4dSQF+ua2aNuhvPYJ2gVlMHHZtSmdU2jeDatjsioVB+P4md19njDs4RSyq+Yn2kIvIwQBTyj56PF0twDE2L5TnRBg8ImcNSfgubXhv1h1n2lU7ANWwA0iMkVie0+qhokobe2OvHnuKxiefYnvzWbu1S/yBxzRY5MI3sbnfa6gOl/FV6VeJvC68cGldeOf1DFfP3n5Ri597WfT8nlhUzQuft4v6cX7kS2oq9ezZp/0drP+7NOVaV+GTU9lK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6uwxrtEnQBWSg2YhZHOM5L52OYA6CVrTSYlFlxP5eM=;
 b=XdvEUm9u6JgnlHHr5gZS7bQIsfTz7+kK+nXGt/cbRMG56XQ9qqqkOrS4EArodX59S/FwpijdT3ZqRWZ7GQsmwiR2P2EOVUv3TqX8bRu7V9qseaDAFa5OFIgDkabGCSCqcOQrQpn7dE6+F1zCoS+/nRugSFlYiEiaPPkeVweFvSq6hy/CZk6ITHQMUc4ueO0m/qjxayLxmmMlpRuuRGXKQZgxnAXTgCtoZCjKQoyLku7dPF8UNUvPMuvlwIqNBXL330YT8tAWCANlNZD6pKNdmR8odrXMfU+++Te4vpKh3PTjwgQwCN8b2nrgQgfXx+cgqnusf8b/pXmyr3Oj7jiLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6uwxrtEnQBWSg2YhZHOM5L52OYA6CVrTSYlFlxP5eM=;
 b=2bptd48hdoKCi36fHEGTGqA3rUXGSSpEnPPAqyI2ITavUuP8VPAEbcC9aKMRwOM66J4XwOjRMRKE913r/LaDbMKZ4fIrMj1Sa3GsDjbzuyxY21szvb7Zf7ELki1iqPjP620spl/K5TlSh4rCZmbGObb2K2OBBfhPekp06ebha1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:31 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/39] drm/amd/display: Remove integer scaling code from DC
 and fix cursor
Date: Wed, 11 Dec 2019 10:32:30 -0500
Message-Id: <20191211153253.2291112-17-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95ebcc7d-b0e9-41ba-01b8-08d77e4f79dc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB249191624E5187A9D455DA4A985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
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
X-Microsoft-Antispam-Message-Info: 6hU2drt2Is+5BhMi3fwIUT1eqnvLU/p1dV2DlB1ytworlxnh08TUkTILxPrtrWa9i2ED9tc/MQ/pfdSWLJvA6aB06gusb/6VbcbRkx5kQX7X/trsk5BYj3MCOAaZ7OuMVKAd6pyqgl+sfGhskPJ9PX30bclTk+Y/E0PrOOhwC0W1kYoLl/kwD0h54YWB01isFWvmzWE5+jybr9m/lkLZUmW+3cXNgXMCakQk/iy35FEf75huvD/KDmTxRQ/mvWszjfoPNxClskSuGU81Kw/bjJAsd0IRUWrnzo+mgOfBBAlv73oaekZ961D4gJubjKY3N+8jaIrcypC9vHeCbu3IYC8DAjd9jZBB2NAtfe8Hq+8nrRWMjJEByMxV0wTB4bUfcFeOG8AhFrOGimwvKKHV6FL/BgWxggZLdmXe3UsPwEqg/BYYndpCnf2GwTmH5VHk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ebcc7d-b0e9-41ba-01b8-08d77e4f79dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:31.0121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIaMaOlDflI6VAIkWSGKsFImpSXeLT9bmy/ycU1s0i3vJh7gdvg1Z7BbaUphUUMnRVK61rLJeBf0so3OLiRr3Q==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Scaling better handled by upper layers before pipe splitting.

[How]
Remove DC code for integer scaling and force cursor update if
viewport or scaling changes occur to prevent underflow from
invalid cursor position.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 44 -------------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  3 +-
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 594731182641..51e0f4472dbd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -940,48 +940,6 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 
 }
 
-static bool is_downscaled(const struct rect *src_rect, const struct rect *dst_rect)
-{
-        if (src_rect->width > dst_rect->width || src_rect->height > dst_rect->height)
-		return true;
-	return false;
-}
-
-static bool is_mpo(int layer_index)
-{
-	if (layer_index > 0)
-		return true;
-	return false;
-}
-
-static void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
-{
-	unsigned int integer_multiple = 1;
-
-	if (pipe_ctx->plane_state->scaling_quality.integer_scaling &&
-	    !is_downscaled(&pipe_ctx->plane_state->src_rect, &pipe_ctx->plane_state->dst_rect) &&
-	    !is_mpo(pipe_ctx->plane_state->layer_index)) {
-		// calculate maximum # of replication of src onto addressable
-		integer_multiple = min(
-				pipe_ctx->stream->timing.h_addressable / pipe_ctx->stream->src.width,
-				pipe_ctx->stream->timing.v_addressable  / pipe_ctx->stream->src.height);
-
-		//scale dst
-		pipe_ctx->stream->dst.width  = integer_multiple * pipe_ctx->stream->src.width;
-		pipe_ctx->stream->dst.height = integer_multiple * pipe_ctx->stream->src.height;
-
-		//center dst onto addressable
-		pipe_ctx->stream->dst.x = (pipe_ctx->stream->timing.h_addressable - pipe_ctx->stream->dst.width)/2;
-		pipe_ctx->stream->dst.y = (pipe_ctx->stream->timing.v_addressable - pipe_ctx->stream->dst.height)/2;
-
-		//We are guaranteed that we are scaling in integer ratio
-		pipe_ctx->plane_state->scaling_quality.v_taps = 1;
-		pipe_ctx->plane_state->scaling_quality.h_taps = 1;
-		pipe_ctx->plane_state->scaling_quality.v_taps_c = 1;
-		pipe_ctx->plane_state->scaling_quality.h_taps_c = 1;
-	}
-}
-
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
@@ -995,8 +953,6 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	pipe_ctx->plane_res.scl_data.format = convert_pixel_format_to_dalsurface(
 			pipe_ctx->plane_state->format);
 
-	calculate_integer_scaling(pipe_ctx);
-
 	calculate_scaling_ratios(pipe_ctx);
 
 	calculate_viewport(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 8d779062a4e8..e1e274018049 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1394,7 +1394,8 @@ static void dcn20_update_dchubp_dpp(
 	}
 
 	/* Any updates are handled in dc interface, just need to apply existing for plane enable */
-	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed)
+	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
+			pipe_ctx->update_flags.bits.scaler || pipe_ctx->update_flags.bits.viewport)
 			&& pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
 		dc->hwss.set_cursor_position(pipe_ctx);
 		dc->hwss.set_cursor_attribute(pipe_ctx);
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
