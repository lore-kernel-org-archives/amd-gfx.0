Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7DAC07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 21:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81A56113A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 21:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81A56113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718AF6E1EC;
	Mon, 19 Jul 2021 21:19:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369BC6E1EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 21:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfdXBspHR981JtZnkcgA8g+jkVRA61ep4dZ4L9NuZQ/JgL0uBAcnEsccOKGYlEdb+uWVZYU+Hz8hA33paDNSB70ouHRLZtLpuNs5rVbiHh38FQG7vKYFu2LzIAgQSNTYZqAiKmas8T41ierPI4UmNWsPXbj1e6N0/T2HaHUcRUcUj6+Xj/MvkawKhkerl1WJvF2Xi7dwB/+pzwK4R+zh6Kxci3vaiFwQamRB7mPXS8pU6w4CF9HGEZcJ4UK1FWbSWIEhM/zbKy3DhWJ3eZM3fZvI8B6FOhgEhHzE7AIzKXk0iohQF3tacVcGd0VebzWhwMtohkwHO7/RfZ6EmJ36oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7eXuMxW0G+nAREr0kt8/rXMNnE6w+2AhFwUgLNprQA=;
 b=PfhmRgzV7k4zxEs6YD+D91JJ7AtgaNsIc7JqwROGeodu2OUFcxwNkiUimdTxaCZuZpxnAhdow7aIxDPpgVkAdVxF3ZyvPZgljZ0CnjxDrERBZJk1mhM400zCc8/O26kKiTOqDounHS95eZq0I4Taiv874VNuju7Db+1jw/uoNPOgIUGr60Oug1EpVAuxbmAQoqkbsfmI5Pu7vIgOAeG2azHcHNM89k/qm08oDDfC0u704R4gokewCIyZl8i5JNRwh+MGGkV51Jd4zAk+kFR2fcV6P9hFB6a+YdPptlQSvlRappePJ9SjuhigL7EtLpkOjQ8qAWywUrnublUE+4gNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7eXuMxW0G+nAREr0kt8/rXMNnE6w+2AhFwUgLNprQA=;
 b=ZaQFS7nQfzC/SEral/Zm2F218hrr36fdbHQ4qgcKBbhO3iQh906SmE84+tUPkbkA0Pch4TNWsgk+KyBXcLjc/ZN4P2ZVlUbtGNS4r4/G/xXdOrDpKeFRz5MxVbnteh9V0MafQc99V82GZx/Vrqj40qj454jdrdvHwNfJPwEqZRQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Mon, 19 Jul
 2021 21:19:09 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39%7]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 21:19:09 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: avoid conflicting address mappings
