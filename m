Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D51C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D6722CAE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D6722CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D3F6E219;
	Fri,  4 Dec 2020 20:41:41 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09696E219
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 20:41:39 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id q7so3437095qvt.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Dec 2020 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x5Qgg5DGI99E9cvvbWPZAaxs0cxiSu7EjqNRUxLG0V8=;
 b=V634R8l+hIOn/Gn5ndnu0rz6Fa4OCz7Soi+Sd7ReW3pZBCFc8Cl+0J7G9fN5DCzqHA
 iPXT0QBvZBbopHDHvPr0Z9sqv4IHlO9VK42CQCFvXZa6bngMZikQlL6GQF6QsSs2fnkM
 kT04rClHTd4AdfVdpNP3QJhSTYmDz5shIeTBCO0pOvUfG3IricAOSeOgU1At85mW7spW
 U2iFfJwCotDqeCjaEXCTCq8ORHydU+ZRLyW8Kd92sJzsKQ/KeFmsV0RkVTlarcTAVpZi
 ove2oUUybokdSRkL65zAHJX9yTXZt5ZQ+2iLmoPWY+ZjcDOzJpgTCBB/z369U0o8Otqt
 FfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x5Qgg5DGI99E9cvvbWPZAaxs0cxiSu7EjqNRUxLG0V8=;
 b=D8DSDkimN3bj/laql7MseNmtKZENJSozFTP4Va41LYpY7t0cu1yY+o6vNp5gqVbs3X
 LfM1rwVYe+JWGk9E/+9E2h7EK7cHwAH0LmvXWxIn2ZTjnGHVg0mH8YH9S5Fq/0Inz5g5
 uPcXYVvj7OFOUOxyH/7ryRysptdAQ5RlcQkyYk4RxSt7t45zmimBpSwAiDt0afCmdPRC
 afkE9rg7F1unQzxmNHWuEeQyEp8ZBhSYuygPgh2QjkSH6IYW6yvZe7kyblvBgWAwy414
 bf3a0Wk7p+VFM4iwFBUFtlMl5j21yGHJkcoPxm9p0++iN4Q1XaCbrZbvPAZNihC3DPs0
 4Mig==
X-Gm-Message-State: AOAM531hYlWEdM6xZ4blonuTRS2l5pifaC8wXHLky3G199ufM3tLaHDT
 cx4ngXSOx5i/j7Cd3dhzQ2Cplsy3jlY=
X-Google-Smtp-Source: ABdhPJyHPCD3kYT3YDy6q1cQM5DxfTXrhXjGJBhRvbsCtDb55dvVRKu0GeFoNAAOWrUscpgyAocn2Q==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr7502830qvx.62.1607114498945;
 Fri, 04 Dec 2020 12:41:38 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o21sm6569685qko.9.2020.12.04.12.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 12:41:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: take runtime pm reference when we attach a buffer
Date: Fri,  4 Dec 2020 15:41:30 -0500
Message-Id: <20201204204130.3697-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And drop it when we detach.  If the shared buffer is in vram,
we need to make sure we don't put the device into runtime
suspend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 5b465ab774d1..f63f182f37f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -40,6 +40,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 /**
  * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
@@ -187,9 +188,13 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	if (attach->dev->driver == adev->dev->driver)
 		return 0;
 
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0)
+		goto out;
+
 	r = amdgpu_bo_reserve(bo, false);
 	if (unlikely(r != 0))
-		return r;
+		goto out;
 
 	/*
 	 * We only create shared fences for internal use, but importers
@@ -201,11 +206,15 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	 */
 	r = __dma_resv_make_exclusive(bo->tbo.base.resv);
 	if (r)
-		return r;
+		goto out;
 
 	bo->prime_shared_count++;
 	amdgpu_bo_unreserve(bo);
 	return 0;
+
+out:
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	return r;
 }
 
 /**
@@ -225,6 +234,9 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
 
 	if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
 		bo->prime_shared_count--;
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
 /**
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
