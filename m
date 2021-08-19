Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6856C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6A6610FE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E6A6610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EA26E8E6;
	Thu, 19 Aug 2021 14:57:17 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFF26E8E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 14:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmH3NRJQ5TGVxMHTJv2XR3ybJ7i31tXsebYJ+w3CczGMbBDuOI217N7pcJxvr1CC7emgnNzNi9q+4CxFwIAh/1AD9D3rwxBIA2q+mXj/L2x3fYq/l59cL0oOeGExT6AQXjnVQECNiWl1Vwbh6a15a2sbnNZr9TJE4e84BJOTYG7Z8wn4oC0V+NAq0wm6Nd/aSteSzbWHWmHIUzTWt8jh6Etp1iPm0feqjmkq/zyBa19/ZbQGLP13XwhzM7UWgz3NDtsqkb/ZjryzKax03XxIr4kjrPozuPx3rl54FtK5rbM5PjfRk5W5WXmapSd6PsKpeBe+/yTGQkJwqbBBJ0sGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywbCAdS9ZAEjGtRXezTqbK6CQlEA8063yFNedBFnmwo=;
 b=fmTEq+g7T9W/pBQ/cG8CSuuhIk4BBdCi8QeYAYT0w/I4MhOQXnPwHxm/qyVLW5i3nd40l/mRPVeKaFAaf3SBswPlQQx0ARhyW7NT+Pr1i7BukgdCPLML8RBGyOpRM9C8RszlvgdoOhSjwkPXT/KZ2BEM+vgaK08yiwXbl1zfa9eC4WMX1tXxRDrQTZbLMpQOWoj9nkwANB5E8wzNMbPlMYGBLWihIeN5gT5qIj0N5HIEapDVqrDioQL0/gSajKtk/+SuYJW/u4qEz7AmewEC6IYQTNig+1i9vF3E1BR8r2/46G9mY4sySm+R7q1AitLuJ1mlQ8LYbe6lw/MxyizPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywbCAdS9ZAEjGtRXezTqbK6CQlEA8063yFNedBFnmwo=;
 b=ThKvlaO6fyfRcaXRUzElQL7v1ZRKyMuuyCNxkVAON2EADpIikk2318ZbA0xE0HVVQWYsLXx4QMLOon/H42HHEk2csPDakkaS2NAjZtAyC6lN5lrS1rd1PrnQacU+i4jjGa5FzD8Oeriiv9TrdgIT60R/MMin7/v5n4X8IbNXdAg=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 19 Aug 2021 14:57:14 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::4a) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 14:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 14:57:14 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 09:57:13 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: check access permisson to restore retry fault
Date: Thu, 19 Aug 2021 10:56:57 -0400
Message-ID: <20210819145658.2254-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc5fd85-e7c4-42c6-dfe1-08d96321a1a3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3912:
X-Microsoft-Antispam-PRVS: <CH2PR12MB391269EC96F9C215D8874C0CE6C09@CH2PR12MB3912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7xCdUw9h9fW5zjY5/L1M0zWL6Dq0P3LYg9h1FIirZMovct0E0j7yXFI+zdo7Gf/NoXrGrOFxVDc6X7ryyCcbKpYa8KpGti/07eBISymvbtwdDUAvegvgKqCjyG6EB9+c6vCx4ignpFNultlMyE365IKNsTymHz1JqK+LY41JO9zstTjBpL3EpW2+gDQNv/ISPyrc1Hthy5jVPzJsJobcI+DSEpOQRYu+/Bx4i/MgwJrGmYAuk5oFFJM7XrKA3PqcgWvMk32bKS3COWe3M68kb7+p2GrZxsyPB1Kh7PDGNGgFACCEks/xTI90cTM+/T1WVPTcTS+FYuz9RtBK2/YLbmvgez7kX7qgh5LQxxWi/FvQBKvIUrQU/d3aGt21NyfpFNaCUrrE2De1C26X0QKeco8lmS71oeGOKsgkgKNjViwK+Yebct2RzOXisz1NHE95pIi5mfiL6JIhhcS0oqdYKqjQdzRfDygW7Dg++6E2UjN1xbbx4xHeG3XYKGBOWKbF+Qh1myiVh1tmUcSqsfqo/wjrf0neDwKV187PmCzws+ryLuBohnuvZ9HOtT411M5Oga+LRZnlIT91zNVQu9NXPAz9NljUD4M45dd0GXSOWU9fCOgLkFHoJOH9kjli/7Hv3TpZ2uBVtgIesFofZ9GsT1CsnGTcFQ1BOEVqxTCf61+qqAV14MlYeUDnZL0gt1/COSuAeNzznZxv+O3FaxfOS7fMD4rWAAWZXzppPB9llVUCZUSW5fQglQ0Td6hE4deLjKbn3rmrK6NGNiBUiErdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(83380400001)(36860700001)(36756003)(6916009)(82740400003)(478600001)(2906002)(86362001)(426003)(47076005)(5660300002)(70206006)(26005)(8936002)(7696005)(2616005)(70586007)(81166007)(336012)(356005)(1076003)(4326008)(316002)(8676002)(186003)(82310400003)(6666004)(34020700004)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:57:14.5688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5fd85-e7c4-42c6-dfe1-08d96321a1a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3912
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

