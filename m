Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5796C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AA261213
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9AA261213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EAE6E1B1;
	Wed, 17 Nov 2021 03:43:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3226E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 03:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvabdzRlDjUdcBL2Jln6Ro2jujms37ErozgXyb/phx4fFNtTEHQYH4mZ/ZGbo/Hbjz+IlxfZXwGcsQcOLBhj3sWj901+/EjwqgD5BRF2HG3V0f6HqeyT9ILct/pPwZHT3HFZWRMRN89stW2kZHLQF0fPXNb3aZrgkwDHcmBJYKDlDHmlpdtSP/bjeg3FrLyhXMq4U8LO4ZNmjfXVfyY0pBjzvTtiSG8xgMhDbXM/j6rVOvVSMcZsBZXGhurK7mVYFfi4x9Ttgv4YE9YePnh9RIzPv3kdbVi/lv8zceUMoER/8/TqNL3CI4WUfVpqmNmuBSz2swH/E5sh+0vzvLOQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJxIj82qPNtRkg1N58NNudbRZAK1xDg0gNZ7ji2TCuw=;
 b=eq98SXPiUHPfC0/yq1A428xh7C2njZ1lYkPSzPz8Ivf3Tv9EQOVBwpv9vpNwYU1dF0x5JFlySnVjKG+CWr8ma6rkGOJ91ejG2j1euvt3uj2mVbu40rSvBIYGo5Nmkm03wPJdUt48Vh0eenADq9xz2DP+/aUpNZckVDCzGRnPdlN17mesvGIjfV4Xf5IbvXqzLNFUTm7usyVvB3zhLpUHbF+nOtv4zJsRIRpjVy+ISV47n4oBfC5WXhnSVuRQ6OvQVJlXl+OLhpQygCpqJRDhDt9pa3NjGnw6oWxdzlnoMC1Kxwmi2ncOSPz+KaJYAA1Umhi35LYJiqBSw0YWBsz3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJxIj82qPNtRkg1N58NNudbRZAK1xDg0gNZ7ji2TCuw=;
 b=Tb1qHFWtF6cvTe9/LqOm8kPfEasm/8uRXbsgesmGFhe2XllBBZQH39zSG+5u09jWmgzt0jVGJlsEzoruEd4Gd9xSlrqEnPDqKDSlkxcX+OYqdPU/d4mfyvXJrM55sOq8WXvsH4WLJceSjDrrAZ55EZ1BTxFXcuPzc6PLWLPmda4=
