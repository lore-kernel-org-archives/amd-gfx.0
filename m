Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B89DCDE00D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 12:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E9F10EA4C;
	Fri, 14 Nov 2025 12:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZprbX5sJ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2822E10EA4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 12:07:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so14333715e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763122059; x=1763726859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gvvmXSlBSnNp8Qaby2HZe9vo06uQfOe7X/dKF1r7ctg=;
 b=ZprbX5sJxPVXT85T4LY7JUcxcKDf3Ijbq5qojpHfdP5YezMbZOVwfUYnMfG/ZxZIax
 7wdG+lGK5zX3XmnGZTg/s/RxoWOALnVlprA3Q8NoW9eM27A0/IQ8vm+trx8GVD4toxE2
 gShoBWVP4CoUzgkO6LhpXJTfwsfhAhf1y4Gyf/d3nNTO1eUGCB64utw2xhQFUXF2rZaP
 JIWyFLo5yeUJO17hGmyDxHwuuXV6zggY7JQrv5P+oMzZRVW2qIKRAmlyJVgrot02tGHC
 ws3Set8NRJGnvjcRYwGvpgu2WJY/gISU7SfQOT3FMQ+uPvVzIPF4rUYFOod3rdCQ580D
 eh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763122059; x=1763726859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gvvmXSlBSnNp8Qaby2HZe9vo06uQfOe7X/dKF1r7ctg=;
 b=cRfElyAbo2bE/k9wuN8GRLW44lKVJ4sCnrTd5tiAh1pludUl3rUwTWc8c+5HI8IPcu
 o85QWkxpQvO8TtsHGpydZPMum5YXls0jEN6Ij9re0QBz/X/uF16xGxjIP4Vx8V6ZVkUr
 fUk0VDh97T116HD/HM8PKQ78DQhrR1tUZJ885om2FlLj4dTTlYgQQ16shzo01qVQaFtd
 p3zNXZLWkZLiRahLup/7ZTC2sRMwWuwjyGeidRzXSRKj4+vXCnOb87f+qBCdzXlN46wb
 5ikaszHd1Z2ClLLAuGMvj+U2Hl1K/AQ6m2xhYK+TZGNVZXl4T75Ud4GLOZBL6ApDi+qT
 GGjg==
X-Gm-Message-State: AOJu0Yx9Jt/sHZx6x50eDbuGoKNpbB57Bf771AQbdO8WUIZB/XRmd7am
 iJIeSk4+3v00RPAn+OxsZKcJHryGQ7/DD+sIV8ReZHiKiatzCl7Foxg4e5LUHeq2
X-Gm-Gg: ASbGncuiFu4C17v+R3ohAWMzw+ANXwjrhhAUdC2dxOcguDjEgRaWI1W25RB5XXdNyIo
 LJpEdoeVU6WJiLWka6TNPvlnHmZPSM3uqf51YQLjWSQajWWVIUsVHA7SxPJDWBI4GijIygrngyT
 Tgpj/IJIR0/je6jQrbMHee2aSJDwIHdLnRzPYbW2BcZddJgp5akn3OzWYIHVHhvewv0xJCcfp+Z
 /CUIGkcw1NdeNAczO8/OazNzaIyxCHoVCqCxuxy53gttn/+S/TX/8CBqjpWVYDrS7TmWti4sLse
 xqhLxJoh668i8x7iORqkLMaVrOqjIqr/okiNu8OprW63WO0ca0w3b2STDarpTLmu/cSXfXl+HuE
 JQz+eY7/2bEfxOq2DyWXVEdbz4GdEJt9GAzyCw2v06590LGh6Cqj+NUVQVCLav28nbDnEw5vFvk
 RHRf42HHY3BPVAVIr1Gdm/KopaJlxz7fIvJDnFBA9+3cFsrrzvbbK7eZ2RTnUl2wnUs3xjvPkp+
 hKwM8VLKhvhLFT8IwgYq05q/mg5
X-Google-Smtp-Source: AGHT+IH8q2kJE7veSPrxYKg6Wb0t6rMDO9Lea7jRb/ELVe5BEHzAbCt4oKyCYxEcpOKec9GuYvAYHQ==
X-Received: by 2002:a05:600c:a04:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-4778fe9b384mr27591415e9.19.1763122058534; 
 Fri, 14 Nov 2025 04:07:38 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00CA8B1D2C0125E560.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd2fa91sm42078025e9.17.2025.11.14.04.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 04:07:38 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/4] drm/amdgpu: Use amdgpu by default on SI and CIK dedicated
 GPUs (v2)
Date: Fri, 14 Nov 2025 13:07:32 +0100
Message-ID: <20251114120736.31310-1-timur.kristof@gmail.com>
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

Changed in v2 of the patch series:
Updated documentation in Kconfig file.

Now that the DC analog connector support and VCE1 support
landed, amdgpu is at feature parity with the old radeon
driver on SI and CIK dedicated GPUs.

Let's enable amdgpu by default on SI and CIK dedicated GPUs.

Why?

Compared to the old radeon driver, amdgpu offers better
performance, more display features through DC,
as well as support for Vulkan 1.3 through RADV.
(Note, although the hardware is 10 years old, the R9 290
still appears in the Steam hardware survey for Linux
at a modest 0.25%.)

What can these GPUs actually do on amdgpu?

Hawaii (eg. R9 390X) can even play modern games such as
Baldur's Gate 3 or Cyberpunk 2077 and gives a decent user
experience considering the age of the hardware.
Tahiti and Pitcairn can play some modern games, albeit
at lower resolutions and lower frame rates. They are
mainly held back by a low amount of VRAM (2~3 GiB).
The other SI and CIK "gaming" GPUs are mainly useful
for playing games from their era (the mid-2010s)
or less demanding games in general.

CIK dedicated GPUs are the following:

Hawaii (2013~2015):
  Radeon R9 290 and 390 series
Bonaire (2013~2016):
  Radeon HD 7790/8870
  Radeon R7 260/360/450, RX 455
  FirePro W5100
  various mobile GPUs

SI dedicated GPUs are the following:

Tahiti (2012~2014):
  Radeon HD 7870 XT, 7950, 7970, 7990, 8950, 8970, 8990
  Radeon R9 280, 280X
  FirePro W8000, W9000, D500, D700, S9000, S9050, S10000
Pitcairn (2012~2015):
  Radeon HD 7850, 7870, 7970M, 8870, 8970M
  Radeon R9 265, 270/370 series, M290X, M390
  FirePro W5000, W7000, D300, R5000, S7000
Cape Verde (2012~2016):
  Radeon HD 7730, 7750, 7770, 8730, 8760
  Radeon R7 250E, 250X, 350, 450
  FirePro W600, W4100, M4000, M6000
Oland (2013~2019):
  Radeon HD 8570, 8670
  Radeon R5 240, 250, 330, 340, 350, 430, 520, 610
  FirePro W2100
  various mobile GPUs
Hainan (2013~2016):
  various mobile GPUs

Timur Kristóf (4):
  drm/radeon: Refactor how SI and CIK support is determined
  drm/amdgpu: Refactor how SI and CIK support is determined
  drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs (v2)
  drm/amdgpu: Use amdgpu by default on SI dedicated GPUs (v2)

 drivers/gpu/drm/amd/amdgpu/Kconfig      |  24 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 160 ++++++++++++++----------
 drivers/gpu/drm/radeon/radeon_drv.c     |  81 +++++++-----
 3 files changed, 162 insertions(+), 103 deletions(-)

-- 
2.51.1

