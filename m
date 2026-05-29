Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9220CD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB1710FCB6;
	Fri, 29 May 2026 10:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QM4PT0vw";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DEC410FCB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:07 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49068493267so38442635e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050666; x=1780655466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8efPVCYRjJe6NMwTqZI1l2Ucr7gH6c01I6Iaz1xZobM=;
 b=QM4PT0vw+tez4taXn3P0g3TsmbGvkcRUoXr7yxvCBTPDQEo7dUiue9Vk2c7gWsYQrl
 dF1Z6VbURb23LDzkD8FvLwa37QqOZ5QngGgHuPcJCNCPtSRqhBG1NR2eJthmagnc4PsU
 7MelHsFATEk4gIZrq0+lGv66VGcQpnpMZ4w12qW7WMLD57vEudH6DOrEx6/9Udqkhc23
 wNCPOIEjbALXRiN3DLC6pdviLSdGQIKuw90jZXWF+pgeyKrSmmXnr7W4qFexvGsT3cyv
 CzdaGxBHn5obxq8BPxupvvsaWUvKHA4j/bK/mwKRy4qcplG3xz2tm3jU8dmqkf8kenCx
 RqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050666; x=1780655466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8efPVCYRjJe6NMwTqZI1l2Ucr7gH6c01I6Iaz1xZobM=;
 b=gJM3FTLhx41mTQNoFyGPPBKhuzslEEcqCsauD/lKQvpGpICfoMW4dfwUoz+ONqd1u6
 Xv7zabx6AFfuYXPCYQzWh56ecixOoUnhpI06Ivr37c8D88BL+c5PfGV8Ct2rQqCFOWIq
 cYJeHyeQubVfP9zMU09KqN405IY53M2KlApMn2/ZOTNTGbI580y9+WbWPZCzU1Vbmwl9
 nEnUH+i0WAAHb2oTdd1HDlxzlfcMvwCZnkpc/LVQnkLvg6razyprG6HAXQDLVZpNN80M
 XhQ4sfgBZfrlzMVUkp8VEAY6ofNAlp9Tk5miyagXDwyKR7P9t3AGdHGNF3BBsvYuuP/Z
 aJ9g==
X-Gm-Message-State: AOJu0Yz6OeV2+j9vKs6j5s7Oa/rXtOLH6tD6b+N2sHkuJAa8R7xnw9qa
 6hXr9ctGhO8iL7CaetKd7IqHYlMuUC791n9G7Lot1OmRw8bc7dTYzrLEM+CMTHWYmrA=
X-Gm-Gg: Acq92OE6HTn/g5ZzvVzKxivVZ+u9xRJLHUGNrWunYfuES+iBnSE3QCCEqMOcQ2KSMBq
 45+bq4I4tUteXW+Hq4u5kcqWVJMeUiKHeCStQhmtfQkESzdX6Ytga51RCGQTPA1NgG3hEFvTIMh
 QPbnb7EvRxN/C9C6LGsASR6Sh5+nR6e6T4rC2+mGOZ2QDmd7xYOrQF2n2uy3NETtFyyBNsfTiOb
 s/TMR1iUibJemJGwU2ILDupTSu5txjU+ARDNgnGPcQVYcC3Y3YOp4yWgMy8bw6BCWyxrdmLB8N8
 d0X+Pq9lOfyupYoj6UgleTKbri+VFa0BBPXHG2Armm1yx7O2Zjy1B71atZdvzZNIXPCB/K1LXNJ
 fNzJpJu66QtZE8AgMuM6ZL7FHRvs66DNjMLnQ92FVTOAaca42cMeeMeQDKg3DNxkV+oSf2XqzuL
 uNwFbU6vm2lQBpbpOaK+NJqBLsHXrMwHB27wCpBP6Yi2h75GR1QFOU4wn5XgO96bROq7eO/EfhV
 dw/OuuxLUoK7LFT
X-Received: by 2002:a05:600d:8445:20b0:490:3c90:2cda with SMTP id
 5b1f17b1804b1-4909c0af5cfmr30578015e9.20.1780050665943; 
 Fri, 29 May 2026 03:31:05 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:05 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/7] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell for
 retry CAM on IH 7.0
Date: Fri, 29 May 2026 12:30:55 +0200
Message-ID: <20260529103059.21470-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 24be9d726428e..4e6d14facf93a 100644
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
@@ -400,12 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
-	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
-		/* Allocate the doorbell for IH Retry CAM */
-		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
-		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
-				ih_v7_0_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
-
+	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0) ||
+	    !(adev->flags & AMD_IS_APU)) {
 		/* Enable IH Retry CAM */
 		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
 		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
-- 
2.53.0

