Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE501C352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A344021841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jgii8WSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A344021841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3323A6E342;
	Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A726E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfmDWuIS0srmmRyIcTmCdeGIUGrrEJDWtAFG4jvLAeEqeIWIXcHSqBtGPen4iX0ACzoZ/2ymaa5CXo8xT7wu68lw+WThJu3EIApUPi1twStZQqPSUF+4fNhNhKXnWhTp7DZcio1YOsbmAHZb+w651Tndbo9n1nOOySc5+1z7I4JXXfNsLZpmzXFya+OnJyBLoH5Xub0O4CQdL/BxQkCN/NdwrLzR4AKikGb5LhcNRJtSnquvrAq/Xlaw/6VBy19jMdvC1uy7Zvlwt1XWHUfvyZ0kYX0DRKtVCF9tmBF0WJJ06eLPXgL+Jckcg5XNaqD/HQo6SYjDMVeqa1rfT5HRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV2KMyUm2vMbcWDnDVV6laEQwG+fguwM6/DLgiIqXic=;
 b=Dyn2Mp+e4ecY3IOxNrnB6qugVO0byXAB3n16bUQ8ll1a6hsAWIiGvIWWF3LU7ReXMmrZHeyXhiMVLSFATnzWo1623lqxX0z4A+yD3/jtdk2jhLaeviFhpCwnlmzZnOLevrM/txJCxVr7LogoXbz8he6AgO2R0wBKoDlmNu1JHK5h0NCVY/tLYBD4HadPoks4vGouHqsQZm6IuAj6Xq3biilY15Gh5sTie68GN1Y0hmPjvtQpQFsLD1Xx9cC2q1PdhTvVoWmsLIy3ws3CpbITXDrW6uoB2qXsVN7bKrDkbFEboCvcQsaUc9tBOqW5yw3n1+NU3lv6mb4TssIpesTMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV2KMyUm2vMbcWDnDVV6laEQwG+fguwM6/DLgiIqXic=;
 b=Jgii8WSjFWOA8S+/8FF7L/+QaMfan+tiRhrCy87wODpa6SEuGQZn0l2uVTDPByoAEVSrKLCWPxAt0Ilo86WQxErCQzskgO8WMNpFY5CUZ/GFT2VhL4j4SvcGlsk03Z6az9wUmHC0syw0kJ+hzi61BGRluJiFNht6o22iU3UHjHs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:34 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/35] drm/amd/display: Fix HDR visual confirm
Date: Thu, 16 Apr 2020 19:40:27 -0400
Message-Id: <20200416234044.2082886-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:33 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d597cb48-1770-4a1f-edb4-08d7e25fb2a0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245955E847E726C8EC1F3BB498D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaZtxzNamVCoy5CHNXRZhyxV1LVuRD0E6r0nhfU4HtGMZGawAC+9VmDf5lfpt+MMGHkJliPumWVUrnQIf9/wltBuzd4FLiPRtAETj1sp4db6fB8JfP6dZ2xRg3bvpYOv8cW7X4KtBGVVmq4c3TpVKreLOrAxzHTHkoOqahxoPeQgEPULgtTr4eMQPc/uJ9QPENU8gumhdAcwDzxYaPxgSSXPPLvCj4/pylloL5s9tl1AfLU3+0swjlT36++j36UhAJpNPgSZwsxEo6yV4FSXIUHFIIXmY9JPQzykZYgV+0AM8Z9aC+lEjUmxvmsbHDa0hbLD6KY5Iigcn4uefsm8I3kz4W5uPulohjVwNKz3ZtE2DodrFHCLA6Ko7B3FiJ1n/vq+aSc+TLo+j+Dl6u/liwVMygnqBLMSyP620b6IeyAzv5Ah3aoe7zLOIX++CSp7
X-MS-Exchange-AntiSpam-MessageData: bbpziXg67Uh3xr0mqwjRDjKtK9nLaFDU5MnKx4cD8I6ggJTjXpwge0l1oIPQ8FbdW2d6BSX7K07zO8aGd5CLQ/eoaz4VVSgzzQibkUcFkwE+9cOj1dgl8jf8u8zFAS4i3/68odESf3VoFbuRmyZzRNroCE7Xxoh5ryY0vGkL89M=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d597cb48-1770-4a1f-edb4-08d7e25fb2a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:34.5444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzROeTs+yEMEx77/0NdK+XZZSuwYHziR+CuLq1wEPHNoiII2jHso46vRHKO1AN44BXX3zLMVsT07YDEOd6wYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Aric Cyr <aric.cyr@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Some cases were incorrectly reporting the wrong visual confirm, even
though they were working as expected.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9f41efddc9bc..80e9ac14e38f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2130,25 +2130,25 @@ void dcn10_get_surface_visual_confirm_color(
 
 	switch (pipe_ctx->plane_res.scl_data.format) {
 	case PIXEL_FORMAT_ARGB8888:
-		/* set boarder color to red */
+		/* set border color to red */
 		color->color_r_cr = color_value;
 		break;
 
 	case PIXEL_FORMAT_ARGB2101010:
-		/* set boarder color to blue */
+		/* set border color to blue */
 		color->color_b_cb = color_value;
 		break;
 	case PIXEL_FORMAT_420BPP8:
-		/* set boarder color to green */
+		/* set border color to green */
 		color->color_g_y = color_value;
 		break;
 	case PIXEL_FORMAT_420BPP10:
-		/* set boarder color to yellow */
+		/* set border color to yellow */
 		color->color_g_y = color_value;
 		color->color_r_cr = color_value;
 		break;
 	case PIXEL_FORMAT_FP16:
-		/* set boarder color to white */
+		/* set border color to white */
 		color->color_r_cr = color_value;
 		color->color_b_cb = color_value;
 		color->color_g_y = color_value;
@@ -2173,25 +2173,25 @@ void dcn10_get_hdr_visual_confirm_color(
 	switch (top_pipe_ctx->plane_res.scl_data.format) {
 	case PIXEL_FORMAT_ARGB2101010:
 		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
-			/* HDR10, ARGB2101010 - set boarder color to red */
+			/* HDR10, ARGB2101010 - set border color to red */
 			color->color_r_cr = color_value;
 		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
-			/* FreeSync 2 ARGB2101010 - set boarder color to pink */
+			/* FreeSync 2 ARGB2101010 - set border color to pink */
 			color->color_r_cr = color_value;
 			color->color_b_cb = color_value;
 		}
 		break;
 	case PIXEL_FORMAT_FP16:
 		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
-			/* HDR10, FP16 - set boarder color to blue */
+			/* HDR10, FP16 - set border color to blue */
 			color->color_b_cb = color_value;
 		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
-			/* FreeSync 2 HDR - set boarder color to green */
+			/* FreeSync 2 HDR - set border color to green */
 			color->color_g_y = color_value;
 		}
 		break;
 	default:
-		/* SDR - set boarder color to Gray */
+		/* SDR - set border color to Gray */
 		color->color_r_cr = color_value/2;
 		color->color_b_cb = color_value/2;
 		color->color_g_y = color_value/2;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
