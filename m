Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F38EC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1828110E8C2;
	Thu, 25 Jul 2024 18:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnzM8Xlt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D32710E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwUSr/YTUS1KbKeNxxL6NPPH0MBaZHoFvdLzD+9QayDPduCEPP/zIx4zG72fowKOH2aVYR9WcA56GZ136LaHkUc98qCQrglZ0uwgWptGoU4yLijVykz45WYMWs1sND1kx0hrSPyBATkgq7DhSL0PQneio0xca5MHbqDk3B9TUpgyZroVoFuYLt1NdkTjIgcScem1clZmwPPwRd+34b/8IL9xDPyG0l923v4fPnR0/4xLT+ANxDnEN1urc+A124uS3pptE4eW307bFgeWkpZwrjFSrv3GODIGqYkRoxraYmAmjTuOrgvgcnJanmHLWs7s21rHIrikQijSCQpCBE455A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpihQYs2x11sqtcbZwzo2YGQR3hT9BJt+nSmOenWJfQ=;
 b=lLFWSr6AYuKUabGp5fsO2aBpy88xfCOgL5vxaK+k6anSrg97Pnzi5ax7lE00VXNA0nbilygis7rzja3Hbr6NEBmLLvk5tvLrX9I6RTQqMGVAIpKKWSAUyN+ije5/Po9P6dHqtIZadqQPsAorGh/6xjYuYHcgD+UJwhSDAbmLwyJ9ax8iE8vKpAkSlpTUE7WBaaJRLSNQnhaLms+qCkKYYGZK0cZN2u5V1G37XEL/hCCbdOQgQr6smfB4VH1jFa0kyw08YQUA2u1t5KNdi15BZ15srmoYacwH7+3N3UnBArEWvTYqbX6QOxDpVPmMgNR6EaxKuVvkumIMSJXAQXfsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpihQYs2x11sqtcbZwzo2YGQR3hT9BJt+nSmOenWJfQ=;
 b=YnzM8XltWSTc/JhPaou+J3qextpygVFH+H+OTSq9XiNPl5G82jy2+yV7c1B1zjwBpr5CHzRPb4380VVpAy1hgF4lTa3YuOH7Yuy6qs0H2Ammwiaj/t/1gGbrIT4XCmFL5bVik8yVGgBAq0t3v2bEoj5YBIbzcS61me9XmGijqOw=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:04:41 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::84) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 37/39] drm/amd/display: Add missing registers for dcn32
Date: Thu, 25 Jul 2024 12:01:21 -0600
Message-ID: <20240725180309.105968-38-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 577c7738-78d5-4017-da05-08dcacd441e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z1OxQ63tcjTlFEUAuRuS5d9+PnoV4ydzWrjazH8jZroC3AhUp+AgixNLxFtt?=
 =?us-ascii?Q?NqubyECxbFXyiNND/9M1zo1vcDr1vZgv5l2L8G+LRXUzrZsaxyvihNTYrQaG?=
 =?us-ascii?Q?hilndin4gnLwS0Fn393/MYb+1YYnNNQnCLHqhygpKc9ivp2KG5oMwlhXlT5s?=
 =?us-ascii?Q?Qdxqm89SSxCbNzR5+kKLm0DOm1IIHopcpBev/8uNH4pLYHWRILLPJIvccyIq?=
 =?us-ascii?Q?4ojIihFM83xWqG+yI+R5rfEBiCHeqIXrT8Z7hyLwZL4A8gf1pJLZUwM1cl9+?=
 =?us-ascii?Q?Qeo2OmbZurL1KzjBs6zG81S9OSt9dBrxZ5cDt/Hiq4xF+ArInG8q2hDhsGYS?=
 =?us-ascii?Q?4s3/A4/XdcjoWfI6yLSyrxeq4SyGW22WduR3rRiRerefLVz5rqK932w/x6PS?=
 =?us-ascii?Q?089PNQrYac1rx5RYjeWlgq/9DXX88v98haOt0yAOTb16sDPA1KkE3QdO5sRU?=
 =?us-ascii?Q?u1pX51NyrlKULpLrZyR/+ZOJBOsc73lKvjlACQbeDdOCwK6oQLlv6Lw/Zh40?=
 =?us-ascii?Q?haSCmAlVlYwdYG0oOOUGjmmbuTtti00kbBwOSmFiQgP7iGoKkQYKhckG15SY?=
 =?us-ascii?Q?Ke97AUVWzkb78JZaP197YXjUtg0/34PZUoWnlFe5jjx0FSXRlbQsMS3zp4JX?=
 =?us-ascii?Q?ehg6/AOZp+ggfSrCcOFkhknvU5K7RHjFtHT6gY/SBGnZlntBjIeRRl6J9zMT?=
 =?us-ascii?Q?YJVxxcwEIL8scdcUmE3U8D2+3MHM8nkz5prxXRXpngMf11G7/nxbw8BB+uKC?=
 =?us-ascii?Q?yq2yyWK7eJtlFA6lBP1O2KcapeHcS7tQ/yZI7ogk84hFh7GrPx/X4aMLxIst?=
 =?us-ascii?Q?n3M6zo0da4SeRXOm8ZE81PLcJhaayuFSKSfE6lrlDLWUEmUzwRZ2F6r8x1y7?=
 =?us-ascii?Q?jLFTPdQslHmzBwXBOj9uUW5+KbfwuC3vtdEN7YUGFMPiAO74nBy93IMIN/Qz?=
 =?us-ascii?Q?INb5GyFQVpWT/XWh1N+xXGKTjdpGCYH47Wbc8UzgDgWt1jngjYjWwGTaUWwr?=
 =?us-ascii?Q?v0VhPpcgsPDKxHUWlO5z6BXVQbODyYOqrgD20kwszNiXinRbXU5nw50eJkS+?=
 =?us-ascii?Q?x4FnxJY2PAckE7eltpyt3ophL91lnCpYcW0ILcSheRn37ALWtwemuAso6+Rt?=
 =?us-ascii?Q?Fi8dmkm6QcbuxU2+UCCWpUGfK2rkHoTiImPRYBzz13LAvx8G+ZTnXMBEOnP3?=
 =?us-ascii?Q?V4bg66DFsl9gD/Gk6wR9gTiUtE93dUvkhmWVY4XufnGp+R8gCNJHWuwUlm4p?=
 =?us-ascii?Q?hrKPM4SozS+4qwlz3suM8CvOTNZMOr7AyrKCU5tHv82ft0RBKEf2IHP9AlDC?=
 =?us-ascii?Q?5dgggxKJcL0FkMEGfVJOOUTJsISQnQbNO6xn6tkM00VXCkRFfBXyCbkSjbNu?=
 =?us-ascii?Q?hSD0AYshm4c/Mck6XwuQrlSgm+DsToo7dUW0vjoMs0f3VJER2PAg4jWLUIYK?=
 =?us-ascii?Q?Uqt7WSL/IONiSzN/b3GL3MHrcuDZQuwk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:41.5425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577c7738-78d5-4017-da05-08dcacd441e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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

