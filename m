Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077DCAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F7110E911;
	Thu, 25 Sep 2025 13:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IWYGrHn1";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E890510E911
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 13:03:25 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so5010135e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758805404; x=1759410204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pe14LktvUEB/8Ve1o6J4wK7uCA1S7SHXPqVYQ/nbUOw=;
 b=IWYGrHn1gbKDim1W1+LHiHN3DmYOIAPjhnqGwuCjyB2fwGglfDr+QvWtmmeVAOS/wD
 /v1PgzOS3RiZ7TBBaxuAHNVWvkEMqBX+XLVq9r5i5cr3FuWVMTcf5afC+gBfg8gaC+Cz
 yZ260G4IH5fW9CB2XU4YRxRkshUNhZDUJo5gEJwdcT6ZJZcu/VLl3lAoBol9z1VHDfV5
 /O96qD9ccAkgudFfC1hN/CYxVlHQ5bG5SbEVSWz+3cdJwCj1I1XGhfSErwOkZxdos+/s
 Q+qBeTYy2DL979XBAJw24LlyqyETMD8V/wezHm/wnn5uU1Pbe9rdgxaSarzWK1F4iJVg
 C1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758805404; x=1759410204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pe14LktvUEB/8Ve1o6J4wK7uCA1S7SHXPqVYQ/nbUOw=;
 b=pE8OslYjbXYN3c6KwBP4ZY7vl9LOZIa+7d4am9wMGlhW+jiQ4uWTVkqcTjvR9FErBT
 YlS81C2DDMuG8yd/tsHOMWImxx9Qch2+rD4eMYLxIk9xqSihFCuoB3ecBIHpjbb0agim
 PE3urp4Lkvi0MaKolDX0Yd63MXJQUBSxnoYiBJC6wUM8IqmPLFv3tNGYnMxnFYEiW4nR
 o0ZkDuzaYYQiBVwRuhcLLTpn6Qo3gfXPkQy5v279GUmzYR7fpNoeVe0RwCxu43Ky8a7P
 HPg2cpc8dLlM9M6wXAWw/AVJwXEzxeyYPm2ZDINx9RQ5m9Rr60PVwm1hYC83lApBWEXQ
 rKRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA/0ejOgWaaRBPEvx3hqLWMhJ61SMEBAV1xUG4ltCNrbNFlW1kFSrHrPc+FjA5u0GTXx7J2Jml@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaUF3c/WQjK+Kq6gubdaYqVNvv2V5dW9ZJj3MKaGsxfenk8F/l
 vSFAdvpl6Yhkxf7BD5MK8zkEwDmZv5lmWqZzs8lDNoWDhMlGL+R+KHvS
X-Gm-Gg: ASbGnctb19e3UIBXctmtHdegkuh9OpFIY+DpXhX4d+yrdwEIYT+z7LZjB8lJ/p7dTZA
 6GxulqAa2E1pKZjZede+2hNAMwvTUWBsv4WNLoMX33XG9kRC3/igtysMgh7hzqImpfdBnM0oxZ8
 1u8mORmXzj+4sCZmkkOorpmOSXoGJtnGvP2pB1ePKOnJO65QOcZEhFStjuNo4HNm0XdncjSZ5/Q
 V/L9sceM1T06kawL+HH9t7KodYfQXf150P7owL0SKQh9C3fXtFR/cqxxIeAyf2Iu+CgWPFi/2uq
 HRXWW/KhnPDapcqRjxAPTlkYj0PdupvEBuokEQDXyYh9LTjQ6SEqkiBUH+9VBC3Ox3OxW8nhj4+
 zInajCYJfBiHVJwbK1FKi9YvxnP9Dr7ZwNnNyrAg2L/3NzYk=
X-Google-Smtp-Source: AGHT+IEOwdCMKXikPeKVpVAmmBoP3NKL7TtgLk3JqnJr/NXtWjQExm/O+m793ldOuMKBIJT2zg1P0w==
X-Received: by 2002:a05:600c:c04b:10b0:46e:2d0d:8053 with SMTP id
 5b1f17b1804b1-46e32a30481mr28999065e9.18.1758805403875; 
 Thu, 25 Sep 2025 06:03:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1573:9600:1c3a:dbbe:8ed1:34af])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e32bd164fsm18565765e9.1.2025.09.25.06.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 06:03:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: reduce queue timeout to 2 seconds
