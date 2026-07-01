Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786B3C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FEB10F02C;
	Wed,  1 Jul 2026 16:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fh3ERMAM";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A2C10F02C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:53 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso753454f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922671; x=1783527471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEa11IbxaiFsvzn7QH+F/vhq22AazijOON6d49zLl+o=;
 b=fh3ERMAMSSADTpIF/OmunDhkYX7LeeVakBUEpnPoUGglsQNhi1YFSTk3cH+3TJHTrK
 PQM14q/sqBpLAq8QCYS3e0iqsKtAnSNBHEuKiBhR7a+p8JGqPP6bYaR3GhmPjDNOO5k0
 n065SKZFeUOIZOXCPTrmwHs7cLe1LHo2Q1yCqypYQzQPK5M2wE5j3x5WR9kBxJkrTzNh
 9KB8BL3XsY1OGph/p6mktmL5S/M6JkPtgxkvg9Bo1mqcRUQkz9b1eE4JfirzEBYQUrVL
 VpRu0o8ZUeiuUBzOgpBfsZhPbhjbpYt2QENOz+FDLXVnlp2VUPnoKrxJAs56eM8foXu/
 NRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922671; x=1783527471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEa11IbxaiFsvzn7QH+F/vhq22AazijOON6d49zLl+o=;
 b=jBxYiz5a8diM/QGbCZUz9+7gxr2SFu2k+7nvj6TrsLHEo6MnTJH9Z6e7/TVHl+uXNx
 qn+47MLqsA8NmOZuXx/jEQmFdVLfgQeM4hmDfructoCQ6QK1xERKYsvjYLRh6hzD+ud8
 DbjFrVVr7gPemVkulBAiwPBDjorWBS3/qTHw5Tx+65LEe3X5ucJXKeSNMqgVPPk1R2g/
 ZW2LS7Aq4cY6ohT1vA1GG1kIRhNSNyfgsYsXc5uWahfciSxoQdOyiJM+2rR97L2iqIqd
 gewLJVOeSK2g+XYw9UK6iM+61Hwj34Pkubjtl4h0tFLiUdCy1ohBklHwZY+Qw2VnFRAG
 1Rcw==
X-Gm-Message-State: AOJu0Yxs8ukDykGL2MM6d1xDzRm3rRGp46ZLVTeEhbfUCAoNEjlAyPtf
 QbB9n3CJDO9l+9cL8igd5eJo1h4HzABb+XA0UJbwCZFO5tILevwmipoLFOzrtnn3
X-Gm-Gg: AfdE7ck38Tygd4xEBOVatxTeRxw5BHfcd0+1v4inbXZEZYEDlM/vRWPJ0dsRCxidyX1
 zDnLsMazqwcOHvRmnhPvNTniTAgnKeE04d7GKLzahRlDnJwRO6pj5X8/d2vrHOhcq8IrMpl6uS+
 CntgwqU99y6dzpzks+nsGC+PeOQwRmix/pcrmTFT/kmN4PL2ChNHWNG4nRBajQadOJWddsoHoE/
 +fbzKuzM3deLzn0iwIo7bZmODcHaNXqzLehZ91+MrMN3A+qwJhUt6+B+Y7+4z1mk4f3mAYif3J4
 UG6antbQvecr+wkDHZA5kKrQ6XmYUUV0cEnJS853BXcIMjPs2wI8HgjErUBMuYmLfU65blgMYvq
 6wkeIXFyT08Nl3du5C87GyIBOlXf/FIM2lvx6YS6iZFRVMSMVB/UYtlv6zb37MSD1E7cLrPBalY
 HR30mEIkTDiF7UW/g0M4SmfHsh2lc=
X-Received: by 2002:a05:600d:844f:20b0:492:5bb6:6d4b with SMTP id
 5b1f17b1804b1-493c3df77eamr17664395e9.34.1782922671459; 
 Wed, 01 Jul 2026 09:17:51 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:51 -0700 (PDT)
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
Subject: [PATCH 14/14] drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
Date: Wed,  1 Jul 2026 18:17:21 +0200
Message-ID: <20260701161721.85681-15-timur.kristof@gmail.com>
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

The retry CAM can filter interrupts which occur repeatedly,
such as page fault interrupts when retry faults are enabled.
This makes processing those interrupts much more efficient,
because the CPU won't have to deal with processing the same
interrupt repeatedly.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 291326d2ee8b..ec0919fa8254 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -390,7 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
-	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
+	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0) ||
+	    !(adev->flags & AMD_IS_APU)) {
 		/* Enable IH Retry CAM */
 		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
 		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
-- 
2.54.0

