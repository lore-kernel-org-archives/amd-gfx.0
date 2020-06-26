Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B3C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 14:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B73C207E8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KriKaN++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B73C207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FC56EBFB;
	Fri, 26 Jun 2020 14:04:33 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1049B6EBFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 14:04:32 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id q22so1000888qtl.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xq0tRZaM2kofu6Sj+lv8tC1Vlv82FaFH+yZx6mhTosk=;
 b=KriKaN++jZnIk7noXqGLyJo08NwDfAPUyQfOS0VUJMIbv9yiRsPFs2UmD1BNMCoMg2
 eiI/H9i6OvEygJd+qOwlmZW3WnR2sDGxohXNi1xfHvrDrmZyw/DtL0N/vCjCVYBVsHth
 glGzu97ObWo0+Z4ouhctiNbRpX9Vm39qsLDkzShqwXRskgfGr8osmmIoL1GYBcfleyVl
 BE/hkFIjFNCx4istEhJRTWlTUtK/9hh3iU8RryqR+DhZ/CdClInLqSzdeeuKnh7g+j9U
 WZheLR/Uz1WJPA/FWnc7/9rm5Q6CckBtaAABHfeZugmBi1Cyc5OMJg6sKdb72iLKzxpw
 haIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xq0tRZaM2kofu6Sj+lv8tC1Vlv82FaFH+yZx6mhTosk=;
 b=kdTgF/t5hWo488OiDR4eKqDUKD9a00jE5xBZnECC8sAOSNYmYpX1KPWYbz+0jV6PPn
 c1+5zEH0OlFTWa8Y/6LtoV8B3JPO2LSGriZpJvLbEOeFLlLU0iXI5F1DdQNy1uy2WeZB
 YGwI6ycT+b/m5P0qifAVbz0jFRURPHJ8CnDIknYAXHp4yHNqbt0Mp7Evni1PBlm8mJ4q
 HG/1Vypdyy+DE1rF2aVoSF8TPjayHDRZYrESvg83GY0sJQP14TFRCrbYSbz3cjH57aAv
 uLxZFm9yQA6tPHtbq7Sme52+zPg9QEpCH+R/UsatDGdEVcyzgUjT49FyPgXvyFuvcMD6
 3eeg==
X-Gm-Message-State: AOAM532/TnVlEPb9whLoCyfgQyj94YUQCVCqUhjKaVRiLGgEVBCw0vKB
 hQal15UpHL1v03BmMhOdsk0/oGtT
X-Google-Smtp-Source: ABdhPJxidrDewbHBzt2g/cMHTEKEm4bYT7rV6TU23RcHV2yntwRkyJltLRodmzad/Y2t+rQly1Y0EQ==
X-Received: by 2002:ac8:260b:: with SMTP id u11mr2953641qtu.380.1593180270829; 
 Fri, 26 Jun 2020 07:04:30 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id c80sm8146031qke.26.2020.06.26.07.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 07:04:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl when
 in reset
Date: Fri, 26 Jun 2020 10:04:23 -0400
Message-Id: <20200626140423.1425349-1-alexander.deucher@amd.com>
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

When the GPU is in reset, accessing the hw is unreliable and could
interfere with the reset.  Return an error in those cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 341d072edd95..fd51d6554ee2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -684,6 +684,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		if (info->read_mmr_reg.count > 128)
 			return -EINVAL;
 
+		if (adev->in_gpu_reset)
+			return -EPERM;
+
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
 		if (!regs)
 			return -ENOMEM;
@@ -854,6 +857,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		if (!adev->pm.dpm_enabled)
 			return -ENOENT;
 
+		if (adev->in_gpu_reset)
+			return -EPERM;
+
 		switch (info->sensor_info.type) {
 		case AMDGPU_INFO_SENSOR_GFX_SCLK:
 			/* get sclk in Mhz */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
