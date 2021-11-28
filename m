Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB5FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 08:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB0F6E1E6;
	Mon, 29 Nov 2021 08:12:21 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DDB6EAAE
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Nov 2021 16:46:18 +0000 (UTC)
Received: from pop-os.home ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id rNJgmflov2lVYrNJhmrSfR; Sun, 28 Nov 2021 17:46:17 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 28 Nov 2021 17:46:17 +0100
X-ME-IP: 86.243.171.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH 2/2] drm/amdkfd: Use non-atomic bitmap functions when possible
Date: Sun, 28 Nov 2021 17:46:15 +0100
Message-Id: <d18382516544c0a8c0b8e563087cb6a8b2893078.1638117878.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f12820f6c5fca9b10ac8f82b3689c50ccb6966aa.1638117878.git.christophe.jaillet@wanadoo.fr>
References: <f12820f6c5fca9b10ac8f82b3689c50ccb6966aa.1638117878.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Nov 2021 08:12:20 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All uses of the 'kfd->gtt_sa_bitmap' bitmap are protected with the
'kfd->gtt_sa_lock' mutex.

So:
   - prefer the non-atomic '__set_bit()' function
   - use the non-atomic 'bitmap_[set|clear]()' functions instead of
     equivalent 'for' loops. These functions can work on several bits at a
     time

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c5a0ce44a295..c4d868a5dd97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1346,7 +1346,7 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 	/* If we need only one chunk, mark it as allocated and get out */
 	if (size <= kfd->gtt_sa_chunk_size) {
 		pr_debug("Single bit\n");
-		set_bit(found, kfd->gtt_sa_bitmap);
+		__set_bit(found, kfd->gtt_sa_bitmap);
 		goto kfd_gtt_out;
 	}
 
@@ -1384,10 +1384,8 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 		(*mem_obj)->range_start, (*mem_obj)->range_end);
 
 	/* Mark the chunks as allocated */
-	for (found = (*mem_obj)->range_start;
-		found <= (*mem_obj)->range_end;
-		found++)
-		set_bit(found, kfd->gtt_sa_bitmap);
+	bitmap_set(kfd->gtt_sa_bitmap, (*mem_obj)->range_start,
+		   (*mem_obj)->range_end - (*mem_obj)->range_start + 1);
 
 kfd_gtt_out:
 	mutex_unlock(&kfd->gtt_sa_lock);
@@ -1402,8 +1400,6 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 
 int kfd_gtt_sa_free(struct kfd_dev *kfd, struct kfd_mem_obj *mem_obj)
 {
-	unsigned int bit;
-
 	/* Act like kfree when trying to free a NULL object */
 	if (!mem_obj)
 		return 0;
@@ -1414,10 +1410,8 @@ int kfd_gtt_sa_free(struct kfd_dev *kfd, struct kfd_mem_obj *mem_obj)
 	mutex_lock(&kfd->gtt_sa_lock);
 
 	/* Mark the chunks as free */
-	for (bit = mem_obj->range_start;
-		bit <= mem_obj->range_end;
-		bit++)
-		clear_bit(bit, kfd->gtt_sa_bitmap);
+	bitmap_clear(kfd->gtt_sa_bitmap, mem_obj->range_start,
+		     mem_obj->range_end - mem_obj->range_start + 1);
 
 	mutex_unlock(&kfd->gtt_sa_lock);
 
-- 
2.30.2

