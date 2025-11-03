Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FECCCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A7710E4B7;
	Mon,  3 Nov 2025 22:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cC7Oxwu9";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2374B10E4B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:23:52 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-640c6577120so2330617a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208631; x=1762813431; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BoSRSLqReOPYZ0Pkgim97xdNgBtQ0qRU5/vt7icPZ0g=;
 b=cC7Oxwu9KDlNfNvWUq5GszePOlgN8P2g++/SgpwIyjGUOlBfmiePRH3iXRESmedH2V
 bvzMm9F51vwbf3k40se+Sa5mM34XxkHHZmhSm5MMo56tFUS21PtKy2Vq2Tv9H1YKxfEj
 hsE8OC0wox1L8brhs7W+uw2gOOBkVWpBgMJtapjD6jsYpSsHpImZ8ff733GY/nveDqWw
 OXvhnVu1b89UpnGsR90F+MJCcB/M5YVvivzEex2Ayk9KA8x43nn3XS4vmVo88jzgcWcs
 1GWFWnfkDCD5mXDx3WTHIk2Xsib1LKU6/FshSKjB9965VbiK+9o65axwpN5EHPCem0uE
 AVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208631; x=1762813431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BoSRSLqReOPYZ0Pkgim97xdNgBtQ0qRU5/vt7icPZ0g=;
 b=RYUdyZDxYhsASia6V53h9dr9f2sYUdbBXNq28K84H5LksZHvllRL6jp4afRgrZZFLU
 rnlCwSn+LkY7WrqkwKri02yMSfxFDySoNILN6Iulsrt1ER0owMGf6jzP0XL0e8rw8jo6
 oEnmlC3CJq7QbYH+KwkXix5zCvB/C3i0Gs3cwW1wKAcLAE+vOKacR97PxsNvshSRQmgK
 k5E9gtlV7fKqFeAVpkNAc5BU2fwiFJsPXOEBMQ75TuKAAZW+I6RS2BcuTQwloc1dIEk+
 iISoqGEV/1ZTmuAADgz3ay1FysXbFHwN4pfyrUCQpcgM0JZXKCkfPNZdPjyx0r3FBjVf
 DhmQ==
X-Gm-Message-State: AOJu0YzMwm4C8y+glYxqXOF7Rj3JFLeMQbzAcRmoKRJYkLYUVKxDteKL
 dSVCz7w4V6qDzJfEzIL/KiAPtSCX5qL6k7kS6QSH7pPagDa5wDTqGIGnsF7J6LkP
X-Gm-Gg: ASbGncsrV/7bK3YqBb9ragAhnDpbcAGJv3UTDFuzCEsfjVDaC4mTPQ5qQ08/U4uXVTU
 Bll41uXbzfqnVTTd9mSkPrhMN0aZFtnuc8ggRsh6A95jUtDs+NcjoumCLMguy8J2aLsNisscPiP
 vwipypBUplJgMhNfAqs5hNjVQ7nU7sTzUQULSuo0Fg2b0jvFrpX9V7/wJERxGyar0cAXioeRyFQ
 zIAfcjPHolH8wYXZkW3bn8ndBV++GQZcYyOX9ZvtAQ5C7soPtXjK22SArHWTesv7u7GZuYnSjDn
 AO+0mXYmcQwiINpAF3QuDuHS69bDyzIPrRUhbKGsx+UeSg4thgZFyexYs62fBBnpskkKaX/CVxB
 D4hZq1q1fU7T33m1Wvt3mCGyZarbGjZTimI0ONF4Zg7jXdXnlbXoxf1IRIccQKsHosmfiQUhn4+
 4ykUQ7sMY9SZQagiNFcrs=
X-Google-Smtp-Source: AGHT+IHJFTXK6kZLu7sdA88zhlmV4vUuxhShJ79DsgoZWYWxRghlSG22oOwSYvnMKKaT5R/DMSuHrw==
X-Received: by 2002:a05:6402:2809:b0:640:be87:a875 with SMTP id
 4fb4d7f45d1cf-640be87a9a4mr4508765a12.23.1762208630320; 
 Mon, 03 Nov 2025 14:23:50 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:23:49 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 00/16] drm/amdgpu: Support VCE1 IP block (v2)
Date: Mon,  3 Nov 2025 23:23:17 +0100
Message-ID: <20251103222333.37817-1-timur.kristof@gmail.com>
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

Looking forward to reviews and feedback!

Timur Kristóf (16):
  drm/amdgpu/gmc: Don't hardcode GART page count before GTT
  drm/amdgpu/gmc6: Place gart at low address range
  drm/amdgpu/gmc6: Add GART space for VCPU BO (v2)
  drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
  drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
  drm/amdgpu/vce: Clear VCPU BO before copying firmware to it (v2)
  drm/amdgpu/vce: Move firmware load to amdgpu_vce_early_init
  drm/amdgpu/vce: Save/restore and pin VCPU BO for all VCE (v2)
  drm/amdgpu/si,cik,vi: Verify IP block when querying video codecs (v2)
  drm/amdgpu/vce1: Clean up register definitions
  drm/amdgpu/vce1: Load VCE1 firmware
  drm/amdgpu/vce1: Implement VCE1 IP block (v2)
  drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit address space (v2)
  drm/amd/pm/si: Hook up VCE1 to SI DPM
  drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn, Cape Verde GPUs
  drm/amdgpu/vce1: Workaround PLL timeout on FirePro W9000

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  36 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       | 179 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h       |   2 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  28 +-
 drivers/gpu/drm/amd/amdgpu/sid.h              |  40 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 835 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h         |  32 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  57 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   6 +
 .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |   5 +
 .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  10 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  18 +-
 23 files changed, 1109 insertions(+), 189 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h

-- 
2.51.0

