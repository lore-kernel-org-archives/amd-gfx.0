Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DDDF588C4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B3010E664;
	Mon, 20 Apr 2026 13:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzrlruvw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7927610E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 13:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlymnqqpWQTUMaM5acdxWfeUfqTvN5aOv9cIMAOGrsh/4IHF9SpvbKBbrUu4q8Tp8G7UXk5IT1FtTL1HyQCE5H/zo09BPJKB78PEGbcnXPgvRlwZh50BYwrJyREI6AdeEZR5z8kmDQitzzME9ROOsGOomRi/NAkmtTiXRAl+smINsG9b+EQRU2R2TTVzr1qSuwEN2PHPUsVFj4Jbgcedw8udHoJwHEL9tHvvWXJIPe2MPnRkjr40rJnh1OhQkmO7kwH4v9d5uR257aJ30woIbfQXV9p74ocfvtWBmrh4MHtLrUnwf8pc4kx2dX6PRQv2hSCAJnQjohGWGH3DS6P3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnKqsp6U4NfHPIWjv54niQDLoR0PfCwmzVbrANcbTj4=;
 b=pQzdXvJ8DSoGgyfI7ilowSzk5CcJQNftJcum4Mq48yc15JQuyyFP4AEw0JfswASTehK8uuAYEs7+X18aVrOuXyACyx1+5bi/j9JWlgAyfL6GpqgsKyhI/FcBc88AmFSWgu3Z3YfNJDpkghscIrTv0QeSUDYCakr/R7CpzKHp0rU3eCn00TzD2Odu+hM3UGKk5c5CdF7mnq+UB2QmY5xrAatnwNkZb7mRAeBfOpZYnhIMyXfqNzjJEilZ8T5pKphQnWWtL+LGjIWm4r7l2A2Ey/pU3r+WWixeiVQmCtj35rUI8Ln4eMYoBL9PVdyTbmIvRoeqfXEZfSNdo0MBu5J9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnKqsp6U4NfHPIWjv54niQDLoR0PfCwmzVbrANcbTj4=;
 b=rzrlruvw6N0FMdRHDb9i2I+O7DJU3b87bW3rEScYj9bTtW+gE4vU3l2JXWpD3cth52AxuMBTjlWXQJyDFQstnl/xq3QY7BH4jG9Lm/KDk7ZsUgC8nPALkMficQ7Tth7U055KV3KQaYnOgz+vc/iKzYT3eos3vgOkC4hz2/mZ178=
