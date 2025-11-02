Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A4FCCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 08:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA2E10E376;
	Mon,  3 Nov 2025 08:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FbgPNhGR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3D310E034
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Nov 2025 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762119498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=PsfZDWp7sm7GiaQ3mUuif11By27vnOTDqkh4M/9GDUg=;
 b=FbgPNhGRAOwyzqrXbno5az2ahc+PGiXzO1NG+iXx/wNjQZO2fMSPYkf/Ks5SYOgiowkeWK
 fOubSBujjS2k3jRAvAZ4Hd04RN64xABNxrh/tsux9U7DN23XwltBpdTix6F90UihwicpqM
 JZxNeDMTUGEYCOeevIDOXH6fGO4YX/c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-aS-Aswj2N6ujmVS3fwfQZA-1; Sun,
 02 Nov 2025 16:38:13 -0500
X-MC-Unique: aS-Aswj2N6ujmVS3fwfQZA-1
X-Mimecast-MFC-AGG-ID: aS-Aswj2N6ujmVS3fwfQZA_1762119492
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A78481956053; Sun,  2 Nov 2025 21:38:11 +0000 (UTC)
Received: from [10.45.225.163] (unknown [10.45.225.163])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53E4F19560A2; Sun,  2 Nov 2025 21:38:09 +0000 (UTC)
Date: Sun, 2 Nov 2025 22:38:00 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>
cc: amd-gfx@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH] fix AMDGPU failure with periodic signal
Message-ID: <28850059-0e96-929e-eafc-7e2ca86447b6@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bvm30dxFXN9VCyo62PFVDIFJ2VnNEiwqKGuCBK7MAF4_1762119492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Mon, 03 Nov 2025 08:02:50 +0000
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

Hi

I have a program that registers a periodic timer that sends SIGALRM with
1ms interval. If I compile a dummy OpenCL kernel while the signal is
triggered, I get these messages:

"amdgpu: init_user_pages: Failed to register MMU notifier: -4"

Apparently, there needs to be fatal_signal_pending.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 mm/vma.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/mm/vma.c
===================================================================
--- linux-2.6.orig/mm/vma.c	2025-10-13 21:42:48.000000000 +0200
+++ linux-2.6/mm/vma.c	2025-11-02 19:54:04.000000000 +0100
@@ -2156,7 +2156,7 @@ static void vm_lock_mapping(struct mm_st
  * mm_take_all_locks() and mm_drop_all_locks are expensive operations
  * that may have to take thousand of locks.
  *
- * mm_take_all_locks() can fail if it's interrupted by signals.
+ * mm_take_all_locks() can fail if it's interrupted by fatal signals.
  */
 int mm_take_all_locks(struct mm_struct *mm)
 {
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

