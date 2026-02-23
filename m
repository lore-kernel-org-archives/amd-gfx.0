Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97471EA4FAE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F3F10E39C;
	Mon, 23 Feb 2026 12:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RVLlK+FU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F85F10E39C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eVmCekjPBgHEFAVxRcyW3jy+HaYB2F0nv5nwT9lu+Bs=; b=RVLlK+FUOdPtbpvLwekvpxPClq
 oPV1ZC5/UFqI5IZGWEwODJ3enu/C5urSqo9/7mOnwbDXCoriouFNk7BCvnsmYGhzGrzLwThRv8iSc
 bwNSL4Mn55xQtQ3MfYxn5u89LscEepJP7MHOjvVk91JsKfq3jwWDzv246adZN8c2HS436lcDEPCib
 y144JqYxdhpBmmWeFrU6je6Z6E5Skt2gH9Aut2+WaM27QV6MOxsZ2pndPQpXVQx7ce+cr1bcaBeIj
 4sIP1tKwVdz/FxT9NLIbXd3pHuCerm8TolCTV5s8TWrxR95JvbKU8FoS0GMDbf04/NTYaGnFj75vL
 Cm2+P7Rg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVFz-004EK9-LT; Mon, 23 Feb 2026 13:41:47 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: [PATCH v2 01/12] drm/amdgpu/userq: Fix reference leak in
 amdgpu_userq_wait_ioctl
Date: Mon, 23 Feb 2026 12:41:30 +0000
Message-ID: <20260223124141.10641-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
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
index 8013260e29dc..9b9947b94b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -876,6 +876,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_unwrap_for_each(f, &iter, fence) {
 					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 						r = -EINVAL;
+						dma_fence_put(fence);
 						goto free_fences;
 					}
 
@@ -900,6 +901,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 				r = -EINVAL;
+				dma_fence_put(fence);
 				goto free_fences;
 			}
 
-- 
2.52.0

