Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648F9CCFA18
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB81E10E9B4;
	Thu,  6 Nov 2025 18:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gYmBf7HZ";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCE810E9AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:39 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-55964d4ccc1so354750e0c.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454738; x=1763059538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bi90ttwaP/7NCS5YxMqB6e9hcIxPQ2CCk/silcbmjPs=;
 b=gYmBf7HZ1Bqxa5OkkeVx0D17VlMMU1I+EQLjAE6nZeAF+PIf62RLXxLURViPUAd39C
 7YhYNZIWzI9GeF0LcTN/0mdDfcr8uaQNuw3bi1P+FEYyHJJapvNw+4Qxkr8o2RY4R5k2
 4J5i/TCYoiYNyHqhL9MGosGnSB23D9fMp9SCNknHFqIbydladIhktRnS4nbQp4LMhRXL
 9FpfLqLnYoqK3PczQ11dwwd9lcPMQtPvfmhUnE0QFMkrGW1uQ4qpuPTvFfOIObQRSyEd
 73AEPTyQizNik2NMa/XPbyyIrXOC3rZYiYm0QkWsLl9gm7bS2tSTZJSfZeecWAYxtZVX
 ThaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454738; x=1763059538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bi90ttwaP/7NCS5YxMqB6e9hcIxPQ2CCk/silcbmjPs=;
 b=hvhN/b6kfForhTR0GsfuzeqoqaJ8a5zrlLjmJaaMg/zT7ANGpH9IQvQe0akExyyLgc
 IKxr9yGyDQYOpW9vzenEtM+2neh731FJ3DyrFBFgT+sAcZO/aoKCXl4T8HUVdvDlrHD+
 ROyJCHnnGrdtDlrtdD8YL40rY6Cl/r77LQ3mnas49amhEmr8LwHLhyP+qRd2hrhHNBb2
 37vW4zdl/HiE2ZivrCQhxNY4BnN1du5QYZm2wkVRP4nq3Rt1sLjUtBlbqy+lbdt5B/2N
 tc2hw2EYH8En1gUJDSVMC9NCTjlxk4gN8JndLCh+zCFpzdufI2FWs12PqvLItUUe+qCe
 rkvA==
X-Gm-Message-State: AOJu0Yx6ubH1r1/MJ3y04OBJuCNecwkmcAMGM4yqqhFW68CmB1ItzijP
 VH+m3NQWun57WU2hxadWxD5dlVKT9irEW+q3fQ2V3Bes7KfazezobnUcCyX+QeQy
X-Gm-Gg: ASbGncuGCfBSIPmKiLkK/Ee5300dVq3XOMNP8PG3zLq944XDjO0N9CqKVG8ZBcMGdI7
 WZPUdgWZmESCiA+nXWVeDyFbr8V5lLpvwBTKc5by0Qm2PZAht/fxqXta87Z5XYvL7rx2yvTAKRb
 QFS59p5vrVQQcaLkWxyRzLBvvFt9oMaBK+yHVHJxdiLSzRRGsUQ6zwwCJw5EEEvKtIXYIstnGgN
 QMC64HtskIh2MjhgZ16JT/vlQicwKoFoB1BIc9XTCq/c3BTz07Oi2f6JK+iQ/lu4vmzzZ5y3wWA
 XPoL4GiPnPvDikQCPlRJuvIXs6+CHaKiyNPC1WUGbjmwlBIstziELmu5F4d7AXhFmluQLWeCzjA
 hEv9RQP1jc/fVwA/MyHzDrtx33z+6Frp0uBDfXUUv7wXo7fKnRchKQ9jVataa8Y01x2oIsEn7Zo
 uGU7PrpS8ZthaTdG0qZjc=
X-Google-Smtp-Source: AGHT+IGO8UtA468y0AuSlfuz55Z3/usYlxqcAj04VN5tc3tnJButgW7dCip1LKYpxBeFCkyXD57Zwg==
X-Received: by 2002:a05:6122:3d0b:b0:559:6663:8b1a with SMTP id
 71dfb90a1353d-559a3a3e5cemr263214e0c.4.1762454738192; 
 Thu, 06 Nov 2025 10:45:38 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:37 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 01/13] drm/amdgpu/gmc6: Place gart at low address range
Date: Thu,  6 Nov 2025 19:44:36 +0100
Message-ID: <20251106184448.8099-2-timur.kristof@gmail.com>
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

Instead of using a best-fit algorithm to determine which part
of the VMID 0 address space to use for GART, always use the low
address range.

A subsequent commit will use this to map the VCPU BO in GART
for the VCE1 IP block.

Split this into	a separate patch to make it easier to bisect,
in case	there are any errors in	the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f6ad7911f1e6..499dfd78092d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -213,7 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
-- 
2.51.0

