Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220BCCCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8FE10EAFC;
	Fri,  7 Nov 2025 15:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxoFBJNB";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E7A10E0E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:57:55 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso10153665e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531073; x=1763135873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dqI21d0sI7Z5ggNhkAn/Mxa2R1SzGklmFEmzPtHaaUk=;
 b=kxoFBJNBDQGw4wUsfwbNjTsWK7Vf4s29zRBgXtAfwMNW+SfZCj1LtLwE1hO9kI1JfQ
 nWNGbxzcEjan+nqb00oHZJymFJhoZxebfmcHGEnWBYjnDjISOhY973FrKgsBnrnJB4kQ
 84DuwDxGXxASA8aO+QJQTZQooTS+/fAZbCQnBITrau23ypinPVideoJoXjXW7lKOVcgP
 oCft8pEeDiOL7ZDmLICT61Qb5pjND3CD2Tb7Idewpbi6EpoVce/oXQyna+9KtTjHrsaP
 NjBUjJf2ojRajSAgEXWqMYWz1CSDq3P2zf2CWjnXARL7OLHlg2F9G2sKG4pkSAeVRP8j
 kIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531073; x=1763135873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dqI21d0sI7Z5ggNhkAn/Mxa2R1SzGklmFEmzPtHaaUk=;
 b=HoD/Pxfcio6+273Q3DtTFVTWVI9gIrtAaW5KhdN16DuYkmtqOgzhgBsYvaKnRfk0Ex
 8e7ogkxuNCZSpPhiHCSeJ+ujK89vuu0s7PF4z6LjwCUoAIgJKi8X+P0R8oIhB/jFtLQy
 gi1tl27gw5zrrVjdZIAExPn3e4Ewv35rah9GkYLhleCXtC9d27zFrnyZLE0TwN3okV5m
 X5RihiqgecEx9Ed3/p7kYZIa+/kF3mpEPjrfBnWgyNqVdUVnR5AFoukb8pol+NKEM5SV
 XfsWFRHBCX//21q8uIh+Im42TG4/hsRVsZdlaVVsHg6DB0etDGgHKxQtN4x96bK5Fxkg
 wJNg==
X-Gm-Message-State: AOJu0YxCdZNKoXUoy8GyStDzmD2RLuAU9IcvtJS0MVZH5Up+WEZwVfH8
 FngKfMtNkQ2zaifvILi/cydE6T5K8Nd22zRhgIHAghb03LkfUQa2A/ZxwfJd/w==
X-Gm-Gg: ASbGncuOErt/dLMo0znL2f/XdfqpK+MXFvGVyWjmA8QK7y2c9DmTgzK/qVQOX+CBd/q
 WGmYHoMwCsoKHDznijlRzi26RV1P47N24DO/dK5yKN3FWv3ZKi57Bp6/s7nyYSqv1HfRJL4uFrg
 3iueaKKfEEQ8nF/ikTJBNmMLc20Ycbl5qVa7aBxlxc5snMT010hpAcQVtjQvZ+BXx7AHuVBvZTD
 4Ksh3cMUhrJ5mdcLJCCF/Y7bSvOQe4rFk42brp1kvEFMOYqWiDKX2Zu7Df2QQf8ktFtqwGsX6uk
 StTqOsfkH9oIOJf0HTmn+27AZcx6jBzC30RKDyuN6mZUPyUTZGgM5NdZMDAve/k55v+KCDOS20m
 uhpQteiAGbAm8wvWcNpq/4UIep9tX/ilSrqz1eFf5oyuJpFLSCXluvzrIAnunnQgrROuD1N67Xx
 rUtO0bm0QHQisSUg+FELg=
X-Google-Smtp-Source: AGHT+IHQGFLd742xwVZinhA0eCZ3hAYq3eLwDwksPRVj/A1X5Bo/nuSWT7kWMywwFjDAzykA6ob3zA==
X-Received: by 2002:a05:600c:3596:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-4776bcbbc69mr42202045e9.21.1762531073379; 
 Fri, 07 Nov 2025 07:57:53 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:53 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 00/12] drm/amdgpu: Support VCE1 IP block (v4)
Date: Fri,  7 Nov 2025 16:57:33 +0100
Message-ID: <20251107155745.8334-1-timur.kristof@gmail.com>
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
Co-developed by Alexandre Demers.

This VCE1 implementation is based on:
VCE2 code in amdgpu
VCE1 code in radeon
Research by Alexandre
Suggestions from Christian

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

Changes in v2:
- Refactor the new GART helper to be reusable
- Reduce reserved GART size from 16 MiB to 2 MiB
- Clear VCPU BO only on device creation
- Save VCPU BO on suspend, restore on resume
- Rework how an empty codec list is handled
- Add different workaround for FirePro W9000
- Address all other feedback from the review

Changes in v3:
- Drop patch to return empty codec list when VCE is not present,
  this is actually not needed.
- Instead of relying on gmc_v6 to set the GART space before GTT,
  add a new function amdgpu_vce_required_gart_pages() which is
  called from amdgpu_gtt_mgr_init() directly.

Changes in v4:
- Clear VCPU BO on resume like in v1
- Don't unmap/unreserve BO on resume

Looking forward to reviews and feedback!

Timur Kristóf (12):
  drm/amdgpu/gmc6: Place gart at low address range
  drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
  drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
  drm/amdgpu/vce: Move firmware load to amdgpu_vce_early_init
  drm/amdgpu/vce: Clear VCPU BO, don't unmap/unreserve (v4)
  drm/amdgpu/vce1: Clean up register definitions
  drm/amdgpu/vce1: Load VCE1 firmware
  drm/amdgpu/vce1: Implement VCE1 IP block (v2)
  drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit address space (v3)
  drm/amd/pm/si: Hook up VCE1 to SI DPM
  drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn, Cape Verde GPUs
  drm/amdgpu/vce1: Workaround PLL timeout on FirePro W9000

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  36 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       | 174 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  22 +-
 drivers/gpu/drm/amd/amdgpu/sid.h              |  40 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 839 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h         |  32 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   5 +
 .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |   5 +
 .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  10 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  18 +-
 18 files changed, 1080 insertions(+), 134 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h

-- 
2.51.0

