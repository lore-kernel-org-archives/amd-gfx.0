Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEF7C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5677C10E878;
	Thu, 20 Jan 2022 23:13:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A5C10E810
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwvHpq9NBKopPigtFUHc3XMDYQ4rxsqwE9Rh0ddKspag6mrl6MyHJC+Z8cRg/gjUxyCuNc4tNbjkk4FTbl5IxAQjsaZ/Jtb4vZEbKPHYVF2ntzUPUu8S0zcUkOam6EuV3a44DQR+3rAmEZI6/8unWaP1Lqy3tuWE+ngy97AxheZGK9Sp6Sc9kKfLVu2+aqmvcYjB27++42RSOmXHrfkzK4iooDjf/FOHDzoOuADXhhLWKfs8LWWkXEnrsmoCyFN0BMnF4YFtXCkhfoyLhANJQ18++RdDAfJjpct3zJ8/8gRNcWAwyn0x5sLAx8gjDa82g6JDoP926RuiHL4eV2HYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uqR4g48TrPbZLiNIz6xqS3vvOzpA4VokLa8pTgXvwg=;
 b=giSIDUhx95JKwkFEjCUAhdQ/9ZtYVGCwvmP4nAcLrDLeCANxIJv+DUkVloRwjBJhkebEK2kZo3+bjev3tJK/zm9YOI3fozXLVThZUg8T7wpF+G/YVF8VkcGFJIbURf8KJ9/OwsMz3lych66do2nWmNYMP5WGXQ05Ryr4b0gH/rp7UMO9ijC1E/7L9Rkkpbug+CsFnv8KfuKL2FbK6wLXcOv2us2pVtXE+oJWZFFMUreCdBkgWmeGnT1yMxMQ/2ZL/eCRgt6RM4x8dODaPrVZB9U6TKfwodJ6TPp+MaL216Nx+klMy6oHZfJR5c9WUu6aIDGlnruw76ZzaXvvvN2fgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uqR4g48TrPbZLiNIz6xqS3vvOzpA4VokLa8pTgXvwg=;
 b=AtIYou4q4JCNN4FxGPSie/zGrBMdAeDG7Kf+NeHICPl3fK7+zB9LZ75F0UzWjp3NuqTylziJU8EHTrBFPQY6x4zycQgI12qnturbRp5nlJ+zbQC0KsCdzPFs8rDK8xkSWvqqn1luMyn9ec/AstwFx4iqp+hE4/3By6SQQDvmNPs=
Received: from MWHPR19CA0095.namprd19.prod.outlook.com (2603:10b6:320:1f::33)
 by BN6PR12MB1412.namprd12.prod.outlook.com (2603:10b6:404:1b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 23:13:40 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::59) by MWHPR19CA0095.outlook.office365.com
 (2603:10b6:320:1f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/8] drm/amdkfd: add migration SMI event
Date: Thu, 20 Jan 2022 18:13:19 -0500
Message-ID: <20220120231322.10321-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f73e6dbd-7bfc-47ba-7b07-08d9dc6a7ed0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1412:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1412126C2B55669C53E3D324E65A9@BN6PR12MB1412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8EOLNQqRm4BJUpGW6edQVfiU4G4x3z7c5s3CbjYecLZPrKHCD1mOSBaehNaxsI+V1FrzUDLLdLIYJIO8G2Tis9+3CMv3Z7eT36NC1Yt7j63txirkGJyuJ6LG74wo1t/IgOsFCeArYUwRWVNVpVckupOP5zVef6/vwikcvGNES43ZR9kW2PTJ4gW9us0Yn4YE+yArYbnNoE/A0R6JvdA+fTPbWF4emoytJwLIRjmcqZ6siiG0tTlIcEhhlQFr2+o4tfXT2oyMYf4Rpk6ZYDMqyGDlXmP51UX5kcjfhsPKiEVqZVJb1N8361jsP4pYH9HubA+W2CPaUwYiZdETYXdYW+iZ/RXfgeD9MWr1mwjz5QDscc6r7s928+JU261AsJRck3ZeLwKc3YyU1G/E4BKJhitb6ytDs5FZQoUJg6vZ/Z2uQqRUFvJYha+ia4a+f/yytMxJOWGs3Be1kZUIhZdwYXiIN/efmMGpAnRZi4+oO1dTO/ExSYpInqYx02c8i7zdp9WuGu57iQKhyMIiCtnD1fRxmNuep170QLgU24huok6frw4PqQppBVjwqd7YUoRmFC8IOcbLJBi/GsP5Hoyn4Rta61KFu0i0Yun6IYAwZSGStT3M1h/sWhAp/0opfDjv+lHIF+iW73eG2WBxjfs9DAyqeV/pwk0eGarLZPbhAdce9bY7nY4z1mfPjllzTt3e6yqBewe3x4bCbYQZrDHhjtWCbN9gZCtS1RLeI4pqGFYSoyO0tTdaCPqSPtZtA0SAiLYeeXdpPwyqOWtnmilBAI6kqxZml8m4rAGsgLRVsc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(16526019)(6666004)(86362001)(186003)(30864003)(7696005)(54906003)(26005)(508600001)(8936002)(426003)(36756003)(336012)(5660300002)(316002)(47076005)(2906002)(6916009)(8676002)(2616005)(40460700001)(1076003)(356005)(36860700001)(82310400004)(81166007)(83380400001)(70586007)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:40.0309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e6dbd-7bfc-47ba-7b07-08d9dc6a7ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1412
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
migration source and destination and svm range attributes,

