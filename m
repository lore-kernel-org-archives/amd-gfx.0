Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF67C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 19:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510AF10E03C;
	Wed,  6 Apr 2022 19:49:35 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C886010E03C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 19:49:33 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id s13so4687975ljd.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Apr 2022 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cZsnacPeXM2ziOyllFOyfWp9IIBmXVWr1N4+JupOOWg=;
 b=U6MHyMiq2x05o9FgNmqFL3C68J7Jr0/Z/bVhBZN2DJkMTF/ppds9Ajot9gHNqJxsuU
 HtXx1Qrl5DxpwgCHSm3FRbu/HsbR0ZHGrDytgoWEOhADZBMPl7RM8h8v6fDNDm6egmxa
 k1eSbcxVRvT9UWcYzQE0FQZQV4SW9oEnb1VrdcrF6vwOj58185UkkHl3rhdhbG1Y+9rk
 ddS6m20dmB1RGDwYPbrRWYZi/img0tiVz9GXlk3gyrf8e/i32a7BrelA8N8uKJIB+UiB
 6VMIis98RhXfTXuVS52OP9MkL3tRCue97vwcvJTVZgptkVvO8AwoxIHUH1ltXtnKHIXb
 fqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cZsnacPeXM2ziOyllFOyfWp9IIBmXVWr1N4+JupOOWg=;
 b=J9EfYtcnBJ2oavqpEaq9z6O2zELqlmb9NHVuawHaKpR2XB3TFqQblIsgdNl5HjcITX
 zRPg8xr497OR7NnuD0/KciiHWw1qHTjTc/UJmbIxdxx6AJy7BbLqOEfCUUjALrldTBRx
 TylvmdnAOoEM9oi7DTxKwyu1YzESOxv8KW6H06fERsfVV+wIZgOsuwqMjpWqXcILD+WW
 wkawwmxHUtoFziY3eYIP3SXGLh6PZVHB+2mSeI8DJooMfuYv+6HJpwlXZ+sR3ARBH1uS
 LBIR8U5rDGc/OWIw2KtJ/mdIuN8JyDHQvzJIP6YoVUWh+rl3FpO5Q039WwqPFxd4Wy8O
 J91g==
X-Gm-Message-State: AOAM533yixIumrIQqsyskbpE1rGPnV5JhNKgVZC0402HTHVRLyY9pBdV
 bjgc+jRBORFrnBLV7olVuro=
X-Google-Smtp-Source: ABdhPJyPhgKyFQ0vGtJxxqinfC1ii/3O+sDwGiH+Gf+TNgf4GVDqqyf8PjxymgUmp2FB+IBZ/DA9TQ==
X-Received: by 2002:a05:651c:1413:b0:249:266f:50fd with SMTP id
 u19-20020a05651c141300b00249266f50fdmr6251557lje.325.1649274571948; 
 Wed, 06 Apr 2022 12:49:31 -0700 (PDT)
Received: from desowin-mbp.lan (078088109026.wroclaw.vectranet.pl.
 [78.88.109.26]) by smtp.googlemail.com with ESMTPSA id
 i2-20020a196d02000000b004488dae6d45sm1931963lfc.52.2022.04.06.12.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 12:49:31 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Mo=C5=84?= <desowin@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Enable gfxoff quirk on MacBook Pro
Date: Wed,  6 Apr 2022 21:49:21 +0200
Message-Id: <20220406194921.2459-1-desowin@gmail.com>
X-Mailer: git-send-email 2.35.1
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Tomasz=20Mo=C5=84?= <desowin@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enabling gfxoff quirk results in perfectly usable graphical user
interface on MacBook Pro (15-inch, 2019) with Radeon Pro Vega 20 4 GB.

Without the quirk, X server is completely unusable as every few seconds
there is gpu reset due to ring gfx timeout.

Signed-off-by: Tomasz Moń <desowin@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 46d4bf27ebbb..b8cfcc6b1125 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1205,6 +1205,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
 	/* GFXOFF is unstable on C6 parts with a VBIOS 113-RAVEN-114 */
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
+	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
+	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.35.1

