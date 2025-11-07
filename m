Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F06DCCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EB910EB07;
	Fri,  7 Nov 2025 15:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/7TAj1J";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026F510EB07
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:58:03 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47109187c32so4447145e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531082; x=1763135882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2UWtUqs5AK8npqmJ85sZXOrTODYAbAXlQ+fsq4qtes=;
 b=O/7TAj1Jqhm0a1dgF3Y/9ANNAfsCZbbKuiQsmxun+ZYqvqRoEr09bD8QEKqmfAFyon
 BDejaaJci0fAI6ZEoxiknQOwHFoawSfkSuHMWjsfqAXrRPFW0iy4wxOUKbpT4QTipYAA
 QXQ7GSc4tnaYjLnPb5Mw3N5PQgCMwhpRjemHxPLxfEnre3h82gcNg5/zs58RpvV9A4I7
 tqeVOS7IlEdt3VCKU7G30aDPrfxfcxzA1IrJs4aWeFMw7a73ezJeCQA1+Ao08THpBRbS
 /+I57YrlJj0slY1n5Z6Owq+F7t8NOhr9gxs8svY2jxkuCDHXU1HkJwihV0pZiBpeRkh1
 7CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531082; x=1763135882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B2UWtUqs5AK8npqmJ85sZXOrTODYAbAXlQ+fsq4qtes=;
 b=ptVxLP18Yl6PfKjdK9Lc4zrK6kwQl0t7nf2XdwLVtAjxI0vxpahaLEYbUwmWedtQ0z
 oHQ4VIubLCIVZMWcsErR/CDMZXckqsVp8c9FUqZSdxxS5/Q8XkXnC6KNM0v+VMN2jf7u
 7YUc0TTCM6yQgtmww41uHjcU4RGbFZhgmgfb80SAoCaA2DhWioudinMukgcKmc4xDZDa
 R5MJ+mWHcADpuh6/g41hUuGUaHMtInrRYKNwZIz1VEDMzrh8xRnZquw9MoxYHvIsi7nZ
 hU1Fh0pL3k2H1SlxT/kwaAhyiYBULvABVcQpBm2BO4oSzeZ+ai0qqtAsTYSbeHYgllwi
 ydow==
X-Gm-Message-State: AOJu0YwHOKXkBDxTa29Kvw2vxcTznhZindlSyoFqohHUEZsnoO3IYUWg
 z/KsU6zDYcXuJ0wSUTcVlndcyPIarz9W9DjWodedr11tycWU5pNHQoKINpUCMg==
X-Gm-Gg: ASbGncv5Kktm9jaMSw4INIPTuswfueOnSmQLQyGCD6uOaxKzRaux3q0X1c8hWPGQ18n
 qOtukA3Wn3GQ2/tMQ5KWRgp5xwhUX+iQRX69KZ2agWlW+gDlY1XirYshpxTzOC/tu76FSrULSzd
 1eCoJxYmyVCfK8zOYAFjYLL1UwaLpYUaOtptDT/4m7HGKzhvGH8xTvb/QaTvpmNrHLd/lI05fqB
 nwxHXGyzws1ml12z4H5DNyiJ0DdUyucyAhhfhQ9Du6xWm6EZeZR0lYLk83bJKUk6etI2KqunKEI
 IXL8kh9L8qIrRESpDPBRibidxXPddj6duUlr5dCxAyByhopUCaSkW0G+1QJBzkT+43Tyqkb/Yxb
 PmAppGNXPOTVARO23lh8G4bNi2E2QHUcWmgk/0whhIQuRfpqbA78LFJOeWA3zeowMuH1DZMQrC8
 OG82pPUGY6ht08GLotuhs=
X-Google-Smtp-Source: AGHT+IF1qGsMF8GWnKZaWwmglF4lRX/cB+aSfr23YaVXWEfd0lfxZ0AO+SJHV3Op4OTbtDqsB0+R4Q==
X-Received: by 2002:a05:600c:1e8b:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-4776bcb8977mr32612625e9.21.1762531082426; 
 Fri, 07 Nov 2025 07:58:02 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:58:02 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 10/12] drm/amd/pm/si: Hook up VCE1 to SI DPM
Date: Fri,  7 Nov 2025 16:57:43 +0100
Message-ID: <20251107155745.8334-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 020e05c137e4..1f539cc65f41 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7046,13 +7046,20 @@ static void si_set_vce_clock(struct amdgpu_device *adev,
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
@@ -7574,6 +7581,7 @@ static void si_dpm_debugfs_print_current_performance_level(void *handle,
 	} else {
 		pl = &ps->performance_levels[current_index];
 		seq_printf(m, "uvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+		seq_printf(m, "vce    evclk: %d ecclk: %d\n", rps->evclk, rps->ecclk);
 		seq_printf(m, "power level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
 			   current_index, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
 	}
-- 
2.51.0

