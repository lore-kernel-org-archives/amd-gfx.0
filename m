Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6D2CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE4910E9AC;
	Thu,  6 Nov 2025 18:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XwX6jTZ1";
	dkim-atps=neutral
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C756C10E9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:37 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-5dbd1421182so1174251137.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454736; x=1763059536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2beDIIArXDhPIawFYSZ44ep+zX0RKVDq6x/4FAZ1pIk=;
 b=XwX6jTZ1aXsCQcK6g8FkUI+LwN7TJPUYiVcPSDPM2f8d4MKv5kgvvQjsIIEehVIx8M
 7zAatbkj+cHClda1M4kCAiKw0mEmq0AL4HX8QbD51R3n/PlcrvUiYoUVsWGyZQSIXzVd
 pvuIJgknoGGOYxbwDCYGZNb2WkDX3cNB8jDIi0koZzRQa8gCNYZGd3Z9rr/EtQaQmUtc
 vBHJx3mreY6YQmpupx/Aga/EZx73O1O++wQa3AuRAm9gEfDr/N3TG4epVG5IhZhIjiJT
 0vKfFEqbPW+ViYjWD+mUFIW1tYSsUtEEsf1nfVEpDegE2fW/LznoxvYN36JL6w79QK4h
 v/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454736; x=1763059536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2beDIIArXDhPIawFYSZ44ep+zX0RKVDq6x/4FAZ1pIk=;
 b=sQWW04tW1AhEpnR/aRiujvVi4a1i0toynlQQ9Aa8AXudBK2sevNfWyOgkuDj/QqIRl
 7cAcoWSyKZyFOTnegBw/k6Twshja+SQhsxadjkXkVC0YdTZio0Ei1eO7Co0Rq27jgwjx
 MO/BQe/VhQZv4tetW5YzE8XM78ao6qHhC95+N1HJ1f/buZ8eIs3AUg4g1lstvXYBUBb4
 jBKxYZuxkgFEUBib/xai9HIfT9GVVmJmjRkYOeckobW83TbOiLDBRkTNBw7QZOjEiEuf
 eMR3cJ0iKoCY7bIdTHyMwI+gNDkvauA/vEoY8FN6+fQ9fA+9yNKsjuHpDJJyFDSkyfXC
 6j5Q==
X-Gm-Message-State: AOJu0YzRWkAP1neeJbIqkpGnZhXq2KYvm4F9loZzvfOWR4raa0ScJ7qi
 n34p8zQBnH28eAWgo7vdgDHCF8L7KfxV6CZuZRoL4At94yjx5j7s1pLAbtBkFfwK
X-Gm-Gg: ASbGncuLU5fnWiJY8AjJjTS2bXB6PVVmHMP1M9+YzUxXqwXBcU4vLOdcx5ooetOSdmy
 BgzYMHjrOP9i3Smlj4QiGX08CzGPa1VwkNdXoMcXxbZLwVD+ZXCVs/SOagqetYOCLWvAyHxPJv/
 vOG8T0GY7rXoUSEwW6Xxq1rf+yOWUmk16dWRISaGSyuMuSHQUhbhUib1vfLDyLpua7GSLHRKS+V
 ODbFRjgl0PsxLEGX3MDwuzDjyYERXapAFSPBSlReCJYC8A2/FocGdN7JzyosyjUY6G3lCv3+tiy
 ClyTSUzRSB0yz+RET2N86sTmXOJ+tsiehh4fJLV79501XPxpGOcKBGGFmjedw0PU9HpLe0+MX1G
 FsEm2UNqWEGfQVzdNkEHy4SNxJl21bm4KooeaudkiPV/c1Z+mMIXaG3Ti+d8YP3A7YaeooWHrmH
 LwX06QIi6vYY97WuI++1sr1goGxwp6jQ==
X-Google-Smtp-Source: AGHT+IGB7Dim8qFNyOg58WE4aRS4byfoWaYP36kt0njcXIqVyGPzhYZ+pgO4L+dtZ/ZHxfNPJ2wIJw==
X-Received: by 2002:a05:6102:512a:b0:5db:3826:7be8 with SMTP id
 ada2fe7eead31-5ddb2256303mr234691137.21.1762454736424; 
 Thu, 06 Nov 2025 10:45:36 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:36 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 00/13] drm/amdgpu: Support VCE1 IP block (v3)
Date: Thu,  6 Nov 2025 19:44:35 +0100
Message-ID: <20251106184448.8099-1-timur.kristof@gmail.com>
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

Looking forward to reviews and feedback!

Timur Kristóf (13):
  drm/amdgpu/gmc6: Place gart at low address range
  drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
  drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
  drm/amdgpu/vce: Clear VCPU BO before copying firmware to it (v2)
  drm/amdgpu/vce: Move firmware load to amdgpu_vce_early_init
  drm/amdgpu/vce: Save/restore and pin VCPU BO for all VCE (v2)
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       | 197 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  22 +-
 drivers/gpu/drm/amd/amdgpu/sid.h              |  40 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 839 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h         |  32 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  57 +-
 .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |   5 +
 .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  10 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  18 +-
 18 files changed, 1103 insertions(+), 186 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h

-- 
2.51.0

