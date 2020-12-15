Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7228C2BB48
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A638F224B8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A638F224B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8888E6E3EC;
	Tue, 15 Dec 2020 15:29:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2C86E3B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608043358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kaTetupLyuYrqzsX7UwEN39ZooQ2px2nX3T94IUgkoc=;
 b=frPSzKVTfiXDCO1+/hQjxVmjPG8c4I5rgUJzSP6dN0cDgSToNEIP8/nVFGWpM+PUvwcOYC
 W4tjbRfXwUcO52cNjcGgwOZG8UgeJ8LPsD+VXHuWQ59S4v/mZVeYApGZEwQsmwjqC0zY/x
 BYY2cvcywKYKXrPftxZwIuwdyHucpZo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-j35q1MIMO6yg_F2AHblDSw-1; Tue, 15 Dec 2020 09:42:36 -0500
X-MC-Unique: j35q1MIMO6yg_F2AHblDSw-1
Received: by mail-qk1-f197.google.com with SMTP id t127so15406496qkf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 06:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kaTetupLyuYrqzsX7UwEN39ZooQ2px2nX3T94IUgkoc=;
 b=VJRoxLgcaF5m7T1Ip2l/UFuU9/DUTf/p1qBhf9aZcXKZa6R/iZS93PNNF/N+9fJ1Qo
 gShD8jeo6p7m1s/yy7VkqNk6e8O2/wPt9sSHpx1ueMJC+sKaUH7R1kFjtbC/Fbw/bCO2
 6vlB8Hy3OhWhaIfhNY28119MvtmFRuA73qz4GUF4QKd14gPkBaT4BpzPKwKYloDbKGY+
 HoENNDToa+2b69E3dINoz4L1Cuw5ggKuyOAFO2eg9LnLHbqiHN307aTbVhhrykpOO9eW
 v1/YR0xhLgbm5MrPL1R2gX6NmzhQIuiEbAZH34IiF9oYkeg47hiWrhelPorqAOmeK9r+
 AxyA==
X-Gm-Message-State: AOAM532jzZaJaBFvi16i3cXWeTFb8QO6L71kTHPF3MMBxAcjTzqa0PFs
 KanPbeTR2F72F06msKTrSjc6ZsgLjxQVSjMW8FINrkUFYM/Jlch+xczczeeyZotNqpoEpufx5dL
 CyNQ4WB8wbhA37/RK1B7Z+kiFsA==
X-Received: by 2002:ac8:5c13:: with SMTP id i19mr38740570qti.250.1608043353971; 
 Tue, 15 Dec 2020 06:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfIuT11JaKaKkZRsbteafZAH9wJ/RUSSqFrn3oRILtxKd8WAilaGcx6jRbNvgnaQ2aFZrBFw==
X-Received: by 2002:ac8:5c13:: with SMTP id i19mr38740349qti.250.1608043349158; 
 Tue, 15 Dec 2020 06:42:29 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id 193sm5726550qkj.105.2020.12.15.06.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 06:42:28 -0800 (PST)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH] drm/radeon: remove h from printk format specifier
Date: Tue, 15 Dec 2020 06:42:23 -0800
Message-Id: <20201215144223.1881097-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Tue, 15 Dec 2020 15:29:11 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_uvd.c | 2 +-
 drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 57fb3eb3a4b4..39c1c339be7b 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -155,7 +155,7 @@ int radeon_uvd_init(struct radeon_device *rdev)
 			family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 			version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 			version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-			DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu\n",
+			DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
 				 version_major, version_minor, family_id);
 
 			/*
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 5e8006444704..a450497368b2 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -122,7 +122,7 @@ int radeon_vce_init(struct radeon_device *rdev)
 	if (sscanf(c, "%2u]", &rdev->vce.fb_version) != 1)
 		return -EINVAL;
 
-	DRM_INFO("Found VCE firmware/feedback version %hhd.%hhd.%hhd / %d!\n",
+	DRM_INFO("Found VCE firmware/feedback version %d.%d.%d / %d!\n",
 		 start, mid, end, rdev->vce.fb_version);
 
 	rdev->vce.fw_version = (start << 24) | (mid << 16) | (end << 8);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
