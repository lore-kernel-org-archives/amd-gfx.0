Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DF2EFB815
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CBF10E4DC;
	Tue, 24 Feb 2026 08:25:00 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9BB10E4DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:24:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 61O8OkJ14002340; Tue, 24 Feb 2026 13:54:46 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 61O8Ok834002339;
 Tue, 24 Feb 2026 13:54:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 4/4] drm/amdgpu: add upper bound check on user inputs in
 wait ioctl
Date: Tue, 24 Feb 2026 13:54:43 +0530
Message-Id: <20260224082443.4002292-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224082443.4002292-1-sunil.khatri@amd.com>
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
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

Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
could be exploited.

So check these input value against AMDGPU_USERQ_MAX_HANDLES
which is big enough value for genuine use cases and could
potentially avoid OOM.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 4f9386677c47..c2435ddfbd49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -636,6 +636,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
 
+	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info->syncobj_timeline_points > AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
 	num_syncobj = wait_info->num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
 					    num_syncobj, sizeof(u32));
-- 
2.34.1

