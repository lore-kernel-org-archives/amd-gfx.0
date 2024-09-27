Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408BECEBF76
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E003B10EC13;
	Fri, 27 Sep 2024 04:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YuYicPJE";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC66010EC13
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMKIXW5hse163WUA4jvLLYoizvJ7GueLS92eFwMi1mJE+DMyRH8HE0EDa/1hOn04qrJnzEYzB6NJ7XGq4lErjTpe/hq9EHKqlApUmuuJ5BHjNQIfXGe8HMrOmay1UnTtF78LWJ0uHsZb5UWCimSR8q+G1cguYxKKyQfsfPuB6KA6KQQtsL98FJnF9iP1pmnAtD1CQjJw/Amno3E7xCf1UuZF4kRRAznyLfZINMpTmbAqzgVc5avvCmYIuoy7mgteqDs9W0Wp7tRPuK7vzaUcnzc+QDqUwLmvZ4Irc50W9A/LGqGZvYQ+3sZSat8Rs1tUz07or5lubioIrEG7EV46SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmNpe2lClgW3YLsj+bxsi1AycQEyXRHxw2vevx8ArIs=;
 b=nv5zNrPuvU8FaeasQvuhhtQ2mo/qZFTVTYx3SzaZWMrsQ18/zWi5rN/rkDWp9bOtvJwELLkT8/v5Y9GSmUpAyqUR4Q61MiWpjGuG3VTLklS+RV1QFUh7H/VOqny5FT9bUkw3Ny/ye6cNKfNgbVbva2OjG1TTEgw8KI8HQ6Ap1WDgeKYa52d4t+5cIZeVe5FTZ0TOWHzYvLO/LokIVEZg8XYcsMCmTI5OOEWM/2iA/zv09vXuSrXojP6R0cpvywjHP3OqzD8ZT6uY5mAKlBbTGsKCq1jpuEw/US4dj1OI8V+Vg1N50vqweLrXud/IVnxJqYNu6y1AST8woT6WBhkrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmNpe2lClgW3YLsj+bxsi1AycQEyXRHxw2vevx8ArIs=;
 b=YuYicPJEHqh7JXT+y2HoDJxxDCtT3OO4j2ld01yKIvPJkYh0AADpFEuyYjXif1a4Yv7IXPv6BjbETXrLNb5egik4R5L1FlszNs+AEDa9mskvqf1TIyW6e1+Z9vdQ4WxFqVmWkPTynS+dPUr29HgHDhlm0nko6S1ahkqhwFqkeLs=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Fri, 27 Sep
 2024 04:58:19 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::19) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:16 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 7/7] drm/amdgpu: Add NPS switch support for GC 9.4.3
