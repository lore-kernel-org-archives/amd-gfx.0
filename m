Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0321C54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 14:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C602075A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 14:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQRzXifu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C602075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB8E6E069;
	Fri, 24 Apr 2020 14:07:47 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812096E069
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 14:07:45 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 20so10191022qkl.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ppTurvTf7RhzhSp9AgJmUkRged7JtOTflshEiYs3e0=;
 b=uQRzXifuG7d2yFolChv1S20wud1RdmtE9wXKXaGkNXImUU67SD0qLDcR6kjDmBt6Yf
 0DwZ71r+Y7xr4JZYufFPSlOM7NcGAFGxqL4LQLW00/bO8wTNa+xOR6ARgtkm5K2IG6ee
 coOWvBU/qxK5CzjXTkpS9hwLm0jGk3ScWiSPZm2avzEMcIybCE8pe7I3EG4EU4YAH6MP
 M8A7HSYU6VmxbDG3NaJrfOX5O1G8KZdN7ojS7XTk3KcV6y8yhqWbVURuJ3CUswm/Tl1f
 l/fohp2bWh2Ij2twVqP/VcXQHLcOBfHrOBaFi2Qo0hrDY2sZIR0MzP7CnhnBDeWtdSuv
 lTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ppTurvTf7RhzhSp9AgJmUkRged7JtOTflshEiYs3e0=;
 b=BnYlJO1uGt5ixuMB0IcY0pD2kdGbfLi3i0D5FsT6bKit7OAgamididhk2xp0sZCaSU
 /v/LFpdLqqEMGEbWvuYEWT6CSjsTv2H6imU+aepAUce7KGxFGqhrUzlKSZawSbqHbXme
 D3pLyWmByAjEpUsyq8bTj9rvaDi75et6S3Oxp0D33XzQe5y9NOmvGbgWz2w7Ow56P1fc
 GvxWjJkgXB3g2hbwQE54CYeY3CBYla4lN6J+7wa/N+2/AunBYT6N+CMq2gtsKqOsf7Zp
 NYguQ0H9DHydZZ2SReuS4WhM+gZM5mfWK6oI7Dj2rRLgjZ6QsDB8GiuYf969XFpDDyCq
 tp9A==
X-Gm-Message-State: AGi0PuaLlJRbfYHzmVVxKuBzEgzXWFhHweN60X7NyLlpZtGGdzHc5jVk
 WSJxPe1DR7VWS37aE4DaAM6NNDv4
X-Google-Smtp-Source: APiQypIXbjp83xgj59FxTEfuPYJZaXde23tSEbqJsPJs6A939Kw/6j/Xql7mj9Spxn6Yx1z3WdVPYw==
X-Received: by 2002:a37:4a14:: with SMTP id x20mr9064744qka.357.1587737264348; 
 Fri, 24 Apr 2020 07:07:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w42sm4028308qtj.63.2020.04.24.07.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 07:07:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: re-enable runtime pm on vega10
Date: Fri, 24 Apr 2020 10:07:32 -0400
Message-Id: <20200424140732.1766356-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.3
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

It was disabled due to a ROCm failure.  I think that should
be fixed.  Re-enable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Can anyone verify if the runtime pm issues with ROCm have been fixed?
I'd like to re-enable runtime pm for vega10.

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ea7e72ecaefa..c7f42ff6ab5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -172,7 +172,6 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	else if (amdgpu_device_supports_baco(dev) &&
 		 (amdgpu_runtime_pm != 0) &&
 		 (adev->asic_type >= CHIP_TOPAZ) &&
-		 (adev->asic_type != CHIP_VEGA10) &&
 		 (adev->asic_type != CHIP_VEGA20) &&
 		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
 		adev->runpm = true;
-- 
2.25.3

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
