Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAC2EA4FB8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABFA10E39A;
	Mon, 23 Feb 2026 12:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Us6Z4/82";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA44B10E39B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DobEj8H6FrpxzY2uyabfD2lQT6+7tXEjEIXWtbNtJlQ=; b=Us6Z4/82TJSqnqZRS1vdCK2H/K
 z+Vdrq1lX6dPnoFwcF64vfeq3q43q8PNB6j8+6K58Fzna7zKvE1vbw63KJSEcVv9HfiPT6LQwh1mB
 BD7QVapYoEc7G0COrXFQSDSt7ExtUF3b5r4EbSs27ZM9mGKCUXB1GE3nyyMh3RQqUgYiLhhbvgQRN
 t32qAMsfFjKCD/AcUQExbQt1LLDGOqkX9ImSAsg2DNwsFTl+rVQLIZ2/nMDmYow+nHeveAVrI6yUk
 bp6W/zaFY9VWvQVtjP1b/ySU/oPVnXdx6p5jOVfPyyaxByhKVtQyiTfpGS/HypQBptXy2WizGpGhG
 /hOJy97Q==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG1-004EKH-3p; Mon, 23 Feb 2026 13:41:49 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 03/12] drm/amdgpu/userq: Consolidate wait ioctl exit path
Date: Mon, 23 Feb 2026 12:41:32 +0000
Message-ID: <20260223124141.10641-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If we gate the fence destruction with a check telling us whether there are
valid pointers in there we can eliminate the need for dual, basically
identical, exit paths.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index d972dc46f5a8..67911e6c552f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -971,32 +971,14 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			r = -EFAULT;
 			goto free_fences;
 		}
-
-		kfree(fences);
-		kfree(fence_info);
 	}
 
-	drm_exec_fini(&exec);
-	for (i = 0; i < num_read_bo_handles; i++)
-		drm_gem_object_put(gobj_read[i]);
-	kfree(gobj_read);
-
-	for (i = 0; i < num_write_bo_handles; i++)
-		drm_gem_object_put(gobj_write[i]);
-	kfree(gobj_write);
-
-	kfree(timeline_points);
-	kfree(timeline_handles);
-	kfree(syncobj_handles);
-	kfree(bo_handles_write);
-	kfree(bo_handles_read);
-
-	return 0;
-
 free_fences:
-	while (num_fences-- > 0)
-		dma_fence_put(fences[num_fences]);
-	kfree(fences);
+	if (fences) {
+		while (num_fences-- > 0)
+			dma_fence_put(fences[num_fences]);
+		kfree(fences);
+	}
 free_fence_info:
 	kfree(fence_info);
 exec_fini:
-- 
2.52.0

