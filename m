Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB825C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381AF10E4AE;
	Wed,  2 Aug 2023 06:52:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5442A10E4AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7pQWoshfm2Ski+cPoJmyvUggnzm9/sZth65nwfDcbJ1RzPCyTFMQwlnNh/CdFXPqx0LcYSFJA2bLWcTXcSPTI8YxJExArYfA04bzz6UbTJW7s1v9tEaRF/OS0kf1g0nQ0pHIDpC3TIE+VCHJdg6abt7jGmovqXDihEOR1R/jy84iv0mX2ceay+WDzxnsF2+pSyQTBYI/WstXpl6OvBmh7XOj41283AjmxjaOSyxfHp+6les9O+5actnhfksrejTNR6oWORqs0b7chkR3BgO8yAlweNbF+aUjgZxwsYVtqcaRF3A289ijBM1wuvF4oSEA8jUv0iUMifT2/ANlbbgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVNdHHh0VQft3BYSHvacy9e3RmaHSG8PjaNHo6iDVOA=;
 b=ik4yH6kT4X2ZjbNHGACr8YePeqIBUFhVccNTPTImmYHQGU+wTFJzDbuLKEQ8AY9EAQDOujySfTqbvGya3o8lDzqCetvrx+ZwZ57jcbDGsRioBsIUljTJvsvdZ+bcSGg/9Acq9c3rxx1lJNhosGaANzrL0/Ceq89h/pXRA02iARQv0KccQroG0ZRZAPGr9DTjPEiXAHujm0X6fwhxS5KvICXxxufF2R1My2GcN3gth6Va+uBMaL24gISe4LO7M4a++JFKyMVwCdD2R9w+eLyNbwQZma81WDq7rv72fU6N7QwwotEQLqlu9W951WQ3q9+jTTODgArq5lXpuq9uGqZp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVNdHHh0VQft3BYSHvacy9e3RmaHSG8PjaNHo6iDVOA=;
 b=1OeQlwpLYQ1/+B6foHoNBZTDFA9ZwInyZaticCPD31Pj7tK3Yt/vDs71MLFHuQIM7Gjdn+vYSSv0DrX3IogfPI80cBMOnbhL2pNEY28kIUNJyyd0QjAHnHZyAF1MvZXXLjj+DDZiMIUfxI/wZD/mlNAmtQ0Y5fTa2BUR6KGsdro=
Received: from DM6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:5:80::43) by
 DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Wed, 2 Aug 2023 06:52:38 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::bc) by DM6PR08CA0030.outlook.office365.com
 (2603:10b6:5:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:33 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:30 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: support plane clip with zero recout
 size
Date: Wed, 2 Aug 2023 14:51:18 +0800
Message-ID: <20230802065132.3129932-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b63bfd3-0bbe-4b3a-1b8e-08db93250f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFHFNxqeDlEEHRCptCGHqhWAc3q2yIWSfY5NjkTJ/L0ST5qySjvkS6RYnmYXtcU7nUZsRTwNLbFXFtB7L4a5lZe0bisxfiktJGFxMrrpyOLsy+FIDwVsm2SYJKKjwFpWMr4lUuBfRge6ylX7UhMC0wVf5Biv7TmYojVxwNYF1gOKyJ+doJuqgjF6d4ufk6ySHRt5/gxBsZmPjroXme4KI2WK+V+OIosTEKGgFztayv982JIusdrGjDxgs4unuROMVGkAMOVrzPZQTTwxWTmLQaryh59NWROMVJFtGl1P6G1KOVesdLnQZ3HBJEi/PYoJQR7Ka5ictSLlElbkGq+Jb56K3GHq2Ofnk4C0JJnI2YCVAu51yCDzHUPoWS8LeHpguoTmPtdWwbcbA0uDS9FRAxbhl/WQYyDd8TaTKLflZ626q2mi9oP2pRsmIrlbwQX+3MK8esZOExI1BVXlYUjHu6k8dKA8RhUdoqHTYJ8/t0M7XkMYr62EJUQNXl0iiMCIdsHIxNW5ror3cnLP9Uli1sMT90+O/eZUowFFt25Sxuo0V5Pl5BFWNUsttaTgMbKypjdkGzd5Xv6YyjzNRa+K9qTvQJ5gI5cWb4QUzesFioJ4uopa7XpeJFMPG8gkUqgRCE+2ffNIRq1OCB3zuwIKAbiKhkCJ1CfoR1/6KuOaFPJXkIAPKGVafztn/mNuyKAAGl1CA4FQc+XJ76qguMdBC3UAG25zhE133EUOSsOrNbw75o5XJ0hP4bvtVO9J6PfAXG3i6ZMd1ruAZV0lZgealA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(36860700001)(40480700001)(6666004)(54906003)(82740400003)(81166007)(356005)(478600001)(40460700003)(86362001)(36756003)(2906002)(316002)(70586007)(5660300002)(8676002)(8936002)(41300700001)(26005)(1076003)(2616005)(47076005)(6916009)(83380400001)(336012)(426003)(4326008)(70206006)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:37.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b63bfd3-0bbe-4b3a-1b8e-08db93250f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
If plane clip is outside current pipe's ODM slice rect, our logic will
fail validation because we assume that when a pipe is acquired
to support a plane clip, it must blend some portion of the plane
on the screen. This assumption needs to be changed.
When a pipe is acquired to render the plane, we are now allowing
it to support a case where it can take minimum viewport and draw
with zero recout size when the plane clip is outside current ODM
slice rect. The reason is that we want to allocate and get the pipe
pre-programmed so it is ready to be rendered when user moves
the plane over to the current ODM slice with a fast update.
Whereas with the existing solution when user moves the plane
over, we will need to allocate a pipe as needed and power it up
and program it through a full update. This not only impacts the
user experience with unnecessary delay of a frame but also
doesn't generate any benefit to the user because DML doesn't
support it. DML will invalidate based on worst case scenario and
it doesn't depend on the plane location. So having our
programming sequence support such dynamic pipe allocation is
not meaningful anyway.

[how]
In build scaler params allow recout to be zero size and if viewport
is smaller than minimum, set minimum viewport size.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 57 +++++++++++--------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d0f4b86cadf1..ea09830a649c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1157,15 +1157,23 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 			pipe_ctx, &plane_clip);
 	odm_slice = calculate_odm_slice_in_timing_active(pipe_ctx);
 	overlapping_area = intersect_rec(&mpc_slice_of_plane_clip, &odm_slice);
