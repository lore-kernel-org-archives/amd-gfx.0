Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3BAC5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D5F10E7DF;
	Mon, 17 Aug 2026 14:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJ9NSFM7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1758F10E7DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG5/c5/Suf2ry7s8m9gLy1EnDPudxIkhiP9cnie9oicoVKZh9ChLb1K2gQGjgeWdOnRLKMPETkN9RBFvdK013xSgDU0juZWTi4nc9PJ70PNu887iDm3YUlYx/9d4oly8t5qCUyX3pGSlDeqg2OxWLsbc0n8m0yWughOMZ/hz8bgxfvUNZ06Cj7K2Zmi0XHrqlSimMvOOclaVq19LO3RDTso5Lw3Cpo46lMGiMlPEgurU74NWt0F4ycHKOEX+Hqfn29h9P6l9ShD7oc7J+tAcP3v4meQm2fTQk4XDeTACKB03HBpPmSPGLBPelUETJfQob9Rob7d80GCCXcSLZSkqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNr53fIpdUdH3Njw7Zq4RH7BWQm0DXpmRRmHjNIFcwQ=;
 b=xqJxydb8T2M5pvXNfG+AryxTMpuOMCOdJJF/O7/pQlmg7QSuky+Jagdu/q++vXdsvIpb+TpQ3Mw4KfPuMEDgrrgO/1OLVKANiSFyTG2OGSegRqtGHKuTU58gd+f2iS8WvvBu3hYJiygfKKJ8hBiiKZljcNSZwRgW3XddjJGIjmZJeZYNoh0b0yoy//P+UOXQU/uKSO1zNYgQ4E5xHcEn2+K0uoDltAmecQIfwjWyHmo2B6qQ596jIPuAeRVdfTj1MklAOs9aOkiBUDqHYLBSmU2a+b3uBakDUQ1iTWGXkdDaCPBCmoMqzlfv/CmXQL8oQr//YJlkLtFva//1uR+xRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNr53fIpdUdH3Njw7Zq4RH7BWQm0DXpmRRmHjNIFcwQ=;
 b=CJ9NSFM7GXPm+Qam2dlNB/v8ZCe75ZUcYG0/Q3CjUs9iEXP1wNWOZdh52DPRfD1gbhiasVihOFlXEphI4uLuw+ymOZKc0W1IgkUWIsS5hT71Ofjf4Nvb0wtlq4AnVAvB5/pWYrjuzgcd6ttpNKsgTow8GCM0ezNKO4lNbEHTUyo=
