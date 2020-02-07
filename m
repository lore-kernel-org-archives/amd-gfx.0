Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93D5C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DA0246C3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOlk7i1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DA0246C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264DC6FCFA;
	Fri,  7 Feb 2020 15:19:20 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A2C6FCFA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:19:19 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id c24so2094753qtp.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2020 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DyaLnXuFxzL3lwuTWwLe27ntg3P4xVXRvfmNuFvcxWY=;
 b=UOlk7i1BjcfMP1hfdJ9OmaGT5+AZ2ejiCH83JugeHJhihA5PGvciJyP3wTYXkHFtn/
 8tFmqYCVBJY/h26W2Nmn6YoW3TZqnY0rs7X5NURRBxfiWt8TEdCvmtpV0QMJgEZuHefz
 qhFX+Q9a6VmD2cAsALicGHXMu1RNqwVkmTadwuVMbMnI5LpnHeFAECxxORhk3iVKpuxJ
 JzHgSNL1M3LlnLZgIL/8yL8DE2Avxn/VUvlQYjPJjqxOFa9D9W4nBGcItGsKZzk/S00N
 8mWFloA4MCYpzCDciBMHNDbE7HFc25xP+m9LRJgb9zzU4V/p9ZMN9likeMlzbXEgWrs3
 KR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DyaLnXuFxzL3lwuTWwLe27ntg3P4xVXRvfmNuFvcxWY=;
 b=TlxKTiyOeTtsVCAx5tRnLxjwGiEttwfeQfHLWIrdNRth/hNTwp7WCxK2MY8rka7p6s
 QVIz0kWbDr0amDlFztZPSvCqQKeaCbNU1XaFh6lqODJKfJ4YFDPzgb8nL2T9Vs+g85QO
 dPBFOF1wg+PDmH3zOBNMX3An8k9XtOS9eZSnhvWWDRZzc/xBW5NeqccWMMoCcjNOQhMX
 6pwxdViVBAIwjs4NGzOq7p0UzT8GLq4FPbkEHCQpfZWrpuJMkxeqI3vcDxUs4poKrJYU
 EJDgGV4R3jD5DQRG+J0kZi/gLxypvSLHsRziNAlIpJMc8nHu6JGD/YKDGHRXe6JKF7qt
 t+Pw==
X-Gm-Message-State: APjAAAWdyUQ/jijJxVMzOkjCcrtgVUzXwh5vQbwcwS3W5yj81oHxv5kb
 u0c0H6TTocTMzgcmzzxh57aGt/8h
X-Google-Smtp-Source: APXvYqzTavbvSka4z+phG7gI3Hj39pcv/BwLPhic8OfDZDJQTtifA628CfAW/2bVgl8cgZ5/p51i6w==
X-Received: by 2002:ac8:3fd5:: with SMTP id v21mr7725836qtk.345.1581088758403; 
 Fri, 07 Feb 2020 07:19:18 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id t29sm1445619qkt.36.2020.02.07.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:19:17 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add flag for runtime suspend
Date: Fri,  7 Feb 2020 10:18:40 -0500
Message-Id: <20200207151842.802638-1-alexander.deucher@amd.com>
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

So we know whether we in are in runtime suspend or
system suspend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b4b00e5c82c1..7bc703387f26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -976,6 +976,7 @@ struct amdgpu_device {
 	int				pstate;
 	/* enable runtime pm on the device */
 	bool                            runpm;
+	bool                            in_runpm;
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f28d040de3ce..1a8659efad53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1230,6 +1230,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		}
 	}
 
+	adev->in_runpm = true;
 	if (amdgpu_device_supports_boco(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 	drm_kms_helper_poll_disable(drm_dev);
@@ -1288,6 +1289,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	drm_kms_helper_poll_enable(drm_dev);
 	if (amdgpu_device_supports_boco(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
+	adev->in_runpm = false;
 	return 0;
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
