Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE6D3C545
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 12:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4E710E71A;
	Wed, 10 Dec 2025 12:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G26HG1kT";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334E310E722
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 12:57:43 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-64175dfc338so11704794a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 04:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765371462; x=1765976262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iHUzl0jXLnPifFcmvE4RMIzU2nxK0hjaO7DyiyXDyOQ=;
 b=G26HG1kTXGTDvU9aRBV/8AzgAf2EbATzR1EcOpQVojk6Xg2sgOac2uvWyyoHoGBB5q
 Z9I6EddgebKhvPxNX9z8PlGNpTFDkdSvMBAMez1jFCkTlAcBVGM3hfe9HXYetOdHku9M
 6k94XO/+DvAHo05XxPnUiGrlM1ZxSb3b+ROuNHibAhhUUKOm+9QF0a7lg5G8bUXfjY4Z
 aPt+CvD1RQtjIKHV82YNFuWZhrSVDNescuxgziSkbdaTJN45nkGxcfgrw+U+F0d9gQY8
 P9JLoWVe1+C9rRh5zrScOsrHCR+2chjpI2BO6HItMsMXpy9WmdpYzNgz3QpZI5V2TvmP
 aAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765371462; x=1765976262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHUzl0jXLnPifFcmvE4RMIzU2nxK0hjaO7DyiyXDyOQ=;
 b=tc4gZhmzLOZjRFgzYHbV1wpZQyj2LSn4bbKsGUHtECy33MGhKCpF/GpnRt8gMdVU3f
 5+yOQsJr+pB++nIKAiBqQnCzZ3jI3UHCcke+/uQxPubQhd9yO3osw4lVyXVVSpxmMtQw
 I9edhEZTYmRwLIhW5NDpRVMrvyzdsEJ7M1vbddQoB8ipPSMDvLTwEcADg46Izu5jkdxB
 21BPRpy3x95fnylkNOjyiktpo0p+YwuU+RB63xmHtdu+KS2uw5wTnTn2vfGCW+suiFAM
 czLa+yYoif54NczX1jKo1+iMV140reozz8bDgPwI3fntRH0/rSP/w9OWgoWFCeesdp+0
 wjQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQIFbeVChAEEv2e7mH61k8HN1bDVyCxXLl+4IbxDVDyg9MfEakjcvKEaqOGgAuBQuhbxWlBEMw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYbIeL6CW+HoPXH8wyHCqLt4hnohzX7MC9jRziRFHJeVZj0dEK
 aHOXtwr4Ykl8hIZRh0YKKdYUqPACK/tkMCkEbGB3126VlFokDwQC3nKRGqKNJQ==
X-Gm-Gg: ASbGncsfBnmieSdpPeiu2ZTatnaS3fWIBPOrFcYGRvCm0BlKp9omui5f3rzjvYflrWS
 AXBu3vuQjkLX0BH+wkXvyoXayMvNiJZnLvocd4EY9Nj7OU5xbFk+DgVTjLO/6yTx9QVUBcyr1c/
 AuDJkgs3xHlLuv2X593VAUqhTt1UthubSYW5cNmUFD5R+88d9pvoxGqZyl8lrosaMv2mDfVprEl
 jZv6NiOzwP1deNuP279eGyYP/s1mNTF+xnJ/SUsY/N3E360ObziZGa4PEKvIZ3U+y981hHuCSCv
 53njlHjg12ESIaCh2PFq4qEJDXFxZhvpnNC4X18CfWp3w+uKu2sCU/keBvu3QZOyxMNGGm437SF
 I9mPfH2Qn79lH0URn4bvE9OjDobkMyAskpHz6MXVlZEZ5ozzpxJoLuAMWua7owgdnvF15PshZgd
 CQ9/5VfDq3eQExFzuQsBt1Oc9U
X-Google-Smtp-Source: AGHT+IFpd2QUyY/zMs7h5kyT2pacf0DSXr+PvK5gCPW3+PAOBx2yhQumjFbiWJXHPCARJxAvVQ2apQ==
X-Received: by 2002:a17:907:7296:b0:b79:fe73:3b18 with SMTP id
 a640c23a62f3a-b7ce82c079emr243010166b.22.1765371461523; 
 Wed, 10 Dec 2025 04:57:41 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:150f:6900:c008:70fa:ef35:29f1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4975c88sm1659704766b.35.2025.12.10.04.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 04:57:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: phasta@mailbox.org
Subject: [PATCH] drm/amdgpu: cache the pasid in amdgpu_device_gpu_recover
Date: Wed, 10 Dec 2025 13:57:39 +0100
Message-ID: <20251210125740.9551-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

The job might already be freed up here. So cache the pasid for later
use.

Signed-off-by: Christian König <christian.koenig@amd.com>
Suggested-by: Philipp Stanner <phasta@mailbox.org>
Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 654f4844b7ad..84bb89498e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6506,8 +6506,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct list_head device_list;
 	bool job_signaled = false;
 	struct amdgpu_hive_info *hive = NULL;
-	int r = 0;
 	bool need_emergency_restart = false;
+	unsigned int pasid = job->pasid;
+	int r = 0;
 
 	/*
 	 * If it reaches here because of hang/timeout and a RAS error is
@@ -6605,7 +6606,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		struct amdgpu_task_info *ti = NULL;
 
 		if (job)
-			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
+			ti = amdgpu_vm_get_task_info_pasid(adev, pasid);
 
 		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
 				     ti ? &ti->task : NULL);
-- 
2.43.0

