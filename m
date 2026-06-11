Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B6BCD98DA
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6E410F2EA;
	Fri, 12 Jun 2026 07:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="GuJyaSky";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3390A10E28C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 19:51:21 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-59d6e44e5c8so107708e0c.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207481; x=1781812281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AqexdJuQhvZ4SiuJdYKxfTsj0ya3VX999FM6ttvHo3w=;
 b=GuJyaSky66coFT+f6bwMNiSkpxaqD4zQ6+JlujatE/JHORU4xVmaaZgbcWrTq0+hsP
 0GtHci1Tqu28fm8M4y3/TNFZrasZQ/9RYny05nAtTX1gqqUklcQqpOLi9OY278iY9sta
 D2KAh/AabOc5ox0w3EkzitEsweqZRht3/19TYGzBZD9TTqvxpOeM1Ts4oD7c95zo64kp
 InS7QLxDF+2cY+L/yWx22JrKsYq+S955q9ux+U+3o/lzknIYrqL9DvQIXg/dM+dLqe+e
 ieKI/7rUoaauKGSf8O9BvE495Vb0KacT1gMmByH1cUmGmLX9OxbBo2cxZ/By6HSvRiPv
 ojfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207481; x=1781812281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqexdJuQhvZ4SiuJdYKxfTsj0ya3VX999FM6ttvHo3w=;
 b=FOL2JwMsvy3oFcCHt6w4gqAhrLp50NZ9Pg+DaMdCdK7CrI+sWFpoe4L277l/U1EipC
 /WmghF7vl8BOs537Kp4lXRz6SiEAGDBdGEQrbw3mLtPv3S6qFecbLvAYoGPvMjTIAUht
 3FutMoRczVscNKjp5wfZrxHMAV42ONljH4yNTOLri4V8qYFvvVVKsTOZWUXZL7gbdwut
 FZyXRSx2UCh7B9EhnCM7W5qFCjWWHpcjuupRMy1FuOsHrJ+K33lMXIPC25dsamRtT+sL
 /XkoJebrQSsfiPHw1genOnyi4oesRkaaKBPceBkug8uz8v7drv5MqAoi0mLvRhbczpCu
 GRfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X4o+adPenFHsCETQFOIDTtMYXdgdmQHBO/JKZuNJ8bz68n0l3ycRSI6UsLZs75rJrHJn+zFi1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzELUQhQodQV9PZ7v9/7SaI3ALbg2R5eifbLfuvC3wKiLgdvZ2l
 ea4SCUVUYkIm0yWbw99xdr0W0n11nsCDGlNlGYrD16hIkQMKqCv6q44+bOEQMesuu4o=
X-Gm-Gg: Acq92OGdaAG3G8+N5U56xOktVWbWdMQuTPAAd2LOUsK6g6wqc9QTgmRvyBB1IA7NYFn
 Ijg3rnmeePdJHpB2y16+Az+EjEOHSEwY6Il6uaZERG8W096gC0nNDKPEnfPsGmXvo4TzCz6ep9N
 gXaiIlU5gLimn59zG6Qg1RzW02fR5ERrxmZVk9Wr8bL0Hzndd9CG0dpZDDyxR988quUxZgk2VkQ
 9i+oizqhPahixiNQbR6oY2LX4bfwj0UwQNIGm5UDIiM8K3DzqvLEGzpX4pqgocd+V7XPSs15v0h
 ZpztpfRv+hVeh9x0KNZxHqMBuB2lW2qyhSADp904rnAkzcyQuRd0rckgAJ1uO3ZRe+ySi2pgup/
 cEfgB1G4Fz4ja+VqIifYVdxXmezSZo1AiQeXhdM58s76wayX7PSZff7oB0F9rdEmNPJr1Dmc8+8
 qjca0SI0mLy09Fhf+GRDl6zL5srFwZ42sKZZ314nKP0eb4DMEi7WCFqO5rgegjWYS8ILBemVfBr
 LcpQbL73TxjejjOH7qVDHLFGISdcAbcR7kCQLilkn6SggdSbA==
X-Received: by 2002:a05:6122:2485:b0:56f:6b46:28be with SMTP id
 71dfb90a1353d-5bb00d816ffmr2885899e0c.8.1781207480684; 
 Thu, 11 Jun 2026 12:51:20 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:51:20 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 0/9] drm/amd/display: convert GPIO translation logic to
 lookup tables
Date: Thu, 11 Jun 2026 16:49:00 -0300
Message-ID: <20260611195026.25125-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:46:58 +0000
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

This series converts the GPIO HW translation logic used by
multiple DCN generations from large switch statements to
static lookup tables with shared helper functions.

The new implementation reduces duplicated translation logic
across generations and makes the GPIO mappings easier to
maintain and extend.

The series introduces generic GPIO translation helpers first,
followed by per-generation conversions.

The following generations were converted:

  - dcn10
  - dcn20
  - dcn21
  - dcn30
  - dcn315
  - dcn32
  - dcn401
  - dcn42

The dce60, dce80, dce110 and dce120 implementations were
left unchanged for now.

dce60 and dce80 contain special switch-case handling paths
that currently do not map cleanly to the new table-based
representation, so they were intentionally excluded from
this refactor.

No functional changes intended.

v1 resend:

No changes since original submission.

Automated review:
https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-overall-20260512190019.228440-1-guilherme.bozi@usp.br/

Guilherme Ivo Bozi (9):
  drm/amd/display: add GPIO HW translation helpers
  drm/amd/display: convert dcn10 GPIO translation to lookup tables
  drm/amd/display: convert dcn20 GPIO translation to lookup tables
  drm/amd/display: convert dcn21 GPIO translation to lookup tables
  drm/amd/display: convert dcn30 GPIO translation to lookup tables
  drm/amd/display: convert dcn315 GPIO translation to lookup tables
  drm/amd/display: convert dcn32 GPIO translation to lookup tables
  drm/amd/display: convert dcn401 GPIO translation to lookup tables
  drm/amd/display: convert dcn42 GPIO translation to lookup tables

 .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
 .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
 .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
 .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
 .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
 .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
 .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
 .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
 .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
 .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
 .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
 11 files changed, 1274 insertions(+), 2035 deletions(-)

-- 
2.47.3

