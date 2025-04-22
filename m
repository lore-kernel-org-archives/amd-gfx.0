Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376EDC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 08:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA2D10E523;
	Tue, 22 Apr 2025 08:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLWHP5Nv";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7AD10E4FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 06:31:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 57255A4BBB3;
 Tue, 22 Apr 2025 06:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35F1C4CEE9;
 Tue, 22 Apr 2025 06:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1745303468;
 bh=NTj4NJqYSupaKoPMbk0RtczS9wWj3svkFjpNxd6UNKE=;
 h=Subject:To:Cc:From:Date:From;
 b=NLWHP5NvxMa8CKEYIOca2haZn6gWGLxFDK2dU3OX6ubjbPaytfEHMMcJFcw3Iu6hO
 RpBWKQv9GhRo1VxfUrIwE7DSRM7pk4TFWi4OgntIoRsG0EqHfvl7AEX8iKAUbOtugP
 Z/0ARTkjV77heZJdo94K/cvQsWm8/uF2tJou/12Y=
Subject: Patch "drm/amdgpu/dma_buf: fix page_link check" has been added to the
 6.14-stable tree
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, gregkh@linuxfoundation.org, matthew.auld@intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:30:32 +0200
Message-ID: <2025042232-buffalo-cultural-01b4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Tue, 22 Apr 2025 08:15:48 +0000
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


This is a note to let you know that I've just added the patch titled

    drm/amdgpu/dma_buf: fix page_link check

to the 6.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdgpu-dma_buf-fix-page_link-check.patch
and it can be found in the queue-6.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c0dd8a9253fadfb8e5357217d085f1989da4ef0a Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Mon, 7 Apr 2025 15:18:25 +0100
Subject: drm/amdgpu/dma_buf: fix page_link check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

commit c0dd8a9253fadfb8e5357217d085f1989da4ef0a upstream.

The page_link lower bits of the first sg could contain something like
SG_END, if we are mapping a single VRAM page or contiguous blob which
fits into one sg entry. Rather pull out the struct page, and use that in
our check to know if we mapped struct pages vs VRAM.

Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);


Patches currently in stable-queue which might be from matthew.auld@intel.com are

queue-6.14/drm-xe-dma_buf-stop-relying-on-placement-in-unmap.patch
queue-6.14/drm-xe-use-local-fence-in-error-path-of-xe_migrate_clear.patch
queue-6.14/drm-amdgpu-dma_buf-fix-page_link-check.patch
queue-6.14/drm-xe-userptr-fix-notifier-vs-folio-deadlock.patch
