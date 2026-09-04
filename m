Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD31C624DE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F4610F8CC;
	Fri,  4 Sep 2026 07:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZoWpYhq";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C6910F8CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:07 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so8997805e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506945; x=1789111745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJflXVvbqbsFAjh2dc5ouPHmJPrEoNOe0H35zTZpaW8=;
 b=sZoWpYhqcAR5JTz5vgZg7Eo+FlfEsVdgwm3J6imgOPEy9Qmf41DSxjLKCwkMb9C8J1
 M2q2KEFxmMHumOzHEp4Ar+wiSRwQ+yILjQtH/IYPxpcDUuWHORq0ZJ+vMcx+Iwx3NHcB
 WRAXmR3l0UERsvw65efD3g3lDM0KRdPV4+82UuTiE/nOhg9ZPNQmOn/jfLc+2aCTj/CO
 3U2BSxlyHyierielxvjZpFwdH37c5owI9KloDm3lyo6RosCH5JiD9mCmp8QGULofBqW4
 qAvo3k9iCHK+P2U0Dr6VpwpYmFRfVGhAqISv3jUuQAer36Ny9syHK3CBIbs4oV6VF8Jh
 hkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506945; x=1789111745;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJflXVvbqbsFAjh2dc5ouPHmJPrEoNOe0H35zTZpaW8=;
 b=KvWj+zWa3FDbOYuD+3mRsBqOToqLRSZr09GyzDeisFByrHtw1+Ausl6KRTGXMdGpdq
 Xn6SSXeOQxBKaq2lDxFiojHDZTJxtROaBc3qSEgXnLkDx3HVgofSP9rR+76LLJPjDwZ3
 yvHHpkaJ6JRpEOD82074DVEzYgRCxawIV2QYhL1D8dzbh9fYF5He95vWmJFyZ7Hx0SfN
 9nArA+NLCcGf4znPmHJ5Ta9EuAtGNHXl/3JvqrNxH1Gqjs1O/m3hXmY4eOpGWn34mRia
 5o8RAr+yb/ytEogoHwpEpmJG1cJAXFyNGi8YB1vtHCYYVqVRRPZ4mtaQ02liN5r6jEqN
 Q2Ug==
X-Gm-Message-State: AFuF++nL+ehJImkD6bX/Gyo51H78YmBsr1NtRsMo13VaBvPjIWS+ku9S
 oS7VqPUwbNf+YNjxQco0NEp05CGQIsFVKVJVqlMHyos240xxHk/cUr2rPOeCDp0cRts=
X-Gm-Gg: AYBFou1z+wOYlDiUWCQAkAbqHM3BZrMq5dIP94fbtc1OBko8mBoausNtLZLklVhsqus
 wURHQoMbPZ1OCb2hPJV4dFajnIH6yDatactQuj32RczRYQkhuewVwpDrCHRrMJicDJqDZArM8P2
 8QLvCtOVnHy0XnoZsSwtYZmXKElvO+ujZML/ri0wJ3447zs0oUXL+vDvUrMbc3sNCZqrNi+kies
 W9ZwnF8hQP1FE0kTD8zx7uaG+Ql1BXjUQbgycV7GaVx6w3ZouBXJyzYPP23vsLDUAzVeVQ/bkzf
 Ki1CRnONQa5UucIpZZOJ4H/otpJoc7lMHDE546pj2F1kictwTpcD2UIx/QeX+WCLSczc0gpgDBe
 wX52MBr27yptYKYKSihKkKa3dwylZv1OphlWB+EupBhwcPuvWIsMpU6/DxJECdgNKufYVBVWdDW
 SMUNSdMa4G502IMbnyrtlcin1RolzASH9vpBypYXs85+E4oLqpQRTNLu6ZbrwAqpSM1TtG+lK89
 fiYvOVQ4j8F2UBwadXN
X-Received: by 2002:a05:600c:3b9b:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49cf8286e30mr34240945e9.15.1788506945327; 
 Fri, 04 Sep 2026 00:29:05 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:29:04 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/8] drm/amdgpu/sdma: Remove unnecessary guilty tracking of
 SDMA queues
Date: Fri,  4 Sep 2026 09:28:46 +0200
Message-ID: <20260904072850.321759-5-timur.kristof@gmail.com>
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

amdgpu_sdma_reset_engine() saves and restores contents of
both the SDMA gfx queue and the paging queue, so it's
not necessary to track which queue was guilty anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 8a78d6967716..055dd2522ecd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -79,9 +79,6 @@ struct amdgpu_sdma_instance {
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
 	struct mutex		engine_reset_mutex;
-	/* track guilty state of GFX and PAGE queues */
-	bool			gfx_guilty;
-	bool			page_guilty;
 	const struct amdgpu_sdma_funcs   *funcs;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 890513d7c18f..77f385b9ef53 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1404,9 +1404,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
-		/* Initialize guilty flags for GFX and PAGE queues */
-		adev->sdma.instance[i].gfx_guilty = false;
-		adev->sdma.instance[i].page_guilty = false;
 		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
@@ -1577,15 +1574,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
-{
-	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
-	uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
-
-	/* Check if the SELECTED bit is set */
-	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *timedout_fence)
@@ -1603,19 +1591,11 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = ring->me;
 	u32 inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	/* Check if this queue is the guilty one */
-	adev->sdma.instance[instance_id].gfx_guilty =
-		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-	if (adev->sdma.has_page_queue)
-		adev->sdma.instance[instance_id].page_guilty =
-			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
-- 
2.55.0

