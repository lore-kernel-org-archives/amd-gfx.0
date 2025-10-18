Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1DFCCF9E2
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Oct 2025 08:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AC910E3DF;
	Sat, 18 Oct 2025 08:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="TOPeRnch";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CAD10E08F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 05:44:58 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b553412a19bso1778226a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1760766298; x=1761371098; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6J7CTQVzJTdpSsBpyYymkd2d5jUSp6/gZICW09ccYI=;
 b=TOPeRnchGCTs6F4fgs1EpM0cSCZf7Xmx1bUcCF1LgrCuWPVxV8IDOl7fE+6bRdJBVV
 W8HGLmp2zt0OmgkVbOQj5i5MxaRNhpCHhS/shTsoNxW9J1yRpKNydF4z5e1DnDxac09g
 nhWw+KMhYK1Ug5DotSiC1HS0c90ArX23OYZqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760766298; x=1761371098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z6J7CTQVzJTdpSsBpyYymkd2d5jUSp6/gZICW09ccYI=;
 b=byVsW1V3qa7GK3RkGX6PPc7RQi/AE5NB3v5xPI3q5AY9sOMg6m+kEHaOtt/8ItrMiE
 x8YHl4wTtULcyDWtcsHVFjtWQ+6U1LAY62QG0vZGDbJQmcZrscDMPGAwfMquaNd/nAZY
 /pCUwwpAWKAi3yAznrwu78tjhgRjMxeE6AINqFXxOReuqmBPcgTL+YVla3HkUgbkaJRN
 kN3mnY+pCWtwSuaBWe3M7HqTUKcJ0PpcledcFl0Uyf3mUqvDFHSva1fCcuH23gVseA5G
 izo+CCGgD484HA0WxjtTQZVAuYDHAvwRuUYsV54KOZyCE1r8MrR74z2Pdmq9jByNd0bG
 YxeA==
X-Gm-Message-State: AOJu0Yz0BnL9J/+9J/G066qiWvYY1qGuEK/OoycEewpYAIeTMG+UN2Ld
 h+tv8O+SEzWN+Y5W66rhk6AcVuxIoxbRG1qyylxD5vQNp3rylWJopAgmGSR1OOlaYCs=
X-Gm-Gg: ASbGnct/zw/Dre+BAZOUFZpewjCGCnUmIakIodMm3MlXWLgnQn+sqsuQWkyYPOn9ooq
 QnenqqlJc9cePZgzKPx74xs6xSZox4xvAyos1rw/hKpEHphsW8pAwUhlMxL0Q4FqKF7gzP2+B4B
 0N0AWX8md0k7CHEe0bOta2aD/I+okLvPGlXvOxco0DOw4WPFGbcrpwowIZMaLtTkyIMx+3uZTWk
 O/lEG4tS9wtJGSRu9IlKlJChzN0oH2ISTAC+inxHMDK5yv0KtdyWVNhamUEutTuMW4fvVCwyp+u
 OZidcTDi4olFO9ZlNfO1n7PeMhXobQUY+hvTunM5HXVbCTFT3m3PFe6IBeJxDyjxl3jMFY5Uinz
 ouM4CN0KZLfHML5Hyj0dBZcVPbpbNUYKolD7xoieOYIEdxd3hub6ERXhoNdEQ5Cl8ZWZn9zRdkB
 iqWH3Dq5g0O6ibHuVMZzy43M0aC/bkONnITeNqjvyZeLnAjxeL698=
X-Google-Smtp-Source: AGHT+IHf1Q2t9Le+gs9UNqzy+mF5hSF6zqhbbRPGceW+0BhDH7PF/VO1zXANTCABMZI3hDYV10XUbQ==
X-Received: by 2002:a17:902:f642:b0:28a:5b8b:1f6b with SMTP id
 d9443c01a7336-290c9cbbd49mr82013025ad.21.1760766297848; 
 Fri, 17 Oct 2025 22:44:57 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp.
 [153.222.3.188]) by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 22:44:57 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] drm/radeon: fix up some badness when probe fails
Date: Sat, 18 Oct 2025 14:44:48 +0900
Message-ID: <20251018054451.259432-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 08:50:54 +0000
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

I have been trying to get a Radeon 9250 running on an Amiga 4000[0].

On that setup it fails to find the BIOS and the probe fails which is
expected but then a bunch of WARN_ON()s etc are triggered.

I though maybe this is "m68k problems" so I bought an old x86 board and
there if I have a different primary VGA card the BIOS part of the
probe fails in the same way and the same scary messages[1] are showing
up in the console.

It seems like the probe failure path wasn't tested when some previous
cleaning up happened.

I'll fix the issues with not finding the BIOS if the card wasn't
initialised in the normal x86 way later.

0 - https://lore.kernel.org/lkml/20251007092313.755856-1-daniel@thingy.jp/
1 - https://gist.github.com/fifteenhex/b971bd62c49383a0558395c62c05ce3b

Daniel Palmer (3):
  drm/radeon: Clean up pdev->dev instances in probe
  drm/radeon: Do not kfree() devres managed rdev
  drm/radeon: Remove calls to drm_put_dev()

 drivers/gpu/drm/radeon/radeon_drv.c | 34 ++++++++---------------------
 drivers/gpu/drm/radeon/radeon_kms.c |  1 -
 2 files changed, 9 insertions(+), 26 deletions(-)

-- 
2.51.0

