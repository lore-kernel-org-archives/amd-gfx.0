Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4690FCAC58C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021B210E889;
	Wed, 10 Sep 2025 08:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="OZr/evQk";
	dkim-atps=neutral
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B072E10E285
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 21:32:54 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1757367173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TGwfNfXsEJt+uuuZOEIftwyyKCix/PrVNO8dS5i6p/8=;
 b=OZr/evQkrPMn26+Eu82p/06rJXNr1j9LyyGeiZYEqKtLkOiPaRfk6DOAHwDSbzqyHll1XT
 WyiuSsWs6Vgp6IV67vr0Psv8x6d/mH3T06524oV4LlVWDcVEnWDfNbsos6hKuOXEh5eQ8q
 5IcS3SL3xSvjV7rdZzSeAvuxOo0fJww=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Replace kzalloc + copy_from_user with memdup_user
Date: Mon,  8 Sep 2025 23:31:56 +0200
Message-ID: <20250908213156.565861-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 10 Sep 2025 08:01:12 +0000
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

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify kfd_ioctl_set_cu_mask().

Return early if an error occurs and remove the obsolete 'out' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..5d58a7bf309a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -521,15 +521,10 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 		cu_mask_size = sizeof(uint32_t) * (max_num_cus/32);
 	}
 
-	minfo.cu_mask.ptr = kzalloc(cu_mask_size, GFP_KERNEL);
-	if (!minfo.cu_mask.ptr)
-		return -ENOMEM;
-
-	retval = copy_from_user(minfo.cu_mask.ptr, cu_mask_ptr, cu_mask_size);
-	if (retval) {
+	minfo.cu_mask.ptr = memdup_user(cu_mask_ptr, cu_mask_size);
+	if (IS_ERR(minfo.cu_mask.ptr)) {
 		pr_debug("Could not copy CU mask from userspace");
-		retval = -EFAULT;
-		goto out;
+		return PTR_ERR(minfo.cu_mask.ptr);
 	}
 
 	mutex_lock(&p->mutex);
@@ -538,7 +533,6 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 
 	mutex_unlock(&p->mutex);
 
-out:
 	kfree(minfo.cu_mask.ptr);
 	return retval;
 }
-- 
2.51.0

