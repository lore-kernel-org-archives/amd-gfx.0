Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3B0C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D6210E8A0;
	Thu, 25 Jul 2024 18:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40P73wBX";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4C110E89B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjGQl4tVUZsitNidqL1sdSFyKbeBTm/D94Vp5V+p7C6oFSpXcJwVDr4n70VqnOXCC9FsY+SpSL/IHnPbSIVVX4rzi3bKxI+midklU9hJMeM3j9Q3XR6Uom8vnbzAUHvDs3I2R6TK6HkCInn+W5uBsJ/vqMWLuqVtEls3+DSyjRY9JNg/RpDksTRBaa3E3l9BR9XWDzTkr0LKkHsMhgWucVLL92M3JfBY565ZY7wJsC8pwu52691i38twvHKpbC1EZOxMDlqA5t4nYOE3ogstwaVFchI+pHFKXe46BJTGNhF5ivlsBF52SrcCfOVPlbA6eWC6FDPOwYiYD3BPGmBZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgqGvRigR6ydUEYWiujc/BH0wAUJm6A6J1Jb9kXaCYs=;
 b=w5wGxC4IR5cpBzvLLk5hFA6iitMqUnNaVERZEBL4tWTtP2Aqx85uAa8BljA6bM3BwCBi3AGwwp0qcWzr6epP0Pf3llwPA9pFWUeT4GMbcSA89J5CSjHm//FOq+pKRR31sdLbCs6qMRkfTXIoJ1ItWDei1+h32qafqN8Ezh/dDExMAhYb25hmjR5PvnO5Wxowt+qFc/KmdHsgjthSQP+wzXtF3bnKizqQz3aSI2jHuHkXqGbW8prhFJ/7+5q+gPbTFEXhW2xGbsFs3dEnUUwBnI794OLLS9OpvGrQCv4OSWhJcuC1Yf/jmxjyZwA9qzWDLZTySvOpm2LlJwl8oRODPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgqGvRigR6ydUEYWiujc/BH0wAUJm6A6J1Jb9kXaCYs=;
 b=40P73wBXwKtKZ/wAxMKs7ZBe97tifOYspIV7xdyGBIXzXcXSyI4QSOR3nIshq1QfbaWmXEUIDR1N+V/wpZBo5wzg0ZqemiBwp9wUlmCYUq2odbmaXsQgEY3UEM0ZldySg9EH+Zfkt+jHQUpgiP6AZEzv/310EvZDrG3CPCvb2iM=
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 18:03:50 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::ff) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/39] drm/amd/display: Fix possible overflow in integer
 multiplication
