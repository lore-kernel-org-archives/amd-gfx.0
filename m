Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02845C27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A75610EB07;
	Thu,  6 Jun 2024 21:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXjeUTx3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EFA10EB03
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLOBMNgoDFEdtGATkfH0s0/TVn1+OMcXzTTuQOkNNSvIxTtKht5KQ1T/cgj2zxqp7roHw9EIWFD6e+Z44RqA7SbVLbfsN/11zsFbDxOfxuhWO1kQCeYh0najSeuWcDCXxEycQXmvmJyVbPy+Qy3/74l6k/ilMyFHYpIof+//UjM4ssVkR0N24wGVE4MtfyS0e9WBJ+a7LD5lw8nY/NQHXSQGiv/DdJ/tRsK9Fud+1Oh6UgecEcwC0HAbAHJNrhAmR+GULXRTOoDr4slVnrUIg90FG8FaNP8W/rc7Hra/BrAO4bV8dGydEHhnYcU2frkvVemMfs5HFiNQsKjF3bgA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvVeQOxjm186uoF5YZlfy+LgFwBHG87+BuYa7PSf36I=;
 b=bazdsBcwcES5rgbStX83UvXsNM4/KNe+ml5dvB3s6QsBHRK2oOS/bMMDRdYQ8NPIAR1/ifZQJBCVS6OJbhlogbTtubfEZVfBO8/ey1z/pIWDNd/F5FLsWmaqapKvKUvu19QVXUgpbAskKdTFTJY12fXK49yaC1tCzscVmZMyPGMeAogCZLrzKVaNT9Q0bkCPKxJVg56djwRkokbBmA9GdXSETjQ2JZgO8puQVOd96MPytEq2iZ/4K0ISv80AX8tTakD5TZC+FUMwmWd4pp9IiazVGJZVqi6CUflIIWhnFKB7zGdWRPJ8iHCjbf6PixH3OH4VfDVTdt9V3m+xYw2Jqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvVeQOxjm186uoF5YZlfy+LgFwBHG87+BuYa7PSf36I=;
 b=gXjeUTx31WxvwdpZKU/HXoPHl5fR114MIiqGtA/oS4zl99oEs6lYup+ZbNBNvfnGjxgEnwVCdOBVyqO4ASugywiKiQfpPBmvJ1QHDmla7aqW9sPIPx/aSbPgSlBmzk9Ihylti06xXaxUStiUze4VRRMtBd8IesuQiVIqQr1J/H4=
Received: from BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:03 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::fb) by BL1PR13CA0256.outlook.office365.com
 (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:02 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:01 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 54/67] drm/amd/display: make ODM segment width of YCbCr422 two
 pixel aligned
