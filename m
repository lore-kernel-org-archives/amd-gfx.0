Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14229C67861
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 11:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07D610E227;
	Mon,  9 Jun 2025 11:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NGRlFpuo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D5D10E20B;
 Mon,  9 Jun 2025 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9ThZwvQZ6X5Bup/BnurWEMmOOJwuE+DHeogEQQN+zGA=; b=NGRlFpuoJO67hIAC3SHjlwPwFJ
 sopgVCPaslI2Q16hb3VZVhe4KGIQR170Acu1IIAg8Ie7jOHIrs8t66M/J2PWxaRHwOvAtBT2fFa1O
 LrkfCmnU1uuLBm/oVcwDNXg6p5IhkQlyPaaNEiPqfvSSAwSHR9/Y7Gvzd7wkc8u7OVQ2XS1+vSu74
 gDGO7mOMhEoQilNvztQOYu3dFLZvvYtw1ZrG+HiCg3op6w24OXloFDAKsvQm9y4RAEJVdi8oFuLTl
 zk2bNMnp3B0MPUKXAYVQ8pozlzO/196RkYqxcA3I2lPZoky0ywxueOlhqeildXr91pGgwKdESbGji
 5vZk1b2g==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uOakt-001Odi-TW; Mon, 09 Jun 2025 13:33:31 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 4/7] drm/syncobj: Use put_user in drm_syncobj_query_ioctl
Date: Mon,  9 Jun 2025 12:33:10 +0100
Message-ID: <20250609113313.75395-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250609113313.75395-1-tvrtko.ursulin@igalia.com>
References: <20250609113313.75395-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since the query loop is using copy_to_user() to write out a single u64 at
a time it feels more natural (and is a tiny bit more compact) to replace
it with put_user().

Access_ok() check is added to the input checking for an early bailout in
case of a bad buffer passed in.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_syncobj.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 03580cc246dd..ffd2df6bcb3e 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1668,6 +1668,9 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 	if (args->count_handles == 0)
 		return -EINVAL;
 
+	if (!access_ok(points, args->count_handles * sizeof(*points)))
+		return -EFAULT;
+
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
@@ -1709,10 +1712,10 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			point = 0;
 		}
 		dma_fence_put(fence);
-		ret = copy_to_user(&points[i], &point, sizeof(uint64_t));
-		ret = ret ? -EFAULT : 0;
-		if (ret)
+		if (__put_user(point, points++)) {
+			ret = -EFAULT;
 			break;
+		}
 	}
 	drm_syncobj_array_free(syncobjs, args->count_handles);
 
-- 
2.48.0

