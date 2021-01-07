Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 23:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FA3206BE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 23:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FA3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1943F6E563;
	Thu,  7 Jan 2021 23:53:08 +0000 (UTC)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057656E5A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 23:53:06 +0000 (UTC)
Received: by mail-io1-xd2b.google.com with SMTP id o6so7924155iob.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 15:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aKj+NWaUmshIqRh7+UkWyqrNf0iFENOcFN9dAA16YtM=;
 b=EXGlVJj8hidtGw870CYKWt3S5viy/Ok1/CbwfXclezZ56+nLIpf6vIE+qCse3K4ADX
 nbib3Y69uAsCkj1/Z6ByXI82b+uGznK5vAVo/ckhYbyh+6iyc03OCa/HY8NeM4TY5Bun
 Sf+wr29iTdZ0kt9Akmfn48JXQnatbkRl45quDq4rLM/GTCGpWDssewLKu8V+zHS+rW9s
 xVg+131YQ8zQIEEnCWeP5Epfygvz/1ToK0RWpvQG3KAlRTMdzlJpUGA9vPKnRuPwWNyt
 CsW3pHLK1O3e3UIqxXXzJET9Y3Kk7D+6D1kbJqi2jTadN9O2bJOP5UDDmavi/vbvGdLx
 O2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aKj+NWaUmshIqRh7+UkWyqrNf0iFENOcFN9dAA16YtM=;
 b=e3dzYzgcgZtrvn02Tq18jIQPBZN5ty3JHDcWRUuSAGToZr71LrTTDKFrh6sFgDk/ry
 FEWiDFpErbW7M2x1ceStSKGj6lkN+w7OQI7/XsAlw2ZcxDRGVAjdpHk5LmfgM5M5GU8V
 RH86HixC5FYTUithT2tZloxiLAbUd6UPpqOp6fCMlP/A6wo+NBfzY7v8JQW/F84oj4XH
 +alf7ydMRRgmOGR5nG5LnqAJmTGywjaRRQfMY2dskkxnuLwA4UKiHFkUaedtW5ty6pz2
 OF78jokJ5HGcGfHHizb82ENS2uJQM4KYf6lm+DhfzqpWKF4mUJwzNuy8YOKXvI2u5JX1
 Vf7Q==
X-Gm-Message-State: AOAM532js6IaSrqLqX2IrsY05aBuo7FrqXJEhRV9ktxd+6oHCLkLnb9S
 xNqqDk9obeBGh+bfIK74Bv3BTpPmje1Shw==
X-Google-Smtp-Source: ABdhPJyXRauYr1KlYZz+vgiqVkCV6+h0vrgbx1Lx/nZ2FPGcFYJ+8JdMBKqttyyCQPCFBaELYe7+rA==
X-Received: by 2002:a02:2b2f:: with SMTP id h47mr891738jaa.139.1610063586216; 
 Thu, 07 Jan 2021 15:53:06 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.246])
 by smtp.gmail.com with ESMTPSA id b22sm4258016ioa.10.2021.01.07.15.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 15:53:04 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix DRM_INFO flood if display core is not
 supported (bug 210921)
Date: Thu,  7 Jan 2021 18:53:03 -0500
Message-Id: <20210107235303.99848-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.30.0
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
Cc: alexander.deucher@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fix bug 210921 where DRM_INFO floods log when hitting an unsupported ASIC in
amdgpu_device_asic_has_dc_support(). This info should be only called once.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1cb7d73f7317..9246c2ae7b63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3034,7 +3034,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 #endif
 	default:
 		if (amdgpu_dc > 0)
-			DRM_INFO("Display Core has been requested via kernel parameter "
+			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
 					 "but isn't supported by ASIC, ignoring\n");
 		return false;
 	}
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
