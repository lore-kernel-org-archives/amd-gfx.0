Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE2EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 10:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3925A10E9A4;
	Tue, 30 Apr 2024 10:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sXyedEG0";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7F410E97C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 10:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv4JnfLPA5swf12OI3zEvCCRhJkv0Ou6TqKTaXtEAZmeIAFO9sFk11mcig7UFtmtZYyWyAEnn5NY9072L6SIv2geKrjbzw+9wl6UavsQCgLtWLSbtPCg9RwQXD4+DUP4PF4gycFV9zEVB497LLw60hv8iwk2N0yiGmCU+PGhxBYPLpj+TLshfyLm6j1oEqVO0Tot84fopmIq/QvYBT77I1yZcY5Gr7PWUx0Trc0ISXamj6dA/IS6B3tCk7caK/xN23XgYSu3wBB1addQP7SHtckyAvrleCEUNIjFvhnjHQ1UGh1mYz1u5+mguXcbvU6wuyOpi3WYfCAUVgOthhZ7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzYEAf99eC5EH2FOG42zgXufkcxqqaUZ+pvn1RR4PvE=;
 b=W4XOnQUvWeXeFpRfW2Lc3+lpOFXJ1DMBjkhjp+Zgn3C2oqHpc+l62nRGOyGIwHQau2ly0nNsA04NF9TA9IqsmFhh6A5CHLCtbD7Vemur897hlXFCyHRuDOhaz4zs0JxykZsSWSOCWncNbk1z/EG5UFHX77OJwakonji0zbPYvQVqfq9uKiXGJHheWqFUjmwEjS9zEL56OqS1Jpeh/aKqBbjtMLxMWjslGzUXtJ+ayqZ5Cl56BFnV4IqBJhVlpb1X0gBXref6ywi4GLqYglKzRUC1z7pNkxSlQri3Hxlq+zMhkvBcDpC1BSNyG0eQLVF+3q96CVhqNJZVA497tzDkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzYEAf99eC5EH2FOG42zgXufkcxqqaUZ+pvn1RR4PvE=;
 b=sXyedEG0+7vombHhHmLTJt5eSJJD3WKE4KZ/Vsb/JRe8rx8AwrF+BH1rbkK/iQsKKD8xP8mPlOWcgZv9lj81NltI2zjMAfHF5beGAuVFf7HrXNZ3rzbIYZ8PJpsF9KDsd5fPjrn1MgYT82oPa15ThApaEhj6cBwQlW6iqYP5mDo=
