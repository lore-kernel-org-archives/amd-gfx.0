Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3196C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 04:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FD060C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 04:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FD060C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186D66E038;
	Fri, 11 Jun 2021 04:52:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA946E038
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 04:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2nMyDAI6DKT4qO5OMjWfpuS1RsMcvWWi5nxymomzqD+fRs3yd3M8LUfirwoAoNar41Wak72MO6tVqD0AXfd9C0d0SD6cRkxBofyeprkSa2XC0XAcb33yx9qKSh54M/boZesRBDzibtMauACxd4SYLNltjJDPqmr6JfI3DYKgIo1GtjU1Bs/enUod+T4L3QKznS23jx4lNT+7nzLs5yl8UZf9R1o9UvU2P8DpQT9N3vGdXSAAd7+81UNAk3z63noxa8GeIgykjH7acqoafo/7ftGbWegGFMYSRDrNzFmr+rD/CEL9NjGRKm/9pfDcEnGQg54ZxLp6gXhC/HA+IaRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl4ovX6wLu5eBEyiaFLoEg3THX1OVMnFd65AGB6/zNc=;
 b=f+h1aHXJQ24g56R0arlTFfh+RV3gZzpp3fVnkZ8oe8axFfzj+aoShXaYNCyo4Ppk4zsAiyxgSiGOWTB/cfyC6mUGSXfAM1T40uPlYhcq1MuoBNy5pp9wdSeKIhQMFHAg21kuMSn4QaSSEYaR48YN49bSgVEGTJQcD81Lc52VtVtXh4UfNLnG/klB48Mq2ARSsDXvBmdgZzNPtMb7VHdeUAQih0IUZA2ieiMOsEP1YBuKJ80sU15f9sInXV7p6vFFBNRFclES3ZaH9LqQHxrfV+u9KVH2iDXq9t7IOjEOSBCk/NDaZmgbFIzkX//IDluPnEsqG42Gs/Yilg24ganSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl4ovX6wLu5eBEyiaFLoEg3THX1OVMnFd65AGB6/zNc=;
 b=krUPbnRh5sGRFW+hcrZxkwdYhaEJ0cLKQqq0VVuFzFUJtEmoqLORnajAn4BAuinhs2vE2b8JnYopHoKB93sWLG/b+KizoyQ1JCAaRXHPZe65xCUNN6C265M2lbWYdYt+C8DBuX695R1pV/5gq1A151NW1AOHRELinHWvcA3hNk0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 04:51:57 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%5]) with mapi id 15.20.4195.030; Fri, 11 Jun 2021
 04:51:57 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: avoid double alloc by ioctl_alloc and svm
