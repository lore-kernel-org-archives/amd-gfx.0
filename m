Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9618ACCA476
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 09:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFA310E0BD;
	Tue,  7 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ipYlpZgq";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056DD10E0BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 09:19:27 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-421851bca51so3933014f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Oct 2025 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759828766; x=1760433566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BPkl515EsnIKg0Df2zWTb2emVnJ2l7gKbYwmwDGoWNg=;
 b=ipYlpZgqw5QuoPSC/fvddyn4WLHiy5NY/5sKydAiXZbp85BKqMy96OqJsa6kSxH84L
 WtdHv/BRLzYNf8rZ7NfYXyYgTycH+Xqqt2dlRLGml6oVnkP1rdghTorN5l+VAWr7nn8O
 rWBpvfxvbv1OF7t42gBttgFzQ14+2o4/u2m2xt0ToeKNQA+EYvV3X4EgsdmpTjUlxFsD
 r4MG33PSi7FwEGDc5H8QvIpsZHFZanCd3mQXgm9HfA3ZQTEaK/vnSlanT5oLU8vC+oqr
 wtxR3/W2WHTjrShtWBxEzd085qSu9+Hxk1b7bXMdqkucpiMFUcYfo5eX/mxiK0deXcr1
 nK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759828766; x=1760433566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPkl515EsnIKg0Df2zWTb2emVnJ2l7gKbYwmwDGoWNg=;
 b=aXguY69fC1hkoAWQ0X+V+z/eUxYo3KFgj5VB/8qx4H/YWrHetxFFRqsXlqLDP3k02j
 Rb7dGSk7Mda6M8wdFmoED90INFlvT2mhQ0HtMWSUvWDXhlP18Az+IBerFrrK1q7ANXs3
 ToP8JMnTjLuht+3at+u7J78dsByfHkEH2/d2dM45ca29bNRozbkt1MEMmHCDkCAcDUV7
 JiRxNI0Efm2itW6ZaFT3me+NkBXfb8eafSuUQbpmBfenui4QrVZRbKq2h29zZ/WB5b7m
 A0/t+HBcs+h+SOqvolncQ+qPmoO+Rwp52kvkhb8l/5L1mXsoRtplgS5n3u8y56qF6Y/L
 sXuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTepJZAlCxEI3XE09S9h9FPinAyA5ZuqD2AHbzZDV9j5xehxKPaO18ZED1zAPku0pifSupdPNF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEphsd8FKCDtAyulGskhMHtrCRU8kVvgUCse4MaB2loKFGcG1f
 oMx57PAlGL4iYJ2dPz7P7zOl5TUNvpmdTIMPPLkCELnNWpoixMgY8hEdGbOHv/vC
X-Gm-Gg: ASbGnctt3Uix1UymDtBkXsTHXDYK/y2sLbVnC7VtSzXNTAmEwSksVd80CXuG5kPWbY7
 z7mgTQzRImOv3B0opsUZeA9/ICu14jbmvKhEyne4JGBV39/R9zx+wDwjMZT8vEY5g24b89B+Njz
 irIZnzMFH5ipThqEE1UUUElUW1PTRbBUSlVDUC4S16PWK0Sq0YVFdiEtLVRDyM9glnaSJ4JaLZ2
 FAIqlb+91z9tOVCFbbW3/RURcIsw14Cy6SKan5GptfDKJiFfNgfTNhVg5TaJQPIzlVRN3IITNAr
 bFBvMRF80425UKsRPcqgIHlVkq714k0VhL24HfCqa88K0/7dzYvgwZcve4seVee+4idvGERKH1n
 IBO6GpXYfSzfQC6a9/Tn3na+RLVTxpicW7/cfoR5LrHHVLzJpv6NOHGoMFNZH
X-Google-Smtp-Source: AGHT+IH+K6mKLQRuYKZZl47v9fV2CegvRWQiZMj75b4G16uAkLgB7FIsCNg1TDzdeOI4EKFUrCDH2Q==
X-Received: by 2002:a05:6000:26cf:b0:3ec:e277:288c with SMTP id
 ffacd0b85a97d-425671a8d51mr9846151f8f.31.1759828766336; 
 Tue, 07 Oct 2025 02:19:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:6100:d279:6e09:af3a:1bf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe9bsm24865684f8f.22.2025.10.07.02.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 02:19:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM
Date: Tue,  7 Oct 2025 11:19:25 +0200
Message-ID: <20251007091925.18470-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

Otherwise accessing them can cause a crash.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index a5adb2ed9b3c..9d934c07fa6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -234,6 +234,9 @@ static umode_t amdgpu_vram_attrs_is_visible(struct kobject *kobj,
 	    !adev->gmc.vram_vendor)
 		return 0;
 
+	if (!ttm_resource_manager_used(&adev->mman.vram_mgr.manager))
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.43.0

