Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97138C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 08:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D782510E00C;
	Mon, 20 May 2024 08:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="L0g2zKx2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AC310E00C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o7jRn/Aode5YtnfF7X27HsWHISTZOs8ew8IAfVw0i9o=; b=L0g2zKx2mrfPx4SA/t3t2ZjgnI
 7gXioFcFBC/UMEbOrpOdfgJ8HoCkyVglhhUHqLvD9TN5zH5sNOU9ygpUrDBLM/kR/eiz8iEvqxovh
 vbToJhhiWI7kLcB6+FPtgQOh/jP77buz4oVCjYVrcy2+V3uibL4wRUVDDJNUEAR1NOIc3kvZfQ5st
 t2DDXe6C3XaonZJklRu5Q91UIr7k/Z0Y/LmO3gp1LrRz7vUOWrSUxhNy01E/4NdYacLuCXfW8rI/i
 SLuBGqVPfN/uZdLBrOvbkr2zXnongDrZGW/5zeeZecGhwR3W6re2wSZjomue/16sfDg80GbhTuh5c
 9gcYwOFw==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s8yDx-00AAa9-08; Mon, 20 May 2024 10:18:25 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix amdgpu_vm_is_bo_always_valid kerneldoc
Date: Mon, 20 May 2024 09:18:14 +0100
Message-ID: <20240520081814.8363-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
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

Align kerneldoc with the function argument name.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 26e20235ce00 ("drm/amdgpu: Add amdgpu_bo_is_vm_bo helper")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b9cca51356b1..3abfa66d72a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3008,7 +3008,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
  * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
  *
  * @vm: VM to test against.
- * @abo: BO to be tested.
+ * @bo: BO to be tested.
  *
  * Returns true if the BO shares the dma_resv object with the root PD and is
  * always guaranteed to be valid inside the VM.
-- 
2.44.0

