Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0414E7E358
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC3F10F480;
	Fri,  3 Apr 2026 09:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATwxNbYL";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CE410E4EE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 08:22:25 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a10d130b37so1556981e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775204544; x=1775809344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iX2gAg3Cvwni3EvZpLj5YxG0NykzLvzc2v6h1lU8a+w=;
 b=ATwxNbYLOgTADG1UFmDs6slDzP46h9MdfxSgavLA4us275F09WJgKcCheqJUaohR3s
 UInlOigRAHdis8KS9ClPvVqCwGNyHkAP6IKNbfRbKPC8aJlH14NTwysxnoY/zgwVXiDi
 sUxXa2IglfD6PYeW9I+yl4ewJnsxzRgmfPpy4fAh+RniKi7wNQh2SvtR7lLlFTPhjSsZ
 /CHSNddeevkR1v/9jW5sp8tdJrbeFJCp7p68ahixRjr1e8SWYrDga4xh6Kg36P53pJT5
 KG7aaDBvWCpgPLSqFMRYGsxnrpwItpe8yiMGGQXm4Rv0fYRxaD3nwXKlPGhSpSu5madf
 YFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775204544; x=1775809344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iX2gAg3Cvwni3EvZpLj5YxG0NykzLvzc2v6h1lU8a+w=;
 b=rIXq1yD/HYuy+CXUM4flAdBSZho5mvkuV7ZmEJjoROVIhQEhp1LdKHZH4rWgWui1v0
 TaRIGPnrJCZcvgz+rbeyADT4EOLBKTLBHXFTQpfrdMeEnjDnXJqQcJmLPV6QCXwO07cO
 0GjpR+DKMRI1GPQ5k/fEIAXO6VMT0aE7w+i4bcjQCuTKDsFEqjft+VAprBn7GkuG02Xu
 3NF4Bp1BGYZ3527uHE3h+s5KHLFkiCKVgOtZy4TZ6X0DbgU0b4JByaH93SC4wfTEQXFr
 1JYp6h0mfaiottdg+nL+RX7aOLsGFKPhO7TSeTVi+5Ng1oobgXBB/BoKwuXyfIadW8iN
 uuZQ==
X-Gm-Message-State: AOJu0YxgrnZPwuujYTT4JuCvPlAN/8E1DHfKgkM5Tjd/QqQMwbbTXdDt
 nAJ0Expoa5Q2OXOTUMj63dSqDUEIWU+QA8JMSvqj4U69maYQhtNUo//V
X-Gm-Gg: AeBDiet38ACqKjc2LxfYSSMynGiVKcg/Id+iNmWoWPpwwLg2dXjh6tDbZHWYh1I2AtB
 zE4l1nIXZOE3/bloiJhACck8MBgtPKo3VLB5htXLB5VmSj9OEnAdW10ZdImuJ6ONbndRoMjEzFC
 NoDtyiczpoUvRCJp6bSDIfmUyPu+x6JGBzHHuOrJ+PTYKIvg8hZkYbGOtzlGhhNvddqLC/gMt+I
 lE+biWLLD18Ay1NK/nuch3qzTL7N8lhe9e4WLa6zQycxXqw6QDu6kqS691k42X2gfhAISfgfrR6
 g9ZR/+708DzbPv1nYfSXsdQW1jSA6nYFKmIvMKwqWMUxlw9XpwxO2C8cpySHNx5cNq4IzBH4DET
 c1T/gXiweJFCnVvg1tJG0kH9mX15/MAuLf/1WVUTDuBqo70ZxRBsLkyd3ubTN6UtE9HW5eyPocv
 yWq9WMBUXCXNK0EFAWDR9uFRa6ia/97esbGzxN0UVB1gJPTRk8gK/S
X-Received: by 2002:a05:6512:3d9e:b0:5a2:c0b8:271 with SMTP id
 2adb3069b0e04-5a2c8d97952mr1848851e87.17.1775204543248; 
 Fri, 03 Apr 2026 01:22:23 -0700 (PDT)
Received: from localhost (94.191.136.33.mobile.tre.se. [94.191.136.33])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ccca2dsm1274752e87.60.2026.04.03.01.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 01:22:22 -0700 (PDT)
From: Linus Probert <linus.probert@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linus Probert <linus.probert@gmail.com>
Subject: [PATCH 0/2] drm/amd/display: Replace NUM_ELEMENTS -> ARRAY_SIZE
Date: Fri,  3 Apr 2026 10:22:05 +0200
Message-ID: <20260403082207.1533450-1-linus.probert@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 09:29:14 +0000
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

There's a coccinelle script which attempts to replace cases where sizeof
array is divided by sizeof an element. Most of these occurences have
been handled but a few remained in this driver in the shape of the
NUM_ELEMENTS macro.

In two cases the NUM_ELEMENTS macro has been removed and its use has
been replaced by ARRAY_SIZE. (1)
In 4 files the NUM_ELEMENTS macro existed but was never used so it has
just been removed. (2)

I couldn't trace why these cases hadn't been picked up by the coccinelle
check. Just NAK this if there's a reason for NUM_ELEMENTS to be kept as
is. Thanks.

Linus Probert (2):
  drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE
  drm/amd/display: Remove unused NUM_ELEMENTS macros

 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c     | 5 +++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c     | 6 +++---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 3 ---
 drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c      | 2 --
 drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c      | 4 ----
 6 files changed, 6 insertions(+), 17 deletions(-)

-- 
2.53.0

