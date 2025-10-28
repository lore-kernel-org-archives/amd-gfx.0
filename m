Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210FFCCF9F1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1FD10E67A;
	Tue, 28 Oct 2025 22:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ivWCGEcR";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE8610E676
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:38 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-63bf76fc9faso11557801a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689197; x=1762293997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0hPaTwqkfpuLJfxK694Mz3OYQu7ZtmZf78SMZGqLu/4=;
 b=ivWCGEcRVCBOSY2H2/p3cKP9ZgOFS49NaS2DgYjeZ7gNR7gWWEXDamEKmbLQt+91Pz
 a5VEmrvFVGB8WYw8Ul8rRhjKXf2ItStFbsWvgFMVsyjHNKG8xSL2YmxHmqCjQdGjeCAB
 7zrFqncZL2CJ2p5MWpc3ZwJM+7Dhfm8RzujTrORpx8ThjtHVi8eFrsi2r2JWQKiscUNM
 +CmvkdFpsA5de7FgM3wyx5VHR+07pTCfmFXXzfVtlHoQOQhtEcure0bpMFqokOdSrPg4
 YPSho56R2GIuWDyour9W/orkZOlkxZ1mKmIGP8S1YlxIvFOoHBTq2EEZUZh12LmsipoL
 F3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689197; x=1762293997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hPaTwqkfpuLJfxK694Mz3OYQu7ZtmZf78SMZGqLu/4=;
 b=v/qpW2amyENEwMeIPojirlRTun8Th4D4wOJBvcxZOh6B2XJegzD2veCvPFkwjExyKS
 1e+82ecKaxyU6wPALYw6RBfeuxcMTrz6InlVARAqKvAJvnR/8UaKIKRYFdQLtn+vK3aE
 Wmh7/Bqo6v5qU5gPD8Q04irdlMcGbh/KTQQwe/9wXuyDV+m6PhL5+W88FI7y9jDNtGLS
 4it2MMpxYblsuZYZs/d5WJ3Y2teXAw7XIc6IjcvihEVvk6oAzgTXTO+oGN4Ne6l4ZllA
 kfwkFPCxJsgy+g7E8rPwTYyCN4M9qGdzNJfLhsz8gxervqRRqUioyAoOsb48x6rp4rRz
 69oA==
X-Gm-Message-State: AOJu0Yy6I9rtC/qKgLsDLYUHZQOSvjjiC9TKkNgenuxQtkmlW7NnSns0
 sxB6y+s/uQUKNrYNrf0/NwQeHI0KjC6WmZxejwxttyGq9IIcsPD9X1+jMiUfCA==
X-Gm-Gg: ASbGncspM7tMC/Ur/doCyjX6gD0Q93McyYqxhwj7knHUFdcMKg0MVM/WeyOwOZThIpL
 gHYv90ZXohq9+VeHQ7XLnGbOLNtxiYDOAFLaXbz4e7bSqEB4+339prmenMQPec20dlqBNhHyIXC
 +3/3VZasfOw/WZAADSuyW8mzfkWQ8BBYV6miIUp7qEgUj83sYToAeJgL3zosBq6HOotaAa4rWij
 tMJW/vNRYLOe7sjiV0YEAby58KQsFkaD9XD492aGi0RKB1mExw7mJwQi4xZbAtbZKZiVhRNVYRX
 MLjtvYiR82RXE5T66BOz3rm0Wnxp4bg9tQinRmtaVWVsROIdIKEz/vFmsaPk8hiLYlszed1BcUF
 R7E/krRqab9mpDI/gjmmG5/eODesH6D623SaVjpEaXRzsH0pwv+WV8zvNvO76/GxLGF3Uzz4EbW
 /3hTqunj6sL9NrDAZee1NWew5nx6GwqtPFdLEwLuk9FpnBiYO3N5OSl3a4Ouq94blC0YVXGTtxa
 mBj8QWK
X-Google-Smtp-Source: AGHT+IEry1GJ6m/7gSvkR02fHqw1Pcb8G43qmj1pbSCZn8tobtbM3zfL2ioyHq3+2/pj1mYalDnfww==
X-Received: by 2002:a05:6402:50cc:b0:63b:ee76:3f7a with SMTP id
 4fb4d7f45d1cf-640443b66b0mr526717a12.26.1761689196637; 
 Tue, 28 Oct 2025 15:06:36 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 00/14] drm/amdgpu: Support VCE1 IP block
Date: Tue, 28 Oct 2025 23:06:14 +0100
Message-ID: <20251028220628.8371-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

VCE1 is the Video Coding Engine 1.0 found in SI GPUs.
Add support for the VCE1 IP block, which is the last
missing piece for fully-featured SI support in amdgpu.
Co-developed by Alexandre Demers and Christian König.

This VCE1 implementation is based on:
VCE2 code in amdgpu
VCE1 code in radeon
Research by Alexandre and Christian

The biggest challenge was getting the firmware
validation mechanism to work correctly. Due to
some limitations in the HW, the VCE1 requires
the VCPU BO to be located at a low 32-bit address.
This was achieved by placing the GART in the
LOW address space and manually mapping the
VCPU BO in the GART page table.

Also hook up the VCE1 to the DPM.

Tested on the following HW:
Radeon R9 280X (Tahiti)
Radeon HD 7990 (Tahiti)
FirePro W9000 (Tahiti)
Radeon R7 450 (Cape Verde)

Looking forward to reviews and feedback!

Timur Kristóf (14):
  drm/amdgpu/gmc: Don't hardcode GART page count before GTT
  drm/amdgpu/gmc6: Place gart at low address range
  drm/amdgpu/gmc6: Add GART space for VCPU BO
  drm/amdgpu/gart: Add helper to bind VRAM BO
  drm/amdgpu/vce: Clear VCPU BO before copying firmware to it
  drm/amdgpu/vce: Move firmware load to amdgpu_vce_early_init
  drm/amdgpu/si,cik,vi: Verify IP block when querying video codecs
  drm/amdgpu/vce1: Clean up register definitions
  drm/amdgpu/vce1: Load VCE1 firmware
  drm/amdgpu/vce1: Implement VCE1 IP block
  drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit address space
  drm/amd/pm/si: Hook up VCE1 to SI DPM
  drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn, Cape Verde GPUs
  drm/amdgpu/vce1: Tolerate VCE PLL timeout better

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  41 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       | 134 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h       |   2 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   7 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  26 +-
 drivers/gpu/drm/amd/amdgpu/sid.h              |  40 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 857 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h         |  32 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |   6 +
 .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |   5 +
 .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  10 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  18 +-
 22 files changed, 1099 insertions(+), 112 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h

-- 
2.51.0

