Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B8C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 14:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BBF2078D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3vzsWad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BBF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC576E128;
	Wed, 16 Sep 2020 14:33:32 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3A76E128
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 14:33:32 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id cy2so3646765qvb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SIOOmbSes92Go7JSTrGUoUlekdlnfiuxZOgfHaiFSXQ=;
 b=q3vzsWadX7UEVD7w5NZw9HjS6DMdkZZEM/5NE6m6cLVOBgWLWGlB09K26QTqXbInQD
 Ms+0us1qBh/uOq5MVg+hjSGHpYXQu5cr9mailnAdoA/zl4ryry0JALMFVGwzYPGnWEvH
 lEMNDxtn2n5UmGXXFv238L3BJez2cBNxkiN8mBCTE3RTa4Il7qmSH8eqQyuMVfNsC5wK
 LgYdXdokfWoxVChF8zA39GG2M/XA7YRNitkAv15luv2t1vkrvAVipigb2Olo4mIXwLRH
 zOE62/rp4cAIsFVRyiI69sFmo9aA7r7x1GqJ2uNAAiZDV227BSXmqac6cgRrr4oF6raR
 ddaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SIOOmbSes92Go7JSTrGUoUlekdlnfiuxZOgfHaiFSXQ=;
 b=emmo0i2ydYlq/L7XPUUBaSRbo1v2gYPTW21ejUgUxQhGP2XavqB+95nElxmpvM6+lr
 3DcHq6uj4YnMNtFYG+xrLx2QHD2hkdn56IRn12Na2LPt+asO/nq6BQyoSB5SQTy4rIQ1
 mXwkq0OBosC8mJ9mQzgAJnQy+pebAJQwUkvESvRXyoPd/COgplwcqx66lmEogDHSwCcE
 qjm6A7Xnfod5PuQI32IgoL+bYM5Wl82EP18LA92fgmF2ZKj4oEYVFBGXWj+anP+x4PIi
 zz/RizUv2DtOqR7/IqNXn4Uml6EIYH779qibq95QV4Z384i9jBbZfVZT5ZIq9DdZg/E3
 jDBw==
X-Gm-Message-State: AOAM532BuOx2n8cvFnFrFMKi5e5TfWh7oXL59RreNVoKgxgK/n/TIZTK
 rNnNihNuT+UjlRwZ5nY8kx8t+Itg7G8=
X-Google-Smtp-Source: ABdhPJxjQFMG+a3e0ENt7/Aj9gJ79J1YH4RyQoQ+Z0bh25vaPJ4LX3DYflE5F4iX/tAitHq9Rs39DA==
X-Received: by 2002:a0c:eb0c:: with SMTP id j12mr7218246qvp.47.1600266811235; 
 Wed, 16 Sep 2020 07:33:31 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id n11sm19180768qkk.105.2020.09.16.07.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 07:33:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: unmap register bar on device init failure
Date: Wed, 16 Sep 2020 10:33:20 -0400
Message-Id: <20200916143320.1411815-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>,
 dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We never unmapped the regiser BAR on failure.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d633e5448476..61ba5eba678a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3209,13 +3209,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		return r;
+		goto failed_unmap;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		return r;
+		goto failed_unmap;
 
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
@@ -3421,6 +3421,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (boco)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
+failed_unmap:
+	iounmap(adev->rmmio);
+	adev->rmmio = NULL;
+
 	return r;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
