Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6B6C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 05:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D4310E082;
	Fri, 28 Mar 2025 05:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKaPTSbe";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0A510E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 05:10:47 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6e8f4c50a8fso14862206d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 22:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743138647; x=1743743447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TeihVEUGopJ/YxWEfaQBckPDZuf8W6lyDKLCwWOmtss=;
 b=ZKaPTSbe+Ec1679vD1OMMv5O7wIODT9Y7vcpUH3AiplhsTxLHzABP16WuGDyX8+LXg
 KsSRRkhhLlSWgev7YpEmEq/E27+IAMZJu0ng0sM7jaZuXivGVqyyAt2XnMPwHuq3bXnk
 paZQ1bBMApZJOeVabxQgC3K4BJqrx3DRSR4PvIypLjrSLM5iRU80yVOJUqceyZ8LXb/r
 jATa5CbRgC1w4fDPVqTvmQsD+l81Fg0zMuaFTR1OJk+DRZ1eXzm48UKPrhbjpQvDD4Ng
 4W1yH67XreWFay7vLRXC7AUd0HxFzboN2mUWHcD1s4XP9WClvgq29hDYFQWriPn6lz6A
 kO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743138647; x=1743743447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TeihVEUGopJ/YxWEfaQBckPDZuf8W6lyDKLCwWOmtss=;
 b=Dfj68CHZs3z7Lb/RTb1j8M0fIwBBumqJaKx8NEAudYWgaYVtJmVxYMVtoWpSBOwG1f
 Btdom/Gh2HGYDj4WoEMmPwtAZqYMpmKyDMwawG9hA7hv3z6Rd5QAwfU2eAFuefqbB0vA
 IU/EEWcKTQABOUFtak8rcBlT53JWmrL/DUZKpm/QfcM0PJCO2798UOl1cy2s6Or/zH0n
 rc2o2sDJFy0xN2hydnFEhA1HOOE3Vu5QDPMu2oVSAInEdWfifDnaVFmisu77Tq2TkzrT
 R30ddIOJ88bvqrsQ+JecaJw0pjBsmIaXrSjOK2HyWhecFUR77xYuPwBQC0Q/Y+LoUHyc
 b8Gw==
X-Gm-Message-State: AOJu0Yxx9Ux0PSw6N1A4X8LF4NcTnWGbVUCvuRMD9ajYF8kLO5quyQLb
 JD/wz8QQBbEIklQOpiJzsEMiPtB7/ditrlnhL1dTT+IO4SqbMTzU4e4VSg==
X-Gm-Gg: ASbGnctLPbcJOw9Vhz6G7UERWatd7Cq5W/4sqdSEu4i9FNzqQBN8YlakIEA7TL1sm92
 pYbs+dGVeXweMDbHxo3NvDK5J2/IGH3Z7ypJBzP2MF7+1OY+mnIbJp9G5bZ5msHiHSHT7eAXAFH
 pOIguQ2zuKCG21GB7ILtL0ouhJ8wvudn1oWtb8DxBqARXLRquO/B7rvvMwuQAhCOxCydaMGMTOg
 Gdkgb8KCHl20n9EwZA/37NBj2kIKDKdwz1+HBBvZ24+6NGQj9LfFdttJcnA8g+aybxHqNlN+4k3
 rLXUgooKV10ODY2l1eBTI3BwMPP3O3cMIGDZbHfnuG9x0YmosSQpyUKGhX6FG9AAvI8=
X-Google-Smtp-Source: AGHT+IGyw9YmZIwR07N3+NnPU9UazoAtNvwMYMskNVIOsNh77W6Yb5mU+3fe3u+xHjDX1zX87tIlyQ==
X-Received: by 2002:a05:6214:d6d:b0:6ed:cea:f63c with SMTP id
 6a1803df08f44-6ed23842661mr80084146d6.6.1743138646413; 
 Thu, 27 Mar 2025 22:10:46 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eec979736esm6747996d6.109.2025.03.27.22.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 22:10:45 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com
Subject: [PATCH V3 00/18] Properly wire defines,
 shifts and masks in SI and cleanup
Date: Fri, 28 Mar 2025 01:10:14 -0400
Message-ID: <20250328051018.1025728-1-alexandre.f.demers@gmail.com>
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
Remove "ix" prefix to some defines, since they are not indexes.
Make sure each patch has a description.

V3: Sending back only the ones that needed rework since the others were already 
merged.
Patch 10: Add "mm" prefix to some defines, since they are direct access memory mapped 
registers
Patches 11, 13 and 15: Correct accordingly to patch 10

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

