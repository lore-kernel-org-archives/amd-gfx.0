Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEE5C624CF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 14:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4773410E90B;
	Mon, 31 Aug 2026 14:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wj99+IUF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9962710E90A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 14:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmuWJOUft+y6za9Cidww94R6zt7f3/FU5YwWIns41qdbm8aAHZ4GItDZld00gCaF7mqp87d8jHNp3D+AsImeUviFA0rMzQbCB1SfDB4LzRsKj6jIV4i4enCjLHTCiD0XvzuMZsii+cAcnXtLxZpbfxHqwDIzWJ/ekV0YS9eUs6mJEw/RKBm/WtjjKO1MibtcQQvLNZxJTqJ16kpi3jM7doAnEAePwzpkj2E1GhvyhD+NwQsBrtH/6DEiMx9WyGiaRX7bOXt0yOne3DLSE37RASSLvBwN1gB4B8mhKgsP8MLiTWYJhPrYg1nC3Z9xKhTCp088cSfouq69BFy/41b6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KirFtqFGmLnDFaESIWjaTxZ5Uu7IZ5RksyroIO/s+w=;
 b=ZBW3M1ilj8V01ctHn4ODuzn09lfkK33tVhebsvegn6HItzPqeCI6PtRYV9k9J2snYPGXHtGtkI/RWklRvYEpwZrTUXeP0pojtFv5k/6zK99/0WQhF7LGBsWTJuzkvwOsgmSWSf8+iQ2nDdRO36orjSLwtpXs2OsjLC8krWtYIEIQbBXglznXEJRVmK0fAbQppIOx17+b3Mk3K6EVuTUJXYNp0Lo4z8/EfAJzug50zFEXPpGm9vdqNRGO1k5B3zWk1V6Chvl4ice1GZxGJPmm+G+3rz/XtMJGQZTgL2nzi6heJK3TamEWfdel0L29hX/RtcjT8OJl6wmusc8elc8lqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KirFtqFGmLnDFaESIWjaTxZ5Uu7IZ5RksyroIO/s+w=;
 b=Wj99+IUFf/WIk09MY8pEESpQkoT6sOn936aeUqeFSP3rgz9o0WjiQhK1/8+hkV+0LDv0mRG8H8penSpYWLDG+DSX7PNrYV9UA1+s09thVFF4RzVxVuXE1QCxpOK9R1bDsZg03+7fEBGBnGNcWDhxjeqpy08mVF3Q5F0a6IM9sBE=
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:26:31 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::8) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Mon, 31
 Aug 2026 14:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 14:26:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:30 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 31 Aug 2026 09:26:29 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: Add awareness of THP of device and system RAM
 in kfd svm driver
Date: Mon, 31 Aug 2026 09:24:15 -0500
Message-ID: <20260831142418.56423-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831142418.56423-1-xiaogang.chen@amd.com>
References: <20260831142418.56423-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a55827-9d08-4509-0b71-08df076bda03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4oLN8RzFKjBf/MCV7OjledoORdscML61wQ01qavq4kGJ05lKx/q1AYN4w+3H2/cWLRigWG0i8/d0VDjznOaicz3XURoB0TviN/gkTBAFaHUy1ZcWJ5Qqn4kd+oFpskC155F3eOJW/vrfyjD50YI1euYzgc7OJlppLvmgTWrxf1c1Uh8CczKM6EhjUrt3uixtcx+tCsHtgIW06EODb6ZdVLsZJv1devKQmZLse40AZXKreG4fIktvONiccKqTw2Cw++r+S1n0+UflL+1KXJOEqdyK+/gmMolPQnf6D08xsU9SmKdiVi88iRZUgojqB4ygJIeFmmtZ2tKnugOjMw9S1ToJSKhGKbX2TcGTLN8pzEQMz+h/TF3w9zCtOSy9vybdqIGaYmeh3rLFn8BRxk0vRkNfJSTkJSrExNJllo2N/RoKCu2TmrZjJxSprTMY21lolYPe3VBkTXEm4tu7DPkdDVMdjAK1VeebBfr7hoXVVbcX/5+LpahPVjgniMRHCpG/2qXtKGmNWUv0UvzcYhHyNsv91f7rp/ZmJOZvxp9KlR2oq00x94UAECH7RdJ5QS04eZon5m31yJCKP7ltM92H7zUgcSz5hIXWP1fzdwB7bAyF0HuogDbkk6z5jY4Yr6rkZUmvy8Butzy/zcxt4xORUrOeDOvICAU74s7FOtbQ/rBJdXm3VMvJA2V7sJ5vlnCy+jCmWud61ysLYUa6i6PvKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W3fnufNWokI/B0Ts4S5Z2Bh1X5q7Wn0NG7ED8ClhLD+xz/jLv1aJp3EsXAGMFNIjmChq5KelAq+aW/P7QmRXrU3DOeczniT8chkcDhEfggGq4I+MXxZyDzIU20Ptmb4R3w0jsvgyYlwurmBLO/C7wJqsxjbKLFkt1ymOQBTQ7c7MtzBq+JTUCYGYLycc5XDdxGa2FqxYXNqIAJdpnIaOlUKWybWF0nwJw4ry2DyTH00DuIRA4IxVjsEvBADdcedpyh9Te/BnoqB6H+iIYfmu1cSAUPZi2Tze5kn9BtF6B+bYwbBxYPj9lS5NjaiNFRjjvCoMsxFASoWR9HYxc6KSGar9VaA+HI2ynR1LL/jBsYR6iHAHSJV/GcHeFM+BockVc1DEtpNqkE/YOHcplMMEcSUuwLNhrHep3ud+XJx6zzsd4S/xNHhi8kkPgF1F+IDh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:26:30.9069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a55827-9d08-4509-0b71-08df076bda03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

Extend kfd/svm function to allocate HPAGE_PMD_SIZE based device memory by buddy
allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned and to allocate THP
system ram by vma_alloc_folio.

It is preparation for following support for (THP) migration in zone
device-private memory.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 22 ++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  4 ++--
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 253365a8257e..49a231e60dfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -217,14 +217,18 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 }
 
 static void
-svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
+svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
+			   int order)
 {
 	struct page *page;
+	struct folio *folio;
 
 	page = pfn_to_page(pfn);
 	svm_range_bo_ref(prange->svm_bo);
 	page->zone_device_data = prange->svm_bo;
-	zone_device_page_init(page, page_pgmap(page), 0);
+
+	folio = page_folio(page);
+	zone_device_folio_init(folio, folio->pgmap, order);
 }
 
 static void
@@ -247,11 +251,17 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 }
 
 static struct page *
-svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
+svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
+			  unsigned long order)
 {
 	struct page *page;
 
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (order)
+		page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
+						  order, vma, addr), 0);
+	else
+		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+
 	if (page)
 		lock_page(page);
 
@@ -300,7 +310,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j << PAGE_SHIFT);
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			mpages++;
 		}
@@ -630,7 +640,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d51f60..280c38932217 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -578,10 +578,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&bp, 0, sizeof(bp));
-	bp.size = prange->npages * PAGE_SIZE;
+	bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
+	bp.byte_align = HPAGE_PMD_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
-- 
2.34.1

