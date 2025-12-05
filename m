Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1AD2F7F2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3304010EB32;
	Fri,  5 Dec 2025 13:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="F4Gx2MyT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FDA10EB2F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ckn8sIUwsNZjA6D+X92cCWs5GUTH8Uh9FNEkrAinC0M=; b=F4Gx2MyTi50On0Iahk6HjjIYXf
 Eg0pOSoNsbCl8jvabqx3ftiZCqmCY2HoBy1F7SqbPPpM6ZSZYoZoz7wbTr6tXHX7zrVsgSKzh//tQ
 73mh9E/zkpX9SGQx3eEN9388nSezrJo/Y5ZOCe3FnJKCiwgUSDIIuzn8Rv5M4M75wp37rmYHZqOoy
 Ka/S6LeULrBSvu9DKgHoeHR1EH5D4uMTAbW7I/c1FGJWLfEhlF+Uznh1jzIJDIUUB+Xgr3ogA3Yt0
 4kF44IJa5ZcsKYILnocouGSiibO08C7ftcGdKUEBJQbwZg5lDjan8lXp6dUxqJkljBeKsnym8HF4Y
 XJFhAZ2w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW34-0095gS-53; Fri, 05 Dec 2025 14:40:38 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: [PATCH 01/12] drm/amdgpu/userq: Fix reference leak in
 amdgpu_userq_wait_ioctl
Date: Fri,  5 Dec 2025 13:40:24 +0000
Message-ID: <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
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

Drop reference to syncobj and timeline fence when aborting the ioctl due
output array being too small.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index eba9fb359047..13c5d4462be6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -865,6 +865,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_unwrap_for_each(f, &iter, fence) {
 					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 						r = -EINVAL;
+						dma_fence_put(fence);
 						goto free_fences;
 					}
 
@@ -889,6 +890,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 				r = -EINVAL;
+				dma_fence_put(fence);
 				goto free_fences;
 			}
 
-- 
2.51.1

