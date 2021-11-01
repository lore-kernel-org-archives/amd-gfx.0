Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C29CC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 12:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E3D610CA
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 12:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34E3D610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A7889D73;
	Mon,  1 Nov 2021 12:55:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D84D89D73
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 12:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuH6i8Mgk2E6ex9LeibxG4mxSXyIjzREbDdapZcWntFLjCZ0rNMtXrDdyGprZRXsJobAvXPSGybA+LpiWgthGcyj8X3wz9yknETltrUv/43n5lB+yg2RNyxRzOnguNMaViIJCl8AwOX5N1nn2n6x7sLjrfn1s75cq1us3aJqRfvSvxOi/1JjbyoQXBW8llcnzqRoJ4w5tcy77EnkjIG1SVwnj5kPUu8O3A3tqFVRXu9ODxeIzQfN1PGa9BY4VobEmlO9hJvxtu5+wrw1u8lZq4/9Hakkp4GMbKhyGNz4AfVQXxNE/VyMV9gARvER8fwJOLZaFlPGdb8EOUbJZsrTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lin4BOp9z4TzY+Gm4SK3S/Hxtd5DP68GYBaGKhO9lk=;
 b=UqJGg/AXYfeNzpcWs4tRRnk4ya5bQ87SxjytXTQck4bQw4iYlpBkHy3mf/y2U7V32PfeD5CwchNK5U4yeB4VJxoIFOmh2JFTbxfbzEohWg66MNti//ww4FIK6/tBLO6NaSJf83dPPs3q623usWXIL3+2a1jqPnYoNSv8l2wfaB07P6wUhrdDv01TdWvPf2VpkqvmJTJydH91jH6H6WrtKMR8OXpFxVmqunpWtdY52rMCaOYEieuIUdaJwMNrMm8//bVEfCWnccaRE3BxCBbpLJE9T3syvuRzBHAdBu/ZPkbc5mmQeewkABkSTDf90J5pf0okQV9CICqrGmos55HWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lin4BOp9z4TzY+Gm4SK3S/Hxtd5DP68GYBaGKhO9lk=;
 b=O0K9t8q09m0FqvBBc4hGWM0i5bUbdiHXXIj6pbPiaabQoyPjgNoZvFqBVvxzE3NN5ouV2f+jaWjpDlMSIDr0NPupZu1uDkrbq2wpEIQy6BkMOKxAO4ImmIxieBqR3VI13uRuTPtNmtr5I1iPD+mISfAJHJ39b9d+m0kAdFD24mk=
