Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFEBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8B910E203;
	Fri, 14 Jan 2022 20:33:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF3510E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgPnw0z9JUKAfvQCEUH4bZZ7eP2sbJZFs0ulPDIz0I7mS7HLga7q0YXTKvhYu++XxPRzDDzufCVAv9IRFQLsfqm1QjOKmuKwQN3bIViHvwCWiAKZEMBF2y/3QsrhnnnYiwLrv/xLd5qqgrutVS07Imc8VBl1uDqhLpuI9YEQs8e1h9gp/Q/Gfl9jUn2thxcW87Ve5jIiyAORqKKDyAHTldD1zSWfoPzvvfuFq8o6/utAx5JcOGh31pRSFNTYAKuk2wYfYfJljvoTF3VwbUASSZamIzxHyea8E4qNFnCbQunVUOIWP4WwY5aW16lN4mbdABujZs3amcSBr375paSmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHMBtWpgCf2E35nF/mW3GT2xEM7LpodygceteD70Ujc=;
 b=VrMikMQuNnCicTT+05l0WTbU4rGL/6+DvL1fcHQDizKBdgYYyOdDFXPo6gN/cppOeaa31g7yXYRDXwJPWgFqRS2cdV1PkdRzl5BQaHt2SvnVCasKICClpln3Ca4TondRmJ6Gaf9j7n3hrtw/KxR9xWcl3woJphC/mw60Pp7FnD6uuwO2zTyH1N+BqWZO3F6QSbsEp2wcdUyNcy8dpWRZXcKgfBEzTjct82M4BrC0M0X36PDmujnQIkr1rpJ9n/jou8ZPmQOpKj9TMRvLdDVcmvGioriOJiolUYQWozXEYEj5BhKCLEnKooAbKAwvE1tAcVv6MCNTVVXlLBxlnEeBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHMBtWpgCf2E35nF/mW3GT2xEM7LpodygceteD70Ujc=;
 b=W744QWLvaK+uJYYh91EPo0bZfJwrnz74jhR+cxG4KIkOnyfGnOoaYoOXRJC/kYX7OSfp0aOswua5URZrV3+IHaVFitewBq+iZNLCvFQJoIKLL/LKrIgjafvMQpmRN/pgTJRc1EtrR4ncUSOxt2yAko+7tyVFZTP61HO90J1HHeA=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 20:33:23 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::8d) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 20:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:33:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:33:16 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: add migration SMI event
Date: Fri, 14 Jan 2022 15:32:56 -0500
Message-ID: <20220114203256.19821-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203256.19821-1-Philip.Yang@amd.com>
References: <20220114203256.19821-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a91540ab-5682-4075-0b19-08d9d79d1c4d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806AF8F59911EF870AFFD33E6549@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkkwrACu422uBU4rLUriVu8zhbfmn9YHSiZ5MRVMPrXFTFLYAhjyYi4GmvJaHUNtlTz9QVUoa4vejrG+jvCgp2PRP0beqBuJL8hNEFVN+3ToGus4sTHxqnoZmDnKD47/tbl6m+HKH8QDOhmPMXKiE3X0mmKkgav0vhNvbsr+m7NlTDeixDv2dszmG77S+ZUnGz1e/fIe5DcXyGx1RYTs8X3P/roXr8yICrhflFCUFtY9bXy5M3s/rpEsZ6IjqDr/iD1DDWwIETszzLFEiy6UEFzZPxF1UKL+9XaqvSgjOFep17aOFCjefaO59W3mcW617XGOh8Moc5TbPomUNnjiwDZzuoomvlgwkdR4/+LY/NgtaJgUtkf1by7K5EtKHgAhhFQZ/3EDEydBFz0WUKSy9+g+/hCnUbZu3ThHmgEMQYW8HsOrA7KeJ3A2YtINWp4RdMPtKSA0FiNaL1vUmzw/tvGG5kZM3aCSNlYe7PR6etz/JDlPesJHhdeizrxpIi/jNLqv+CPoTA3VCtnUq+agtu+g3MDXUHTjibbpmLa/ITytUgxfej3Wqw5v0GVFG2zc3vX8R5FOrmV9/z19Zgsc97Vf6mrjDQZv94Itg3vS5wn3NjajtZ5BfFj0nj777y8+SJ3nUuaoeotNXEQ032nEs2j7bULmURQA5lGhi76HMJgu8qD6w7NWOUDs1aSRUYusZ2LeNgjLaImId6dAqYra1PdDaLkwFBNQyOMlm0hCTAnlSVXohWIj5EOPPM1Ww76ILm7flO5gB5A3QB7SN/RS9aW+jqejHWQahvsapwiIQZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(47076005)(83380400001)(186003)(30864003)(356005)(81166007)(426003)(54906003)(2616005)(8936002)(4326008)(1076003)(336012)(36860700001)(2906002)(36756003)(82310400004)(5660300002)(6916009)(8676002)(6666004)(70206006)(508600001)(7696005)(86362001)(316002)(16526019)(40460700001)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:33:23.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91540ab-5682-4075-0b19-08d9d79d1c4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After migration is finished, output timestamp when migration starts,
duration of migration, svm range address and size, GPU id of
migration source and destination, svm range attributes,

Migration trigger could be prefetch, CPU, GPU page fault and TTM
eviction.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 67 ++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 24 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 +++--
 5 files changed, 86 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d5d2cf2ee788..eb12f1c3c3fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -405,10 +406,11 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end)
