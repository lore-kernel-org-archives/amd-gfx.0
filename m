Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B46DCA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C541710E587;
	Mon, 25 Aug 2025 21:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nXGxqMid";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E00910E588
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:58 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso1960846f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158417; x=1756763217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bdnk3/P+Ex7ZyiAshLI0TSazXBQVJE604Q3xCPnm7EU=;
 b=nXGxqMid/10TU7mGsPxvizh/2IYyZqxXHbOEy2Q3NuJ6k1tUB09wQtekpkJOevHTvA
 5VBGP9Sdga8/QkYE+0ppUH1VxR5Yv3sOa5CHMi6vIXJff/e4sNMECRQzn1iS6X3z+/0R
 J2SB719rGXIdz7Uz2kh19djbcT/bI5Teawr8oXGTr7u+v7sa3nmWjvl/ikgRAXT5rNcG
 uA64+nh1FG8ADtXXWBxCn3JAOdNBPWmIcXy5dC6JmBJJFdi48e7yDyCKmxFAaI/a9xnU
 xq9kVkNKIoP2ASXmSt9OlTwiJZtL9ZnRDtqNJRkO9WnPIt8gm8yCgLQ4e+xKx8KSN87x
 0KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158417; x=1756763217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bdnk3/P+Ex7ZyiAshLI0TSazXBQVJE604Q3xCPnm7EU=;
 b=uYgz3B4Dbx9TRiulc+8eq1kWCHmDABR3YrzZizEAXHhjjku0MGlJo5ep4TTU0ZQq4z
 FSMdYpPMB90XrH4YT0w8v/fJ33m1K/PaVOllPX+TynGB4Rh6TKGEgtwkfyUoHHKVhbWT
 s+x8MzILQg4c87YKerKJcL4J6nDdixU6RLRknLDVXzFXYmQrgR4vWDqXLGyEhiLgdvLM
 kTK8S2Y2GIeH69OjbzjfMs//vo1mtkndteD+0yB9ywz9/8eNon1z9Xd5k/krCubZPyUo
 CwvdGQNrrwr5Hx0ecWOLn+wS1tza/Ny0Na1Ij8kZ2Vh5e6VTCbMR1+H2HzwgNXGqRm24
 xyvg==
X-Gm-Message-State: AOJu0Yzu7lWUk26SUZCFkEcok3+7a9VIaFULyDFPEqODfbdfkWulxZG2
 ok7Y1JPPGE4VKvboTqnExtF7Wrqz+JsMWNXE1dR45b/pw+33r/eQI5GrOplm7w==
X-Gm-Gg: ASbGncufXTDA6y1y1mMotbqbxc8VE+NI4x852EOy4WUIqkVBaN5HJe9T8FvRMv8goR2
 GQit6Yo201Mtzvi0p+cYlhP+TXMUyPPZd/DuJMeo1aXXmlsetFBrC6AfjHNoR/4eWpTeol4nPkI
 miaVRkvwpwGKXzdMFuaimBZ3BqS3Sb1AkrAlF+KxV2rVhMhN7tKFhKwgn2vbN3c3FPhHQsLbw2t
 v/cooBcDMgJyqCsEI1cfArrRypfoEYq3YsazRUA3zQ7oPQAg9tGsAq+FDPYXngIuu3gzuO7gY8z
 LqMBcXeW4WwV//Np/z0u38x17YcEFMjAHwxP5s6obQZI3nN5MWdmvwNWpHk1KLHmYIKUV7/ijiD
 Lm8pFG8V9mRThNAaCecY3+gQ1TFArML09UBxo3SmrQPPtCjxtHobp7rFYZBgiV3yk+4E8PsarnT
 +tBGGlf6B8Q6k3PPAzGFg2X/AiKQ==
X-Google-Smtp-Source: AGHT+IESt9QfuzZslWY1K3yNTihseWlXNq2yQQ5jr9Dyh+mNH6uEDS+JzRNf4kcX8Kbr9PXSfABGjA==
X-Received: by 2002:a05:6000:210d:b0:3c9:c3dd:768b with SMTP id
 ffacd0b85a97d-3c9c3dd7932mr2224028f8f.57.1756158416567; 
 Mon, 25 Aug 2025 14:46:56 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:55 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/8] drm/amd/pm: Treat zero vblank time as too short in si_dpm
 (v2)
Date: Mon, 25 Aug 2025 23:46:32 +0200
Message-ID: <20250825214635.621539-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825214635.621539-1-timur.kristof@gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
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

Some parts of the code base expect that MCLK switching is turned
off when the vblank time is set to zero.

According to pp_pm_compute_clocks the non-DC code has issues
with MCLK switching with refresh rates over 120 Hz.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index db46fc0817a7..1e2aeea0b552 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3082,8 +3082,8 @@ static bool si_dpm_vblank_too_short(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 vblank_time = amdgpu_dpm_get_vblank_time(adev);
-	/* we never hit the non-gddr5 limit so disable it */
-	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
+	/* we never hit the non-gddr5 limit so disable it (but treat 0 as too short) */
+	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 1;
 
 	if (vblank_time < switch_limit)
 		return true;
-- 
2.50.1

