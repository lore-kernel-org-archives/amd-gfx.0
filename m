Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0ECC47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 12:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508F206B9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 12:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508F206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAA86E0D0;
	Tue,  5 May 2020 12:59:36 +0000 (UTC)
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FB96E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 12:59:35 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id y4so1489734ljn.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 05:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=OJguaWHZ+vGlPYL86fZ1YbDGutZx15FCOsPxOiBO1nM=;
 b=cy2augcnrodmssYFAETDn+XDNFDZPop7mnbaclcEygdbXkb6I/fe7AnwraXBFV9wY6
 kf/iRCg1YWUeLY9Ogd3sBWsFpUNhywrWbYVusMQ1TKPFfNaLl3hbjR8Xt9gHzgiNQyqF
 NFvjONBQIkgmTTa5pECgrxs2ZVoh9n4ZxdZmu1QYMITqNx6SoBYTIv7Snjya8pkf+kAn
 CuOWFdW1LFrvbkISZmcTN+/kaw6G1ktOAciEKpforUTUF3OShVNPDopXyds/B2CNs7k8
 YUVB9Ovt24kPsmwuuUGpYJrjiAEY4bvmNQwQkNc4/thllDN7uzAliUdtcrGKBsxD8y03
 SH1g==
X-Gm-Message-State: AGi0PuZDzG9pcUs716TSKjUEDLYbTIrZBvbA0f4uN6/uhPJTW7iMtEhO
 owGokjcGz8hrvcqTNVUIyiec0igicW8=
X-Google-Smtp-Source: APiQypJbSpVPUOfAkS/CwcxVOpGOjQDrqKgcg5rWHNMzCHf5OG8DtN2r5MaapbTY5BWfR2GMpy/hOQ==
X-Received: by 2002:a05:651c:201e:: with SMTP id
 s30mr1827892ljo.190.1588683573618; 
 Tue, 05 May 2020 05:59:33 -0700 (PDT)
Received: from [192.168.0.88] (east.meadow.volia.net. [93.72.151.96])
 by smtp.googlemail.com with ESMTPSA id c2sm1769158ljk.97.2020.05.05.05.59.32
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 05:59:32 -0700 (PDT)
From: Andriy Gapon <avg@FreeBSD.org>
Subject: [PATCH] amdgpu_acpi: add backlight control for the DC case
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Openpgp: preference=signencrypt
Autocrypt: addr=avg@FreeBSD.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d44edf2c-32f9-eb61-3447-be9329e88e34@FreeBSD.org>
Date: Tue, 5 May 2020 15:59:31 +0300
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 1e41367ef74ee..a8157a5154243 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -444,7 +444,6 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
  		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 -		/* todo: add DC handling */
 		if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
 		    !amdgpu_device_has_dc_support(adev)) {
 			struct amdgpu_encoder *enc = atif->encoder_for_bl;
@@ -463,6 +462,25 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 #endif
 			}
 		}
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||
defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+		if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
+		    amdgpu_device_has_dc_support(adev)) {
+			struct amdgpu_display_manager *dm = &adev->dm;
+			struct backlight_device *bd = dm->backlight_dev;
+
+			if (bd) {
+				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
+						 req.backlight_level);
+
+				/*
+				 * XXX backlight_device_set_brightness() is
+				 * hardwired to post BACKLIGHT_UPDATE_SYSFS.
+				 * It probably should accept 'reason' parameter.
+				 */
+				backlight_device_set_brightness(bd, req.backlight_level);
+			}
+		}
+#endif
 		if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
 			if (adev->flags & AMD_IS_PX) {
 				pm_runtime_get_sync(adev->ddev->dev);
-- 
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
