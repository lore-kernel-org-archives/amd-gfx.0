Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCB3C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2379710E6E9;
	Tue,  8 Sep 2026 18:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mxVtFo/k";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA6A10E6E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:05 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso56257625e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891064; x=1789495864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X2FDs2e/7Cs+0xVRUVeiLtRiTiLQqf3FxILo5LoXPrc=;
 b=mxVtFo/k3WU1jVKvAX0h6J0neDSmWXBhZ4u0DanUMJRAs9Xd2jdyLfXW+CzyB2H/a5
 xJOeNU9WXmAL/A2ZEuwN+ZA5d2GnDWtxXUodQTdxGmRkglkDsnb2zrNk1qnLzmJh0l4w
 jHeZoXWb6T3YRmGLnsG9LcPJVt8rT/xX37OUFR1GbXUJcJUicRib0v/5vtX8RxcKGV66
 v0GI3PhTK5dErYbiDrNqCcqeTUvMLLwL+csMmotpRyWUivkayz8XAl1keaIQgEK5nZNs
 LLNuDizodoxCZdDJ/vYJ/n0tW8YNk1SALuCA1zO1Az8n/Yic7uPeCa68NMHCOaWP4TfR
 fZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891064; x=1789495864;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X2FDs2e/7Cs+0xVRUVeiLtRiTiLQqf3FxILo5LoXPrc=;
 b=Y7KROIPN79/OS07eHR3cxQ+/gDZoLbSX3YUUtxsJk8pkNZKw7MB+eWf7BeChI6UGYy
 Y2SB6cGXthXPD6qmIz+ofvvhJt71vkDzVq5pzTWvaLPhIKeMnSg629C92cZFc2wkpArO
 AXUAeyJti0OsJAnA4VwoXzdndYiP0qvkRGjIM1wMx/1SdhW1zJ6FvYY6X6qMCdDPEL30
 53loquwNqQSYWsPbRYx4SJoP5hvzfzG13VuhEm10VBRT/hPzRNNS1ryKEem11FBe9hzz
 iUM0ySCAXmKbO/lcXJxyHhPD76pR47GtvzvH42sDhyvCQyNcOGy9K4paF0ON+GFBDY1w
 BDew==
X-Gm-Message-State: AFuF++my+GUuSB6Q/xLY8Z+8M0NzNmS6vXA+wvDSeqwngc1kiN9Sf+aj
 3s46y7izqY37zUnu+PrMNLoxg95+brWbsXT0hR3bNPmYKRKtz4KjozjRmUWJ5l0j
X-Gm-Gg: AYBFou1TqXqCfdRQEEWI93PP6ZTiwDMU8TsdiDv6hh1e2WQ2cie8xWKmpRSCjYUwvGH
 Ive1fFj6lQpuYyG1IZC4vvfYw/V/ED/JmmvbHfarNs4OKTL6D5M9VUz1jS/qUyEa35RGvRHhZNu
 G1wix5XbGMq1fBgqPqXYblHodX6ZtwEoIzNkZ66ziPUsLcZ02oB/uaKYI9UJRaE54y4P4qog4VZ
 eHAZNVHhluR97fzZ6N06TOo0iBXxpchlGoxz5CVpqaw7C4vy2LL1vz/iXTadsnyuyPr1pVmeeFe
 5pp6HcsDxPwh1x0IsNFzEXwB9Z2PIHsSQybSkwUzr4sxkq5EJu38rboOfJkmIzKSIuXrf5uvebM
 lUegwWWmK1pl7gihelbz/TnNYQgbFnxXuD+Bonf6F/S15BocgxKZyCEZPBl6ao7gvZWQ2ZgbxXu
 1JtaFcOSDz18tzliHbFtoZzac7lX++1OOqovOiwhIlTqsAZUUJFaee0hQKjSGSverDbr3oTCLyn
 tB5l2iBFlsqQp5n8ajd
X-Received: by 2002:a05:600c:4712:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49cf8248cd3mr512448235e9.13.1788891063564; 
 Tue, 08 Sep 2026 11:11:03 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:03 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/9] drm/amdgpu/sdma: Remove unimplemented soft_reset() for
 SDMA and SI DMA