Date: Thu, 25 Jul 2024 12:00:52 -0600
Message-ID: <20240725180309.105968-9-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 567b8c1b-a4fe-43a7-3935-08dcacd42341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n/FvQkHFZ6AtUvfonPBNxhP5FD13wnxeRfSXiJMbv6nztewdvBi8lduMf4k8?=
 =?us-ascii?Q?iG+WgHNYwcNuc6uU+VxfMMJKVf9UZmxl0UzAzhvAYZsqnCzBzOIGwg3zWdMb?=
 =?us-ascii?Q?BpOP5P++fhz6msCV0AofAD5FrG8yMt3WrF4MZ4mY7ZQYU4xUdT+fDu0+oBfJ?=
 =?us-ascii?Q?8YtlO50kAvflr5hKIFD0tkFZAcnDyL6H6L2QFT4WVliKElVBl2LixYKQROJI?=
 =?us-ascii?Q?JY0MVXDNFd0CXPpKVSrOogwTiMy+5zR7bVaj2y3wiwOK0jLyQ0V8lmvAOjqc?=
 =?us-ascii?Q?JWsVr7QoGY1taRprxm7XoNLjbeOAJXOcClVS7lsWJLvLjv2rx5ZksPvOg3q4?=
 =?us-ascii?Q?QbUSPjkA03LLyxXnblWox4540S3hmImsbD3MRMyFO9/QQjzaKIS1BOoIxHyF?=
 =?us-ascii?Q?x5q2AiqoLfzLfDkmRgqhYtUNb4WNJ7mQrL7dRPbmBZwVSjL82WvYNeK7rejL?=
 =?us-ascii?Q?CvxhuIh3iC8JV+8UGU1ZOAFN+aRWxLnCvaSii6bhnV3PQMpXJ/y7NzkCBJdM?=
 =?us-ascii?Q?zuQ6Xdz5xHKkTm++kqybh+J+jXJNLt7p6l0lY5jSsINdDnFRiexyLEn9Vj0l?=
 =?us-ascii?Q?sYgiyqCcnSHNbVaR2+7iMFMCPZCIVRZu7mxEd6oqwtNCguzMAKmSku5+CnaO?=
 =?us-ascii?Q?9wXiKb/d/r4+/Ixfi0cwkz8xgxqNDcuteFehlBMdLa7bvG/w6loO3YTt9NxB?=
 =?us-ascii?Q?o03kKr7swOs6iYD99ubUMHR2uLhJGzjYtJ9B0k43LHp7RAVyzUPt246Jl/ej?=
 =?us-ascii?Q?Qs+Yhsb62xhaCYFZJKxwtpfRfU08NrQKfQxRYXTx5rM14rvEptyYmZwcKFy/?=
 =?us-ascii?Q?i5xo0MdUm3WTVxQgtkIvsZIAaMW3P8TN2sPsQwC5LhXRxaIOQjzzBNp53tYB?=
 =?us-ascii?Q?0sNeICxrvoU21iq6HuAHZNybmolyoCO2rWvhfH4gQFKwu0RVrYzztz3QzLj0?=
 =?us-ascii?Q?bX18WQTGi7VWjRlR3cMoPRVcDZoH94Cqf3pd6ilaRAadyev1Y+2NEpBbySvx?=
 =?us-ascii?Q?RmKouelObHMn080kL8Pl5m9Tu1X7VqacYNM2XZ0B04FKivcwNDzhUZZEAkC4?=
 =?us-ascii?Q?rwMe2muyZ9eFbr9ccX1AMkPTzmsNI057CAgPs1waM7KH9VdbwlDJiA6cbYYt?=
 =?us-ascii?Q?LaNOvVNsbPn30MnG9uIZVkLX1oDKYTPPhAouT6i1rWada6RQHPcdhN22NOa0?=
 =?us-ascii?Q?9TxnhWJIaogu42Uk82Uy3fTvv8imXMgLZvIkpgyOAM9NkZ6CC6NdSe0v7ioj?=
 =?us-ascii?Q?/WcjBPT/b6ejLR6y2b4Jh+rK+wO6s76QNMLKnefx1H1PCtLm0avdMajHGx8I?=
 =?us-ascii?Q?VbBcf/ui1AqDqGrfspVck+pskFyIPbCRnFrgDlx38pobmv8lixOg9rCcbV2Q?=
 =?us-ascii?Q?Q8Cw+PkKJmJZPxwRaP7IK3oZ+7N+WqgsffvnSlunhju9F6zrTgj1PxXwCm5S?=
 =?us-ascii?Q?XhaTlorxbk/KM4E+HwhOS8ijPBZfOzQE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:50.2257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567b8c1b-a4fe-43a7-3935-08dcacd42341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Integer multiplies integer may overflow in context that expects an
expression of unsigned long long (64 bits). This can be fixed by casting
integer to unsigned long long to force 64 bits results.

This fixes 2 OVERFLOW_BEFORE_WIDEN issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/resource/dcn32/dcn32_resource_helpers.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index 47c8a9fbe754..f5a4e97c40ce 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -663,7 +663,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 
 				subvp_disallow |= disallow_subvp_in_active_plus_blank(pipe);
 				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
-					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+					pipe->stream->timing.v_total * (unsigned long long)pipe->stream->timing.h_total - (uint64_t)1);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
 			}
@@ -724,7 +724,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 				subvp_disallow |= disallow_subvp_in_active_plus_blank(pipe);
 				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
-					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+					pipe->stream->timing.v_total * (unsigned long long)pipe->stream->timing.h_total - (uint64_t)1);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
 			}
-- 
2.43.0

