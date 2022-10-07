Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26F6C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 13:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E8710E1D6;
	Mon, 10 Oct 2022 13:14:20 +0000 (UTC)
X-Greylist: delayed 856 seconds by postgrey-1.36 at gabe;
 Sat, 08 Oct 2022 09:34:12 UTC
Received: from 186.whitelist.crbl.net (186.whitelist.crbl.net
 [162.243.126.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3086F10E0CB;
 Sat,  8 Oct 2022 09:34:12 +0000 (UTC)
Received: from ([60.208.111.195])
 by unicom146.biz-email.net ((D)) with ASMTP (SSL) id DLX00001;
 Sat, 08 Oct 2022 17:14:01 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.12; Sat, 8 Oct 2022 17:14:02 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <airlied@gmail.com>, <daniel@ffwll.ch>, <Felix.Kuehling@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdkfd: use vma_lookup() instead of find_vma()
Date: Thu, 6 Oct 2022 22:48:18 -0400
Message-ID: <20221007024818.4921-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.200.104.82]
tUid: 202210081714012c959af65021b156089005c68f8b32f8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Mailman-Approved-At: Mon, 10 Oct 2022 13:14:16 +0000
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
Cc: Deming Wang <wangdeming@inspur.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using vma_lookup() verifies the start address is contained in the found
vma.  This results in easier to read the code.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 64fdf63093a0..cabcc2ca3c23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1586,8 +1586,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		unsigned long npages;
 		bool readonly;
 
-		vma = find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start) {
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
 			r = -EFAULT;
 			goto unreserve_out;
 		}
@@ -2542,8 +2542,8 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	struct interval_tree_node *node;
 	unsigned long start_limit, end_limit;
 
-	vma = find_vma(p->mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+	vma = vma_lookup(p->mm, addr << PAGE_SHIFT);
+	if (!vma) {
 		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
 		return -EFAULT;
 	}
@@ -2871,8 +2871,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	/* __do_munmap removed VMA, return success as we are handling stale
 	 * retry fault.
 	 */
-	vma = find_vma(mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+	vma = vma_lookup(mm, addr << PAGE_SHIFT);
+	if (!vma) {
 		pr_debug("address 0x%llx VMA is removed\n", addr);
 		r = 0;
 		goto out_unlock_range;
-- 
2.27.0

