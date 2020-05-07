Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A7C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB8D2083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxonE8/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB8D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7856E149;
	Thu,  7 May 2020 16:08:18 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB8C6E133
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:08:17 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id n14so6648551qke.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aHFU/ZqoQCiIUgRndVlrBQxb7lJjQ9Hg9cRH21MaTyg=;
 b=ZxonE8/7A79OZMwPhOu2XnUrm5wqaCmV5P9MXcjc5et9VdQPG3kJK4QcLwumGgT+2y
 2TlRHpYmXwcYI7lkg3OHh/0yqUqlCTyDpBy6jMsP7N9rTzQG1MrJuZww+5basKCkMbwX
 vHnLt5j2lV/ZGQnOAKk8Bkmqm8cGXzfMwXdSgP8SZqxTT0OYXpmfJjQbtgttFHPbdInE
 bN4Zid+HvIfNchQethTiuV1E+uj68Dq6qfsIhT6s4AHfrNOZZW4fxBbhsC/ZqAjAztEk
 fptMC9Gnd72YiKmtnJgDvXZrS4Tjbhs4mUayc+XT5edggS1ppNJ/h16VZRc193G760Sr
 4fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aHFU/ZqoQCiIUgRndVlrBQxb7lJjQ9Hg9cRH21MaTyg=;
 b=ilfmEhntFB/+xFlKPWoJvVi+bK0e88OLQW1rba36gZuPPzhSOibKQFOwvEWAK4ZTVM
 I8gqkMXf2B3xbwxmy0mgnnZDu9hi5Ca37ewsD2a2FHDE7o8wMLQTRGivgQovssf6KfOn
 f6koOLucaPHBJ4JkvJXifBeSDj13YV4jHw3xiqd0v8t2kvvwtcPOYXG9UY6kBQez+EWB
 r40j1lOMjULNfQLEkqD/gGhP0mMrjiGq4/mkejnefhDe6X4bl1K+DEcmhMSiOnNrm9lU
 6kB6x/p/6rO2CceIQ/0rrzaqtXpyMeU5fY5kReCbGSUjkuMNpITlVVY2th2Yugj/nrBS
 WXRA==
X-Gm-Message-State: AGi0PubtdGuLfCqRM/OpuPLB6NG0sO8Jn+8n3JUPpHicr+Z6HqB9QIr+
 n8++E6qi7aEOttkMrqEk4Jr7i0/P
X-Google-Smtp-Source: APiQypIoqlR8D2hq0LTc/lvqa6CMku1vlNZm+iOzG+GdK+/ZEqKy28abq/x2YlgvLDFdW7f0tQpcPQ==
X-Received: by 2002:a37:e310:: with SMTP id y16mr15866151qki.275.1588867695296; 
 Thu, 07 May 2020 09:08:15 -0700 (PDT)
Received: from localhost.localdomain ([71.219.37.167])
 by smtp.gmail.com with ESMTPSA id d6sm3186567qkj.72.2020.05.07.09.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 09:08:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: drop pm_runtime_set_active
Date: Thu,  7 May 2020 12:08:05 -0400
Message-Id: <20200507160808.4250-1-alexander.deucher@amd.com>
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

The pci core handles this for us in pci_pm_init.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c7f42ff6ab5e..233d6c8c4ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -191,7 +191,6 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
-		pm_runtime_set_active(dev->dev);
 		pm_runtime_allow(dev->dev);
 		pm_runtime_mark_last_busy(dev->dev);
 		pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
