Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC73D2ECE1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB7010E513;
	Mon, 19 Jan 2026 20:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YNO2cxpE";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F6510E50E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:36:34 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-653780e9eb3so6999764a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768854993; x=1769459793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61x/Oaznmj4/gzxfH061a60VGOnRl8RG0hCVMQIeXec=;
 b=YNO2cxpEPx8U9FyYdnuPhECL1j+OhHbx0LCzW+YwjgGThMmnQxbksYgyGbovJvk90K
 hxRXrvFqjvNm244LfbD3WNNcX/HYNs88qAxCDm8k9HsESmiuH/4dIn9Ghs96Uiszbwqq
 MWh4QalwhRgkmryR9nu3Fqong1XnVua9R9fcE43VK69FjCZF40zUQ+nCi6kY0PDCfgsR
 N+b8jTvXmgMf2fZPtfh6Ztwrr0h3PyvnY8nBZb5J/uuhx43E/z3TdYn0YJS7ctSSjDzY
 gRG3SNjNfOGBzl9bS/prQCTTyEf15nanstmHvEXNrLlQsuiCijzS9Js2f9qx+tPy7OOr
 XhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854993; x=1769459793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=61x/Oaznmj4/gzxfH061a60VGOnRl8RG0hCVMQIeXec=;
 b=JhA0WK3nALWsNN6kFJpgVXPUWHTzaMIEcm8Eq0lFfVxrqW1A1+jn6aLbhuP3swxeOG
 TqQWg/see7S/z0HEtPdC34PD81MEs859EiS6UUDh9aOZICAfdDycWXCpfT4QqcubreRK
 C4F9BYzkCVEUXeJAxEPl9GCAXXK4TE48VdJ1WuVgj0BG3tDXfXD2WK6UPB+PmxIYdTiS
 VtSJHfUuIqFpUWor037P6P0CUDOlzE4/EzDZiWfdD/+Sv/EGUxXl50APf+xWusrdaNGY
 aB12jp7lgucXZGP3FKWa1ZgeWaSoLDnNck9yZ2D0Wabu51Wb6zO/W09Mp2taRVzZ0p5z
 oCzQ==
X-Gm-Message-State: AOJu0Yzg2oRpe7FKMfQ2UmsHtRa7i47+5PedDNaDLUujYNNq/GJbcztX
 f4zvmbv3WZDpiR0ryBpV249ioWCQs9FaUFP4mO6KOBCymLZ70hjPLFFvVdT2cw==
X-Gm-Gg: AZuq6aJA4l6zftAaDtyRoxOuYSivMMpDQByZ+fL6S6IYYGIaq44/H2cSUN8AgIY74OJ
 xVLc10/SA9duGiTPad9XWge21ghqCa00hVcRbw+m1aRH7Ni//phNC1J0s/GNno0Yv8nkjDHLH7C
 RD+cnvC/LOTbcMcCrrhpaZ1HFIsuROIKOT/3u+Nf2NIWvU2uPSqLkoWp/v/mVY4JTfl9hDUssp2
 /s7sYwGy7bwRHBqtJMDmGxYe3PGxdSIyjCpNej2LXcQLrVeAi6Xql0SOpMfB2ckK95dhT3huul2
 YMfRCdwiiU/nh92cm89KUuYIRy76CpHDtOkb30UReimtZ2m3VJkt0zY/n+y9mTCUvuj8Qo4q1xj
 eWF7hb0mfJXgyoryP1ssb+ItAparTrX+sliju/ifoKjS+YyfEkFRn5KMVfOnsjZCCQC8hl4CJzj
 W+GNW0oal0VUuDHyohsdlCnP/IEG9jF+4MjSDM8yDM8QNqpq7NLLnt+nxQQ83hqAaUHmS9P9PeM
 XSD1QuHeqIlAf/dk6D8eLs=
X-Received: by 2002:a05:6402:27cf:b0:650:f4dd:182c with SMTP id
 4fb4d7f45d1cf-65452bd5374mr9245509a12.23.1768854992560; 
 Mon, 19 Jan 2026 12:36:32 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce213sm11375492a12.2.2026.01.19.12.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:36:32 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amd/pm: Don't clear SI SMC table when setting power
 limit
Date: Mon, 19 Jan 2026 21:36:23 +0100
Message-ID: <20260119203626.16070-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203626.16070-1-timur.kristof@gmail.com>
References: <20260119203626.16070-1-timur.kristof@gmail.com>
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

There is no reason to clear the SMC table.
We also don't need to recalculate the power limit then.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index f7c2b1d206b6..87bab6c8564d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -2273,8 +2273,6 @@ static int si_populate_smc_tdp_limits(struct amdgpu_device *adev,
 		if (scaling_factor == 0)
 			return -EINVAL;
 
-		memset(smc_table, 0, sizeof(SISLANDS_SMC_STATETABLE));
-
 		ret = si_calculate_adjusted_tdp_limits(adev,
 						       false, /* ??? */
 						       adev->pm.dpm.tdp_adjustment,
@@ -2328,16 +2326,8 @@ static int si_populate_smc_tdp_limits_2(struct amdgpu_device *adev,
 
 	if (ni_pi->enable_power_containment) {
 		SISLANDS_SMC_STATETABLE *smc_table = &si_pi->smc_statetable;
-		u32 scaling_factor = si_get_smc_power_scaling_factor(adev);
 		int ret;
 
-		memset(smc_table, 0, sizeof(SISLANDS_SMC_STATETABLE));
-
-		smc_table->dpm2Params.NearTDPLimit =
-			cpu_to_be32(si_scale_power_for_smc(adev->pm.dpm.near_tdp_limit_adjusted, scaling_factor) * 1000);
-		smc_table->dpm2Params.SafePowerLimit =
-			cpu_to_be32(si_scale_power_for_smc((adev->pm.dpm.near_tdp_limit_adjusted * SISLANDS_DPM2_TDP_SAFE_LIMIT_PERCENT) / 100, scaling_factor) * 1000);
-
 		ret = amdgpu_si_copy_bytes_to_smc(adev,
 						  (si_pi->state_table_start +
 						   offsetof(SISLANDS_SMC_STATETABLE, dpm2Params) +
-- 
2.52.0