Received: from BN6PR13CA0049.namprd13.prod.outlook.com (2603:10b6:404:11::11)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Wed, 17 Nov
 2021 03:43:43 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::6f) by BN6PR13CA0049.outlook.office365.com
 (2603:10b6:404:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend
 Transport; Wed, 17 Nov 2021 03:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 03:43:43 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 21:43:42 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: handle VMA remove race
Date: Tue, 16 Nov 2021 22:43:23 -0500
Message-ID: <20211117034324.4663-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117034324.4663-1-Philip.Yang@amd.com>
References: <20211117034324.4663-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 924f2383-1db6-465c-b4db-08d9a97c73aa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155F2B15BA35C6DE7263354E69A9@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrzqoAC5N/axqMAey9DCGTCSJ+VYYae5e8qNkuLmWuch3zHbt7pt6dlebYZZnW1wpx/qGSQB9kAxgYGG4zWINfitU3K2ib1+AReG/DVm/opjgzpgCxsah9AsRgrCXWXFKnTh5lGKdD1Nyqzbn4LrENEz0PF6BOpy04NaOVLPzUuTXNjJ7/63r306tTd+8uqQ4/xFdhMsu3kuoNM7p8cyUfJofdrBbxlEtQ46bc8VKjARvq6K+j6i7iI5+OO/n8svZT+U1jd7T/XZ4wTvYtC/fKtbQjwIO3GFwH01Kbi6Aky5Pwh6WEosga1uUT2Wf63SquzKuWb3aHTwGdSROvHu3khT+ZZExh6oPrystiAbKHVFMvJ73CiuDStn4FoMc3mJGtzefeYVL8NH3vwf9AGIyF75f8ei9aeGVW0BUWCzFBqKOwBhXEm1KHYDey4ZlU7vPQBq4K6xnLAHlliroURkz0VARyed1fMBXYIEM8Nv9qy36wnnurc7fH0PP+RmHtBDoFj323TmB84VRovavQ/9tfweUcQqgvhLodro0zodwYna76OgtSTDi00t9eGinBNnuKVhoDQxIpqQ/uQLGmLlsiyKtMWFC+sO9BIWvleAd+Tw9TbH5NNBV/YPERo+ABnmhDLcbNAlZIcOoP1ArOdq1BGwP+qVHq55pVuvg7SNzqXy1jcZLJgbkIaB19XbjHwGM0twXruV8b7ZUKtsNdVyi/mWhBzCHSsVcRq9QoUh9Fc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(70586007)(356005)(186003)(1076003)(5660300002)(8676002)(8936002)(83380400001)(86362001)(82310400003)(36756003)(6916009)(4326008)(6666004)(36860700001)(2616005)(81166007)(26005)(508600001)(16526019)(316002)(54906003)(47076005)(426003)(336012)(70206006)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:43:43.0802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924f2383-1db6-465c-b4db-08d9a97c73aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

VMA may be removed before unmap notifier callback, restore pages take
mmap write lock to lookup VMA to avoid race, and then create unregister
new range and check VMA access permission, then downgrade to take mmap
read lock to recover fault. Refactor code to avoid duplicate VMA lookup.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 65 ++++++++++------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c1f367934428..3eb0a9491755 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2329,20 +2329,13 @@ svm_range_best_restore_location(struct svm_range *prange,
 }
 
 static int
-svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
-			       unsigned long *start, unsigned long *last,
-			       bool *is_heap_stack)
+svm_range_get_range_boundaries(struct kfd_process *p, struct vm_area_struct *vma,
+			       int64_t addr, unsigned long *start,
+			       unsigned long *last, bool *is_heap_stack)
 {
-	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
 	unsigned long start_limit, end_limit;
 
-	vma = find_vma(p->mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
-		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
-		return -EFAULT;
-	}
-
 	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
 			  vma->vm_end >= vma->vm_mm->start_brk) ||
 			 (vma->vm_start <= vma->vm_mm->start_stack &&
@@ -2437,9 +2430,10 @@ svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
 
 static struct
 svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
-						struct kfd_process *p,
-						struct mm_struct *mm,
-						int64_t addr)
+					       struct kfd_process *p,
+					       struct mm_struct *mm,
+					       struct vm_area_struct *vma,
+					       int64_t addr)
 {
 	struct svm_range *prange = NULL;
 	unsigned long start, last;
@@ -2449,7 +2443,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	uint64_t bo_l = 0;
 	int r;
 
-	if (svm_range_get_range_boundaries(p, addr, &start, &last,
+	if (svm_range_get_range_boundaries(p, vma, addr, &start, &last,
 					   &is_heap_stack))
 		return NULL;
 
@@ -2552,20 +2546,13 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 }
 
 static bool
-svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
+svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 {
 	unsigned long requested = VM_READ;
-	struct vm_area_struct *vma;
 
 	if (write_fault)
 		requested |= VM_WRITE;
 
-	vma = find_vma(mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
-		pr_debug("address 0x%llx VMA is removed\n", addr);
-		return true;
-	}
-
 	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
 		vma->vm_flags);
 	return (vma->vm_flags & requested) == requested;
@@ -2582,7 +2569,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	uint64_t timestamp;
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
-	bool write_locked = false;
+	struct vm_area_struct *vma = NULL;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
@@ -2606,26 +2593,22 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	/* mm is available because kfd_process_notifier_release drain fault */
 	mm = p->mm;
+	mmap_write_lock(mm);
+
+	vma = find_vma(p->mm, addr << PAGE_SHIFT);
+	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+		pr_debug("VMA not found for address 0x%llx\n", addr);
+		mmap_write_downgrade(mm);
+		r = -EFAULT;
+		goto out_unlock_mm;
+	}
 
-	mmap_read_lock(mm);
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
-		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		prange = svm_range_create_unregistered_range(adev, p, mm, vma, addr);
 		if (!prange) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
@@ -2634,8 +2617,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			goto out_unlock_svms;
 		}
 	}
-	if (write_locked)
-		mmap_write_downgrade(mm);
+
+	mmap_write_downgrade(mm);
 
 	mutex_lock(&prange->migrate_mutex);
 
@@ -2652,7 +2635,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	if (!svm_fault_allowed(mm, addr, write_fault)) {
+	if (!svm_fault_allowed(vma, write_fault)) {
 		pr_debug("fault addr 0x%llx no %s permission\n", addr,
 			write_fault ? "write" : "read");
 		r = -EPERM;
@@ -2704,10 +2687,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&prange->migrate_mutex);
 out_unlock_svms:
 	mutex_unlock(&svms->lock);
+out_unlock_mm:
 	mmap_read_unlock(mm);
 
 	svm_range_count_fault(adev, p, gpuidx);
-
 out:
 	kfd_unref_process(p);
 
-- 
2.17.1

