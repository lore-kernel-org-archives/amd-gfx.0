Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485EDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D9060E73
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11D9060E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7829E6E064;
	Tue,  9 Nov 2021 23:05:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AFD6E88B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 23:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctfVHoFexyn5HoiZGR/Gm56gxFeH0DFTtb7re73c3tON7G9R4sylf02dmIAlecr3xX4vQdXPKHbhTu7qE/cScSpe7DdboWH1ERcDH/AKYdapQqFxUKoRTCHYjnm9lWsYNX+h2yTE5GcMd2zLmzZQxH/S5YYhC96azvrIKFizxGTxyH8RmteuFDKpafwTbdnUOpi0xR6dXbqRGMm0K3/ArtWmkiYxaavxfWff8RQzxXo8nrXofysVTHw4zOfb4A8dcsLete5X7DCQfDyz9QpYKKIegL6D9LNRZzm8Vj1/KXLJpGLjq1Hv4aqD00UIrTepFGVazWuOLhxE1hqga+Joww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0mP8MJltg1fcpUZpzkkEBGcURVzDYrTqk3PsOfeOcU=;
 b=FhKOcSD/HU6O7J9VSWum3a5IuGg/k4ihYQvvVSJfODHVeg3USLh78R7Ou8LPSJaf67FcFHuCVguQ6rovZq1/Hbc9/ATWPnWYLU2uWUfig5ZHuiIUQmNcM1Phv694CONDpeWCiygf2W3LqC0obflQDm5AVdBaswrN71HE/vMxqrnkyFv8XV337Y+3JPKhW5oQ8sr50nA5QNoTpcJZ4eFvnUxqOjwnQ0D3aP0+qfRpEXOPB36AqyYCs/+9Rm8iA8QM8BQsk+AXWOWiYHkdMt9jx709rXQeiKqXCTnMwK/aZn0zz/MRRETj6h0bbo0MAyT4rkQ6GlIS5BvzDM0t3qbJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0mP8MJltg1fcpUZpzkkEBGcURVzDYrTqk3PsOfeOcU=;
 b=1uFtpySv1acB1xNYj05QuPHnJ2b+Njn5oM8NoZoBvHamTkYOS2PUI+7es32NY+9sJDnmADeutoWCMcvs+7nrbFK5t6IEymtGZ+8Ospu6uhp+aWv78ks07+PciaXpbL5c3xBHGwpPrNN+AJnT+nBg7LBOj+lefgl1ffKkgGOHtPc=
