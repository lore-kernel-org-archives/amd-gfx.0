Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16B1C25B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0735B10F2A8;
	Thu, 23 May 2024 19:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PR5GB9n6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC7D10F2AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvwMan8Sewaj1JxMjU38upCW9iUCSOZPAtlaDDLnKEEbhQj/UnRhrkUvo8goTIdX8ZIBI3SdqJ6soJXE+bxXdHDLBtq3p9v0pV42C4RX+kyuzPwLtm1kZ9XqrgW5dgN722DCF0R3bknp1hXfpINTUpFWkOCfvov3fI44lMC5sRQEw1dPYg22qAWAhJlGxrlYeJMcuJmi78dHmjnhcF4uuKpxkAs5e3IJrqWQHnJYneqXFqmXNdZEfincBYUyevSX5SSyHTXykLwEfs2CK4sIyVR6hEChRGDwtiDp79ojZuy7/rM9mCGcQglr3Cj7eJGXpj/wZg+1tvPPKw31gDjV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZXvxteAuoVhLHjVcD0TcMX1vZ2qr5YPrMlPRdq54Ro=;
 b=gA9pGQYdjP4EmNjOYNXoBH5bWFCb2ixaPhrUdY8/PDcsQ1UvZNUFuZta32sTaG49Xpi+csjYqV2J4CnEXQKj6ZokCuKjx+2dUOWW/FYnW5Xp2PXsGA9iFb3P1CCwppqVgBKeiaNGCiQFu39AuAGOIk0yAJ0gdP5tIpDFP4pgfqnq9efCao9k4Gif31lG1RfJq8tJwuN5IQixhFZA+/crSNCXclIAAIF4CiO80DTNCF/Er+uPLzoVfLmI/FUlvQPNGQipPJtTfnQQnZQQugRLedz4EFYiplYawBbIPLxTcfgcebmSpaXC72gxDC3Xk7AuVt2dDodc8grXbm7ZICWOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZXvxteAuoVhLHjVcD0TcMX1vZ2qr5YPrMlPRdq54Ro=;
 b=PR5GB9n6E9qTnjEhqe/ei6kq90tszFyHnctWfSKygAnc8CNgwjJraiLOsGh6ceXnfu+zqAIE933akPk9abaquQVdbMLBem1CU7t8OKsONWAWbyDaKGPiKN91nyzkUM1jk+CPDdEyshjPnfja7Gidhuomk+KIomb1k/MC9UsGNGU=
Received: from BL1PR13CA0276.namprd13.prod.outlook.com (2603:10b6:208:2bc::11)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 19:21:18 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::f8) by BL1PR13CA0276.outlook.office365.com
 (2603:10b6:208:2bc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 19:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:17 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 09/13] drm/amd/display: Fix null pointer dereference for dcn401
