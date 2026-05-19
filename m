Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE834CD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E56E10EB69;
	Tue, 19 May 2026 08:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lTecmVbC";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CC210EB14
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:42:04 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso33515065e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180123; x=1779784923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlUVQSs5BQNLKwijpg9J2OlcuRue5qIacselDF1An5A=;
 b=lTecmVbCol9jV6vdfsnwlVo/x1tE1wT0h5wEXckHqJ8WVhc5iN1aLX6fb510xYjyTd
 6QuNt421dLLUc2AhI+QdUaXZKhtwEePJosrKGbiy2Tkvl3Af2GgDfl061EQHPfzunwGB
 maQpSJWUcdVCLhxXHNnEHtILQR7N2U7l0Vf7knAIy60O58FOE7303UNWp7E7VWH41NVa
 2sMHMqWy3znKzKKENLyUcr5SR4OLRJZhTZ5FDWqyg5JV802FnImGin+O7fHkYglWSOeY
 CT/bjKPtAIR2cXaVEsXyp31LQYCLw1UcYYm/mtNlkNPW7GaSnvaVQSJ0D3koyyu3MI5f
 sPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180123; x=1779784923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlUVQSs5BQNLKwijpg9J2OlcuRue5qIacselDF1An5A=;
 b=M+An8UPKNV0i+cZ2o+JdMbXGI6/yolnSh4n418sifgrtLUqnt5FjP2L2KRdfvTxX6Q
 6qkjxk3/UXx/JLfdEDdbu1HF+tdiZrpyEjBozxJEOIdviozJGF2qLQzwWhA11aEqMwYj
 Y3t0uxq4MP2dU6lmN33pS5jlDsjvh/ff52Z3ffAKqTfm/bYcWnFp4NWA7PXqZv9IwFfb
 PVlseqy6ST20dZExt0x/swwBR/OFYJ3CDWMNlFWuT1Fuou83IphNFhsHK9APaN5inmiH
 WfCdqn+oXF95D1noB+NMqVcR5mQd6DnM48AuRnax0Z68/Caf++Q0xGcbG9ikc6Vv4UE+
 g01Q==
X-Gm-Message-State: AOJu0Yz83NKvBdIp86ONKGpGVa9ZpU3miYxK9uTr+3ICbI8Ptakej4LL
 Rc8SDPdfIkUW9cGDv3AikEWmBk25nE1/3cI7NaWy9wquwtBT/WECuum27j9u1g==
X-Gm-Gg: Acq92OFaZ1obUfTahuRSRa9eSFepd9BFHZwORcn5hWmNmSmg7YjkaGM+KwxTCQFJwHw
 nN8JbAmTWjwqhgiknKV02uDqOymwY4cjS/tkKFAN4gzBLmaeybCZT+5Uar4kjUd3md17LpE7nWu
 95BvGCz3Vmr/2IkqZXQb6ABDnZBZWIMOI36TPff5IuJWAfT8o/9UirxOkBCfSsX8zl5PLhECOUC
 tne5IN3g+/GNaP4HD1uldI9Tqn8CFk0wSnrmXpniet+viatKm22FlO5JONsyeg+szoMaTFPpcdn
 PGLp8HX+Hv/2fRBPZfHseqYjYyiFOaQmeSwv4aS6PgtvyYmwbHs5p11+LmO3/UFX0qxjyn1JJpR
 jhhpRCsm9+W2kHinVM3WLd+CYe5T0G5YW7v6i/4CcqdlMpc+BLMbayh30ymWuHiGxUFvD7eYVOa
 3sLiV6FIFjlI8iZTs0g8YAvWR9Wa/p4BxOdrxpTz98i+tK85euhhiEk2pHqkH5ZRCw
X-Received: by 2002:a05:600c:34c3:b0:48f:d0f7:78f1 with SMTP id
 5b1f17b1804b1-48fe60e4e27mr304928545e9.4.1779180123215; 
 Tue, 19 May 2026 01:42:03 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm141935945e9.0.2026.05.19.01.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:42:02 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amd/pm: Rename enable_bapm() to notify_ac_dc()
Date: Tue, 19 May 2026 10:41:55 +0200
Message-ID: <20260519084158.72960-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519084158.72960-1-timur.kristof@gmail.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
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

No functional changes, just change the name of this
function pointer to be more generic.

BAPM refers to a specific feature on KV, but other kinds of
ASICs may also need the SMU to be notified on AC/DC changes.

Also remove the argument and use adev->pm.ac_power instead.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 8 ++++----
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c     | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 1bbf531de5ed..27e0874d3ade 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -417,7 +417,7 @@ struct amd_pm_funcs {
 	void (*display_configuration_changed)(void *handle);
 	void (*print_power_state)(void *handle, void *ps);
 	bool (*vblank_too_short)(void *handle);
-	void (*enable_bapm)(void *handle, bool enable);
+	void (*notify_ac_dc)(void *handle);
 	int (*check_state_equal)(void *handle,
 				void  *cps,
 				void  *rps,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index feadf604b474..f76ba6753551 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -33,8 +33,8 @@
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
-#define amdgpu_dpm_enable_bapm(adev, e) \
-		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
+#define amdgpu_dpm_notify_ac_dc(adev) \
+		((adev)->powerplay.pp_funcs->notify_ac_dc((adev)->powerplay.pp_handle))
 
 #define amdgpu_dpm_is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
 
@@ -504,8 +504,8 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 			adev->pm.ac_power = false;
 
 		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->enable_bapm)
-			amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
+		    adev->powerplay.pp_funcs->notify_ac_dc)
+			amdgpu_dpm_notify_ac_dc(adev);
 
 		if (is_support_sw_smu(adev))
 			smu_set_ac_dc(adev->powerplay.pp_handle);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 33eb85dd68e9..49b95752de25 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1233,14 +1233,14 @@ static void kv_update_requested_ps(struct amdgpu_device *adev,
 	adev->pm.dpm.requested_ps = &pi->requested_rps;
 }
 
-static void kv_dpm_enable_bapm(void *handle, bool enable)
+static void kv_dpm_enable_bapm(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct kv_power_info *pi = kv_get_pi(adev);
 	int ret;
 
 	if (pi->bapm_enable) {
-		ret = amdgpu_kv_smc_bapm_enable(adev, enable);
+		ret = amdgpu_kv_smc_bapm_enable(adev, adev->pm.ac_power);
 		if (ret)
 			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 	}
@@ -3342,7 +3342,7 @@ static const struct amd_pm_funcs kv_dpm_funcs = {
 	.debugfs_print_current_performance_level = &kv_dpm_debugfs_print_current_performance_level,
 	.force_performance_level = &kv_dpm_force_performance_level,
 	.set_powergating_by_smu = kv_set_powergating_by_smu,
-	.enable_bapm = &kv_dpm_enable_bapm,
+	.notify_ac_dc = &kv_dpm_enable_bapm,
 	.get_vce_clock_state = amdgpu_get_vce_clock_state,
 	.check_state_equal = kv_check_state_equal,
 	.read_sensor = &kv_dpm_read_sensor,
-- 
2.54.0

