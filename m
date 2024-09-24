Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A8FCF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 09:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA88A10E69C;
	Tue, 24 Sep 2024 09:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pBJ4qaUp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F51510E69C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zi6Jp4io0dLbFj4uIyJ+NEKh9UPtdn2vJ0fWBJAJKfc=; b=pBJ4qaUpUHmI1Hqfe/q13CNcKf
 cnjalYDvRY3vjBFzsC8JF98Qk8EFGpBsq1PhRTgA3vIq9439rnN2G3zWWH44tdTp0lHHJ6JBXpx7L
 NrLr52Ob6yVPabeSXCmVydamoi5O494fO5EOanOnuzc8D01EVpzCtVG+WjW5fsiYaC1Dv3MW4i6Ny
 WcCw/SYmsdL70bAsOwqxTf01811ffetmiKQD765h/Fyzu+uLr0Y4G58yUmyX+mjr9rpI+KtA+xBTy
 9qRR9WXsXF19U0lc4eJ3xHsGB5JdmfrYrOujVQgmFrzTwLQeLghaRLgixuNvvhyxied2RMP2rzi7B
 zVS7OO+w==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1st2D4-000KQY-0E; Tue, 24 Sep 2024 11:51:54 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Drop unused fence argument from
 amdgpu_vmid_grab_used
Date: Tue, 24 Sep 2024 10:51:43 +0100
Message-ID: <20240924095145.2281-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Fence argument is unused so lets drop it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 92d27d32de41..8e712a11aba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -342,15 +342,13 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
  * @ring: ring we want to submit job to
  * @job: job who wants to use the VMID
  * @id: resulting VMID
- * @fence: fence to wait for if no id could be grabbed
  *
  * Try to reuse a VMID for this submission.
  */
 static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 				 struct amdgpu_ring *ring,
 				 struct amdgpu_job *job,
-				 struct amdgpu_vmid **id,
-				 struct dma_fence **fence)
+				 struct amdgpu_vmid **id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->vm_hub;
@@ -429,7 +427,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		if (r || !id)
 			goto error;
 	} else {
-		r = amdgpu_vmid_grab_used(vm, ring, job, &id, fence);
+		r = amdgpu_vmid_grab_used(vm, ring, job, &id);
 		if (r)
 			goto error;
 
-- 
2.46.0

