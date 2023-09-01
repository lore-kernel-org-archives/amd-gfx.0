Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FB8CA0FF8
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Sep 2023 23:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F2110E829;
	Fri,  1 Sep 2023 23:42:46 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766E810E829
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Sep 2023 23:42:45 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68bed8de5b9so2141286b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Sep 2023 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693611765; x=1694216565;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1wNSnWkGtYsqmdJ7SiIP0G54S9pY24k7p5P1n8MG+s=;
 b=KKzdHHoFNINtk2MLAp4UQnTC94LILh1zsoYG4JYt9qfkj3k4yym/rT0GRm35cY3klU
 rPZRCmSN/vZ/JaEdk+shVXC7tp8TfKM1lriLFvvAl2MXI0wUbEB5hHrrhVvGFlL0FhPV
 0idB9yJv9kQ/X/F42r0zDyVdJm8R21LveEdZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693611765; x=1694216565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1wNSnWkGtYsqmdJ7SiIP0G54S9pY24k7p5P1n8MG+s=;
 b=WumdVyFWV/7Tkfzw0HSttuQ/aBAK4OANcQTCl+rN2rL0PAqG8HYbP5wWkpzeMDM/2d
 zr2fqJ55nbf/rdywjqIJ8tRWhw1ay78uxr1j+TJJ3Q+oDa5cdOsoLua7c/R8YyB3GmXR
 pP+BmlvQZTwqDcP+/O0QadgiTHlTcOiCir3XbEhfWoyjF4ewGGgcZptdjQAGfjzKVM2q
 QpFLzRGbhk+NCV70/GZiViAuCFzZMeVf5+AZZ2+gQYaSmWkoeZ6Cd4bswMXcGkUZXfYk
 ygimPu+84cHMcCPdOSloufiV3lQxMV2o4qI/O/qNjmHKA3T0xZLnHpQfIotN70l54Xnf
 KFSA==
X-Gm-Message-State: AOJu0YyxNBDrVoJI6hsJekv1/AyJW9HPW28Z3KGaJNrK8Umco5oE6iH2
 YKezSUkpkX/jRTsfGbfEnF52dQ==
X-Google-Smtp-Source: AGHT+IEkl683gWaaIdVyv+hHmYbbrgZJNsGzwDeq5vblOp769UBG3JrWsk8J+Ps9xjU1Cfx4ftFMxQ==
X-Received: by 2002:a05:6a00:2484:b0:68b:e7d4:2564 with SMTP id
 c4-20020a056a00248400b0068be7d42564mr4944901pfv.24.1693611765024; 
 Fri, 01 Sep 2023 16:42:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 16:42:44 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Subject: [RFT PATCH 09/15] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
Date: Fri,  1 Sep 2023 16:41:20 -0700
Message-ID: <20230901164111.RFT.9.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234202.566951-1-dianders@chromium.org>
References: <20230901234202.566951-1-dianders@chromium.org>
MIME-Version: 1.0
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
Cc: Victor.Zhao@amd.com, srinivasan.shanmugam@amd.com, tzimmermann@suse.de,
 Bokun.Zhang@amd.com, Xinhui.Pan@amd.com, maarten.lankhorst@linux.intel.com,
 Douglas Anderson <dianders@chromium.org>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lijo.lazar@amd.com, le.ma@amd.com,
 mdaenzer@redhat.com, YiPeng.Chai@amd.com, mario.limonciello@amd.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, shiwu.zhang@amd.com,
 James.Zhu@amd.com, airlied@gmail.com, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

...and further, I'd say that this patch is more of a plea for help
than a patch I think is actually right. I'm _fairly_ certain that
drm/amdgpu needs this call at shutdown time but the logic is a bit
hard for me to follow. I'd appreciate if anyone who actually knows
what this should look like could illuminate me, or perhaps even just
post a patch themselves!

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8f2255b3a38a..cfcff0b37466 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1104,6 +1104,7 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
 int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags);
 void amdgpu_device_fini_hw(struct amdgpu_device *adev);
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
 void amdgpu_device_fini_sw(struct amdgpu_device *adev);
 
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2cdde0ca0a7..fa5925c2092d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4247,6 +4247,16 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 }
 
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev)
+{
+	if (adev->mode_info.mode_config_initialized) {
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
+			drm_helper_force_disable_all(adev_to_drm(adev));
+		else
+			drm_atomic_helper_shutdown(adev_to_drm(adev));
+	}
+}
+
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int idx;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e90f730eb715..3a7cbff111d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2333,6 +2333,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_device_shutdown_hw(adev);
+
 	if (amdgpu_ras_intr_triggered())
 		return;
 
-- 
2.42.0.283.g2d96d420d3-goog

