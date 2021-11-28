Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE4CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 08:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEF76E2E1;
	Mon, 29 Nov 2021 08:12:21 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7566E558
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Nov 2021 16:46:00 +0000 (UTC)
Received: from pop-os.home ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id rNJMmflft2lVYrNJNmrScH; Sun, 28 Nov 2021 17:45:58 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 28 Nov 2021 17:45:58 +0100
X-ME-IP: 86.243.171.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH 1/2] drm/amdkfd: Use bitmap_zalloc() when applicable
Date: Sun, 28 Nov 2021 17:45:55 +0100
Message-Id: <f12820f6c5fca9b10ac8f82b3689c50ccb6966aa.1638117878.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
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

'kfd->gtt_sa_bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify
code, improve the semantic and avoid some open-coded arithmetic in
allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e1294fba0c26..c5a0ce44a295 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1252,8 +1252,6 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size)
 {
-	unsigned int num_of_longs;
-
 	if (WARN_ON(buf_size < chunk_size))
 		return -EINVAL;
 	if (WARN_ON(buf_size == 0))
@@ -1264,11 +1262,8 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 	kfd->gtt_sa_chunk_size = chunk_size;
 	kfd->gtt_sa_num_of_chunks = buf_size / chunk_size;
 
-	num_of_longs = (kfd->gtt_sa_num_of_chunks + BITS_PER_LONG - 1) /
-		BITS_PER_LONG;
-
-	kfd->gtt_sa_bitmap = kcalloc(num_of_longs, sizeof(long), GFP_KERNEL);
-
+	kfd->gtt_sa_bitmap = bitmap_zalloc(kfd->gtt_sa_num_of_chunks,
+					   GFP_KERNEL);
 	if (!kfd->gtt_sa_bitmap)
 		return -ENOMEM;
 
@@ -1278,13 +1273,12 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 	mutex_init(&kfd->gtt_sa_lock);
 
 	return 0;
-
 }
 
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd)
 {
 	mutex_destroy(&kfd->gtt_sa_lock);
-	kfree(kfd->gtt_sa_bitmap);
+	bitmap_free(kfd->gtt_sa_bitmap);
 }
 
 static inline uint64_t kfd_gtt_sa_calc_gpu_addr(uint64_t start_addr,
-- 
2.30.2

