Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D12DC02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6B710E212;
	Wed,  5 Feb 2025 22:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lxR0TjLg";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49DDD10E16E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 19:12:52 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-518c46cc6e4so23172e0c.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2025 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738782771; x=1739387571; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kWccelVeRsy1o95KeizPK/HACe1yDtoX8uEvuDrhy6A=;
 b=lxR0TjLgJO5AAT+2ArfkdHeg/PtohOrxBOZVIMGO+64c/VEHfVF/7bMtyNiS+uIKT1
 VmUW1YYldm3Za2NHtQH8HVmHbXbgk5PXL16uUlkv+gjSjpi0hUBkY39mM9ZZPiqAzmvF
 Cc0B1dr9ScL7J1CVe+CXJoQfe1SWJwfmA+mAKrA1+jhCxfLPyR9KgM6oDjg+dwXFt3+P
 0Dpo0j1aVQRvTFCo3GPXi+2Ie3k80kT5ZIy76miWe2GdesDSbhrp7qJmYK0bGDsfyg5Y
 qIhUWQDEuRmG0V3gr2fJvS2zmpcIbALx6mFBcy5OhelFkSTc95HTiMjwHX1avgl9lp/p
 niYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738782771; x=1739387571;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWccelVeRsy1o95KeizPK/HACe1yDtoX8uEvuDrhy6A=;
 b=sgufZAarSZ1ZOBw4qyTOQfdigR6YdRZm3KwZYmUhBKL8XkknBXnEH6R2b59kZvBdvi
 zC9zEvQN6aF9hpGWbxk4d5tOVUorATJNeKcoP1ulWGMTOKXms4LABUZpM+iCIHMIuG9S
 KWCdtB8l/gpQrrZ1oHsoCagsUe17ASbj3fe8fhbmm55fYVHF3j2roPZm6b/pEAeMfPU4
 h03doN5/SFHlS9QvHOZqALXv8QA4NauKqQiS89z7YS4iJMC9xeBLzLycBwpFd1r8TK8b
 DyUpuoMaLPdWusxLLcTjrisua7L9XEZyEuLuJ51bqauGr4ZbcF6EwvJRsZN2uVEZVXhg
 41MA==
X-Gm-Message-State: AOJu0YwVByPhtJWLrfg7GXp1SK2uvTzVVEHi5PS3DfxiZWPedgpdaIqe
 2gXqcaIy4o8aYbEiYKYOI+GdfIgdkRHeNam1JZUPML7uX0oTaGm0iTpqU50hDzGCx3NGH6o5Shd
 wsumcjNwi+CtwltZsRI+tlakUlEyp7Lgj
X-Gm-Gg: ASbGncvU5nHmI2+5+m/+qhf1MmdrcGBnHnYZdI2sokcQ4l8B/eEFYL+qQERzkScKgtZ
 5jYbQJIYxm1m9XOv/XB0itmMiIuHMc5yi/t8mPoBFdoy0CcSlNnkTHlIl/r05Hgg+av1vag8=
X-Google-Smtp-Source: AGHT+IGzFTnRgVfdgXq9CbnEovXw/pbq8TLB1IenQekUZIH52T8R563BeVTfCrEu08o2em1QRwXpHLdgoU/zN4sp6wY=
X-Received: by 2002:a05:6122:da6:b0:516:2209:9032 with SMTP id
 71dfb90a1353d-51f0c35f6c8mr2889219e0c.2.1738782770889; Wed, 05 Feb 2025
 11:12:50 -0800 (PST)
MIME-Version: 1.0
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Wed, 5 Feb 2025 14:12:40 -0500
X-Gm-Features: AWEUYZmZ_bOiflqdoiQUnR8KclPofxy7Zq-jSSK4uzD9zV8UyHz_xs8FTquK4-Y
Message-ID: <CAPEhTTFyW6Y7uGkh5zc4=N4qKaO_XM9Rfrjk767dLFp0u5_8vQ@mail.gmail.com>
Subject: [AMDGPU/PM/legacy] PATCH SI/CIK: suspend / resume gpu hang [issue
 2524]
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:38:15 +0000
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

A patch has been laying dormant for more than a year that would fix
suspend/resume GPU hangs happening on SI/CIK's pm suspend/resume
cycles. See: https://gitlab.freedesktop.org/drm/amd/-/issues/2524

I'm not the original proposer of the patch, however this person hasn't
been answering after a few months since Alex Deutcher had suggested he
send the patch to amd-gfx mailing list for review.

This patch handles the mutex locks/unlocks needed to prevent the
suspend/resume hangs. It mimics what was included in

commit 3712e7a494596b26861f4dc9b81676d1d0272eaf
Author: Evan Quan <evan.quan@amd.com>
Date:   Tue Nov 16 14:30:20 2021 +0800

    drm/amd/pm: unified lock protections in amdgpu_dpm.c

While you could add my "Reviewed-by", I've not tested it and it may be
possible to narrow the locks/unlocks around less calls.

I'm willing to test it on Pitcairn and Tahiti for any regression I
could find if requested.

Alexandre Demers

----

