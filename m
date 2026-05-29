Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53C8CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C6B10FCB4;
	Fri, 29 May 2026 10:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4yMuxNB";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C78410FCB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:09 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so4269725e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050668; x=1780655468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1g2soikWGEwvlFxH25rsfBGqEUSTkW/yH21MDOXrLuc=;
 b=W4yMuxNBVI0GJxV/4Bhb5B5ucLzsIK8jAsiQIegJ9En3CSCzJgypY5UbIXg8+KKCif
 o3bRvJGy7BAB31iM5vl37iNJoRXqPGqMZD5UM6ZxEWHc2FlhibV0l2AtnsR7wPUkRDge
 gtcJkF6Un7EieV1mJfLMfOz+65agUpW+p+lVAbFmC4nnBZPAYyiGmK1V8aqZMAYynHWm
 iDC5r048o2OBkRpsYBX67YtAu2oKMpzuHjtv03Wfz797L5SZq4JnFjjo11dMbvyXTp26
 CslnvD5oBvdWxlcyRNJkdH1bKf8C/zfoBJ/xNEA5G9jVSMU4bdN7xLGPxVdAhYlPvU2G
 qMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050668; x=1780655468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1g2soikWGEwvlFxH25rsfBGqEUSTkW/yH21MDOXrLuc=;
 b=WxjWzWOqiKe+LAZXta6nS6KXGasfD9y6V9nZaPIUpJHy5RSia9tdtLNyrV87pJ+RPa
 FZ7K4i9Ty34FSRkF4fwR5XVG8MHFhdst6uneJFR1rNGSOXN6LMdzcaCPgs4p5MTyMktJ
 TiXRm/GbmZC49trVVACiwvS4w+xjqW8OAQmYnDi3j/iuvphqaJ5z5K2GSTTFlQqa2D4d
 aKgOaN9FZZwoCzbpE02SiGjDuYF6S7s7E5/Ddf4pGzJ+fX4bOkZo1PMFKWITfuEhmi73
 Al3HPiMlpnF83DK3+NX+MYiN2dIxcPLyCtJTOlrqmMXR1YGhegvjpYnGzf8YLkFWB4nC
 iUZA==
X-Gm-Message-State: AOJu0YwAzT6C8fZlg9xD1tnq2hJaeRlJgtYLdjjFU9oDiYOH2rzAXqIs
 JORDPw1b870DcEhpEMTi1XKdsCJfIr2C+2PWw/BNZcgqHe1xeZYzog/4d/DzWQxl0TI=
X-Gm-Gg: Acq92OHUJ7WdcMM2sPLGy2/YzDS5/ccHDHlrB30fLP9jBUhC7p1PmwlzNd3LX/MX384
 hJLCtAUxi9kc2iLncbNPfEv28ZNRswI45WW6R3j7pYId/iT0dt0mtSVEmCrFUzKjkVT2UfKgQ1D
 9avzKW4ahenlR4PJcQiww2Vvp/HojpsC5FQFkCoEAbNffMlaSytsmZojI1uZn8UryFvnVv8ltiH
 wxayDIFo/QII0DN38ycscW9Z6S+cnoYFBTSzQ+78/3E1q72S4KxSVIShCAptDW43FtgtGQnIctJ
 vZD9JxMw+XbQcTLGYZKWjtRaBU+OeJyAESUgNv2Ha7yn50+xNM3YiqRh6hPztceKvAoReF2BAP1
 3KiwBGbSU1VvEdEZ6RGgK2dwx5gcYrEEXR42OvnRs0IGiBok/4eUWj4T82IYSTVnWoHBC9KYvAg
 kmm7PrcsokhN+JshSOE9XU82lXfQAKMKtTt7vWobzknlgXQ9aaqnUm/uzpuKLQDQCwIAYT1ecWX
 mmR9HWM7V3Hgn0g
X-Received: by 2002:a05:600c:a399:b0:490:5e2a:dbaf with SMTP id
 5b1f17b1804b1-4909c0b344dmr27997535e9.21.1780050667677; 
 Fri, 29 May 2026 03:31:07 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:07 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/7] drm/amdgpu/gmc12.0: Use AMDGPU_PTE_IS_PTE flag for
 init_pte_flags on GFX12.0
Date: Fri, 29 May 2026 12:30:57 +0200
Message-ID: <20260529103059.21470-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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

According to some SVM code this flag is necessary on
also GFX12.0 not just GFX12.1.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 586703ec0dfa0..7bbf5f848ce1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -641,11 +641,12 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 
+	adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
 		gmc_v12_1_set_irq_funcs(adev);
-		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		gmc_v12_0_set_gmc_funcs(adev);
-- 
2.53.0

