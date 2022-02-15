Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA6BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F32C10E1D6;
	Tue, 15 Feb 2022 21:23:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AD810E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8a3bViVVnYwr4T+WOKgSR2kUpAwTTKKNvaR6tN1Bd8yi1ev8d1Qxuhjhu3hzL9S0JhbJ4wMMQaVEr5KmmknvWMhW9QcbMNZt6FvoIiJ3qolclfgiDFiVPgFbp41GZvPz9dY6cEcPop62tv9Cu+2OhgF6ipKzbc3EpgKwvOoVncjwWCgKYMohL/lDobOwXcS4Q+MRUwpYpg/j9SYBYA4y8CNNgSr3zChm+IPoTWZAnjQXoNAY4Ru4BiuLCJUrmDSn0tIS6i+Zjgx+SEg5hGMwXpTV27kmUY5VhFAoJFICS/w2PIz2UrWdMHrr71ElgiT7tRCteO72hCz9D6iQmJKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOkKcYPjKZ04AGQtTRrU6cOu4wJppMFLjbdKYQXJfIc=;
 b=Oo42HoH9LWX14kbqg7GAVxodnwNwEi0aKeBvZejZCY/TtdzmR8T7SxrKWqvkESxTIZjUrImb9licPUB7hoo9ovCtAME3UcV+0n6Ug+seh1NtSi/4Gdc6rCtj1f5elLau8lDhBrPIs4uG5HVuJt4QBRJ+SFebIlHwZ4ydK1sJXNcE9PGGrdPKqcDc8QkJrJANgQdXNqTxBeWn0c3e+Txzaaj0OXDjkFPbHPAhpCfz1+A2TFm3QfWcskyuMD7xxH8pjp18m8TKTH3DQbZsw+CAGEhecDdkvroVPV6olDITmJwmB0O/tJP2wTtTkDjnlWbizbd37SIj2jwwovWR10wBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOkKcYPjKZ04AGQtTRrU6cOu4wJppMFLjbdKYQXJfIc=;
 b=fxNN+X7ShMT5ZAd71RsIwHch4+3iXeOBjf0O6FqdvE0UNKIvRJIt12hJZAvVWl2XQPOFxY8fBi/Qx4NjapYFZQ0/cA2HBzy8t9WkBDWQilWsPTnlQVeQ7y2ai22etO9+vwg9I+BhkEwshWZrPde+D5ahSiaMVJQRUlc2g6X45x0=
Received: from CO2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:104:2::18)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 21:23:11 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::d0) by CO2PR18CA0050.outlook.office365.com
 (2603:10b6:104:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/8] drm/amdkfd: Add migration SMI event
Date: Tue, 15 Feb 2022 16:22:44 -0500
Message-ID: <20220215212247.16228-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b1f3c1-66de-4aa9-fa41-08d9f0c95e3b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3681:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3681795957737E9D57DC7595E6349@BY5PR12MB3681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pd9Qq0gmeFBW5exoU9pr2SKs6nSFJuQwo27Ylhd8BwkZkrHqkWWRCYAm+vhqdKAd8VuxQWcEE46gBDeNOOPDgBrcEQICxmpv2l7vctFvB0U3Q70oQ0qwTVsJip5WZrTnQPxE803tMLE4zNRvd5m14Vln9bqFXd4guniuTVu1kwDmae5Gw34pn2Q7D2EKfgdtv9SHEgCIBUsXJURnGrI5sT7ZRQwvU9iakMZCnwoJWX3Sh42kvnn7+1iC87coJjjK/XOrrA+R0wDjhYFpNGiSsetU/jCD14FUtPXpLvtpT4h6ZxH0cmmUr1WftvbE3t7MLe8CfZLuc3y1BrePkWK+1r3t5fpvMPMB91ZBibd928HliIdxk02E4vP26GPkaKg5qHNWxCdg8iFkguhPVDPyCquw/C4CXCloYAmwRuKTf+m//xAYunIlyDop9TodY0f5U/80/xABbz1GFERYHjTxAEZ8Gdx9bd/phHweC1DFHU+T81n66kGw8qIeNsLkR22eDT/THpDs8kblYjJPhArLq+uDR3NLW3xcuYrMFtf/rQsC4vX2YgLETTyuu0j2L0U2xQHsNKSg2IapCnTdMnUIOLs8Gn8rqGmzzqX7jJUWyW/hr1pKLxhgZv830ciwCfAf2Zb9wJ3qfOpDzFbDWPJjh2t45gfWHxfFYVtAR33alMoO3V2bW3SsgVgOpCPJL+WBCwNXV7GyOOGnE9eE0FuaAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(40460700003)(356005)(70206006)(2616005)(70586007)(8676002)(7696005)(186003)(6666004)(316002)(6916009)(81166007)(82310400004)(426003)(26005)(1076003)(16526019)(54906003)(5660300002)(36756003)(8936002)(30864003)(36860700001)(47076005)(508600001)(86362001)(83380400001)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:10.8155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b1f3c1-66de-4aa9-fa41-08d9f0c95e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
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