Received: from BYAPR08CA0011.namprd08.prod.outlook.com (2603:10b6:a03:100::24)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 13:38:04 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::e4) by BYAPR08CA0011.outlook.office365.com
 (2603:10b6:a03:100::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:38:03 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:38:01 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Kent.Russell@amd.com>, <Andrew.Martin@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: move VM PTE MTYPE override to per-PTE
 granularity
Date: Mon, 20 Apr 2026 09:37:05 -0400
Message-ID: <20260420133705.3721315-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420133705.3721315-1-Philip.Yang@amd.com>
References: <20260420133705.3721315-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: e1359a5d-f76f-4a02-55d3-08de9ee20c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2wa+/03qB1nXrubXXQZOfco7PW7FarBTVBFjvoC2+a3QRSpf0WmOcJ9V7y9KKDL4cNVxxes70MzbzJixLqYtwIV73WzX41c9dIKS8Y1GkWLEMl2krTF1UJ2se3uq726Feu/rMrnzCIBJqiwsYyoaYHj6SZq08MGBqS+LrR12x2cqYSX08lmhI/IC+YLTF41v4cwayNmwroF0BX8nkqSj+/woD8PgbTJmk9dfvAwft1ge3MGsiEaR7u0q8NegmvRfoWbt7ZdnRXEuGta/qKUiXRiY+7rk9NHR6Z95VfsnaDWnnEFBZCivf5kiAQv6zDVC57IljObuEp2RYVTWHqsUorhVOpUR3jaTIzoL70jArOKm6fLOU7b/RCy+j7njq3RLXG4jVXy7s+N78iCCJzoVK4oCAdMU3HfefNOuTCK10dIt7ui1asbx57YR5NL2A95umrI4paibQIrqb8zITJFLQkMRSeYdX7+ZOUtWrt7EH7JJgDk5aihy9ACtgxHj+aJVoMnuPuL7J7JgenuoR33sa23i731kKZ0D2cyra8TsjiVnk+40oOFTZyo9wFATQN6wJQ24EPs/x1e+lxt7N8Vgd/e5wY54RkbKXG8Tkiir95cBQrfi9APYjmuQjoG/sizSurhkbQLG4pHac7YvC5YQVenfH9bMD7ly3554zjJol2TTJ2LOm/H31Aa2HAsMsNYrom/JOA+ytP2EXhLpbzpCvSrywH2sYk7mT9t2lhUBqihQxh5KXdHas5rkeWviLC8dJKP4uwMHpk5nqxeEXKOxJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 08RHLI2yPBEn4wBkKFoVvHKT7VQEUandqpvo/FRYNCgrFaIV96mLFcTpMqWVrMcCPuyBMZ6uFGw2U3MFgyKjIuSKTl8S4Q4P1nE5SPuJZ5fz7aGJOZd+3dsC20SpWJDbr8A4aFhgjm5M3Yi0AfoAZfGgnqT79Ba1L13Hpaeyh6lyIyWXbwlLgnRG8aV9v9ZINzO4PIyak//Eh1wcJr684WLxnqCTjhbdV/Q2DoCQlnx1X9oYDIWoWlPFvMI5epVLKl+I4eboRcCIEldwGndkDxpDx2Xv5snkieKjLEFPEbQa1y6fMzBKCJtkS4UvRnUUgRhtz7Y2uYq8b8afBmCS+gRWYOBPousPOrjaEmMrmmAXwwpECGkr+CMaAMbiePxyw6SlP0rN4wV6P03P2blnNo3/3/LyX/0KdRtMFO9z1g6w4iqxfYmNmRo+lDdCZEEm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:38:03.5326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1359a5d-f76f-4a02-55d3-08de9ee20c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 35 +++++++++------------
 7 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 6ab4c1e297fc..c6d7a9e54eb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -365,6 +365,8 @@ struct amdgpu_gmc {
 	bool flush_tlb_needs_extra_type_0;
 	bool flush_tlb_needs_extra_type_2;
 	bool flush_pasid_uses_kiq;
+
+	bool override_pte;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..532b78701bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1163,7 +1163,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
-	params.allow_override = allow_override;
+	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
 	amdgpu_vm_eviction_lock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f33ea7f8509b..a0435468d0bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -296,10 +296,10 @@ struct amdgpu_vm_update_params {
 	bool needs_flush;
 
 	/**
-	 * @allow_override: true for memory that is not uncached: allows MTYPE
-	 * to be overridden for NUMA local memory.
+	 * @override_pte: true for memory that is not uncached and gmc override function is
+	 * implemented to allow MTYPE to be overridden for NUMA local memory.
 	 */
-	bool allow_override;
+	bool override_pte;
 
 	/**
 	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index f078db3fef79..b31ff6f56f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -88,12 +88,21 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 
 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
 
+	if (!p->pages_addr && p->override_pte)
+		amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
+
 	for (i = 0; i < count; i++) {
+		u64 oflags = flags;
+
 		value = p->pages_addr ?
 			amdgpu_vm_map_gart(p->pages_addr, addr) :
 			addr;
+
+		if (p->pages_addr && p->override_pte)
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
index 36805dcfa159..2eb64df6daa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -257,6 +257,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		}
 
 		if (!p->pages_addr) {
+			if (p->override_pte)
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
+			if (p->override_pte)
+				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, pte[i], &oflags);
+
+			pte[i] |= oflags;
 		}
 
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e7b78027002b..aca7841173f3 100644
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
@@ -1344,6 +1325,20 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
 {
 	adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
+
+	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes, local system
+	 * memory can use more efficient MTYPEs.
+	 *
+	 * APUs mapping system memory may need different MTYPEs on different
+	 * NUMA nodes.
+	 *
+	 * Only direct-mapped memory allows us to determine the NUMA node from
+	 * the DMA address.
+	 */
+	adev->gmc.override_pte = adev->gmc.is_app_apu &&
+				 num_possible_nodes() > 1 &&
+				 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+				 adev->ram_is_direct_mapped;
 }
 
 static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
-- 
2.50.1

