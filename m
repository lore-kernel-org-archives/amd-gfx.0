Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD98D10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D5C10E12D;
	Wed, 26 Nov 2025 13:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JO3czEZ4";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F327110E12D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:56 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso5085666f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163795; x=1764768595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tQAoqblxxj+oaGaT5Zc7MbITuWPhL5SUkUMjWrg/qcU=;
 b=JO3czEZ49Ybj7DCqH4ZBSr/qBrhvMa6I1rL7o9qQpZ7ZRDZi7rx0WdtHFCIFM700P0
 mE8nRR8YzgBMPJYJA38J1w1dR2Br0N4+KIJ3VlwaHmbG66j4Q5433QK1N+36aXW+geSA
 hZVEMEPiQQKb4bqBqmMyDOcFKA9LlKm81EDiVFv6N4x8gNMaa3Ude335axCSPUSi1lLq
 kumzrqMsAUqiQYaUBXFofiHrz6W+wrivxcvSg3tqtdc+Aqv5yq6n9vwns/Qk0YYnX+L6
 7YqyKx1tBQlIgAVZSnalwUInjZRK6Ge7+iINoqHy2vbQZbKqz9nRBpE8KuJriGxuLEi6
 2TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163795; x=1764768595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQAoqblxxj+oaGaT5Zc7MbITuWPhL5SUkUMjWrg/qcU=;
 b=EGXL5bA56HqBFmQJCJ2MGzkzVom2wRZWu4JzyG1O6k9fOBCtvamFMpXEMNBJE6wCH3
 s44wxstXiWx2LyH6IkorludXAA4etSXVK6geG4Sz9GjTlK0sol+oWd7moBsSJuP21HYx
 OoAM1FjZB1P5rmm0ToEJKm8ValhlhqUA+GdRKf0XdtjfbgTACxeTGg03HfnOx18fxj42
 11M+S1ZqWy33++k5tJpb3CQ2txMWTmgyVWnj6uafgNnyxVaYE8OWi9YpBIrIF2A3An1W
 17/1QOzKdqpycNo2s/y68avq8227jaJ6KrriSEnef7j5Dp+dWSq68jlH8DC47eMIYU17
 6gIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn/rgPoM++52mqsvDi10pXnJgeAgoJSK/2M4SKBsZBt0vQnh22Ld3Z+09OsVOrLKi4POAdXXnQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNtv/bm0GpqTI305yq3uX2vpETG+bnHwt3V9hHlSOKk++qpURb
 BDWuDKhJhT8Z7rPId5G2JB4euHf601tjSqDj5ScY5Vs6UfUjxvXqe00Y
X-Gm-Gg: ASbGnctBwrpLOHGBHL5kUMxbI+rFOVXg3oX7zPXuyx1rt3gkkzmnUl6l41VRR+qTFAO
 CTJvj8i80+A6gwFO9xw6gH3C81YehECLlH0iTdpB54Dzhh7+AnhH9W3plxkWsQ7Dm2l9MqY9jT+
 izG+r9WhC0020Fb3ITLcGtYimxPQUhAcaN0Qf9e67uaKXnkynkdWftO8bZtVlYRevsbboaJaBpA
 CHFp4RdsFXrRNpNCW4TkVjDNQTEZM7Sjn62vHKj3gWVCodWTXYFy/Sxq9gxkI1WJwNmyHjCvmw3
 Bo+Idg2FH3OdVzI8sU0remog3M9/jtozh/fbg0kXNubceSEQtpkvnFcTAumSPpRfAgB8C9wWZ/G
 wviVTDkkCOqJtS1sz++wcU90Jut6SDmUDVMHcD1H9YzZQ6vstzp9YHNikhyndGc/vBqd1g/S8MH
 rWopd5hvOEVUeuxGgXcvAZ3YANzPxwD2XLuQOIPL503XR0Rc3mOfY6PTKU6LGn9GH9+R3QT3OH8
 Jy8ewQlKSQtT1Mayds=
X-Google-Smtp-Source: AGHT+IGMBHpWgGZ2KU86zCIR5PXuehTg63AdXqzNHFa98dZPG02rZjsI554f0x6tyH1rCdnp43MG0Q==
X-Received: by 2002:a5d:4b45:0:b0:42c:a449:d6a5 with SMTP id
 ffacd0b85a97d-42e0f343fa9mr5229152f8f.34.1764163795146; 
 Wed, 26 Nov 2025 05:29:55 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:29:54 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/10] drm/amdgpu: Improve page fault handling on GMC v6-8
Date: Wed, 26 Nov 2025 14:29:42 +0100
Message-ID: <20251126132952.150452-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
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

Enable the soft IRQ handler ring on SI, CIK, VI and
delegate the processing of all VM faults to the soft
IRQ handler ring.

Why?

On old GPUs, it may be an issue that handling the interrupts from
VM faults is too slow and the interrupt handler (IH) ring may
overflow, which can cause an eventual hang. This is a concern
especially on SI and CIK where there are some HW limitations
regarding robustness features with some shader instructions,
which in practice means that users can see thousands of VM faults
during normal gaming use even when the game or the UMD don't do
anything wrong.

With this series, we spend much less time in the IRQ handler that
interacts with the HW IH ring, which significantly reduces the
chance of hangs.

There are also a few misc improvements to the GMC v6 code.

Timur Kristóf (10):
  drm/amdgpu/si_ih: Enable soft IRQ handler ring
  drm/amdgpu/cik_ih: Enable soft IRQ handler ring
  drm/amdgpu/iceland_ih: Enable soft IRQ handler ring
  drm/amdgpu/tonga_ih: Enable soft IRQ handler ring
  drm/amdgpu/cz_ih: Enable soft IRQ handler ring
  drm/amdgpu/gmc6: Don't print MC client as it's unknown
  drm/amdgpu/gmc6: Cache VM fault info
  drm/amdgpu/gmc6: Delegate VM faults to soft IRQ handler ring
  drm/amdgpu/gmc7: Delegate VM faults to soft IRQ handler ring
  drm/amdgpu/gmc8: Delegate VM faults to soft IRQ handler ring

 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 20 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 10 ++++++++++
 8 files changed, 80 insertions(+), 6 deletions(-)

-- 
2.51.1

