Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80C8C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 09:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2CF10E0BD;
	Mon, 24 Mar 2025 09:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXAiWkAn";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97A110E0EF
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 13:12:19 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so432255466b.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742649138; x=1743253938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-language:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glt5ruwpixFsicAS1lOTGEFLbSwOkm6yTHjTjJqBs+g=;
 b=CXAiWkAniNPq66XG34wjblslXUME/Vv5QtWt390f6UhWXH8lrqKojqPXJXt5fhaL9t
 IeW93osQJ936GrLpic2kBJ/Woar6VJF8uN1LDwrkGClcajF6Cm4NZSjU6Mvbe9Gr9Xj7
 Pl2gOeEwOnC+BUtwiIAtfCX63IparzXK9lGaq4o0Mo2yyGfNVm7xHdb1dwYJp4Pwv4f+
 dgAaCcMtRPOZW3XBZ1aoutAwgL73dS33CnvmqNy5YBhs4yG78W9JbjVbPpIvuwSzxggg
 R0TPxGqDQdMSZDkzWSshsNSAYa7RXRuGN7THC2zBC1MzD1Y7Y5iGm/DWxVlul9Yz0J6A
 Rp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742649138; x=1743253938;
 h=content-transfer-encoding:content-language:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=glt5ruwpixFsicAS1lOTGEFLbSwOkm6yTHjTjJqBs+g=;
 b=E/mvmTwmLrudxj/vZB1c2qShnz84b0plCman4msNTHTV5FKDX0IRDzCUPwIIisuiUA
 RhVbrWzxCHnR9od0D1s1B6tvrAQS53atRN/iOXMs9dLQ2LQMTjdO5+aSH/fnrNe7oV+D
 rMtafqyxJFNoS4ZhJhiJiEtgCrpo+rAOtOT7sY3MNWt9WVxAyyBZ3AjJOk65BI9v7d/P
 j7cd/CRmInuAFVmqlxUkmOLc2JU7jAlgEC7zpovApkYtcS+pjoDtaYTWeFeuowh6A+Fz
 lu6Z3q/esZTnNwRv1Q277C8GaJm0Eb8UwBn/ERlMAz1Y6o6XdmYoF8x8oG06i5GAa3pI
 dBWQ==
X-Gm-Message-State: AOJu0Yx0CVotVvhunqdx9TxGWS9ReLrgT8TPH4gx+47ytzjZo71xQ+Eb
 0v4cfJyFrr4wxX2xPAfDB5cIa0H6cdCOtGlwWdeCP/XyTXzNmiZ6c2l9IvgF
X-Gm-Gg: ASbGncuHGPx4x+fT+vMRU3VnlD5JIORxEdyLvn1iXWNPv2jtJyOTBpoaZmtItM694Pu
 h7N7tSA/00bwh+fWZgz3s56EEH1jgII8uAK0ay85T/My+ZXzVR8Ffxp5VyOaFM+NCG09fcq7dwv
 M7IDy9gKi0cVlsdh3myWKDmjR8L8cZ78JUtFRfUH3hD/Z2+WIhaSj9hcAEZZTGvwN5lVvDsem2Y
 Px3vXpHBgvG4my7zQFP/im+zw76tpn7S4iSye3WdZfqNeUTlJg/d3Rj8uDVateyKZESqffPCVcS
 m4QilEhnzErBcJ+2dttDrgJM0hengt4Mnyy2PMsHEEWH4Wbx3vaFogBF0LhG4Gc=
X-Google-Smtp-Source: AGHT+IF5A66nsRoMPIFoHrlosW87FIxEIk6dy9jN+yOR1Ujv6QelsEQ/Q75kpjsXmw7++eBZjKT0Gw==
X-Received: by 2002:a17:906:6a0d:b0:ac1:791c:1532 with SMTP id
 a640c23a62f3a-ac3f28048camr779769566b.51.1742649137593; 
 Sat, 22 Mar 2025 06:12:17 -0700 (PDT)