For migration start and end event, output timestamp when migration
starts, ends, svm range address and size, GPU id of migration source and
destination and svm range attributes,

Migration trigger could be prefetch, CPU or GPU page fault and TTM
eviction.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 53 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 39 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 ++++---
 5 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index caf37904a466..96265cbacd84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -403,8 +404,9 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end)
+			uint64_t end, uint32_t trigger)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -432,6 +434,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				0, adev->kfd.dev->id, prange->prefetch_loc,
+				prange->preferred_loc, trigger);
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
@@ -460,6 +467,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
+	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				0, adev->kfd.dev->id, trigger);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
@@ -481,6 +492,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: the process mm structure
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -489,7 +501,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			struct mm_struct *mm)
+			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
@@ -526,7 +538,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -642,8 +654,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
+		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
+		       uint32_t trigger)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
@@ -672,6 +686,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				adev->kfd.dev->id, 0, prange->prefetch_loc,
+				prange->preferred_loc, trigger);
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
@@ -702,6 +721,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
+
+	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				adev->kfd.dev->id, 0, trigger);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
 out_free:
@@ -721,13 +745,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -765,7 +791,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -788,6 +814,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -796,7 +823,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm)
+			 struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -808,7 +835,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, trigger);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -816,17 +843,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
 
@@ -895,7 +922,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		goto out_unlock_prange;
 	}
 
-	r = svm_migrate_vram_to_ram(prange, mm);
+	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
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
index c5ed0f2dad45..6d2f56a4773e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -303,6 +303,45 @@ void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 			   len);
 }
 
+void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+				   unsigned long start, unsigned long end,
+				   uint32_t from, uint32_t to,
+				   uint32_t prefetch_loc, uint32_t preferred_loc,
+				   uint32_t trigger)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in),
+		       "%x %lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
+		       KFD_SMI_EVENT_MIGRATE_START, ktime_get_boottime_ns(),
+		       pid, start, end - start, from, to, prefetch_loc,
+		       preferred_loc, trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATE_START, fifo_in, len);
+}
+
+void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+				 unsigned long start, unsigned long end,
+				 uint32_t from, uint32_t to, uint32_t trigger)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in),
+		       "%x %lld -%d @%lx(%lx) %x->%x %d\n",
+		       KFD_SMI_EVENT_MIGRATE_END, ktime_get_boottime_ns(),
+		       pid, start, end - start, from, to, trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATE_END, fifo_in, len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 7903718cd9eb..ec5d74a2fef4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -34,4 +34,12 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
 				    ktime_t ts);
 void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 				  unsigned long address, bool migration);
+void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger);
+void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to, uint32_t trigger);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c6ea52340abc..35b2a0f63521 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2792,7 +2792,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (prange->actual_loc != best_loc) {
 		migration = true;
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm);
+			r = svm_migrate_to_vram(prange, best_loc, mm,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
@@ -2800,12 +2801,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 				 * VRAM failed
 				 */
 				if (prange->actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm);
+					r = svm_migrate_vram_to_ram(prange, mm,
+					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 				else
 					r = 0;
 			}
 		} else {
-			r = svm_migrate_vram_to_ram(prange, mm);
+			r = svm_migrate_vram_to_ram(prange, mm,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 		}
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
@@ -3128,12 +3131,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 		return 0;
 
 	if (!best_loc) {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 		*migrated = !r;
 		return r;
 	}
 
-	r = svm_migrate_to_vram(prange, best_loc, mm);
+	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3190,7 +3193,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 		do {
 			svm_migrate_vram_to_ram(prange,
-						svm_bo->eviction_fence->mm);
+						svm_bo->eviction_fence->mm,
+						KFD_MIGRATE_TRIGGER_TTM_EVICTION);
 		} while (prange->actual_loc && --retries);
 		WARN(prange->actual_loc, "Migration failed during eviction");
 
-- 
2.17.1