Received: from CO2PR05CA0094.namprd05.prod.outlook.com (2603:10b6:104:1::20)
 by BL0PR12MB2499.namprd12.prod.outlook.com (2603:10b6:207:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 12:55:38 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::fa) by CO2PR05CA0094.outlook.office365.com
 (2603:10b6:104:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Mon, 1 Nov 2021 12:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 12:55:37 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 07:55:34 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Handle incomplete migration to system memory
Date: Mon, 1 Nov 2021 08:55:13 -0400
Message-ID: <20211101125513.999187-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101125513.999187-1-Felix.Kuehling@amd.com>
References: <20211101125513.999187-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e6a50c4-1e51-458c-5883-08d99d36e6e4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2499:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2499929EFB9FD886F43509E2928A9@BL0PR12MB2499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNbWxDLJClGMjv462qR/ADGf0r8pTPjDXkktK/1thG2Sc8ICO19TC507+4yELVaBoR0m4YUf0ubVLrLs2J2TMT/3IQ2otPEs8rK6g2YMO3fVtG2hWXN0y9PDEoVaLTlnM64wV9PCFjC+/N0dXC8yrN4fbQOya8YIEI3oTFeMGT44KKjeUHSUep9Adq1LOKOWY3MZkKP/1QeYe8mxzzKbxOhC2zGKorSwRzgPgT9SrtbLMqeGP8HgT583/ys+4hTMlTcEPcaYee8Lryy9b3mhnG5cdLUZLPUb+f00pEyI+bqNUciZeqpnT4V175WyFQ3dOgiiilzV65jKDAx2sS+Hc1Al3TrJPVn2HW++EFvV/PCO1ZM0waBvAaS2M1wG6bqn5g8CytbSd2+Q/ILmcXk8QC9rmvCeTQRYbrT7S/izbA9XMP+aPa8goWEvfLP4XL+rgbkYCegFecDEkALR4iWT12xDIMEnt4fYcjpMs4U1BkBsi300jVP6hXSXqxrZGgQfOGSMsE1LuYGZcEo5YkMkzmSLJZrAAT2MBslninHSDsglMNbd9QCbGMd3DNha3glaxFjvVfZqSUSM0jflXA7ppde5giAEQxw2m3KwnETcerwnERGN1hBq08WMk7p/Sa9lNPbsJpeJIf3JTq10Zm67VSj9yOb6P/qnzzR2m2q3eB2DrHb2lkyaBAdIl+vwbxhW9yUE1PSE94FPvzaotIYjB8xGMMI9oT2X4QnybSbjFXI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(336012)(6666004)(36756003)(426003)(36860700001)(8936002)(26005)(8676002)(4326008)(2906002)(86362001)(16526019)(316002)(83380400001)(356005)(81166007)(6916009)(7696005)(508600001)(70586007)(70206006)(47076005)(1076003)(5660300002)(82310400003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 12:55:37.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a50c4-1e51-458c-5883-08d99d36e6e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If some pages fail to migrate to system memory, don't update
prange->actual_loc = 0. This prevents endless CPU page faults after
partial migration failures due to contested page locks.

Migration to RAM must be complete during migrations from VRAM to VRAM and
during evictions. Implement retry and fail if the migration to RAM fails.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 45 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  8 ++++-
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6d8634e40b3b..cc1525095937 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -281,6 +281,19 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 	return cpages;
 }
 
+static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
+{
+	unsigned long upages = 0;
+	unsigned long i;
+
+	for (i = 0; i < migrate->npages; i++) {
+		if (migrate->src[i] & MIGRATE_PFN_VALID &&
+		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
+			upages++;
+	}
+	return upages;
+}
+
 static int
 svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -634,10 +647,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	unsigned long upages = npages;
+	unsigned long cpages = 0;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
-	unsigned long cpages = 0;
 	dma_addr_t *scratch;
 	size_t size;
 	void *buf;
@@ -671,6 +685,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	if (!cpages) {
 		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
 			 prange->start, prange->last);
+		upages = svm_migrate_unsuccessful_pages(&migrate);
 		goto out_free;
 	}
 	if (cpages != npages)
@@ -683,8 +698,9 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
-	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
-		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
+	upages = svm_migrate_unsuccessful_pages(&migrate);
+	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+		 upages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
@@ -698,9 +714,9 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
 
-		return cpages;
+		return upages;
 	}
-	return r;
+	return r ? r : upages;
 }
 
 /**
@@ -720,7 +736,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
-	unsigned long cpages = 0;
+	unsigned long upages = 0;
 	long r = 0;
 
 	if (!prange->actual_loc) {
@@ -756,12 +772,12 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 			pr_debug("failed %ld to migrate\n", r);
 			break;
 		} else {
-			cpages += r;
+			upages += r;
 		}
 		addr = next;
 	}
 
-	if (cpages) {
+	if (!upages) {
 		svm_range_vram_node_free(prange);
 		prange->actual_loc = 0;
 	}
@@ -784,7 +800,7 @@ static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			 struct mm_struct *mm)
 {
-	int r;
+	int r, retries = 3;
 
 	/*
 	 * TODO: for both devices with PCIe large bar or on same xgmi hive, skip
@@ -793,9 +809,14 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
-	r = svm_migrate_vram_to_ram(prange, mm);
-	if (r)
-		return r;
+	do {
+		r = svm_migrate_vram_to_ram(prange, mm);
+		if (r)
+			return r;
+	} while (prange->actual_loc && --retries);
+
+	if (prange->actual_loc)
+		return -EDEADLK;
 
 	return svm_migrate_ram_to_vram(prange, best_loc, mm);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 854735dbb96e..e6897e931057 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3083,6 +3083,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 		struct svm_range *prange =
 				list_first_entry(&svm_bo->range_list,
 						struct svm_range, svm_bo_list);
+		int retries = 3;
+
 		list_del_init(&prange->svm_bo_list);
 		spin_unlock(&svm_bo->list_lock);
 
@@ -3090,7 +3092,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 			 prange->start, prange->last);
 
 		mutex_lock(&prange->migrate_mutex);
-		svm_migrate_vram_to_ram(prange, svm_bo->eviction_fence->mm);
+		do {
+			svm_migrate_vram_to_ram(prange,
+						svm_bo->eviction_fence->mm);
+		} while (prange->actual_loc && --retries);
+		WARN(prange->actual_loc, "Migration failed during eviction");
 
 		mutex_lock(&prange->lock);
 		prange->svm_bo = NULL;
-- 
2.32.0

