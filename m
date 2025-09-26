Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D928ECAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36CD610E15B;
	Fri, 26 Sep 2025 18:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bc+ed69T";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16F810E15B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:16 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b5507d3ccd8so2200436a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909736; x=1759514536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nrwO8zUUQ6zp3AsQGcCXhu6FPHJ2Dz62jW2bt+i7ii8=;
 b=Bc+ed69T+NnPOKzLkZ3XpZNcBJVxMZq2j+LNUnJIlqX5gpm1PYLlxsjQ9pq0Gnagrk
 vqiTkiCUKT1LBTS3ijkXUiNX2FXVkE9p665ePOBo++fbuA160q15UHB3CQYup9R2IJz7
 Tev0DKc0WzLX9K95aKz6z6SQisbhyAlRuemkX7ksgXIe0w6Z3JogDmf/W1fNYiu3JjcA
 nmc+XGrTO0IM3NZMpHDinRAOskDhcrTVfGfZi9+HNC3oK/lYhrfKe8013TKlIOQlxsYA
 A1vSbzXE6RIBO2mg9tvTrzMaNOk++7paWj8qloyV1ijvEpbU8leCzw2oC+sTW9YerCYm
 TzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909736; x=1759514536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrwO8zUUQ6zp3AsQGcCXhu6FPHJ2Dz62jW2bt+i7ii8=;
 b=RxbhkmHBNHwW2c50X8jFy4y76UfG/qiQCSMEQo9VRurX2qehnZU9arbhCmtwYLTIRy
 /gspDuvOnENpiAPb3zuUAhl30L6RQgGzB44NhBfErL8Dzgkr1j+4TU3XbZYMJcJpTRKL
 nthvctj/AIs3g+Ec81TGc7aXg77MqHl779TcnQvb5Lz8RrxoI5wyKv0Oe8aPxUDVhdSz
 VwEU479ed5xKsiijpeJMjuEJCNd/9mYpbVVQMKBd2nw7d+61J4E6w4ijnXeMUU93eGXr
 vHYzMp74T53VLuyZHTVYdg7PMCKzpDQTqByFwZLbhk5wE1WGBLpZ2zfpbQu0UhGfOIqx
 TG3g==
X-Gm-Message-State: AOJu0YxmJ5QN+ZYdqSeoaMFUlULvOnfnSDkU4SCSo3VtCUpsdhneKSPN
 DIiF9G5n6uLGc0FWw7Jl1JW+/xCTUH2msXySBFALZ8RPuYl/cv05DbTSR4ifDA==
X-Gm-Gg: ASbGncsGgC7WsZhP/PdOMUoxLB27/YY5Fm3ym51BcksIuOD3118FVME2Q1UvvRlA0pB
 YKtGjX6fmnFK5/KDb+UvHZwfCbVm5u6oWlLEkJbm1dmZEOhHtysjm/e/99HjgKPSQGqMjyLBKfa
 1FcwwSM0VtyuhRB+aag+U5MOQmevq8Uc1J/Vv/lNYfrObGOoOOfzq/QVtC8OnOw10XaB95L3PoK
 sgn7nc4+snyOaNpRaYBIUwHkZCtFiT7Q0QsBvVMt5Ofd8Az8Hwc8lOsmLbH1ExSdh9iVktJrYIQ
 4LDB4wb8codOoDY6u5Uhk5lxqRfxvjArHC9dWhpyKimSBeb7/nQcao1UegFo6LhhuZimTXbq/Vz
 So4l+ChSsdugEMN/YM++fSKL0I5yBR3sAJ+92auGa/firiv6+Q2p5ORQ0D1yX9q7INXN6NGpjMh
 14ksma2tXrkHUDS3OJjgU=
X-Google-Smtp-Source: AGHT+IEKKtS77gHggO1+FXnCkfhhtaSz+NAY931LRlV4F+9l/uq9evVgoIf0DfXB6gqHd+c8gjGpsA==
X-Received: by 2002:a17:902:ec8b:b0:264:ee2:c40f with SMTP id
 d9443c01a7336-27ed4a665e9mr98483375ad.52.1758909736068; 
 Fri, 26 Sep 2025 11:02:16 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:15 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/23] Analog connector support in DC (v2)
