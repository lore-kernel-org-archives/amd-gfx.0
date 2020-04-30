Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9EFC4724C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E5B20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXytr0tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E5B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685A66E94D;
	Thu, 30 Apr 2020 18:37:46 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E356E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:42 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id ck5so3512073qvb.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uKb2UnswuMTn9OfTuF6dTSlJyqH31GAhHYefuJVprM0=;
 b=MXytr0tjzZ/buGbl9KlXbl/5L3TA1505MyNG6Dj4vu0sp5OAh/5uUG8j9TS6Nq3qpv
 Ngu/au89oSFSy6X45SK/9QdxSC75PrXD/GOYdu7RMOhcrp8MavZEG95QIESxws4URISy
 UAHxJzZrToxV3Dht1w0uXfba1jxE6D0SqcIsEuYwei2ZnqGw0s25CSFZZNNmfIYR2KuB
 GZDLAKjDoGn9P9uzCAqg8X//GjESuk/2I0D1NzvwwqGMuH+kJZzOue8QIImYx87eDNFv
 GNcVbmkdyBdBE6tzzvZUi/7XY0S2xc8CZRRHKiP11y/1Z+FFDaE+qNPbCxH/EbeX2TBL
 ZC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uKb2UnswuMTn9OfTuF6dTSlJyqH31GAhHYefuJVprM0=;
 b=XgICfEoYmaszjwz04q/d5BqQpem6Kxh0hYuEH1+i8CJEhOjo0PBRM+2M9fYAAy/xA4
 AOzL7dWph72VGJWvqkq3FJLbOilVeAMKV6HG6Sgm3gSqCiyW8gtsozwZTJxt2Gnk9Mhe
 4+L6tSbKF7nux8mgoKpoRd0SVas8l/CCDt/5LFSU+yxGbMFbMDt3WNX6c3qXJF8BcdwF
 YuG2xo7TlsMuBWEJF/DCvx6HQ1a3YHXitu3e9YP0/hROUQeYOBEOWp2TQIU+tXrLvgaq
 uxZ8fTRA8gtfxChoC36mUgWRfimuyRaeAJTPQTXhJ3Bfx/sAzqZVzYGVbyafjmGzXRm9
 VROQ==
X-Gm-Message-State: AGi0PuZWA4lXObgU9iHLwgbPLFBDwRlSy76h420u3gACsU/MghLnyj7e
 HJb1Pp18GcDlVJi6w+ozx/9RrshB
X-Google-Smtp-Source: APiQypItT26bz2xXTWepwpybrKCi811/kLAgTxtDZGeFlZJ6/NM7cohKC5ERkhi2OogPrmDSZjUvEg==
X-Received: by 2002:a0c:8ecf:: with SMTP id y15mr290375qvb.44.1588271860900;
 Thu, 30 Apr 2020 11:37:40 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] amd/amdgpu: Limit rlcg write registers only for nv12
Date: Thu, 30 Apr 2020 14:37:19 -0400
Message-Id: <20200430183719.419549-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200430183719.419549-1-alexander.deucher@amd.com>
References: <20200430183719.419549-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: shaoyunl <shaoyun.liu@amd.com>

Create gfx_v10_0_rlc_funcs_sriov for nv12 with rlcg_write function pointers be initialized
so driver can use RLCG to write aceess CSIB and CP_ME_CNTL registers when nv12 in sriov mode

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 32 ++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 20258c5d335f..7ff7e516b72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4577,11 +4577,13 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
-		     adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
-		     adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
+	/* amdgpu_mm_wreg_mmio_rlc will fall back to mmio if doesn't support rlcg_write */
+	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),
+				 adev->gfx.rlc.clear_state_gpu_addr >> 32, 0);
+	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),
+				 adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc, 0);
+	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),
+				 adev->gfx.rlc.clear_state_size, 0);
 
 	return 0;
 }
@@ -5190,7 +5192,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
-	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL), tmp, 0);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
@@ -7088,6 +7090,20 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
 	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
+};
+
+static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
+	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
+	.set_safe_mode = gfx_v10_0_set_safe_mode,
+	.unset_safe_mode = gfx_v10_0_unset_safe_mode,
+	.init = gfx_v10_0_rlc_init,
+	.get_csb_size = gfx_v10_0_get_csb_size,
+	.get_csb_buffer = gfx_v10_0_get_csb_buffer,
+	.resume = gfx_v10_0_rlc_resume,
+	.stop = gfx_v10_0_rlc_stop,
+	.reset = gfx_v10_0_rlc_reset,
+	.start = gfx_v10_0_rlc_start,
+	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
 	.rlcg_wreg = gfx_v10_rlcg_wreg,
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
@@ -8211,9 +8227,11 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-	case CHIP_NAVI12:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
+	case CHIP_NAVI12:
+		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs_sriov;
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
