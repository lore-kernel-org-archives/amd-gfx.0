Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF6C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E8510E2DF;
	Mon, 17 Mar 2025 06:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ID3KO2lF";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF59510E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:28 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-47690a4ec97so41609661cf.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191648; x=1742796448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PL1xSGy/8VbgRXiY5G9SN9Lab3J8WeumuX411JsDSTU=;
 b=ID3KO2lFTzLjMp5+CacVqZySmpPe0yYg0jYJ9mhcNuPsIufwP1P3IOZ7e6nWIFlga6
 4n0sVIXX4w8el87VG61lhjm2CdNKK9bkjtFEDhSI7nkx7Ky6sL3z/uHE98L1RBUHJbwz
 l2M7hYRoQHukobKL3Z6s7t2StaXs49CJZ+LDBJLKmyg1lBd4pWFAkiw7d3fQ52Qx3PGr
 R1s4a3YdmSYj9C5AKev0Zyv7yTbz6cWvp9GHt5Pi9L/PLInTb/7nxSLRVz3DcUQfd+fF
 Qh2vvROYuK+zu43OroNCdeARyncN6vYsjGadil7Ufre/gaiWAvJdbFtdgw58wufUByzc
 ONVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191648; x=1742796448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL1xSGy/8VbgRXiY5G9SN9Lab3J8WeumuX411JsDSTU=;
 b=KzTM87jUYlEKbCnMo4Liap8U6v01d4UbLAU18ZEJoIBbYIlvYKaoFtq/NHyvLaJRxT
 9k22sWkwE2mejz5VyizSdpZTwtec5xGqiqGio6in7EewQgI2lqMY20DAQOJwzNE02RuT
 j4eFPSAapWhuTi33frug5IosB3QJh0vsBC6h9kWl5oYv9KfOfh6iuTMURTuDMyFtQ2HX
 Vh3SgyP7vLFf5lZsWeU3GKs84IvelBnkZpz79371IJhG7FWr4DmLEr1VK1Q8DU+xLhCw
 ieU87mfNtrYnzYqgnkO1QhO8Axx7S8GPkFPcrpLpoyboiRatCI+CX9YwNhRSP3cWImtC
 Q+RA==
X-Gm-Message-State: AOJu0YytxHV3g8+WDUx3ITnfuqcAzks20XBHqPkEQHJGrLMSRHMq5tXa
 BMdTKnn5a72LSAI8x0BivDAXFeuoG50+MWcZc2wWHIyN/ba+EKfqnTHw3A==
X-Gm-Gg: ASbGncvhqT7GyVoNSkOH6lrFfJUu+7W2i4XXP6QwNqbp+hU+4yBeJ/6pHECSd6bzV/C
 G853/RNOWfpgtu+GOaj/ZbGBnJNRehCwXUMJOCwWd0k01k5Poe8UBtojtJ83L/Uu35IDl5HF5J1
 Cuu0MxF1wPoh3j7QCCNZKvpqQxdQBVhSTqastN2I0e/HMxoiiYHXXvKRB0qcOaLZ+DDHNIsFazQ
 fvZTvthLrpnXC1SztKodi4BHcck5PbaiIuS0qCrss8sE6czEJIUFuEEHGsMIMD0vhnud2P3kvg0
 EhlS34FDmXCZ7I6URLhqhmodGvXjo/wLek77hrKtVAmh1iPYRCjg2U0SRlOJNIijPDI=
X-Google-Smtp-Source: AGHT+IFMcORuTEEi8kn/aLDoq9V5vULpD54YDsH+OrSAmJ5Mc+q4NGspQnopeYXT5rPc8nqVLI03XA==
X-Received: by 2002:a05:622a:5b0b:b0:476:63e5:eb96 with SMTP id
 d75a77b69052e-476c815e8f2mr174916621cf.28.1742191647688; 
 Sun, 16 Mar 2025 23:07:27 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.27
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:27 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/18] drm/amdgpu: use GRPH_SECONDARY_SURFACE_ADDRESS_MASK
 with GRPH_SECONDARY_SURFACE_ADDRESS in DCE6
Date: Mon, 17 Mar 2025 02:06:50 -0400
Message-ID: <20250317060702.5297-7-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

It seems a copy-paste error: since we are working with
mmGRPH_SECONDARY_SURFACE_ADDRESS, 
GRPH_SECONDARY_SURFACE_ADDRESS__GRPH_SECONDARY_SURFACE_ADDRESS_MASK
should be used.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index a9a087a841ea..0ac66493ef40 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2010,7 +2010,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       (u32)fb_location & GRPH_PRIMARY_SURFACE_ADDRESS__GRPH_PRIMARY_SURFACE_ADDRESS_MASK);
 	WREG32(mmGRPH_SECONDARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
-	       (u32) fb_location & GRPH_PRIMARY_SURFACE_ADDRESS__GRPH_PRIMARY_SURFACE_ADDRESS_MASK);
+	       (u32) fb_location & GRPH_SECONDARY_SURFACE_ADDRESS__GRPH_SECONDARY_SURFACE_ADDRESS_MASK);
 	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
 	WREG32(mmGRPH_SWAP_CNTL + amdgpu_crtc->crtc_offset, fb_swap);
 
-- 
2.48.1

