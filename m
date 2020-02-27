Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C59C11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 15:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3627424691
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3OVfRiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3627424691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 015806E90C;
	Thu, 27 Feb 2020 15:01:19 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50B76E90C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 15:01:17 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id u124so3334816qkh.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9kJ2m6rbZWMFiMlPkvOAL3EE57aeaYEMa+uPNu2tzOI=;
 b=A3OVfRiC9D4gecrHrDLGqN6k2k6lLbZ9CADTjhBzUUROhpe80vvTvqi+823HrA32U0
 uWgAj68JzQU0mi+D2cFW2IKlbhYd5OVdD3Ya9yxaoimOj4j85LsXfT902lzLajUc5lec
 K/dBMlhHKJRBNaDAgLFY6+tAqefphrxPOHn7srlvXcjt9DHQZCZfut3Z0DH9PmGp0vG2
 fjtNv9aYbCSq5s9teho3FWtiRUERxYqTMY2DVD+r5dsz5kKkvv0ICLphAfHl8+xRTwhg
 kmKxjrZyuyWQvAlHP8CFilZe6H9Z+lMq45/5DGGyZnEoN0u6E1dpEwjry5d3Ep1X3bqK
 71nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9kJ2m6rbZWMFiMlPkvOAL3EE57aeaYEMa+uPNu2tzOI=;
 b=CxoSWaEGd0anD/86MDBn7nbPzaf26WAIsTwTTFVOkkJF0YCmTwHPF1kZQZokzki9K3
 Rup3jIoAES4QLH17r2MIVCQcdRBYR5drI5AUxt0mFLEak99pky98F9LQmfJqX0FvJkV8
 wwc/2uSj3Y3xYALf6UL96djPgcSfwScGP1XiQYJiS/+It7PTrjvZGn+t+5c0x2rgFkYu
 fEFQScucXGF5s8I9URfHli5x6lvvJhO8VBGi8aXJk9Ax6vEBl+Z4cyk/JRRmS2N9QwIl
 WnfhNfpDJW90TG8USeoyxaHRBjPHJTOnfmBTqhnh3JfKc5kp4UqRtj96ojgigfnt84Ax
 UTjQ==
X-Gm-Message-State: APjAAAVlOWxEImusT9ZQku3voXdO6ceQCULj3I7kfiDUOmnBu1jGFVYe
 zO7dCzY2KTP8gFPNWrnb8Ax0IpIc
X-Google-Smtp-Source: APXvYqwWVFY0nxv/cXs/mBLezt8jAgU6dsLBSwHu8tCIxmcaPy7Tg6OEWAnLW8UOrt4vZPgRaOhFCw==
X-Received: by 2002:a37:a6cf:: with SMTP id p198mr6261745qke.298.1582815676603; 
 Thu, 27 Feb 2020 07:01:16 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w41sm3257868qtj.49.2020.02.27.07.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 07:01:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: don't enable runtime pm on navi12
Date: Thu, 27 Feb 2020 10:00:57 -0500
Message-Id: <20200227150057.32976-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

BACO for power savings is not supported on navi12.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c4f9d0e32383..eebf6ad04a78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -176,7 +176,8 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 		 (amdgpu_runtime_pm != 0) &&
 		 (adev->asic_type >= CHIP_TOPAZ) &&
 		 (adev->asic_type != CHIP_VEGA20) &&
-		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
+		 (adev->asic_type != CHIP_ARCTURUS) &&
+		 (adev->asic_type != CHIP_NAVI12)) /* enable runpm on VI+ */
 		adev->runpm = true;
 	else if (amdgpu_device_supports_baco(dev) &&
 		 (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
