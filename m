Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06B8C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 07:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5787B10F42F;
	Mon, 18 Mar 2024 07:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlN1wLV5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AE110F42D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 07:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdcqAvy8Po396kFWRg3/i0PQZAKQfgPEjXcjmh9yqGqLAi86/JDKKGS8y8aWkZp2GQ9cgqHguaDVwJ2qCdUeNF9mMtkwBtPGyKsW/YShu4mpZ6xjFl4j6v2BsImXAFMFUYPUPU6bDWIrPDP4gcO6+Mc8ejyuyGR4+z10XifaYZBqvclyHB0pdBRguQRbq4ndgXZ01Lum40SyMZlfqXkop2XahRDSuwCuggMNE7a+CUltdwdj6xkNLIm5oHFuBpnV8CNMEhLOMDYgW+m6rxvYbpO5uU+wjOKFLdwKw70hNRSHHITSB2cjLxqCDwZ4mMrVREHEwKnwjwr2SXIKXuOwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1ifXlhqiNRkVakdDcobWgdfCfaonvRSqXKJbMms+Us=;
 b=YvY71e621jDRRSUYrmCfcR4cUNm7BaSAuWsMZA7Y1U79eHT+Unbdo7g34aum7Hn+LFWTxNbfpu3KF4RpDG8Q8HDK3cv3BoVsxMorcQVuGieYAJlov4EDgXl3+MkLB74utS6A/UqlNVknnSlB9g92gOi0uiWAx7tIU37h0fLJ+FuoX5B/d+LIN9wBMuIe2XQ6Mu/5AyRbuookzfqV/IbM9tlPtZwUCBRRwNuoZg4sdFfGzwBR2BqzaKfaspJThqO94Z4Ypp44tixTkKod1I9lpBYIfoIQ/s8gKP06rDtfnMJl0s/d+ymGS4UHzfdtcVZ9H+Z1kFY7F/nRLwNq1KySUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1ifXlhqiNRkVakdDcobWgdfCfaonvRSqXKJbMms+Us=;
 b=xlN1wLV5wh7crinP10yi7xvotYRHvY/DzGswCxKAzf9mjkdha9XxzPgyT1MiWpgFE5rIgLhnmJkUzTrtaHT2pHynYFkYV9alAB6LRIvyiGQu8BfbFLU9KLiQ8WeqDP72CnPwSjKSXikt8KHoSKzVrMibCFg/OkUGEFeQNjgrkGs=
Received: from MN2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:208:23e::26)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:26:35 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::f3) by MN2PR14CA0021.outlook.office365.com
 (2603:10b6:208:23e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 07:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:26:34 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:26:33 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: support utcl2 RAS poison query for mmhub
Date: Mon, 18 Mar 2024 15:26:22 +0800
Message-ID: <20240318072623.352614-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318072623.352614-1-tao.zhou1@amd.com>
References: <20240318072623.352614-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: db6ccd41-a48d-4d39-90ad-08dc471cbddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVdADrKMrjbjV29MXk4OXcXAmf2ATPzQ5S+G0XodtmS44u+FM1tT7MAia+v6Fh0JiQ2atG5+gIdVK5eZTwtHomVjxz2dePTslI476SYrW5KSgkKspwkmSSOOLJlKjSkyifIcQQM2wqRgC947bZpmD5A1ZegJP1QTlVmwfA6tv5ckaTbCrnaBCAnZ/mEsiykIPqM6wLZUZfJfE6Jz26EEh2zdesSmUM5WtNdGNSWCwAmv1T4guyBgQJbh5bkfI/s2eU7JnL8zFr/15glBU15ekMM3M/7lqmhzYDjSGI4BjTcFWYPFuB2WqxJ34xKggivmjKPXLsUja+x2jZ/roYf0cebaNObw1Rx4BL0GQbC1lSZE1R5fR2evDjC3sVCKIQpMOqJeQmYgR3K31nq8H9ZYtQB+d50bPYca+jow6D/jVyZh5wSKKwAHPdoxThut8Atuu6xDA1tEnmbv9KpFg6c5dVa6Im4s/FC5S9oD06h2Ouc37caNSvBGcszmf4lRCbym7sNtvlQ+sWx0Hs83xWU7Wl/pY9P8s23ps5WIF55l+JttUN59EnZcWILw2hQSbKFDhsaRuHIoa54x6jFA29xPgsG2HWB0t/gJKSHiRkkimHO462CyEfnv+jLZHgXni2npIrJUh3T1J9VdknS9pNmov5tCfx5h1AxvTT3Eq/jXsIcfsJFsimsV7oJxTBJw/fKOm7H3wK/alXEYBsJJ7gPUpF/y15vWwzsJ00N2ydT8ttaZkl+ujustdcR5R+5ra1qu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:26:34.9304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6ccd41-a48d-4d39-90ad-08dc471cbddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
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

Support the query for both gfxhub and mmhub, also replace
xcc_id with hub_inst.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 17 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c           |  5 ++---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c    | 17 +++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 17 +++++++++++------
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0c794301d18d..0b4910108f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -782,12 +782,19 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 }
 
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
-			int xcc_id)
+			int hub_inst, int hub_type)
 {
-	if (adev->gfxhub.funcs->query_utcl2_poison_status)
-		return adev->gfxhub.funcs->query_utcl2_poison_status(adev, xcc_id);
-	else
-		return false;
+	if (!hub_type) {
+		if (adev->gfxhub.funcs->query_utcl2_poison_status)
+			return adev->gfxhub.funcs->query_utcl2_poison_status(adev, hub_inst);
+		else
+			return false;
+	} else {
+		if (adev->mmhub.funcs->query_utcl2_poison_status)
+			return adev->mmhub.funcs->query_utcl2_poison_status(adev, hub_inst);
+		else
+			return false;
+	}
 }
 
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 73b7fa7c5116..03bf20e0e3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -406,7 +406,7 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
-			int xcc_id);
+			int hub_inst, int hub_type);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b3894fe868b2..4ba26d7e52bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -670,10 +670,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
 
-	/* for gfx fed error, kfd will handle it, return directly */
+	/* for fed error, kfd will handle it, return directly */
 	if (fed && amdgpu_ras_is_poison_mode_supported(adev) &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)) &&
-	    (vmhub < AMDGPU_MMHUB0_START))
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
 		return 0;
 
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index a8e76287dde0..650da18b0d87 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -369,18 +369,23 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int xcc_id = 0;
+		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
+		/* gfxhub */
 		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			xcc_id = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
+			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
 				node_id);
-			if (xcc_id < 0)
-				xcc_id = 0;
+			if (hub_inst < 0)
+				hub_inst = 0;
 		}
 
-		if (client_id == SOC15_IH_CLIENTID_UTCL2 && !vmid_type &&
-		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, xcc_id)) {
+		/* mmhub */
+		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
+			hub_inst = node_id / 4;
+
+		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
+					hub_inst, vmid_type)) {
 			event_interrupt_poison_consumption(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index ff7392336795..11641f4645e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -415,18 +415,23 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int xcc_id = 0;
+		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
+		/* gfxhub */
 		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			xcc_id = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
+			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
 				node_id);
-			if (xcc_id < 0)
-				xcc_id = 0;
+			if (hub_inst < 0)
+				hub_inst = 0;
 		}
 
-		if (client_id == SOC15_IH_CLIENTID_UTCL2 && !vmid_type &&
-		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, xcc_id)) {
+		/* mmhub */
+		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
+			hub_inst = node_id / 4;
+
+		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
+					hub_inst, vmid_type)) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
-- 
2.34.1