Received: from [192.168.0.126] ([188.163.14.173])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd569fesm345155366b.173.2025.03.22.06.12.16
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Mar 2025 06:12:17 -0700 (PDT)
Message-ID: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
Date: Sat, 22 Mar 2025 15:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Kovalenko <seryoga.engineering@gmail.com>
Subject: [PATCH] drm/amdgpu: Add GFXOFF auto-tunning algorithm
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Mar 2025 09:06:25 +0000
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

Predict an optimal delay to enable GFXOFF for the next interval
based on the request count:
- less than 15 requests per second - zero delay
- less than 25 requests per second - default delay
- 25 and more requests per second - don't enable GFXOFF

The algorithm allows maintaining low power consumption in idle,
as well as using the full GPU power under load by eliminating
hundreds of extra GFXOFF ON/OFF switches.

Test configuration:
- Ryzen 5 2500U
- Ryzen 5 3400G
- Chromium 134.0.6998.88 Arch Linux
- Mesa 1:24.3.4-1
- KDE Plasma 6.3.2

GFXOFF enable requests per second:
| Test                                                | min | max |
|-----------------------------------------------------|-----|-----|
| System idle                                         |   0 |  64 |
| Web browsing                                        |   0 | 127 |
| WebGL aquarium                                      |  10 | 236 |
| Heavy load: glxgears + vkcube + resizing + flipping |  39 | 677 |

Test results, Ryzen 5 2500U:
| Test                        | patched-6.13.7.arch1 |   6.13.7.arch1-1 |
|-----------------------------|----------------------|------------------|
| System idle (PkgWatt)       |               ~0.74W |          ~1.25W  |
| glxgears (vblank_mode=0)    |     ~7300 fps, ~7.3W | ~7300 fps, ~7.3W |
| WebGL aquarium 15.000 fish  |     56-60 fps, ~9.8W | 55-60 fps, ~9.8W |

Test results, Ryzen 5 3400G:
| Test                        | patched-6.13.7.arch1 |   6.13.7.arch1-1 |
|-----------------------------|----------------------|------------------|
| System idle (PkgWatt)       |                ~3.8W |           ~4.3W  |
| glxgears (vblank_mode=0)    |            ~7200 fps |        ~7200 fps |
| WebGL aquarium 30.000 fish  |          37 fps, 47W |      38 fps, 47W |

Signed-off-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
Tested-by: Liam Fleming <fleming.squared@proton.me>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 94 +++++++++++++++++--------
  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 +
  2 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c1f35ded684e..5e23b956e0bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -781,55 +781,89 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device 
*adev, int xcc_id)
   * 3. other client can cancel their request of disable gfx off feature
   * 4. other client should not send request to enable gfx off feature 
before disable gfx off feature.
   */
-
  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
  {
-	unsigned long delay = GFX_OFF_DELAY_ENABLE;
-
  	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
  		return;

  	mutex_lock(&adev->gfx.gfx_off_mutex);

  	if (enable) {
-		/* If the count is already 0, it means there's an imbalance bug 
somewhere.
-		 * Note that the bug may be in a different caller than the one which 
triggers the
-		 * WARN_ON_ONCE.
-		 */
-		if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count == 0))
+		/* This case covers multiple calls from parallel threads */
+		if (!adev->gfx.gfx_off_req_count)
  			goto unlock;

