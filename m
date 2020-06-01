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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0989EC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFC62077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTgRWmc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFC62077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2A16E2A3;
	Mon,  1 Jun 2020 18:04:06 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E9E6E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:04 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id i68so8440068qtb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UA93pkbA4xrCKt339sGdnsClZC2Z3g9Chuu/bgVLXZ0=;
 b=lTgRWmc7e+SV6TFiywch75swaysXmgCjsF2b4WJor7yquEL145Og1xETTJE/DEvAss
 ryohiN7v4KbcE2ggEq4wXchA34u8gdGS5NhtLW2KT8uMzOD6POENcYBkFTkg5Vv81IIa
 XvvfRiAqf/j+NS7GoqVc+y451y3cDNWCNxXsHHOFa1L4yzRJup/nbWqU4OIb432Mb90I
 gQIAFG8yU2KbfxGU3V5PzRjKZ6GsCG5u+lboawJdHVG7MWf8OsMz/gjSFIR4Xq9vwBGu
 MvvYzp76UC/RBXrEdVJ8KIkZcfjCdVkbILw38N5b1LxeKL6DN7rOwhrgwqY0ueh4Fuqo
 EhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UA93pkbA4xrCKt339sGdnsClZC2Z3g9Chuu/bgVLXZ0=;
 b=oS3Izvne5abve9Qu9YioOzc//GzdVvzfKxEJyizHFAO+8+L2kxBw2eh0WbDnmoYxxk
 wBMmxe7wTQ+HoIZN+Ct2XVp9iLDDEf1HT4J1aMBpkWrM+/FscCTTpkxQaENUYP+/YSAf
 tlRYb2AbruNHEmWt+jRKRPdJ5yLRj2HHMpQMbJde3A98TZ+9rImnOzUBtOr9xXosjHSa
 J52iTLnGIZy9yje4PdPIjl+hOUbRd7v2Q9uut+P4EE6dfvdm6jpJErwCxSunEGrIU832
 FnPj16X9lOFs3bGBPxJubCyKrshfkRIogPN++6aEfnTV5XGo+ERzJ7kUQiOiWd6abEAv
 eE+w==
X-Gm-Message-State: AOAM532Hma+EvMyZoAtbIlEvvXqMW/jwxxkxACLQDie9EkNOaDKkzbQ5
 n57SPLoDTl26vT53qvAeVyP9s301
X-Google-Smtp-Source: ABdhPJzgoccei1JlC+vmHGqXnkHfyj9mHbzNWn7BRo3mCiIRWEgBpEsFlcQZiwP6J03PKnmbQWueyA==
X-Received: by 2002:ac8:4d0e:: with SMTP id w14mr20706791qtv.266.1591034643907; 
 Mon, 01 Jun 2020 11:04:03 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:03 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 054/207] drm/amdgpu: add 2rd VCN instance doorbell support
Date: Mon,  1 Jun 2020 14:00:06 -0400
Message-Id: <20200601180239.1267430-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

Sienna_Cichlid have 2 VCN instances, using different register for range

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index b8eb5ece37c0..821289bff93a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -193,8 +193,13 @@ typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
 	AMDGPU_NAVI10_DOORBELL64_VCN4_5			= 0x18A,
 	AMDGPU_NAVI10_DOORBELL64_VCN6_7			= 0x18B,
 
+	AMDGPU_NAVI10_DOORBELL64_VCN8_9			= 0x18C,
+	AMDGPU_NAVI10_DOORBELL64_VCNa_b			= 0x18D,
+	AMDGPU_NAVI10_DOORBELL64_VCNc_d			= 0x18E,
+	AMDGPU_NAVI10_DOORBELL64_VCNe_f			= 0x18F,
+
 	AMDGPU_NAVI10_DOORBELL64_FIRST_NON_CP		= AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0,
-	AMDGPU_NAVI10_DOORBELL64_LAST_NON_CP		= AMDGPU_NAVI10_DOORBELL64_VCN6_7,
+	AMDGPU_NAVI10_DOORBELL64_LAST_NON_CP		= AMDGPU_NAVI10_DOORBELL64_VCNe_f,
 
 	AMDGPU_NAVI10_DOORBELL_MAX_ASSIGNMENT		= 0x18F,
 	AMDGPU_NAVI10_DOORBELL_INVALID			= 0xFFFF
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 4a00b064be10..7429f30398b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -38,6 +38,9 @@
 #define mmBIF_SDMA3_DOORBELL_RANGE		0x01d7
 #define mmBIF_SDMA3_DOORBELL_RANGE_BASE_IDX	2
 
+#define mmBIF_MMSCH1_DOORBELL_RANGE		0x01d8
+#define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX	2
+
 static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
@@ -109,7 +112,8 @@ static void nbio_v2_3_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 static void nbio_v2_3_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
 					 int doorbell_index, int instance)
 {
-	u32 reg = SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH0_DOORBELL_RANGE);
+	u32 reg = instance ? SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH1_DOORBELL_RANGE) :
+		SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH0_DOORBELL_RANGE);
 
 	u32 doorbell_range = RREG32(reg);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
