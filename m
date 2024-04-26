Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1264C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 08:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095DE10E571;
	Fri, 26 Apr 2024 08:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xD5ZtXCi";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51E010E571
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 08:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0Cx2zuI3aeE7rhJsBg/8UFSFJ7GIUg6+a1ucr1hEZZDORGxpaSmmig2f1OmYMiqvKms18qBfIZP4zLoj+OqfbpyQzyRuIn2wjQi4XfCTRrtw0G/h0cEqrHjIr9mijm05MP2gRDgL0LOV/ZHnMF+0Cp3lEAl6FLqHIrkhkqKNeYpBSFmnIlKkE9A++9dL2FfTgKkAUc9xmJuF26wRrxxYhTTh6aINLSUTExwvqH7/ZvkxHEE6JExXEfe0j0Et0jfX2+vYWWRJBwQC8YMTEzd0lqHLileeGUXFVW/3L+301kLM3m+P3/WRguaJWvz5QL+q7Wko9ggQUWyVw2wfvrMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsBf8AeVUZUBPVtmD5/HN4EB1Ff1sSKvbQZwxE1cwYA=;
 b=E+kx/IeTTU7+1mKDGs7KONDS4zRIPLDWQ4/udlN6vpKiXfvy4I0w6e117mvzihvL6i9JZYrex3sgFbyM5cE9L7Rfb9pEV4VBDLPRN2Yv3Z5JHQ0h/ivZqx2CGqXzHpUCRTkInfhNxJqatOZlw3BS71voaRQeZvwhrf8lYVzM0RoAvk9XZYVk8e1Ta06U465PUnp4teMB0cLHk3XAe8hM0GrHpEAUmLuZztMypRwG/ZAfupobPSKFTsdnV5m45zfzpqyt9OXNRrJt3bwATJH3WFpPLMbqOTYqo9MBOH/e0gh2WdLHHIhZtiWrbbI9Z3gjOdiedwoSUpu6qKeb+oc3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsBf8AeVUZUBPVtmD5/HN4EB1Ff1sSKvbQZwxE1cwYA=;
 b=xD5ZtXCiM/RgjaS2p9oU52y0tyw6qp4F4IXcBBI4QO5SH4XKT4Uu8K4o2NGdQCzXTmuw2QtqAzfwu+Djmy9QsxwfdlanGzyLklNakkvXCUYHugWSbV/7l9ODHdaHEqfC0IO503yYf4L3iLi4W79LdI58G2WTjL+gKtyBhEDonmI=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 08:38:11 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5a) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.16 via Frontend
 Transport; Fri, 26 Apr 2024 08:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 08:38:11 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 03:38:08 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Christian Koenig <christian.koenig@amd.com>, "Yifan
 Zhang" <yifan1.zhang@amd.com>, Aaron Liu <aaron.liu@amd.com>, Lang Yu
 <Lang.Yu@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Let VRAM allocations go to GTT domain on
 small APUs
Date: Fri, 26 Apr 2024 16:37:49 +0800
Message-ID: <20240426083750.485808-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: b2624fb9-176c-4c57-4004-08dc65cc34d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wJc4giMJz1VGoYvRCarWHv5FVSTlbjFu45iqv2CHs1QoZ+3sELxz/vSrAG+a?=
 =?us-ascii?Q?q2B8G+zzDiGyNuswquFg3udyILdgUZRjT207m1eCTW8S4F6DtvYOwuaGNJoz?=
 =?us-ascii?Q?ETTCJ9URQigS1Bf5P2rEQugKi0s5HfguSW3iR5Z/uQfUzWNs/cnetKhSLdnT?=
 =?us-ascii?Q?h8YPUWyv5YOCUJtqXZLTQE11K0dTNbuaprJ2DhW+Zuv8n+BTiVGD87OjkQzo?=
 =?us-ascii?Q?kSWs8rRM7da5YSE9I3Ls2MbUkLB113T/kEOFfvPLTHhwXB/Q0mITm2P90wOa?=
 =?us-ascii?Q?XNWNw/45OQDkEnRzMkxY/LPz3BulFTK0o4uaC7r2Tx9rjEeJIoAmpBUDVJ2k?=
 =?us-ascii?Q?TfZEvENvrHLaZEGE2W1FAiwWZ/nQoUxgAKxb+u4WIAyh90W9nlmyg7RaJk9j?=
 =?us-ascii?Q?2vyhXpSEjW/W4RJFLaRHbEGRvXujR8cjlSy9oiumSZf+UneUSFj1FotlbKzF?=
 =?us-ascii?Q?vKJa0iCztdcR0vhfLnbKegf1DMi9Ze3siHqiWN5Lh+T1HMhQXZvDpCz6osoE?=
 =?us-ascii?Q?SqHszvSIniDMgC5GOqy0COD1UYvtCrl2G7vb23pE8fUbEympOcVkt/N1VcP3?=
 =?us-ascii?Q?uxkqkL2OpGcg8x3o/fxssV/7xOrdJlUEWM97G/C6ksvyluDU9YJmjjFwKZSf?=
 =?us-ascii?Q?k7qe9Iph30Te5qwvrqMJYXFufJvyQ8nx9qy5gKwF2cJLfsX7j8x6VNIc6Va9?=
 =?us-ascii?Q?cvK9J+5DPZ+L/wAFxqBQoGMYiISIwdKay+3qUzeTnM3WeYdkAoyCtVks3mw1?=
 =?us-ascii?Q?I6Xvoaqej0tr1l3JKBYp5HWMEbpUSefXzW2HUEwrJx1Dw0FTu0VinR9y4VKm?=
 =?us-ascii?Q?31mMAo7k3IVKLD+cEcstVif19/g4pQFvz3+ENefZhlVKxVD/bd9bXF8vlwe5?=
 =?us-ascii?Q?7l3CWdSlYUVmPNrUVtOkQgRP930FEyoecJ+f3zLbAwrPPH/LkNvswJp9QmeG?=
 =?us-ascii?Q?flihDr8S+qG4dPnbZXHoLX2/a2EzZccnrP0n/0l3O/abxao/CvoBLmyjbzmu?=
 =?us-ascii?Q?oGNxwycWhouPkZ6Vh15j0gqbMCWeSv7CIay1BNhBweAEN+SKk0ht5sO2va7I?=
 =?us-ascii?Q?X6PGYuAeDz5m2KyZWWkiJ0nOYycvSu2PxkXuruzBgdT3BK8vAKLbO3Yg9NWN?=
 =?us-ascii?Q?7fPqPtmdd1QnFidEujev+msdlPAE5PtVvPPytdyHA2b9PWh6P52Cy8rrTpFE?=
 =?us-ascii?Q?XkdqTMCkaXxmOWfkc6QKpjbZUlEgXK3GWC8jNjKzZ4cyNZEw9tTJQQln+yJ1?=
 =?us-ascii?Q?8D6qMywJMh9MD3lD5oEVHPW9AY8wURrOgID76A55dRc0qRYAGCi5msA27McA?=
 =?us-ascii?Q?QYrTgmwKLCRRLSuf/1sFoRdOHogISkM7JJgUZNWwWn0bn+R2aHZpQi5uz7Uj?=
 =?us-ascii?Q?LHWLzW05yJjv7YJMSi5+OyX80ER1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 08:38:11.2395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2624fb9-176c-4c57-4004-08dc65cc34d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