Check range access permission to restore GPU retry fault, if GPU retry
fault on address which belongs to VMA, and VMA has no read or write
permission requested by GPU, failed to restore the address. The vm fault
event will pass back to user space.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 30 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  5 +++--
 6 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 831f00644460..ff6de40b860c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3347,12 +3347,13 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * @adev: amdgpu device pointer
  * @pasid: PASID of the VM
  * @addr: Address of the fault
+ * @rw_fault: 0 is read fault, 1 is write fault
  *
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    uint64_t addr)
+			    uint64_t addr, uint32_t rw_fault)
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
@@ -3377,7 +3378,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &&
-	    !svm_range_restore_pages(adev, pasid, addr)) {
+	    !svm_range_restore_pages(adev, pasid, addr, rw_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 80cc9ab2c1d0..1cc574ece180 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -448,7 +448,7 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			     struct amdgpu_task_info *task_info);
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    uint64_t addr);
+			    uint64_t addr, uint32_t rw_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 24b781e90bef..994983901006 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -93,6 +93,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_iv_entry *entry)
 {
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
+	bool rw_fault = !!(entry->src_data[1] & 0x20);
 	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
 	struct amdgpu_task_info task_info;
 	uint32_t status = 0;
@@ -121,7 +122,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, rw_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 097230b5e946..9a37fd0527a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -506,6 +506,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_iv_entry *entry)
 {
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
+	bool rw_fault = !!(entry->src_data[1] & 0x20);
 	uint32_t status = 0, cid = 0, rw = 0;
 	struct amdgpu_task_info task_info;
 	struct amdgpu_vmhub *hub;
@@ -536,7 +537,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, rw_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d4a43c94bcf9..cf1009bb532a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2400,9 +2400,29 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		WRITE_ONCE(pdd->faults, pdd->faults + 1);
 }
 
+static bool
+svm_range_allow_access(struct mm_struct *mm, uint64_t addr, uint32_t rw_fault)
+{
+	unsigned long requested = VM_READ;
+	struct vm_area_struct *vma;
+
+	if (rw_fault)
+		requested |= VM_WRITE;
+
+	vma = find_vma(mm, addr << PAGE_SHIFT);
+	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+		pr_debug("address 0x%llx VMA is removed\n", addr);
+		return true;
+	}
+
+	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
+		vma->vm_flags);
+	return (requested & ~vma->vm_flags) == 0;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			uint64_t addr)
+			uint64_t addr, uint32_t rw_fault)
 {
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
@@ -2440,6 +2460,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 
 	mmap_read_lock(mm);
+
 retry_write_locked:
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
@@ -2484,6 +2505,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
+	if (!svm_range_allow_access(mm, addr, rw_fault)) {
+		pr_debug("fault addr 0x%llx no %s permission\n", addr,
+			rw_fault ? "write" : "read");
+		r = -EPERM;
+		goto out_unlock_range;
+	}
+
 	best_loc = svm_range_best_restore_location(prange, adev, &gpuidx);
 	if (best_loc == -1) {
 		pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index e7fc5e8998aa..e77d90de08a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -175,7 +175,7 @@ int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 			       unsigned long addr, struct svm_range *parent,
 			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev,
-			    unsigned int pasid, uint64_t addr);
+			    unsigned int pasid, uint64_t addr, uint32_t rw);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
@@ -210,7 +210,8 @@ static inline void svm_range_list_fini(struct kfd_process *p)
 }
 
 static inline int svm_range_restore_pages(struct amdgpu_device *adev,
-					  unsigned int pasid, uint64_t addr)
+					  unsigned int pasid, uint64_t addr,
+					  uint32_t rw_fault)
 {
 	return -EFAULT;
 }
-- 
2.17.1

