Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D3EC36001
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708C610E84C;
	Sat, 22 Mar 2025 01:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBNYk+gT";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EB410E84C
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:13 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-476a720e806so23515981cf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608033; x=1743212833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jCrjBRIE/QKZKhR+ffDSCHJAQ95MYOcCeCN3r8guUlQ=;
 b=ZBNYk+gT3wHIZO3MiBGnYJFIT1nkiCOhrP3wXMeRvuKdZPiAt7IS0/vm6+n4Rrp606
 5/jxolqcRGJADGCs2PqTN0hB2JO5VW/YHt7f/9bY1IRQuIzzxHxdThkJjPvXBVUT/9hT
 i99MbIXHCPfzEVpaRSSlhFYCnSQP3C8IwCvxEW/B5esWiQQmo0PNI4HmBoxBXEEOEFGx
 URoRtms65+/JWIcEbURyuvcXc9/Cik8Iy2+JoH8QVfBGk3kLVMab3y0EaDjM93Z3L9Vc
 5pkOc2732fGXhprjmMEVOIrZHvcq6cW5KLgE3a04dhVIShDUTD5scFJw8uIn57OLqBPT
 y3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608033; x=1743212833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCrjBRIE/QKZKhR+ffDSCHJAQ95MYOcCeCN3r8guUlQ=;
 b=GpAGlOXyB4IwP007KykdEQEZxhyBNdiQ3Nh5Ii1M3dA8ksX+pEin4lVthD2hdzex23
 aRVMnf4l5CmZBFZ8aOWAS9wqpZBZHmiTzbbL8VAL44ZoQ11UCsLUKu1Fz4rj5yvsl+7x
 P6rZP2ZDPgkFyx/95ORAeJRRsj45OinUtBX+2nx3vmXZxEPUUyFucXKGN8PxzsIF9eLR
 L8n5W/sFGJfj2c5LyMvHCZYueJI42HAtcGUXKBE5ltwix1/wkS7de0wZJNYcNic0VMjk
 5ktItdaztoBU7OzotnWhn2V34qDiKCF7LOCm1MTCbm75Sw7vSA0wUnvjQ0+IhUmLNmpa
 DEcg==
X-Gm-Message-State: AOJu0YzvdBDYCKNtRlTIVlLinB28qH4lOpW075lyxMQip2mq/oM2QqJN
 LGyNVq4i1TSeWm+I22qYrvn+c8u3GxBK1+w0MTud8XOdHWlFJ9SXi/htTQ==
X-Gm-Gg: ASbGncueqiQgdDZTkBsAOVLPodyHjQCLRhi0lpIgQrWnNhNZ3slqetG4GTnxg5VXa7B
 iknGm9UdhRoqG+gKsGI2VsTog0UYCBrXY4KY5SAT2VSw4Jf99e5Bm/xqs9LbM4o/1FeBpD0Tg1z
 hxA7Xty9EfISZzahtuSljwSMXIe+0F2ZAYgR04ladBxxoY3bEHJD4fWV/spJfkKtccrPJPE3hA4
 7i8iLXz3nURv/E29cJKn5OfFRIlILLBLwDFnqJ0nJT2QnXCNgt/NCPN02OBYC2xUEzayyooatnH
 u6HTbhBO5CBqwigBWmUWHn0QengZc7NrghHF8/kQHp1QEzNPMd/irBqhOnasWNpUDEk=
X-Google-Smtp-Source: AGHT+IH9epHeuSsuj93R4LZpF6S8LEgV7pZIMNu4b1jQB203W4IvWLc0SgUnDisNzMel4cfdnUYTZQ==
X-Received: by 2002:a05:622a:418f:b0:474:f97d:51c7 with SMTP id
 d75a77b69052e-4771dd802c0mr80849431cf.14.1742608032568; 
 Fri, 21 Mar 2025 18:47:12 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:12 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/18] Properly wire defines,
 shifts and masks in SI and cleanup
Date: Fri, 21 Mar 2025 21:46:42 -0400
Message-ID: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
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

The following series is intented to remove duplicated defines, shifts and masks or
to classify them where they belong. si_enums.h has been used as a garbage can
for anything and everything when moving SI code from radeon to amdgpu. 

Where needed, the defines found under sid.h and si_enums.h were ported to DCE6,
GFX6 and GMC6 defines, shifts and masks. There location was based on CIK and
later.

However, most of them were already available, but not used where they could be.

This series is running on my PITCAIRN setup without any visible drawbacks.

V2: Drop unneeded comments.
Remove "ix" prefix on some defines, since they are not indexes.
Make sure each patch has a description.

Alexandre Demers (18):
  drm/amdgpu: move GFX6 defines into gfx_v6_0.c
  drm/amdgpu: wire up defines, shifts and masks through SI code
  drm/amdgpu: use proper defines, shifts and masks in DCE6 code
  drm/amdgpu: remove PACKET3 duplicated defines from si_enums.h
  drm/admgpu: move si_ih.c away from sid.h defines
  drm/amdgpu: use GRPH_SECONDARY_SURFACE_ADDRESS_MASK with
    GRPH_SECONDARY_SURFACE_ADDRESS in DCE6
  drm/amdgpu: move DCE6 away from sid.h and si_enums.h defines
  drm/amdgpu: add missing DMA defines, shifts and masks
  drm/amdgpu: add missing GFX6 defines
  drm/amdgpu: add missing SMU6 defines, shifts and masks
  drm/pm/legacy-dpm: move SI away from sid.h and si_enums.h
  drm/amdgpu: fix GFX6 variables for sid.h cleanup
  drm/amdgpu: move si.c away from sid.h
  drm/amdgpu: move si_dma.c away from sid.h and si_enums.h
  drm/amdgpu: huge sid.h cleanup, drop substituted defines.
  drm/amdgpu: keep removing sid.h dependency from si_dma.c
  drm/amdgpu: cleanup DCE6 a bit more
  drm/amdgpu: continue cleaning up sid.h and si_enums.h

 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  176 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   15 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  387 +++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |  116 +-
 drivers/gpu/drm/amd/amdgpu/si_enums.h         |  234 +--
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/sid.h              | 1546 ++---------------
 .../include/asic_reg/dce/dce_6_0_sh_mask.h    |    4 +-
 .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |    2 +
 .../drm/amd/include/asic_reg/oss/oss_1_0_d.h  |   23 +-
 .../include/asic_reg/oss/oss_1_0_sh_mask.h    |   43 +
 .../drm/amd/include/asic_reg/smu/smu_6_0_d.h  |   44 +
 .../include/asic_reg/smu/smu_6_0_sh_mask.h    |  190 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  358 ++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    |   42 +-
 16 files changed, 1001 insertions(+), 2198 deletions(-)

-- 
2.48.1