Date: Tue,  8 Sep 2026 20:10:44 +0200
Message-ID: <20260908181052.381126-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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

These functions are not called from anywhere
and don't do anything. Let's delete them.

Also remove the srbm_soft_reset field from amdgpu_sdma
which is not set anywhere anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      | 7 -------
 7 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 671cfbb67b7a..2b4e51c33e6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -108,7 +108,6 @@ struct amdgpu_sdma {
 	    int			num_inst_per_aid;
 	    int			num_inst_per_xcc;
 	};
-	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
 	struct amdgpu_sdma_ras	*ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index de2323e23566..511c9dd3778d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -55,8 +55,6 @@ static void cik_sdma_set_irq_funcs(struct amdgpu_device *adev);
 static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev);
 static int cik_sdma_soft_reset(struct amdgpu_ip_block *ip_block);
 
-u32 amdgpu_cik_gpu_check_soft_reset(struct amdgpu_device *adev);
-
 MODULE_FIRMWARE("amdgpu/bonaire_sdma.bin");
 MODULE_FIRMWARE("amdgpu/bonaire_sdma1.bin");
 MODULE_FIRMWARE("amdgpu/hawaii_sdma.bin");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 9478dd034aff..63c94fe52b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1234,13 +1234,11 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
+	u32 srbm_soft_reset;
 	u32 tmp;
 
-	if (!adev->sdma.srbm_soft_reset)
-		return 0;
-
-	srbm_soft_reset = adev->sdma.srbm_soft_reset;
+	srbm_soft_reset = SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK |
+			  SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
 
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 9d7d919a5aa1..ded1f8abfb08 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2051,13 +2051,6 @@ static int sdma_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static int sdma_v4_0_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2403,7 +2396,6 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 	.suspend = sdma_v4_0_suspend,
 	.resume = sdma_v4_0_resume,
 	.wait_for_idle = sdma_v4_0_wait_for_idle,
-	.soft_reset = sdma_v4_0_soft_reset,
 	.set_clockgating_state = sdma_v4_0_set_clockgating_state,
 	.set_powergating_state = sdma_v4_0_set_powergating_state,
 	.get_clockgating_state = sdma_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 461f8b220a3e..5212ea6c46a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1651,13 +1651,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
 {
 	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
@@ -2109,7 +2102,6 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
 	.suspend = sdma_v4_4_2_suspend,
 	.resume = sdma_v4_4_2_resume,
 	.wait_for_idle = sdma_v4_4_2_wait_for_idle,
-	.soft_reset = sdma_v4_4_2_soft_reset,
 	.set_clockgating_state = sdma_v4_4_2_set_clockgating_state,
 	.set_powergating_state = sdma_v4_4_2_set_powergating_state,
 	.get_clockgating_state = sdma_v4_4_2_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97fee70dc2f6..a6fcef36c501 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1522,13 +1522,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1906,7 +1899,6 @@ static const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.suspend = sdma_v5_0_suspend,
 	.resume = sdma_v5_0_resume,
 	.wait_for_idle = sdma_v5_0_wait_for_idle,
-	.soft_reset = sdma_v5_0_soft_reset,
 	.set_clockgating_state = sdma_v5_0_set_clockgating_state,
 	.set_powergating_state = sdma_v5_0_set_powergating_state,
 	.get_clockgating_state = sdma_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3705a963e660..31ab701d45d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -600,12 +600,6 @@ static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int si_dma_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	drm_info(adev_to_drm(ip_block->adev), "si_dma_soft_reset --- not implemented !!!!!!!\n");
-	return 0;
-}
-
 static int si_dma_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *src,
 					unsigned type,
@@ -732,7 +726,6 @@ static const struct amd_ip_funcs si_dma_ip_funcs = {
 	.suspend = si_dma_suspend,
 	.resume = si_dma_resume,
 	.wait_for_idle = si_dma_wait_for_idle,
-	.soft_reset = si_dma_soft_reset,
 	.set_clockgating_state = si_dma_set_clockgating_state,
 	.set_powergating_state = si_dma_set_powergating_state,
 };
-- 
2.55.0

