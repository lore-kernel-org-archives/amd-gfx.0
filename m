Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF077C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5712110F016;
	Wed,  1 Jul 2026 16:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qlhIjKpp";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5C710F028
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:50 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493b691cb44so5836685e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922669; x=1783527469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3v7o4kDdRXuMnUGHIMXCkBJMTPMGOOggPcLw2ws/kg=;
 b=qlhIjKppx//TPe34Im4Cw8Kzx9mKtFCIvzEv/Zn2nuK16+Pg4yZjC+n5fOIlI/ocG4
 c3WVpT/olDNByxt1zWgyX/+1k8DLKs9VIUILSPFqYGkj0jsyWHa5xluR1fjG3JGicZR6
 k6rDFflq96RuNJI3vckpBCoNvgvefshwQKiy/JeTlai7xMSLu3EbSL1juCKsK+Wp6XXm
 OTFNp5ujA2ySKWj+00Dgcklf6PtgbTtXl46Nh/MJ1Q0/q1IfdHUD6MMeaCDu2g/e1eQc
 zzNB9by6YAzI9em+qDuvqDZ8xKIDEYe2o8gqhiW6E5amQfMcbeYcuOaMR2Rms6wxy61V
 7sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922669; x=1783527469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3v7o4kDdRXuMnUGHIMXCkBJMTPMGOOggPcLw2ws/kg=;
 b=Q1w3nbQqmJCvf+2pjoYUH3nD1Tdo/FVxZuot9Qq5mbXfEJ0fq32fDd9/QazO4tcYks
 dlKdX0h9SMAOSQhVspzrkbgYFM55Ul5QEYbP+ikK9ucgbx2Kb80+B8Og3B7z1raRangm
 Oq5veghx+z3uzUnhgbuCkq3n2Sxi36JogIgUHfx6zTdE0Myv95/p0GuZ4OkKXsFaZP4W
 xdRw+jry9vfGZ7WH0YnzhU1Tb1EvYyPQBSCCW2FSW8Pgi31IZrGdK0JGZ7vUyA4Gkulz
 88HjLzl46to2pW6BX/oQtC3jvXLWCNdsVfJ8nGNEzFIxN7byc9be8+9CgNRuXgUqAD5p
 jD8A==
X-Gm-Message-State: AOJu0Ywarsq0LGEu8H/QKgqdmzGRXWTn+cpDgtGOlGvbyLCOS9RGSB34
 chrb4uHiXNyKgJEGaHuM9O43r08nUQMZQryXRmaQrdPqwiGuQDqUnTGqxwDYTsWD
X-Gm-Gg: AfdE7cmuGMKWWpp1lxGeBFgoHqg+xdZzjTP4Eo/0oQ3NVq2nX7awDDyVJY0pPJoTbQR
 hJig3wt6xDp7fDcUMmY9fmiMVCuRuFpvEEGB9GSkg5uDuh9dLP2fULx2aWW5L9goVWEjtHA7q8j
 GH2xqxqheLJr7hS4LOW8ljEapS8KRdBq98X+piirBlmyrUlZG6jK4n1ELw6kIoDk7kz42EsNJBM
 n3BF35uEXo2vx3xsMVrEZSfJpT9bPBrPE1ICNdrdueJxb/a4Co8KfPr+gLowzgB67sQUDYAIi7t
 G0WKfvryJUT/pQB+H4snK45BFD6tVz1CVoB2FopPUCF4VmbP3tesyopUVRSpG2EiaXtzSwb3S8x
 eDL9uCnvLWwlllLaOtjWOgB1A0BkpbFf+PU5z+8Sm5v6D+vUYQ/qOXaiGhUaDRKFrTldjnojbw/
 q4cpIwCWdVKbFGLF9v
X-Received: by 2002:a05:600c:5808:b0:493:aa0a:45b0 with SMTP id
 5b1f17b1804b1-493c2b855famr26183485e9.23.1782922668590; 
 Wed, 01 Jul 2026 09:17:48 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell for
 retry CAM on IH 7.0
Date: Wed,  1 Jul 2026 18:17:19 +0200
Message-ID: <20260701161721.85681-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

The doorbell is not working on Navi 48.
Use the IH_RETRY_CAM_ACK register just like on Navi 3x.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index f1de6450a31d..291326d2ee8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -279,19 +279,9 @@ static int ih_v7_0_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
-static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
-{
-	u32 val = 0;
-
-	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
-	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
-
-	return val;
-}
-
 static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
 {
-	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
 }
 
 #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
@@ -401,11 +391,6 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	pci_set_master(adev->pdev);
 
 	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
-		/* Allocate the doorbell for IH Retry CAM */
-		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
-		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
-				ih_v7_0_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
-
 		/* Enable IH Retry CAM */
 		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
 		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
-- 
2.54.0

