Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF648EA4FB8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A241E10E392;
	Mon, 23 Feb 2026 12:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oEAQi4+7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B637210E398
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oLO5nyaanKpxm4D3WJ4fBZkZK154opmOabNtViwFTV0=; b=oEAQi4+7d61/sc0W8dPFpFyLI5
 +TI1luVGI0Gk6ko9Yx+UZDLOc4EMuh7Fc6txaAAOaTr9F/MACHD9/OFQIi3J31Y4t58kCXGUJjJA3
 G8/j5Vlio9+DqUOB1KmjYj7iXzxPkzpj6JCdGoyfP2XHvKgjb8aREIMZuw9XQIyPs3E7vynh7f7ns
 kdDH8TwINkUoiVOIevNJGfdgz96AIzxq3kPw45B5qQobeJbDeYVJmN5yms3c3wfDXCuS6wy8q78xs
 xR7z4OecPV7hqm4802UuEsvpqV7OG8la9HP/TCMkVFxjS+k0Hqk9XgKrYN/wmdG3Fq+ic34nDZFxq
 TH3A/xmg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG3-004EKm-WC; Mon, 23 Feb 2026 13:41:52 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 07/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_signal_ioctl
Date: Mon, 23 Feb 2026 12:41:36 +0000
Message-ID: <20260223124141.10641-8-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 63d1b6364e96..47b75cd2fcfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -478,8 +478,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	num_syncobj_handles = args->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj_handles));
+	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
+					    num_syncobj_handles, sizeof(u32));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
-- 
2.52.0

