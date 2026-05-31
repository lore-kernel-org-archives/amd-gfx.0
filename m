Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A994CD6E52
	for <amd-gfx@archiver.kernel.org>; Sun, 31 May 2026 10:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F8F10E616;
	Sun, 31 May 2026 10:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLVpUIqk";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A4310E613
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 10:57:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490a765f47aso3211215e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780225071; x=1780829871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqKtki+BLyfiZJsWxKa0XzxeBr6g0BJYASpoIgEStXk=;
 b=LLVpUIqkXxogOi+HUtrkMVBNALLudiYutXhS1zVLxn2JkICX9O1ZQZ8uwajK/+thNU
 f76h/f4EnGnErU6KoI0Ewt66Drcv1TzNbyZsDZAI6AVYkH2YZ+R3p5W5oxTsvvMTLkaY
 e8zuCEjijKNVSXRLp4WpxcfI1LxQCZzYV2ZBlVRAzsmqoMchyy97zyWlaivbzZOyvZZ3
 iAn7f6RUU0pfJ/RE7WZEPk5Jp4tNQfMumsO+fltO0MHdlpS4o72QhrimiRtaKArELvT5
 fGY5VZeW/b+YsJq2DHUS/gZ6fkrx3EmfriF7A2uQWX75rdaPX+h3kbBManjv7KEUvrxX
 XTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780225071; x=1780829871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SqKtki+BLyfiZJsWxKa0XzxeBr6g0BJYASpoIgEStXk=;
 b=j8bO/mG6dIU+wYjQM0pSK4nk6vNguWWM+X++J01wjNvS9WgYRMEyXzmcEryZsc0F5b
 eSvOUwtp+6E/hn09bniX9CN8yFCpUxV4Pk+AV+Cc0OUI2MrppmTJzsfj6FEO96+y6AK1
 yGNSS599RVBiJRayUXdbQrk0ECoMCAn4m/HcLGY8G0X9mIdl3fiz1p7HSsTEEiAxuW9+
 SHCznaBDSC1hqkfXnjYsQ4Hc58RXhr3tQkz590liFy7cyv91w9vVnH7fEBoTMxYOQ+EM
 piyJvIX3Su9Fd3R4v2KOUBPsUUrPvdeCisBoLa6mcfqP/fyfZdYvlAaCNw6ANpeF1ZvR
 wOfA==
X-Gm-Message-State: AOJu0YwqxfZLhFqj82cX+6JZM7RCXuj2HhicXaapcf9OhnFxRDWPBbmf
 aGJzF0QImV2VMNcG/gIyRXPsN0BX8o9/Rr6z+4J1ngOerFYygvl8c6SVQrGuiVmS
X-Gm-Gg: Acq92OFRF/nrCfpD7C8ZnFvBIUExTjUnH/ZOigewzQ5BTfFI8Tl4tBvCIAxOSZxucII
 CNXjER+Q7bGNRw5KTH0S7s3g81mNn6BHC56Pbwold/4b2LfOan0f7SKGFrW+IGCB+GvNkuvCseY
 4LHkaN9PHjKZ2bztJTnVJ6aui2BBJJB1r5vKACl7JFGPHCXSKmbxfSfry9tRHiN8nT2lwab8hdR
 BKy3w858l4BS72NhHpQ/QQc4Qn5YYKN2t1vOxU8ZyfyEEWQYCOrCqjU7qhPzPKPYL/gSBAMGcZ1
 tKkfkroo/WWs7rNrlvC2/HqcJWfSGkSxxroAluJz+46F0aYpbI6VutdrTKeIttGhdOGPbTQvECY
 Booz53A62gPuYEgvWhekStINT5ZXeGUXk/YoZ+fr3iWg99ChztrwShp3pjiXjceOn3f45+bNxTc
 MBY26u6vFir/c0wejvKc0vFGIAIF3nornM+M1lc5ZsKf5pMiYFwf3SDcu0BNc52Uxz+6WL7nBZs
 i2EBd8jgbs8gb7D
X-Received: by 2002:a05:600c:6287:b0:490:9d1b:f068 with SMTP id
 5b1f17b1804b1-490a295d9c6mr127249895e9.29.1780225070657; 
 Sun, 31 May 2026 03:57:50 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm192904065e9.1.2026.05.31.03.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 03:57:50 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd/display: Always create delayed HPD work queue
Date: Sun, 31 May 2026 12:57:42 +0200
Message-ID: <20260531105744.28717-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531105744.28717-1-timur.kristof@gmail.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
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

Not just when DMUB outbox is supported.
It will be used for normal HPD events too.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 28092ac052ae..255903d000c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2197,6 +2197,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
 		if (!adev->dm.vblank_control_workqueue)
 			drm_err(adev_to_drm(adev), "failed to initialize vblank_workqueue.\n");
+
+		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
+		if (!adev->dm.delayed_hpd_wq) {
+			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
+			goto error;
+		}
 	}
 
 	if (adev->dm.dc->caps.ips_support &&
@@ -2223,12 +2229,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			goto error;
 		}
 
-		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
-		if (!adev->dm.delayed_hpd_wq) {
-			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
-			goto error;
-		}
-
 		amdgpu_dm_outbox_init(adev);
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
 			dmub_aux_setconfig_callback, false)) {
-- 
2.54.0

