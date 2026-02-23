Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C8EA4FBC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB3610E396;
	Mon, 23 Feb 2026 12:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TtXyugoP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0280610E38E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uB7oB2Sdfoqaw+hs8qEkAmj68XvFZbB16H6RbDXzFbE=; b=TtXyugoPpc3o0AjJ4+98iD62Gc
 6w8JLkyVrZgFWa4gQawJF5ICLXguMzb5yZD+tBGjzBw4MuGf82ExXuMRt/ZiIEjIH9/uUTeshjpH6
 MMd2KxpzVtkIt6bj2q1N+uhJXVQpZc/7ZQdz4vixC0C+SJtrM5zTJ4jGuaw80/xksc3KwD/rp5oKe
 exkUtVk13albBpFV+uNh0V8hw7tmt6LfjmRB7m8H/60OOGhria/lQCOYNSOFBrfxJ8Q1kXxF6KWlG
 TAknQuyI790HujQnb3SRHK+l2gHCS44SoLG3BHQri4m/CQLySzg1OhxX+FLRCA/nA7vGmZfNMa0Ta
 1SrzZCRA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG3-004EKc-9M; Mon, 23 Feb 2026 13:41:51 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 06/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_wait_ioctl
Date: Mon, 23 Feb 2026 12:41:35 +0000
Message-ID: <20260223124141.10641-7-tvrtko.ursulin@igalia.com>
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

Use the existing helper instead of multiplying the size.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index d779671bd0db..63d1b6364e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -629,21 +629,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	num_syncobj = wait_info->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj));
+	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
+					    num_syncobj, sizeof(u32));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
 	num_points = wait_info->num_syncobj_timeline_handles;
-	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
-				       sizeof(u32) * num_points);
+	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
+					     num_points, sizeof(u32));
 	if (IS_ERR(timeline_handles)) {
 		r = PTR_ERR(timeline_handles);
 		goto free_syncobj_handles;
 	}
 
-	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
-				      sizeof(u32) * num_points);
+	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
+					    num_points, sizeof(u32));
 	if (IS_ERR(timeline_points)) {
 		r = PTR_ERR(timeline_points);
 		goto free_timeline_handles;
-- 
2.52.0

