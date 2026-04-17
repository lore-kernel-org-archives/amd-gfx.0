Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBAFF436A1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 13:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FC310E0BD;
	Fri, 17 Apr 2026 13:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0/amN3K";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624B910E0BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 13:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPEO4QYOmAE6jjA9Vvfro1DSsEzHk0BErCmbchFIXfZiXeGUHEFkHaVvFLsQBvhjVSQ43wDbCuuFE50qD9ZRwDXvLklF2DRo+Z0vRRsQY3dMK7gJPWktYH/qAHfSUuicFSyKmoVjj30/K2Es1WQNJRkdA7SdYiF5c6ret7yFwIU5wtAF1okcvn7isZJ2isVZl0gSorPrl8ssGQ42BxMugYPshs+0gZVJUHboEboWgxOswZ7bD3JGJzIMTZewHqqWg91phuIX/6TmRPuWmw5hXQ4AKF5U9tojxokJNuYuDxNlv5f7f+nDvIMJmkQ4Cq9yxtjhl542NQl2zWi+zgs9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXtW1892rd8qlHLg3ilI1+IuitUDoH+HLjQro6WvpBY=;
 b=WsUixWJVxpwbYbpyXsoj6OCUgQHl/j+iQimkUgyqSYtp+qqwIMvb/T0GOwIuLqV8o0RqB5o6YM5nzz9ZJa+n7WNvXDcgnaoNyW4I8AMcp66ugqzKXReET0iM1xU8yh4cvfgXLnDFrTNLRUj2m3bpPS2MCQl+dMKvbvOM9hw96lOnQTqgFjDu8aY1nQjOAfOo1TEUEZGfTnnzJEhHsTz3Aps/K6Wy5FldS7ystvSQMDimxIVt1AIcEEsv+g43eaHhThPpj4TqjKo43bIvAvLJVXsTfYXKGowWWj83O1ffQSj8+vbIF8yGOdTfit395GtbrXqwqsRamV3BL17PzTmV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXtW1892rd8qlHLg3ilI1+IuitUDoH+HLjQro6WvpBY=;
 b=l0/amN3KApX5S1rVTvuV9ZvE8d3MWr2/YEJABDo7AnSn/D/fNNS4nFnNbpFlmcOwnxEZ/x0Wkafxqv2HZkFoLwURTlvxcfwuk4zWi/9z0tQ0pghVGY28/twZb0fpzWYbzIiMgoMU0Cq0bHOglj2eKTk5nonxV6UZwDpJz3iwOyE=
