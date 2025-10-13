Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDBACCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 06:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A49A882D0;
	Mon, 13 Oct 2025 06:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHpUhuya";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E56910E38A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:06:49 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-639e1e8c8c8so7310687a12.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760335608; x=1760940408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JHA6KwZbQiiAgTRoW1HYymYTZA9lMYrF5vKG1BYuqdI=;
 b=jHpUhuyao2Kgw3Dms+HT/STad241FcussMIr4OnhcapQFFJoa9eG6NBdoY5TjoOJcV
 fijcdrEevW8YBshtSnsItRlVtBdZzsk1WThYYb/9/+od8Sck9l98app9kkY0/+RkHTn0
 qqsSDqFsR4MCoGhk3kmbzYdbU02MfpQfli1noX5YrkMEaw2ZLqjwKtRl7kXA8zIwlKLq
 oZdkARfoML5s2arjKQhVCzwxoAS8SztwOFvMYbe/FCOssfZgxm04M9wXpk/BWKFBF1zj
 Fbbs/NiYDBaL05I5HcMtrb+aNEhW+YvUWjZj5ncNHyo7zvOQAmLrnIv4bV4AMkiBYXmV
 Wa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760335608; x=1760940408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JHA6KwZbQiiAgTRoW1HYymYTZA9lMYrF5vKG1BYuqdI=;
 b=cGRc1HNxrZPSr8GEJaAosergbIgbHv5qrNvzKqXwk0m0qOtoieW4FIU19OgaVuFv+U
 8IPgasavCjFZ21oJSiYEDGfpg6n+/ZPUPieoKOAcvn4qNzf0+uN7NxxxWJ7eix7CeLIL
 H0r8xdW0ZR20Qp/IIjPJ2xHYcoL3llN8fGSDKyUbzfyGfWzQ2pX6SpddsA7y2krG+qEu
 uKsMUP0hXBSjaMgM8bx56VMcZWZDIFLCqnbm/4NJpKA/0CqLWD+uCW68LOSKUmvQhhKB
 lzOedNKebmHwwgtJmolaCIFRw8E/7ZvASjo0gtrMtj9Qpv/HS4iYRvhDICwwF2UuaUEt
 OZKw==
X-Gm-Message-State: AOJu0YwfpEOXwu5JdYkrfoFFGeMHijaFIur9/CGoRyDaDxcqLNnX8XUW
 TcF88uPHcf4JCwojaDL91oVUlcJHZTfRbz7S3T1h+X5CPlz+4JEZxiUz7oCLWQ==
X-Gm-Gg: ASbGncsGrDFW0Jsw/4IApcLKD740C7TvkK1KZ33r7pitOPH2MAoZgB9D93RewiDYqk1
 O6vqY8vxZiiIYnKZGY9Dn3GRjwLfklYBGMhJjdDaf7ET4B4mVwcBbcs8m8snmkhp3WQgaulSkAQ
 aH2+X4vvzoTtiY3Ivy4xXojeEXu5Cn9WiAiyo6k4FU8J2ZnjDWNMuRj9aq0kUNKIFXCpyFwKvGN
 6e2gFAqM+BQo99yL+WDD1skB1YcO2ObT4gch9zQSpdfVshZBlDO1lQYWNC2QZbiYta921n9o7kw
 Z6ik95KGbN/DLcMIiDpUe/PMhTp8j4RsGrD+YRSuQlmhPCQ0fZef6Kep3/KztxTzTjx8ZMfaWlG
 Vol33ZJrp2ro1mVJFMNzHy5HkhwB4T5XRMHq8PClePAAd6Yk6LkCEKqctKEk+fKg8irq5s414q6
 QRpyhTAyxECrZgGZHNkULdPpxLoU5LHyLkOmolT8dOdkNx6A==
X-Google-Smtp-Source: AGHT+IFfKoGhq3hegjhBV+LQsU9gcUUWXYFKHv0y2HqH2chTUZXQ7w9auu0+3eNtiuZph5+4+1Ck5A==
X-Received: by 2002:a05:6402:1453:b0:639:fefb:996a with SMTP id
 4fb4d7f45d1cf-639fefc0db9mr13206974a12.12.1760335607871; 
 Sun, 12 Oct 2025 23:06:47 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24F25600946431E697F050A9.dsl.pool.telekom.hu.
 [2001:4c4e:24f2:5600:9464:31e6:97f0:50a9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c133f58sm8209921a12.30.2025.10.12.23.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 23:06:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Fix CIK shutdown temperature
Date: Mon, 13 Oct 2025 08:06:42 +0200
Message-ID: <20251013060642.21269-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Remove extra multiplication.

CIK GPUs such as Hawaii appear to use PP_TABLE_V0 in which case
the shutdown temperature is hardcoded in smu7_init_dpm_defaults
and is already multiplied by 1000. The value was mistakenly
multiplied another time by smu7_get_thermal_temperature_range.

Fixes: 4ba082572a42 ("drm/amd/powerplay: export the thermal ranges of VI asics (V2)")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1676
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 8da882c51856..9b28c0728269 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5444,8 +5444,7 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = table_info->cac_dtp_table->usSoftwareShutdownTemp *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	else if (hwmgr->pp_table_version == PP_TABLE_V0)
-		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		thermal_data->max = data->thermal_temp_setting.temperature_shutdown;
 
 	thermal_data->sw_ctf_threshold = thermal_data->max;
 
-- 
2.51.0