-	/* shift the overlapping area so it is with respect to current ODM
-	 * slice's position
-	 */
-	pipe_ctx->plane_res.scl_data.recout = shift_rec(
-			&overlapping_area,
-			-odm_slice.x, -odm_slice.y);
+	if (overlapping_area.height > 0 &&
+			overlapping_area.width > 0) {
+		/* shift the overlapping area so it is with respect to current
+		 * ODM slice's position
+		 */
+		pipe_ctx->plane_res.scl_data.recout = shift_rec(
+				&overlapping_area,
+				-odm_slice.x, -odm_slice.y);
+		adjust_recout_for_visual_confirm(
+				&pipe_ctx->plane_res.scl_data.recout,
+				pipe_ctx);
+	} else {
+		/* if there is no overlap, zero recout */
+		memset(&pipe_ctx->plane_res.scl_data.recout, 0,
+				sizeof(struct rect));
+	}
 
-	adjust_recout_for_visual_confirm(&pipe_ctx->plane_res.scl_data.recout,
-			pipe_ctx);
 }
 
 static void calculate_scaling_ratios(struct pipe_ctx *pipe_ctx)
@@ -1292,6 +1300,7 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 	struct rect recout_dst_in_active_timing;
 	struct rect recout_clip_in_active_timing;
 	struct rect recout_clip_in_recout_dst;
+	struct rect overlap_in_active_timing;
 	struct rect odm_slice = calculate_odm_slice_in_timing_active(pipe_ctx);
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
 				|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
@@ -1301,11 +1310,16 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			&data->recout, odm_slice.x, odm_slice.y);
 	recout_dst_in_active_timing = calculate_plane_rec_in_timing_active(
 			pipe_ctx, &plane_state->dst_rect);
-	recout_clip_in_recout_dst = shift_rec(&recout_clip_in_active_timing,
-			-recout_dst_in_active_timing.x,
-			-recout_dst_in_active_timing.y);
-	ASSERT(recout_clip_in_recout_dst.x >= 0 &&
-			recout_clip_in_recout_dst.y >= 0);
+	overlap_in_active_timing = intersect_rec(&recout_clip_in_active_timing,
+			&recout_dst_in_active_timing);
+	if (overlap_in_active_timing.width > 0 &&
+			overlap_in_active_timing.height > 0)
+		recout_clip_in_recout_dst = shift_rec(&overlap_in_active_timing,
+				-recout_dst_in_active_timing.x,
+				-recout_dst_in_active_timing.y);
+	else
+		memset(&recout_clip_in_recout_dst, 0, sizeof(struct rect));
+
 	/*
 	 * Work in recout rotation since that requires less transformations
 	 */
@@ -1487,17 +1501,12 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.recout.x += pipe_ctx->plane_res.scl_data.recout.width;
 	}
 
-	if (!pipe_ctx->stream->ctx->dc->config.enable_windowed_mpo_odm) {
-		if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE ||
-				pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
-			res = false;
-	} else {
-		/* Clamp minimum viewport size */
-		if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE)
-			pipe_ctx->plane_res.scl_data.viewport.height = MIN_VIEWPORT_SIZE;
-		if (pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
-			pipe_ctx->plane_res.scl_data.viewport.width = MIN_VIEWPORT_SIZE;
-	}
+	/* Clamp minimum viewport size */
+	if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE)
+		pipe_ctx->plane_res.scl_data.viewport.height = MIN_VIEWPORT_SIZE;
+	if (pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
+		pipe_ctx->plane_res.scl_data.viewport.width = MIN_VIEWPORT_SIZE;
+
 
 	DC_LOG_SCALER("%s pipe %d:\nViewport: height:%d width:%d x:%d y:%d  Recout: height:%d width:%d x:%d y:%d  HACTIVE:%d VACTIVE:%d\n"
 			"src_rect: height:%d width:%d x:%d y:%d  dst_rect: height:%d width:%d x:%d y:%d  clip_rect: height:%d width:%d x:%d y:%d\n",
-- 
2.25.1

