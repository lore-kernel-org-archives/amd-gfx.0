Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4F1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 22:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20E610E334;
	Mon,  8 Jan 2024 22:38:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0131010E334
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 22:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqP1UbPF/LoIQit/TQvjWKpX4QKP01uqgGOd3CE2OJcIKmhWuSYaPkKtrBQTNNnd27a8Sun7TYqhlTCu0LsvfEsEsnzwc8DF+0+egvw0f+4Cb6akBAxhDocHZLARXHSyjH6S6z95q9dTeDdchBOOTv0Y6XqSeod6G0MnH2Z4bFRmCaXF6Uw56bW4dvZpb6QVz3SudoZjnJQSzaF84vSgd65oS9pCYOUGEbryoI6SSp75KzyROdrY4kNX2cXM0DsFz1gh5zpIFSfqKajkpJPRvtnrGJcG0OReDirVMMT9Di9xbHGUn8APzA7a631Ed3w1A80i8wwZ+b/kjL1E15QXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4GoKNR2DfZPCtGuAzchxN5FKGE8McZBjfjGv6pqhoY=;
 b=REdKskEjnoANE1w8zxcHk7rIBQ5sROxJk10XVoi+wfVWkwM14aT/Fk+EmtW0GCUd77/WGWTqTICSr3J5/Kmw1JinV/MEGFzRWSg8UKv6d9tXUdAgAFDcjFmmsfn6eN7qiJcIHjrkXWXFgXxiIwd5wbJsZEAYwh1rG/5Ra/s7KE4lSq+CanixKTsjVc+KVQW+M3QteFTFCaZ1qkeCBWoRuTIrCjkkdlFl8X21JKd8O6vBtzUJdHcf9eUnjFPx7jY0U95ehibCSjUxN7X341DdldMn+7Bnvxfsz1tzYyIkCcgOpKgUMhZh3LsFM7F1/0FIwXj9U+M+q8R/H+FmSAdv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4GoKNR2DfZPCtGuAzchxN5FKGE8McZBjfjGv6pqhoY=;
 b=Fj6TSCxZNVJsVmmmOpzeJxbPuMgkR+Fupld8uXQPJpIsWDAJVkG+kjdaIB4l6RuYWre+d6nSSD78AMc4LiX2t2sgDrMcVvQQT3Y8DuZa4fK3z8odl84KTb3wUGVnBasX0bJnb27Z9owUY6UW3GE404xDmM39em6Zudcz9WbOZuU=
Received: from MN2PR10CA0036.namprd10.prod.outlook.com (2603:10b6:208:120::49)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 22:38:08 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::e1) by MN2PR10CA0036.outlook.office365.com
 (2603:10b6:208:120::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 22:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 22:38:07 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 16:38:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdkfd: Refine locking in restore pages worker
Date: Mon, 8 Jan 2024 17:37:48 -0500
Message-ID: <20240108223748.15777-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 4595796e-99c4-4993-2cf1-08dc109a7c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQhKVPZJ6vh0ZaCutaN06tAZ4xkGJGJMpwK567d//LRNHDuNiCqeIenMuB5tpsbgufHVQqkcAGd8IIrE+85HVYOWe5fSN2RggnH75Ea8RrZcLYxo7zPlVxjCHs2sIV8IZddMeUsOuao6M5qw9i5++NnYSrb6xT9A9RNOLrLYZ1fvWWO4T/LDHwFq8FU3fn6vvr8D33SKQ+VPRfVUAVM9vXFlvzvpbRaU87rVUfITh6AohQBxvYQdONCr/cK7lj3pSwJfqy840QLYjplD6zWFCaf6NAfOZ/ObsGsV9Ww6RLg7ZlBifeQw80UWOTFnAnSHedIUvo2ojo2iMOlOZJM7clAEdcJCk6Sg6E+Z2wRyz6QJvEUTgEdUp3rRYw2KKdg0850Pk+HRzzOQcqXe0k9/6aSBMjbydkVSnAR47NFrH8mMm2HDZ4ibZg28qlVzu8K20IP3GpyI+V5GHCs/C7tBZNE7qJn4kxw1LHFrmRpgngzFkAJW0+kWYHWmiq09cyVM0yPZQyPlpUmPrR3QU5puMS7p+uroqi2KT1XF798M5ycVa5Ypqkz5sMrVm+zy/Kbo4L8tT5naddOfGizeOrHQiMfAGJ1kWkLxvgvOsQHM3WRN9b/iRhiq7mz0TRyNTs2uIN9Zs4TAVHnDXtM1so+H1JsBIs7JoXjAMHKZ3ZWNUAIv45Yx0/oQ3xIgvNI55FrPcGz5gsItZisZlcIMbqMUU+dPNmY+gyw6pjb/aEZV++uuWl+pJVh9yasGGnL7IUtFxrPcjBqeXvZ5O7TpNYq6Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(1076003)(426003)(26005)(336012)(7696005)(478600001)(2616005)(6666004)(82740400003)(36860700001)(41300700001)(86362001)(36756003)(81166007)(356005)(2906002)(47076005)(83380400001)(16526019)(6916009)(5660300002)(8936002)(4326008)(70206006)(70586007)(316002)(8676002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:38:07.4822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4595796e-99c4-4993-2cf1-08dc109a7c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To be able to handle multiple GPU page faults concurrently

1. remove mmap write lock, take and release mmap read lock when checking
vma, migrating and calling hmm_range_fault.

2. insert new range mmu interval notifier without taking mmap lock.

3. take and release svms lock when checking and inserting new range to
svms.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 70 ++++++++++++++--------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3b78e48832e9..cc24f30f88fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -117,6 +117,18 @@ svm_range_add_notifier_locked(struct mm_struct *mm, struct svm_range *prange)
 				     &svm_range_mn_ops);
 }
 
