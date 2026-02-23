Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DAFEA4FBA
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A6B10E38E;
	Mon, 23 Feb 2026 12:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZGdEI2Mw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBDD10E38E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YM5UbjJhmWzlNNLm5KmiL6rKDrQr/1+gT5KhfvFhvhA=; b=ZGdEI2Mw/002XvINH5StT6PcxQ
 OGLIm/kwi+7lx8feh8gYrSYursAz+B4ZX1fH0H4LfK6e89L51mSS/NyJg6P99mIXge86DNnLDQcSq
 LhPm9XEvEAyB48qXgVtKKdyS3m70HRg6ZLvtBwfdiFxbYtN2zDmqyICeI+rW6ydTFP3KIrs0ZsPEw
 Z7o1WIga3RzHFDMFY+BGmH8FPS+pWGnyftqmD1u11rWlz6sMQN0Q2Ucs9k4tdOzol0pYKXrXP9jwK
 sZ5QJ9pVqwq6zH5ciIUf5abjcTvQMwrrBKBaNtTdbJNhoVpcor13qNHCWgalIxxzS9K2zqZ1acNX1
 OH85OTGw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG6-004ELF-Rg; Mon, 23 Feb 2026 13:41:54 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 11/12] drm/amdgpu/userq: Stop looking after finding
 ourselves
Date: Mon, 23 Feb 2026 12:41:40 +0000
Message-ID: <20260223124141.10641-12-tvrtko.ursulin@igalia.com>
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

When amdgpu_userq_fence_driver_destroy walks the xarray of registered
fence drivers in order to remove itself from it, it can stop iterating
once it has found itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 69451d0acbbe..1328fd87c10e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -202,8 +202,10 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 
 	xa_lock_irqsave(xa, flags);
 	xa_for_each(xa, index, xa_fence_drv)
-		if (xa_fence_drv == fence_drv)
+		if (xa_fence_drv == fence_drv) {
 			__xa_erase(xa, index);
+			break;
+		}
 	xa_unlock_irqrestore(xa, flags);
 
 	/* Free seq64 memory */
-- 
2.52.0

