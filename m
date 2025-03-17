Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D6C35FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB11F10E2E2;
	Mon, 17 Mar 2025 06:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fYDpwO8o";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253C410E2DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:29 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-471fe5e0a80so37376411cf.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191647; x=1742796447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=97a57FFucYk6i0P8dY0xsS4aMg003QyZQ+q8Q+4QQfA=;
 b=fYDpwO8oz4jSfdVi1a5kG6s5LLbYZ1/9CQVXOgqvKD7Z29+Lld28PFGEPMgyCAylxz
 TVy4QPU23yxQ8byDjI0UtM/IC2ZAQyBVBnV5T8Yz5panTKtMANpkJTPwimUDR0SyK0fE
 eBOut5MYND8Bo6RP/xhsuSPkSEh1YzCVogufpOOw6W5y8duq/iVu5hjGCqMxldfGzO16
 CiGJsiUIm3KoetGkkYb+TI/c8tUH9V8OQuPhTE93OO3wq+78iwJMjbuvDWBPcOPKrEQF
 Ark+E/ztulM3aEz+EhcfwhrUuRDteqzeh2UekppL9MFwGQR/JAz8ixi5iRW6IsT3AAl7
 R74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191647; x=1742796447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97a57FFucYk6i0P8dY0xsS4aMg003QyZQ+q8Q+4QQfA=;
 b=rbukqzlCzPVDIQKXqHMEsMggoCO/poEvIqhfSGGpWtVc+aFTAXv/CFHxhaF3FwHs5I
 5js6YSahroKgJgCcFcMwXGbOd7JSGoFuV7luQWCiv0k21qOPD6tTbuhEqnzDQz2+APl8
 ClmYckx7TKdPpqvKpFPJHlF+EafD0Gwi7Skgq9XnuS7zAib74Iczis1Wl1tf5WytYTEs
 5g4oVkeIztqXtqSvfVbtg/a2iSNake4FeW1FohkaHVxDClD5aEQTT7xhnWh/NasDEPdK
 2xpOC6UNMU700M9fhDJdQ5+iYymYoCKCNMiZI4LlKnGnUc6Bqr4zjzQ3NrIchdss0nlE
 KuGg==
X-Gm-Message-State: AOJu0Yw6ZWuUmDq33u2dDfg3Xhf76HGUyxJ5PT3zNx0P7j5U63qDnyFQ
 8Tydl8+FYSYHpJE78y0Klk4BiyBJJU/MZpW4Mz8el5Lf1aNQMfNHjXgyhQ==
X-Gm-Gg: ASbGncsaxzI6DR2Md75PaeeCkZ9bou6dswQ/yTnu2+q7GrzbVcwAk+7FuAzDjNauImh
 glcjif3TOsWWmuY5PBErjEAacV9iptVoNrB26xqKYwpZetDgaIgw1dJlYDB+6JmBa5Fr/gWHvlD
 SLL0fEyAiBRtbO0icklqjoKovEIK2v2frakMeiEcskgdU7NIdtDfH5InMYaRcjkCyHgo3n/Jb8j
 J3hC3iOPsaWhN4rPkmTiasLPcASHpmJu2Kpq/tCcUVh92aWkc+i6/8kCDPqd3i1zJU7TraNbL9e
 bjAiSJSgiRAy/RYLG1PGJOD49IdCGjA1i2ZDNcRmi3JH/fEFUte6ssK+5xBD6pgDU80=
X-Google-Smtp-Source: AGHT+IGj0C+8QZJxWlVpFlbO+vuga4HGshi84GGnSPYKtjVpCnRCvMR2VXa12IouYtkMy38fPJm1uA==
X-Received: by 2002:ac8:7f11:0:b0:476:a967:b242 with SMTP id
 d75a77b69052e-476c815a099mr193429371cf.30.1742191647003; 
 Sun, 16 Mar 2025 23:07:27 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.26
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:26 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/18] drm/admgpu: move si_ih.c away from sid.h defines
Date: Mon, 17 Mar 2025 02:06:49 -0400
Message-ID: <20250317060702.5297-6-alexandre.f.demers@gmail.com>
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

They are properly defined under oss_1_0_d.h

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_ih.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 94468c87122a..234bb76d12f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -214,7 +214,7 @@ static int si_ih_resume(struct amdgpu_ip_block *ip_block)
 static bool si_ih_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 tmp = RREG32(SRBM_STATUS);
+	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
 		return false;
@@ -240,23 +240,23 @@ static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(SRBM_STATUS);
+	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
 		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_IH_MASK;
 
 	if (srbm_soft_reset) {
-		tmp = RREG32(SRBM_SOFT_RESET);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(SRBM_SOFT_RESET, tmp);
-		tmp = RREG32(SRBM_SOFT_RESET);
+		dev_info(adev->dev, "mmSRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 
 		udelay(50);
 
 		tmp &= ~srbm_soft_reset;
-		WREG32(SRBM_SOFT_RESET, tmp);
-		tmp = RREG32(SRBM_SOFT_RESET);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 
 		udelay(50);
 	}
-- 
2.48.1

