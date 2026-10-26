Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C3606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PxObTWOg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B27710F353;
	Tue, 27 Oct 2026 09:34:12 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB21D10E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 19:50:19 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c413dea9ca6so543651766b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793044218; x=1793649018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ClZUc16qtddYCX0Axof+CUhlhGSWDDKrln+zkDueyKY=;
 b=PxObTWOgLV/1CHOKVNq/YbcsRHPe0xS3jicug+5Ias2auQDpj1eP2ZPLpKP60ghYkM
 xWxyhwjj/6WU2StvMbq6humazAaPMB4dYMLLnVIxg7cPF54Fs5dwbJaqVXs21HiYZ9wE
 zZp79P9ifTBju85etHb03OVM28hqG6+xivtryjYCFLreA9NTnsm+hL0UjzbgBm0ZNP9f
 stWDzxvpDf6WEQFWDlNtUiLS00pywxTAAGAbfGvOI53LRgaUm+PBScnMt8g9UE1rJ/tX
 mO+d5R1T/G0mcfT83lZNMupesQAvXTu8gBxjKiwEI52zmHxv6HVKYZmnlS2mGBGaRhHq
 ED7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793044218; x=1793649018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ClZUc16qtddYCX0Axof+CUhlhGSWDDKrln+zkDueyKY=;
 b=d10Ur3OsKpajyirx78Gye2/mOMZSWA7tA1LYoxv95fNuy3NhWGmpuaI2TRY96kq1Pb
 t0fTO6rDRd5KHB5yyNlyc32UxE/KAnK+rNPhLqxrstB31FRO6W/kYO+gGLTQVoa/jZ8W
 NTQqwO+nr0s7VksOkznz3B3Bqj4UY7HWu0R34adbqvnbT4X5X70AD9oC5sjEe4TA6tLT
 BBqNiV7IIhbETBnHJSxSztRJt2UPpFJwdO6c15Pu+nS4pXuTj94sQpJD4b9GzV4UdeD4
 33rySUrhm32HiIaYE74CwH19VCIWY8F3so4nYRM63njtkTykc+yEk6ULJVghDGYOqbPe
 l8dw==
X-Gm-Message-State: AFq9FYLd0CRR8wq7SX5axKFUVuShbddR2+QTgFDOKQZR2s9KyN3DwB7R
 ZDWA8Y5jfAEhHxZLKlCzqEYRSXQWM1jg6/G0qeWpt4kzosEPqX1gjD73hTMml6eN
X-Gm-Gg: AYBFou0dDXrj3Ra6S6i3o3e1/5bQb+QPKAvONvs7DXAERN9+vLZdN+k7kX1c5nj3mW7
 mKVdE+gokAvcJC18npTshrYH0RcTGml0JfhMDtVlreEsJCVGp757Hcg8el0fAY3gEsLn4edQiv/
 6Etr9av+94G+aMKRGQSMezv1v2GqaVHCY4aCSj3cHidLUcbnTk5dDSs+piz2cXNY/4ihk8BCPLp
 wf6fBWPP7zWJ5xcwr58v+WT8HfyU1BiFaXkLXhTqvpLo+KlYtMhrZoEIE0mpuuuWZpWz+s6beBz
 6IR4PJvPacoisSdrkO5I4c22p2CpDhZyjWjA2HEyISLhZhTwJNDtMKpZEwCC2R1F2hUISHxmFwl
 nFfnUDdQUeAc89TD7pH0mTIEVvkV8f+YiIVirqnOSf7yP2OSV3Y07vxXmQvurWZlvx+Qjg0xQPF
 YzxcBMmOx0EjsMOZKESI9Z1k+wT78TBKKCexEXg7ysaQ4UFF7HQhTAtpb5aKF0OCjb3zb62cyn1
 szelCk9k6tMLVEqhzzFAMAx3w9V3o2D1m+KCPP0KnRCxN9ggxeuxLo285Z2bqAMANUSF49tdAan
 XnzEOHYbTyBMVHRb3AxqBg/VZRwQDdr/xsA+S7Lgw0VrkSzrW7oBEYXrFDPIxx160XLFrIXsvGr
 OmrenGu9LHu0DXUHSjIz3s4OALHK5USJ2dL351k5FjB8PzLD3yy1SgrcFGXOHcd1ygF00zMVsHe
 Wv791rzyCAdVTUiZWoiIGxe1dyccLtBnAzdbkH0mAibeEndOWx9qJAT1xA2vgxdG6yHAnswO9G4
 hCtey4f6XfNPOFIwmPvWPwyX84EicziUph5jfYOTGoyv79t1lS29d5HsQTKYFgtmnxZZK4mhSZ2
 hX3JIQZNKg4=
X-Received: by 2002:a17:907:7b9e:b0:c2c:d06f:cf89 with SMTP id
 a640c23a62f3a-c46bdacc54fmr933504666b.2.1793044217958; 
 Mon, 26 Oct 2026 12:50:17 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7ac041sm351814566b.82.2026.10.26.12.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:50:17 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>
Subject: [PATCH v2] drm/amdgpu: Report MES ring wait timeouts.
Date: Mon, 26 Oct 2026 20:50:13 +0100
Message-ID: <20261026195013.451031-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024194334.305636-1-erhan.bilgili@gmail.com>
References: <20261024194334.305636-1-erhan.bilgili@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:34:11 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Return -ETIMEDOUT when the fence wait before submission expires instead
of reporting success without submitting the packet.

Fixes: 34e087e8920e ("drm/amdgpu/mes: fix mes ring buffer overflow")
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
v2: Dropped the redundant check of the wait return value.

 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b2e4da70d208..8ca487829aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -218,8 +218,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring,
 				      seq - ring->fence_drv.num_fences_mask,
 				      timeout);
-	if (r < 1)
+	if (r < 1) {
+		r = -ETIMEDOUT;
 		goto error_undo;
+	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ce577f49b630..a25e6f6d5a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -195,8 +195,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring,
 				      seq - ring->fence_drv.num_fences_mask,
 				      timeout);
-	if (r < 1)
+	if (r < 1) {
+		r = -ETIMEDOUT;
 		goto error_undo;
+	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
-- 
2.56.0

