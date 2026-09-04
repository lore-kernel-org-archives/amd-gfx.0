Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3D6C79FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7262A10E67E;
	Mon,  7 Sep 2026 07:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bzvx7rn6";
	dkim-atps=neutral
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D20610FB0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 12:01:33 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-6b35cc0a8c3so776706eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523292; x=1789128092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62OHtMMqWnXWwh+ZI/Lum+yuS2herj6Kihe5wKXICGE=;
 b=bzvx7rn6bKHxbCdtz5xWNelNDpwtVjELpUHmG07ucjFmMyLLGtvGSUN2cKtyVz+Vu8
 HyK8KiIMZRBcpsPjgcRN4NxFU5xDNYxLL7vvHLhEDpCz+Uyk2b9RenGPrwO9xmpz5l8L
 Xn93mErJgANQ4LzINjxDfCB31udGF3U388uNbLZoqxXihbD+pfc11Oc96+qoCodZfEfl
 kZAMxE5GBpwimP5//Mx4N9CwGhcJXKLlgB9g/5WwPzOKPVS/iO2amV8ljKrF0eeFxxi8
 TPGvAAvFo7G+Hwm1vH1RYtUX+6SFhDTzG68MG9M7uqN3NH/e/bNdj159HaR3aPlpUELJ
 YXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523292; x=1789128092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=62OHtMMqWnXWwh+ZI/Lum+yuS2herj6Kihe5wKXICGE=;
 b=Zl1cueP0mXX1Bv3EGTv7BM1xg+OVwi83yQm2vPbCuR9WPnFKn/AZf/hkNVgShwo7Ac
 0s9n9pu0J/TNvM8JDi2V1eYsFgKIHijDaOAUMhh7MxrzuHCBi1NyVZ1dUOt9NXNbbVAI
 C31SNsTAlDPBnfaXy4M1yBVslyXx32p48H2SKcD2UWwPxoSZVsUHrqn4/GsjqBgWgE3h
 aaxvAIP1OvBnwXr6M7Ud7TGqv416NFxFIKAk70KPnXkUaK+o2rkRWU1ckg93HeGvkxY6
 LvhLKP6ATLf4AzCxvT3V9hcnrrGmCoZinK6HiRvVRF8gpzHjdJhAeXo8FV4LLXhiszw/
 WMeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYRrHT5jAYQrnxIKk1RKIHTz1s5ZjqSkR3EV5xGmQRfrO+dWCb08SiyZwKqfLa/AJ0J6dj0qjl@lists.freedesktop.org
X-Gm-Message-State: AFuF++ln0u6kEMoYAMr5Nwj7M4i0Ri4P8b+1Z4ZXBy03toR2cWCNtG45
 5juzSE/Wdthx+9va5iqYOki8EVil5xe4CiEh6XoE59he5I2JLd5BjC7A
X-Gm-Gg: AYBFou1c8MHUufvgT2bxSELF5PBNV5R60EijOxwciXdG6Tz4UB4g8lwtPpJ0xP0wjwn
 6Y9ekx20HNRy9OJidw+fNOcgEXxyc1A3c1rHPLW6LFyZp2lVRpKAmXkNM8XgY38nN2j+c7RdpBB
 jX6i8Wgs5tK7HyDJtyVF+7BeID8ZnUIz68IVYvpVrv4wbdHjw8VgsOEob6u4cqTw7Wy2FNsfAaw
 5tuhJcsJZsEmFqxhi2JmDMtbmDxc/oyAXtXdxQWYqfdUruXl2kwvKf4XG2jlOOAcaJvePRU01jg
 /W+p3BxGrUdKmttsRoRQZtxv0kutQN84COrkpuYW4Vbb1gCdB3ooG/f+lmFKBMIZvEkgF+TF1kT
 qLLzhZN9Qr2udwNBdYWdv+m/WenWT9Dew+NnXNl1wJ7HuDNnKKPIcncxMcShRuDn4mjpKUYuSFL
 sU162m8KYhG/n335a331gph5Y23c+lhVgvCMATJTOCjCiCjakdOC4/J+L1e3DbBfGdDad76x2iG
 mMz2gqGWbXrk9I=
