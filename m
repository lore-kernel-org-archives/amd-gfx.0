Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40558C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 07:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B680510E8CE;
	Thu,  8 May 2025 07:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szYCW0sP";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E34110E8CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 07:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0BnL+9m5/p+QnY3V6AHU/bhqo1DRsY3sr9nG3iZpG34HhH6HbDFPhlDWrz77dLaEKW0n6pieEVvkNg40WaplrnmD/zV3CMLMcKlGSQvpR573TMdcTNF1E7mnhYAGMw6gfUT2DZMnl4Ss+rYaqoYOWNtkL52xgWDOX/FHKKnpH/iA8QABVgRGwaqd3r3sx4+o5h/piB/SXlwBXun75SttV9KEntAF/1NLw/GITwlHiiSmKalUszbpXHtINnR/841XQXhk7PrbJKJ9pOC8oP9SGzLdOaoFaL1Na8GYPzHGuMg/l+DKNbAckh+HSgUvhSB2OER6kjG1sXYXrEBnpYLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9EvOjwLPaazAG+e8f4BJ3WHSTFzKBWWyQFSlIobOPs=;
 b=JcsHV62VRdAtyYecObASaqYVotxgdrzvhCJBdWeTEeujqU7RRJy1bfloe6D2zSyBt31LvpwbHQdD1BhXTphA27KH+kxkH2BeQ/zJg9aX0brNJ+gCEvL6Mb/yHdE7YHfzzeOFNP+o4nwvOW/I4Xil7reRClNccs/QaYFLI1+ImQX2szofx4nk4HtLlF7Azq3+sINl5NuZ3zYjjrj4SSdU+HZ45o3hC0QQcOt2vpKpC46KTpKGzwzEayjgMVBKSqj3DNyEqvi+ENHSkb6XIi83Zcd43Oky5NIav1f4HjClNCKRY2aWfFrvHu1lBQp2xAToSgX+bvChAeZQtue6T5VDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9EvOjwLPaazAG+e8f4BJ3WHSTFzKBWWyQFSlIobOPs=;
 b=szYCW0sP5lanpR5GWfvZL3hLhTtKX/90rNXJOIJeopXllT7yolZTaHk6BDJ5iMT42+pBLS0grssTNgoHbUN22c3k3JeeQ+hpDlWF7dLsmrYb4MIlh1YgemMcRgyT5f71T/UVQNoE1EOStnlTagrgbNvyEdIUY7y/jM1D6FulSxM=
