Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DB4C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 22:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B32210E939;
	Wed, 12 Jun 2024 22:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EQx5pIkx";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B0410E938
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 22:28:47 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2c2dee9d9a1so240502a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718231327; x=1718836127;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlLfBbnX9FblBpW76gVStblANR7z9T1g0t5a6w4/nbU=;
 b=EQx5pIkxaXnqtqd014VLlG8nY4grJ4Spq51gJ5tWUY+pSXDgHHZi2V395ArAC07g0J
 f4+qQhfSeY/dR0PjGoKatta5IGTQyoegPeYEboOEjaWSGQs6Kg85Oxe8vM8A8UJV5XxM
 WEFw3zTEuRu115iqA9u4hHu+GBMWko6jKgntk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718231327; x=1718836127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GlLfBbnX9FblBpW76gVStblANR7z9T1g0t5a6w4/nbU=;
 b=ozZ46dO73Mi1Or3gmPDl9n9IS09wqN1C9/rPvZsLXD1O+nowH8sCqv6Uqaty46Kt88
 9qXAq1KgrKvVR+ssSAnpchT1cwi8NVoiDgvLL4pt8xlYF7dBMLlult4izJiY7VVpf2y3
 YZFwPvuypIaSPRNYnwVuyk29oRXuuIAEP12pHzME+ufpj9grgtCBI7IsLuEIzfhCGpEU
 9hwXWmGsRf6DugbyQoWNn59/ejJe7Yuwcf8LoSeTjAotCZKX7pEoxzYOMflyzpX4b799
 KFfq7emz/aPSbZw7n1VfojzUDc86xfkEny0Bmw3Rk+Mt6guePe9Wf3Y4Qw2AE8sCVY+S
 Py0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGBB62Ed/IM9QZupzUAIoJoSgoDDj0kChd5Q1fz3KFU+YopzJnV7YkVvsALIPYjRuZPsKXCE8acu9rUs6eTvO+ZqaxSkUdw+7vGodqyw==
X-Gm-Message-State: AOJu0YxR02xrz4F1VS5XzoFjmdMUdTGHrq4cxstZ8oAJz1w2nmXzOw/K
 0O0Ydyu0BubRiiraI2cQdxozlnqYAC70pLuRz+HscFbzmKFlaAtCPbLjgSeXSw==
X-Google-Smtp-Source: AGHT+IHPZkmR/uiNsfI6yDfoiz6DjupPzvyE09FKeunOtYBdIdMpSm5jxkYUgJB/lptf93zhOTJSfQ==
X-Received: by 2002:a17:90b:4ad2:b0:2c4:ab32:b723 with SMTP id
 98e67ed59e1d1-2c4ab32b8c3mr2926957a91.29.1718231327185; 
 Wed, 12 Jun 2024 15:28:47 -0700 (PDT)
Received: from dianders.sjc.corp.google.com
 ([2620:15c:9d:2:2816:6a42:9074:18cc])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6f336d172sm87788575ad.247.2024.06.12.15.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 15:28:46 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Candice Li <candice.li@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org,
 chenxuebing <chenxb_99091@126.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
Date: Wed, 12 Jun 2024 15:28:04 -0700
Message-ID: <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
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

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

...and further, I'd say that this patch is more of a plea for help
than a patch I think is actually right. I'm _fairly_ certain that
drm/amdgpu needs this call at shutdown time but the logic is a bit
hard for me to follow. I'd appreciate if anyone who actually knows
what this should look like could illuminate me, or perhaps even just
post a patch themselves!

(no changes since v1)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f87d53e183c3..c202a1d5ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1197,6 +1197,7 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
 int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags);
 void amdgpu_device_fini_hw(struct amdgpu_device *adev);
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
 void amdgpu_device_fini_sw(struct amdgpu_device *adev);
 
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 861ccff78af9..a8c4b8412e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4531,6 +4531,16 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
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
index ea14f1c8f430..b34bf9259d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2409,6 +2409,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_device_shutdown_hw(adev);
+
 	if (amdgpu_ras_intr_triggered())
 		return;
 
-- 
2.45.2.505.gda0bf45e8d-goog

