Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0875DF364C3
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 22:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFF810E15B;
	Thu,  9 Apr 2026 22:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4MLsQlXx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D19110E15B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 22:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD3jWbkuj9DI/VF2WVzdGiCpHxfFppxJ3HMh/JM+R+9xlMrcWTIO4uT21vwT1Ahkgn2A2aIPQxdX3B8oYaNL/puwnud/9A5GxtTiQT8YuXqR94MCAGx0HAWevtDZBeqLmcNeYI+5zCVhExt9uU0UMEFRsfNh9h2jdDquH2Nhk6g4aV8hrcaR55aiJ3wWi/rEjk/8hoq3f02RWXiH4dZ11RIAA1MmRLIQFSMaTYD667nKy6XdkTtuenP5lGRndrKbhC4C2b1DbMPvSXdYxvOLxJG0t1Pbo3WU9zcfvCap0wUhI8HMaQ19WJ5NCOyeS96UiztfWnKZliI1VVNGgOBoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRqZnSsANuV24XiAtTlHqLMgdiYbuX357Jn0DJVbSX4=;
 b=lnDGw9Ah0L7a6CLIVYMoyZP0NfKWMMlBKD1pjp93++gCxnCRn/TJkMJYBnqHwrF65C1NSst7u6mGFB0k2w47YFViUhDrAQ1uQlnWcWnS0cgA/Z8rt6Q7jsWWTWM4XU+3DFLKdgqS4qOHLIOk9yLTIWoD1z642P21zCtQgzdKTTwB9OF3sRrfDVAcFOwEztGeuEBfDwC9WodIjoQ0VXSwTeCEiUevNxAJhtr44vuhXFBOD71spqRrzkfAmxsHo1qZVNPKenJZAF+CegoqU4EDAu3p0YjKH5vsGUdN34XKDk5Zn2GM+TU21lkOOjQcHCCOyPPZSK3WYUBKblkZSHOvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRqZnSsANuV24XiAtTlHqLMgdiYbuX357Jn0DJVbSX4=;
 b=4MLsQlXxmdMsLMG//vxeqZERj075Bmrx0R1DesC/ke6D0TFCFzn2FnijsSISEPpIpYtMyVkqPHvbUril6j0/TrWgNFShrCK9z/hQ0atq5wv9OF/qgaUgr1j8LIgHafk3RwBhiZzNkMypyVi8WVCsICD4zipndA/HZ+jfAZJ1ATo=
Received: from SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 22:46:12 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::89) by SJ0PR05CA0152.outlook.office365.com
 (2603:10b6:a03:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 22:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 22:46:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 17:46:10 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Kent.Russell@amd.com>, <Andrew.Martin@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdgpu: extend mtype override to non-contiguous pages
Date: Thu, 9 Apr 2026 18:45:53 -0400
Message-ID: <20260409224554.2813645-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8319134a-c10d-45ed-9696-08de9689cc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xFgJ1eLEs6pTCIknXYUNX7xmfCVMzqxPuKQKQd6k3xJ3JRtbsaj32yQILZtpIAj3n3lXFkPA++xWWJRHgU8EkTTY4brhPk8B8lcMYC/xywajTY9aeN0PWkpsxCaBa4DLRB45zyWE58YKNtTFLG3Zye2ZGIqSF+4NUavVk1O3ceKUTjbLwJOFcVKc6yR+LAWLj0hLvnS2bzm4IKfYDEByjsemmmya6JR5DZFrFGtb5pMCLwTAg33OXjQmEFeD2mG0wGtWdPkNHv6ZgOemvWhhuF73oSuEniEiL1prGVtfzbfNLDV1bT4C6l6+JM7PUJbcSgRO637exu+VwjnCxxR58TbDD3zX3cHvkT3USfG4wOry62bSYy5diFSZhHaXKuxjDck55OgsrUy8FHro+/YK/UxHG1I7mYWjVbyHS0F8r1dPQXy0yj9g6z2QFtPoUsxorIPciCpnMRsuZdBFDFS0nn9Pk97LRVudOy7HgKExWzWku84GPVkOh3W6HsaLv54N4AjLJfA7xwWhs3lj5VNGuWcWoI+H0BJuY1qw8rhlQOuhdrD85dOfO1Xg0D4t7dz1XFaloZlcu4h7xiBd6tsYNtmD43zxvxCiBNLHnQqLzYFa2ZPBcLH8VcvIH9e+5rxQLA3k8xUrR/ZYXAyRiF3/OeYBw3RkGkXvJvPWQNDQveBMnXc+SoWiQsoEsNmLcYN1oxdxPVEsxsf+0ZsVDRA/0FdKvB2Jx5iQC4xEHwbueie8XKqaqGtGbmNX7SLxn9ynAe1kLNT8XtPNmDw8+Ty4iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EhDQR+F//vIsMbVo2aEc8OJfAHde9urzeT6WjC6GEj3dAFR7gk7LtNdWiZ5Pnv761qn2XERp/Ap33JGoMUm5VdSurpsUdmZwmc7+t9GRmgb8Wzv6hyQEwerylcXuCDVGGs5KbwVoowEY5C9cyV7QnbF4ouC7NGiBrluA35z2P0ugn50crEE5XJfTjV4cyE9fqykacGpWkjA5glWEwaJjEiH3sD2T3LFzPvA+TeAErw1bsKYBN/CdzFDMJSB/Ig300yRw1PpFBu3Ju+J1Djb1jK2SiEi5tUbGLldaQobVTuGvkgacYJL4vVDaHsrTrErux4Q2dDt5DRE2zTOjF7UouGvs+EQwxoDyxOTxCMLlCOymSLGf/KGqGc9vDyKEy8lO1Y7lNx7ujalq/5peT6TbGqAnyMjwtwiFSykf2WJhh1NUOqIJ4rU5bqkTYOL9namr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:46:11.7875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8319134a-c10d-45ed-9696-08de9689cc87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

On multi-socket MI300A APU systems, system memory pages mapped to the
closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
excluded non-contiguous page mappings from the override. This caused
incorrect MTYPE_NC for scattered local pages, leading to cache coherence
issues.

The override applies to both contiguous and non-contiguous mappings.
When pages_addr is set, resolve the physical address via
pages_addr[addr >> PAGE_SHIFT] before passing it to the override
callback for NUMA node lookup.

Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
pages on different NUMA nodes as non-contiguous even if their DMA
addresses are adjacent. This ensures amdgpu_vm_update_range() splits
page table updates at NUMA node boundaries so each batch gets the
correct mtype override.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 51 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..7b7cbe054d73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1099,6 +1099,32 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 }
 