Date: Fri, 26 Sep 2025 20:01:40 +0200
Message-ID: <20250926180203.16690-1-timur.kristof@gmail.com>
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

This series adds support for analog connectors to DC for DCE6-10.
There are two reasons to add this support:

1. GPUs that already use DC by default and have analog connectors.
Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
and their analog part doesn't work with DC. This functionality
regressed when switching from the amdgpu legacy display code to DC.

2. GPUs that don't use amdgpu by default yet.
Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default
yet, and missing analog connector support in DC is cited as one
of the main reasons why not.

Before starting this work, I asked Harry and Alex about how best
to do it and we agreed that we'd like to use the VBIOS to set up
the DAC. So I used the amdgpu legacy display code as a reference.
The first few commits add some minor changes to DC to prepare for
supporting analog stream and link encoders, then analog link
detection is added along with polling, and finally DAC load
detection support, which is useful for old displays and adapters.

With this analog support added to DC, we could already fully switch
CIK discrete GPUs to use DC and switch them to the amdgpu driver
by default. This series switches Bonaire to DC by default, we
can do the switch to amdgpu in a later series.

For SI dGPUs, there are other pending patches to make DC work
well, afterwards we could switch to DC by default, but missing
VCE1 support is the blocker from using amdgpu by default.

For GFX7 APUs, further work is needed before enabling DC by
default, specifically with regards to the TRAVIS and NUTMEG
external encoders which are not supported by DC at all.

Changes in v2 of the series:
Fixed regression on RDNA2 and newer APUs.
Fixed flickering caused by polling analog connectors.
Fixed crash on Kaveri.
Fixed bug when HPD was high without a connected display.
Reduced code churn by reusing same link encoder.
Addressed other feedback from the review of v1.

Timur Kristóf (23):
  drm/amd/display: Determine DVI-I connector type (v2)
  drm/amd/display: Add analog bit to edid_caps (v2)
  drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
  drm/amd/display: Hook up DAC to bios_parser_encoder_control
  drm/amd/display: Add SelectCRTC_Source to BIOS parser
  drm/amd/display: Get maximum pixel clock from VBIOS
  drm/amd/display: Don't use stereo sync and audio on RGB signals (v2)
  drm/amd/display: Don't try to enable/disable HPD when unavailable
  drm/amd/display: Determine early if a link has supported encoders (v2)
  drm/amd/display: Add concept of analog encoders (v2)
  drm/amd/display: Implement DCE analog stream encoders
  drm/amd/display: Implement DCE analog link encoders (v2)
  drm/amd/display: Support DAC in dce110_hwseq
  drm/amd/display: Add analog link detection (v2)
  drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
  drm/amd/display: Poll analog connectors (v2)
  drm/amd/display: Add DCE BIOS_SCRATCH_0 register
  drm/amd/display: Make get_support_mask_for_device_id reusable
  drm/amd/display: Add DAC_LoadDetection to BIOS parser (v2)
  drm/amd/display: Use DAC load detection on analog connectors (v2)
  drm/amd/display: Add common modes to analog displays without EDID
  drm/amd/display: Don't add freesync modes to analog displays (v2)
  drm/amdgpu: Use DC by default for Bonaire

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173 ++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  20 ++
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
 .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
 .../drm/amd/display/dc/bios/command_table.h   |   6 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  85 ++++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  16 +-
 .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
 .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
 .../drm/amd/display/dc/link/link_detection.c  | 147 ++++++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
 .../drm/amd/display/dc/link/link_factory.c    |  60 +++-
 .../dc/resource/dce100/dce100_resource.c      |  31 +-
 .../dc/resource/dce110/dce110_resource.c      |   2 +
 .../dc/resource/dce112/dce112_resource.c      |   2 +
 .../dc/resource/dce120/dce120_resource.c      |   1 +
 .../dc/resource/dce60/dce60_resource.c        |  29 +-
 .../dc/resource/dce80/dce80_resource.c        |  26 +-
 .../amd/display/include/bios_parser_types.h   |  11 +-
 .../display/include/grph_object_ctrl_defs.h   |   1 +
 .../drm/amd/display/include/grph_object_id.h  |   7 +
 .../drm/amd/display/include/signal_types.h    |  12 +
 35 files changed, 1117 insertions(+), 86 deletions(-)

-- 
2.51.0