Migration trigger could be prefetch, CPU or GPU page fault and TTM
eviction.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 67 ++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 29 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 +++--
 5 files changed, 91 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 88db82b3d443..06fb888f87aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -402,10 +403,11 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end)
+			uint64_t end, uint32_t trigger)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	struct kfd_process_device *pdd;
+	struct kfd_process_device *pdd = NULL;
+	uint64_t timestamp = ktime_get_boottime_ns();
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	unsigned long cpages = 0;
@@ -431,6 +433,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	pdd = svm_range_get_pdd_by_adev(prange, adev);
+	if (!pdd)
+		goto out_free;
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
@@ -459,6 +465,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
+	kfd_smi_event_migration(adev->kfd.dev, pdd->process->pasid,
+				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				0, adev->kfd.dev->id, prange->prefetch_loc,
+				prange->preferred_loc, trigger, timestamp);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
@@ -466,10 +477,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -480,6 +488,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: the process mm structure
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -488,7 +497,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			struct mm_struct *mm)
+			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
@@ -525,7 +534,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -641,12 +650,14 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
+		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
+		       uint32_t trigger)
 {
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	uint64_t timestamp = ktime_get_boottime_ns();
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
-	struct kfd_process_device *pdd;
+	struct kfd_process_device *pdd = NULL;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
@@ -671,6 +682,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	pdd = svm_range_get_pdd_by_adev(prange, adev);
+	if (!pdd)
+		goto out_free;
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
@@ -701,16 +716,19 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
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
@@ -720,13 +738,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -764,7 +784,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -787,6 +807,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -795,7 +816,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm)
+			 struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -807,7 +828,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, trigger);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -815,17 +836,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
 
@@ -894,7 +915,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index 080eba0d3be0..97393f4f3549 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -314,6 +314,35 @@ void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 			   len);
 }
 
+void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger, uint64_t ts)
+{
+	struct amdgpu_task_info task_info = {0};
+	char fifo_in[128];
+	uint64_t duration;
+	pid_t pid;
+	int len;
+
+	if (!kfd_smi_event_duration(dev, ts, &duration))
+		return;
+
+	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
+	if (!task_info.pid)
+		return;
+	pid = task_info.pid;
+
+	len = snprintf(fifo_in, sizeof(fifo_in),
+		       "%x %lld(%lld) -%d @%lx(%lx) %x->%x %x:%x %d\n",
+		       KFD_SMI_EVENT_MIGRATION, ts, duration, pid, start,
+		       end - start, from, to, prefetch_loc, preferred_loc,
+		       trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATION, fifo_in, len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 7f70db914d2c..5788728f2879 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -34,4 +34,9 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
 void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 				  unsigned long address, bool migration,
 				  uint64_t ts);
+void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger, uint64_t ts);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 08b21f9759ea..7dbc724364e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2791,7 +2791,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (prange->actual_loc != best_loc) {
 		migration = true;
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm);
+			r = svm_migrate_to_vram(prange, best_loc, mm,
+						MIGRATION_TRIGGER_PAGEFAULT);
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
@@ -2799,12 +2800,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -3126,12 +3129,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
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
@@ -3188,7 +3191,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
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

