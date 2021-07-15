Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E0DC636C9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 19:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02BC6128C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 19:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02BC6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFBC6E8B3;
	Thu, 15 Jul 2021 19:59:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B2C6E8B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 19:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJAVWlnJhFt7PHAvgUJadep9zgYDdwV2q8kcZthb91nzoYGZS0eKOOph3HlmmW57qjKReZoPPwQpqoin0VR7nBfrxS3xL5GgxnOq3S68Q1ctvTEnJMIZGyFvUYbWflTrxyyNVNnKTCnJzG85deqGVIVQ2gBbKnIUqRw6yTUkyYtO7iL9oGEm6T7Gm3MTmAntu58mVqBTCvVhpHoWlM2jsqOVNkK13YmoTrxmnnrTbr/AwAYBhh8HAhNLwokbM5fN85C+/hR6b0u2kVZ1Aeifq6k+q1JSZP8cCESZvx/jru6oiR8/n74/Oy7tfKexEocrrzyyMJ5Wv4qJWdXfsc4pHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lkjA3O3TsfXYFy4NfKHomn1Ue+/e2uoOyTSpKcV64U=;
 b=P9CuGgqtPD0b5qPeEhdO71G05djQhBEx2xvEHpOTZcT9LR0ZPLbTzyVai5W00fZI7GVco9NRnoUUQ0g+pEh2KY4UfUWHWS4qtq/NKN/Eg7aiQwLHh2EO3Yjof45lvXY0sZ5QbUTQvrSf7b3qEc3NN0y3xlb0lxY6MwyuLHzpwHaFfRBFg1W/baSHYSux4SjfWG7/mi/lZqzRZToSv1GBVg5oaBFLoOtZM6HMkOkj9bY7uSrUPbuDz7spt459aoe+UMVXCgzqsf9uAanndG0N4HmntMxUEwDbUprbvNz4BBwpKx/qQIvh+iNwD8Vu3R05a/LAqmlEy50ax31D/YmCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lkjA3O3TsfXYFy4NfKHomn1Ue+/e2uoOyTSpKcV64U=;
 b=ivAZEWIEMDvwpdUwgN3BW61vRQxQr3EZzjPXlGey1vtSDBMEclOX4D1T7WAzOaWuLQllP+l6quzeJvxHbC+9uDDn+QVaL/6rKyXOveOYhsa3/Lkq56+1ipq00BJUWd11JTnqksxKJSROq48qeGke3J4lORyLscx5czPvuhx5Wtw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 19:59:36 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39%7]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 19:59:36 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: avoid conflicting address mappings
