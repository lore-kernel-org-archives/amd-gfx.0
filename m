Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D746EE57E5
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Dec 2025 08:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651D910E9A0;
	Wed, 31 Dec 2025 08:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=inria.fr header.i=@inria.fr header.b="C40NU8gA";
	dkim-atps=neutral
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B928510E241;
 Tue, 30 Dec 2025 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6dWzj7sv8HrEjyebUNfSk2ME+IZ6ovwMP1uwx2K0bio=;
 b=C40NU8gAok7TrE7L3hoqM0nBu2Ll8eGa1cElerUIUnHqyRkP+94+RtPc
 KjopT1dOJHLvSyvGpjOgbz9KOjiprCyKko42nIqD39HjC/YYoOKEIYRQX
 E7wUZing3UgrM3wZEN7M7q5MXXmx1FnIyuvoZIVAcmwb/w9rmoEyQrPOo o=;
X-CSE-ConnectionGUID: bO0t530fSVGx2p8A+D1iLw==
X-CSE-MsgGUID: w0eSi0QASMi6Tl8Gdn0uFw==
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; d="scan'208";a="134761890"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 18:53:58 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
 xutong.ma@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: update outdated comment
Date: Tue, 30 Dec 2025 18:53:53 +0100
Message-Id: <20251230175353.105289-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Dec 2025 08:57:58 +0000
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

The function amdgpu_amdkfd_gpuvm_import_dmabuf() was split into
import_obj_create() and amdgpu_amdkfd_gpuvm_import_dmabuf_fd() in
commit 0188006d7c79 ("drm/amdkfd: Import DMABufs for interop
through DRM").  import_obj_create() now does the allocation for
the mem variable discussed in the comment.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b1c24c8fa686..4782265d5e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1987,7 +1987,8 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	drm_gem_object_put(&mem->bo->tbo.base);
 
 	/*
-	 * For kgd_mem allocated in amdgpu_amdkfd_gpuvm_import_dmabuf(),
+	 * For kgd_mem allocated in import_obj_create() via
+	 * amdgpu_amdkfd_gpuvm_import_dmabuf_fd(),
 	 * explicitly free it here.
 	 */
 	if (!use_release_notifier)

