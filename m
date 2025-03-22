Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC09C36008
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D4310E854;
	Sat, 22 Mar 2025 01:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LVt8Ok4x";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E2310E85A
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:24 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-477296dce8dso4744331cf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608044; x=1743212844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tuMuCGPTZ13V/onlwapzElJRl5Izo1uzl4o/ul/vubg=;
 b=LVt8Ok4xKqFYrdeALmfOJ5aqe4tXU5DIyUAspuSTVviNAq/yDafjeX7Ng1oHINgMFO
 a8YcIYxqvQGxnIzEg9oNOOBN+OLT6pQ9DlwDeBTEGiOxY393DjoBmezzwnpvKCg906SK
 pjy39+37DlRw5eBRZDgqhM54NVXswjRyHtZju6j6K70s5CPoTXIpunzIa4HSgbUJBl5o
 piZkVyfgABb2FI28hY7cDnwIRGLxJEUNS8U4LeOW3Z7+HQEBhJvnrjDo/02loqka9JaO
 1nLzk48tQihU/4Fv8V9Yg9FTcrCEOkgQ40wbhsMHh4OMuqHfe6hywvVY5XoWos7XkhY7
 7gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608044; x=1743212844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tuMuCGPTZ13V/onlwapzElJRl5Izo1uzl4o/ul/vubg=;
 b=VKtUpTkKFGkLXgYJvAd6SRZ2Fwny+MtfWT0khqVTCdXOh0bDjd5PzuwhE8tObUo4H2
 L9Yw1Phg+7XBNiM44mGVI2K+epLv8rOqF8OnHbppJI4iYfq4Zmc/l78DCv6XGbO382Y/
 SQ+cr8ukoEK8rO1joSvgTeE0Ky4/TzsZJz/TTSktLrEkjrpsJLXdza1rMB08fjjREA+A
 vE52NWWctE2rKnEoNPyfuxFuy/z91SVbVx71D8m44O7vKmZra+EjLKly0Gu77Tv0pmnq
 ZGr25zRZvqVXwFxegcshn/XgLfdzElDUhx2mvV0c0x9v2cAAoyMNVe9vC6lmhSWFnNvp
 8xJQ==
X-Gm-Message-State: AOJu0YzOU53dgOntrBOgk4vbAnn62bAjK9mJ/PXbLStvEF1UidGieif4
 deIwbV6/0Sa+XasVp/x23YtIsGFm5q7tFBUJwIXgyDp1F0w8MFF7U4zJZA==
X-Gm-Gg: ASbGncuIYqJa/04xxyqPfPVB6QX+pmhNee91cWiAviIa7oSbFp/12aYIQ1I1fRx3AVQ
 slUCjFthR05+CibmaBAWIcL62OtnzWQHMlDmJKyH+Hsm78nz226pJSw5kNpCjTUcTev+hktZeuO
 F+b1CaYK68LPeCmHeuvIBr2ADbymxS0exZv2cnZYSKBre2S5IMNdx5532+L3p7sCR9eOgWAUM9B
 +TOwE+67EJxPnHzIO+5fKTxpxVOztbI1zIOx6EcR+AaepT8p4TK8G+TsgogBtzt0RWzlRwUurAo
 bbfhscpp8i0w+HkQZ8muCGqMK7q+oQ+WIqVXswyh2vdUiY3BypS5zK84KSgHl1FBztml8rZ7w15
 qog==
X-Google-Smtp-Source: AGHT+IGJGMpI5hyu32tbvlMfFSKtVGhk1jpYWD10frIzyQ8GiUEAjy4VYimjL3AaZCr7hjZq/pdEvQ==
X-Received: by 2002:a05:622a:2b45:b0:476:977c:2eb0 with SMTP id
 d75a77b69052e-4771ddc8c90mr103056951cf.30.1742608043660; 
 Fri, 21 Mar 2025 18:47:23 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.23
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:23 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/18] drm/amdgpu: keep removing sid.h dependency from si_dma.c
Date: Fri, 21 Mar 2025 21:46:58 -0400
Message-ID: <20250322014700.62356-17-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

Move and rename DMA_SEM_INCOMPLETE_TIMER_CNTL and DMA_SEM_WAIT_FAIL_TIMER_CNTL
in oss_1_0_d.h

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c                  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/sid.h                     | 2 --
 drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 1b8adeabc7f4..19c5211067dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -149,8 +149,8 @@ static int si_dma_start(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 
-		WREG32(DMA_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(DMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmDMA_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
@@ -477,7 +477,7 @@ static int si_dma_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->sdma.num_instances = 2;
+	adev->sdma.num_instances = SDMA_MAX_INSTANCE;
 
 	si_dma_set_ring_funcs(adev);
 	si_dma_set_buffer_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index f82398a9a750..b5d5ff639be4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -806,8 +806,6 @@
 #define AMDGPU_PCIE_INDEX	0xc
 #define AMDGPU_PCIE_DATA	0xd
 
-#define DMA_SEM_INCOMPLETE_TIMER_CNTL                     0x3411
-#define DMA_SEM_WAIT_FAIL_TIMER_CNTL                      0x3412
 #define PCIE_BUS_CLK    10000
 #define TCLK            (PCIE_BUS_CLK / 10)
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h
index 8edd6c871e1b..f6acd06c8da6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h
@@ -246,6 +246,8 @@
 #define mmDMA_CNTL                                          0x340b
 #define mmDMA_STATUS_REG                                    0x340D
 #define mmDMA_TILING_CONFIG  				  0x342E
+#define mmDMA_SEM_INCOMPLETE_TIMER_CNTL                     0x3411
+#define mmDMA_SEM_WAIT_FAIL_TIMER_CNTL                      0x3412
 #define	mmDMA_POWER_CNTL					0x342F
 #define	mmDMA_CLK_CTRL					0x3430
 #define	mmDMA_PG						0x3435
-- 
2.48.1

