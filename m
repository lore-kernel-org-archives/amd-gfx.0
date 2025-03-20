Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5840C36001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7621010E3B1;
	Thu, 20 Mar 2025 16:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSnIesrk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13AD10E3B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+A3g/kWwhgT7KV7Kn3QFUv9cF/736pMiKTqkZZbvvNwXcTYochXdNSrB3cKZMRSB8QjZLbpOwbReZTFBr+ZY7VcVxtK2jGKl+gBkZeFmWCbBLC1NFAQYpzkhhJ4pL8MFc6Tmd9FthumLAH7T7aHjgPXh1GudxQTu+qgbWwC8pKJYXVoD6iWCjhaVux6pT2yvPqwA4maanaZ696jy9mQUBJnX5zDBj9QKqZ3NrthnY6TNVoOsEPSUKu6uHXqB5Yct1lqiDfToUUVawPZxa7y3cHMUXEARzUw+geNZoyVUrHw3o0kYDo2ow+7Mpb8nWUL2S7Z3HesVAkyQT2iBKuIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQiHgNxqS+hAan/eouTJ64ty4fuwdwXFKvKrUZNPUYw=;
 b=m2t8aJHkO7oi6v2tWwoImrPRtIWXfGPTdJ+MY8+dx/HtUEMEm0EtBCLfYtMX4C6BNNmuJcxg+juvbEOX0Q6jEWMs9kZuc2FhIE6cm2+Ba8pnLxg7SysWNNtETG/hf3TQObcVNepz2uqA/FIlm0JSLpgs0y/57mLfx8HsvcZ190adFFFx5ToskuYMdLGcFl2YqPjckF7SoMk1vvamGpkCJTHS9afLhcaxC6JWlFojgBqfWuEPz1sFcwk5OK1EoDsMMTBmRK5kn1VwcIpaSg6cj6FPjcxs9aiBNSJFPlPHA8xyPCtkx8fq5TrmoFIht+B8xynaGJMzUVzbnhAL85AKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQiHgNxqS+hAan/eouTJ64ty4fuwdwXFKvKrUZNPUYw=;
 b=xSnIesrkY123wiIp1H397AhBKc/9PJbPKp/JtarFU2/zlx2gdRA1MkAnfid5UOnnqOsbX+eZqjiT5pJSOgwmltGybvDQwmOfJQlEVq7wq+on0m8mkRnBppbpdi1NlGr2AWbeK+iV8//LzEa5SCeHBjYc7zrRPembhiiAjKTarag=
