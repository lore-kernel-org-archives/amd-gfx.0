Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BC5C1B087
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAD810EA32;
	Thu, 27 Feb 2025 05:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6dGk6F5";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C5C10EA2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:22:59 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7c0ade6036aso155004785a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633779; x=1741238579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uH/FFT8bRxjJa6U6nUaga+bWpw6A0WqIfrFpwf1SXww=;
 b=c6dGk6F58rGOOcRQ3XoOQu3Bnr73SM2RmuzyZKlcvgVl+U1t3qx+/JhoYFKbop0STX
 bGVHza13glUhbs8suu4c6xWg5++wMN8MWHTtDi0IcZfpi4gLxkN/M1smOwfH+U7/WLg5
 cGgdYDjWkWCBPXsv1cssaiiCKjwhy/Ok5pSVhBPfksWQ8iJqT/x4s9HacvsvdP70ZF+y
 ji8S5M0W7kkTY1Hcze5+5xgktb8nilIQB8tmwAy1QtNWr+7eWHDvi545MbQViWeQpsIi
 h3QYGpbMDWaqlmbakYkfNDoysgj2uee+98Nu5ney6ZwVStaeYsBfzil4j/Lm7rTUU897
 cYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633779; x=1741238579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH/FFT8bRxjJa6U6nUaga+bWpw6A0WqIfrFpwf1SXww=;
 b=hglBjykzcR0zV2tMMEMMm/WoHyrTNAovV/sYZXHyd387rNWv1jcTEl3PlxyDpCdp1B
 Q/ROdyX7+MQ6tVA5kpir3XahLexv2PvKsn+aybQQPXYkV3hNGq5wa0Oqjlt0CwouCLXE
 YLUvwBUTizQX3A5PZbxTdbD+J9Z9FSpdsMCT3+pZk7U9+advxSN7+hgQ23p1DNHbwWZ2
 4g0E+Dfq2pIhWiagngTaJGP9BWZ0s//i03s5QmssgJ/TzJxZwlRE0XRzdf8F6NS7O9ku
 sjDObfDBw5JQMCm4a4zaYyHuXMt0v5zxptJ5DtM7Lb8CoDDfPQM3bjIuKp7+PLevsPER
 CEyA==
X-Gm-Message-State: AOJu0Yxf+Fqugw0Lja6gY645ptluQNIGu/5Xkq9ieetBCl2Mz6xxJyp7
 a38k9UjrERxpQyDjbGiUmNtouxEqMQyDGOpv37xcuHSWG2WH3QQjo0Jrmw==
X-Gm-Gg: ASbGncuOie9vJJUEtXwaQhTWDCFGjm6TXWYrhP0Oua6ZSNKZdAuB6GOm2daUKAtWaNX
 lJnEvnRM5NBJAhhMhcbx7x2wtqA+V6ijQN8j3tDUmhp+9FL5z8DplDcy0wfvvI4/LfHZD85JDJz
 4/6AHMYgnM2h+a+QKLAbaEkF4HFo5NWLcVtglLQ7amd5l0Zh4nseelDBUeKMcvYumYv6FidLDc8
 xNL+wzW5Q0yz58Whb92Zq3YexE3vK877G64Ifhl16cqUNs5IPviASARQA93PZ7p1UeN/aLmtCGu
 N3ETYKh7NPIGLJ147QTMIHNIuaFHq30UBJSbgBbjwiq0HP5b
X-Google-Smtp-Source: AGHT+IG0l/0yBpofokt37iUegsYVo/MHaWcHYl+zF+1DWLi8ZpCe2B2Q2WtTOpsk/DY7Lgz5qJWqRA==
X-Received: by 2002:a05:620a:1a98:b0:7c0:770a:d19 with SMTP id
 af79cd13be357-7c29f427cf2mr327141185a.8.1740633778797; 
 Wed, 26 Feb 2025 21:22:58 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.22.58
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:22:58 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
Date: Thu, 27 Feb 2025 00:22:37 -0500
Message-ID: <20250227052241.171102-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index bd763fde1c50..254cb73324c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
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
 {
+	int num_crtc = 0;
+
 	switch (adev->asic_type) {
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
-		return 6;
+		num_crtc = 6;
 	case CHIP_OLAND:
-		return 2;
+		num_crtc = 2;
 	default:
-		return 0;
+		num_crtc = 0;
 	}
+	return num_crtc;
 }
 
 void dce_v6_0_disable_dce(struct amdgpu_device *adev)
@@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handle)
 
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

