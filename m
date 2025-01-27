Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4E4C0218C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2025 15:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7782810E566;
	Mon, 27 Jan 2025 15:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U8beyF4N";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1520310E566
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 15:32:11 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so32482795e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737991929; x=1738596729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4uhajgKuIKNXhznhjeXP+/fqZXJW6Pdme/EXXkFG0+c=;
 b=U8beyF4Nj51IicQTGSzB4Gcw4hHglMeDHBNM4q/UgBDcJXXl3HUp6EDPhKzBpbc/Dq
 pYw+TGM5orhods4iQ5r6PaASbhTYUfY5gozqDy61VLus0bGqAVDc/lrYV2cbg0mVS8LW
 LeBk/ucjNX4Qbgse9DBQTyhrukBqUIspHPL2pmROnXvKF9HhAmf4Ad6hDchezsRFIkHL
 7xnAAYmCvq8qVPZjgdnAIIs7ccniNB0rpx4R1RkfD30qH4Bmf5xfd6BqpMTfgZonMKZ+
 snnOVrqaw3bQfsnB/XyWZEVvoH+j7vTJyrU4WfSHBZ3NSc+ip4+001pRZ3xuK5K0BYnH
 MR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991929; x=1738596729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4uhajgKuIKNXhznhjeXP+/fqZXJW6Pdme/EXXkFG0+c=;
 b=b5lg9PPlX/MPoY71/fDLbmZF+ENTBQTYzrVE/ldsrxevRY9/tR9cveQwY3n7yw677O
 xCxCPawaKvnU0lDRVhId4WTDMV55AE6aTQVN5WHHT0az/oOp13mkmMNBwYeV0DyIz8/M
 mwebiyAe+2InDhCSyYhTnuUsIIqEE8KIv7TVzO9pgZ1oQQAng3TH5LRtqvC2/aKfDXxI
 GNY//jK3vXjwHfSM4IeQeleUnmRbuNwadTq42M6Zq2dBz3NOpty8KzR/y/oDPt32L06T
 VwKqUwIyMRAupEYBALoKMfiOndnU6/9CRip22M+Y4UgxNqXt8H15Fivwp7nv+JE/+kVo
 NFqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfTTo0jO3CBHtEVEfJfBZ1hnASW/zeXOVojr4QYhymwu3RBR4XqLxvkYkl6bnad6BDmGyG5GI/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDCJGI9mJ1uzFqDKD/5RhW9PHZyLmOBDNnQLzbWyiSZVjS9P5e
 oGhZVKUxk1SYk3Vnv59oNYIYzlwPMPAF8sb69gxAuBHqCVZwidMLXP+52jak
X-Gm-Gg: ASbGncucpNr9ba7+xAQMcqiDsFBLZWD1e3D2e8W2xJbHXUf6aZ59UfGx1RUJ3tzUlcd
 /tkp5b2ENRg6x/8F2ORl82olUkLDFM/JTSNAgJAWQnJhT4+z0vhV73ESFWpEXQRjJBvkBwN79Hm
 vRgocOx2I64QlZTsaE1KS9NjqHHjikkpxceX49YzAqinG0dDvr+gd3+2hBwtHHxnM32PyaK87L1
 AtJYidhHYXw8G4nc0r4MzBEgklbEtYNgBqZZ8SqAU4doyY2H4OHrOIf0BuDcvqJkz36QD1dBAmZ
 1HnBadga+HOKxzRq0QRgmyz+W9dJ
X-Google-Smtp-Source: AGHT+IFP+rM5yEFoaCPdtjMR3YAjdxt/OB1IXLDa4OhXGsMDNg5S4sXRkfzdDiUya3nrRFNmYcOS3w==
X-Received: by 2002:a05:600c:1d1d:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-438913e79e2mr376604875e9.13.1737991929190; 
 Mon, 27 Jan 2025 07:32:09 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:153d:dd00:1202:d6cf:5d6d:56cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm133904325e9.39.2025.01.27.07.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:32:08 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: grab an additional reference on the gang fence
Date: Mon, 27 Jan 2025 16:32:02 +0100
Message-Id: <20250127153207.5717-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We keep the gang submission fence around in adev, make sure that it
stays alive.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d6b473217c8b..aaa8f9f7b6b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6753,6 +6753,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
@@ -6765,6 +6766,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
-- 
2.34.1

