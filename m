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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29C4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C829D208E4
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhaPq0cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C829D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858F66E0DC;
	Mon,  1 Jun 2020 18:03:11 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7E56E170
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:10 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id y1so8400074qtv.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zvb7XqIxhMDmNtQQReSDgTwr9hPM1oq4w/N9w9R+BXc=;
 b=lhaPq0cQPLNXYug3toCP/o88BlsrFw8uVpURxS/wosWzdSLPgPyILzKHbWxO7jJx1l
 c81o3cG/NIV2kxQIhjuyFl6JF1OxFdOJTZQqj2p+/WskeSvJQc5S7J1yq4yDR4PhNxL8
 RVLj1P09Pv9Ju1EqdEeW/BFrHFB/OhHmfvjUctBzcARdkLawXsuptFoiMDzdbH8QnD71
 6I8gw/voJmq8KQHCTfSrolaER7Bgh5aPIcZTWxbGjpA6BuOAHa0ltr3U4/bmfoNaeqH0
 ZkgK1HJ+WmIXqo7q2w+e+diJtks6uNl6lOPAE9TEj4iukDpXCG/I4EerbVciH9DSZBXT
 FS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zvb7XqIxhMDmNtQQReSDgTwr9hPM1oq4w/N9w9R+BXc=;
 b=Bcqrn/NiX8pGZKYqV0UenNb4PFG1HDD38qQ0AUivzGv3JiOzJEauJ6zoesrnggWGkx
 nL74PqrB+cvSI/SjZkrTOdw/uYYprKuDIWw3AGv68O6H3M94dim+w+yIXR75H4BsCX3R
 H+B7+54tYy+VOjGFoo+3Ku/ZyQIkpZsZer4PAv9LCnLeoT1jp09SFBioSKkZvqkEsR2h
 iwhocogbWzGY1620vEQmPLY+TmUWHAPl06BZI44N3D6gIi7q750oEPNgKthRrggyXyLn
 H/7AdzSG5+2SzW8YSQNK8oC/VJnieMZd889H1QQ7qbaHy5XIxQJIlErmYbLRm9S+7yEE
 /zhg==
X-Gm-Message-State: AOAM530SfDVYjUVEMRqK2OK8FgZvx0trPZElPxBUDt94QamtaAFOpwgG
 E+/j+O3wVICXBPLRWGdmrYzH9D99
X-Google-Smtp-Source: ABdhPJz55MFRpmUKAguN2CPBzZ8SADfI6FGr1RFb8gvmKttJ4zKSiHpNYQEeOlCyel4atCSTNTzUmg==
X-Received: by 2002:ac8:53cf:: with SMTP id c15mr23936182qtq.230.1591034589603; 
 Mon, 01 Jun 2020 11:03:09 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:09 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 019/207] drm/amdgpu: add gfx ip block for sienna_cichlid (v3)
Date: Mon,  1 Jun 2020 13:59:31 -0400
Message-Id: <20200601180239.1267430-16-alexander.deucher@amd.com>
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

Add support for GC 10.3.

v2: Squash in gb_addr_config fix (Alex)
v3: Add num_pkrs support (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c         |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d43c11671a38..50be8e3a443b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -134,6 +134,7 @@ struct gb_addr_config {
 	uint8_t num_banks;
 	uint8_t num_se;
 	uint8_t num_rb_per_se;
+	uint8_t num_pkrs;
 };
 
 struct amdgpu_gfx_config {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8a6a9ba85714..feedbde0565d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -63,6 +63,9 @@
 #define mmCGTT_GS_NGG_CLK_CTRL	0x5087
 #define mmCGTT_GS_NGG_CLK_CTRL_BASE_IDX	1
 
+#define GB_ADDR_CONFIG__NUM_PKRS__SHIFT                                                                       0x8
+#define GB_ADDR_CONFIG__NUM_PKRS_MASK                                                                         0x00000700L
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -4002,6 +4005,16 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
 		break;
+	case CHIP_SIENNA_CICHLID:
+		adev->gfx.config.max_hw_contexts = 8;
+		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+		adev->gfx.config.sc_hiz_tile_fifo_size = 0;
+		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
+		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
+		adev->gfx.config.gb_addr_config_fields.num_pkrs =
+			1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);
+		break;
 	default:
 		BUG();
 		break;
@@ -4107,6 +4120,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -8253,6 +8267,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
+	case CHIP_SIENNA_CICHLID:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7600f42ba3e1..6dd0adb78c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -487,6 +487,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
