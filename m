Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C66CEA4FBB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FE610E395;
	Mon, 23 Feb 2026 12:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kEzbUKKU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E58F10E396
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lto1y/7Ka51jyO3ALQ9T6U+NqF6pcUrEleJrSMmWjzA=; b=kEzbUKKUkVvgrjsoovay1VrntF
 NT207GhOaB7GhXTPjudDdef8A+wwII8VE+PR9fqSxpmJjX83N8BrpW7WSFrl2WrBwU7EZU1+WioYS
 8iyjj76cY7cOIDCOBoCfffAk8qzjko/3mAULL+zS9ndAcG7p7+4AaSjXfvygnwvwMIZABzSqHWNMr
 pXDnYfqs2gZeQG8ZHwO/4ANK+rNa1Td8mNuVqPdUZT8290rJr/rzjdMuEQM2+bx0zKUWF38M3MP9V
 oueh2Gy/OmelUNCRpuWzJ4NTdHzedqsbg6Ltqt/jnd3k0/PJggFjPeYEgqDtk470WGCAcISJQxF+2
 ASTRBa7A==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG0-004EKD-Ct; Mon, 23 Feb 2026 13:41:48 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 02/12] drm/amdgpu/userq: Do not allow userspace to
 trivially triger kernel warnings
Date: Mon, 23 Feb 2026 12:41:31 +0000
Message-ID: <20260223124141.10641-3-tvrtko.ursulin@igalia.com>
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

Userspace can either deliberately pass in the too small num_fences, or the
required number can legitimately grow between the two calls to the userq
wait ioctl. In both cases we do not want the emit the kernel warning
backtrace since nothing is wrong with the kernel and userspace will simply
get an errno reported back. So lets simply drop the WARN_ONs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 9b9947b94b89..d972dc46f5a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -833,7 +833,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
 						DMA_RESV_USAGE_READ, fence) {
-				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+				if (num_fences >= wait_info->num_fences) {
 					r = -EINVAL;
 					goto free_fences;
 				}
@@ -850,7 +850,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
 						DMA_RESV_USAGE_WRITE, fence) {
-				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+				if (num_fences >= wait_info->num_fences) {
 					r = -EINVAL;
 					goto free_fences;
 				}
@@ -874,7 +874,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 					goto free_fences;
 
 				dma_fence_unwrap_for_each(f, &iter, fence) {
-					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					if (num_fences >= wait_info->num_fences) {
 						r = -EINVAL;
 						dma_fence_put(fence);
 						goto free_fences;
@@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			if (r)
 				goto free_fences;
 
-			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+			if (num_fences >= wait_info->num_fences) {
 				r = -EINVAL;
 				dma_fence_put(fence);
 				goto free_fences;
-- 
2.52.0

