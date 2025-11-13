Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E5CD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 19:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4A410E928;
	Thu, 13 Nov 2025 19:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X311A3It";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C066710E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 19:07:24 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so10137635e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 11:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763060843; x=1763665643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Do1S4HHZnCAJgzolwWOfARyogo6FeWafov6E92fQW7g=;
 b=X311A3ItJOLKvS/0Zk0njHSE+2dcj+VbX8I/sST15F5YGFBShbccCyfmr8pFdiS8WE
 gDOrk3Ig7DkgtuUzyJQiXBaL2Gh6mv2DN4uRXgXGmUt3uuN3CxM7z+lJ5rJBKHzgtF+j
 c15QFe4qO6aWgiiEEa9ZvOEo8v+14YjC1IgliBrbr1Mc9zllOYJeyLFU8FTFmzJ3NXXU
 h/GhL0xNI0eGtRjoFkYaJxXaqHlTMXrWTSY3YpFtNowAKCgpuzZSd23OZ+16dNm6qAeG
 5WVOx3LpUIwvmm/jDbuNwPJAlaXXRwwC4mn+EebFo1c55SlxUnSpCTuQWm8ZFoaAFIe9
 gJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763060843; x=1763665643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Do1S4HHZnCAJgzolwWOfARyogo6FeWafov6E92fQW7g=;
 b=NyQGzPapPiDnVTQ9PhK/G61TwWptbUVFcVH8ADTroy+fzdoK/gTy/ND4Hum7GknBSE
 d9yo3kJlhhiqBx/w/nYAldfmuW6uvcUteEFre5lhKPapDO/XQPbM0mU77RmrT5jsSRay
 ejprDwtfFjIbC1m1bt+FAAteoaVpLwksjg3Zp+VrDzJy06kujy8E+42B2JSOMS0I4kkm
 QMiZh2oA2WXPc7xQWqFTrcfic4F879On8mMgTnU/WmUGH5cncgq1h40M8oJpULwAVENC
 dL1m+GEkVynHYd59Rh1bmnSI+uCzTR4GojykOejeyuMw1h9fiuC9xkkx339T3Uc4UNRR
 8LNQ==
X-Gm-Message-State: AOJu0YwORSF6p5ZdD8ytfno5URNwmCLVjnWXtCMEPDMO0lB7HK4ftclM
 TJJ0uHvGGRfrfc/a5EhDb/s6FgzpgO8VM9b+KCkDvxR8XMrif18xuP7hrzRBMxE/
X-Gm-Gg: ASbGncsJSq4lN+1UILdiaU/6y81DUUOKGriB3ZaaM4hbTgj2d9Pg4y60d0I260rKwrY
 qiPK9804YquKwd+YUPyH5C6ZIXG94bVrbII300ck3NzJLVbi9csh8R98vW5XA8rz5+Glt/tUDtq
 2mZQ8d8kYSaHCTe1kRFo5Epp6g+M0i/5wIA6xbv04e1JAyGXkKNcWGfASRaSYz5VhPZtW1CBTpV
 qq7d93TgNR/SJTG9nHqfI7z7FniIMlTNpWaex8B6cYp9IST93pyPEVI7A0euKMb/ZKOzfox2pnj
 Rv1DXI8QAhelFX5pAA4GPo2SAsRTTK65ivmbbQE46aBE2qmVnq3P9ttXetAesI1p05j/gfdiED1
 JMAw8b+iea2iOhOWCsPYeUOwkdynYKDYo29dITDakhbBSKH+Sb9XdwDCQtP60VbYjuzzukzUcK2
 a2pBKyecAhM5mQ8zcQAIE9jwnVEL05wEU2GjvzS57Z4V9+Wx1+Rxa2RpdZTDPMtrb3BbLJVY4O5
 /hSCXPQdm2coHLEtfDGRJa5yLY4/Q==
X-Google-Smtp-Source: AGHT+IFrWSvHHJ4+hsPM9rD4MOCbvWDYcg/MVASsoo7JFJcgLgs0KDMqfgjCM8bwRGVBpmkuGokOZQ==
X-Received: by 2002:a05:600c:8b37:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-4778feadabcmr6455415e9.32.1763060843114; 
 Thu, 13 Nov 2025 11:07:23 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778f4bc9c6sm18822665e9.14.2025.11.13.11.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 11:07:22 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/1] Use amdgpu by default on SI dGPUs
Date: Thu, 13 Nov 2025 20:07:20 +0100
Message-ID: <20251113190721.258617-1-timur.kristof@gmail.com>
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

Based on my earlier series:
"Use amdgpu by default on CIK dGPUs"

Now that the DC analog connector support and VCE1 support
landed, SI dGPUs are at feature parity with the old
radeon driver too.

Why?

Compared to the old radeon driver, amdgpu offers better
performance, more display features through DC,
as well as support for Vulkan 1.3 through RADV.

What can these GPUs actually do on amdgpu?

Tahiti and Pitcairn can play some modern games, albeit
at lower resolutions and lower frame rates. They are
mainly held back by a low amount of VRAM (2~3 GiB).
The other SI "gaming" GPUs are mainly useful for
playing games from their era (the mid-2010s)
or less demanding games in general.

As a reminder, SI dedicated GPUs are the following:
Tahiti (2012~2014):
  Radeon HD 7870 XT, 7950, 7970, 7990, 8950, 8970, 8990
  Radeon R9 280 series
  FirePro W8000, W9000, D500, D700, S9000, S9050, S10000
  Radeon Sky 700, 900
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
Hainan (2013~2016):
  various mobile GPUs

Timur Kristóf (1):
  drm/amdgpu: Use amdgpu by default on SI dedicated GPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/radeon/radeon_drv.c     | 1 +
 2 files changed, 2 insertions(+)

-- 
2.51.1