+static void
+svm_range_add_notifier(struct mm_struct *mm, struct svm_range *prange)
+{
+	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
+		 prange, prange->start, prange->last);
+
+	mmu_interval_notifier_insert(&prange->notifier, mm,
+				     prange->start << PAGE_SHIFT,
+				     prange->npages << PAGE_SHIFT,
+				     &svm_range_mn_ops);
+}
+
 /**
  * svm_range_add_to_svms - add svm range to svms
  * @prange: svm range structure to be added
@@ -2801,9 +2813,6 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
 	if (is_heap_stack)
 		prange->preferred_loc = KFD_IOCTL_SVM_LOCATION_SYSMEM;
 
-	svm_range_add_to_svms(prange);
-	svm_range_add_notifier_locked(mm, prange);
-
 	return prange;
 }
 
@@ -2899,9 +2908,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_node *node;
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
-	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
+	bool new_prange = false;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev)) {
@@ -2947,42 +2956,30 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		r = -EFAULT;
 		goto out;
 	}
+
 	mmap_read_lock(mm);
-retry_write_locked:
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
 			 svms, addr);
-		if (!write_locked) {
-			/* Need the write lock to create new range with MMU notifier.
-			 * Also flush pending deferred work to make sure the interval
-			 * tree is up to date before we add a new range
-			 */
-			mutex_unlock(&svms->lock);
-			mmap_read_unlock(mm);
-			mmap_write_lock(mm);
-			write_locked = true;
-			goto retry_write_locked;
-		}
 		prange = svm_range_create_unregistered_range(node, p, mm, addr);
 		if (!prange) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
-			mmap_write_downgrade(mm);
 			r = -EFAULT;
-			goto out_unlock_svms;
+			mutex_unlock(&svms->lock);
+			goto out_unlock_mm;
 		}
+		svm_range_add_to_svms(prange);
+		new_prange = true;
 	}
-	if (write_locked)
-		mmap_write_downgrade(mm);
-
-	mutex_lock(&prange->migrate_mutex);
+	mutex_unlock(&svms->lock);
 
 	if (svm_range_skip_recover(prange)) {
 		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
 		r = 0;
-		goto out_unlock_range;
+		goto out_unlock_mm;
 	}
 
 	/* skip duplicate vm fault on different pages of same range */
@@ -2991,7 +2988,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
 			 svms, prange->start, prange->last);
 		r = 0;
-		goto out_unlock_range;
+		goto out_unlock_mm;
 	}
 
 	/* __do_munmap removed VMA, return success as we are handling stale
@@ -3001,14 +2998,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (!vma) {
 		pr_debug("address 0x%llx VMA is removed\n", addr);
 		r = 0;
-		goto out_unlock_range;
+		goto out_unlock_mm;
 	}
 
 	if (!svm_fault_allowed(vma, write_fault)) {
 		pr_debug("fault addr 0x%llx no %s permission\n", addr,
 			write_fault ? "write" : "read");
 		r = -EPERM;
-		goto out_unlock_range;
+		goto out_unlock_mm;
 	}
 
 	best_loc = svm_range_best_restore_location(prange, node, &gpuidx);
@@ -3016,9 +3013,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
 			 svms, prange->start, prange->last);
 		r = -EACCES;
-		goto out_unlock_range;
+		goto out_unlock_mm;
 	}
 
+	mutex_lock(&prange->migrate_mutex);
+
 	pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
@@ -3055,9 +3054,17 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
 				 r, svms, start, last);
-			goto out_unlock_range;
+			mutex_unlock(&prange->migrate_mutex);
+			goto out_unlock_mm;
 		}
 	}
+	mutex_unlock(&prange->migrate_mutex);
+	mmap_read_unlock(mm);
+
+	if (new_prange)
+		svm_range_add_notifier(mm, prange);
+
+	mmap_read_lock(mm);
 
 	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
 				       false, false);
@@ -3068,14 +3075,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
 				     migration);
 
-out_unlock_range:
-	mutex_unlock(&prange->migrate_mutex);
-out_unlock_svms:
-	mutex_unlock(&svms->lock);
+out_unlock_mm:
 	mmap_read_unlock(mm);
-
 	svm_range_count_fault(node, p, gpuidx);
-
 	mmput(mm);
 out:
 	kfd_unref_process(p);
-- 
2.35.1

