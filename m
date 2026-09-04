Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19534C79F85
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9387310F8D4;
	Fri,  4 Sep 2026 07:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lyKFdWdx";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0102610F8D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:13 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso4596905e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506952; x=1789111752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VH693aZWqTFohLEaFlmz+59mfLrTNfzbiznohx60gs0=;
 b=lyKFdWdxCjgBV0jUwCk6SKftrycUBfYO2sLTVcx5qtm3YfZelG1omXmJYtJxvXeBVI
 oebFuYhp3Iqeu7efTLHUHgTjVhNHjsL0Vraw1fm2LWaI6R2kEDiK0I45C+dq9I62WxhR
 JoiSEOlM5fM5VdbSW/3fj1o6om4631wnT1E9vUwVL5v1HWIunzSJIJXzPHJdAAymr8A6
 L3WXrBm12t7h9Fxjsm26vOZOeMVyI3PWgSBIKccAQf48tAp3F/hm5LC4AKF7UVhrTOMB
 aPQga8EtMlNxG0U2KSCnZB5YTgLPpXwpmWOqDfGJwXBmfdSXCDTwnUugPvejc8hcMZzw
 caDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506952; x=1789111752;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VH693aZWqTFohLEaFlmz+59mfLrTNfzbiznohx60gs0=;
 b=ZjKArWyb0stTpq3qxgN5hY3KVBHRrg9CQaIUvUtCrBp8Als8++VdJxStn/cgjRgMIC
 TXebJ/Qj+4VCMUedRaL77/KFBfEYnum3LsenfBIIOCZZBWOW5MjGRzXwfyuApbk/Z9s6
 dFFo3fgVsncpHzLxXF4YKoKlE3/p9d4MdmgdgslQ5DCkRXhDyQ+jVdhZOJNBa8V5bFJ2
 cse70X/T4wNXxt0fuhjzGJfftmpaL5SZTGyioH89OlNijBW/kZrrPBCIKY7TyY6l3Xud
 ml1dAH/9WCUYoCuABg2cQpS3CR/9ezgX1bn4OFOT9rs9AMcpX1Jw0SukzqN1JlWN/0R+
 tzhQ==
X-Gm-Message-State: AFuF++niXd0MQmspyMA5x8LURKbXj9OtVza6xoSRB82GYE+pToYfYqiM
 7mDsZ7Sf9/uk/R8AEIHZCdFxAcbiG2PBkKd0ZEwFWs7+X6ViJeB6+s3pcQwilImwuzE=
X-Gm-Gg: AYBFou0ck0n9N8YN9rE6/Vwc3QiFbOjGHW5idBBVrJv2rcRnO5BB/ia2FizpuXMcaG+
 tWoootdqaYY9G045QC2MBNxo/UYHGBlcRdTyEd7iMxc2OCqgoYqgJUL4nm2+hTayNfDQW0p0inN
 LcFEbHF2Xd6jXdvvAZN1mp0AcGaMgKtidMdrips3X77RHaGYFtPuQRbX5dOVYp66LWI3zuhiJ3e
 WBtRy2LmvQdMmxxaCm2RmgPn9ApYwFbbup3ze011JnJca1JJTvR9FdVTyjU9oYQFf5y4FlqJUQS
 25Z/KmES8EYUL5foZvR3DssE/vt1bkQBvZoE9vEOeRw8qg+6bD2eYz47WCaQkLfJrwTYBCUiY7L
 rurxP9bB7f9qcuieoNxz0x4yBmmaiFgQKK4okspGqGWjYAUbjSkcGYZeqXKTyL0JtcFs8UPJVgN
 BK3SCDJCWZ2U0bMlcAxWNJ/HU1C0bTnueY5jq2d9zFFGJBC1L5CaTy+ly4hjMW0Gh0HUnp6+lA6
 xjtBJrbUWSzW/u4QKo5
X-Received: by 2002:a05:600c:4744:b0:49c:fc6e:a3e0 with SMTP id
 5b1f17b1804b1-49cfc6ea75amr13481315e9.31.1788506952248; 
 Fri, 04 Sep 2026 00:29:12 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:29:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/8] drm/amdgpu/sdma: Use common SDMA legacy queue reset on
 SDMA v4.4.2
Date: Fri,  4 Sep 2026 09:28:50 +0200
Message-ID: <20260904072850.321759-9-timur.kristof@gmail.com>
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

Now, sdma_v4_4_2_reset_queue() does basically the same
as amdgpu_sdma_reset_queue_legacy() so let's use that.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 796ea9f74763..60bb22d0a43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1574,20 +1574,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
-				   unsigned int vmid,
-				   struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-	u32 id = ring->me;
-	int r;
-
-	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, id);
-	amdgpu_amdkfd_resume(adev, true);
-	return r;
-}
-
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2031,7 +2017,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2063,7 +2049,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

