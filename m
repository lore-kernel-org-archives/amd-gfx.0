Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2754DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFCF64DD6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFCF64DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D38189FAC;
	Thu,  4 Feb 2021 18:47:18 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2282889F07
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 18:47:17 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id a19so4402342qka.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/XBJeSfByryHzyEKoUtDqgXLHA7rjKIiGsYLzqypojU=;
 b=am/fbCFOE12gh2LtI0C8jSaWpph+O08AcT8Bd86RP+sEsk2riBXT8PGy1yrv6ZBwRj
 Zp1z6VlE7+7oNH/JMuH1PI1FJH4//+5k1YYxOywR+/jevpyIc5bipU0EsrqzpyEmjGZW
 B7GJEhcUg4G8JRtinYV3REQtWHrK+0AM2LyRJ7pieUxe6evLJGirVvNP8Ccr10mzipl1
 aJ/dm9rzmlvj80Yj3T0VST5UdVvUl/6jZBPVGfQuvzrOUWW4XPtr87Hv7Ers+PU8hMkF
 jZRUhhCORFrK9vwV8l+VQ8JVc+gMb3Ho+ltjiEycspKTmrexBYW2SlhycBYWqlTlJn85
 k/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/XBJeSfByryHzyEKoUtDqgXLHA7rjKIiGsYLzqypojU=;
 b=J4alV+A9xUsdZpYPvnJG/Ru0OGPUSzl11eZXf8xFdnHaagn4cUZEHFdB7pBUJu02Sn
 PhlefZMgntWgeLgWIbuqmCtvSWDuomQjZGAqCx5jcBWDe/u7DXekh6JbeAGfp+Q5J/0Q
 CLhPLKA29Hu9c9lGOFKLDngf40MB457fhcTShC9k82XQX2YRn95cSAkKOKxNDejhikTz
 nPEEc20iuDaAVWm83dCCwgYlruV8BDW5HfkWwc3HW6UnA6xAAY7RMmb0VgX3LN/LFDmb
 01yD+NQjGffG8ucViwab+rjEQslL4sfXAjcKC/RDlvFruNu0VcDKAyZ1+e7MwCv2eEQr
 wvmw==
X-Gm-Message-State: AOAM53097/l8TcwUbEbRC5dM0hKFyanfhDe5nBs17SdnGS38vWWuYkpn
 /FJo1vaqw+bQBBRh7OwvjZHYd2pNBOo=
X-Google-Smtp-Source: ABdhPJzX4Tio5Ae8ILREbFdV8uOzMkWCEOfwsalxIF9ywHZtvDnCb+zWmzOhmYyPkShAx7Mia58KWg==
X-Received: by 2002:a05:620a:b18:: with SMTP id
 t24mr526925qkg.65.1612464436211; 
 Thu, 04 Feb 2021 10:47:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j188sm5833644qke.67.2021.02.04.10.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 10:47:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu/vi: minor clean up of reset code
Date: Thu,  4 Feb 2021 13:47:02 -0500
Message-Id: <20210204184706.168934-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204184706.168934-1-alexander.deucher@amd.com>
References: <20210204184706.168934-1-alexander.deucher@amd.com>
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

Drop duplicate reset method logging, whitespace changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 36 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 2bfead243335..ea338de5818a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -831,11 +831,21 @@ static int vi_read_register(struct amdgpu_device *adev, u32 se_num,
 	return -EINVAL;
 }
 
-static int vi_gpu_pci_config_reset(struct amdgpu_device *adev)
+/**
+ * vi_asic_pci_config_reset - soft reset GPU
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Use PCI Config method to reset the GPU.
+ *
+ * Returns 0 for success.
+ */
+static int vi_asic_pci_config_reset(struct amdgpu_device *adev)
 {
 	u32 i;
+	int r = -EINVAL;
 
-	dev_info(adev->dev, "GPU pci config reset\n");
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -850,29 +860,11 @@ static int vi_gpu_pci_config_reset(struct amdgpu_device *adev)
 			/* enable BM */
 			pci_set_master(adev->pdev);
 			adev->has_hw_reset = true;
-			return 0;
+			r = 0;
+			break;
 		}
 		udelay(1);
 	}
-	return -EINVAL;
-}
-
-/**
- * vi_asic_pci_config_reset - soft reset GPU
- *
- * @adev: amdgpu_device pointer
- *
- * Use PCI Config method to reset the GPU.
- *
- * Returns 0 for success.
- */
-static int vi_asic_pci_config_reset(struct amdgpu_device *adev)
-{
-	int r;
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
-	r = vi_gpu_pci_config_reset(adev);
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
