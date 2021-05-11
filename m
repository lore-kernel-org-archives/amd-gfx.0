Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 17:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DB461363
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 17:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DB461363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=my.bristol.ac.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D006EA98;
	Tue, 11 May 2021 17:25:24 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2CE6EA98
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 17:25:23 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id i128so11533057wma.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=my.bristol.ac.uk; s=google;
 h=date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=YBw+3kTekV0bMl+PsRHCnL4SWoA/B2dyme3D6tSwrfc=;
 b=NU7qRVpOU4MEp5YOrE68c1ahN57b07QmIUxW1a3m9O+8y5GMY/+APfIgGj+OKvQ4Gy
 moB5IMoRXfMRB3fOIpQoiNh58UyFqIMCOIVFB5hON+FMfcf5pNoGqSHzJb+qzPSD9qQc
 gCTyfZN/jOxNhcV5Eauh0r2E64AgAMP57c3NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=YBw+3kTekV0bMl+PsRHCnL4SWoA/B2dyme3D6tSwrfc=;
 b=kgWejqWJRGAVYitbv4xBIvV2gDtgi/uOrPFPOasUgmQTL8YK/nHFIbRb1TgOOz7joq
 oz5A1kmiWR+5C9DpchHTD0Cb2efuj4gKYgZgT/1Kn+EyuCpy8f60DgOJtsqIGRM8GLI4
 4XxFtgD3OcS5hpvE4/1pDtiHtWG7c586Rg58yPXcgh2b5prXwrnmjPUNGIKnDseyG460
 J3LnokJakVj7LkmsmD8xwMOCv7v5BgIpYhZ4BOCJ7ompYwZVesvJtWs6x06rqfALxSwu
 PddaEzNojtCNf7LSzIT7qLYhMZ48Krl5ShsNOz3QR87koAUsoIU2JUJU1CbKppZBmLsf
 qq3A==
X-Gm-Message-State: AOAM532sz61OJP9h77o1tp3eKU3x3V6tc9J6Jq7FXyP5wE13X+pgKvI7
 Iu4tZ10ky5wWcbmbSvJjvF0FStJvr2WojpQn
X-Google-Smtp-Source: ABdhPJzap1RkzX/2cehVbKHFLnCGBJbC+nAjEzgnquiuoBcy8TMT+LAB7xgprwrDil4GWxAJEa8bMA==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr6888893wme.0.1620753922452;
 Tue, 11 May 2021 10:25:22 -0700 (PDT)
Received: from localhost ([2a00:23c6:2a8f:de00:212:ddff:fe76:5c63])
 by smtp.gmail.com with ESMTPSA id b12sm28243082wro.28.2021.05.11.10.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 May 2021 10:25:22 -0700 (PDT)
Date: Tue, 11 May 2021 18:25:16 +0100
From: ts8060 <ts8060@my.bristol.ac.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix uninitialized return value
Message-ID: <20210511182516.3e9071bc@my.bristol.ac.uk>
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
Cc: alexander.deucher@amd.com, airlied@linux.ie, christian.koenig@amd.com,
 daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_display_suspend_helper() function uses an uninitialized
variable as its return value, causing a failure to suspend/resume on a
Radeon R7 240/340 GPU, with the following error in dmesg:
[drm:amdgpu_device_ip_suspend_phase1 [amdgpu]] *ERROR* suspend of IP block <dce_v6_0> failed 118489088

Initialize the variable to 0.

Signed-off-by: Tim Saunders <ts8060@my.bristol.ac.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 8a1fb8b6606e..27626d8a0647 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1544,7 +1544,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
        struct drm_crtc *crtc;
        struct drm_connector *connector;
        struct drm_connector_list_iter iter;
-       int r;
+       int r = 0;

        /* turn off display hw */
        drm_modeset_lock_all(dev);
--
2.31.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