Date: Thu, 10 Jun 2021 23:51:43 -0500
Message-Id: <20210611045143.557-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:806:a7::32) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR10CA0027.namprd10.prod.outlook.com (2603:10b6:806:a7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 04:51:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a59fa3-a520-4faf-5e28-08d92c94a40c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512EE9525DE711EAF2168CEFD349@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrOwH1bW2dUzVjjbeUc7tXswulB30aLb/xNMIrS/Sm7qeOy8RgvWcDDazy9txrx0OgZ62yDEg05zmbJ3J3A3b6KJ+TT9p0/uD1aoK8UhZgOxqKilEnd33NHNUrJIZJeqhVV0Hy+BGEvrr7esAlfSToT09tnRGDOsV+I9rpXPUPK33xNPa3KEHbo9SWnIshQSoZpNbjErD0f6IcgvYMVf2br75+HFBDZ3gOWaEemYT9ZPTDKTBnK2mTXuNfWUSNlUS6eOTRpkf0U4WUEB1PVSntSb7Ff8svifJkEdmFsN71/T8ZYSde6RR0bpIYHCoEcvjdk1BeQn+UmROYZC22Er0yEJcsS0EFLPeuNHAOGnZYxDRhNqbbTAqe+0LAub8+OB7kTTl6ZhES8aZFLjXhu6G4Qie4MY1q59V+pwlrSXENtQ8ukkxfP708P837Gw5ArV3nt1OjWjseetaq+ag5ZjNXHn+g3O9kbPWVn/kQraJvvfQh5CDoCYMwJT5nhTvCcdoPQZl04TOlb3UsftfX2RjM8aYhlcBlSFKz3nAPs2Imaiihp3Z91SK7iiZ3Kt7j05ZIdG3y88G5bdbT5gXVcxJltPK0FJPb+Kdn1ddWqFBz3NeaBDlCAGruCDOwzCKNF8mSiHmMIwDepvb7t3o5QO/JxY7hbyFTB8Y60aBwDIHJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(5660300002)(6666004)(956004)(86362001)(83380400001)(6916009)(2906002)(66476007)(66946007)(316002)(66556008)(2616005)(44832011)(38350700002)(38100700002)(8676002)(52116002)(7696005)(8936002)(186003)(4326008)(16526019)(478600001)(6486002)(1076003)(26005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPhT2Qu4OudEm4Vmqm/QD/S4bR1gjedwWb2xAroU8RS2TKlkj+jvvGrMqOLO?=
 =?us-ascii?Q?pdc3hbC4+cbhvszXWmmp8XDj+meYvoaFcWjboqDF66PBotOdL6dc6paTRWIx?=
 =?us-ascii?Q?JrT482AMsvYC44YwVK7LUbnbdqpriqF6VMbeg78A9d5SLiwvKVMcy+DQifYn?=
 =?us-ascii?Q?gtk68x5Bmd73n7AMuzJz1T78uyIxlaoS9bgDELoSdOEzJbz71KL2CsUpEWn9?=
 =?us-ascii?Q?79VVsp/j6m5u6j+U7cAa77rQV6JHAfXatnDNzRa3Nu3ccV1SfPw5S4dUebWQ?=
 =?us-ascii?Q?f+HGcE3vfs6MCmf9jFvIc4NwF3mW5yk55yVhmnxGmzGyra4wZ88rO8+N+ONl?=
 =?us-ascii?Q?YXXBc/0j9jSsqJ5BpeYxBptv4CGTyGgUyoYj3fInBAO4gelIhPFC5zT1NFeG?=
 =?us-ascii?Q?Cnc9s6OzyvrIIIzaZ3JEbkVDh+5uwa4YeEA3J61moNhIBn9UQPFOekVFsKEq?=
 =?us-ascii?Q?KtvH4g/97xSDwkpxzRh759yYG5SZFJDcaWRMl4eRSnEgbvFm7i/m5JxdjTNH?=
 =?us-ascii?Q?ivL6wzQDCrMfn3WBFayuuxmKajG+cxygz4qcVFHi+13ygADul4RfRDn+D03n?=
 =?us-ascii?Q?TzEpLBn3fQWRURvYFMnGwIFvpsJgFXd0XpxNrT3ddhfiSp9plcVm+kM+Wi5q?=
 =?us-ascii?Q?M9lFi/2srVGUzqyx6HWSeA8kpDIxa3Ro3RSAyx0tt1GaTnC+cXFLC/j90Vu0?=
 =?us-ascii?Q?wm/otDhqJ5l86qHWqyYums0L+TRVSCUsDj+rAXe6Xs3YfMpq+ozNPRh7ceVY?=
 =?us-ascii?Q?qFSh0tbKvk/nz1JuZEsUIvNWhmhvstds88Hs7lHvaHg/9K2ntiilbd9JhxJW?=
 =?us-ascii?Q?6cCSpf+5ITIjAji9xwdxonpo/9pS3IVVZRpBPbYuZYSt3ws3JNjVJlYFVbze?=
 =?us-ascii?Q?kOuWDOCjrpnn7mOENKUjVrWqXUHwQixrIu+aLbSM8YIjqFKQjGH1OX5kKRKQ?=
 =?us-ascii?Q?3eECQNzVbjBz1UKBDD58Di6vwOxzY1Ul6qr5L+jJr8/EaqbQqhv30I6lnVKj?=
 =?us-ascii?Q?OR2PXceuKKz111GuKP9SdYweo5YEHifU6D87lHGrgZ92qEwRsAIpz9BfBB/t?=
 =?us-ascii?Q?fgYncYwVUfcauEhiBwzao+pikNbyY7yT6r0SPmlo3gDMazh+R4gX8UBUlHWQ?=
 =?us-ascii?Q?Y3le5f1bxX9oHdWi7xoFpV53ca0ZloQ5gVV31AQscXA7kVndQFquoW9Xae7F?=
 =?us-ascii?Q?oweGVQmUXT+5OKifj/yulyjG2QbNSgRrO6f4PJQcsG1xjEIxFupJPMlixn6k?=
 =?us-ascii?Q?ie3Z2lFaixn8TnC3QvIn9RlKN5HtgqQj0anJ8JEksx1i7UOQk9G9qP4G3PFe?=
 =?us-ascii?Q?dDSmPfJhPCuTVvyEkGQf011e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a59fa3-a520-4faf-5e28-08d92c94a40c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 04:51:57.0035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pglFxeQgG3s+LKtwMUzCI5RzPE9OPV5YgEyapjTiQCXexD6bNCjmG1Sdy9m/V8YaJJl1HWntdusgMjNVnGDRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Avoid duplicated memory allocation for address ranges
that have been already allocated by either
ioctl_alloc_memory_of_gpu or SVM mechanisms first.

[How]
For SVM first allocations
Check if the address range passed into ioctl memory
alloc does not exist already in the kfd_process
svms->objects interval tree.

For ioctl_alloc_memory_of_gpu first allocations
Look for the address range into the interval tree VA from
the VM inside of each pdds used in a kfd_process.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 63 ++++++++++++++++++------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5788a4656fa1..0cfa685d9b8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1259,6 +1259,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+	struct svm_range_list *svms = &p->svms;
+
+	if (interval_tree_iter_first(&svms->objects,
+				     args->va_addr >> PAGE_SHIFT,
+				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
+		pr_info("Address: 0x%llx already allocated by SVM\n",
+			args->va_addr);
+		return -EADDRINUSE;
+	}
+#endif
 	dev = kfd_device_by_id(args->gpu_id);
 	if (!dev)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0f18bd0dc64e..883a9659cf8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2485,9 +2485,40 @@ int svm_range_list_init(struct kfd_process *p)
 	return 0;
 }
 
+/**
+ * svm_range_is_vm_bo_mapped - check if virtual address range mapped already
+ * @p: current kfd_process
+ * @start: range start address, in pages
+ * @last: range last address, in pages
+ *
+ * The purpose is to avoid virtual address ranges already allocated by
+ * traditional kfd_ioctl_alloc_memory_of_gpu ioctl.
+ * It looks for each pdd in the kfd_process.
+ *
+ * Context: Process context
+ *
+ * Return true only if range has been mapped
+ */
+static bool
+svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, uint64_t last)
+{
+	uint32_t i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct amdgpu_vm *vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
+
+		if (vm && interval_tree_iter_first(&vm->va, start, last)) {
+			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * svm_range_is_valid - check if virtual address range is valid
- * @mm: current process mm_struct
+ * @mm: current kfd_process
  * @start: range start address, in pages
  * @size: range size, in pages
  *
@@ -2496,28 +2527,28 @@ int svm_range_list_init(struct kfd_process *p)
  * Context: Process context
  *
  * Return:
- *  true - valid svm range
- *  false - invalid svm range
+ *  0 - OK, otherwise error code
  */
-static bool
-svm_range_is_valid(struct mm_struct *mm, uint64_t start, uint64_t size)
+static int
+svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 {
 	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	struct vm_area_struct *vma;
 	unsigned long end;
+	unsigned long start_unchg = start;
 
 	start <<= PAGE_SHIFT;
 	end = start + (size << PAGE_SHIFT);
-
 	do {
-		vma = find_vma(mm, start);
+		vma = find_vma(p->mm, start);
 		if (!vma || start < vma->vm_start ||
 		    (vma->vm_flags & device_vma))
-			return false;
+			return -EFAULT;
 		start = min(end, vma->vm_end);
 	} while (start < end);
 
-	return true;
+	return svm_range_is_vm_bo_mapped(p, start_unchg, (end - 1) >> PAGE_SHIFT) ?
+					 -EADDRINUSE:0;
 }
 
 /**
@@ -2826,9 +2857,9 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	svm_range_list_lock_and_flush_work(svms, mm);
 
-	if (!svm_range_is_valid(mm, start, size)) {
-		pr_debug("invalid range\n");
-		r = -EFAULT;
+	r = svm_range_is_valid(p, start, size);
+	if (r) {
+		pr_debug("invalid range r=%d\n", r);
 		mmap_write_unlock(mm);
 		goto out;
 	}
@@ -2929,15 +2960,17 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	uint32_t flags = 0xffffffff;
 	int gpuidx;
 	uint32_t i;
+	int r = 0;
 
 	pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
 		 start + size - 1, nattr);
 
 	mmap_read_lock(mm);
-	if (!svm_range_is_valid(mm, start, size)) {
-		pr_debug("invalid range\n");
+	r = svm_range_is_valid(p, start, size);
+	if (r) {
+		pr_debug("invalid range r=%d\n", r);
 		mmap_read_unlock(mm);
-		return -EINVAL;
+		return r;
 	}
 	mmap_read_unlock(mm);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
