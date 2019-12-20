Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC5C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FD220866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anq9gDCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FD220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5C96ECA6;
	Fri, 20 Dec 2019 20:13:46 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3416ECA4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 20:13:45 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id 10so4034123ywv.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/uhc8GOB+NuC+0lWeHBZP+2nOdsFlOMpF+mhj3dKnpc=;
 b=anq9gDCul9Xm+8NuaNaAUxmkYV683UeVlAYL/ZFkDnQAlIyukAquvhIvi/ApyFGE36
 aucHQ59NmU6X469l2fcpc/02J1c5RWzKWCFCgfoAOWosDbWr/izG0QocwJbeaSUgyubn
 8o/DFNfJaq9I5nHudj1GNBggiCyluJJnli9IrNRr3tyvI4K4UArU2EfmVQNuwcoM76NS
 LHc+v+4x4CQVm1FUwmGgE87XIZYcXKKTCbrtOvgFUadbpllTpEMVoy2MaCOTkl0aKhsq
 VIC1ZpSFvt33OHImVlfh9q1GRo1q3cjTPXchPr8VhchRfNqYVLuMqiwLkbku0AA5QHHz
 0wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/uhc8GOB+NuC+0lWeHBZP+2nOdsFlOMpF+mhj3dKnpc=;
 b=kse8S00ncmtDc6qgO79qrGkP+xnDi9yngwVDKfIyQ3f/d1SaSNX6+L01s5INejbKOG
 FpYog8Qqmx7yzEu0SaJNduvXXysoy90qCfVe8yrR5dAGWaVh+9mII4CtPV+imvbTq2od
 5+EjLl/3I/LIcVPxKA05dt7aaHi7lj8JTFGQ0jXgL26vFUS+VyIpI3rMqqBM2NNcqoID
 P3zExCIbcrdXEH1EOF1GupEqJ5PyMbnoAFBna4H3B9TshpeFtLad84vMNtPNGCvByth2
 Zld63w+JphOk7yTCQm/zXwG6s+0u7kjFl0Eo2RUfb0rWDoLL7DIIV1hYRkLiV5sdyHwb
 bEDg==
X-Gm-Message-State: APjAAAUn9rKdp+U0nwqxvN6Jza8MfLtw/eqO/3i0JacPcI2en3oIQDJ9
 vB0VZ0wR1xcJhMs2m5fePDZBZ2JZ
X-Google-Smtp-Source: APXvYqzfuYdYtoGeiegz1Hs3sUTf8nPyt6zrzRIMCYnuBzppXLdNJhTE5Kq7yqX/1jO5JS4KaAvBTA==
X-Received: by 2002:a81:178c:: with SMTP id 134mr12394805ywx.363.1576872824117; 
 Fri, 20 Dec 2019 12:13:44 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e186sm4208564ywb.73.2019.12.20.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 12:13:43 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/smu/navi: Adjust default behavior for peak
 sclk profile
Date: Fri, 20 Dec 2019 15:13:35 -0500
Message-Id: <20191220201336.1083364-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Fetch the sclk from the pptable if there is no specified sclk for
the board.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index bf87e93b26fc..c33744a0d46b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1587,7 +1587,7 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t sclk_freq = 0, uclk_freq = 0;
-	uint32_t uclk_level = 0;
+	uint32_t sclk_level = 0, uclk_level = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
@@ -1629,7 +1629,13 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 		}
 		break;
 	default:
-		return -EINVAL;
+		ret = smu_get_dpm_level_count(smu, SMU_SCLK, &sclk_level);
+		if (ret)
+			return ret;
+		ret = smu_get_dpm_freq_by_index(smu, SMU_SCLK, sclk_level - 1, &sclk_freq);
+		if (ret)
+			return ret;
+		break;
 	}
 
 	ret = smu_get_dpm_level_count(smu, SMU_UCLK, &uclk_level);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
