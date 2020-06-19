Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C68C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F14208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fc+R81by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F14208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FBD6EA19;
	Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833406EA19
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnPbCRxm3GxvKVQfq4ZACE62KCUHfqCPxSTyP8PXL+jWYSZ5UuQt+f8Ru9/hCW6ZvjY1pZgCW9IICCIBeZkYktt0jX6BVPv7s0+sDO1NgSMiM7QNptYdeDfZhyOYMIO/xlNGg74lb5Klq4ZWQ+rr6dZ+DFNdJwBZ1RmEKh0NvRaW9mNtcbI0fhjvuCaBSUcNME7ODzOtRQVnUhPP8tvl1lPxyB9emSWQCr/R2EfJkIApCtD6CK3qpQyO2xhmRI5a24Q9KhgDN9+j0Cln6rqIbrgHef5FiP3qNQsn/pbNVlav1Vq921OXaYD0I2Pit6nEf4u4u/B5FzSOhmDwpO5b8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdsOZt+M7kgk37nRduspzog/zWypOs4aboQMIUvrowM=;
 b=nAbqYBI3VAU/g+ck07PkUyH2QwqBkK5nr40WzgCZUyDi0kNPdT1lwxg5wcEDYDdjBpxlT9zIWqWivgk0yw60jpQc8H0JhwZxwvFub/qst2MUdq4NNp1KRFznQeGGFI9H/8e8/lKQj/924e1NglP/aLutC84lQK2e4xQCgghbz4JeYuqulSM73TzdCw67VvegsMt6fwVAZnmrctIIGT4v5O1hMgt8zXB8G9IjfnVuDeg9yYs0F0Q3DeuoIFMLghCDXHug0cDqQgs0yu5pZ4zYT+l4aLflwzdRgQihweMHjbupQdr6YIYXdexBS/ascCyqFg2Jss6k1c6b+u+TMuSlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdsOZt+M7kgk37nRduspzog/zWypOs4aboQMIUvrowM=;
 b=fc+R81byKr+fpEiV2XPcgD9Ebp4WTGhA+hLkH8H8KKbNPXNtSejcoAy+QOkOv63me2K0QjQ5Q4uEpgBaN4MpELz2n7AJF4PRpxc6LQVmMpAHgoVyAyDqeJMF9TyFtfF+XtTov+WpVkO5HkGpP4QWr6Q8pXEJnEPRc/UYKcvVVM4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:53 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/30] drm/amd/display: Fix DML failures caused by doubled
 stereo viewport
Date: Fri, 19 Jun 2020 16:12:00 -0400
Message-Id: <20200619201222.2916504-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:52 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 833f5ff3-d88f-4645-49fc-08d8148d25d4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408765E5E0052A0755D2DDD198980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymZpNBnTRQygmweXT7UlWC6xyUy3AAel0i7JRe8tfbzdXfLw/L34mK5biDVW/fIMr19381lyt8iDGIKeQXl8LvrH3VcsIZal667tIxHmww/ofFVH16KW+1nuMNa0Y3pz6qfTgaPJLTBX9jteVPDekvlFdMgAxVZ/bde0N/LbFccGIH+c714QSrUvcMKYZEQL5oy8A30t7iY32w/sjtsBfIl8FyiuwuCMOf0ui9yWqdBw4Xmb1i41rnhVBDUP06BNhdZe9nCy+DPsblPpc3ENRTxjyMUL/ImXCAYBAFm9zs0VTlhkAAEE3EgZObBBpZwhi7N9gd+i5kyZ9oJAu6Jb/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Z3isWcliC8c9+9dzqglPteVCIkR5Szu3vsW/K9GdXwcw5XKiqIUba7qbgsfKadZJzdJr1jZ2RqDoOiZ8Jz7MUKpFloGZ48Q/eb5pfIikpWTtqmzlGtBedYETTj2aDkmNl3Y+xFWO/eri4rQpg7BgK6mAyUscOHdz1F2DMHdrTOtK+I+lp39ZCsV+HkgMZ6b6y4eZLiopadMWfZi3rda8AZngZNcrVar4PtJfyJIm8+Kwy56AvZipPYjd/VUi/4qTx9eH5qj727OYAAaYX3bAUYrQUd/9RktmQEZLEUhDQEr2gsObmeK+/lp1l9ggUa1lA1JpIWmHFL/vVoSTOjAXI+05TSq7poxQB3F8WUk/yf/B39ZtJJFKNBLAdEfYyqOn7c2lMUAd+Bi3kN/a5N6iBBlLthX3mGT2s9IMejQXBsFNPGwPS17G1Im7lddCAhkIPyn0KuU3n02qB65IqQaWeJey1dDPyll9w4pRjirGhpkyvGs5kEQf1khj+aABkYHk7iaXXVlqHjWM5KshWggEOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833f5ff3-d88f-4645-49fc-08d8148d25d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:53.2141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzxfuBfKUHYGrl9SZsg+GZyFkiO58jJB0QXy5/jDN+YLY9F+E5vWeuByBlw0b3y6o6ZHvvLavrJBTxhCyYdg+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Side-by-side and Top-and-bottom stereo configurations fail DML mode
validation due to Viewport exceeded.

