Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F63EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 14:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2758110E3A2;
	Mon, 14 Mar 2022 14:50:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D6110E3A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 14:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BexdTtZ+zzjXqJOz/MunDw9DxfP7jp8xChE1FnQF5CFEjblDLQlThWFMStdYV3ygDcwrPOzcVoDh5bc0QGStLZTAFEBbLOyphml3B8qZv0Yg6Hfl5lzZOWhak/VYuk9tBPuKrWRlRC5ZFzwFWlT55XcebD8ehvu8NPE5ID87peLlkx4qKvw7hX/cUFeL+TXF/jceXg7BGPKGbh7z1KoA47WRZcu6rD/iGGDWCzkWEC9hfmRzespHzGqtfIUIh4XtAC/Hg8x/TvsKNmn1+nKCUmBZrelVOnZkz2M/WSV3Md5pRXTAkP4EygFKNShBFQStb7gNgisNI5Ox91+LzeWc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn1XfiSr72+kqWSk9fDGvuOD/Y8BjFgyg98QSWOvT90=;
 b=Fz3Ir3OfsrcB2nAUiaZ5pUFXSLZTeEqiO7+D6h3UT/BOWgzt6Cd1wThostH5qXOA+xdM9k6CRWi4siymJGmLzYmRajvhDiv6WOgGPb6nAW9ZDRwzE++3SlY9v/zNmKQegomhTxdfhmP25dZJJL6i0wLtVZTtji+jKXKF1ETPtTsG/c+4i+hDisLgIcWu2CrD24joKQRXE2kT8HjLhYPZKmihqAcxvw6mZkoYZzxYuNMtOVtytS2EScgZCJrdfcEP+FOX6ou2ko8YX+IKUGVlGM4k1RFliiV4TfhvoOUQpKYpKzKZMtSDtiLsWYSZZn9jZQUHuReHOEGvoB2YK6zhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn1XfiSr72+kqWSk9fDGvuOD/Y8BjFgyg98QSWOvT90=;
 b=Qhixg7yZnJ3u+Rl70xxTj0vwYBFAp83f1I7vPRlnm47YzCfc3oQuqPyEkUNFaYFOgjX+9BUd7obhYl7dkmv4PYWgT3SYUXGzp3Ee3uoLpZkLt2HNzxBfWfhxd0kJHIfbgK/5z7zYqanFs51nD9OsQLBCw1vz4N1gBtXtYvQD0TU=
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 14:50:47 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::53) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Mon, 14 Mar 2022 14:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 14:50:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 09:50:46 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: evict svm bo worker handle error
Date: Mon, 14 Mar 2022 10:50:20 -0400
Message-ID: <20220314145020.9142-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 157ca864-9712-48ef-0c55-08da05ca066c
X-MS-TrafficTypeDiagnostic: MW5PR12MB5682:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5682465296DFB95403101D9BE60F9@MW5PR12MB5682.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xXXpqvLB05spQIJzRTjMx+7mZQfA1TDnw+JRnT9lXjGU8NqrOwwcGtL08fQmotST4ONxK97uauXohzBDO2oxBx6+8DQPQ+EtqcKDETmTdfdjVd8+P3Wpoze8kAQ0qr1KyLdQezQUoywOH/WYpgT8JjMjIvkEOVXVMW9wGYn+sfp9QoR0r5EYkSnQ2b2yKhtRJwXwSWNEA1c5ILrpKmcgoTyeE588rSISgCnFKsuXYqNZcd8ROsP5XXsOK9QRrgvWiU5sFKA+PEYVrLxjeWL4PSdT1SOECR5jtsy6pG8TUBQZ9o+fJAwQvQU4s0D6/0CT1iwWvwCfyHg2Hfy8t5XXe9rO5C6uIY+XAoQQh7X3Pbu5F6TVl5YyE4EOr8zdjaMEMcAPQ+XPurmUxNSijf6978w83Zhi/0RIPIxGxHkVpH+5tw25khtWmY70HnG56uMyrPceQakscdRzNN6BE/yblk/J3ww+lJWfqI2eWaOuxs4kFmYiQUDjrvLfEEMD+H1wds+XBviYhi7QkFNnq7k8PM3hQxKGv3UXN5sksUOhGU9CO42J1F1g4cpYIIC5XgMnsFPaJrZaqNN8XshFV1dDZ4l2ZvUjU6p2+lsW+clrdJZTAIBpGBMoIXHB/e28UrAozIEKUqbRwks3ZhJz7k4dDF+vhbpVUWamjqXZ0ZM5iTBRxSkeq4GikD4XQsNSKQM9VvrvaTwdATCUOW7h0nRnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(83380400001)(16526019)(47076005)(2616005)(1076003)(426003)(186003)(356005)(26005)(336012)(81166007)(82310400004)(40460700003)(36860700001)(6916009)(2906002)(4326008)(70586007)(70206006)(54906003)(316002)(8676002)(36756003)(8936002)(5660300002)(508600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 14:50:47.4685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ca864-9712-48ef-0c55-08da05ca066c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Migrate vram to ram may fail to find the vma if process is exiting
and vma is removed, evict svm bo worker sets prange->svm_bo to NULL
and warn svm_bo ref count != 1 only if migrating vram to ram
successfully.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 27 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++--------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7f689094be5a..c8aef2fe459b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -638,6 +638,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
+/**
+ * svm_migrate_vma_to_ram - migrate range inside one vma from device to system
+ *
+ * @adev: amdgpu device to migrate from
+ * @prange: svm range structure
+ * @vma: vm_area_struct that range [start, end] belongs to
+ * @start: range start virtual address in pages
+ * @end: range end virtual address in pages
+ *
+ * Context: Process context, caller hold mmap read lock, svms lock, prange lock
+ *
+ * Return:
+ *   0 - success with all pages migrated
+ *   negative values - indicate error
+ *   positive values - partial migration, number of pages not migrated
+ */
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
@@ -709,8 +725,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
-
-		return upages;
 	}
 	return r ? r : upages;
 }