Add missing debug registers for DCN32.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index fee67fbab8e2..7901792afb7b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -505,6 +505,8 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
       SRI_ARR(CM_POST_CSC_B_C11_C12, CM, id),                                  \
       SRI_ARR(CM_POST_CSC_B_C33_C34, CM, id),                                  \
       SRI_ARR(CM_MEM_PWR_CTRL, CM, id), SRI_ARR(CM_CONTROL, CM, id),           \
+      SRI_ARR(CM_TEST_DEBUG_INDEX, CM, id),                                    \
+      SRI_ARR(CM_TEST_DEBUG_DATA, CM, id),                                     \
       SRI_ARR(FORMAT_CONTROL, CNVC_CFG, id),                                   \
       SRI_ARR(CNVC_SURFACE_PIXEL_FORMAT, CNVC_CFG, id),                        \
       SRI_ARR(CURSOR0_CONTROL, CNVC_CUR, id),                                  \
@@ -761,6 +763,7 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
       SRI_ARR(DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, DSCC, id),         \
       SRI_ARR(DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, DSCC, id),         \
       SRI_ARR(DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, DSCC, id),         \
+      SRI_ARR(DSCC_TEST_DEBUG_BUS_ROTATE, DSCC, id),                           \
       SRI_ARR(DSCCIF_CONFIG0, DSCCIF, id),                                     \
       SRI_ARR(DSCCIF_CONFIG1, DSCCIF, id),                                     \
       SRI_ARR(DSCRM_DSC_FORWARD_CONFIG, DSCRM, id)
@@ -1185,6 +1188,8 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
       SR(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL),                                  \
       SR(DCHUBBUB_ARB_DRAM_STATE_CNTL), SR(DCHUBBUB_ARB_SAT_LEVEL),            \
       SR(DCHUBBUB_ARB_DF_REQ_OUTSTAND), SR(DCHUBBUB_GLOBAL_TIMER_CNTL),        \
+      SR(DCHUBBUB_TEST_DEBUG_INDEX),                                           \
+      SR(DCHUBBUB_TEST_DEBUG_DATA),                                            \
       SR(DCHUBBUB_SOFT_RESET), SR(DCHUBBUB_CRC_CTRL),                          \
       SR(DCN_VM_FB_LOCATION_BASE), SR(DCN_VM_FB_LOCATION_TOP),                 \
       SR(DCN_VM_FB_OFFSET), SR(DCN_VM_AGP_BOT), SR(DCN_VM_AGP_TOP),            \
-- 
2.43.0

