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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEF8C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F292073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHjHwpwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F292073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E166E0E0;
	Mon,  1 Jun 2020 18:23:01 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A806E37C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:23:00 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id i16so1842130qtr.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wZviPTkyeC+Zp3CXKQgIiKBU8OdVu2d6Z+tZ9HIG2lA=;
 b=aHjHwpwOU+eDLEuBo4QL6jdygXK5gzJku1GsANl2BSDgqA8DKhWPQlfyd+4rhuM/qg
 l6DcQ4zpiwLEEaonYvgfppS3jM/BQBCDnRMQg8cfY/jxY9+Xrp8/XrP95lgahJFGIlLB
 VNmI+sEHAfX5H2t2aVYQ1leFJ23pEPnwW2bWVF0j2RGWWFlkrup/5AGGGhNsX7hn0t7n
 7Sb+o0ZKCTw0wklaJgQKwwmLH+gxmKyc+Bd04TmdLiloL6O9YQYJXyq08f1FjqR0ccTc
 DlvxeD4vi/WDD+dBwFGehjewJXV3zEunx0BOpY16OpAWuDejoEAjffmmdbcNx3R5QlYq
 4ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wZviPTkyeC+Zp3CXKQgIiKBU8OdVu2d6Z+tZ9HIG2lA=;
 b=HrAKRO8N77tyADT8v2QampKEMVjcXRXi/NIirAVL4/RiLKCfF+7o37G6bro4aEae5p
 lD9kaDyv/qsh2blDhNOaF+LTwKFx9jW26mnrPwi/E4wDHJIJLBINUXg9qB59OiSMOzZd
 tZ8TJdk02aFFLbTJgOWOheV0Ve0F5xQ78JwdTxnMf6HwzSGPDhYSOlo6Pid6+DcFRhnC
 M2rlI0RO/4glEfvQfcxKFz6T5gSG7sSTURomOvHI/pVph+w251W3UQJ12+e3IoloXbJy
 VX3rNcFWey0ErpirtXF3xBg5tJVHixKFcKmBmlikLN8X1X0uFMJpSpawLUEQ6ENprErG
 74cw==
X-Gm-Message-State: AOAM530vbaZ7oAYBEjvtZvKnK653cdLqyHP/fFr+VRxkLG8cH2gX28Dj
 F0wxzIDJDC6fV+Ab2Gy8bRVQZmSa
X-Google-Smtp-Source: ABdhPJxkFx1znKlNyLfPhEvbRw1W2W6173zFM5gG6LX9LxlmRtQM4q6kLJCYvQtj0D2pXl4DomhPCA==
X-Received: by 2002:ac8:31f3:: with SMTP id i48mr23202078qte.128.1591035779031; 
 Mon, 01 Jun 2020 11:22:59 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:58 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 177/207] drm/amdgpu: remove unnecessary check for mem train
Date: Mon,  1 Jun 2020 14:20:24 -0400
Message-Id: <20200601182054.1267858-88-alexander.deucher@amd.com>
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

a.Check whether mem train support when try to reserve related memory.
b.Remove ASIC check and atom firmware table version check as the check
of firmware capability is enough to achieve that purpose.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  5 --
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 47 +------------------
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 ++-
 5 files changed, 7 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6e74ff9990e3..a4a0296b168d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -655,10 +655,6 @@ struct amdgpu_fw_vram_usage {
 	u64 size;
 	struct amdgpu_bo *reserved_bo;
 	void *va;
-
-	/* GDDR6 training support flag.
-	*/
-	bool mem_train_support;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index fdd52d86a4d7..c687432da426 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -2022,11 +2022,6 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	if (adev->is_atom_fw) {
 		amdgpu_atomfirmware_scratch_regs_init(adev);
 		amdgpu_atomfirmware_allocate_fb_scratch(adev);
-		ret = amdgpu_atomfirmware_get_mem_train_info(adev);
-		if (ret) {
-			DRM_ERROR("Failed to get mem train fb location.\n");
-			return ret;
-		}
 	} else {
 		amdgpu_atombios_scratch_regs_init(adev);
 		amdgpu_atombios_allocate_fb_scratch(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 2b55ccd5cb44..e249b22fef54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -516,7 +516,7 @@ static bool gddr6_mem_train_vbios_support(struct amdgpu_device *adev)
 	return false;
 }
 
-static int gddr6_mem_train_support(struct amdgpu_device *adev)
+int amdgpu_mem_train_support(struct amdgpu_device *adev)
 {
 	int ret;
 	uint32_t major, minor, revision, hw_v;
@@ -551,51 +551,6 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
 	return ret;
 }
 
-int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
-{
-	struct atom_context *ctx = adev->mode_info.atom_context;
-	int index;
-	uint8_t frev, crev;
-	uint16_t data_offset, size;
-	int ret;
-
-	adev->fw_vram_usage.mem_train_support = false;
-
-	if (adev->asic_type != CHIP_NAVI10 &&
-	    adev->asic_type != CHIP_NAVI14 &&
-	    adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 0;
-
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
-	ret = gddr6_mem_train_support(adev);
-	if (ret == -1)
-		return -EINVAL;
-	else if (ret == 0)
-		return 0;
-
-	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-					    vram_usagebyfirmware);
-	ret = amdgpu_atom_parse_data_header(ctx, index, &size, &frev, &crev,
-					    &data_offset);
-	if (ret == 0) {
-		DRM_ERROR("parse data header failed.\n");
-		return -EINVAL;
-	}
-
-	DRM_DEBUG("atom firmware common table header size:0x%04x, frev:0x%02x,"
-		  " crev:0x%02x, data_offset:0x%04x.\n", size, frev, crev, data_offset);
-	/* only support 2.1+ */
-	if (((uint16_t)frev << 8 | crev) < 0x0201) {
-		DRM_ERROR("frev:0x%02x, crev:0x%02x < 2.1 !\n", frev, crev);
-		return -EINVAL;
-	}
-
-	adev->fw_vram_usage.mem_train_support = true;
-	return 0;
-}
-
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 {
 	struct atom_context *ctx = adev->mode_info.atom_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 3a5ed339903e..9f0d4356e8df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -31,11 +31,11 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 	int *vram_width, int *vram_type, int *vram_vendor);
-int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev);
+int amdgpu_mem_train_support(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 12675cb7dde4..d968e38d475b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1861,10 +1861,13 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	bool mem_train_support = false;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		if (adev->fw_vram_usage.mem_train_support) {
+		ret = amdgpu_mem_train_support(adev);
+		if (ret == 1) {
 			mem_train_support = true;
 			amdgpu_ttm_training_data_block_init(adev);
-		} else
+		} else if (ret == -1)
+			return -EINVAL;
+		else
 			DRM_DEBUG("memory training does not support!\n");
 	}
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