Received: from PH7P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::24)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:50:40 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::c3) by PH7P221CA0027.outlook.office365.com
 (2603:10b6:510:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 13:50:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 08:50:38 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Kent.Russell@amd.com>, <Andrew.Martin@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: move VM PTE MTYPE override to per-PTE granularity
Date: Fri, 17 Apr 2026 09:50:25 -0400
Message-ID: <20260417135025.3434482-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f0cebd-84e5-4b19-6d35-08de9c884f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: lpfF+t5adrJSYTy6HCd+WekqSHI4+TvNUdWQ+KJ8rGymlCXEVkCvLCAKToy0haANDjOuHc3bduOGfn9IzlKP934vilnbtmMw+RGs4paPvEv+p8RrSjTefB9sYXUPeugYe19mqizxY0VM96Sxz8k6WV9gSuyKrhTx4I7aFsFq+KmiwKvfxgejtyNm7tdZVnM5ZpzNSk0ulwqfWBcrzUGOnY81qOqGmlVyg9MNb8HdHMx2jFs61MqQGVR6aB2IjsD4ekd54YogZ9DaLxTcWLEIWBj24Co2udcY9FU20Xg04bgcOwiVf52oePwAWKh5CzP5c0E2C3zyQr21rGIIZrpBU4lt3KVOOESsEZ3eR5D+gBqmRDERcOYVscERaWGZP1mhHtorp8qkIyoWSTGRd3hQpvZ58MdibR+WlRvOGBZmZyQk1JWJfAKfNKUHWecDSuZPeiYnb17Ochw4yOuIjjajI6ZwG71g0tHCJTD6zychZ4TnOtuHEzJbQ1cFs2VZdRwt2wsx+W3Ebakuvku+6g/8sAavfK1Ei6CbHt2ZU9wvLT5XyerOjE9QIXgPZ1IKK1WqOcKIkdPRgvX1lYEAx771digZ3loq6FWpWJdqhaMmBKygpNYeis683sjJAENDjTrC2zwITgk8khoPfgzx2VCrEPV4UTYOmqm8bCGU5JSIpqMUQczop2zcFrKM9dl1vK18W5H5o63itr8blF79vziYPpVwnAaTTrKdpknszA/sEH36T6O7TeR0053rMUSJJrc+OIWL9dZYZdoB4wRNDoUsHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ng7pdXN6Vxn8ER7m5yXmVZ/CmZeHy+XheHEYYuRBpEbuvS5uiId5EHb3tLwoRFLHAmnC2klp4Eq6z9YLocZ2b3gJmyktcJ5gLWDb/Mo6FCGmtnPuyvGUKc5/5mbEFv9rTKoSB+x/qvtKoB+5Q1IKg6wgP16OF4RsMW5sfus4HDYWFjiolS954pkf5paHRArXiC2q0IrYQVorRgol6QU7V37Lk8J6Rg9DKddHJupiDPgEJDoOTYoW1AgyxlpsQAj0URcVeRspmYaGaZaGlKNXJMVPcZUhCkAlcqiivipjmLMYEs2rLC7+AccsdErgUINrGqZhSprcWVaQfhOQz+PrKRg96d5/xOOB/qkD3J+T1gN+byiBdE/1R7YQvT35xb7y1ylnhXiVSDWW/Ofh0qB1DkMzsmc5Yb96GBQiBTdoO1Ka4jz4MallH7Bo58nsCq4G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:50:39.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f0cebd-84e5-4b19-6d35-08de9c884f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670
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

Refactor the NUMA-aware MTYPE override for VM page table entries:

- Move the override_vm_pte_flags call from the centralized
  amdgpu_vm_pte_update_flags() into the individual CPU and SDMA update
  backends, enabling per-PTE MTYPE override including for scattered
  pages (pages_addr path).

- Move APU, IP version, and direct-mapped eligibility checks from
  runtime (gmc_v9_0_override_vm_pte_flags) to init time
  (gmc_v9_0_set_gmc_funcs), selecting between gmc_funcs structs with
  and without the override function pointer to avoid repeated runtime
  checks on every PTE update.

- Guard allow_override on whether gmc_funcs->override_vm_pte_flags is
  actually implemented.

- Move amdgpu_device_check_iommu_direct_map() earlier in device init
  so ram_is_direct_mapped is available when gmc_funcs are selected
  during IP early init.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 50 ++++++++++++---------
 7 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bc7e96b58d3f..b139475f65cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3860,6 +3860,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * completed before the need for a different level is detected.
 	 */
 	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
+
+	amdgpu_device_check_iommu_direct_map(adev);
+
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
@@ -4117,8 +4120,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
-	amdgpu_device_check_iommu_direct_map(adev);
-
 	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
 	r = register_pm_notifier(&adev->pm_nb);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..853204b5bd73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1163,7 +1163,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
-	params.allow_override = allow_override;
+	params.allow_override = allow_override && adev->gmc.gmc_funcs->override_vm_pte_flags;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
 	amdgpu_vm_eviction_lock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f33ea7f8509b..326522917131 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -296,8 +296,8 @@ struct amdgpu_vm_update_params {
 	bool needs_flush;
 
 	/**
-	 * @allow_override: true for memory that is not uncached: allows MTYPE
-	 * to be overridden for NUMA local memory.
+	 * @allow_override: true for memory that is not uncached and gmc override function is
+	 * implemented to allow MTYPE to be overridden for NUMA local memory.
 	 */
 	bool allow_override;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index f078db3fef79..fa5d4ac2ef39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -88,12 +88,21 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 
 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
 
+	if (!p->pages_addr && p->allow_override)
+		amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
+
 	for (i = 0; i < count; i++) {
+		u64 oflags = flags;
+
 		value = p->pages_addr ?
 			amdgpu_vm_map_gart(p->pages_addr, addr) :
 			addr;
+
+		if (p->pages_addr && p->allow_override)
+			amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, value, &oflags);
+
 		amdgpu_gmc_set_pte_pde(p->adev, (void *)(uintptr_t)pe,
-				       i, value, flags);
+				       i, value, oflags);
 		addr += incr;
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..883cc275f354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -707,15 +707,6 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 	if (level == AMDGPU_VM_PTB)
 		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
 
-	/* APUs mapping system memory may need different MTYPEs on different
-	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
-	 * to be on the same NUMA node.
-	 */
-	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
-	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
-	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
-		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
-
 	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
 					 flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 36805dcfa159..37f0c0027075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -257,6 +257,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		}
 
 		if (!p->pages_addr) {
+			if (p->allow_override)
+				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
+
 			/* set page commands needed */
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -275,8 +278,14 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		p->num_dw_left -= nptes * 2;
 		pte = (uint64_t *)&(p->job->ibs->ptr[p->num_dw_left]);
 		for (i = 0; i < nptes; ++i, addr += incr) {
+			u64 oflags = flags;
+
 			pte[i] = amdgpu_vm_map_gart(p->pages_addr, addr);
-			pte[i] |= flags;
+
+			if (p->allow_override)
+				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, pte[i], &oflags);
+
+			pte[i] |= oflags;
 		}
 
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e7b78027002b..479611e269b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1204,21 +1204,6 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 {
 	int local_node, nid;
 
-	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
-	 * memory can use more efficient MTYPEs.
-	 */
-	if (!(adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
-		return;
-
-	/* Only direct-mapped memory allows us to determine the NUMA node from
-	 * the DMA address.
-	 */
-	if (!adev->ram_is_direct_mapped) {
-		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
-		return;
-	}
-
 	/* MTYPE_NC is the same default and can be overridden.
 	 * MTYPE_UC will be present if the memory is extended-coherent
 	 * and can also be overridden.
@@ -1231,11 +1216,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* FIXME: Only supported on native mode for now. For carve-out, the
-	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
-	 * memory partitions are not associated with different NUMA nodes.
-	 */
-	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
+	if (vm->mem_id >= 0) {
 		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
 	} else {
 		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
@@ -1328,6 +1309,19 @@ static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
+	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
+	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
+	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
+	.get_vm_pde = gmc_v9_0_get_vm_pde,
+	.get_vm_pte = gmc_v9_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
+	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
+	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
+	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
+};
+
+static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_override_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
@@ -1343,7 +1337,21 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
 {
-	adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
+	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes, local system
+	 * memory can use more efficient MTYPEs.
+	 *
+	 * APUs mapping system memory may need different MTYPEs on different
+	 * NUMA nodes.
+	 *
+	 * Only direct-mapped memory allows us to determine the NUMA node from
+	 * the DMA address.
+	 */
+	if ((adev->gmc.is_app_apu && num_possible_nodes() > 1) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+	    adev->ram_is_direct_mapped)
+		adev->gmc.gmc_funcs = &gmc_v9_0_gmc_override_funcs;
+	else
+		adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
 }
 
 static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
-- 
2.50.1