Received: from MN2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:208:23c::13)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 16:56:51 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1d) by MN2PR18CA0008.outlook.office365.com
 (2603:10b6:208:23c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 16:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:56:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:56:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/gfx10: dump full CP packet header FIFOs
Date: Thu, 20 Mar 2025 12:56:32 -0400
Message-ID: <20250320165634.1245798-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320165634.1245798-1-alexander.deucher@amd.com>
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3919a6-d6b4-42cc-9f94-08dd67d03598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jvgM0jFO+3CiZ462/o/wPayf881LljmVl+Xc0PLIMfOy0UGXyjQiHyv4kdbi?=
 =?us-ascii?Q?7J++nfDOCLAEtTrEy6AMExxZcXFxu1y9EIGpjcajuJmSLvwix04Y6Ux5SPmB?=
 =?us-ascii?Q?M35LmjxX84foR0QW8LXn9/3F3JU5H3GiLezImNUNezk0TGyU+8J98Uc+zLC7?=
 =?us-ascii?Q?UU5878FbZiBKxc+CBOuGMQKcgbzbUTLYdCWEZXkdXyoEHLd/DIBe82s91G+Z?=
 =?us-ascii?Q?9tbG/tIYJ2FD5+A5kO8w2Cqu6i1hOc/CTu71zpE4DRaUnTfNq5GNBKwoaoDg?=
 =?us-ascii?Q?XjMQOS6Kqj/NH5V4h3cc3C6kcwq8NJ8FnwMbmpunISb1qmegPa26OZfx4kAw?=
 =?us-ascii?Q?vwYVNxfCK6DTKilmhH0EbHWlm8ouUsXjMxzI7e7zUOrOd/LJw9eSEgYmKOTT?=
 =?us-ascii?Q?xy0W74z82b2x1BzeeOniJOJhyIyFWRIa+rcgnjFZC4zzTbg7lgFoyRMbgves?=
 =?us-ascii?Q?r8p1X2Sev5hQeMsxkPbdLT7Ipk17NMPcJYlQE52nhFZU0aXV7Od45N3IYQHt?=
 =?us-ascii?Q?UpOgN09nMHnFBkcK3KVg3MtD7d4QSvGfPIbFKTEcIM+FB7LQlF93WWeHettF?=
 =?us-ascii?Q?8tpkFNyv0uIlcZH8XT0+y8FFWYkfoesxnkTKNmPcOJyu2ceSBQdKYQx0v80P?=
 =?us-ascii?Q?Q5EHzlKVJvVnK1PChBkCITDnM4DIjG/n2F0Zvedht0rqN+HAqrzJi+dNFs93?=
 =?us-ascii?Q?wPoS3Gld9mQ+FPu7asqoIMnomUqYVXI0vgek1GfeaE+8sKjbDFHqBnRX2Yum?=
 =?us-ascii?Q?1YQ0Z7kvTrczJnDnVrNQZcLcMCY6DJvNTQyMf28zrM5ucug2M1oRTtTYtwRM?=
 =?us-ascii?Q?ef9ouKGvJFoVg+4m2CRA+4WDHcBAmx5PPOWtVMllIS11Xi2kt0fzQjmYIZZB?=
 =?us-ascii?Q?phBMdGlh3HLP9M1FEPhz9WueI0j0qV24kNZ165aKeOiNl/o/fLX1FVcKBYwq?=
 =?us-ascii?Q?4FB8fP9EW/ZNv6XOg7UhckL+AkjCSS1FvHBFa/y+IDsIcqyeO1KbtGwdZjJw?=
 =?us-ascii?Q?ptcxfPIACBEXySiHG1uoL+J3lIH80lTuCXdLWGOSuXs4wpXd7x9x8s5xt5mc?=
 =?us-ascii?Q?JH0j+qBTpUvnKqjPprjCiP1P+XreZNHROSjrUFNRLIMs2rVCmOG/Pa2UiK0x?=
 =?us-ascii?Q?dPEcxFkdzq3DMw3hIWNlgTlhYKWJwuo6xmc1INDYXxG3Na7nc5rSTtDzukdQ?=
 =?us-ascii?Q?ExDth17heg/aTl/sRJU30a75w/iB5TCfKy8gFqsUjregbG/ztFvb+HVMWlH9?=
 =?us-ascii?Q?KzV/57XNwYD9XiSz1BMnRBFOQnTVLa8v1nI2BzgTeq91b7YICgUh/yzTbx3B?=
 =?us-ascii?Q?3A3GEYp3DBJyP6Me4hH+4D0aJdBg+OrL2bcLe/bnDgh9vgIfX/8S4xrYF36A?=
 =?us-ascii?Q?DJFORsZRs1KRqHNMoaAKaLul4OTWy7Zah46fnV7/l6kTsMaL77PlSlwenaqf?=
 =?us-ascii?Q?1lJhX/fu8V9naSPGcXriNcl0ldQM8KzgdphFl7QtzPn5BQNJl/We9isq2DhG?=
 =?us-ascii?Q?yUsTNKIByUpD4y4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:56:50.6062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3919a6-d6b4-42cc-9f94-08dd67d03598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

In dev core dump, dump the full header fifo for
each queue. Each FIFO has 8 entries.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 64 ++++++++++++++++++++------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2275cdfb38cd1..0a817403ceaa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -368,11 +368,6 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
 	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST),
 	/* cp header registers */
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_HEADER_DUMP),
 	/* SE status registers */
 	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
@@ -421,7 +416,16 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_10[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
 };
 
 static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_10[] = {
@@ -448,7 +452,32 @@ static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_10[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR_HI),
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO),
-	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI)
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI),
+	/* gfx header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
@@ -9714,9 +9743,14 @@ static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printe
 			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
 				drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
 				for (reg = 0; reg < reg_count; reg++) {
-					drm_printf(p, "%-50s \t 0x%08x\n",
-						   gc_cp_reg_list_10[reg].reg_name,
-						   adev->gfx.ip_dump_compute_queues[index + reg]);
+					if (i && gc_cp_reg_list_10[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+						drm_printf(p, "%-50s \t 0x%08x\n",
+							   "mmCP_MEC_ME2_HEADER_DUMP",
+							   adev->gfx.ip_dump_compute_queues[index + reg]);
+					else
+						drm_printf(p, "%-50s \t 0x%08x\n",
+							   gc_cp_reg_list_10[reg].reg_name,
+							   adev->gfx.ip_dump_compute_queues[index + reg]);
 				}
 				index += reg_count;
 			}
@@ -9777,9 +9811,13 @@ static void gfx_v10_ip_dump(struct amdgpu_ip_block *ip_block)
 				nv_grbm_select(adev, adev->gfx.me.num_me + i, j, k, 0);
 
 				for (reg = 0; reg < reg_count; reg++) {
-					adev->gfx.ip_dump_compute_queues[index + reg] =
-						RREG32(SOC15_REG_ENTRY_OFFSET(
-							gc_cp_reg_list_10[reg]));
+					if (i && gc_cp_reg_list_10[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+						adev->gfx.ip_dump_compute_queues[index + reg] =
+							RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
+					else
+						adev->gfx.ip_dump_compute_queues[index + reg] =
+							RREG32(SOC15_REG_ENTRY_OFFSET(
+								       gc_cp_reg_list_10[reg]));
 				}
 				index += reg_count;
 			}
-- 
2.49.0

