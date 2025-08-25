Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F041ECA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C2E10E593;
	Mon, 25 Aug 2025 21:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/VNSSI+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB94610E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:47 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso25725415e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158406; x=1756763206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zK/Gw52cYHXvKR63yN3lqfkGNmwmHtZ+xfVRlhe+m1w=;
 b=S/VNSSI+SIrJ4Jx6GvLZvCgrxZb1fjhnkMTOMCS/yUwDqRzVej5tUru4u3QbFs8Axw
 q1KnNrP/ai+O2Fs73cigz4voChTRdVnBRQLelRfUl60LQ3Ydv6sK58qmOS6nuEMBpPPl
 k7eS5kHabICpSbr3D8F2boNPMAzLtPyoxkSp2vcYA/ts3Drpm+IHr5mzFNtQDMlhse9L
 tG4yNA5jd4lsi0H8wb+NGcLNNkoso1r6jLktKrwSbpOoOCPdssUAcYSQP1UI4Am7N957
 9Z1TsZGaj22TZbYQTmdTYOe7qRrxuuhLRj+YtDojT/sraGPPua/L1v+4CXKU/534f25h
 wv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158406; x=1756763206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zK/Gw52cYHXvKR63yN3lqfkGNmwmHtZ+xfVRlhe+m1w=;
 b=NQUcjI3Ugsv1fGNfuh8c0fZAVtcVSUOlWnXeoOZpV2MC3o5dcgb3aFjSMhVIm3ks9d
 sZMkwOQPD9a5uPq55ByPRlWZqGSP1pf/e5MzptQ8YhOjFvP7R2lOfx6dxiw3xO0apjAb
 /Assvzr6H/Bi5uVzjutRy4HrgEeuKEDGVqLxYwq4j6FZPiZmdwKp8pi5eX6gALlkVCu0
 bCVke31i6FpLAtNkuQwNfOAOtDTfTSsIsUXOAh6DYlngOSjV8+5Ck9N1/t9L6NrRkb3F
 HlSwNb8pBDO875JJaIC3pLyFRPUe5X/tFI7K9lFPSDXj8HP3o3TzcWez1N43q2z4ezmX
 tgDw==
X-Gm-Message-State: AOJu0YwX9xNtHsgNB6qAJNedQu+wcYVzVksU4hr6idSe6anEdfds0Fs1
 s5qtJFpI61zr5UnFXnpoc5wxVKEnne3JAHwvBLblqA+BNuh/uCfl3joSopKk9A==
X-Gm-Gg: ASbGncvD3r3A9kXYsL/WBw404rUYJckdaO3emDUFr7LX+iYCpFnKRXi5JBwPdQ6IAbS
 kVTNjJD9HII0gLw4A5tBd4DjjLZ9GjZ6FR8HBGx0f72866A+jNzSoZ1GzM9mszgUY5N+70I0j4P
 y4MGX67kM3Li/OnwfiTtVKIZKNcXikEStpao7EQlF5UqTRouwwPCmdtRkjWB3WKQHFoKVXNoF4L
 eiOa8VPPHi97M2hE/iH8Za4KSUzpaw/yTtb0I+wH5tsY57x/511q7kTRSZ6VhRyl8CemC/LIZ/b
 bN78M12Tovu7Dt9L3GJFvfzTClotefpIehKWDo+wOaUmweMdw/YboYTVIhvvd1gPAtddQrz7jMb
 NPLyBGdEQ4CKlb/K7QtOutb0cfEoTYP8qd0m4pQLYou/lV/LYYmLGghHmPurLpb4SRR8VruHRsS
 feVc4indeQ7ZLPKstwc3AuKwG3gQ==
X-Google-Smtp-Source: AGHT+IFjnofvTOKBUf1ikLOalHRTiH60iQKvCSsoNPLXLj30aa8uLe8Y3wU/J0HoTY4Bhwu5CSr9HA==
X-Received: by 2002:a05:600c:450a:b0:456:25aa:e9c0 with SMTP id
 5b1f17b1804b1-45b517ad7f8mr80892465e9.14.1756158406101; 
 Mon, 25 Aug 2025 14:46:46 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:45 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/8] SI power management fixes (v2)
Date: Mon, 25 Aug 2025 23:46:27 +0200
Message-ID: <20250825214635.621539-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This series fixes some power management issues on SI,
addressing the feedback I got for the first version,
as well as additionally dealing with the issue of higher
refresh rate displays with the non-DC display code.

I recommend backporting these commits to the stable kernel
because they fix some issues that have been there since
the beginning.

Note, I decided not to include the radeon backports in
this series and instead will tackle that separately
once this one is accepted.

Timur Kristóf (8):
  drm/amdgpu: Power up UVD 3 for FW validation (v2)
  drm/amd/pm: Disable ULV even if unsupported
  drm/amd/pm: Fix si_upload_smc_data (v2)
  drm/amd/pm: Fix si_upload_smc_data register programming (v2)
  drm/amd/pm: Treat zero vblank time as too short in si_dpm (v2)
  drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
  drm/amd/pm: Fix SI DPM issues with high pixel clock (v2)
  drm/amd/pm: Remove wm_low and wm_high fields from amdgpu_crtc (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h     |  2 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c        | 29 ++++++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c |  7 ++
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 75 +++++++++++++++-----
 8 files changed, 93 insertions(+), 30 deletions(-)

-- 
2.50.1
