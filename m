Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F68BC5B549
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 03:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1146010E5A1;
	Tue,  3 Jun 2025 03:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mYnB7kU5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3B410E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 03:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igjqkzKLvvgwMhFrLSeu29n0MxwUjEF6UQdPqr/RBWDHQ0gAGSl/6ZoqlBn36Qjm+ENgDhHMaYiUdE8pOJTSZKeGXWzoJcOaLqvLfUzjHZtSM1P+f1QwxOkRLGnAMm/exqxbgLIajggHKCPVDl4op5PtkTlFEiS8CkSZ3NrfpDOWdGsF7KeS2QZjca1gTiSp0Sv7/eSujbcOAPNsFzBR4eQhhGRtVYpmmf2AsMV0927aR03hRYSZ0RlFHhrf2YtAZAcF28aXJjZJpk//LERGXEBoDZy8pmlGsKga3aavCebm0CZhQvptilHjjkCPvccpXCseAv1lNotzxR2XTWJ9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yewyIDg6wwFqfzhnPsUVI+lsqO3l0+lKKd7c1rgCmr0=;
 b=pW9wfnejZDJNnTOS8sOw/K4qfk01dQj+meXly3pNW3yqJvxlwaV3ZsG89kW1/SO2UlgJGOX4WyailghTY2AVtq2kj+aVOGzsywCTgMDhkJehnDpp5yMtb6uxMKJxpPRVV+Zxn2EwHkOzvPa3VwXDJdhbTtHNaG3E8QcpwvDDWXUNAX09HIE54Y7Hyg9EuesjabgVf8VY8U/3YIEXr84EXj+F06zSxBMe8P8pm+PYeS/2K0E1UTitDyX/bxaZeMFmu5ym7G5MvNs2yhS3NxK1O3KZWwRmABkzcfx+MI+giPb17gS+UrkPtyc3hTEbsVOurg8V+oFCCjG6PpeAyvdxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yewyIDg6wwFqfzhnPsUVI+lsqO3l0+lKKd7c1rgCmr0=;
 b=mYnB7kU5POU0FZWhop7uyB6kJssZ4bcn1J3sEeYvcXJ4xBFYTmd3f/wUsVbnjtC1bfpbFZ/ERr6Gsra/cltPj4NqVrQb/i5Z+GFb/5P0FtLBvRQSBRHueBRYdH3flvYwhomWGwGZqyLpjwkmN7jsK96adR15qma7jnk0FifHhVs=
