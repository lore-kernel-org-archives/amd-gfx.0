Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06527C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 18:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAED6113B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 18:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFAED6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495606EADE;
	Fri, 20 Aug 2021 18:31:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748A56EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 18:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T97aHuXsy30Esf+sjKZbFQZAopKdwaOdINt5OeT1d+RRliqA745snYAW0Iu5/xiRnNDo2KBs7xI+6FHiATw/bzdDonBj6Lh/ZDrPtsgvnGOWOgsG2Q5SxUXBrLusH8CtBKj9fSserX5VehawDGrXcrRSHRwcMX2RX+baSw+LXX80vSMPaOda8RHAqyBig8lhZ/kYBtS5mB8YxCRJtQmX/r6GUFNbeDGp6YzlKId4jix4Nn4IwJSgZokDlCZ5jzQLIIBpNIHWpshP5yCR/MaPTC+uIAL38fVj+GC40MXbMGHCyZcf8VqovvY1dJms3wp8+8O4zuRQ4fW0lyV5mm4adQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faRghjJGgDvMbm0DItYOFCfj9Xkqch1jkYFv9Td77Qc=;
 b=NRvI2GZb3csJosHMc8zWXXyQt6THi4/7bk7iOBpFZXGrT1KQF7RLvSCNO/YwCMve1p5yvkTVqOXnmgqaooSmAyvlezBMGq8l06tFzwud2L5qZpsZeZozCzSwOqs6061wDatD+gXluX5alarBduUfUBEFy/wEzQrIZ3lNOH3r4ZGjT6SekcJTBBBpmOi7eGWVpoyTKRgX2GaFDTsAAhsMBk9NGxe6IZJy602mbgoxhmzhbDa2mhQm/YTpMZSYsbFBc6xImXAEvFtwcpgx/9XAbFvU3iQgfU2Ui4dZxntw2dPTRZb1dTtFOziebYESa15Sb3MSmJcMx41JQn8kW8uZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faRghjJGgDvMbm0DItYOFCfj9Xkqch1jkYFv9Td77Qc=;
 b=e1rYp6kodmKW2fFwauyef+2zkHxOiZmj7mjSR9Cnl64yjatE95Yhamr79yMfR9lBUL+CfHd/fxHmNfLvWX9GyegOVoKy4hQn75i6QO2xv2rvf/C1XBl54ydf2Fg9XeFcopErsHREsYf8zfmtArWuDY1S8QgbAGKsxowKN+zgrLI=