Date: Thu, 23 May 2024 19:20:23 +0000
Message-ID: <20240523192027.50630-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c74d085-85f8-40f8-400d-08dc7b5d85c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mq54t+Ghd+z46BxsNiYRhfksUjniOl0t5+icHHrRI2jISbPAIdAfNLX2mMM5?=
 =?us-ascii?Q?YGbvBx8uXSG6Wyj8JKSUy4Rx44cAQmwiGPvRypOr3jxhqEJ4SMAeYBOSvLu4?=
 =?us-ascii?Q?KEoohBevP0nnrnKgNxI0EI/e1J/9oVBveMpK90+fm/5PJfy8TzqcMTxTZJQt?=
 =?us-ascii?Q?5QSo39btoHpC/R9+6VBkdbTujkX2R4QKkigEzUZhF17mdYU6uQpD1pCR7HEJ?=
 =?us-ascii?Q?NA2Uiyu6t5r668P+ObmcKv++DMFFkcT41hhfBtL2B9Z0y6C5WOs1icytt4sj?=
 =?us-ascii?Q?bKqD5gNa6XATef7eyYmcYPpBsEOo4XS5H2PCx7fIuo5HbIiDemyc4xLAdpVk?=
 =?us-ascii?Q?TGXdLb0iz258YfQOQE5Tthym5XbeIpKtc/g9n7k4M6IkmS0C8TR0pbsOuXDV?=
 =?us-ascii?Q?/88SALGF5hmmDmonfEGPGtt5oitUHwSztQUhwF+CLvtokcmKXq3MlXnXlJNq?=
 =?us-ascii?Q?9vaDMnOYFAXZJAxDOESvNOUo/OLPNYvgX0WSTl+MJKBq5f1J+iwgopL31Hdp?=
 =?us-ascii?Q?CWTCH4XNo9v2iPVDo5u+PxuTfSeFgKyJnoJtek2z9KszCsJOYJ0s1LLeY9YY?=
 =?us-ascii?Q?sYEygt4dgwpfiGXJrE6JOcbR40JtbOGKVNf853mIOzSTlKDfgCNbgqwJLMzc?=
 =?us-ascii?Q?SKIzQfhAstmin+SMN+MVeIpv2tQt3yVqv/iO+/Eh9wQvWs8WFktlD+AXQmDO?=
 =?us-ascii?Q?sg8eWgc9A9MmzuxFeGuunCeHBKii+o8qiwEifWzsLPIvsnnWdIhDq+p8gfWW?=
 =?us-ascii?Q?xT1SQbPo/8okNH5aw+NFcuzqhevAU/8B4Y9Otpl0PhklXLfWSVTx+YUqGoqQ?=
 =?us-ascii?Q?/nbP5RVVT/rZO6H2LqKAr3+pbAifhKfTapcWV4ZJ4oJQg7+hM3z9PzpUCRps?=
 =?us-ascii?Q?v13fEP5kktpWdHLkU0AQVKD7gX+k0X5VGkm0ue5obt/v9Pomk1fEomeJDisY?=
 =?us-ascii?Q?GAStVcPCntV7agf5c2MzFjqhzBvTcczqZzSiIjAO6DNNsKTkxTfGiZJ4SJLz?=
 =?us-ascii?Q?YjjdwqM/r3VmhPUsyspLx+Gv3vMPkRedHDC3Zcc2kbvMc4rZeyhJeT5owoT+?=
 =?us-ascii?Q?wogQokRmo5tZK5pk7zeXTFRIoo+ihX9LKY2sybTdi8Ljsw+BkMKEalZ+9Teo?=
 =?us-ascii?Q?m9uCQ1wzRpy7VIi7ebsfbT0wK+KQvH5Ailvy+P/WqYi0o64AgZxVy2JauEJg?=
 =?us-ascii?Q?I/D9WSlqTlIXrPILb1fMG963X4A4HLP+Hxmj622Hl6qebN6SExPH7tjB18We?=
 =?us-ascii?Q?HXwEEQJumi+4Q1JMRmgOvtEsrlWqTDTJ7gHO1LjiTIuOhSDxP7WVvH12YsI9?=
 =?us-ascii?Q?yWzDtGrPNZbDOzwA0G80uEk9VYwz85bPEV8vr87GfvK2ho49kDK4DdDOjPpU?=
 =?us-ascii?Q?1G3hySEaBNE96QsKn9O65Qnk5eLM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:18.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c74d085-85f8-40f8-400d-08dc7b5d85c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When ODM slice happens on DCN401, there is a null pointer exception
caused by that. This commit address this issue by checking if the
required data structures are initialized.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ce1991e06049..beca40f8694f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2083,8 +2083,10 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 			timing->h_border_left +
 			timing->h_border_right;
 	int width = h_active / count;
-	bool two_pixel_alignment_required =
-			otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing);
+	bool two_pixel_alignment_required = false;
+
+	if (otg_master && otg_master->stream_res.tg && otg_master->stream)
+		two_pixel_alignment_required = otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing);
 
 	if ((width % 2) && two_pixel_alignment_required)
 		width++;
@@ -2124,7 +2126,7 @@ struct rect resource_get_odm_slice_src_rect(struct pipe_ctx *pipe_ctx)
 	odm_slice_dst = resource_get_odm_slice_dst_rect(opp_head);
 	odm_slice_src = odm_slice_dst;
 
-	if (opp->funcs->opp_get_left_edge_extra_pixel_count)
+	if (opp && opp->funcs->opp_get_left_edge_extra_pixel_count)
 		left_edge_extra_pixel_count =
 				opp->funcs->opp_get_left_edge_extra_pixel_count(
 						opp, pipe_ctx->stream->timing.pixel_encoding,
-- 
2.39.2

