Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AE6C624DE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25B410F8C5;
	Fri,  4 Sep 2026 07:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BGOJUkcG";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAB310F8C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:02 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso5658125e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506941; x=1789111741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hi/7/i+hUgBhIEA5+vfPX3z+aLRbcq4CHmAieRzjaaM=;
 b=BGOJUkcG4drhcnoX70Kx3wH8rX1bb7vnC7WGUVWoY/Fpd0EXSsZjQhx8Kk+qlZqZN+
 93b9bIjMMA+tKjdq+fsfm/U+0QqYeygYcol6mARblRcdsfIiJJfiHL3SDKerq1bXYSog
 rDX4q78bpzqW8YLwqM56MrRtEwfzNKCrqPrigfVQXbuymudkdSPNWSSbA4v4XatJtas7
 7AyEckhUIlNF2J8rknv1a/svE8esFgVpBeuvVQy1fjHavb2WKBoJfix9cOnWJdC7g+nf
 oRxCQuSAeuU9d2tSg8wYBQnD1TP1IxkcCblNeZzBMAAAEIPbFXKa8pTopsn8h6z596gs
 v7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506941; x=1789111741;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hi/7/i+hUgBhIEA5+vfPX3z+aLRbcq4CHmAieRzjaaM=;
 b=J+96ehNdCiGqwc65IlwDIRisAq/+iL1bCFO6ksJLqg9YPS7Y0zJn2+YbmnPY74Yvp1
 +OpPMmu8b6Y3acYsSLg6YW2C/9BAl6mnLGl+kgvoh/VZD1NAEWHc32cw5/jatneu/inb
 U2Jmpu11dGzbDxkEQt5l/RUA0St8IaTU9Il8ylF3IEQOouFhlk61JNLWhL5nq2EQmxf/
 3iKYzEMOeWqdHq+yMFk2wiZ9OxKEaYYJ0DkQHNBLX8wNsOCTs1Y0T0x6GhPfL0fSi6sj
 T9U8fsCwdURtiWaFyMFNrJ/7foQ+Y32M2NZcN6Ti/6Z+yRHcSUTgyQWbunUuDSU/Gpn9
 woyA==
X-Gm-Message-State: AFuF++lefkW4VSMSxiNqSzcJIFjzoZJRw7twbTBFCYt9BW50mZnFxFdf
 dTzKgRJ+0vStLNyKn2wxkYhIG79tjkQLxGHd5ETE7jFUt+Qpkmx8hL/ETpd7yIXd/n0=
X-Gm-Gg: AYBFou2gMvP58ogCf3M7M68RUueHGgt9/CCOn10zyF2ad+d31tpczFyX/+miNxXueHI
 Soupx8ECuHzKlJdflYHpXX5d8PjgWDIfzVJP/hzwV1+uNb/Kdauoy0/xi5YhRaXPobK2KcmpsLX
 CQUcBTQexHpbpF54Ygcf2Tl+uNols9IAFCBATrOquR4biTdhGe0XpzBUlW4hwZyMisahNxu/tYr
 7Re4rwFyZiezJjN6+sG4RHTPrqpfLpkvxIvZ2FSq/TJe3VfgxQ5jaJr/y3yJ02CMHk5l2MqKtBV
 Ps/Methnl3lNBhmXO0j5hNTfVWU2uK13GXJnhFx5NJTZgKkVK/It/ScVu2VlBez5ObqKISJTIvb
 5tCn+UdWMCZCV9NDUrpwf8D445B1RJI3c1YWkrnbK7fiia4rQBxxCQFAteGfgQX6WjSHDcccYKP
 c0q2VgHTpRUIaQ7LZkgvDqvlI0f8EVMPwvHbjrVJS+Nw5ZpkAuSGxN5+4/EfrtPj1Bt77h8XfgO
 ptMdOT8QgRnVOGWb3jg
X-Received: by 2002:a05:600c:4744:b0:49c:fc6e:a3e0 with SMTP id
 5b1f17b1804b1-49cfc6ea75amr13471925e9.31.1788506940527; 
 Fri, 04 Sep 2026 00:29:00 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:28:59 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/8] drm/amdgpu/sdma: Remove unimplemented soft_reset() for
 SDMA and SI DMA
Date: Fri,  4 Sep 2026 09:28:43 +0200
Message-ID: <20260904072850.321759-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904072850.321759-1-timur.kristof@gmail.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
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
index 4f4e56022c97..8a78d6967716 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -107,7 +107,6 @@ struct amdgpu_sdma {
 	    int			num_inst_per_aid;
 	    int			num_inst_per_xcc;
 	};
-	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
 	struct amdgpu_sdma_ras	*ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 824ccac9f9f5..7040385a98d2 100644
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
index 6198bc2024e4..0d06e6643ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1229,13 +1229,11 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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

