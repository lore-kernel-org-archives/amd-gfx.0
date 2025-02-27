Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD0AC1B0FF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BBE10EA3F;
	Thu, 27 Feb 2025 05:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nc7dr8zR";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802F910EA3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:23:00 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c0a974d433so153098685a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633779; x=1741238579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGWWtZLlOzXcUVYutw2hNcQ02A1iRHMLo/Hbp2etQX4=;
 b=nc7dr8zR76rVG+jmyUuRQZc9Yy2hsN2xVetnx8+BEUqy02hTjZRRBUAuLMbyegibwS
 0oW6ojcva1sZKKzpJVaEUDMkdkaAGFloFzxgBBc1uPwSDZsQ9iV6c/GKxROYufoUROPd
 D/ifcRvFUP3Dv15/GVSxkhw16tZCem5qnaFJByxpUcd/T+83h1+iSpR2hdFOb7HjLSvT
 wC5nVQf2/zueJioevRpB2x9apwqRBys5eagwC4sm7lIHYlbdtWQuw4BAMjdN9eC3fDnd
 0kyDnviMigC/Wr6Sl3nOCebWZGsZDcE6SwC2WPZKDJt0j6XxuCRsb6AITz46CiJHxZbX
 bbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633779; x=1741238579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGWWtZLlOzXcUVYutw2hNcQ02A1iRHMLo/Hbp2etQX4=;
 b=Wy4TLHXPdQrq4KXLybYpoiv3xldQfqUtaC0ki20enbR3kLa03NAxg6iD26QszadsGO
 T5T6+tjutq4w5gqbZgNp4Qw/+rmSkoSTypwJqOaqSvZ7YDcdDO9xfoIJrn0Bub2s51Yw
 52o2VGK/vOf68H1KDLMxwmrd+WMli6l+OkBP3nCUWIVz9OCo/P8F2r0w2BfxliH7ubGg
 Dc1UHH3k41X2P1dVMyd6gYuag4vmElNptmrqglGv6UenKlIJj1z35cyN1ezk1uONdWZR
 jmWBipGQjZD5g8hv2SzGSZGeOorWK5KGm4y94jBdQrXF2Ux9R70kjwBbFHI1xBOqZvY/
 dNMA==
X-Gm-Message-State: AOJu0YyWhQdU62LjGIZ1DCcqUMn4DrPfCj673s0JNM61roUsdaQiHBjq
 LXSUDRURL0GcjPGwAEFbIH92qEXZZ5mNzqd5GteJp3KXz5tndA3kv0fdJQ==
X-Gm-Gg: ASbGncvfiwTknqzOuCTj/LKHDXrrvDIFPna74MV1CGX5bVOu4Gu5/I2tv1m54/96wUu
 /zMf1dvwpsRydqqKft90WARTlPOQwqnNPFDZoaWNWYcj6k6CEaSsG1P49fMm25qUETs3ER5RVsw
 vckeOLcAQwFIRENzMtHJLnePwundBiFFK61tWnn1/IzOD1U1Ha/n1GoqQzoH/y/UMINtb+Pj/yO
 JckHcGGL1Dw2Hwk1ZEO452FVp/jrOFdVkIlEARk1NY2dSXEs977ajA+f7G+mg0vW6m58w0Ohv2N
 txZzsgO0rnH/oD8hzZdQcvH21Humspr9jEQ6a2Rx/0h0GmKm
X-Google-Smtp-Source: AGHT+IEwm3tQEkR0y2qNG1PgUVWkyySWAl7ZLn2bNbv7vXdQxALeaTrEv9xaRGxp41lZ0An/vUfj9A==
X-Received: by 2002:a05:620a:1a98:b0:7c0:770a:d19 with SMTP id
 af79cd13be357-7c29f427cf2mr327144485a.8.1740633779576; 
 Wed, 26 Feb 2025 21:22:59 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.22.58
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:22:59 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: complete
 dce_v6_0_set_crtc_vline_interrupt_state() in DCE6
Date: Thu, 27 Feb 2025 00:22:38 -0500
Message-ID: <20250227052241.171102-4-alexandre.f.demers@gmail.com>
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

dce_v6_0_set_crtc_vline_interrupt_state() was empty without any info to
inform the user.

Based on DCE8 and DCE10 code.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 254cb73324c6..e805c4f9222c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2957,7 +2957,51 @@ static void dce_v6_0_set_crtc_vline_interrupt_state(struct amdgpu_device *adev,
 						    int crtc,
 						    enum amdgpu_interrupt_state state)
 {
+	u32 reg_block, lb_interrupt_mask;
 
+	if (crtc >= adev->mode_info.num_crtc) {
+		DRM_DEBUG("invalid crtc %d\n", crtc);
+		return;
+	}
+
+	switch (crtc) {
+	case 0:
+		reg_block = CRTC0_REGISTER_OFFSET;
+		break;
+	case 1:
+		reg_block = CRTC1_REGISTER_OFFSET;
+		break;
+	case 2:
+		reg_block = CRTC2_REGISTER_OFFSET;
+		break;
+	case 3:
+		reg_block = CRTC3_REGISTER_OFFSET;
+		break;
+	case 4:
+		reg_block = CRTC4_REGISTER_OFFSET;
+		break;
+	case 5:
+		reg_block = CRTC5_REGISTER_OFFSET;
+		break;
+	default:
+		DRM_DEBUG("invalid crtc %d\n", crtc);
+		return;
+	}
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		lb_interrupt_mask = RREG32(mmINT_MASK + reg_block);
+		lb_interrupt_mask &= ~VLINE_INT_MASK;
+		WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		lb_interrupt_mask = RREG32(mmINT_MASK + reg_block);
+		lb_interrupt_mask |= VLINE_INT_MASK;
+		WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
+		break;
+	default:
+		break;
+	}
 }
 
 static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
-- 
2.48.1

