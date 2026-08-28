Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A15AC61DDB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD3910F36F;
	Fri, 28 Aug 2026 12:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qU5ElNTk";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D472110E00F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:07:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so148851866b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787918856; x=1788523656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CyI0Ir84C4Qgr1GrWAU+Efd3JdCxmBAanG7oR3NSYpk=;
 b=qU5ElNTkEEmE7pWbBL/adUJ1RTBjupqIjd9f5kSb2kfVMETWBnqIwyppmTbqFjfSeK
 sOEcjY8X1CQbDZ+h7lQhUnaFhXwrUShr+gfhmTRBPjTAOMKmuRNz9qfayJ1f4jV+MXAl
 /jORyH1k/hEFq5e5cEcAgZnLMFU1otH3biMLUGVfj48+NWvqnue3dZVM5r0OKYlilujF
 OemqGOVBhAltErZPdQNFxqpHYqpekWqpxi9TE2BtAY764hHDFb6EVrnNtj0Xnmx2T9Cx
 dD3bWCrxiSXpRY0/eKgrELyyA1p+7ke3HpT3usIpYapzNYMhjkeWDXQKA6+I32+FfIaw
 41Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918856; x=1788523656;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CyI0Ir84C4Qgr1GrWAU+Efd3JdCxmBAanG7oR3NSYpk=;
 b=a3hb2LULyFB/6h7bdT61P/Ueic+S40NqglzQeEuTbCp0/zZ1+XF1pyAjIoEfHoWHOm
 O79/6kEM0m1BCtnu/JNwQ19qImqyUieuagE4FFid+ds4gaq4icfsuQLzp2ds9VbQicUG
 PQuNbg1oskJN51CD7QAl9+KWRV9N2Tmll2deXMKq0kAi2Dzd0O+KUWRaCe9rG4hSh50X
 g2KX+HcTLXQl0W54bVR+86a5Nw/LMAGLBF9ZdwhVR8C9a96nca4w9XfeRC7q7o3SbmXk
 GyGBLcjoFIqf6c+KXW7iuwbW/QABJz66xV+mlOa7R9gYCetjgR3VXTJEOz6q+QqnVWMe
 yjkg==
X-Gm-Message-State: AFuF++m7kSGs3BRyZa9biY/FILiQVI3qrOW50ASjlq5vJC+zqtXG7knL
 /HfWcDec6llIABwATI9RJBo4dykywuu1AAm7hsaJUzvSfK2utdb5Fmw59nSZgHmt
X-Gm-Gg: AR+sD10+Ehi0w8Zv8G3r5ZnbBhryTnIlcyPcB0u9d2SXRTgRCS/xqyTyuPoYl6XQozU
 oFCx3nfN2eX5HUsuC+w2s0WwNWY1QHKd4j2PkV8cLx/VZvbhK9i+fRYg183Ej+/7dhwJVvZAlhu
 K+1tsx9FZ+a2Bsj3wIcQCjkkHtvuorliTSHe+Gdw3Y8RgbnRTJVbe/NdEfkrEeReiDV9ZkI+anO
 gSwtC38oeSjyhi0NK6EbLVb3yl3+1KuYuly1QpI+rYoJlhDlDv6lbnDDPNGVu9aUcZpLPgb9Bkf
 g4kQ8x/EVvyZsqU/rz0aERySIAbA0YHXdzpvUMPn390+N8GhTY9b4tENCGvy+vylpWHsQ88BqDh
 FgJ5xdheAYGOldC7GFE2le/15uDap9IfYCJfV8c/b8oxZMv8cEzdJnUkaxtNZSQSnTkuRyPPOOW
 lT8W0RnC/BjxkL+FMVftpyAeopmby90rWUpAfJPXMdccpilqW6iH/xEUPFjOtJKM42zhrCG/3jD
 OCQW5U7ncygJyqAJqh0FXgU
X-Received: by 2002:a05:6938:a084:10b0:c1c:64d4:5ba3 with SMTP id
 a640c23a62f3a-c25571a8f9bmr333640666b.20.1787918856146; 
 Fri, 28 Aug 2026 05:07:36 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f29a9dfsm75364066b.63.2026.08.28.05.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:07:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amdgpu/sdma: Remove unimplemented soft_reset() for
 SDMA and SI DMA
Date: Fri, 28 Aug 2026 14:07:26 +0200
Message-ID: <20260828120729.25908-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828120729.25908-1-timur.kristof@gmail.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
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

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      | 7 -------
 4 files changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a0f19f7b39e6..bf71f99f7307 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2046,13 +2046,6 @@ static int sdma_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -2398,7 +2391,6 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 	.suspend = sdma_v4_0_suspend,
 	.resume = sdma_v4_0_resume,
 	.wait_for_idle = sdma_v4_0_wait_for_idle,
-	.soft_reset = sdma_v4_0_soft_reset,
 	.set_clockgating_state = sdma_v4_0_set_clockgating_state,
 	.set_powergating_state = sdma_v4_0_set_powergating_state,
 	.get_clockgating_state = sdma_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 1a2810b6f27c..72ea9db939b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1646,13 +1646,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -2104,7 +2097,6 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
 	.suspend = sdma_v4_4_2_suspend,
 	.resume = sdma_v4_4_2_resume,
 	.wait_for_idle = sdma_v4_4_2_wait_for_idle,
-	.soft_reset = sdma_v4_4_2_soft_reset,
 	.set_clockgating_state = sdma_v4_4_2_set_clockgating_state,
 	.set_powergating_state = sdma_v4_4_2_set_powergating_state,
 	.get_clockgating_state = sdma_v4_4_2_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1a022a251011..0da54c335822 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1518,13 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1902,7 +1895,6 @@ static const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.suspend = sdma_v5_0_suspend,
 	.resume = sdma_v5_0_resume,
 	.wait_for_idle = sdma_v5_0_wait_for_idle,
-	.soft_reset = sdma_v5_0_soft_reset,
 	.set_clockgating_state = sdma_v5_0_set_clockgating_state,
 	.set_powergating_state = sdma_v5_0_set_powergating_state,
 	.get_clockgating_state = sdma_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index edebd9109fd4..1df30779dcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -594,12 +594,6 @@ static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -726,7 +720,6 @@ static const struct amd_ip_funcs si_dma_ip_funcs = {
 	.suspend = si_dma_suspend,
 	.resume = si_dma_resume,
 	.wait_for_idle = si_dma_wait_for_idle,
-	.soft_reset = si_dma_soft_reset,
 	.set_clockgating_state = si_dma_set_clockgating_state,
 	.set_powergating_state = si_dma_set_powergating_state,
 };
-- 
2.55.0

