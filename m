Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C41CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE7D10E9B8;
	Thu,  6 Nov 2025 18:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HXvC5H37";
	dkim-atps=neutral
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578D410E9C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:59 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-5db2a0661e0so734690137.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454758; x=1763059558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2UWtUqs5AK8npqmJ85sZXOrTODYAbAXlQ+fsq4qtes=;
 b=HXvC5H37rBUbwe9y4DYgRvISKMIktkzNqH83P/uTDqjeQ3K+C98vLHiW/2+wjNt8uF
 BaTmGx8G6Iaz/9wZFayC2A0bhnn+LZ69tlg+S5cvDSVUKlFMLIlS0JF0QLXi1hheQVT3
 pBxJXReDB3gyiFB6l95Ug30zWNMBCv6/nGyLiw8zP6AArLT0WsCBXRIzGwGkc/XxZwUQ
 xHtj1NEH4ZWRlyive55EoO6MD0+2nAcJI+WZXIGmzTK3/GeK0TG6cCK3pFHDy6MQTRpc
 8Q3QVuJqJUggeWhOyAbDcYNYSGFqG+iVT+NHU9Lq92pBMLhvDenMx3+qrhAWgimtU6EQ
 PviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454758; x=1763059558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B2UWtUqs5AK8npqmJ85sZXOrTODYAbAXlQ+fsq4qtes=;
 b=XuXiurO0UzSZDJLPUJEdYO6Bo2Hhminx6BpoO47oUBQd9sxT64c0D3LPQ9MVpHB6Mz
 5/fGpbvbXecLFiRDHSWEbyI3sYybInUcOcF9ae+MZRAvQ7BOxALrJ1dySXXAztwgqgh8
 ix7gCaV9RJ3Kt0j30aljGhNWpBinoC9hgXU93BCL9HTkZ/U3uhx7FChtgk9TepSNqV4c
 UT8QWLkj9QL167aguqVM5L2HyZK+4WoIK6OLbgQKD1dCgcpnpEWISPx3YUAtYwW+98mS
 S+TQRVGkmSa4RnsuNEad9ct7gRqoKZLOLemcWWdzf+OcCkH7mQqVLzygeN8KLv7Rvp9+
 pX9w==
X-Gm-Message-State: AOJu0YyLUFcpPJhEMjDqhlC6bGr/HgW73Tk7L6pjgxWtALRtkdTeFHo8
 4qqMYjiZMjAnOhV2wH6L7QCirVa/sw+8b6BLr5vuSeSCFHWHw2rxmoFKgLojfhrX
X-Gm-Gg: ASbGncskrKtPzNu1FPK3FmE5BOIkgHVCSX7PaooeQ/YdT0UjHHqk7Xys8PIkJOAycka
 sUQjLd1fIfbrlAASg+5Ve1sGsq/ZSqt+GsdfrF5+EV1qhNUTZ4YnsmiSUU6wgV6jAJBAUcVOgW+
 o0dRgg0SUZ81tLGa07RN4sSY+uBrVD4RrBeTbs+1NozXScVkUAwrRWlHjh/TNyKiHPNwJbNpSz+
 ImfhFJyJ23cvz60L7RoCRbDMhWvlLIO/S+vhpalS//XTkXwJ1BNPE25DCEEGn42W8GB6qwdb+30
 HzBne78zoEgsahkmLCrmFfV7LA+S3HtgDQJ6QKevor38GGoiyFC3DN1Jnvo57AvylND1Ku1BbPC
 DgvLHm3h6Z71Ew7hbclSsz9gsKslhpWxAs7w0jlQ5s+jSy2mzApPjWDJM/y4SGCyxGIKmXNZdAN
 LYgihCe6ESsV01E9r1RYA=
X-Google-Smtp-Source: AGHT+IHkWL2oN4NI++t4ZLt6iJ6uUz5Xu2xV0wBe8kPbtKM1IbX5fCRcGYdS5k9EGp/NmoHNs7m12g==
X-Received: by 2002:a05:6102:a4e:b0:5d6:2bf0:32ed with SMTP id
 ada2fe7eead31-5ddb2294a47mr237105137.34.1762454758386; 
 Thu, 06 Nov 2025 10:45:58 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:58 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 11/13] drm/amd/pm/si: Hook up VCE1 to SI DPM
Date: Thu,  6 Nov 2025 19:44:46 +0100
Message-ID: <20251106184448.8099-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106184448.8099-1-timur.kristof@gmail.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
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