Received: from BN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:ee::34)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:31:36 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::3c) by BN0PR04CA0029.outlook.office365.com
 (2603:10b6:408:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 18:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:31:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 13:31:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: check access permisson to restore retry
 fault
Date: Fri, 20 Aug 2021 14:31:13 -0400
Message-ID: <20210820183114.30710-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b374d3d5-c0ac-45e1-8065-08d96408bdeb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4200:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42002771940060785D8B812FE6C19@CH2PR12MB4200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24kjNSE4dWAzUX14maokf+WyFgX/RpmLdXCYzV4w8Alx/0EEeCwlc0acMW0gZF2WLFgnMrNqbmj/h9Mvm73CQviq/BIzOq58binGziS9x2FSESJ1Z9XDtUe0AisiLcFf7zfPgeNAS/1OYGkuAstTCNaocLHF/PVO5aZctD0tPMpeKzZUK2YNkK6Wsjw/Bk7MFmdVTq3/i2+7nYsN2u7DeIW511zIb8sVC6mM90+cJcYC82+ZCNXR3nV5ugdAtcZ6NsUDjYaFxcqs0c8gsofhrEayD2ql75YvlpB4tAymwpKMCIIQJaFjDClM9c3HGpNOPmFdqOI91sAxs0u+7iw+Fe1BK2v6W1HFF1RdqV5Ofj6vIIALqEKPaPudA62wlZQcpJJMmgU6YpXyQCf5J75QLvPQ5/RnKZh/LJ0/VN8JSYkkD6dXEMr1xCg8UKcURbT3KYUDtZN7SQAazwBOakQ7YWdOKXahVO1+pzA275Ua004SfOfQFJQmGF/7TZGNUZwUEGw51il4W/BZ4M0utd0YW3SeN+m4w+wivvx878jqysTdGtyM8Zc8YMPIXZx9aEGPLrYgxjldBhuatURfKH2+kzUhNgSNvDjtUU2UHP2bqPIJaIPFyJ3UimpLqNg9M/X7BxBb3g3l83d1M0R4blgi9JJ342i9mzEj1rRPfPF8WvOGi7TK0RkW/aTkAojSaA1kt033Q5qswBLrFkFo1w6fNDjMggD/AxIESm5FhHPM7d3pZA51Akh0n6N3OCRTKxKZdOxqzmG0fNar67yzGwTqVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(336012)(1076003)(70586007)(82310400003)(34020700004)(36860700001)(82740400003)(2906002)(86362001)(8936002)(70206006)(47076005)(83380400001)(7696005)(36756003)(4326008)(81166007)(2616005)(26005)(8676002)(6666004)(16526019)(356005)(478600001)(6916009)(186003)(426003)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:31:35.8049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b374d3d5-c0ac-45e1-8065-08d96408bdeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 29 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  5 +++--
 6 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 831f00644460..bbb892d8f489 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3347,12 +3347,13 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * @adev: amdgpu device pointer
  * @pasid: PASID of the VM
  * @addr: Address of the fault
+ * @write_fault: 0 is read fault, 1 is write fault
  *
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    uint64_t addr)
+			    uint64_t addr, bool write_fault)
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
@@ -3377,7 +3378,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &&
-	    !svm_range_restore_pages(adev, pasid, addr)) {
+	    !svm_range_restore_pages(adev, pasid, addr, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 80cc9ab2c1d0..85fcfb8c5efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -448,7 +448,7 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			     struct amdgpu_task_info *task_info);
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    uint64_t addr);
+			    uint64_t addr, bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 24b781e90bef..41c3a0d70b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -93,6 +93,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_iv_entry *entry)
 {
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
+	bool write_fault = !!(entry->src_data[1] & 0x20);
 	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
 	struct amdgpu_task_info task_info;
 	uint32_t status = 0;
@@ -121,7 +122,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 097230b5e946..a7dfb370f642 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -506,6 +506,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_iv_entry *entry)
 {
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
+	bool write_fault = !!(entry->src_data[1] & 0x20);
 	uint32_t status = 0, cid = 0, rw = 0;
 	struct amdgpu_task_info task_info;
 	struct amdgpu_vmhub *hub;
@@ -536,7 +537,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d4a43c94bcf9..b6d1268bc38f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2400,9 +2400,29 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		WRITE_ONCE(pdd->faults, pdd->faults + 1);
 }
 
+static bool
+svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
+{
+	unsigned long requested = VM_READ;
+	struct vm_area_struct *vma;
+
+	if (write_fault)
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
+	return (vma->vm_flags & requested) == requested;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			uint64_t addr)
+			uint64_t addr, bool write_fault)
 {
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
@@ -2484,6 +2504,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
+	if (!svm_fault_allowed(mm, addr, write_fault)) {
+		pr_debug("fault addr 0x%llx no %s permission\n", addr,
+			write_fault ? "write" : "read");
+		r = -EPERM;
+		goto out_unlock_range;
+	}
+
 	best_loc = svm_range_best_restore_location(prange, adev, &gpuidx);
 	if (best_loc == -1) {
 		pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index e7fc5e8998aa..6dc91c33e80f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -175,7 +175,7 @@ int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 			       unsigned long addr, struct svm_range *parent,
 			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev,
-			    unsigned int pasid, uint64_t addr);
+			    unsigned int pasid, uint64_t addr, bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
@@ -210,7 +210,8 @@ static inline void svm_range_list_fini(struct kfd_process *p)
 }
 
 static inline int svm_range_restore_pages(struct amdgpu_device *adev,
-					  unsigned int pasid, uint64_t addr)
+					  unsigned int pasid, uint64_t addr,
+					  bool write_fault)
 {
 	return -EFAULT;
 }
-- 
2.17.1