Received: from PH8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:2d0::22)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 10:09:30 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::f7) by PH8PR02CA0009.outlook.office365.com
 (2603:10b6:510:2d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 10:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 10:09:29 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 05:09:26 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Christian Koenig <christian.koenig@amd.com>, "Yifan
 Zhang" <yifan1.zhang@amd.com>, Aaron Liu <aaron.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH v2] drm/amdkfd: Let VRAM allocations go to GTT domain on small
 APUs
Date: Tue, 30 Apr 2024 18:08:16 +0800
Message-ID: <20240430100816.1057712-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f336a2-95ec-43f1-0095-08dc68fd9fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D9fzprbEIBEdxFJ0B6jI4MNDgSJDd0v0RmO2ZUWcyyENIvLANFkinyWCacRj?=
 =?us-ascii?Q?pwM5UXsFJf4wZe7wRKDc6u9LuW3sZrFjeJ9nMiTZGGgnYLXMCoHqF1TM+iQW?=
 =?us-ascii?Q?YiL454oho03D+pU5rK01ar61z5quKIZyD8zMgof2Xk/u+bN8Ylr4V2vx/SED?=
 =?us-ascii?Q?EzPBOhKbwW4BL2PzPwuJCJowZUVbm6i7F3k6BFF8efo51Ix5iaWqmkJ2h8Nm?=
 =?us-ascii?Q?TkdpmOevwN8tWhiv6f9yAS1RPQUtA9p1kGSfjdsoZ8eqhLNQVU3cUC13eKxg?=
 =?us-ascii?Q?j4as35336/IT/Q6pMUsed82Oay9KO0shuW+xGXBmneVnfIrnEFOEWKx2zAS+?=
 =?us-ascii?Q?aONh3KCNjEjSSFJhor8UjDE83tGd7HMOl1UxCh9pCbsaRV2aReK5slVJWb5Z?=
 =?us-ascii?Q?Rgh+fDvbSHwT7idO/yU93t5gLOfjDb9Bj6KuEz1plVa+USaY7yXLgvUr47sG?=
 =?us-ascii?Q?USjug84p4LrSbiN/u2KczH9h8zXZod2IIF5ouxD1mKjvBcKntqXz/42wygN2?=
 =?us-ascii?Q?4RuatbIb02E/P5Id2nMQVmiLE7sE0NX+XTQMKCzKJtyZr+NdlpeKgV/8jiG5?=
 =?us-ascii?Q?ptN++UBQz6nnFNweugGpqu+OzlxpYpwRa/Xv7GKhN9XrO07rnoF8JyLgAA6M?=
 =?us-ascii?Q?SLhc8iRjqE/PN/RDPM4r4hzTp5LPkzVi6Tq3HWD6SD61YJ34HZeSEqIUe3wn?=
 =?us-ascii?Q?TyLTU6v16rVSpVDfIeRCHD491svoln6Kp1NoRyTLXAZ13WAvZqBGNmwCqobB?=
 =?us-ascii?Q?OvgYUvCi6MpJvXenYg1+JUkg/rMfFq7XMtsU5jAJLnsbAKDYi7Wy+u/rLbPi?=
 =?us-ascii?Q?hh3FBXW8rVrahake8lj0imXwld4L2rwLj9pk5hCVBdkSVG6WK+Hy2825Yg4T?=
 =?us-ascii?Q?/fHhC32REwggNDHd4KPC789Gnxn0MZgjR6VkwQJ5gP3nJnE2kk89u8EXgzUk?=
 =?us-ascii?Q?g5VAsRIN/losns11T3urPtxA1qBvEm06yWVbOyCghXxhJ3vEnU8IugLCz+NX?=
 =?us-ascii?Q?++Y+e18EDx870DaF63sq1AKIxgNtx713efNWhkYkJaNhiMX8SaxeBSMlpqO7?=
 =?us-ascii?Q?MSnoHworjEg+qGHydpnHNQhjwY6XmfVzp/Q/g3rtnM3sM93K0IJwwlfTFHvF?=
 =?us-ascii?Q?LorN/14382TEoN4c8dhFF+ahXIwWAVSqXOOKpkHFxV042OVlHn7XkUOiuh5z?=
 =?us-ascii?Q?um7QLG3MgV1hHnwgeLmK8OfprqZdyc6eMng9ljXkCh/I7hCreUatev23V8Ge?=
 =?us-ascii?Q?OVWyO11EZjHVGR0dxRKaUnND6ykR64KDoGUgtifrLw6lolEomu6Q4A6ts613?=
 =?us-ascii?Q?GuVdRC20DMArZPWmnsjLrnMj2rQOMYW7RCkhq80xjutxAi/ovA5nbg9gjbPS?=
 =?us-ascii?Q?ifqgmkNBYubUVzwTxnCCHfcDQj9U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 10:09:29.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f336a2-95ec-43f1-0095-08dc68fd9fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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
Error Log when running mnist:
"torch.cuda.OutOfMemoryError: HIP out of memory. Tried to allocate
84.00 MiB. GPU 0 has a total capacity of 512.00 MiB of which 0 bytes
is free. Of the allocated memory 103.83 MiB is allocated by PyTorch,
and 22.17 MiB is reserved by PyTorch but unallocated"

Though we can change BIOS settings to enlarge carveout size,
which is inflexible and may bring complaint. On the other hand,
the memory resource can't be effectively used between host and device.

The solution is MI300A approach, i.e., let VRAM allocations go to GTT.
Then device and host can effectively share system memory.

v2: Report local_mem_size_private as 0. (Felix)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  3 ++-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7ba05f030dd1..e3738d417245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -455,6 +455,9 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 		else
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
+	} else if (adev->flags & AMD_IS_APU) {
+		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
+		mem_info->local_mem_size_private = 0;
 	} else {
 		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
 		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
@@ -824,6 +827,8 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		}
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
+	} else if (adev->flags & AMD_IS_APU) {
+		return (ttm_tt_pages_limit() << PAGE_SHIFT);
 	} else {
 		return adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4bdf59213384..5843c3d35cb9 100644
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
@@ -1674,7 +1675,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
 
-	if (adev->gmc.is_app_apu) {
+	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1722,7 +1723,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->gmc.is_app_apu) {
+		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1973,7 +1974,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   (adev->gmc.is_app_apu &&
+		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2395,8 +2396,9 @@ static int import_obj_create(struct amdgpu_device *adev,
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
index 386875e6eb96..069b81eeea03 100644
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

