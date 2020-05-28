Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A9C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A42206DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxhlWMrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A42206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB746E7EC;
	Thu, 28 May 2020 21:35:39 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00946E7EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 21:35:38 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id r16so108283qvm.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=81d9Bi5jiCMrvY2lBLuB88TOdnBJIOVBPlGoG3qGCq4=;
 b=gxhlWMrWZulm8XrWjXJ2vWEXKYpFn4JJhu3CPn474SyMaI5uEX1+hfqMoMf7Xkqd+C
 g431pSMf6RYFk3ilODPLI4A7OH5yCUYoAsQ1J0LTDAFsZzNBIOxbTr6H18nrSikdxlzx
 RgubI5vjEiapjKOaYe4dt2Qvq9ZzytdaGH03dIkovCSnlZE9pjy0uIXRxk7OYN7kMwjG
 BkpznOlezkaTroLHlcVoAgvPMmUyoAr5EH90rDtpLKHtYopbl6NDj929trOGhOI6l2CH
 UiBBIQGppfK8jcQRMmLG31l+83OgWoaC/m6eWDq7ThaJRU8veCKHmRUoAtqhAaByKvtj
 1zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=81d9Bi5jiCMrvY2lBLuB88TOdnBJIOVBPlGoG3qGCq4=;
 b=d7e4Co9xjuPULvafoX8s6c7cnfXVnaYkeT6twY6MN+eUzAy7Yd7SWGBpbtZ12K5b51
 StuGQYfXnoEnOFG6nAt3eseL8DNNW4KOScep3uU72BSt9YXb4klQdvJCwoDvC3JjYAGP
 +qZgqHlHanH0sH7X3aU00v0687UU35kRZWNAF9sT4OBh034bvwD9tQQqPeBz4TzB7Dnf
 eNcJhF/TlP10ezDttbhEecE02XR81tm7x15my1iaYHAwE+ULDLTIkc4JXDzbCe7PTGyE
 Na/RkfnfDmz+NyUHzkygEdF1R5lIahRo1npdPar1Z/JC7Qr//sbeCRvPkVaG4PMX93mD
 xkjg==
X-Gm-Message-State: AOAM530ATH5d9sjSE2i2G98sL/MONR51Udu5ZjHTYLs2M4bvZKTaHLfh
 9jtQl2ndEjUn0E6+KIYeuHmCFVvS
X-Google-Smtp-Source: ABdhPJyXkB5+lNJWK08N7RrWrJcdNT+6CuNBrjd5W5bvef8R42yEc5rNfB2p/0k0N9YVqSBsW4GVUw==
X-Received: by 2002:a05:6214:1365:: with SMTP id
 c5mr4976979qvw.152.1590701737304; 
 Thu, 28 May 2020 14:35:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k43sm7027851qtk.67.2020.05.28.14.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:35:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: skip gpu_info firmware if discovery info is
 available
Date: Thu, 28 May 2020 17:35:24 -0400
Message-Id: <20200528213529.673145-1-alexander.deucher@amd.com>
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

The GPU info firmware is only applicable at bring up when the
IP discovery table is not present.  If it's available, use that
first and then fallback to parsing the gpu info firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f0e8da7bacf..716f1f7ebe3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1533,6 +1533,11 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
+	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
+		amdgpu_discovery_get_gfx_info(adev);
+		return 0;
+	}
+
 	switch (adev->asic_type) {
 #ifdef CONFIG_DRM_AMDGPU_SI
 	case CHIP_VERDE:
@@ -1617,11 +1622,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 			(const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
 								le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-		if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
-			amdgpu_discovery_get_gfx_info(adev);
-			goto parse_soc_bounding_box;
-		}
-
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
 		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
 		adev->gfx.config.max_sh_per_se = le32_to_cpu(gpu_info_fw->gc_num_sh_per_se);
@@ -1650,10 +1650,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 				le32_to_cpu(gpu_info_fw->num_packer_per_sc);
 		}
 
-parse_soc_bounding_box:
 		/*
 		 * soc bounding box info is not integrated in disocovery table,
-		 * we always need to parse it from gpu info firmware.
+		 * we always need to parse it from gpu info firmware if needed.
 		 */
 		if (hdr->version_minor == 2) {
 			const struct gpu_info_firmware_v1_2 *gpu_info_fw =
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
