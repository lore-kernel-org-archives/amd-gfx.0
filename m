Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC6BFEEF46
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 13:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4FF88697;
	Tue,  7 Apr 2026 13:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mW07yjst";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02CB88697
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 13:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8nhLLxPJZGtTITfej0pchHiVYFwdc36HAs8+AE3x4AcC1WnmrRB4YLCGY+ha+GZMQOhfQC/ic1Gz0PDNOrw8iZN8E3yKHME4zQM8XnoGP2MWe3dwxMklL5McRZzssJY0KmQJuQqP5uDc25umkxWyCH96ZsA/KMqXUskCupsUNhtCJy7oBkTIS3j5CSm0MPh/2dwKl8QgiAQ8mwTiyDF47xN+dF4FlyPOSOF38cLPv7a0Czi5cZ3RatCpoeFyCfheTJ27NyNJT68wBH14x9bJnx/PsXiueKmf70JrzO2fqPl+/Fu4dNEqNQFne4tyw+WaSCd20jaBNoUHAHaxcXatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBp9zMY62GptV4UN/zut2b2QqTAIhdkiedItPranvJc=;
 b=LiJiJONt4Ov9DHkh4OPpKH+pcM62T6r6ey0AugqW9jGnlOpJce0DOAOTNAgXvH4q7JhDET3FTCfiinwgTbsxUIXv7Bg8Nm0l5yObbVcWgEFgbUhWsM5o9dJxmrZHqzVfWNiDemd/oufX4iWkQog9UlfuuMCS4YUb5l9CK5EXEKWqOojhweuxJqCpH/TMuH5tHy0ZW+44YA2/wYvIS3BI9HidMrpYeEvt1KTA2euFfPeVjft5qAdvRYDr28v6LSeVX9RRlq2JaEYjxzt5rrPYBR1GtTu9sbeBOqugVtxolbz6Cjl8wdJ0QF8SYH4xbwtXf6nN59Zn8ZwswTQ4Lv3DOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBp9zMY62GptV4UN/zut2b2QqTAIhdkiedItPranvJc=;
 b=mW07yjstS3yBcd/hGlagjGlBH1ZEIJdUffEraCPhULvE5f29uLugTBBQ4GrsZhiOW/qwCIYbmk58gH5XW5bkao+jW+JCO0t427ku08ajxZvATiUhHJW9/THoLRtroE18sOTwSqwwDzi3v8NRn8DDgPwNGd4gtT7Q0w/SWnZmYps=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 13:39:29 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::54) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 13:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 13:39:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 08:39:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Kent.Russell@amd.com>, <Andrew.Martin@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
Date: Tue, 7 Apr 2026 09:38:33 -0400
Message-ID: <20260407133833.463741-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: c9579e78-b868-4dac-8c3f-08de94ab16a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: NJZyi05Azrsd5mUmnMMuuGSCeQD6/RnBexPKZBCTrDotSrVGMXpki2XvCZg73wcfS9cngkqs8dfGk/qBx56gNjucyQ8syraMs4nqOSkcgY6SCjLdm53dk1ZQIsGsd4YGIPgHWGrAYobZOr5+EDOg1aqlkYwMmxq/KTy7P82YR6ndpaIxHFV4mo/MUq0yrnoVAfOBNZEnjH5q/UHy3wVKoBS89RncWZ8eA4V0au1ZMYJXZ7D9UokhrHENlkFv2lwm7T0Z483uKYAwp4XqDEC9BKq3OqAIPIsaiQfr54q+tlUGk4UlhblG7j6xI+mRsHveW8Xcu4jERsWofVatYpv+zqR+ZK2MlIR7b05o+jwo1wOYnFJuw5CeQnYxuWar1tUi4fTX63VFRks+LpRwK6XvaMs8dc9jMjmlw2MYM86tOwxDwZm7nfRf0yG87sjOAubYxZ9ppd3POu7TqPbwgbd7xK3OwXynYfJOd/f/l3UWBrYY2+5ojZ4wdO8R+2MbbJeSmvscsle0JYesdh5JKB0gIf4OTX7/9eVFnNcvwIqMat6d3ja59AHQIrj5cNnnUMArOR/URj4xsPnBFJ+Ru6XkWFSVl/0nBi7LHret7bCj/5kzvEw9u+1Su2N8Z57JVe64YpYScR1EtrHHFEpgn9LXOPpDygraqjCild5vV6gvAjBOzqAmQzrl7wBaRU4pukyTqQfgBN91Qr6QDOidDw5dT0olhKJBz6kR1oUu53w2l8u5XPbmf0ZRLtj/k2XYzHq6/57NJOiqO8aqML0AP3PjeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LP3PAn6NV/vPOLQ9T/wZGE9tRLHf43PKWhSofeFV7zdjElHB0TChfVdIOTKJyT4d2QxsIaAu8vpZ1hrPxMH0iiVoXjGo7czfQAmnp5FERUX7nyAcI6N/kdD+fkjV2HYTB7hg9M+g87Yui9Xru4n/cI/Wrp19HQgzJV37Fy9WcSVsIQuQ8L0jVh50PtK/Qrxw1Y+0eCdbPxox5vj0Sm5ccCq8j66O1EwEo6SVtJBvQjssCA/6Uhp/F2Ilf3fNFpqRiC6xg7O7ivZ17NUKBGxjVpIQiBhhVtbbKX4iLgdZna0EvpvR3Ah+xyvPVBYzl7RQ/WoRZGIej6qsrLQornBosIVdHs7wod9FVCLHOcqPggDJTkiXIk41gSUwx53ZIQxZqaSreG2TCKg1b5O4VwCcaGFncfsqjRm4iwEHFOozc7Mg9Q1l10XWu0oP73C/5p+J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:39:27.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9579e78-b868-4dac-8c3f-08de94ab16a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..f8fcbf079bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 }
 
+/**
+ * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
+ *
+ * @adev: amdgpu_device pointer
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
+static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))
+		return (addr + PAGE_SIZE) == addr_next;
+
+	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
+		return !contiguous;
+
+	return (addr + PAGE_SIZE) == addr_next;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				uint64_t pfn = cursor.start >> PAGE_SHIFT;
 				uint64_t count;
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+				contiguous = amdgpu_vm_addr_contiguous(adev,
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
+					if (contiguous != amdgpu_vm_addr_contiguous(adev,
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