-		adev->gfx.gfx_off_req_count--;
+		/* Process only if req_count == 0 and GFXOFF is disabled */
+		if (--adev->gfx.gfx_off_req_count || adev->gfx.gfx_off_state)
+			goto unlock;
+
+		/* If going to s2idle, no need to wait */
+		if (adev->in_s0ix) {
+			if (!amdgpu_dpm_set_powergating_by_smu(
+				    adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
+				adev->gfx.gfx_off_state = true;
+
+			/* Reset delay flag */
+			adev->gfx.gfx_off_use_delay = 0;
+			goto unlock;
+		}

-		if (adev->gfx.gfx_off_req_count == 0 &&
-		    !adev->gfx.gfx_off_state) {
-			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix) {
-				if (!amdgpu_dpm_set_powergating_by_smu(adev,
-						AMD_IP_BLOCK_TYPE_GFX, true, 0))
-					adev->gfx.gfx_off_state = true;
+		++adev->gfx.gfx_off_counter;
+
+		uint64_t now = get_jiffies_64();
+		uint64_t delta =
+			jiffies_to_msecs(now - adev->gfx.gfx_off_timestamp);
+
+		if (delta >= 1000u) {
+			/*
+			 * Predict the optimal delay for the next interval
+			 * based on the current number of requests:
+			 * <15 - idle, no delay
+			 * <25 - light/medium load, default delay
+			 * 25 and more - high load, GFXOFF disabled
+			 */
+			if (adev->gfx.gfx_off_counter < 15u) {
+				adev->gfx.gfx_off_use_delay = 0;
+			} else if (adev->gfx.gfx_off_counter < 25u) {
+				adev->gfx.gfx_off_use_delay = 1;
  			} else {
-				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
-					      delay);
+				adev->gfx.gfx_off_use_delay = 2;
  			}
+
+			adev->gfx.gfx_off_counter = 0;
+			adev->gfx.gfx_off_timestamp = now;
  		}
+
+		/* Don't schedule gfxoff under heavy load */
+		if (adev->gfx.gfx_off_use_delay == 2)
+			goto unlock;
+
+		schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+				      adev->gfx.gfx_off_use_delay ?
+					      GFX_OFF_DELAY_ENABLE :
+					      GFX_OFF_NO_DELAY);
  	} else {
-		if (adev->gfx.gfx_off_req_count == 0) {
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
+		/* GFXOFF was enabled when req_count == 0 */
+		if (++adev->gfx.gfx_off_req_count != 1)
+			goto unlock;

-			if (adev->gfx.gfx_off_state &&
-			    !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, 
false, 0)) {
-				adev->gfx.gfx_off_state = false;
+		/* Nothing to do if the work wasn't scheduled */
+		if (adev->gfx.gfx_off_use_delay == 2)
+			goto unlock;

-				if (adev->gfx.funcs->init_spm_golden) {
-					dev_dbg(adev->dev,
-						"GFXOFF is disabled, re-init SPM golden settings\n");
-					amdgpu_gfx_init_spm_golden(adev);
-				}
+		cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
+
+		if (adev->gfx.gfx_off_state &&
+		    !amdgpu_dpm_set_powergating_by_smu(
+			    adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
+			adev->gfx.gfx_off_state = false;
+
+			if (adev->gfx.funcs->init_spm_golden) {
+				dev_dbg(adev->dev,
+					"GFXOFF is disabled, re-init SPM golden settings\n");
+				amdgpu_gfx_init_spm_golden(adev);
  			}
  		}
-
-		adev->gfx.gfx_off_req_count++;
  	}

  unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8b5bd63b5773..38fd445a353b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -430,7 +430,10 @@ struct amdgpu_gfx {
  	/* gfx off */
  	bool                            gfx_off_state;      /* true: enabled, 
false: disabled */
  	struct mutex                    gfx_off_mutex;      /* mutex to 
change gfxoff state */
+	uint64_t			gfx_off_timestamp;  /* gfxoff enable call timestamp */
+	uint32_t			gfx_off_use_delay;  /* flag to choose the delay range */
  	uint32_t                        gfx_off_req_count;  /* default 1, 
enable gfx off: dec 1, disable gfx off: add 1 */
+	uint32_t			gfx_off_counter;    /* count of gfxoff enable calls */
  	struct delayed_work             gfx_off_delay_work; /* async work to 
set gfx block off */
  	uint32_t                        gfx_off_residency;  /* last logged 
residency */
  	uint64_t                        gfx_off_entrycount; /* count of times 
GPU has get into GFXOFF state */
-- 
2.49.0
