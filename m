Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB414C35FFB
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8CA10E334;
	Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MTr87i09";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805C910E32B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:36 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-47691d82bfbso13843711cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191655; x=1742796455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tuMuCGPTZ13V/onlwapzElJRl5Izo1uzl4o/ul/vubg=;
 b=MTr87i09KeN4RyqDFHSn+4sW5+UuNb6/oAnufVaYzV0ycDPH6HgJxtR3HgF2b8QDRo
 38XtDpUBzPiZVyZpWpXd28AS0l/CRiJa2bBZi/RKgtDotYmd7LS2X8Rn1W1GwgBpFOjE
 pRqojaW7O1074f+xoAh4mEVgWa3mtgsXw5nQIczGZdj1Q8GVxJDVcctOk0E7c6DcHXWV
 VVaz+p8a0A+nK9YoFQKZuhTNxsLph84ug5wwyVFPfq3Kq9NbbTNCOHtF2PkYCQ56Jfn/
 ReVz3RerkjEloOGZkcpSsi3K5Ja6GdVc/ytFEcpwFCdLreMi0qmZRvQHhEUeMk/Jduys
 bEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191655; x=1742796455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tuMuCGPTZ13V/onlwapzElJRl5Izo1uzl4o/ul/vubg=;
 b=P4Nf+nNFw7TI02wpfCpd1u0tjylu3UVmdwyXAQznSSQGqCS68ijlBOuSkanS4WBaur
 n/NZrtFlk2L5Lnx9bSAHsWtEuKL3Ku+tnaOF35OH10BgKcozrRI3c/7WpXKVzhx6vaJR
 1E5eml6AhHwL5ZmA9zMaZcE9f7Go0ljawBIf0fGm3MAqzIpeiS+rQz4y7B7yrqIMQ+V7
 KbH3FjwO7BNi+ta/e/G903T6Z6XAorTqsmZuibxVGeoVjQL5kZZEvgnBjKV2ymOStlPm
 KSZ8RfPgwAU3htdInVFcA7OH6bOupozblmXoC8hXVOx/NWrsu76pKcunUmYvx/8u4xDs
 +iWg==
X-Gm-Message-State: AOJu0YzbwpJcsAVDVOrcvnAtHVQY1fv0kBPkeOGZY4RUfkgo5dsFpM8S
 thecmJXJ3/cUCSIaUE5K7jnQjnWw9PDI3sp5Q9P0yCQrM9PfINYguyUqoQ==
X-Gm-Gg: ASbGnctB5gY/gbr5cGKcD0zDEbCfOzdSkSuILP141dG769MEjct8Pw3MscmpPvWnl7w
 MlGn506LCV2BsiVTXVMaofo5nQ/JRljo/cSG4Kq2/M3PvxUzKo3vJVIr3uQP/J+/0M6WWSco6IF
 NlVh0jG0P0Q3fJVkQdndCnz+oGDAT6dRH6ekSVSMWVoF8Hbk7iK4S55dCOIDQ4sneqaQpstadPf
 KrSSuQJqk7bMrmRG9CGmwDcunYGMHHK8umYFvV266i03EkyHmeQQpWcHYp69NpZUuEsStdkCH5r
 5pXshTKPFsereau82vGsXlMwGO6sELzcoka1XgPa88JUKM2Mm79SIDlhCnY8Emw3qSg=
X-Google-Smtp-Source: AGHT+IEt4I8x3Gvo+K5XdWsNupulvOKvcoXvBkXKcvXa/wUCUOpgschgqaXaZyCpesIYULxEFbHsbw==
X-Received: by 2002:ac8:5955:0:b0:476:7199:4da1 with SMTP id
 d75a77b69052e-476c81d94b1mr160152961cf.46.1742191655343; 
 Sun, 16 Mar 2025 23:07:35 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.34
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:35 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/18] drm/amdgpu: keep removing sid.h dependency from si_dma.c
Date: Mon, 17 Mar 2025 02:07:00 -0400
Message-ID: <20250317060702.5297-17-alexandre.f.demers@gmail.com>
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