@@ -759,13 +773,16 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 		unsigned long next;
 
 		vma = find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start)
+		if (!vma || addr < vma->vm_start) {
+			pr_debug("failed to find vma for prange %p\n", prange);
+			r = -EFAULT;
 			break;
+		}
 
 		next = min(vma->vm_end, end);
 		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
 		if (r < 0) {
-			pr_debug("failed %ld to migrate\n", r);
+			pr_debug("failed %ld to migrate prange %p\n", r, prange);
 			break;
 		} else {
 			upages += r;
@@ -773,7 +790,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 		addr = next;
 	}
 
-	if (!upages) {
+	if (r >= 0 && !upages) {
 		svm_range_vram_node_free(prange);
 		prange->actual_loc = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 509d915cbe69..215943424c06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3155,6 +3155,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	struct svm_range_bo *svm_bo;
 	struct kfd_process *p;
 	struct mm_struct *mm;
+	int r = 0;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
 	if (!svm_bo_ref_unless_zero(svm_bo))
@@ -3170,7 +3171,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 	mmap_read_lock(mm);
 	spin_lock(&svm_bo->list_lock);
-	while (!list_empty(&svm_bo->range_list)) {
+	while (!list_empty(&svm_bo->range_list) && !r) {
 		struct svm_range *prange =
 				list_first_entry(&svm_bo->range_list,
 						struct svm_range, svm_bo_list);
@@ -3184,15 +3185,15 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&prange->migrate_mutex);
 		do {
-			svm_migrate_vram_to_ram(prange,
+			r = svm_migrate_vram_to_ram(prange,
 						svm_bo->eviction_fence->mm);
-		} while (prange->actual_loc && --retries);
-		WARN(prange->actual_loc, "Migration failed during eviction");
-
-		mutex_lock(&prange->lock);
-		prange->svm_bo = NULL;
-		mutex_unlock(&prange->lock);
+		} while (!r && prange->actual_loc && --retries);
 
+		if (!prange->actual_loc) {
+			mutex_lock(&prange->lock);
+			prange->svm_bo = NULL;
+			mutex_unlock(&prange->lock);
+		}
 		mutex_unlock(&prange->migrate_mutex);
 
 		spin_lock(&svm_bo->list_lock);
@@ -3201,10 +3202,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	mmap_read_unlock(mm);
 
 	dma_fence_signal(&svm_bo->eviction_fence->base);
+
 	/* This is the last reference to svm_bo, after svm_range_vram_node_free
 	 * has been called in svm_migrate_vram_to_ram
 	 */
-	WARN_ONCE(kref_read(&svm_bo->kref) != 1, "This was not the last reference\n");
+	WARN_ONCE(!r && kref_read(&svm_bo->kref) != 1, "This was not the last reference\n");
 	svm_range_bo_unref(svm_bo);
 }
 
-- 
2.35.1