Date: Mon, 19 Jul 2021 16:18:57 -0500
Message-Id: <20210719211857.29954-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
X-ClientProxiedBy: SN2PR01CA0012.prod.exchangelabs.com (2603:10b6:804:2::22)
 To SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN2PR01CA0012.prod.exchangelabs.com (2603:10b6:804:2::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0aba4a-1903-45be-ef51-08d94afad8e1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24134DCD3BCABBF61780E4CDFDE19@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5YZSKpuU2S9uRdxR04t1DdaT4Z2TFBX/4rjC+vW9fF02ez4t0xBZmFyEP0AnSYPa9h8ePjZeHlNtxEjxcpEb7+UFUzqqgJDSY+YBvnPa4W1BNq7p//F+t+lX2mLDjFDsLQK/X0hYblVMcpqdPqR79NgS0v5FqNWoewWHSSX/l7GLe8PKg7BZlJRKRy97JNNkRhz6f9zINxhyh+nWKtswG1t6SEe2IwJguFW0E8vp+uCxN+UdFIbhaek5xECa5yzkfgeAhyZhgpPRO2fwZ8RPi57i0XHR0+CbAo1YghkOr5P5LA5PH16Rpjtmd/7u0RQFwaIlF+bRxrg4GONKdKL+O9ySvk2Di5XZasp5r//ywYaE3dDWLgc14FijCbzNSZqh7zhrp9mFT62vAdGupLldiCnEFwid4KhN7wmwbOeC39TS0FC2HIUOAD0ImQXtInOSMjVpgjtwpgulhdn49klwLRIDRau3gQUHB0NBroeeGb1Fdih86wGz4PkcVTuaOtMxvZU7n0v5F8+/wmNyBy1nw///Arn6Y86nrcIi/E6udRTbJvsUqPOfd2twOVljwhyZoHPyCuwzLTemPXV5LQ2IWJH8P/c5S3orl2pb4iBoQerr0Lyf5aKBQsAC0KZqg2s4KZ4Xtyl5NeUowmrx5KOs07WVPzlOq2ZlubJ+y8S9a6bOC75QC7ZSuG2zaZs5rJomGFkelKwEWUSIVL6IfOI2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(7696005)(478600001)(316002)(6916009)(2616005)(956004)(83380400001)(36756003)(186003)(44832011)(38350700002)(38100700002)(6486002)(8936002)(66476007)(8676002)(6666004)(5660300002)(4326008)(2906002)(1076003)(52116002)(66946007)(66556008)(26005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?npncjKVWImhMKQSr16d6jRamvtKN6QMUBfgWOZRTOO5V8RdiMuoHKMoXLHEV?=
 =?us-ascii?Q?qnbdH0oTapJcH9LPc8qYD23gVGi9lsdh005K3zi5yO2YyhHiE63Y6u9Qi45F?=
 =?us-ascii?Q?f5InYrB24VLAfUlEcTgVhOqrpQrqWRbBuUQzKJufROghwM70wni1DA7mcIXV?=
 =?us-ascii?Q?4rUMDSvbFJyeOUS6JQHEvwEono3Agl0JfxX22hfvZDXlaQZ/Q7X4oMCcWKsJ?=
 =?us-ascii?Q?wm9eKfCkm4pA4lLsM0kpQnZJxIflPfByirrXB/QReWkfU4mwMi1VP+M/G9uA?=
 =?us-ascii?Q?o9QS6CnWYL9nX3FSSpjFP6kB2XOyPlF1aOflTPaiOBM2Bwxr1zgRTFdMOoyq?=
 =?us-ascii?Q?xYScwsrfaW66Sa82rwUliuwDkJBWobHDyja6F+oPbn365JlvZXboFjol2QD9?=
 =?us-ascii?Q?FnEPKOMxYLdyl7LOadCjeFJclIrfgLazGUtpCRxD695l+utzL6OdD2Ueaj6g?=
 =?us-ascii?Q?b5FJaaxroXeNAGooseOf2H34tkNKD6AIXqSV6dzGZLvNl2+BI/jzgMDcfcOj?=
 =?us-ascii?Q?7ZlRCX3tOE2hD3zBFoZmrJW7jfunhoEnpdfBuVPZieLXl8q/Px8Ko3ZqWbyn?=
 =?us-ascii?Q?r9jihf/mlJpEABJZU6EdWMwBauaof6GFei7FdzFbAC6yZXFSlmezyS52FRGE?=
 =?us-ascii?Q?LmXGpkURy4vKK6TEiWRMmzc9Q+tjeZh12f72BHpWziJhE3G+gX+2Yba07nMy?=
 =?us-ascii?Q?dD9FH+cPP6BnTu4M8uatDjyDG0zSOXs9sXp9pZxXgSnBIYvZmNYXYvfp3Kfb?=
 =?us-ascii?Q?bVE4xdAKR5LuwCeberTpR4JHHTpbRn5Szg4IqbTR9hyJDgX1himfUsOVKUqP?=
 =?us-ascii?Q?g8C1DYS7axEItAYh1t0GX9IXEpqcO/IPtvH4fc+6EKYECJAXIgpPZze7ym5X?=
 =?us-ascii?Q?bS1M4JJEJ5dMxhhuU5IPKdRtWRFyceM9yXCCDgeJqCyXfcKviEL4TXkhbrNc?=
 =?us-ascii?Q?xlnHClIUUrlxzwZlUCgBMqufE+iAV6PkBqk7Ed02gaepFNI9jDHaxwp3XfV1?=
 =?us-ascii?Q?E1a+WvxE3eE0RDKUXe1J5vlqY4qU2wvf86gLElaEHh357TZIO+EtDp9+lvgi?=
 =?us-ascii?Q?NsxofxwGQIDYM0l3PQ5nFi7QGdJDJd06murYhu5dgwLV2iL+gd9sNYGsQmW0?=
 =?us-ascii?Q?dTqrqCQShafPI1VOEQjgr7CFdVqdM+MUAf5nmfDLj4aSzadNTqcA3ektQGtX?=
 =?us-ascii?Q?I0eHM6k/SBJXxbkY1bDb8cfy4Ad1ht0Op+MMnUIohCwmHBtllva2uOL5fhde?=
 =?us-ascii?Q?tO6BpG2hmQxeoqnmKngUV8zbgAhXa1NB+MhUIWBlLWqD9mVjC9yfFbTQGStv?=
 =?us-ascii?Q?d5ZkQKaXjskB3SiUAxQunhkp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0aba4a-1903-45be-ef51-08d94afad8e1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:19:09.2482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14i3IJ/6qXYxxyp4HAwRjqQNjVcs9rXRoI/KaBR5vJqpmXAewMH9Dcu9IlryArrN1o6mcM6Er6wrQueZXgMi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
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
Avoid conflict with address ranges mapped by SVM
mechanism that try to be allocated again through
ioctl_alloc in the same process. And viceversa.

[How]
For ioctl_alloc_memory_of_gpu allocations
Check if the address range passed into ioctl memory
alloc does not exist already in the kfd_process
svms->objects interval tree.

For SVM allocations
Look for the address range into the interval tree VA from
the VM inside of each pdds used in a kfd_process.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 79 +++++++++++++++++++-----
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 67541c30327a..f39baaa22a62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1251,6 +1251,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	struct kfd_process_device *pdd;
 	void *mem;
 	struct kfd_dev *dev;
+	struct svm_range_list *svms = &p->svms;
 	int idr_handle;
 	long err;
 	uint64_t offset = args->mmap_offset;
@@ -1259,6 +1260,18 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+	mutex_lock(&svms->lock);
+	if (interval_tree_iter_first(&svms->objects,
+				     args->va_addr >> PAGE_SHIFT,
+				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
+		pr_err("Address: 0x%llx already allocated by SVM\n",
+			args->va_addr);
+		mutex_unlock(&svms->lock);
+		return -EADDRINUSE;
+	}
+	mutex_unlock(&svms->lock);
+#endif
 	dev = kfd_device_by_id(args->gpu_id);
 	if (!dev)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 31f3f24cef6a..043ee0467916 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2581,9 +2581,54 @@ int svm_range_list_init(struct kfd_process *p)
 	return 0;
 }
 
+/**
+ * svm_range_is_vm_bo_mapped - check if virtual address range mapped already
+ * @p: current kfd_process
+ * @start: range start address, in pages
+ * @last: range last address, in pages
+ *
+ * The purpose is to avoid virtual address ranges already allocated by
+ * kfd_ioctl_alloc_memory_of_gpu ioctl.
+ * It looks for each pdd in the kfd_process.
+ *
+ * Context: Process context
+ *
+ * Return 0 - OK, if the range is not mapped.
+ * Otherwise error code:
+ * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
+ * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
+ * a signal. Release all buffer reservations and return to user-space.
+ */
+static int
+svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, uint64_t last)
+{
+	uint32_t i;
+	int r;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct amdgpu_vm *vm;
+
+		if (!p->pdds[i]->drm_priv)
+			continue;
+
+		vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
+		r = amdgpu_bo_reserve(vm->root.bo, false);
+		if (r)
+			return r;
+		if (interval_tree_iter_first(&vm->va, start, last)) {
+			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
+			amdgpu_bo_unreserve(vm->root.bo);
+			return -EADDRINUSE;
+		}
+		amdgpu_bo_unreserve(vm->root.bo);
+	}
+
+	return 0;
+}
+
 /**
  * svm_range_is_valid - check if virtual address range is valid
- * @mm: current process mm_struct
+ * @mm: current kfd_process
  * @start: range start address, in pages
  * @size: range size, in pages
  *
@@ -2592,28 +2637,27 @@ int svm_range_list_init(struct kfd_process *p)
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
+	return svm_range_is_vm_bo_mapped(p, start_unchg, (end - 1) >> PAGE_SHIFT);
 }
 
 /**
@@ -2913,9 +2957,9 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 
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
@@ -3016,17 +3060,18 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	uint32_t flags = 0xffffffff;
 	int gpuidx;
 	uint32_t i;
+	int r = 0;
 
 	pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
 		 start + size - 1, nattr);
 
 	mmap_read_lock(mm);
-	if (!svm_range_is_valid(mm, start, size)) {
-		pr_debug("invalid range\n");
-		mmap_read_unlock(mm);
-		return -EINVAL;
-	}
+	r = svm_range_is_valid(p, start, size);
 	mmap_read_unlock(mm);
+	if (r) {
+		pr_debug("invalid range r=%d\n", r);
+		return r;
+	}
 
 	for (i = 0; i < nattr; i++) {
 		switch (attrs[i].type) {
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
