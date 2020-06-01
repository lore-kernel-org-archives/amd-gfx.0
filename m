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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2DC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A246F2065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inGa6C6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246F2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DBCD6E15E;
	Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC93D6E148
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:05 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id e16so8467814qtg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ksrvjTm6nYqFM16ERTM7jlYdghvYs0kVBDKvOA3J7Hc=;
 b=inGa6C6gyPlcef/eOBmPXg09o4Ke2gp/MPObnyBiV+pt2wachppfIOccql9CB8+zjQ
 8aiY4OfIJLMp5Iw6me75BbLrWxApyxvOhLHwK9xGHi3FUN6c4HDpvJwZJvRDd6LIeJj/
 ++gqv4Vl/mvNh39PDlXlBGbCb+wKarJcUQhCNio4u5iYdVKjlgyPBaXfYBk5tj82JFq1
 zaWHWuj1ns2AUJ0vFADLUkRuajkY5wbUOA4Bq3992sgUtwSVCjUtbbQMkSqSPA/ICpbe
 2hrrnd3KQiAyTMh0fLfgu2AhQ35gBLmjJ24fX0yPMx4KnoWUF8me1wbjBYjpIAHeRE1G
 Y25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ksrvjTm6nYqFM16ERTM7jlYdghvYs0kVBDKvOA3J7Hc=;
 b=qzdR+F7iQDKf8uvbnGCVzkfGPqWx03UEMrZVP9ChCyPrjKWq+IpqKo0ICdXu1aXKY3
 ZO/QFaCrOM4sT3MIR91ajkTK9bFbQ4uEqRTeAeMhjPf1ujbTJM6SK35iJS6oTQF+oX+F
 Oyao/2iZ6Pe4ex46eTpN0eiZYl0D1/PK94QLtyiV+KKqBYXPKJP09FDNTZKJwuEvUwHQ
 NlwhcvjanX7NFedPl5LBxnMB1VQZlCm9+o6CspdUdpfxeCeyV0OBEY6C4t8I3urBdpWT
 mSDUJ85Ie2MfcIUbPvabZOP9cndT+ouZ3D3Te/C6hAaGj8FwDE7GI+itUPeAdRtSM6kj
 mwWQ==
X-Gm-Message-State: AOAM531C56mRCw6MI77Cv49Q4ua6NFMeZAwujkbGGZ6jna0Znfa20IGJ
 V7Rnp3ySo1Bwb51Cz+ZbpUoVQIqN
X-Google-Smtp-Source: ABdhPJymgwk6AB3aIlY2tYwW9+KDLIOoLmZQB2Y7rQqBfC1Bl0Jo7kXU/62732jM9XZpq5t+IhJ3rg==
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr23541937qth.143.1591034584631; 
 Mon, 01 Jun 2020 11:03:04 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 015/207] drm/amdgpu: add support on mmhub for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:27 -0400
Message-Id: <20200601180239.1267430-12-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 71 ++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 616309e85d6e..b83a56d67428 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -31,6 +31,11 @@
 
 #include "soc15_common.h"
 
+#define mmMM_ATC_L2_MISC_CG_Sienna_Cichlid                      0x064d
+#define mmMM_ATC_L2_MISC_CG_Sienna_Cichlid_BASE_IDX             0
+#define mmDAGB0_CNTL_MISC2_Sienna_Cichlid                       0x0070
+#define mmDAGB0_CNTL_MISC2_Sienna_Cichlid_BASE_IDX              0
+
 void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
@@ -367,9 +372,16 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 {
 	uint32_t def, data, def1, data1;
 
-	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
-
-	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
+		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
+		break;
+	default:
+		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
+		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
+		break;
+	}
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
 		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
@@ -392,11 +404,20 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 			  DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
 	}
 
-	if (def != data)
-		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
-
-	if (def1 != data1)
-		WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2, data1);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		if (def != data)
+			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
+		if (def1 != data1)
+			WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid, data1);
+		break;
+	default:
+		if (def != data)
+			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
+		if (def1 != data1)
+			WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2, data1);
+		break;
+	}
 }
 
 static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
@@ -404,15 +425,30 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
-	def = data = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
+		break;
+	default:
+		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
+		break;
+	}
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
 		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
 	else
 		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
 
-	if (def != data)
-		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
+	if (def != data) {
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
+			break;
+		default:
+			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
+			break;
+		}
+	}
 }
 
 int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
@@ -444,9 +480,16 @@ void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	data = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
-
-	data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
+		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
+		break;
+	default:
+		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
+		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
+		break;
+	}
 
 	/* AMD_CG_SUPPORT_MC_MGCG */
 	if ((data & MM_ATC_L2_MISC_CG__ENABLE_MASK) &&
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
