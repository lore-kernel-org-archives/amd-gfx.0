Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 16:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E10420748
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 16:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwXNLZ0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E10420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC026E94B;
	Thu, 21 May 2020 16:27:06 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29166E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 16:27:05 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id x12so5917501qts.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l0jYvvnw4bCzXjs1yTshIU+MW3b+8jjP/FI/naT6XF4=;
 b=YwXNLZ0nOwsb7BEJQKO1hEzcTCH/Hti0OpFt1M+9vVERCKtjL8yb4PZ5jT/4+AB1H+
 4uWnZ5SavHw4Hv0IHwJvUTbUVH+r/sfFszBEJpSI3AJuZfqqQe9nyRciS+yIY6Hp/VKy
 mzVE1/xFc6+AE1h6OCXP7+ERZorLxBWri6ybQOqyHbEG+HFsbjh5ZORP44y1sTBOmXVY
 f9FiB0dpXguNOJPIsQ3Ik9P8SqPeUw8ac1Pt9h0D1CZ8TmfjZQFn3h8c5/S2NfkOEMFR
 +dIoXllzZ1gKLA4k2+4Jn9bfPmzSGSoOJe3eU689o/GDKnxPJfKXjsYT0DYlUg3NLnvq
 vWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l0jYvvnw4bCzXjs1yTshIU+MW3b+8jjP/FI/naT6XF4=;
 b=gDA+atPDRH51hcfVKVY9EnswMzNnhoTzmSr39nC9zqnVg7RwhNO0sHwGmCT2VklHyJ
 8zNUDRsXjTXLSOqjbEwjo9c3Exz1D4Truw8yYS5Hlbfnulb2gin8yTzlcGW9IYFeERCM
 p2pjNFmupjWe2QsglB2+qNuWC03SYc++ZCvL1mmx9nh9+ixhlewENMDwPYhbDTBd0aSQ
 KcNrckYTV5F0tl9Iuvvu++3aH/MCHeg6HA/ozsM6H5in2Qz6x3uCi3pfKdFuzMCq3cT0
 qHcbIZMfOajcVbL0GEkEvcE1qg9Yw62SUf/sqTZGK6OPh5EluJQ8+4klsJnsoTQnBRo8
 yRmw==
X-Gm-Message-State: AOAM533qpOfKf3nybHw+b7LVhdHGLN/bhlOUG5KrPgUoSzT+S41INbB5
 RuomM6Ul/dD/vYu7W6pGz6SCEUes
X-Google-Smtp-Source: ABdhPJzDZUQpY2yKKyyrf5PFVqJGdv64Fx5/khOzVBqJNP82QNSkiHVElPU/ZphV+pL+FeSRVc69zg==
X-Received: by 2002:ac8:71c1:: with SMTP id i1mr3137929qtp.320.1590078424746; 
 Thu, 21 May 2020 09:27:04 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 23sm5054610qkf.68.2020.05.21.09.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:27:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix pm sysfs node handling (v2)
Date: Thu, 21 May 2020 12:26:54 -0400
Message-Id: <20200521162654.1643801-1-alexander.deucher@amd.com>
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

Fix typos that prevented them from showing up.

v2: switch other files in addition to pp_clk_voltage

Fixes: 4e01847c38f7a5 ("drm/amdgpu: optimize amdgpu device attribute code")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1150
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 2fc51f815eaa..e06fef6174e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1731,10 +1731,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 #define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
 
 	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-		if (asic_type <= CHIP_VEGA10)
+		if (asic_type < CHIP_VEGA10)
 			attr->states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
+		if (asic_type < CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
 			attr->states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (asic_type < CHIP_VEGA20)
@@ -1746,7 +1746,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		attr->states = ATTR_STATE_UNSUPPORTED;
 		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
 		    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			attr->states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
 			attr->states = ATTR_STATE_UNSUPPORTED;
@@ -1758,7 +1758,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (!adev->unique_id)
 			attr->states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
-		if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
+		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
 			attr->states = ATTR_STATE_UNSUPPORTED;
 	}
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
