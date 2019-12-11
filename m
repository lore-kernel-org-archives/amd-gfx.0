Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F2DC3F68F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C53A2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TGhNCtto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C53A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E06466EB78;
	Wed, 11 Dec 2019 15:33:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7218A6EB75
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA+e0Rmjc/SDWuBOZO7bRPpA436+o7YEDOk3szq8G8K6No4F9N5N8hGOUB6hlpsBjLv6/AOrqFTvr50LNxE9bOGtSBvJ/G8HxQxSvJaFIrsHEZnYNW1CuGy1Pmx14xc8+zXWojjINCjP+QZ6h4opPp8mT00csVkADaVxf8ZjQ/3OBkZEt01wQdN/2y+7YEjWlOXtVF1kHZTgpqfMjDyPCshD513Brdpu/xhCe7lpv4TUXL1BssuL74OgyWMKzqnGo6FUTxhYyGr2k+HsgvVOmLjBkDRqdK2rhnz3r4oDxEAZ6QwF7FSeEQz9AvTUdtSsv9CsAcXb+LDMm/kCptzuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBNnXpx7hTJ2kIt97Pw/6M0upe7GIi53/MXXH2GhkpQ=;
 b=Ltk6If7yM/KZSeauTmOHGFGaOgBG+YMsqze90Yx0kCbsN8Q2KoqPxD9FYpS+qa3yEmaPH2ay1euOTT/tNLOtJmxtTgbjKlxGCVQPSRoRg5EXHotZWcMkeNuyU/7GSoHd6+tc768u2qtQuWk4V33f1HO/X0aPj37WHPbEtuJf+R5KY+rj/X1WlJNQoU+eahF63LmDJ49Ig8hmboZAYhkHfM+79NCJThPbCBOCdxK+9buSBKZkHdxUPQM5BABQ+KMipSUAJYTZQFsK1rDqQ9Mxlb3mfMa+aUdHyR+UinUqx12F3i1Eg8Q1O611cirBiaVb2+mvyRhS58DzPVbLCLcjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBNnXpx7hTJ2kIt97Pw/6M0upe7GIi53/MXXH2GhkpQ=;
 b=TGhNCtto2bjPnR4Et3ep1XMfVTLe2zAtcIXmnTA8oVWNTxVTqn+6GkzuFBFx6+GAvJr8BC2avUSTz66zjM4o+8SYr4BuYRW2t2GBlyhsd3/+xzxCtEOZ63xva1hdmFOKzlvTb8mkMd2in4rH34bEeIh4G2WzxK7f3ML9JJ/cvSs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:22 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/39] drm/amd/display: Disable integerscaling for downscale
 and MPO
Date: Wed, 11 Dec 2019 10:32:20 -0500
Message-Id: <20191211153253.2291112-7-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d3df111-8448-447b-342e-08d77e4f748f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2426AC8C429DA4555E2B7A14985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5zCPthfNPhDp1W5liZ6Y9lo9yYnrXn9ZitMdtFTmdSDlZDMG0qPsnVm1jAsf5jJbzt8OpdyQW5b4DawpMJs7bF95IdFZPqqeIbwrIKREDpR+eKuJp98s1KbZFkDmuKbbc2ASmqt+ihzP1ZcZSwfiIkRZOqGKyOoaKMtcGJ0Y2wa5PEXevi5GPI3180sYbrh28cBCGDta3E0MYFs5Q6s6kcjsxz8n2O9/qQ4B2l60t+yLq/62MDP4kRdbfMNzbqnQj0BbskbsktUUXdkdeWOcKViT4eFYmCAMbE66fiL6ASxHXzt8mTt2fujCNkeKKF8MFMhj4qq5gAnFen4Jtu/ZHdIYCneVw4YdN+Z0ZMv9rwYkWY9OeVxsGBm8W1lOHXJeNBO5XCM8sh8t+/2eUGTeZO+x/gy78iDCsONbIpWSjRumgpq6CBYvlH9A4lH2bgx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3df111-8448-447b-342e-08d77e4f748f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:22.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKt3CEJw4eKp3W/hT8GsH0BRyS1T/P+2gaBJHfJYXe8CODvK5FdQkvnOOuApvyzOFgRAnkPUw+U9vjA3+RYWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
 Harry.Wentland@amd.com, Aidan Yang <Aidan.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aidan Yang <Aidan.Yang@amd.com>

[Why]
Integer scaling is applied to MPO planes when downscaling,
MPO planes use variable taps and integer scaling sets taps=1

[How]
Disable integer scaling on MPO planes,
Disable integer scaling for downscaling planes

Signed-off-by: Aidan Yang <Aidan.Yang@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 6c6f5640234c..39cc71bedf69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -940,11 +940,27 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 
 }
 
+static bool is_downscaled(const struct rect *src_rect, const struct rect *dst_rect)
+{
+        if (src_rect->width > dst_rect->width || src_rect->height > dst_rect->height)
+		return true;
+	return false;
+}
+
+static bool is_mpo(int layer_index)
+{
+	if (layer_index > 0)
+		return true;
+	return false;
+}
+
 static void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
 {
 	unsigned int integer_multiple = 1;
 
-	if (pipe_ctx->plane_state->scaling_quality.integer_scaling) {
+	if (pipe_ctx->plane_state->scaling_quality.integer_scaling &&
+	    !is_downscaled(&pipe_ctx->plane_state->src_rect, &pipe_ctx->plane_state->dst_rect) &&
+	    !is_mpo(pipe_ctx->plane_state->layer_index)) {
 		// calculate maximum # of replication of src onto addressable
 		integer_multiple = min(
 				pipe_ctx->stream->timing.h_addressable / pipe_ctx->stream->src.width,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
