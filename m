Return-Path: <SRS0=TD2D=DN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C43C4363D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 13:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5C6207EA
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 13:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XllLJ3Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5C6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB696E048;
	Tue,  6 Oct 2020 13:27:17 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163846E048
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2020 13:27:16 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s4so2294601qkf.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2020 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yz5QbLbYBaExcPYDWZQ5583wo/DSnCFpyUcDfXtJI8E=;
 b=XllLJ3KiCc1Q/AMn//Wf5tFNl5OY3RTZYRGFSDD73yaRdVia3qy5Yeq4E7zlVKfVtH
 JFbEFrquK3zn/I0GY/xF3R8Y5Oiwz4NHHCkiM1LHuNvDK1YK7W4gyP94yaN+L0fHB44w
 bwugl3YtWICnYGY1II3j60AkHyJzxhNwizZqJvokEmmPYo+dpvK+rpryBxuWrKNOUEFd
 BbHfG7BDmO4OMzdonD7bfuJ8Bmc4PWaB/jZbkWu7yeXyjRAD3Uh+nAa0LcjKaAOhXzsx
 LnUwFgAKU2km3faXBF8N8+tgcnBET8bddxauOaNWQkot9H03YcvCFU5rpTf/3DoH5HaA
 7Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yz5QbLbYBaExcPYDWZQ5583wo/DSnCFpyUcDfXtJI8E=;
 b=A64GyzJjP7FfaNMO3nf2DHEe+amrbthauaKW2/ELOOkXjIoG4AF6CERChvo407w7GZ
 k7+WaFf49S+gAEEW18j24zqTkhXjypABDGWDWtLRQJepwDzAwc5cR+qlY6ERdff29VLd
 k0teRM2HzjrYtRVurhORXMrFqFw7sUiUUVJd9/dmo7ZzPPQbVdjmGvdVlnvVzdkilkm5
 k248n8sBuLGmtJb5nwG6edWXRAP23metvByJSrcPiBJbHZP5KK+vSrMtrRJ6PZ1kAb5Q
 QknItpYa9JlZIo+DlF8uIkYFfbIgiWhEhW0rLz1M9Tc00R0+3cNr/gs2GIFyN4m7HNXY
 KJKw==
X-Gm-Message-State: AOAM532TSNKdtzimPoOAxoYKCRZfCardS089wX74oVHwaeRrjdbP9I9F
 LKqfYxzDdWLv5lHWnjhHFM/jNoIGpKg=
X-Google-Smtp-Source: ABdhPJwDSMBLmKQGBWUDt8vcwAEQVmu/+jblLjzrWaEWEQ7wyQ2hO7/Ur1ln5BxJe3BoOd68weS67g==
X-Received: by 2002:a05:620a:13d6:: with SMTP id
 g22mr2721337qkl.425.1601990834981; 
 Tue, 06 Oct 2020 06:27:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id b9sm1621812qka.86.2020.10.06.06.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 06:27:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: prevent spurious warning
Date: Tue,  6 Oct 2020 09:26:58 -0400
Message-Id: <20201006132659.1486610-1-alexander.deucher@amd.com>
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

The default auto setting for kcq should not generate
a warning.

Fixes: a300de40f66b ("drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v5)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a26894dc635..7f26408c0d76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1372,7 +1372,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	amdgpu_gmc_tmz_set(adev);
 
-	if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
+	if (amdgpu_num_kcq == -1) {
+		amdgpu_num_kcq = 8;
+	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
 		amdgpu_num_kcq = 8;
 		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
