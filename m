Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD7ACCFA1A
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Nov 2025 09:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7345210E351;
	Sat,  8 Nov 2025 09:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JChn/KmQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA1210EB5C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762537694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=OtB+sZpQawht6Y2wkMhn/jRh99U8DiHTZvyeB15mQow=;
 b=JChn/KmQoPXvc9upZrr035/hg2QLczAm+I5z5tBkAnnPzHpgAY93KFBuFbw+1I2P5tXK55
 wKywTQDtqBhXpYwjJfss6glMKQtbW6VRWGE5hhyAjb8PqhkdlMq3wG0ECYhozpcQ5aIhDz
 e7IQ+BJXUuhrBYMPhGNuPc47naKdpn4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-pyVrMrA2OsmnKgqooUZhkg-1; Fri,
 07 Nov 2025 12:48:10 -0500
X-MC-Unique: pyVrMrA2OsmnKgqooUZhkg-1
X-Mimecast-MFC-AGG-ID: pyVrMrA2OsmnKgqooUZhkg_1762537689
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AB36195605B; Fri,  7 Nov 2025 17:48:09 +0000 (UTC)
Received: from [10.45.225.163] (unknown [10.45.225.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0671196B8FC; Fri,  7 Nov 2025 17:48:06 +0000 (UTC)
Date: Fri, 7 Nov 2025 18:48:01 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>
cc: amd-gfx@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH v2] fix AMDGPU failure with periodic signal
Message-ID: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X6UEvPuyTl-ZdptgIe88_I-vm2Kicf9Y38GjkP9lziE_1762537689
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Sat, 08 Nov 2025 09:39:37 +0000
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

If a process sets up a timer that periodically sends a signal in short
intervals and if it uses OpenCL on AMDGPU at the same time, we get random
errors. Sometimes, probing the OpenCL device fails (strace shows that
open("/dev/kfd") failed with -EINTR). Sometimes we get the message
"amdgpu: init_user_pages: Failed to register MMU notifier: -4" in the
syslog.

The bug can be reproduced with this program:
http://www.jikos.cz/~mikulas/testcases/opencl/opencl-bug-small.c

The root cause for these failures is in the function mm_take_all_locks.
This function fails with -EINTR if there is pending signal. The -EINTR is
propagated up the call stack to userspace and userspace fails if it gets
this error.

There is the following call chain: kfd_open -> kfd_create_process ->
create_process -> mmu_notifier_get -> mmu_notifier_get_locked ->
__mmu_notifier_register -> mm_take_all_locks -> "return -EINTR"

If the failure happens in init_user_pages, there is the following call
chain: init_user_pages -> amdgpu_hmm_register ->
mmu_interval_notifier_insert -> mmu_notifier_register ->
__mmu_notifier_register -> mm_take_all_locks -> "return -EINTR"

In order to fix these failures, this commit changes
signal_pending(current) to fatal_signal_pending(current) in
mm_take_all_locks, so that it is interrupted only if the signal is
actually killing the process.

Also, this commit skips pr_err in init_user_pages if the process is being
killed - in this situation, there was no error and so we don't want to
report it in the syslog.

I'm submitting this patch for the stable kernels, because this bug may
cause random failures in any OpenCL code.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    9 +++++++--
 mm/vma.c                                         |    8 ++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-6.17.7/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
===================================================================
--- linux-6.17.7.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ linux-6.17.7/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1069,8 +1069,13 @@ static int init_user_pages(struct kgd_me
 
 	ret = amdgpu_hmm_register(bo, user_addr);
 	if (ret) {
-		pr_err("%s: Failed to register MMU notifier: %d\n",
-		       __func__, ret);
+		/*
+		 * If we got EINTR because the process was killed, don't report
+		 * it, because no error happened.
+		 */
+		if (!(fatal_signal_pending(current) && ret == -EINTR))
+			pr_err("%s: Failed to register MMU notifier: %d\n",
+			       __func__, ret);
 		goto out;
 	}
 
Index: linux-6.17.7/mm/vma.c
===================================================================
--- linux-6.17.7.orig/mm/vma.c
+++ linux-6.17.7/mm/vma.c
@@ -2175,14 +2175,14 @@ int mm_take_all_locks(struct mm_struct *
 	 * is reached.
 	 */
 	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			goto out_unlock;
 		vma_start_write(vma);
 	}
 
 	vma_iter_init(&vmi, mm, 0);
 	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
 				is_vm_hugetlb_page(vma))
@@ -2191,7 +2191,7 @@ int mm_take_all_locks(struct mm_struct *
 
 	vma_iter_init(&vmi, mm, 0);
 	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
 				!is_vm_hugetlb_page(vma))
@@ -2200,7 +2200,7 @@ int mm_take_all_locks(struct mm_struct *
 
 	vma_iter_init(&vmi, mm, 0);
 	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)