Date: Thu, 6 Jun 2024 17:56:19 -0400
Message-ID: <20240606215632.4061204-55-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b18091d-604b-484c-bb1e-08dc8673e0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8Y+eoENofzDh7PZxro3Qvxuj7OtVts+DUv/Z6C++x+C4tF1npnICW+wII5q?=
 =?us-ascii?Q?/f78bchPDW+vwesfm1UIfmMBueX1NQd7DF1FYMlss1PBws9U3mFh/TFxdQnU?=
 =?us-ascii?Q?MejDcKod7rE0dcblnNqfClgRrMLDiSlG7tXiXlDRPYLXOaHxLEPtRnEVMgt9?=
 =?us-ascii?Q?xxoSs7/dnYEIBji5vLueT+t8By7YoBc1BqRvP8fUEXafDrcAVG78Jnw8nDvB?=
 =?us-ascii?Q?leI1eK7unHSpEbBXULusjqMNeXgG0ebn5HnYbFrYL7u47nqqgQfegjrFSHQX?=
 =?us-ascii?Q?HlcoiCRbjeFIT+PDkTgys31mcvi6SQNo0g10lhVtCozUxcK7DTDyWOuANL7N?=
 =?us-ascii?Q?kPDixIq68J1L8fNbRw7e2yeuivXeTKynhDdaZ5pUl1a5jOZKyMH25mh1Lh9v?=
 =?us-ascii?Q?y/Hw4lI8VaRphwmZhL26MZzgPsgSJto2UfkK8SSyyyjja8CDVnMqfrKUvYSo?=
 =?us-ascii?Q?4+jkrb+7+NjHN6VWEJZ+9/1md5dAkAxIsK5zx4O4P2DR4sN9zRrZlZSerH+f?=
 =?us-ascii?Q?O9p5upd25TI9OaHAJSsJoiS9EbZKARfrZF5iqx7DstBAjSePa2zytOviVy9F?=
 =?us-ascii?Q?8MIf67fclsxpxOPRxzW3L9IEHHAo0l8RDx3ZpIa3hBmPOZg4ybNn3nBGUB2o?=
 =?us-ascii?Q?mXPG2xxPy80H4uXpVPED8qWxEvtujQKVEOPm7Mrq5m1xYy3sdIfPTVbug3IR?=
 =?us-ascii?Q?V3vKdWhGbOJLPJ8k1NV/lyPLogW8Yr7qgoVYZY/grXnc/tjrA782jEGDDvk4?=
 =?us-ascii?Q?m9cA7Ea0ikenbYJbAIzV5zRYWxVLpUSa8soaR2wzIj1uCh+3wRwWabEz8vQF?=
 =?us-ascii?Q?4a0DKQ6CfxN9w/OkunoVg7i6wGpy+UFW/cDWO3ctKhbCS8JVVIt14ZRU/NW9?=
 =?us-ascii?Q?38YEzMnw4v5JHAzBLMo1K+4QuqstBWPsbV4gZL0wN8TErwxf2b/6wUeIj4jm?=
 =?us-ascii?Q?PCf0tOv17wbWkZ8t16qwjni7SuooaaZZsCSEFekVVdIVyIur31vxsv9Ee6jx?=
 =?us-ascii?Q?uL3KSO6EjmP/bhzftq1GYXDXFXuz85Lsm/lNNxFJGVVGNi/x3nJvHotl+bHt?=
 =?us-ascii?Q?9qQf8VUDduP4T2Ec0/y6uOSXxUY2OIJuTzjl0F6w/TA1cEJU9vryORdTLT7J?=
 =?us-ascii?Q?UJ4mNj09ntr3mAAYS9Q5MJoaR5CTkER7eq8b87GDEUqC2R5jdVnALoY69Rlq?=
 =?us-ascii?Q?t76/DMOkZOf2dxtx/9VtmcZXNVEdOYGIAaUc1SxOa2i1JwDNAkGJCtCtlHrU?=
 =?us-ascii?Q?6El/6shOa4waXCok8Zov+yAKburP6UOJvoHhuho+t6twrtSHPOES7qN9g2H5?=
 =?us-ascii?Q?kyqomLYcmUPGgkWk0da5NAHvzYNG51Ca9Vi87OxJHhwBSba4P0mRd3Bwkgnz?=
 =?us-ascii?Q?jHdvzXhH1f4Lqm6KNhkAc1aCjiXIrMlWQduZ/3OE74dHINnlBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:02.9099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b18091d-604b-484c-bb1e-08dc8673e0be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In YCbCr422 format hardware shares 1 set of chromas CbCr with 2 sets of
lumas Y. Therefore each ODM segment needs to be two pixel aligned. The
commit adds this missing hardwware requirement into ODM segment width
decision logic.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e047ea4ff3aa..76b849bdd914 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2089,13 +2089,20 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 	timing = &otg_master->stream->timing;
 	count = resource_get_odm_slice_count(otg_master);
 	h_active = timing->h_addressable +
-		   timing->h_border_left +
-		   timing->h_border_right;
+			timing->h_border_left +
+			timing->h_border_right;
 	width = h_active / count;
 
 	if (otg_master->stream_res.tg && otg_master->stream)
-		two_pixel_alignment_required = otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing);
-
+		two_pixel_alignment_required =
+				otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing) ||
+				/*
+				 * 422 is sub-sampled horizontally. 1 set of chromas
+				 * (Cb/Cr) is shared for 2 lumas (i.e 2 Y values).
+				 * Therefore even if 422 is still 1 pixel per container,
+				 * ODM segment width still needs to be 2 pixel aligned.
+				 */
+				timing->pixel_encoding == PIXEL_ENCODING_YCBCR422;
 	if ((width % 2) && two_pixel_alignment_required)
 		width++;
 
-- 
2.34.1