Received: from SA1P222CA0129.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::9)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 03:12:53 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::21) by SA1P222CA0129.outlook.office365.com
 (2603:10b6:806:3c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.23 via Frontend Transport; Tue,
 3 Jun 2025 03:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 03:12:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 22:12:51 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 2 Jun 2025 22:12:50 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Move SDMA queue reset capability check to
 node_show
Date: Tue, 3 Jun 2025 11:09:15 +0800
Message-ID: <20250603031249.3727405-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: d75b2c47-5066-4126-60da-08dda24c873b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C1150/DIl6iBCWyDV1xqHhELMn3IwV3k8C6pvNtvsGX/PX4A8PPf0YbO/JhP?=
 =?us-ascii?Q?/jEwMNHImKt7d5hq0bYFE+bOnldG464HPG2/fJuBo9T4GBaKkvRSTxpO5oy3?=
 =?us-ascii?Q?Zgb4Tavdux197GS+EpGZx6pwQ1dmVNd59XYxPF1p8HMRSLWX8b83dy2dJ16Y?=
 =?us-ascii?Q?BVQ4jRMuvNRoKxOiW3jOBqTPHM2Q+bXMWoalRg17Ihq2qQerToL2wM9rGPaB?=
 =?us-ascii?Q?KPvPTqLl7k6jOyqVPK2e9dz/9I/w4e+UBwbUElGqNoBt2Nyabf8fVc1iNNh3?=
 =?us-ascii?Q?M/oaw2C8NiBA5lIRMTomReRAhcjpGb+kdGkLS72cat8XDN5lpT5YFN8QmlWc?=
 =?us-ascii?Q?EGLyEoQq+QxsGHbEixHUUjL+HmfWt54XkTfGGoTPh8PN5zN6gmEr3c3j8KRO?=
 =?us-ascii?Q?q1A0m/O4OUEvcelvnWf2VQoOcqjKyKabmr70y2vjetonHAlN6h3T4t+UiQUy?=
 =?us-ascii?Q?N0nxj9eg45onz/2tWltlKIKgUb3oY9X3oqJC3blvjhsK7Ho3LQWPrC/5nVQT?=
 =?us-ascii?Q?OBoV5ITVVceGy8yhIR5AqqQvhPCGQC/o2TbZplDABfZ4YdZ5Nhug3SMMW5vA?=
 =?us-ascii?Q?HKNT/PkN4Mv9nFGgGiioK/qQGoz4GUH3PXcEs9erWaGUp5M+fhJezwXWlKW4?=
 =?us-ascii?Q?mM2aOs4F66KZQ5bQbO4rx8HRaM6eQUNaU5keLs0dIHFg/cjP3rEHPlIibBAB?=
 =?us-ascii?Q?Aztpg4f34HoksIHFHnAUlm1kl/NIJKX6s0j5CJshWnf+p6AMikkZzMbWuZ3I?=
 =?us-ascii?Q?bxgRBhscLpIVDhysRwdPCvb5Ie+gjWZgP81HJ4l0JLQ80DAM2xF1W6JrM4H7?=
 =?us-ascii?Q?Rbh7iC3z17DynztMTh+V7tXOcSHjClwNOPaNssToNWUiRo1ig6HOiOHAtUt7?=
 =?us-ascii?Q?fph2pSxau6zKkkMw0oANtKqb1q+bJ0lHwh+/kGrRmpOsUHrR3G+IOOPC2l6k?=
 =?us-ascii?Q?jfeSIerarAdwoDdUCs0bad6TsbBisKmsRvjE3BksnjPlCL0ICRZdoKPKfqgE?=
 =?us-ascii?Q?OsiUai/C1WwqWcSccmxreWYld+q6rtNgkkXbVFPpiuWJrby9JdPVqmjnCVYp?=
 =?us-ascii?Q?OOGDWa1bT6Zske7NalutB07jXeqkDG5CqOr2GuwVSdb0j9YGKHcJ6PkmFqWB?=
 =?us-ascii?Q?gRZ0flxD7I8xDa3thS+xNr19dc3n8sBXlkGfh4OkvzbIXY7McBpoPag6YfJw?=
 =?us-ascii?Q?ZIReR+bY+9rfuCXok6KwMrwzNe3jJRp07WxowVzYX++WsMVynLTDA1V6VqJH?=
 =?us-ascii?Q?KDQDtLnG4gYap46ITLL9SeRrGlGUw7BeOmC67U2a1xT9t68wF9huFQxLuMsn?=
 =?us-ascii?Q?+Fiinv23EEwAt57ACY7C88ZxCkWKSpqG/uc1gL29LRbSXELU4KiyGPYW8Zst?=
 =?us-ascii?Q?c/S5w0q8YSGO4b3amhFFS4spD0eLGwzy1A6D04bfHqOjPDPzkr6JdGRqi45+?=
 =?us-ascii?Q?FYWA98e2R+qU8TcJBH14TOOL8len1XLhzxrGaXhuNK1w/hFXfFus4AD8bCu+?=
 =?us-ascii?Q?XDrUxavK30X9aoads4zt89XLAB2zFFgi5fDm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 03:12:52.5749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75b2c47-5066-4126-60da-08dda24c873b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

Relocate the per-SDMA queue reset capability check from
kfd_topology_set_capabilities() to node_show() to ensure we read the
latest value of sdma.supported_reset after all IP blocks are initialized.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index baa2374acdeb..e123952e9a74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -510,6 +510,10 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			dev->node_props.capability |=
 					HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
 
+		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0))
+			if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
+				dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
+
 		sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_fcompute",
 			dev->node_props.max_engine_clk_fcompute);
 
@@ -2008,8 +2012,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		if (!amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
-		if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
-			dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
-- 
2.49.0

