Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757FCEFB819
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 09:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4A210E524;
	Tue, 24 Feb 2026 09:11:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E78410E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 09:11:29 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 61O9BMDv4017827; Tue, 24 Feb 2026 14:41:22 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 61O9BM5f4017826;
 Tue, 24 Feb 2026 14:41:22 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v5 3/4] drm/amdgpu: add upper bound check on user inputs in
 signal ioctl
Date: Tue, 24 Feb 2026 14:41:17 +0530
Message-Id: <20260224091118.4017760-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224091118.4017760-1-sunil.khatri@amd.com>
References: <20260224091118.4017760-1-sunil.khatri@amd.com>
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

Huge input values in amdgpu_userq_signal_ioctl can lead to a OOM and
could be exploited.

So check these input value against AMDGPU_USERQ_MAX_HANDLES
which is big enough value for genuine use cases and could
potentially avoid OOM.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 42b548c8a86e..4f9386677c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -35,6 +35,8 @@
 static const struct dma_fence_ops amdgpu_userq_fence_ops;
 static struct kmem_cache *amdgpu_userq_fence_slab;
 
+#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
+
 int amdgpu_userq_fence_slab_init(void)
 {
 	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
@@ -478,6 +480,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
 
+	if (args->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	    args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
 					    num_syncobj_handles, sizeof(u32));
-- 
2.34.1