Received: from DM5PR06CA0065.namprd06.prod.outlook.com (2603:10b6:3:37::27) by
 DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Tue, 9 Nov 2021 23:05:10 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::dd) by DM5PR06CA0065.outlook.office365.com
 (2603:10b6:3:37::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 23:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 23:05:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 17:04:56 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: restore pages race with vma remove
Date: Tue, 9 Nov 2021 18:04:30 -0500
Message-ID: <20211109230432.3947-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109230432.3947-1-Philip.Yang@amd.com>
References: <20211109230432.3947-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c54e0256-dcf9-4515-4422-08d9a3d56122
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26496E2881A6C0E40632DABFE6929@DM6PR12MB2649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSeJWHcvnWJkrOlpCrz+ZRyStO4CLVbGB/E2w8bvrFQy9a8l1eX3wmGCdj8S0/sBkiiYKztEwd6Ugnv+ftUDhViBzOnGJdZYYQgy1lITS2df52yCbsyh2Sg+PMA3qTheeb4gahYphzju9EL6U6sHY/UCTwMd6YymOqTXeZ1Mmq4jmQ0vPArCAZ4MhRAn3XXec0+BmRUMONwN49+MZJBlctSJCAaHiOZmLBqfVz1mWlSRPIpDy43QnRaCs5I1VH8tVV9J+5rHO2Ek1GKj0QmggAgNa7FlESq4TYSgAPbmzV+ML++3JYYf3uvZJ/Q7gjWSXM1CIf7TiVvDAH20EHYqYoz47CAXB3X2fVqd1zC+vOj4mLJXj2oWZt0Tiorygp624uwoWny7RylpFdc8ItxeSACLJd5AyMCEBKJTBPSO91EYZDNWF3Nj3dhgZ/oxcz6zwQ6Wi8LIWeXqI5gA6BOYwuKRDHhvpuXrqIxl9J7GHgg2UqiGgINIuWl+2qVUa2cb4D76a/AKGUkeh0XwR09wYP4/CIK1iHlG7tD+gcwUxABI22dJ/k2WidQ7XZe3CyEkavaixlRElMnF3xMuy2bBKi4IWtNsl9hsFofuJruDhu84ROQFH9oeI4lbjXekcrC/BeBgxQU53tF+B7ZpsqI6n2nvOjP7kRCi3Jtpp2COvchhvYECPSrN6KD95O5n/X9cpTfX7agr3UkPXPPBOGTnRz/GAllCcDfgwOn5AELdoQA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(36860700001)(86362001)(316002)(70586007)(2906002)(186003)(54906003)(47076005)(26005)(70206006)(6916009)(7696005)(83380400001)(508600001)(8936002)(2616005)(356005)(1076003)(16526019)(81166007)(8676002)(6666004)(4326008)(336012)(36756003)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 23:05:10.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54e0256-dcf9-4515-4422-08d9a3d56122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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

Before restore pages takes mmap read or write lock, vma maybe removed.
Check if vma exists before creating unregistered range or verifying
range access permission, and return 0 if vma is removed to avoid restore
pages return failure to report GPU vm fault to application.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 64 ++++++++++++++++------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 64f642935600..8f77d5746b2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2336,20 +2336,13 @@ svm_range_best_restore_location(struct svm_range *prange,
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
@@ -2444,9 +2437,10 @@ svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
 
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
@@ -2456,7 +2450,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	uint64_t bo_l = 0;
 	int r;
 
-	if (svm_range_get_range_boundaries(p, addr, &start, &last,
+	if (svm_range_get_range_boundaries(p, vma, addr, &start, &last,
 					   &is_heap_stack))
 		return NULL;
 
@@ -2558,21 +2552,22 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		WRITE_ONCE(pdd->faults, pdd->faults + 1);
 }
 
-static bool
-svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
+static int
+svm_fault_allowed(struct mm_struct *mm, struct vm_area_struct *vma,
+		  uint64_t addr, bool write_fault)
 {
 	unsigned long requested = VM_READ;
-	struct vm_area_struct *vma;
 
 	if (write_fault)
 		requested |= VM_WRITE;
 
-	vma = find_vma(mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
-		pr_debug("address 0x%llx VMA is removed\n", addr);
-		return true;
+	if (!vma) {
+		vma = find_vma(mm, addr << PAGE_SHIFT);
+		if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+			pr_debug("address 0x%llx VMA is removed\n", addr);
+			return -EFAULT;
+		}
 	}
-
 	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
 		vma->vm_flags);
 	return (vma->vm_flags & requested) == requested;
@@ -2590,6 +2585,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
+	struct vm_area_struct *vma = NULL;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
@@ -2636,7 +2632,15 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			write_locked = true;
 			goto retry_write_locked;
 		}
-		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+
+		vma = find_vma(p->mm, addr << PAGE_SHIFT);
+		if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+			pr_debug("VMA not found address [0x%llx]\n", addr);
+			mmap_write_downgrade(mm);
+			r = 0;
+			goto out_unlock_svms;
+		}
+		prange = svm_range_create_unregistered_range(adev, p, mm, vma, addr);
 		if (!prange) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
@@ -2663,10 +2667,16 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	if (!svm_fault_allowed(mm, addr, write_fault)) {
-		pr_debug("fault addr 0x%llx no %s permission\n", addr,
-			write_fault ? "write" : "read");
-		r = -EPERM;
+	r = svm_fault_allowed(mm, vma, addr, write_fault);
+	if (r <= 0) {
+		if (!r) {
+			pr_debug("fault addr 0x%llx no %s permission\n", addr,
+				write_fault ? "write" : "read");
+			r = -EPERM;
+		} else  {
+			pr_debug("fault addr 0x%llx is unmapping\n", addr);
+			r = 0;
+		}
 		goto out_unlock_range;
 	}
 
-- 
2.17.1