Received: from DS7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::16) by
 IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:00:39 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::2d) by DS7P221CA0020.outlook.office365.com
 (2603:10b6:8:25c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 14:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 14:00:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 09:00:38 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Mon, 17 Aug 2026 09:00:38 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Check cpu page faulted vmf->page got migrated
 to system RAM
Date: Mon, 17 Aug 2026 08:59:18 -0500
Message-ID: <20260817135918.228397-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817135918.228397-1-xiaogang.chen@amd.com>
References: <20260817135918.228397-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 500f04a9-69aa-4419-f360-08defc67eb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wm3ulgwAH54gWE3PQmuOF3A8HfeBDWfUV3N+NEX618WEL1jxe1vMDIvja8O7YzbgenfNZpzcuwBHAIb7t7IhyEW0VnYdgYL4LRxK1W0kVC0a2veMbUvz4EPxQkEbHe2ivs6ghQA/AjlMSbgR3bzDBX2PwhFP1u+pO8GR1x6eiO/J7OmluXUxU36kOxrQMR/mjBJWA1kKmpFpjG50hOKEDZx2P96BIBbd84VMP1arNRaJiSA3HaAv4ALvAXiLllyygawcLPTzhAkoWfnzYrGN7UTRESTeyxwE5W7Sswe5WQCKMHHm4GGCwuSyvDla5B1rjy0YDhiDTMFL6LsYOJgIZwds6/VOEKRw9XjK09+NdKB1XVkcGY2LEJBgXWAkX2V7EwoQFd2N1SO1pTtNjdGAA94g8ut3DkZt6b7cv/w/xrG/ODYdWA7an+VsilLAD94iPpnEaIy7J1uXsuV0vradMZmHsAUFbkK0LQ7SE076X/qdPieOWsOtAIYcnhlOzNpenOyTd26JfkPVxmATeuD7xvmHWnk4U6aEikctnso5wOgWn4mdns+GwEIOMc7aMYzTLtsI1s/sRwB00t5MAL0vkPLa4JtSCOsZwq3mTmvkNhmlKRXb8n/vhyQ0Y9qmYgPdjuuQ7Wtjpg9OgHPiYuslxMNurxqbnrQpP7fzrHqcHMHmAIkx121M+UD2TypiVioP8eZuvHurvvOvkh2YPbinYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4tDFG01ybyDGrxpkGvov1lifFjHuiY2AqsTJ597g3JyR+3glIgAycxjjy+0ueeoFQgJj28I4ORGfUmc5WQAAZYl28esGgHcQdClyCKHeDl33JkfXWE0L5MzlTCAb8vXHPcgPZAczdJ7dK2oS7Pqew3y0QZ+p9ad9o8oFFLyMXS665cU+rOYd41g1ELlWOnwV9jONQSiX5kpvzZMkZumEmx1CSlkWHpD4uAiAM3GxFXYLpDtj2YkFKCBftJj+wtRItaDNv36paRyVIl6XI61bcs8CYR/Y5E9k7/fpF70PKf2QeikjJ+kSfE9T18DAfqycvrQzRHz4PfbISUTraK7DAbrIOcmB/qjpNnIkgeiACA0e4f7K4cHDG0RDpVoShfuldRSKn/bkc2j/yd1xEeVlgVZYQpl9KSy2fxTfuCzYForOA8mxMWeUvZt6Pev3mF+q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:00:39.1766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500f04a9-69aa-4419-f360-08defc67eb4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Cpu page fault hander __handle_mm_fault calls dev_pagemap_ops->migrate_to_ram
when faulted page is device private memory. This callback needs return either
success or vm_fault_t to let handler know what happened when handling the fault.

Current driver returns success if it did not hit a hard error. That does not
means the device page is now in RAM. Some cases like fault page pinned,
lock fail or other mapping prevent faulted device page got migrated.

Then the CPU instruction will fault again(retry loop), unless something else
changed the PTE.

The patch explicitly checks if the faulted page vmf->page got migrated to
system RAM. If not, returns error to let cpu page fault core handler handle
the page fault in error path.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 28 +++++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 263dae49bb3e..656197dee9b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -582,8 +582,9 @@ static void svm_migrate_folio_free(struct folio *folio)
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
-			dma_addr_t *scratch, u64 npages)
+			dma_addr_t *scratch, u64 npages, bool *fault_handled)
 {
+	struct page *fault_page = migrate->fault_page;
 	struct device *dev = adev->dev;
 	struct page *dpage = NULL;
 	dma_addr_t *dst;
@@ -646,6 +647,13 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
+		/* if this spage is not migrated the function returns error
+		 * final decide whether the fault got handled is decided by
+		 * fault_handled and this function returned value
+		 */
+		if (fault_handled && fault_page && fault_page == spage)
+			*fault_handled = true;
+
 		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
@@ -701,6 +709,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  * @node: kfd node device to migrate from
  * @trigger: reason of migration
  * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
+ * @fault_handled: whether CPU page fault got handled
  *
  * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
  *
@@ -711,7 +720,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		       struct vm_area_struct *vma, u64 start, u64 end,
-		       uint32_t trigger, struct page *fault_page)
+		       uint32_t trigger, struct page *fault_page, bool *fault_handled)
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	u64 npages = (end - start) >> PAGE_SHIFT;
@@ -771,7 +780,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		pr_debug("0x%lx pages collected\n", cpages);
 
 	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-				    scratch, npages);
+				    scratch, npages, fault_handled);
 	migrate_vma_pages(&migrate);
 
 	mpages = svm_migrate_successful_pages(&migrate);
@@ -816,8 +825,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			    unsigned long start_mgr, unsigned long last_mgr,
 			    uint32_t trigger, struct page *fault_page)
 {
-	struct kfd_node *node;
+	bool fault_handled = false;
 	struct vm_area_struct *vma;
+	struct kfd_node *node;
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
@@ -861,7 +871,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 
 		next = min(vma->vm_end, end);
 		r = svm_migrate_vma_to_ram(node, prange, vma, addr, next, trigger,
-			fault_page);
+			fault_page, &fault_handled);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate prange %p\n", r, prange);
 			break;
@@ -886,6 +896,10 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		}
 	}
 
+	/* need handle cpu page fault, but not handled */
+	if (fault_page && !fault_handled)
+		return -1;
+
 	return r < 0 ? r : 0;
 }
 
@@ -1027,7 +1041,9 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 out_unlock_svms:
 	mutex_unlock(&p->svms.lock);
 out_unref_process:
-	pr_debug("CPU fault svms 0x%p address 0x%lx done\n", &p->svms, addr);
+	pr_debug("CPU fault svms 0x%p address 0x%lx done with erro=%d\n",
+		 &p->svms, addr, r);
+
 	kfd_unref_process(p);
 out_mmput:
 	mmput(mm);
-- 
2.34.1