Date: Thu, 25 Sep 2025 15:03:22 +0200
Message-ID: <20250925130322.1633-1-christian.koenig@amd.com>
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

There has been multiple complains that 10 seconds are usually to long.

The original requirement for longer timeout came from compute tests on
AMDVLK, since that is no longer a topic reduce the timeout back to 2
seconds for all queues.

While at it also remove any special handling for compute queues under
SRIOV or pass through.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++----
 2 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..ceb3c616292c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4278,58 +4278,53 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	long timeout;
 	int ret = 0;
 
-	/*
-	 * By default timeout for jobs is 10 sec
-	 */
-	adev->compute_timeout = adev->gfx_timeout = msecs_to_jiffies(10000);
-	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
+	/* By default timeout for all queues is 2 sec */
+	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
+		adev->video_timeout = msecs_to_jiffies(2000);
 
-	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
-		while ((timeout_setting = strsep(&input, ",")) &&
-				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
-			ret = kstrtol(timeout_setting, 0, &timeout);
-			if (ret)
-				return ret;
+	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
+		return 0;
 
-			if (timeout == 0) {
-				index++;
-				continue;
-			} else if (timeout < 0) {
-				timeout = MAX_SCHEDULE_TIMEOUT;
-				dev_warn(adev->dev, "lockup timeout disabled");
-				add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-			} else {
-				timeout = msecs_to_jiffies(timeout);
-			}
+	while ((timeout_setting = strsep(&input, ",")) &&
+	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
+		ret = kstrtol(timeout_setting, 0, &timeout);
+		if (ret)
+			return ret;
 
-			switch (index++) {
-			case 0:
-				adev->gfx_timeout = timeout;
-				break;
-			case 1:
-				adev->compute_timeout = timeout;
-				break;
-			case 2:
-				adev->sdma_timeout = timeout;
-				break;
-			case 3:
-				adev->video_timeout = timeout;
-				break;
-			default:
-				break;
-			}
+		if (timeout == 0) {
+			index++;
+			continue;
+		} else if (timeout < 0) {
+			timeout = MAX_SCHEDULE_TIMEOUT;
+			dev_warn(adev->dev, "lockup timeout disabled");
+			add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
+		} else {
+			timeout = msecs_to_jiffies(timeout);
 		}
-		/*
-		 * There is only one value specified and
-		 * it should apply to all non-compute jobs.
-		 */
-		if (index == 1) {
-			adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
-			if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
-				adev->compute_timeout = adev->gfx_timeout;
+
+		switch (index++) {
+		case 0:
+			adev->gfx_timeout = timeout;
+			break;
+		case 1:
+			adev->compute_timeout = timeout;
+			break;
+		case 2:
+			adev->sdma_timeout = timeout;
+			break;
+		case 3:
+			adev->video_timeout = timeout;
+			break;
+		default:
+			break;
 		}
 	}
 
+	/* When only one value specified apply it to all queues. */
+	if (index == 1)
+		adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
+			adev->video_timeout = timeout;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ece251cbe8c3..fe45dd1d979e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -353,22 +353,17 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
  * DOC: lockup_timeout (string)
  * Set GPU scheduler timeout value in ms.
  *
- * The format can be [Non-Compute] or [GFX,Compute,SDMA,Video]. That is there can be one or
- * multiple values specified. 0 and negative values are invalidated. They will be adjusted
- * to the default timeout.
+ * The format can be [single value] for setting all timeouts at once or
+ * [GFX,Compute,SDMA,Video] to set individual timeouts.
+ * Negative values mean infinity.
  *
- * - With one value specified, the setting will apply to all non-compute jobs.
- * - With multiple values specified, the first one will be for GFX.
- *   The second one is for Compute. The third and fourth ones are
- *   for SDMA and Video.
- *
- * By default(with no lockup_timeout settings), the timeout for all jobs is 10000.
+ * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
  */
 MODULE_PARM_DESC(lockup_timeout,
-		 "GPU lockup timeout in ms (default: 10000 for all jobs. "
-		 "0: keep default value. negative: infinity timeout), format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
-		 "for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
-module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_timeout), 0444);
+		 "GPU lockup timeout in ms (default: 2000 for all queues. "
+		 "0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
+module_param_string(lockup_timeout, amdgpu_lockup_timeout,
+		    sizeof(amdgpu_lockup_timeout), 0444);
 
 /**
  * DOC: dpm (int)
-- 
2.43.0

