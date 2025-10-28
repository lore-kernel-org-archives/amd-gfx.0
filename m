Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D0DCCF9F3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E29310E684;
	Tue, 28 Oct 2025 22:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jU6RProP";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A626410E684
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:57 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b6d5e04e0d3so300097466b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689216; x=1762294016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZKs/gRBXNe8esW/C0uH9UvHsJd9waNO6aXep5TbBevY=;
 b=jU6RProPia/aZy27cYBjKUAUgoHOELN1OmPN8jye22VtVKe0o9ZX+FqtzTD+rkwlmI
 fE3bCzyjEZRRM1SXJUrev7pTkRnl2n8uUGUOISKEqRTHnr3oOW0Dpo+uTx0ULNwY+ZA0
 yNJW5S1rQNQMf+5qUV+mve1kNqNH6FPzn43vDnKcOPJs0KmmgAwyW5bAqWBIyQpf2YtR
 3ZEjxfEcQ8si9Y0ak3gwNy/11HIvK6b+KkYJofqi09DDa41gA6U3AGEJ58ZSCxjVb+He
 CmR5uC4FxKk7ejwb7RfFokVTA3ncLSNc5D0M5m07C83V8OMSmEbjrixUPlKm7tekDpEf
 AhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689216; x=1762294016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKs/gRBXNe8esW/C0uH9UvHsJd9waNO6aXep5TbBevY=;
 b=Rl9nU/+VK0Xu6Mg1t/Xa0NwL0cFIVhYp6dxXjU73fMjLqER4bLm+p7Yw4Ndk0pStJj
 ecWi+MSh1/CYxDm27UObkDzJN9hQ2qPFDwKmosYLzBO0+8DQjEwCAdNPeTU75YW9apJL
 ewAFXGoZRwAQEpZXAPoi2lKGqJoEyKy7QY//XzaUKEPjSA+Cpgp4xfqGbbB4sSw9bPle
 RFKXITZpzIetgaKi5uPKwylawqTJhxzko4LddICCiiTZpHPNpG5bjFqNKTpYDZT0wJUJ
 QZRaX5J0iJzdCHL1JQHGWOdv3QEy9wwoJ4d3TbU3XhdiZk2qPRjxtCuMkkAZoHxqoSgT
 Tc9w==
X-Gm-Message-State: AOJu0YyoaqGA4KDDpWHSW04KAl9VhqQARlU632bztop/HxeyhyRdruoy
 WxAmEvmp/84qwCqkPhPYC7JyuMHS4xpIMawLDHT8qckW35IYhDvebXijMWS7JQ==
X-Gm-Gg: ASbGncuO817itjG6DWc3LrPEZguJdDlN0t717NZmZgDVWvVF1FEXdRJpW9OxwnbioGd
 qt54KescRrUIxd/qsZNxmAqpNpAiV3T5Hv5HO0wvkNuE7VONAC2rAurn2cFM9TUJEvB3hEwoXPY
 rk5A3pZMg5Kjmo0ao2QbP++zR4TeC8YhXa7f3sQUU7kVHFaFj1aMx0tBeqGQLiEFYNmz8g5mk9e
 pijgBK9EFEKw/g1u4ERFXz/IZ3d3pD4Z1Ta17mUYf7dLTVAatPg4SNRLdIL6MT1whpZA0Q4ozVF
 gcoTCZEMCYTQBV+5PAFt7rMy2YeCpUPHLz0ZbH8y4acONgcJRELCzg0JRnjM57p5PVyAj714IBU
 df3r6CsoT2rBLgOIXYsSGkuUpGeMqNnL2C71+beroQb6BccagxYf8+1+FRnbmUDwDIvWYGxXIBk
 LDeWobkuNIDw7bfK/INEt8fsmzk5YJ5i+gA/Kan4XFzD6wwv9pNJ3kXrIoVOzC77UPBk5qFLOyH
 /1u+b/B
X-Google-Smtp-Source: AGHT+IE/gd55FQcAqVDHYkDaBsQpBI3Zkm3umhaBPW5e4ezYEb+gMGsPpRZYJvOhio/zmEWy7OxOtw==
X-Received: by 2002:a17:907:72c9:b0:b54:25dc:a644 with SMTP id
 a640c23a62f3a-b703d5cb645mr50803466b.60.1761689215956; 
 Tue, 28 Oct 2025 15:06:55 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:54 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 12/14] drm/amd/pm/si: Hook up VCE1 to SI DPM
Date: Tue, 28 Oct 2025 23:06:26 +0100
Message-ID: <20251028220628.8371-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

On SI GPUs, the SMC needs to be aware of whether or not the VCE1
is used. The VCE1 is enabled/disabled through the DPM code.

Also print VCE clocks in amdgpu_pm_info.
Users can inspect the current power state using:
cat /sys/kernel/debug/dri/<card>/amdgpu_pm_info

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 3a9522c17fee..bf7ab93b265d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7051,13 +7051,20 @@ static void si_set_vce_clock(struct amdgpu_device *adev,
 	if ((old_rps->evclk != new_rps->evclk) ||
 	    (old_rps->ecclk != new_rps->ecclk)) {
 		/* Turn the clocks on when encoding, off otherwise */
+		dev_dbg(adev->dev, "set VCE clocks: %u, %u\n", new_rps->evclk, new_rps->ecclk);
+
 		if (new_rps->evclk || new_rps->ecclk) {
-			/* Place holder for future VCE1.0 porting to amdgpu
-			vce_v1_0_enable_mgcg(adev, false, false);*/
+			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);
+			amdgpu_device_ip_set_clockgating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_CG_STATE_UNGATE);
+			amdgpu_device_ip_set_powergating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_PG_STATE_UNGATE);
 		} else {
-			/* Place holder for future VCE1.0 porting to amdgpu
-			vce_v1_0_enable_mgcg(adev, true, false);
-			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/
+			amdgpu_device_ip_set_powergating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_PG_STATE_GATE);
+			amdgpu_device_ip_set_clockgating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_CG_STATE_GATE);
+			amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		}
 	}
 }
@@ -7582,6 +7589,7 @@ static void si_dpm_debugfs_print_current_performance_level(void *handle,
 	} else {
 		pl = &ps->performance_levels[current_index];
 		seq_printf(m, "uvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+		seq_printf(m, "vce    evclk: %d ecclk: %d\n", rps->evclk, rps->ecclk);
 		seq_printf(m, "power level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
 			   current_index, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
 	}
-- 
2.51.0

