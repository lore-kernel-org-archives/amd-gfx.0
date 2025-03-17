Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB9C35FF8
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCCC10E2DE;
	Mon, 17 Mar 2025 06:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cK5CqJAX";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0338510E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:28 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-46fcbb96ba9so16638251cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191644; x=1742796444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gSIKfe8Kv3TNwqX6B/2hSGdKfGd+A5mIPHT3ZgGMtfE=;
 b=cK5CqJAXS7/yS5z+bXURKr841F/VxlgYgmYbU/tTMod0qexRKBiQ8KgB0yXiiDQ3YU
 lFpHW9E4ap2rECm1qFxJZYpWks3ruwodDSfhzoucj6GkxYfql0rRRkF5jIKRnXWu2Aq/
 J74RCbPfysNSdYA0QBkPTxjomn8kCLkGdxlU1JcnLnGCBucMtP6WwTe0co/SD+c6H1HR
 CbGwPPrWaS9TAuJrmDoycl6nJSpcMUEp7x4FbLRgZ6CV637GpXBeMjrwOjxw/dwXlBfO
 rmYh7ekRrpx+BjUstNcCrTbZ0DvwFsTkcKyfzFU6DVO5ljAtAdURsEprXzWqnL2TB98Q
 F++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191644; x=1742796444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSIKfe8Kv3TNwqX6B/2hSGdKfGd+A5mIPHT3ZgGMtfE=;
 b=TL3ZBqbWdrJMWTb6RYFwGuXLlDjWrpGvTDaNsGmxRHO36cpFl2ee3eaBqRXprCGqiv
 VcUxsGMgwypcirkmQTAeM59QoRHQwGokCE+EDO1LneaUkTkeZqNHaD7L4kbqV3iw90BL
 kBVG7AYd5qCuTMzQ8uxbutlz2r/CzXKcrNjoZcsFoGEu8XVyARgkGnr4wbFfv5kQUWAy
 EktR4a+i9uJtEHA+TfF/9BM2Z1EHHi0Qmhct26Yp1mcchcaUEq+9ifks7pokJJJGAT9V
 uE0prNYI85/NdEd6hGHLVCT8KHp2GEjefX1kTBXOUH52vYxq4dvQm07Ww13fGxPIgy7b
 lWpA==
X-Gm-Message-State: AOJu0YymF/rOsMD0DzDJkHvl6fq0cClcQcNQLdww/OtgpJXzcn3oKylj
 bhS/cEH9caIUFP0o9AiZxKNa6MfBwLpl/0A+fMf2NBHP1gbCs03NH2Apmw==
X-Gm-Gg: ASbGnct3r4qFcNS2/FUGuVTCyFWbzS27PKBmdpGeWSN4vQZjwhV7x9UU14Ksq5igfKR
 NlIv6+NeyWToZzEgexiDIsmnetR728ZwhuSxYqXT1A/fWUsPdrZ3Z/PvT6zivxBQkpyPQgRK5nQ
 /s18LowNWEPNQ7jOqndbZW0CgeJjCET1QckQSgfzpFrqJzgsa5PdNKUhwY/Vv+q/YQa2A5IoJ5i
 k+w3gQZsM1DPZaZOo6zPbP2dvHZ6kAUQC8XOA6Q5zBBfWpbz1D57raK4buPbGY0cakeiFlUfeyn
 hFSqb8Y9JDE7LJFSfOnmLUv9ZombpLX6x2esG2sXUGdXgT0tMICD/GkqYYCvr6U1hCg=
X-Google-Smtp-Source: AGHT+IE16AiGXbuzTNDggWMqoOy96IDiC29PtkRk7aviXuhKY2Au+a5cHKwnaL3fCNB+L6zsHF8MIA==
X-Received: by 2002:ac8:7e8e:0:b0:476:8cad:72d7 with SMTP id
 d75a77b69052e-476c8129768mr182398361cf.8.1742191643487; 
 Sun, 16 Mar 2025 23:07:23 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.22
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:23 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/18] Properly wire defines,
 shifts and masks in SI and cleanup
Date: Mon, 17 Mar 2025 02:06:44 -0400
Message-ID: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