Date: Thu, 15 Jul 2021 14:59:11 -0500
Message-Id: <20210715195911.6673-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
X-ClientProxiedBy: SN7PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:806:120::19) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0044.namprd04.prod.outlook.com (2603:10b6:806:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 19:59:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e1b878-6ea2-4fc1-2258-08d947cb128d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4413E4610A4C0F4D7D203D23FD129@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Oi/RzX2ngF/hu4DGAGU7bzmoI1ZFdVQVyvDPwEIJ4MSw0IlAx7PgevLH/Miz6eWV4boeQGt1f9oYbq5SSyBiFPa3AvHxafuzqfiMKmT8eImHduZ4xobWI3kJz1CiH/PZV2VVhVELu8IAtNtmq66SsRjclxqAshjlZWPP9sVhJiF2DMhf6nhqMyU48JlXns08LIb3qVg0a+BRQYC4ur+YHHjpgoQC8LO/VJbSe4ckiajaPLqEeC28Eve9B0+63lpUPDmBtN/YpkBje3cqAJ2EVM1D9p1quXHk/p6L7xfcuYvjdUAQteouNWJ9BQ4O+E7nH/kdZrXX0O1fcam1zPdC2eDmqpCu77zEtzQqfjQ51jkA5J4+h82t0RHNF6ALDFhs6+rUqEc9om+k/5zRsGR2gz2oIOvdr2ddalxzf8aqj27Ity8WW2iEQRuf+6J6VM/HGTHmF4mJ2s06zuFhq24kyCd5dPs12/ZcSIJk3P8Dy5GPMTrwOR+Cj28aZpWj5Ww3gWLa94itE2DFAGgD7jl9WDpzXcwYXvKgRCbChUKRlccsHOSFv8u1zS1Nik51607lKQpMXchNochHutwy0dxJIN5BAhIkhrM1P2KxAh6yPa9n0M287K2POKP24FjGbTgFohdKz4DmF4sqbFQ4mvd4SZinYL0EsQgnMJmYxyi6hck2PLPwPCTIVENbr62Olv2yQgZY60ko6YKWTdsx1ei2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(956004)(2616005)(6486002)(86362001)(44832011)(83380400001)(186003)(8936002)(8676002)(1076003)(316002)(66946007)(478600001)(7696005)(52116002)(2906002)(6666004)(36756003)(38100700002)(38350700002)(26005)(66556008)(66476007)(5660300002)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THXAI+Y4Mn2ENvX8sWXFs9wzOslitQhrk3+0OjGrTDU6+UzFFuHxsFE1u9FW?=
 =?us-ascii?Q?ktNP4JmTlBGjiyAfQ/9bzC03ka0T+Te8McuAWXIjvWW0MU9mInd56WJPu2E4?=
 =?us-ascii?Q?MrCz4l71GeE4WNOkTOpTuJ0WyDaMMjuveBDqlH6afAnSu8h259TminBTeySO?=
 =?us-ascii?Q?97updBhD1MBNB4KbsVtBo0TPnB5x6NYaJ0Tin+MCmiRikPZlIaQDwSGNtSJf?=
 =?us-ascii?Q?5MfxOFR9fYcHjx38iKMFLt2v8pDlvpvPsTuxE8j4p6RaXUYzQHR62nWxFoM/?=
 =?us-ascii?Q?o+NCEWHLUpHn8bFT2UUL7Kg09qnxP7dIdj62T1+cqbt+ZqIJjnDpgJlNqo1x?=
 =?us-ascii?Q?Gavzh1iS5rTDWQZYtqzOCtChfZBhnCN0Iuu2auG8LDdozQRBTx2lKw5csbcn?=
 =?us-ascii?Q?XJtHv9ViYUsqyUcRPedMgafph1E3R4/qZSfkBrQwnaNGpYCmkJg/c4CyUlr1?=
 =?us-ascii?Q?gyjs33UyLkEkr7pxijvfHj2Y6TdKq915p7T7Mok4uZV/30Ima6GvTX2fv8Kn?=
 =?us-ascii?Q?hvGrel2vYIsrX+jOgH9kpqLcG738C100NaWEje8oR4Zzz8cSbGwYHDMhFbZv?=
 =?us-ascii?Q?HtjBlAX2u7Vbz67Ju8EqjVDr5DpwpuH6SIucCKcd1sdW36X2miiaMO+gnw2q?=
 =?us-ascii?Q?IbCigHx+B0CLJENvEQgCIIjyhMxFEBXfIHdo/BWSYnn1dVbn8oeAA/Q6tpeJ?=
 =?us-ascii?Q?gM9lVLToKgJzXyVKy0NnGi1b2fQp3bpxakCyKLys+XVZ+yVn0MVNkmYuExz9?=
 =?us-ascii?Q?VE0AezJpfJB34iFPs/ppbGRe0jK7ktT1Djsrgq4cEge466PudnrxACEsw3vI?=
 =?us-ascii?Q?4G9VXOppLnyEJm5hfd9+iQImfAtd+7oEcP14ypC0nONmkEM4oCtBOULjSyvp?=
 =?us-ascii?Q?zLSZ0LlbEdP48SeeZlmLKEeE/8TRRTwX6RpkzXEQtbsydeyE0adUFwvmBoEg?=
 =?us-ascii?Q?Ib+VxjfEURlpYut1ioDoeqxUExMyX8vgI+UyH867PG4QCp33tZ5XjuEQR2Co?=
 =?us-ascii?Q?dt8CFkAW0sOILVcfxMypLlE2CYfJiErFw3/tGUjJo5N3F3YG2ntgxbHOMAQn?=
 =?us-ascii?Q?1WUJ1cAfjpj7YqWMCO2lfo/nkixHrN3ntcThQoBVgWRgOGPcCdaVKq531X+p?=
 =?us-ascii?Q?lF3U4Z+BzivofGMoWdFKRG2dfrLvBDl+YxM0HTL5oYYe4Ws2u7h9r8jiklJC?=
 =?us-ascii?Q?MfOI85HaCYZ5uPcjNzgYq0LeeaW7weePeKkKkjrxEGTwHV5FOMMlKFA1O0Nj?=
 =?us-ascii?Q?Psq7c7omJBXA4UtSP5jv1xlNEKCmfbkdtfIpejjTSQAVhCKfTwYOMygqBkBq?=
 =?us-ascii?Q?zBeQp/TmLX+DwdKCFKlRhAW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e1b878-6ea2-4fc1-2258-08d947cb128d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 19:59:36.6570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVlVCRA28uM/DHR50f0qSGAHhVIrG3mRSUKYLOwWSBYtBKX627cMeDFCaZowOomsFj2GVifyfoyoUSSyhu2p4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 68 ++++++++++++++++++------
 2 files changed, 66 insertions(+), 15 deletions(-)

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
index 31f3f24cef6a..43b31f00951a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2581,9 +2581,46 @@ int svm_range_list_init(struct kfd_process *p)
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
+ * -EFAULT - if VM does not exist in specific pdd
+ */
+static int
+svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, uint64_t last)
+{
+	uint32_t i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct amdgpu_vm *vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
+
+		if (!vm)
+			return -EFAULT;
+
+		if (interval_tree_iter_first(&vm->va, start, last)) {
+			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
+			return -EADDRINUSE;
+		}
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
@@ -2592,28 +2629,27 @@ int svm_range_list_init(struct kfd_process *p)
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
@@ -2913,9 +2949,9 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 
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
@@ -3016,15 +3052,17 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
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
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