This is because we consider the planes as being pipe split in pipe
population so we end up doubling the viewport width, eg. from 4k to 8k.

[How]
These pipes technically aren't hsplit, so add a check for determining
whether is_hsplit should be set.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c      | 11 +++++++++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 555af29565aa..51397b565ddf 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -302,10 +302,17 @@ static void pipe_ctx_to_e2e_pipe_params (
 		struct _vcs_dpi_display_pipe_params_st *input)
 {
 	input->src.is_hsplit = false;
-	if (pipe->top_pipe != NULL && pipe->top_pipe->plane_state == pipe->plane_state)
+
+	/* stereo can never be split */
+	if (pipe->plane_state->stereo_format == PLANE_STEREO_FORMAT_SIDE_BY_SIDE ||
+	    pipe->plane_state->stereo_format == PLANE_STEREO_FORMAT_TOP_AND_BOTTOM) {
+		/* reset the split group if it was already considered split. */
+		input->src.hsplit_grp = pipe->pipe_idx;
+	} else if (pipe->top_pipe != NULL && pipe->top_pipe->plane_state == pipe->plane_state) {
 		input->src.is_hsplit = true;
-	else if (pipe->bottom_pipe != NULL && pipe->bottom_pipe->plane_state == pipe->plane_state)
+	} else if (pipe->bottom_pipe != NULL && pipe->bottom_pipe->plane_state == pipe->plane_state) {
 		input->src.is_hsplit = true;
+	}
 
 	if (pipe->plane_res.dpp->ctx->dc->debug.optimized_watermark) {
 		/*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index fb167393b8fe..e8357d7af4ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2257,6 +2257,14 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].pipe.src.is_hsplit = (res_ctx->pipe_ctx[i].bottom_pipe && res_ctx->pipe_ctx[i].bottom_pipe->plane_state == pln)
 					|| (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state == pln)
 					|| pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
+
+			/* stereo is never split, nor odm combine */
+			if (pln->stereo_format == PLANE_STEREO_FORMAT_SIDE_BY_SIDE ||
+			    pln->stereo_format == PLANE_STEREO_FORMAT_TOP_AND_BOTTOM) {
+				pipes[pipe_cnt].pipe.src.is_hsplit = false;
+				pipes[pipe_cnt].pipe.src.hsplit_grp = res_ctx->pipe_ctx[i].pipe_idx;
+			}
+
 			pipes[pipe_cnt].pipe.src.source_scan = pln->rotation == ROTATION_ANGLE_90
 					|| pln->rotation == ROTATION_ANGLE_270 ? dm_vert : dm_horz;
 			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport_unadjusted.y;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
