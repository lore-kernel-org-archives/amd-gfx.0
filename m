Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C9C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3367D2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op5TAh1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3367D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D345E6E303;
	Mon,  1 Jun 2020 18:21:24 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A127B6E2FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:23 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id v79so9967952qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=raJnSEtA2yZAgtzODpihF/nm8d1933wpCgEQvhmfk8o=;
 b=Op5TAh1HLyylV+P76NZeMhrlYsXvQUXkjJhfYXPDs5jKuYRBCY0qnkaNehYD759Uhx
 XeNatR7w9uKIAm/EpSfA6NOA7TxcfRdeiPr0LoLU3pHBiMthQ5fi8xlBeu3vyFlMqMoa
 sNUvGjdF6xlvSNqFvqTQESJ36KiAhXRe2mXR6ivDrpQoSuEjQHBwcNCPJX4OFaUGjazK
 95hCbNc6C8V+hkRnUUTvyfBPjLz02cnSLJ98cGPrdYaUzQ4foIkn0hFPKZTG1tcOh/Dx
 NplJlw7YEYVZwTdi4kizglFSnm2OhmZDwIzuYk3qaW96BYXobr3A/by05WDSzk4GpIQR
 LDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=raJnSEtA2yZAgtzODpihF/nm8d1933wpCgEQvhmfk8o=;
 b=g4u4fCStdnLNiMFIIstzwfD+HvyY0cmcg47LWu/A8NI6BxT9DTQzbVr4D46J6Fjlcl
 llQPDJxY7q39S2bRbpqAFrqQxFlUyNZ0GsCiiE3r5UrGWaHM/DWvYsZgXq0T1uo9hEMs
 k+9xntnlk0QSTr8bP5lahhh5Nv+ZAieHuP4S8vvhpm0JXkftpKUd3J2swMyYkPZgfuzW
 jA3MKBW4ng2ee4xCfBgz0C9yaYXl4RaR1C0KeQ72XkngCuprgWb1OWRet6C4fATHeg4W
 H51+M7osTmNZaGDzE1TF6wxbauBrkV39iKg5364seMF0t3Oundn0jjwK5FWzo6q5hAJ7
 poxg==
X-Gm-Message-State: AOAM532zntMmuRBvnn0hBZUTy5N84JFMpozn0HcNokcaium0NPTnb6Vd
 hmCkyVRkCa86tvooYYF3l+JGS3/L
X-Google-Smtp-Source: ABdhPJzkwpY/HNvOTnOVpISAbO5++jrGGL+L4aZlI3XajPz14POL7se2fAK1WGwXciGwToJ8WOOmNA==
X-Received: by 2002:a05:620a:20d6:: with SMTP id
 f22mr20492415qka.294.1591035682662; 
 Mon, 01 Jun 2020 11:21:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:22 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 104/207] drm/amdgpu: fix the PSP front door loading VCN
 firmware
Date: Mon,  1 Jun 2020 14:19:11 -0400
Message-Id: <20200601182054.1267858-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

for the second instance with correct index

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 371c70a1e611..dddae2b8f0f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -345,9 +345,9 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_lo));
 		WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_hi));
 		WREG32_SOC15(VCN, inst, mmUVD_VCPU_CACHE_OFFSET0, 0);
 		offset = 0;
 	} else {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