Received: from CH0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:610:b3::21)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 07:31:06 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::bf) by CH0PR03CA0046.outlook.office365.com
 (2603:10b6:610:b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Thu,
 8 May 2025 07:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 07:31:05 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 02:31:03 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <tim.huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect MALL size for GFX1151
Date: Thu, 8 May 2025 15:30:00 +0800
Message-ID: <20250508073000.1172588-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 9364fb94-60b5-4c22-4f77-08dd8e024ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V0/3RusAKc04ke6hX7aOdOGMrh+S7QSiGcGy40A2/5oUB5FAfdyzTnZ+A/wN?=
 =?us-ascii?Q?ZqqWRxsuBDCRf97L3osVa7mDkK8HNPjpDHGRTIqD4qQALuScKXDAwOVlxYmT?=
 =?us-ascii?Q?HtX+Ls8uueiWG8+19HR3GSpk0eyQl3ysUg4ZSUBXxT78L6NtO22hnA4pwi/Y?=
 =?us-ascii?Q?3Sz3OpqpPbvUHpDMgfzWhjO++vRzVyV9NstNUaBJVjiILQeq4n1cItKS/xwe?=
 =?us-ascii?Q?IgCqGJRvj2YYa7vcon97UQe1A/qaoA3E9YRDxnAc8+Qn5ny6d8zqIDqL3C2X?=
 =?us-ascii?Q?oFczRiqK1EeY/X7vYzawDZ8IDLuPaI8HvEOr6xn4hyBR+OvimpD1TmSiDAjS?=
 =?us-ascii?Q?TC+g6+16zbtngqbcPgi2Y7kvhDGmyUFZcvfkuViyyVFT8O4uyy1OkDftDgUb?=
 =?us-ascii?Q?zXKBhslpL0z6+y+pdlklg44PQoWaSSAwk8WEDuAZBdiBWnuBBmCIGv/0ASMd?=
 =?us-ascii?Q?2+2haSh/jdsO2gYBwJnkCVkUgLn8kv1eZv49ibS9wx7zEMdDU/y7qbDy2e3V?=
 =?us-ascii?Q?80ulOrlFlTy5ysGlLYfzqqVsHdoE/xUMo5gUsrr2EGN0khXRiMTHEBq5KzWF?=
 =?us-ascii?Q?eCRJSvqn0uM0JIXEfeWkVSNSFV7R5dF4WyyOMTQ/u5clTmKoX8UcVWqnavAc?=
 =?us-ascii?Q?ZkDl1jLBhV4lYUM9gMyNAw2KftE373ux47PZk3ed6qgaU/hCjURaBPYxoPkl?=
 =?us-ascii?Q?nJGBA7c0AZK5STRv4DDAye2JFHxWjrcB1tb/7EWkNxK3bzgGv05+1/1lFjiY?=
 =?us-ascii?Q?y4WRyUK9qGZvFXby4TwKvtYmoqbKgKcvPFqQmg34Cwv/jtAmuGgnce1fjYk9?=
 =?us-ascii?Q?66OSfKrDVADQpmeMuLJHDzTtQggpM6NwBTrr/jDt1pmvwDtH2d2zCNPY6JjZ?=
 =?us-ascii?Q?lnAQAp8/jXf4/cNJivOM4hdsGhoKMHC1vaHTqICe/hQto3ldPBKJ+56veA+N?=
 =?us-ascii?Q?jFycD73ar4GrQJE3snou9BmfsXWeVM2XACPUj/fK/gqDdApD3qqMPFXpWS+S?=
 =?us-ascii?Q?n0yScOQNR/Nf1LiHCMPPxi1ZJ7aHdLmEPVmFYcxPmZtVXm1ajd2cwy3bzltq?=
 =?us-ascii?Q?TMdxiTXHuWYbwdIZ7dcFXZAaqEfjKoYPtDZNOaCeSng/NvrE5Ws3IT41nr7X?=
 =?us-ascii?Q?hKeZC1TRE89I1gEGUxSEpWB+jlhYu5q4W47j/mI6MS3Zm5XJgpVmhqT9nuuV?=
 =?us-ascii?Q?an8oE4N12YepYB3KinG3Wu1FEyNMhV2ipDBkdhkswGpG1Bt30UIW7V56cTWF?=
 =?us-ascii?Q?oKtml+vzyzy+dmIvvfCChwOAzh9q6PhgSMc2iAk7Xf5w5uWEmdwOwyT2wGBe?=
 =?us-ascii?Q?DPvtx5wPk2Lpole0rJr3NypVdj56DWOaEeLdjpC2jPLWjn1VzAdF1hj6Z8oD?=
 =?us-ascii?Q?1YkSipiAw3nOowsrpCxp064C6wyisIwMaZE2K29RmbeVyIETOv5+cw4TF/sX?=
 =?us-ascii?Q?sHMaD5sBHqAJhFkgwXy+pUW5at44nwFgNbaH84UDwNhb4cY278Q0McFSuhsv?=
 =?us-ascii?Q?EbCh2jXgNUu6XviylMNSQ3njFonIhU9qWJXg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:31:05.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9364fb94-60b5-4c22-4f77-08dd8e024ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
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

On GFX1151, the reported MALL cache size reflects only
half of its actual size; this adjustment corrects the discrepancy.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 917d894a1316..72211409227b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -748,6 +748,18 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.vram_type = vram_type;
 	adev->gmc.vram_vendor = vram_vendor;
 
+	/* The mall_size is already calculated as mall_size_per_umc * num_umc.
+	 * However, for gfx1151, which features a 2-to-1 UMC mapping,
+	 * the result must be multiplied by 2 to determine the actual mall size.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(11, 5, 1):
+		adev->gmc.mall_size *= 2;
+		break;
+	default:
+		break;
+	}
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
-- 
2.43.0