+			uint64_t end, uint32_t trigger)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	struct kfd_process_device *pdd;
+	struct kfd_process_device *pdd = NULL;
+	uint64_t timestamp = ktime_get_ns();
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	unsigned long cpages = 0;
@@ -434,6 +436,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	pdd = svm_range_get_pdd_by_adev(prange, adev);
+	if (!pdd)
+		goto out_free;
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
@@ -462,6 +468,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
+	kfd_smi_event_migration(adev->kfd.dev, pdd->process->pasid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				0, adev->kfd.dev->id, prange->prefetch_loc,
+				prange->preferred_loc, trigger, timestamp);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
@@ -469,10 +480,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	kvfree(buf);
 out:
 	if (!r && cpages) {
-		pdd = svm_range_get_pdd_by_adev(prange, adev);
-		if (pdd)
-			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
-
+		WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
 		return cpages;
 	}
 	return r;
@@ -483,6 +491,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: the process mm structure
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -491,7 +500,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			struct mm_struct *mm)
+			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
@@ -528,7 +537,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -644,12 +653,14 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
+		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
+		       uint32_t trigger)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	uint64_t timestamp = ktime_get_ns();
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
-	struct kfd_process_device *pdd;
+	struct kfd_process_device *pdd = NULL;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
@@ -674,6 +685,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	pdd = svm_range_get_pdd_by_adev(prange, adev);
+	if (!pdd)
+		goto out_free;
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
@@ -704,16 +719,19 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
+
+	kfd_smi_event_migration(adev->kfd.dev, pdd->process->pasid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				adev->kfd.dev->id, 0, prange->prefetch_loc,
+				prange->preferred_loc, trigger, timestamp);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
 out:
 	if (!r && cpages) {
-		pdd = svm_range_get_pdd_by_adev(prange, adev);
-		if (pdd)
-			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
-
+		WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
 		return upages;
 	}
 	return r ? r : upages;
@@ -723,13 +741,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  * svm_migrate_vram_to_ram - migrate svm range from device to system
  * @prange: range structure
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
  * Return:
  * 0 - OK, otherwise error code
  */
-int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
+int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    uint32_t trigger)
 {
 	struct amdgpu_device *adev;
 	struct vm_area_struct *vma;
@@ -767,7 +787,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -790,6 +810,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -798,7 +819,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm)
+			 struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -810,7 +831,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, trigger);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -818,17 +839,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange->actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, mm);
+	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
-		    struct mm_struct *mm)
+		    struct mm_struct *mm, uint32_t trigger)
 {
 	if  (!prange->actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm);
+		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm);
+		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
 
 }
 
@@ -897,7 +918,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		goto out_unlock_prange;
 	}
 
-	r = svm_migrate_vram_to_ram(prange, mm);
+	r = svm_migrate_vram_to_ram(prange, mm, MIGRATION_TRIGGER_PAGEFAULT_CPU);
 	if (r)
 		pr_debug("failed %d migrate 0x%p [0x%lx 0x%lx] to ram\n", r,
 			 prange, prange->start, prange->last);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 2f5b3394c9ed..b3f0754b32fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -41,8 +41,9 @@ enum MIGRATION_COPY_DIR {
 };
 
 int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
-			struct mm_struct *mm);
-int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm);
+			struct mm_struct *mm, uint32_t trigger);
+int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    uint32_t trigger);
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 6ed3d85348d6..7996438377bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -286,6 +286,30 @@ static bool kfd_smi_event_pid_duration(struct kfd_dev *dev, uint16_t pasid,
 	return true;
 }
 
+void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger, uint64_t ts)
+{
+	char fifo_in[256];
+	uint64_t duration;
+	pid_t pid;
+	int len;
+
+	if (!kfd_smi_event_pid_duration(dev, pasid, &pid, ts, &duration))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%d ts=%lld duration=%lld"
+		       " pid=%d pfn=0x%lx npages=0x%lx from=0x%x to=0x%x"
+		       " prefetch_loc=0x%x preferred_loc=0x%x trigger=%d\n",
+		       KFD_SMI_EVENT_MIGRATION, ts, duration, pid, start,
+		       end - start, from, to, prefetch_loc, preferred_loc,
+		       trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATION, fifo_in, len);
+}
+
 void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
 			      unsigned long address, bool migration,
 			      bool write_fault, uint64_t ts)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index fa3a8fdad69f..7dcc66ac8798 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -28,6 +28,11 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
+void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger, uint64_t ts);
 void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
 			      unsigned long address, bool migration,
 			      bool write_fault, uint64_t ts);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b81667162dc1..d7dcc443c16f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2780,7 +2780,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (prange->actual_loc != best_loc) {
 		migration = true;
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm);
+			r = svm_migrate_to_vram(prange, best_loc, mm,
+						MIGRATION_TRIGGER_PAGEFAULT);
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
@@ -2788,12 +2789,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 				 * VRAM failed
 				 */
 				if (prange->actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm);
+					r = svm_migrate_vram_to_ram(prange, mm,
+						MIGRATION_TRIGGER_PAGEFAULT);
 				else
 					r = 0;
 			}
 		} else {
-			r = svm_migrate_vram_to_ram(prange, mm);
+			r = svm_migrate_vram_to_ram(prange, mm,
+						    MIGRATION_TRIGGER_PAGEFAULT);
 		}
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
@@ -3115,12 +3118,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 		return 0;
 
 	if (!best_loc) {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, MIGRATION_TRIGGER_PREFETCH);
 		*migrated = !r;
 		return r;
 	}
 
-	r = svm_migrate_to_vram(prange, best_loc, mm);
+	r = svm_migrate_to_vram(prange, best_loc, mm, MIGRATION_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3177,7 +3180,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 		do {
 			svm_migrate_vram_to_ram(prange,
-						svm_bo->eviction_fence->mm);
+						svm_bo->eviction_fence->mm,
+						MIGRATION_TRIGGER_TTM_EVICTION);
 		} while (prange->actual_loc && --retries);
 		WARN(prange->actual_loc, "Migration failed during eviction");
 
-- 
2.17.1

