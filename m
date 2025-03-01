Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B0C021B8
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 04:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7EB10E100;
	Sat,  1 Mar 2025 04:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kPepcCN8";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3DF10E117
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 04:11:39 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6e894b81678so14322216d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 20:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740802298; x=1741407098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YnR1c/5GyGtBa1Hb7CDFoa51kxLYBIQeZNM4u6R90eI=;
 b=kPepcCN8aZn9oLc0X2vXgk4jxrAp8O7g9rfrgyn0gH6ebx6NTk4jtolviNP+lu7Sig
 HSmOxiZ/lNLtG3pMGS3g/OyX6kQXdN2w14fZkq7nFDROEZqvhSp8tl1D4nao2Dc08pPl
 vI9KCm8louffKsCFSL8l7i/4X5yCGq4lZYouNFhnqghBS8/JioenlUuFVq/pNJ/s7OIv
 EwAgXPvDEcU90Nkn+ZqSJd/nL09r9mZ0z3aFN8C6/jeKyM9QTm/ECgW7AhLdUV1sq8DC
 MZ4c3deheaw58lb0TUeaoEhhF+yjWPwSbOEOX7eClU28c+GCTpNIGbex8XmESP2DFgOv
 ez1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740802298; x=1741407098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnR1c/5GyGtBa1Hb7CDFoa51kxLYBIQeZNM4u6R90eI=;
 b=ubujYq5Ne5Tqnk1Q7sLQsGQAiXtErk4rIiLfmT3nnC4BWFHDK/Dbgo/MgqWKfbpaUZ
 aI47jTuLGBRx2sa4ptCgxgAVwveg7rCm4458BBKaz5afCsvDmIX1K8YFYn+c6JxNxuXp
 BDLqjGaFU0PUp+RR257orRVznq5LryliPwgvTTWRLpbPMAxnV8Toy0wFIAKcmEMyyfym
 EPGvYGD6yJZibTUTYbr83oMaaXrwbGcpMM8RrA68xhGgQJ9510gsSrZ/ERWv1sIoYLE0
 ouFeQFHSZ16cEvm/M0qYFAPRcJNsuR7lmKNvmrwkCCwLi1k8IY+rS7az5DGd4iSbcdM7
 StVg==
X-Gm-Message-State: AOJu0YzcXg+sdhaE56TOXonJIhkzQ0uU9UKpYN1jHpqoiNGDKiqJrfGb
 VgRX/CrJPHA6y0+nVk1Q2DvLr1uD6SX8tiCcPE1uW6mz43IbytTLTreikQ==
X-Gm-Gg: ASbGncuYYEdRTma8sUwHHbObY8wFgm7mtMgn8aKicHJ2QljIUAYJpbeRDEHsGm2DuhV
 fbSG0zfTJXWVLHFn4wh8VidfxxL2cvNTdFp9oYP41fGf6SfkfGJEZndy+XOxyfJhVkKxpLuifiH
 UFLd3ZudGbf2753EP77Pt+BHVi9pJotrOM7eKet0D6DYHX3e1Ecz0wRwWMiCKmWEDR2GLPvQMrE
 mjURqrw05jZVSNPfSbXwqtsgCT0ASucbAVdITwKP6iYOQazca7IH/jtKyhyHyRGTmo2lHy3ZQRZ
 WjhD1VvSq9NBm6qkwXDO/eE0YJablXNdBC8uBVoV6Sa3yPI09vTyAW2tf6uRBqXN/n4=
X-Google-Smtp-Source: AGHT+IHXqPvpI5L04lLkSlNFK+//EV4YVFHokn2dEk6FfoKpD3W14X3jbTWpTPruzI2QVkLCKKx44g==
X-Received: by 2002:ad4:4eeb:0:b0:6d8:8a60:ef2c with SMTP id
 6a1803df08f44-6e8a0cce81amr94160866d6.2.1740802298428; 
 Fri, 28 Feb 2025 20:11:38 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36ff0f386sm327973085a.60.2025.02.28.20.11.37
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 20:11:38 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
Date: Fri, 28 Feb 2025 23:11:20 -0500
Message-ID: <20250301041121.9661-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
References: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
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

DCE6 was missing soft reset, but it was easily identifiable under radeon.
This should be it, pretty much as it is done under DCE8 and DCE10.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 53 ++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 185401d66961..2ccb450b35a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -372,13 +372,41 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
 	return mmDC_GPIO_HPD_A;
 }
 
+static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
+{
+	u32 crtc_hung = 0;
+	u32 crtc_status[6];
+	u32 i, j, tmp;
+
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
+			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
+			crtc_hung |= (1 << i);
+		}
+	}
+
+	for (j = 0; j < 10; j++) {
+		for (i = 0; i < adev->mode_info.num_crtc; i++) {
+			if (crtc_hung & (1 << i)) {
+				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
+				if (tmp != crtc_status[i])
+					crtc_hung &= ~(1 << i);
+			}
+		}
+		if (crtc_hung == 0)
+			return false;
+		udelay(100);
+	}
+
+	return true;
+}
+
 static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
 					  bool render)
 {
 	if (!render)
 		WREG32(mmVGA_RENDER_CONTROL,
 			RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
-
 }
 
 static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
@@ -2860,7 +2888,28 @@ static bool dce_v6_0_is_idle(void *handle)
 
 static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
+	u32 srbm_soft_reset = 0, tmp;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (dce_v6_0_is_display_hung(adev))
+		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
+
+	if (srbm_soft_reset) {
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+		tmp |= srbm_soft_reset;
+		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~srbm_soft_reset;
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		/* Wait a little for things to settle down */
+		udelay(50);
+	}
 	return 0;
 }
 
-- 
2.48.1