X-Received: by 2002:a05:6820:1527:b0:6b1:4cb:39ec with SMTP id
 006d021491bc7-6b6fb3df3c0mr3696718eaf.12.1788523292127; 
 Fri, 04 Sep 2026 05:01:32 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm10164241c88.4.2026.09.04.05.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:01:31 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd: fix repeated words in comments
Date: Fri,  4 Sep 2026 17:30:08 +0530
Message-ID: <20260904120044.14303-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120044.14303-1-hemanth.selam@gmail.com>
References: <20260904120044.14303-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:01:06 +0000
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

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 +-
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c  | 2 +-
 .../dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c      | 2 +-
 .../src/dml2_standalone_libraries/alternate_pstate_shared_lib.c | 2 +-
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h | 2 +-
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 802d060a03ac..75bb237dd5e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5702,7 +5702,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 			// vs the latency based number
 
 			// prefetch_bw1: VM + 2*R0 + SW
-			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the the worst-case latency based time to fetch the data)
+			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the worst-case latency based time to fetch the data)
 			// here is to make sure equ bw wont be more agressive than the latency-based requirement.
 			// check vm time >= vm_trips
 			// check r0 time >= r0_trips
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index fea336d3953d..3b2d8bd85494 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -3167,7 +3167,7 @@ bool dcn5_calculate_prefetch_schedule(struct dml2_core_internal_scratch *scratch
 			// vs the latency based number
 
 			// prefetch_bw1: VM + 2*R0 + SW
-			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the the worst-case latency based time to fetch the data)
+			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the worst-case latency based time to fetch the data)
 			// here is to make sure equ bw wont be more agressive than the latency-based requirement.
 			// check vm time >= vm_trips
 			// check r0 time >= r0_trips
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
index 84eac364222f..e1c13bc40ad7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
@@ -133,7 +133,7 @@ static void dscc_bcl_compute_delay(latency_t *p, int bpc, float bpp, int slice_w
 	//this step is necessary as each padded pixel added takes up a clock cycle but is not included in the initialXmitDelay and, therefore, adds to the overall delay
 	ixd_plus_padding = initial_xmit_delay + slice_padded_pixels * lines_to_reach_ixd;
 
-	//convert the the padded initial transmit delay from pixels to groups by rounding up to the nearest group as DSC processes in groups of pixels
+	//convert the padded initial transmit delay from pixels to groups by rounding up to the nearest group as DSC processes in groups of pixels
 	ixd_plus_padding_groups = (ixd_plus_padding + 2) / 3;
 
 	//number of groups required for a slice to reach initial transmit delay is the sum of the padded initial transmit delay plus the ssm group priming delay
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
index 42af0cbf9516..4ed75444d6e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
@@ -580,7 +580,7 @@ static void calculate_start_index_num_swaths(
  * ***********************************************************************************************************
  * calculate_hubp_start_end_lines: Function that calculates svp parameters given a target p-state line
  *
- * This function calculates the the svp parameters (vp0 and vp1 programming) in terms of swath index and number
+ * This function calculates the svp parameters (vp0 and vp1 programming) in terms of swath index and number
  * of swaths given an otg p-state target. This function should be called per plane. There are 5 steps:
  *
  * 1. Calculate svp0_start_dst_line and svp0_end_dst_line.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
index d518dee18e1b..6ba06f2196b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
@@ -487,7 +487,7 @@ typedef struct {
   uint16_t Tvr_socLimit;            // Celcius
   uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
 
-  uint16_t PpmPowerLimit;           // Switch this this power limit when temperature is above PpmTempThreshold
+  uint16_t PpmPowerLimit;           // Switch this power limit when temperature is above PpmTempThreshold
   uint16_t PpmTemperatureThreshold;
 
   // SECTION: Throttler settings
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
index c5c1943fb6a1..0b4aa66d1883 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
@@ -545,7 +545,7 @@ typedef struct {
   uint16_t TplxLimit;               // Celcius
   uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
 
-  uint16_t PpmPowerLimit;           // Switch this this power limit when temperature is above PpmTempThreshold
+  uint16_t PpmPowerLimit;           // Switch this power limit when temperature is above PpmTempThreshold
   uint16_t PpmTemperatureThreshold;
   
   // SECTION: Throttler settings
-- 
2.48.1

