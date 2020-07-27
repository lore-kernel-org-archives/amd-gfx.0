Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1197CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 17:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1EB20729
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 17:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duR2ZUNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1EB20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FE589DC1;
	Mon, 27 Jul 2020 17:34:48 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1F389DC1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 17:34:47 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id b25so12841272qto.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kbd9jVmog0d/NNrXKeUnImiOlseECHE6AvjlxCC8w1M=;
 b=duR2ZUNr2ABhMri1vEv8Ctzqd2dc662zfsCgQoTE839Y783yX9u5pORBpt39e1Z/RZ
 aPJEzpFyIKo1MBNz/fmn5TxGGRM/O3/5O7NVQFQPIZlZFdJ5CUYw3isnhaG1is29/S9Z
 Mr3AUiGw4zIpgJy95HZhwPgRkbQHlbSk6poq9Z6NcE/tuKCFrHx0W6S4DVra7LcjtQi7
 /6+hZoSKeLYAiXlathAtKCDNq337/Ze18tOb5EBIXlHgmYaEUc0f+BiXhJd7cAdx1hJl
 blhkIHzbwZ8AsVmkzDAErDJmRxJlVTNf0GbxLwbZMTmc8D4sG7L/I+MfCFJ8Zr7wCHpH
 WGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kbd9jVmog0d/NNrXKeUnImiOlseECHE6AvjlxCC8w1M=;
 b=q/nzV2Vl2vBI6iBjE/gWxH/17eurejxySBkXELOH0tRiK5YE0fN+JyqSZME7t2nYBF
 PpMa5ova1NbY28rr5WDSsKOjMpUCwUg7wg7mDUfSGaONrx2Mv1fSy/OhCnCnh6mY9F8y
 5ozihAzHBUAfkHY71v8cBE2vM8Ph9OGWMAczE+5EhBJWsrfznmb/GmBRDhFTmUJSenxt
 nLNe8WTCuXmabp+GJuqrI7q+ZRtzvSsvJD8BW/WrasH1g5Tf2XZ1zwE5XqOrIMV4Ut+E
 tyjuvtTaSUqkkirUJgdudGaStWMKuFcAq5hpSFodeflrtMWcL7FQCehAKeoECJ+K4Flf
 kIvQ==
X-Gm-Message-State: AOAM5333bG6evrqGeUkUK4oQ8/UyaC3qeSfEmLryFJXe0IbrHwB17i6T
 dAH5hXAqZo9YW8tMcbBI7RIVxyw3
X-Google-Smtp-Source: ABdhPJyR/JnSPaL2+AQj4JTAZY+hCmRNKzLiKe37Wls0HUNtGdZI9v40nVpbZIr+RupCD4SB1XX+Dw==
X-Received: by 2002:ac8:65d3:: with SMTP id t19mr23130107qto.193.1595871286339; 
 Mon, 27 Jul 2020 10:34:46 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id b22sm17704656qka.43.2020.07.27.10.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 10:34:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/si: initial support for GPU reset
Date: Mon, 27 Jul 2020 13:34:37 -0400
Message-Id: <20200727173437.117009-1-alexander.deucher@amd.com>
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

Ported from radeon.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 92 ++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 1b449291f068..a7a45f06c8f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1215,10 +1215,98 @@ static bool si_read_bios_from_rom(struct amdgpu_device *adev,
 	return true;
 }
 
-//xxx: not implemented
+static void si_set_clk_bypass_mode(struct amdgpu_device *adev)
+{
+	u32 tmp, i;
+
+	tmp = RREG32(CG_SPLL_FUNC_CNTL);
+	tmp |= SPLL_BYPASS_EN;
+	WREG32(CG_SPLL_FUNC_CNTL, tmp);
+
+	tmp = RREG32(CG_SPLL_FUNC_CNTL_2);
+	tmp |= SPLL_CTLREQ_CHG;
+	WREG32(CG_SPLL_FUNC_CNTL_2, tmp);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (RREG32(SPLL_STATUS) & SPLL_CHG_STATUS)
+			break;
+		udelay(1);
+	}
+
+	tmp = RREG32(CG_SPLL_FUNC_CNTL_2);
+	tmp &= ~(SPLL_CTLREQ_CHG | SCLK_MUX_UPDATE);
+	WREG32(CG_SPLL_FUNC_CNTL_2, tmp);
+
+	tmp = RREG32(MPLL_CNTL_MODE);
+	tmp &= ~MPLL_MCLK_SEL;
+	WREG32(MPLL_CNTL_MODE, tmp);
+}
+
+static void si_spll_powerdown(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32(SPLL_CNTL_MODE);
+	tmp |= SPLL_SW_DIR_CONTROL;
+	WREG32(SPLL_CNTL_MODE, tmp);
+
+	tmp = RREG32(CG_SPLL_FUNC_CNTL);
+	tmp |= SPLL_RESET;
+	WREG32(CG_SPLL_FUNC_CNTL, tmp);
+
+	tmp = RREG32(CG_SPLL_FUNC_CNTL);
+	tmp |= SPLL_SLEEP;
+	WREG32(CG_SPLL_FUNC_CNTL, tmp);
+
+	tmp = RREG32(SPLL_CNTL_MODE);
+	tmp &= ~SPLL_SW_DIR_CONTROL;
+	WREG32(SPLL_CNTL_MODE, tmp);
+}
+
+static int si_gpu_pci_config_reset(struct amdgpu_device *adev)
+{
+	u32 i;
+	int r = -EINVAL;
+
+	dev_info(adev->dev, "GPU pci config reset\n");
+
+	/* set mclk/sclk to bypass */
+	si_set_clk_bypass_mode(adev);
+	/* powerdown spll */
+	si_spll_powerdown(adev);
+	/* disable BM */
+	pci_clear_master(adev->pdev);
+	/* reset */
+	amdgpu_device_pci_config_reset(adev);
+
+	udelay(100);
+
+	/* wait for asic to come out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (RREG32(mmCONFIG_MEMSIZE) != 0xffffffff) {
+			/* enable BM */
+			pci_set_master(adev->pdev);
+			adev->has_hw_reset = true;
+			r = 0;
+			break;
+		}
+		udelay(1);
+	}
+
+	return r;
+}
+
 static int si_asic_reset(struct amdgpu_device *adev)
 {
-	return 0;
+	int r;
+
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+
+	r = si_gpu_pci_config_reset(adev);
+
+	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+
+	return r;
 }
 
 static bool si_asic_supports_baco(struct amdgpu_device *adev)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