Small APUs(i.e., consumer, embedded products) usually have a small
carveout device memory which can't satisfy most compute workloads
memory allocation requirements.

We can't even run a Basic MNIST Example with a default 512MB carveout.
https://github.com/pytorch/examples/tree/main/mnist.

Though we can change BIOS settings to enlarge carveout size,
which is inflexible and may bring complaint. On the other hand,
the memory resource can't be effectively used between host and device.

The solution is MI300A approach, i.e., let VRAM allocations go to GTT.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 +++++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  3 ++-
 5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7ba05f030dd1..3295838e9a1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -456,7 +456,9 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
 	} else {
-		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
+		mem_info->local_mem_size_public = adev->flags & AMD_IS_APU ?
+						  (ttm_tt_pages_limit() << PAGE_SHIFT) :
+						  adev->gmc.visible_vram_size;
 		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
 						adev->gmc.visible_vram_size;
 	}
@@ -824,6 +826,8 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		}
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
+	} else if (adev->flags & AMD_IS_APU) {
+		return (ttm_tt_pages_limit() << PAGE_SHIFT);
 	} else {
 		return adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c4f9960dafbb..7eb5afcc4895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
-		if (adev->gmc.is_app_apu) {
+		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
 		}
@@ -232,7 +232,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		  "adev reference can't be null when vram is used");
 	if (adev && xcp_id >= 0) {
 		adev->kfd.vram_used[xcp_id] += vram_needed;
-		adev->kfd.vram_used_aligned[xcp_id] += adev->gmc.is_app_apu ?
+		adev->kfd.vram_used_aligned[xcp_id] +=
+				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
 				vram_needed :
 				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -260,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 
 		if (adev) {
 			adev->kfd.vram_used[xcp_id] -= size;
-			if (adev->gmc.is_app_apu) {
+			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 				adev->kfd.vram_used_aligned[xcp_id] -= size;
 				kfd_mem_limit.system_mem_used -= size;
 				kfd_mem_limit.ttm_mem_used -= size;
@@ -889,7 +890,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev && !adev->gmc.is_app_apu) &&
+	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
@@ -1657,7 +1658,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
 
-	if (adev->gmc.is_app_apu) {
+	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1669,6 +1670,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		available = min3(system_mem_available, ttm_mem_available,
 				 vram_available);
 		available = ALIGN_DOWN(available, PAGE_SIZE);
+
 	} else {
 		available = ALIGN_DOWN(vram_available, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -1705,7 +1707,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->gmc.is_app_apu) {
+		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1952,7 +1954,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   (adev->gmc.is_app_apu &&
+		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2374,8 +2376,9 @@ static int import_obj_create(struct amdgpu_device *adev,
 	(*mem)->dmabuf = dma_buf;
 	(*mem)->bo = bo;
 	(*mem)->va = va;
-	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) && !adev->gmc.is_app_apu ?
-		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
+	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
+			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
+			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4bcfbeac48fb..4816fcb9803a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
-	if (adev->gmc.is_app_apu)
+	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
 		return 0;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bfab16b43fec..238ac11bb97d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2619,7 +2619,8 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (node->adev->gmc.is_app_apu)
+	if (node->adev->gmc.is_app_apu ||
+	    node->adev->flags & AMD_IS_APU)
 		return 0;
 
 	if (prange->preferred_loc == gpuid ||
@@ -3337,7 +3338,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		goto out;
 	}
 
-	if (bo_node->adev->gmc.is_app_apu) {
+	if (bo_node->adev->gmc.is_app_apu ||
+	    bo_node->adev->flags & AMD_IS_APU) {
 		best_loc = 0;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 026863a0abcd..9c37bd0567ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -201,7 +201,8 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  * is initialized to not 0 when page migration register device memory.
  */
 #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					(adev)->gmc.is_app_apu)
+					(adev)->gmc.is_app_apu ||\
+					((adev)->flags & AMD_IS_APU))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
-- 
2.25.1