Date: Fri, 27 Sep 2024 10:27:43 +0530
Message-ID: <20240927045743.2718949-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045743.2718949-1-lijo.lazar@amd.com>
References: <20240927045743.2718949-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d2eb64-be53-40fc-1cc7-08dcdeb1015c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9T6eaC8Z3nC6Lntzx6OMJa4tnGtJzpK4t1JzCz48ueEH61JN8UABpDFQ7Fq9?=
 =?us-ascii?Q?dBHWwTakrFg+RFgJPr4Gijvv/QI0KER/2OgdTdM3y6ZG3kufjkue3vViAE4K?=
 =?us-ascii?Q?aW2oye7ZqNse1ITQEVfwxGqBMjEjCYNhmkJbFLhZIky31BnuPe8TRCQexnDy?=
 =?us-ascii?Q?3QDm9sPl/3qnp65wB2r3xGHEPddV0OytlR20lOEbgewdi0092MgqPtE3zPrm?=
 =?us-ascii?Q?hM5q8hWhGn8js5WdOAPsHnSrKJhpf0WvqTuGW9mEYtASreq7IiPdVkVduIS3?=
 =?us-ascii?Q?Mh5WMBC+3IgHpPotS/vo71PoozHptWfHwtYHc1LPrzNvmtbDqziMNyrIb6os?=
 =?us-ascii?Q?WaMhhD/VGQv4hSqw2q1SV/rJzOusbCR4eo8dnd6KoKKSfliM0oZhdpRyaVHZ?=
 =?us-ascii?Q?lvofMWwH9pdKpQ9n9NjGR8tPugwVLA/yD0TJVYuMZGCMU4A14HDTonlsMXFI?=
 =?us-ascii?Q?r9zWx5TS8bdKzcCZe89DpH85CE7Yn/OnkmfsiVMho1BA2pjWUUzMBRzNvNGK?=
 =?us-ascii?Q?pICGgtFBft/13B9i2b7heFp2Ubwpm69m/RsGjoQbtRSWpZ8XAl0cvZj5xaBU?=
 =?us-ascii?Q?+Vp6CJcGL6k5MOfZestm6tAIsdeKciqfsjcqsKK1SNf6TIBXe91hEbl/zWh0?=
 =?us-ascii?Q?BKsFJK69ZElbby02blq9EUNvT+8xVzR+NcT2FFareNhsGTT6lf93tJ48Uv6b?=
 =?us-ascii?Q?ixQEWbdee24r6Ta7k7qXoFhKimCxl/qkdSUk4/m2htfex0aN2T3mc9xdnFT8?=
 =?us-ascii?Q?bkxIbD6hXnvm516GE7JT76xPFdbjSkmtetJivvm0SY/7EyZenCBKui6mYdCz?=
 =?us-ascii?Q?8mxoZaucgt+PjHlm1pGBx2/Ky3na8vxRfTe0M+unTbtte5MUvUoAkgAJcNO1?=
 =?us-ascii?Q?c8bO4f2QlM1KUWSkQdec8CE1I+Qyd4reRa0J/WRME+lNvRSC+bMQibmXh+ea?=
 =?us-ascii?Q?kS+GlfmCR+2Dln8CcS9mgsNW10RjbdkHmr4OGy8d8zHq85Pwfzr3qIEb2IGz?=
 =?us-ascii?Q?9dBsYfagIWK1fCFhDMQ4Hlutl6kyeAwFcNeKXyz5FWmMnjcvP8J29WwqvLXK?=
 =?us-ascii?Q?t9Va7I3yiUfWhTQ4NhoOUVd+LnfExYWB9E2VRiGG9fAkrh7poB7P4+RUfwcO?=
 =?us-ascii?Q?9ZP0VXe2wrK6l89rdC8z+ZseHdTZtuCBClbNTDMyzYDeIC3wr4E+GOyJYnIA?=
 =?us-ascii?Q?se8UIiFStlMojXcde05uKcroEDAr0WiGlu+H2lHILTysyEW0upYWmcxmBkOV?=
 =?us-ascii?Q?c6kxWSc9X6/f1BQisoWk5dipyqXzuKOBnanuOXrKcVM/6mTNAm9u5G+CdBfO?=
 =?us-ascii?Q?v7z48Z6NhW2iXrs2wYC7DAPVDlISwzhDPeAjDi2cDAYL+oIM/DUAcVRTq2PX?=
 =?us-ascii?Q?tP4pAo87pzMe+ED6HLPEkZkbZswGByJhsOTXdHpd2wdbbLpOw1sGMAMhs6Nq?=
 =?us-ascii?Q?3Z1ChNlypeTe4HU3aUUoGaLmgOxoUQnh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:19.1753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d2eb64-be53-40fc-1cc7-08dcdeb1015c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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

Add dynamic NPS switch support for GC 9.4.3 variants. Only GC v9.4.3 and
GC v9.4.4 currently support this. NPS switch is only supported if an SOC
supports multiple NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 44 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 12 +++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index f61d117b0caf..79c2f807b9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -101,6 +101,7 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
+	bool (*is_nps_switch_requested)(struct amdgpu_device *adev);
 	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	void (*set_reg_remap)(struct amdgpu_device *adev);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cafcb24449df..6a95402985ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1395,6 +1395,17 @@ gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
 	return gmc_v9_0_get_memory_partition(adev, NULL);
 }
 
+static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
+{
+	if (adev->nbio.funcs &&
+	    adev->nbio.funcs->is_nps_switch_requested(adev)) {
+		adev->gmc.reset_flags |= AMDGPU_GMC_INIT_RESET_NPS;
+		return true;
+	}
+
+	return false;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
@@ -1406,6 +1417,8 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
+	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
+	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
 };
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
@@ -1545,6 +1558,28 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
 		adev->gmc.xgmi.ras = &xgmi_ras;
 }
 
+static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
+{
+	adev->gmc.supported_nps_modes = 0;
+
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return;
+
+	/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
+	 * supported modes as 0.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		adev->gmc.supported_nps_modes =
+			BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			BIT(AMDGPU_NPS4_PARTITION_MODE);
+		break;
+	default:
+		break;
+	}
+}
+
 static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -2165,6 +2200,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	gmc_v9_0_init_nps_details(adev);
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
@@ -2440,6 +2476,14 @@ static int gmc_v9_0_resume(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* If a reset is done for NPS mode switch, read the memory range
+	 * information again.
+	 */
+	if (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS) {
+		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+		adev->gmc.reset_flags &= ~AMDGPU_GMC_INIT_RESET_NPS;
+	}
+
 	r = gmc_v9_0_hw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index d1bd79bbae53..8a0a63ac88d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -401,6 +401,17 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	return px;
 }
 
+static bool nbio_v7_9_is_nps_switch_requested(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS,
+			    CHANGE_STATUE);
+
+	/* 0x8 - NPS switch requested */
+	return (tmp == 0x8);
+}
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
 					       u32 *supp_modes)
 {
@@ -508,6 +519,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
+	.is_nps_switch_requested = nbio_v7_9_is_nps_switch_requested,
 	.init_registers = nbio_v7_9_init_registers,
 	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 	.set_reg_remap = nbio_v7_9_set_reg_remap,
-- 
2.25.1

