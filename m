Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2100DCD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF7E10EBF7;
	Tue, 19 May 2026 10:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V83JlWP1";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0CE10EBF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:26 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso1878685f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186085; x=1779790885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oz0JIcSgLRnpFHsiRgITyuAxwsEfg8ktrxv+35YlX/4=;
 b=V83JlWP1aN/h8O3ypOh/CZ8ljXd8vWaDj4GKFZLKsIoPOtX3Rrn7ZmQEz2uJyGBF8F
 csfYFeIXmk3VZRCOcF4bbR3XcPGKY2JhZNYQgfuUvjbKlr45/7Yx30zZrzvgkOOe8V7f
 1UcDcgF8MNMr8m8YorCoBGgUp+3Cfp9cAKr6pHACCt9oof6wKdc+vxaZxOxrY71SW1Il
 /MlPU+DNJ3+rKgVpG7rqba3mFiO/doAunhvgDIo1zp98ftlt5PsdM0irnWDZgi5uRSik
 Q86yRIKHZqkfTN/NLM6z4rrJi2SYBz2hcRdM/WpiBO5N/an1GBCe2h7xCDCuWJ63GldM
 AGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186085; x=1779790885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oz0JIcSgLRnpFHsiRgITyuAxwsEfg8ktrxv+35YlX/4=;
 b=KpwfUyNP93wlsedlcPciSMSc8Y8i29EEYZ81p1M+bnOLha9Dz2HbJe0qud1pDWhRnq
 DOX0ybGxmcHzg7lFGpYqGLC/ezmdRDQJ0lGnA2YJKtiNhm++zz/vcWRUpNFxQD1Sw+dB
 4DMpp0AT7d299Y6WZgCrN6gyMWH9O+WoPGUZ+HL27MoDxN2DJQUcwY11n2FJmPqTJfdV
 MvFxbsmv/ORpZjtJm9WBxFJ+VjXm0b++xKKJr536K7rdQAFJNxiE2p6zSFCekzJEYXh7
 zNLMHTkZVqj9xIJL++ELw38QlPPXLGvsZUwAY6+ZsGikY+YwDzSTALxoAUOBnQzYiuqZ
 X/hQ==
X-Gm-Message-State: AOJu0YwX3WJ3nJxne2qelyJL7fvMD21bj4A3dzqwQb9sKN9j6nvQBLkE
 NibBfzPfYrpJJA5raXM2N4Z6Aie+hhl6ETt/BqUQaxLK/lzxUF2KY2svMQRKfkRC
X-Gm-Gg: Acq92OEn/o/8AJ7QV7EmXFMjXI4VOGyxB6jGtv9+SPq+izus0y4OFIVvvxK4lROIDtd
 MoBzlt7xAUMuok5HfaAK5um3/nTgVk4egYoir90BeE/FqUpN7lglpS1hlTkyh7oLUlrFl9xX9oi
 VuXYbNC8NwPDMvjgP6uMJAzLyAI8g/QbmTOslpKuqfyPekMhSR51QPjm9obncA0AgQ5bHxXx0Oo
 Obqv6OcnEcNnnJAM+q/EY8rAeb9kdfdSoqZZTvEsuBIj4Tx0rGT1ch0B0I/9I5zH6VLd4Fjp2Wy
 J18TmV1JnZXOkYF3O5ONLymuDfMFoH9e4k4odJPYHoj/NbxkTIcqSChebNN0o+DSidEcs4hqwZS
 WQaUzuLQj0yDeBeg7nCPvg9pzHKDDOrBL8Qw/W1Z8CI1GTP4+0P1MruIErim73CRaI/IVgxQBwe
 BxxQp7CW6nYMFFBLkrHnqSQaZOxi+8iCyynxhrMC0yRBzu2sEPNY5Z2KGCeCjccq4f
X-Received: by 2002:a05:6000:2007:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-45e5c605c2bmr29190162f8f.37.1779186085331; 
 Tue, 19 May 2026 03:21:25 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/14] drm/amd/display: Delete max_clocks_state
Date: Tue, 19 May 2026 12:21:08 +0200
Message-ID: <20260519102118.246466-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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

It's not used by anything anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dm_services_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index cae3ed6056d6..f114ab819afd 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -254,9 +254,6 @@ struct dm_pp_clock_for_voltage_req {
 struct dm_pp_static_clock_info {
 	uint32_t max_sclk_khz;
 	uint32_t max_mclk_khz;
-
-	/* max possible display block clocks state */
-	enum dm_pp_clocks_state max_clocks_state;
 };
 
 struct dtn_min_clk_info {
-- 
2.54.0

