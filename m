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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0AC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7F32073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJj3p3Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7F32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8854189254;
	Mon,  1 Jun 2020 18:22:53 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94FD89262
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:51 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id y1so8456215qtv.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lZt9ZJRdJKsvBoPvDwknho6rMAbAynG2feKbCNtevHE=;
 b=nJj3p3IpO5wtrvKUak4wNaZqUxu4szJQLqhnowCHr3Xb1/PvXZg9+qqArJz+MhlF0b
 0Fndj4gQ+oRa6z4NFxf3cEfvXrNWS0sbrBpbPtJR/IMkrcyHiZ4GB4mfZGGTuXVfHUGK
 79667+IU57WaSVgtOLueGCRC6PUfLwTGNjbkkiUAWXTQ82UUFpkFftSI5XPwCI1Oemlf
 QF0fyj4eej9f9wlnisUO+U12PyJt38SrQAK3LjA6V5KV2Y+u1Eh3USvVPSghbU3+oWaH
 HAXFWnqpH4oALo268IWWmhSSQvnOKi8qjhfSuPCaHuVvVDRbk0tMXmfjST7PK7c/eWP6
 Lo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZt9ZJRdJKsvBoPvDwknho6rMAbAynG2feKbCNtevHE=;
 b=i30+LVmvNgY/2UhyQCvwrP2Mss3onzDE97F3Ef7bnV36mizqzrZ0hsR1ONpkGkfBMt
 YoBM0m8RsQammzm9WmEot2b/y9k5w53YNKYdSJ73FceGcq/pWu6t2EHWNb1dO7MSJ7VL
 Nviv3Otf9X1QtjbUQQZrgH3MfsrEiHKNxROBe+yzX+t26CfCtGNE/bCg1WzhT9YW7sVz
 JEQybEhf74N/8Sc0kn6Z3+ybro3Uo6P1UG8AjawB+13QPuLqhDtQGPX9tySeBUiAS+eI
 UFo0TZx6iDZU/NyLuxgszaalhabxiaBrDpbUQQ0jWqKNDc0WBiijnZ/3IxeUgwIKdbb7
 gI3g==
X-Gm-Message-State: AOAM530kYamEokuYczYzEkAOzasX04b7WYFJNnVfone7bJ5qpOu4RJub
 MKm8bYaKtk33yPgQHb1lhOtq2WPl
X-Google-Smtp-Source: ABdhPJwCpHDvSW5NTOYrtq9h2fUtQI+NNW+Gzjajg1AkslpIEuANPkhOW6uehzBgsnMC6lO7db6aSQ==
X-Received: by 2002:ac8:551a:: with SMTP id j26mr23770092qtq.237.1591035770795; 
 Mon, 01 Jun 2020 11:22:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 170/207] drm/amdgpu/psp: support for loading PSP SPL fw
Date: Mon,  1 Jun 2020 14:20:17 -0400
Message-Id: <20200601182054.1267858-81-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add support for loading SPL firmware.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 34 +++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cd52b6e05793..cdd65b577986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1355,6 +1355,14 @@ static int psp_hw_start(struct psp_context *psp)
 			}
 		}
 
+		if (psp->spl_bin_size) {
+			ret = psp_bootloader_load_spl(psp);
+			if (ret) {
+				DRM_ERROR("PSP load spl failed!\n");
+				return ret;
+			}
+		}
+
 		ret = psp_bootloader_load_sysdrv(psp);
 		if (ret) {
 			DRM_ERROR("PSP load sysdrv failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e66958a01458..1513887e7a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -50,6 +50,7 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_KEY_DATABASE	= 0x80000,
 	PSP_BL__DRAM_LONG_TRAIN		= 0x100000,
 	PSP_BL__DRAM_SHORT_TRAIN	= 0x200000,
+	PSP_BL__LOAD_TOS_SPL_TABLE	= 0x10000000,
 };
 
 enum psp_ring_type
@@ -84,6 +85,7 @@ struct psp_funcs
 {
 	int (*init_microcode)(struct psp_context *psp);
 	int (*bootloader_load_kdb)(struct psp_context *psp);
+	int (*bootloader_load_spl)(struct psp_context *psp);
 	int (*bootloader_load_sysdrv)(struct psp_context *psp);
 	int (*bootloader_load_sos)(struct psp_context *psp);
 	int (*ring_init)(struct psp_context *psp, enum psp_ring_type ring_type);
@@ -298,6 +300,8 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->init_microcode ? (psp)->funcs->init_microcode((psp)) : 0)
 #define psp_bootloader_load_kdb(psp) \
 		((psp)->funcs->bootloader_load_kdb ? (psp)->funcs->bootloader_load_kdb((psp)) : 0)
+#define psp_bootloader_load_spl(psp) \
+		((psp)->funcs->bootloader_load_spl ? (psp)->funcs->bootloader_load_spl((psp)) : 0)
 #define psp_bootloader_load_sysdrv(psp) \
 		((psp)->funcs->bootloader_load_sysdrv ? (psp)->funcs->bootloader_load_sysdrv((psp)) : 0)
 #define psp_bootloader_load_sos(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 234ba127ec2e..423386272920 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -252,6 +252,39 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
 	return ret;
 }
 
+static int psp_v11_0_bootloader_load_spl(struct psp_context *psp)
+{
+	int ret;
+	uint32_t psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check tOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v11_0_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v11_0_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy PSP SPL binary to memory */
+	memcpy(psp->fw_pri_buf, psp->spl_start_addr, psp->spl_bin_size);
+
+	/* Provide the PSP SPL to bootloader */
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_TOS_SPL_TABLE;
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	ret = psp_v11_0_wait_for_bootloader(psp);
+
+	return ret;
+}
+
 static int psp_v11_0_bootloader_load_sysdrv(struct psp_context *psp)
 {
 	int ret;
@@ -785,6 +818,7 @@ static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
 static const struct psp_funcs psp_v11_0_funcs = {
 	.init_microcode = psp_v11_0_init_microcode,
 	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
+	.bootloader_load_spl = psp_v11_0_bootloader_load_spl,
 	.bootloader_load_sysdrv = psp_v11_0_bootloader_load_sysdrv,
 	.bootloader_load_sos = psp_v11_0_bootloader_load_sos,
 	.ring_init = psp_v11_0_ring_init,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
