Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891EAC04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBAA246C3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnEBio34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBAA246C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7896FCFB;
	Fri,  7 Feb 2020 15:19:22 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541466FCFB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:19:20 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id x1so2482573qkl.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2020 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5otuR5JUX7SIDvbn/VZvzc6h0aaV42+sjpHbNlV99g0=;
 b=LnEBio34YoNBtqxKrUjMvC/o89U/6MunIiAO0pRJOF221pupKp5niqllkjMDK9suiE
 HQrzyGRIQjbxE9DsoKgz5PJLrwKG9lLD0wmUQ3W+B0cY2asMtyOS/mIpfyJ5tdHGwx27
 kgX4sdyn36F+isHuRvL8aOy1FFSqtp7fHeHlcy8LH79xlcS+GOOgywRSd+7ipN5bGAlh
 rICaatwuifMbshdW6LBCGFl4OCnqFeyL7HBFfF/uo7IozwmhHyF2GjtfVT/wr3RWrZS8
 P5KKkKNA/lBOtAnSRqmwxHxm9agimY/5NbUcd2GYN8hEajZwDghgyc2+JQx+dMSc0Jp7
 HKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5otuR5JUX7SIDvbn/VZvzc6h0aaV42+sjpHbNlV99g0=;
 b=oYP6iSe6R5ZWNxDuePvUTpj903XfW93Of+vOdClpucLJfGi6WD935DYBBsp6q8qnIU
 sAp+OstUaKf+w6iKo4gA+kxBeFGePdNG46lXsuOybC27hnnqly+Z82eo22R026NEgC4k
 w+SbTuB9K+W3u3cOFNlc2pdQ7FO+v78HJSOD6OCjm3yf6V/+N4tnM8Ag/pS8f+pt4x/r
 KOIkhwuNqEjv4wuPSp+VuSRIYB3cW2q/exfB1vogzfQW607OhDHrB1rEGH2i1aQOzz/s
 r3J35qxCrwa8Ns1W8BTz1xaOOaCTpEeBD+idCjhkVX+ejreCysgFoqS/CBMXoYt4qySE
 iMhQ==
X-Gm-Message-State: APjAAAX/l29YhOHOzq2YQZrPrhYEQ++TfifvSkLDH6Sp4qGo/HPAEe3i
 a6GQDIIi9yWcMnpJ/4a5ubFejVDV
X-Google-Smtp-Source: APXvYqxMNQsT+A8fSxh6FXplTifLUUjQm/ABw/c8+GLkoAsK5uE7j+HNGi/83/ujEBT/XZ2iGeU7CQ==
X-Received: by 2002:a37:a392:: with SMTP id m140mr854127qke.211.1581088759240; 
 Fri, 07 Feb 2020 07:19:19 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id t29sm1445619qkt.36.2020.02.07.07.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:19:18 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/smu: properly handle runpm/suspend/reset
Date: Fri,  7 Feb 2020 10:18:41 -0500
Message-Id: <20200207151842.802638-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207151842.802638-1-alexander.deucher@amd.com>
References: <20200207151842.802638-1-alexander.deucher@amd.com>
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

We need some special handling when using baco vs. other
things.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 35 ++++++++++++----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 0e9d33ee08ab..53ea5343fbed 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1454,11 +1454,15 @@ int smu_reset(struct smu_context *smu)
 	return ret;
 }
 
-static int smu_disabled_dpms(struct smu_context *smu)
+static int smu_disable_dpm(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t smu_version;
 	int ret = 0;
+	bool use_baco = !smu->is_apu &&
+		((adev->in_gpu_reset &&
+		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
+		 (adev->in_runpm && amdgpu_asic_supports_baco(adev)));
 
 	ret = smu_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
@@ -1467,13 +1471,13 @@ static int smu_disabled_dpms(struct smu_context *smu)
 	}
 
 	/*
-	 * For baco reset on Arcturus, this operation
+	 * For baco on Arcturus, this operation
 	 * (disable all smu feature) will be handled by SMU FW.
 	 */
-	if (adev->in_gpu_reset &&
-	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
-	    (adev->asic_type == CHIP_ARCTURUS && smu_version > 0x360e00))
-		return 0;
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		if (use_baco && (smu_version > 0x360e00))
+			return 0;
+	}
 
 	/* Disable all enabled SMU features */
 	ret = smu_system_features_control(smu, false);
@@ -1482,15 +1486,14 @@ static int smu_disabled_dpms(struct smu_context *smu)
 		return ret;
 	}
 
-	/* For baco reset, need to leave BACO feature enabled */
-	if (adev->in_gpu_reset &&
-	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
-	    !smu->is_apu &&
-	    smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
-		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-		if (ret) {
-			pr_warn("set BACO feature enabled failed, return %d\n", ret);
-			return ret;
+	/* For baco, need to leave BACO feature enabled */
+	if (use_baco) {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
+			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+			if (ret) {
+				pr_warn("set BACO feature enabled failed, return %d\n", ret);
+				return ret;
+			}
 		}
 	}
 
@@ -1510,7 +1513,7 @@ static int smu_suspend(void *handle)
 		return 0;
 
 	if(!amdgpu_sriov_vf(adev)) {
-		ret = smu_disabled_dpms(smu);
+		ret = smu_disable_dpm(smu);
 		if (ret)
 			return ret;
 	}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
