Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F7CCFA1A
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Nov 2025 15:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C5C10E036;
	Sun,  9 Nov 2025 15:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngvbC0gY";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D39C10E036
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Nov 2025 15:41:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso10905185e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Nov 2025 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762702871; x=1763307671; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LYw+uICWY/oXPQms++Yh4Osfi8zKYeRjWNC/gSKHeXU=;
 b=ngvbC0gYNXLbZ4VEIVzEHNm4pZBaOqVWcVvkCDPPNbhUC2mxR/XMG4PCs+W7Vrrh/g
 WGHaZ++POLqHKbsSnAULdhST0T84UUwD3ny1QQ13fazcux5HrbAHgFKr5mlDmIgJmDOz
 WWiHPa5o4Cu4X65Iiv+1Xf4EcHlLr3fnHIU6THRBtR6V99AILo6gGcJRQu/jpIluLaDj
 7ezWe62172TR+20qKcIH01vfNiDRab8qy7szz1NaoYXtJcSBOUa1AvJiZCUBDWHldtxE
 omweXd1XRJZqL3XIp0lzFdXoDJn3mLQc2dI6bhXj3qo5rbZ3StvUbnb2kuXSfk7DjMEE
 kXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762702871; x=1763307671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYw+uICWY/oXPQms++Yh4Osfi8zKYeRjWNC/gSKHeXU=;
 b=jkBgOAXt6KfANRiLCP3pkOM9Qvhz/irpF1bjnHO+k9/lUNdRLj2d0pDeg9EM9RR2Y4
 /C90plfPps0v76VOT5j+GHDmWndnlQqzCqYRoenyylSlyjFonIw8g5sSUWGaf7mhweA4
 1di9h+0OyI+iQYwj1lvvfi2uS+B07+N65dJinRoFZ1XOstS6oSXI5ukpB1M+njamKjdY
 KFFTIPV2WTzujRSmR4WJYnBQciA9VE7Z5B/ho/r0i2XPe2KEd2M67fnoJPOHFONa1esv
 AyPjPnCVgIaeDkl+cRiH6u4f9/omeQrM7ZweNifNV7RMNxNYR/H0q9fzsaQP2kfjfT49
 lLRw==
X-Gm-Message-State: AOJu0YxdvlvJrQUpUQ62g59fC4f0aEkbzzS4y8B9pD8RjddJMdJswvvp
 ar5gcZSC7p+Z9t3Y9UlMG7Itu5io1vStbanbdurw/KpupWCGrBOXZgVy6/4ULQ==
X-Gm-Gg: ASbGncsgr9hTdFrQ30Bh5B1LXTDqEQw/4yJUGdvTEzWfgf7J+c5l3mTfmPVvIUqCcay
 K4/nQ7xbl5Ymk6jHtgnVJ0QOv3LRw+wdNtJhhb+SlIQ6Mq/0PU8FeIAItTDIIj4wVJtj57Shp+p
 PQm+R88DnyEJLaFvITStGmt67c9JiVtJ4osyXUgxdM96wfwflStMisd0e7hN4x8L38nuGVaHPw3
 5g3tI2WLyx3Cb44xC10zMEFhLtNXsiFCAKESI4CrREBZXe3l0kxL9br2kAPV1f+Sz4f9yj76CgK
 qgtw1tvgAZXvgDaBmhqxJrMw9wl67fJ1UCnZkyGjp/V252vZ/Q+fA2Is5e0wKH5WfVTBdIhhnuM
 6WFJH+pG+aFTIwNISk+2ORb2jrpL/QeWYwHBUAJ+19kzgFJtDZ+VMzpnYaxYrMKwneluuaPYKzO
 pNvU0wCCAC24ZpPWR66A==
X-Google-Smtp-Source: AGHT+IFAMyLSaqdb4cjXaOncdymhl4NMmAtjSUhWIqV0Erh7rc8euOGuOJRf4utxNqee7ns5WsgvCw==
X-Received: by 2002:a05:600c:1f93:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-47773287cedmr46725565e9.27.1762702871422; 
 Sun, 09 Nov 2025 07:41:11 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24e1:af00:6cff:cfe4:4da7:ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776a278a32sm78918505e9.12.2025.11.09.07.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 07:41:10 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/3] Use amdgpu by default on CIK dGPUs
Date: Sun,  9 Nov 2025 16:41:03 +0100
Message-ID: <20251109154106.43279-1-timur.kristof@gmail.com>
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

Now that analog connector support is merged in DC,
amdgpu has reached feature parity with the old radeon
driver on CIK dedicated GPUs.

This series refactors how the default driver for SI/CIK
is determined, adds a "-1" option for default, and makes
it possible to determine the default depending on the
chip. This way we can make sure to keep using radeon on
those chips that are not at feature parity yet.

As a reminder, CIK dedicated GPUs are the following:
Hawaii (2013~2015): Radeon R9 290 and 390 series
Bonaire (2013~2016): Radeon HD 7790/8870, R7 260/360/450,
RX 455, FirePro W5100, etc. and their mobile variants.

Why?

Compared to the old radeon driver, amdgpu offers better
performance, more display features through DC,
as well as support for Vulkan 1.3 through RADV.
(Note, although the hardware is 10 years old, the R9 290
still appears in the Steam hardware survey for Linux,
albeit at a modest 0.25%.)

What can these GPUs actually do on amdgpu?

Hawaii (eg. R9 390X) can even play modern games such as
Baldur's Gate 3 or Cyberpunk 2077 and gives a decent user
experience considering the age of the hardware.
Bonaire can play games from its era well.

Looking forward to reviews and feedback!

ps. After VCE1 support is merged, I would like to also
enable amdgpu by default on SI dGPUs.

Timur Kristóf (3):
  drm/radeon: Refactor how SI and CIK support is determined
  drm/amdgpu: Refactor how SI and CIK support is determined
  drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 159 ++++++++++++++----------
 drivers/gpu/drm/radeon/radeon_drv.c     |  80 +++++++-----
 2 files changed, 144 insertions(+), 95 deletions(-)

-- 
2.51.1