+/**
+ * amdgpu_vm_addr_same_group - check if two DMA addresses are same contiguity state
+ *
+ * @same_nid: true to check if two address on same NUMA node
+ * @addr: current DMA address
+ * @addr_next: next DMA address to check against
+ * @contiguous: current contiguity state of the range being built
+ *
+ * Check whether @addr and @addr_next are physically contiguous. On APU
+ * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
+ * also breaks contiguity so that each contiguous batch stays within a
+ * single NUMA node for correct MTYPE override selection.
+ *
+ * Returns:
+ * true if @addr_next continues the current contiguous range, false otherwise.
+ */
+static inline bool amdgpu_vm_addr_same_group(bool same_nid, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (same_nid && page_is_ram(addr >> PAGE_SHIFT) &&
+	    pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
+		return !contiguous;
+
+	return (addr + PAGE_SIZE) == addr_next;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1134,6 +1160,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
+	bool same_nid;
 	int r, idx;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -1166,6 +1193,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.allow_override = allow_override;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
+	same_nid = adev->gmc.is_app_apu && adev->ram_is_direct_mapped &&
+		   adev->gmc.gmc_funcs->override_vm_pte_flags &&
+		   num_possible_nodes() > 1 && params.allow_override;
+
 	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
@@ -1198,22 +1229,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				uint64_t pfn = cursor.start >> PAGE_SHIFT;
 				uint64_t count;
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+				contiguous = amdgpu_vm_addr_same_group(same_nid,
+								       pages_addr[pfn],
+								       pages_addr[pfn + 1],
+								       contiguous);
 
-				tmp = num_entries /
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 				for (count = 2; count < tmp; ++count) {
 					uint64_t idx = pfn + count;
 
-					if (contiguous != (pages_addr[idx] ==
-					    pages_addr[idx - 1] + PAGE_SIZE))
+					if (contiguous != amdgpu_vm_addr_same_group(same_nid,
+									pages_addr[idx - 1],
+									pages_addr[idx],
+									contiguous))
 						break;
 				}
+
 				if (!contiguous)
 					count--;
-				num_entries = count *
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+
+				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 			}
 
 			if (!contiguous) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..9e1607fb3b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
 
 	/* APUs mapping system memory may need different MTYPEs on different
-	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
-	 * to be on the same NUMA node.
+	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
+	 * since amdgpu_vm_update_range ensures updates don't span NUMA
+	 * node boundaries.
 	 */
 	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
 	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
-	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
-		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
+	    num_possible_nodes() > 1 && params->allow_override) {
+		if (params->pages_addr)
+			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
+					params->pages_addr[addr >> PAGE_SHIFT], &flags);
+		else
+			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
+	}
 
 	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
 					 flags);
-- 
2.50.1