From e62461803e84c181d6d237e27a215b788d72fa41 Mon Sep 17 00:00:00 2001
From: "chr[]" <chris@socke>
Date: Sun, 23 Apr 2023 06:13:47 +0200
Subject: [PATCH] amdgpu: fix suspend/resume issues

resume and irq handler happily races in set_power_state()

* amdgpu_legacy_dpm_compute_clocks() needs lock
* protect irq work handler
* fix dpm_enabled usage
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 19 ++++++++++++++----
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  2 ++
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 20 +++++++++++++++----
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index f5e08b60f66e..e260224b6152 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3056,6 +3056,7 @@ static int kv_dpm_hw_init(void *handle)
    if (!amdgpu_dpm)
        return 0;

+   mutex_lock(&adev->pm.mutex);
    kv_dpm_setup_asic(adev);
    ret = kv_dpm_enable(adev);
    if (ret)
@@ -3063,6 +3064,8 @@ static int kv_dpm_hw_init(void *handle)
    else
        adev->pm.dpm_enabled = true;
    amdgpu_legacy_dpm_compute_clocks(adev);
+   mutex_unlock(&adev->pm.mutex);
+
    return ret;
 }

@@ -3081,10 +3084,13 @@ static int kv_dpm_suspend(void *handle)
    struct amdgpu_device *adev = (struct amdgpu_device *)handle;

    if (adev->pm.dpm_enabled) {
+       mutex_lock(&adev->pm.mutex);
+       adev->pm.dpm_enabled = false;
        /* disable dpm */
        kv_dpm_disable(adev);
        /* reset the power state */
        adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps =
adev->pm.dpm.boot_ps;
+       mutex_unlock(&adev->pm.mutex);
    }
    return 0;
 }
@@ -3094,18 +3100,23 @@ static int kv_dpm_resume(void *handle)
    int ret;
    struct amdgpu_device *adev = (struct amdgpu_device *)handle;

-   if (adev->pm.dpm_enabled) {
+   if (!amdgpu_dpm)
+       return 0;
+
+   if (!adev->pm.dpm_enabled) {
+       mutex_lock(&adev->pm.mutex);
        /* asic init will reset to the boot state */
        kv_dpm_setup_asic(adev);
        ret = kv_dpm_enable(adev);
        if (ret)
            adev->pm.dpm_enabled = false;
-       else
+       else {
            adev->pm.dpm_enabled = true;
-       if (adev->pm.dpm_enabled)
            amdgpu_legacy_dpm_compute_clocks(adev);
+       }
+       mutex_unlock(&adev->pm.mutex);
    }
-   return 0;
+   return ret;
 }

 static bool kv_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index d3fe149d8476..665c218d9003 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1047,6 +1047,7 @@ void amdgpu_dpm_thermal_work_handler(struct
work_struct *work)
    if (!adev->pm.dpm_enabled)
        return;

+   mutex_lock(&adev->pm.mutex);
    if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
                   AMDGPU_PP_SENSOR_GPU_TEMP,
                   (void *)&temp,
@@ -1068,4 +1069,5 @@ void amdgpu_dpm_thermal_work_handler(struct
work_struct *work)
    adev->pm.dpm.state = dpm_state;

    amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+   mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 49c398ec0aaf..15084872975b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7797,6 +7797,7 @@ static int si_dpm_hw_init(void *handle)
    if (!amdgpu_dpm)
        return 0;

+   mutex_lock(&adev->pm.mutex);
    si_dpm_setup_asic(adev);
    ret = si_dpm_enable(adev);
    if (ret)
@@ -7804,6 +7805,7 @@ static int si_dpm_hw_init(void *handle)
    else
        adev->pm.dpm_enabled = true;
    amdgpu_legacy_dpm_compute_clocks(adev);
+   mutex_unlock(&adev->pm.mutex);
    return ret;
 }

@@ -7822,11 +7824,15 @@ static int si_dpm_suspend(void *handle)
    struct amdgpu_device *adev = (struct amdgpu_device *)handle;

    if (adev->pm.dpm_enabled) {
+       mutex_lock(&adev->pm.mutex);
+       adev->pm.dpm_enabled = false;
        /* disable dpm */
        si_dpm_disable(adev);
        /* reset the power state */
        adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps =
adev->pm.dpm.boot_ps;
+       mutex_unlock(&adev->pm.mutex);
    }
+
    return 0;
 }

@@ -7835,18 +7841,24 @@ static int si_dpm_resume(void *handle)
    int ret;
    struct amdgpu_device *adev = (struct amdgpu_device *)handle;

-   if (adev->pm.dpm_enabled) {
+   if (!amdgpu_dpm)
+       return 0;
+
+   if (!adev->pm.dpm_enabled) {
        /* asic init will reset to the boot state */
+       mutex_lock(&adev->pm.mutex);
        si_dpm_setup_asic(adev);
        ret = si_dpm_enable(adev);
        if (ret)
            adev->pm.dpm_enabled = false;
-       else
+       else {
            adev->pm.dpm_enabled = true;
-       if (adev->pm.dpm_enabled)
            amdgpu_legacy_dpm_compute_clocks(adev);
+       }
+       mutex_unlock(&adev->pm.mutex);
    }
-   return 0;
+
+   return ret;
 }

 static bool si_dpm_is_idle(void *handle)
-- 
2.30.2
