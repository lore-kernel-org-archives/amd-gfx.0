Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6333DC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 16:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3132253D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3132253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C996E32F;
	Mon, 14 Dec 2020 16:03:46 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D6E6E3DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 16:03:44 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id 22so5797376qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=69czKCp4n2Zx65mhINca2uP2JKK13Xmiet9JXqlGmZ4=;
 b=O+Svf5kcELLtY/9rdftFfMYukqLjl1jW59e3MAl/5JdaS0V3ILaNxCTJNBmYdxiamQ
 SKqt41IzV9tyhQ8cpzb7uHpViWwVkuNnf2xHZ05bRjOcrnloJZc1trGCx2r2ieWtGQhn
 gFB2KEsex4XtMP3hH+1CABJ/vr/H6b8kz+kSr4ybH7qZBZgTVFJc05iExLGIsdeOcFAO
 1d8jZpTrN9iz2n7o6Yb/TK0COufV404ZRl3ohyA64EpoZpteqASBYdSucIY2O/0s8y6U
 wma9qYnYmV8eHPMDUzG0/1uzmzur5uB+aSgsJhEOpWHFP2RZ2KwGCfacU9Qf6xIOTRrQ
 IYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=69czKCp4n2Zx65mhINca2uP2JKK13Xmiet9JXqlGmZ4=;
 b=kmiE+igDOBwk73NJ2FccciyHACxDLHGcIFxQ1WVXwqKknvctDTmvX+0cc2cv5el9qm
 AMtXwVrqDnbLF8HJ1AmqX2ZAWyOh9R/pGgcm6sbsrBjE2d7IUmN9RnWrdpBiq5mWmyvd
 5ods2o8f6kaVeMHfrQKtNcLNJ3+4NpKrIWGd8uVEcH2xivitEy4BUFav1AKPYe6iy0V2
 HEiG0ENs6cCIkVXsg+4HdmddC5kDEcChs+4UFHfccWBvDnqgB4iQe9nBuT5Xs7ayUlZT
 ieJrN5RJE6dBEuxLO1d+K3hIpOXk2RKyZPZQK2xDFtpUO64v9avCZQrlos2cxvuROu+O
 f8lw==
X-Gm-Message-State: AOAM531HOWPchV+olpKCDJKoNPq3ffBUaIz1fAn4u6WOxdF+wqNYGY6y
 VjLNBY15rDE4M4Cz0gCvEAv0XQKfCVs=
X-Google-Smtp-Source: ABdhPJz01aprx2RUgGynyZHDAqEoIrCdVTDjwkS7s6Ebe43X2Cz9A1+cgwPtzYOJKXAs/F8cXIGxeQ==
X-Received: by 2002:a37:9c82:: with SMTP id
 f124mr31848648qke.369.1607961822611; 
 Mon, 14 Dec 2020 08:03:42 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id b33sm15440494qta.62.2020.12.14.08.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Dec 2020 08:03:42 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix regression in vbios reservation handling on
 headless
Date: Mon, 14 Dec 2020 11:03:35 -0500
Message-Id: <20201214160335.771801-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to move the check under the non-headless case, otherwise
we always reserve the VGA save size.

Fixes: 157fe68d74c2ad ("drm/amdgpu: fix size calculation with stolen vga memory")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 02af47ddddbc..c2ced5be6d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -496,13 +496,14 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE))
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
 		size = 0;
-	else
+	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
 
-	if (adev->mman.keep_stolen_vga_memory)
-		size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
+		if (adev->mman.keep_stolen_vga_memory)
+			size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
+	}
 
 	/* set to 0 if the pre-OS buffer uses up most of vram */
 	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
