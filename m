Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C811BCCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 12:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4AC10E5E3;
	Tue, 14 Oct 2025 12:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKcrttqY";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC5410E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:30:46 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b48d8deaef9so790540966b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760373044; x=1760977844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7qvGVqJFxFczgbamjnghg7Ab7JKXWCZEKnWkyxV0YaM=;
 b=XKcrttqY/bxMSjm+NV14rmpmA/MorYWbRNitV/nDMnbHG+Xab7Yl5oHaWOzeT85uYQ
 Kb1vIMS28iDEifj1kZXHhwQbCV65TpwD6b6JZszuIjSKXMgtsnXGi4qwSt1Et7dgjm8j
 65yJgi9hEAPHpE6kVG0TunJmZA3KOYbOqTlSRUR66Tm1Oc5g9N6yPWCIHB/OKzRxWhd0
 knfWEc9WJ4dFaADSXzmksVqGtrd7Vp4IY2RKcdSncs0Cjk1SqOW5gOXJIFqtdzgoVheR
 4G92Nh1ClMwZ/9POjqaTVfsIX/T0/HRNnl52KHP1QGcX/9RsSfuVzm3xN1oR0tyaMtTM
 oRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760373044; x=1760977844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7qvGVqJFxFczgbamjnghg7Ab7JKXWCZEKnWkyxV0YaM=;
 b=t2UnQhEF0+3jvSqK00sdjTIB+nXzZGLBfbYA5EijiNyhyXwRkjEPvHORA4aCZSQUJ0
 KWMoeONJ15v0R7kPAlKsdNLkM+J+8qxlXp+/G6MEycIg/8P3M0KCBHvWBeOyYBFsFodb
 /W3R/2eOURWNyBziVUeHPmHvLiDapvRCawStME0LYpINuTiI+HzCtpzrADfsS6l8dc+9
 J/CxgcI9J+/iFY0Rs499QTtEhFVTP3qlmkJ+/4j+JtT5+RbRuSQIBR9nzMdNApwIF7Vw
 9QSoxVkIde/VMyNgo9DtIqXyAxKL0zaJCq/+sej3ARpwdwQqUUBAIM2qI0ygd+U4itje
 EGuw==
X-Gm-Message-State: AOJu0Yzg9HbQ2p89cG82ZWP8Ybk3bBAYmXnA8+3xxetKXh97gJb47L5j
 C/mob7avmzHiJH79Gx1dACsMF5otsnyKTD76f5MiyNibY0JrtV36nqxtW9ZjyLmR
X-Gm-Gg: ASbGnctLhfuXJPbqn2E9hkuharj1Qax+faC014H/2bbk9YEPw8rdp2Gtl5dHuZn2qil
 KoxC5iwXiK/4R6d6MQcvnS9zzmsF0eu5yldMAwRN0IAlmJpzFR5js9xdMXC8GecnQZwIGJqDa6w
 RdbkKZefQZdX8f2FJf+cbsdht4Z4BAkrnsVJOMpC3IfrRFnl6EaOtSEocn/4M0yMFPn9f6Ys2dJ
 XqoNP0kRgTSwHPBT+XucH6hc30AbwHzkLhuXMd8i0yMil+VtpCRvIwPo6gZZVDrr77kPRor5y+E
 RWw+LtXZ+f2ntIumvnP7bQ6KBBy8NbZYh17SDPb+0vBy5w4hzB1E81yaxDpEMWZk27tL5jPlhfB
 HBhk07LMEhdMxN1NWGc3WK8ywP4Z9CjOPJRHjC4KcztET1bXtu94ObpCgDsfnVUVAPHX4Cl1DBl
 GqMsDMnFCYeZclLg33+DE=
X-Google-Smtp-Source: AGHT+IHODEmylhGzCAPUpTOFw0a3UEbWCPw5rNPAHm8InX0V1A5YN2zfj4hNnnDkZAtGYds+WHd9dw==
X-Received: by 2002:a17:906:c104:b0:b2e:e87e:ef2e with SMTP id
 a640c23a62f3a-b50ac2d593bmr2270486566b.39.1760373044216; 
 Mon, 13 Oct 2025 09:30:44 -0700 (PDT)
Received: from hyron-desktop (host-176-36-64-50.b024.la.net.ua. [176.36.64.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12b9dsm959166066b.45.2025.10.13.09.30.43
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:30:43 -0700 (PDT)
From: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/1] drm/amd/pm: Avoid writing nulls into
 `pp_od_clk_voltage`
Date: Mon, 13 Oct 2025 19:30:41 +0300
Message-ID: <20251013163042.531225-1-ilya.zlobintsev@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Oct 2025 12:36:26 +0000
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

Previously, reading from the `pp_od_clk_voltage` sysfs file would
include lots of null bytes between the sections, e.g.:

$ cat -v /sys/class/drm/card0/device/pp_od_clk_voltage
OD_SCLK:
0: 500Mhz
1: 2514Mhz
OD_MCLK:
0: 97Mhz
1: 1000MHz
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@OD_VDDGFX_OFFSET:
0mV
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@OD_RANGE:
SCLK:     500Mhz       3000Mhz
MCLK:     674Mhz       1075Mhz

The reason for this is that calling `smu_cmn_get_sysfs_buf` aligns the
offset used for `sysfs_emit_at` to the current page boundary, and then
gets returned from the various `print_clk_levels` implementations to be
directly added to the buffer position. Instead, only the relative offset
showing how much was written to the buffer should be returned,
regardless of how it was changed for alignment purposes.

Now, the file is clean without any garbage data:

$ cat -v /sys/class/drm/card0/device/pp_od_clk_voltage
OD_SCLK:
0: 500Mhz
1: 2519Mhz
OD_MCLK:
0: 97Mhz
1: 1000MHz
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
SCLK:     500Mhz       3000Mhz
MCLK:     674Mhz       1075Mhz

Note that I am only able to test this on a 6900XT (SMU11), so the rest of
the changes are untested.

Changes in V2: 
- As per the original patch review, I've added the fix to the rest of
  the devices that use `smu_cmn_get_sysfs_buf` (Navi10, Renior and VanGogh
  and some others were not covered).
- Also, I've previously missed some early returns were still returning
  the incorrect size, they are now fixed as well.

Ilya Zlobintsev (1):
  drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`

 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 15 ++++++++-------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  7 ++++---
 13 files changed, 52 insertions(+), 38 deletions(-)

-- 
2.51.0

