Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA3CD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A7310E2AB;
	Mon, 25 May 2026 11:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GdeE0vKa";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6469A10E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:11 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so50436235e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709510; x=1780314310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m8cU9h9SRAVQJT6AVkZu8Ep4jYmQCgT70j8P+uuZKEs=;
 b=GdeE0vKa9+pe/6E7idpUXVsmhlMBFYSSVK2pNhJHeyPMqY6ed9Vf5WDlE3vVSwsBrN
 kbEt8qkRadFqMiwoxDTGjli4VGUt2s1UZp0Yoi5g+NyPeg+QrJ8oA/qyoSMO5ckMfU6+
 bGRGIlRxSQyNeXqRowQ4wp1X9XU2/aHvxQqpCMzsYYPb+xCuiMFFqd1Q+cBWfKmg8qAK
 XWuvPerXXlFZJZa1V7vCaP2rxkb6JEUBnVaScwBIOW4Xys2khI7LAQElgcapLsx/O+Q7
 3q1c1CXUdYN1le3rVIqHxCjkl61HRFdYHzwT4mTrsSVlwMJQhyTdXzXax5paLMC4tcdJ
 yIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709510; x=1780314310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8cU9h9SRAVQJT6AVkZu8Ep4jYmQCgT70j8P+uuZKEs=;
 b=DDUMQqnd4XKkI0uQHNWt+beLw64d8VVsP9IT+Y2BrML7py/51ahYYoCwc7ooTXGHbD
 psFW6mPXRZgH6O4e9vOihrMdPvHrHR3idE1ocZpLfyXYCKPMS7j7MbDAoulhCd7dlSO6
 x9m+pjofJnHHz9TAuAQMjOhZ5wXKPfCua542acO2/yXRZE9aJuwItGfl83cPNNcRgxGu
 8IbHgvQpGCiBeKAXLZWVIDdctriwiFlf97Ck8Gl1DX7mPCJkh2cS7I0QZqkVMksc+9A9
 DqcLguyoQxP6OD3/QX27yxZJiHS7hSxCklPpdPvQ4I5axEZxNSzXlCTTxKW1XfMAyrJc
 gAHA==
X-Gm-Message-State: AOJu0Yy5ldFRIsA8dXJcYNbWHDaIZKwpZF7LYDsUZ9C7py1Ta1Zv2poj
 vODsHmGf8+ced0m+bY8o6A38SCEy+75HoDMLzYVlJTpaNvx3FGznOUasWYOQyg==
X-Gm-Gg: Acq92OGyfRPNEomMrntFV9ax/vjW+AZ2RzNMtTqmvi4yeRWTrC0iWt+E0+jfQsHd15I
 HvFVozueRrZr2N8Ejd1d21JI5huRMCSYcCfVLfrRMjhPx/EaXL1V6GSKijSpNpWoxdc5a8G08JR
 HNWMuT5PiDRgwzTwyzSnr9J0sWOIabHRs49soNA2N20csjDnm6ac4FeVP5JKRzTfJrnwXt8NJxC
 HeAcOUjAJDa4pTqjqfFZTpRzWwcsnG2MfT64YpZDYb2sTxJ1PSiLMwouMzulJ7r+u5LjzXzCrcS
 RMn1/ldUcD6EvrWsdVlmOa7velD8T0B0FBdq4aE/5dyMbKuobFZx7Dl3PN0AxDV8aeLMOVdp9E1
 eEqQmDpgXzcYPksoth4DzZvsCs4P9I5V7ZGrCejlmBhiWn4X4q4dVAcemHMzVfMjqwZfa6GcQbL
 Z3kWsHPhqfT3G3cYOm+JgdF9KIIlHEuQW2JhUXYBH43xe11FMlKkxJh/nJKvxWIhc2
X-Received: by 2002:a05:600c:c4a4:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4904225fbdamr210455375e9.2.1779709509763; 
 Mon, 25 May 2026 04:45:09 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:09 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/7] drm/amdgpu: Improve retry fault handling (v2)
Date: Mon, 25 May 2026 13:45:00 +0200
Message-ID: <20260525114507.24566-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Fix some issues regarding retry fault handling,
such as enabling the retry fault interrupt (necessary
for retry faults to work) and similar.

Improve retry faults on Navi 3 dGPUs by enabling
the filter CAM, which can filter the repeated page
fault interrupts that happen when retry faults are
enabled, making the handling more efficient.

With this series, the kernel is able to mitigate
most page faults on Navi 3 without causing a hang
and without a need to reset the GPU, when the
amdgpu.noretry=0 module parameter is set.

Changes in v2:

* Reordered patches in the series to put bug fixes first
* Enable retry fault interrupt in init_system_aperture_regs()
  instead of in set_fault_enable_default()
* Added a patch to respect the noretry flag on GFX12.1 too

Timur Kristóf (7):
  drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry directly
  drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed
  drm/amdgpu/gmc: Don't compare page fault timestamps with other
    interrupts
  drm/amdgpu/ih: Add retry_cam_ack IH function pointer
  drm/amdgpu/gfxhub: Enable retry fault interrupts when needed
  drm/amdgpu/gfxhub: Respect noretry flag for retry faults on GFX12.1
  drm/amdgpu: Enable retry CAM on Navi 3 dGPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 21 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 21 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 21 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 21 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c        | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c      |  8 +++++++-
 22 files changed, 141 insertions(+), 86 deletions(-)

-- 
2.54.0

