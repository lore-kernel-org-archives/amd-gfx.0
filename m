Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D819FCCF9EA
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7292210E67F;
	Tue, 28 Oct 2025 22:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dlLKOuX1";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B7410E67E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:41 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-63c31c20b64so10246013a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689200; x=1762294000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+f6hXgG9QjQJdMlJHqQOYLtTot0NBt8wSVTXmddyiaM=;
 b=dlLKOuX15Hfpf2WKU0zctskJ/9rrX67/oDCDmHJ587TE3P2IgqjwEWfh8rlq3Uccxn
 zH4CNiFRpoSYxLVntmsbZynZBs49pkrWyQ+fqRrmuveEaHrYCA8dgQBjJm/06Vyqy9uu
 RfzxktA3y2AnGY/8f2VQ8+MlGuwldkx9SBqxkkO2ubUULJuBjtZStNgXdN5SFA4Ue1X8
 +fWy8JV9y/ealDxhie16r9piC/QHtwJ6kbugSyLqlIVyIxUqx/En9Sm1CGoJ523rKCcH
 0Auppvngz0/AwqKtxD3jNh+vLmd7fvdaQQ7hx0mPfLf1PylOVKJPJpE13GBVFeYbfxM0
 K9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689200; x=1762294000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+f6hXgG9QjQJdMlJHqQOYLtTot0NBt8wSVTXmddyiaM=;
 b=HG7+DfiafBvkgWZJSl5y0ceC/uAftCywY66TdlaxyqajHBxB6DbWUrn8ETno3yZAhE
 CjMjIuQJgeEH5fa3TE1HTmRIv34a7zxF1UfXxZ/0Q3R5UMc52S9YPJJ7wpDeL3cYg+bL
 oVjxsUeg3tJYKylT0+poAKgusMb2GILuQGLsAkL8hcZHL9paPVkkA/DHv/+nqrurxsAU
 U+UYRCLNgjACaahSnvmiytBRU0vL7Ow5wh6X61smWHy6TqSSRk0XH3Sq3IqUIipWPrJs
 2sRHhfxWYoh5BTygUYekWkQP6LKvqfhIVfizz7IZtNDFhxPZ7MFP5PNJgW92rKpnM/dl
 vT1Q==
X-Gm-Message-State: AOJu0YylQznbN/eKf1NZj7euk3zF7eD4ERSa1BLMAfo8YXrtm4tyLPe5
 tBlCpKth8QN+uKC4wJCGn0rSpGd8ZsykSLdJI1i/eeI/Ch0WNgjVPN80XftNrA==
X-Gm-Gg: ASbGncsJmUSAC0TTbK/oqPAjwWycJTWt9m0IUlXlk2GMt10njlXAiKkjtX9KpDCDP+I
 01xubS3UmPUSk7gZ2Um143NYOlW7t3UnVKh4sPxLWeMeIgusVy8txsK6Er/9fft8AIeM2avXn24
 14IzTvtnb/Zge9OPW21DLAdQpMCQynaDqlH1yckq83E/bk5U4F922XY3PgxUXw0EAQZTWfqO8Oa
 XNYL9IFKEntVvsv/zl/dkofWuvfaSwy+PbL4BjivMPIxQGR7RsDxuuWnHW/z856P1tRwEO1DW+d
 78Q27RmK4zwmngKVelIkOwJct4PYksEdVc3HKLs7hTJv6kE3Aw4H/Bau3BNn0QCLwxr3duqxo1D
 eHDKhccfVEgwjBHTsG9rJdgWgTGcTq7EPXzoEXcE0I2A9i8eTf1nWwDo/dEAxgJPdRUoY890ek/
 vSStb2p5HwHia01pPTYWwdx5TtZMcVitKjgt/fGCyv8vsZnzjZUkm/okRb2GkNfsHosMKuDYuvI
 lqoDwH93UShjQM8Et0=
X-Google-Smtp-Source: AGHT+IGqorDYr5yjW23YCDpqyspKnyfGlicZLzjfHs67gP/c/YeAKx90qxdcqbNzplS8XsKXND135A==
X-Received: by 2002:a05:6402:5113:b0:63c:4537:75c0 with SMTP id
 4fb4d7f45d1cf-64044381a9cmr422924a12.38.1761689200215; 
 Tue, 28 Oct 2025 15:06:40 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 03/14] drm/amdgpu/gmc6: Add GART space for VCPU BO
Date: Tue, 28 Oct 2025 23:06:17 +0100
Message-ID: <20251028220628.8371-4-timur.kristof@gmail.com>
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

Add an extra 16M (4096 pages) to the GART before GTT.
This space is going to be used for the VCE VCPU BO.

Split this into	a separate patch to make it easier to bisect,
in case	there are any errors in	the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 499dfd78092d..bfeb60cfbf62 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -214,6 +214,9 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
+
+	/* Add space for VCE's VCPU BO so that VCE1 can access it. */
+	mc->num_gart_pages_before_gtt += 4096;
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
@@ -338,7 +341,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
 		case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
 		case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
-			adev->gmc.gart_size = 1024ULL << 20;
+			adev->gmc.gart_size = 1040ULL << 20;
 			break;
 		}
 	} else {
-- 
2.51.0

