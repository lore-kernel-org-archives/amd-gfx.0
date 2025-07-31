Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF57C87FD3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505C110E74D;
	Thu, 31 Jul 2025 09:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZikudEu";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14C110E749
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b790dbb112so129474f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955062; x=1754559862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHR8H6qJ13A0quHfiy2FQk3U277tB6v+zMDBaXtjd1s=;
 b=nZikudEuqiwQN9lMOYcq7TxRM8jQe1/ydEaNwTZkEPnkD/aazpPthNaAn33yId9wpX
 uvCt3/CXJPVKDJhc2mQKW1MxvFB45YYXknWAFDmgnYHTbzf5EO6h/ERW1OA2XwksSq7+
 bN69GqR6yZnVwt+OdHCkDL/u7xByCjYtG0sQcQd7g5aCzW0LpkbvAHiEg/34U+PhVNgo
 6oVhEoDeIN9mv9UJwTy8ZJs3Ge1W1epR+QHDfuJxx7w/QXGRoK+xRHr+oz0r1B+UQ/vu
 Xsl1/wXuwYYH4QkK8bjTZFDfVivb6BF588VuiqM4L2q2RXcWbK2YfvaQDX49m6JVcNW8
 GU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955062; x=1754559862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHR8H6qJ13A0quHfiy2FQk3U277tB6v+zMDBaXtjd1s=;
 b=Mti2OS5iSydzr9Q0/nb8ipvtXk0lRlIZHVG7EEcTbiuG7dxSHt1UzTew6UmgUayh1j
 FsgbiS06t8QyPsJtyv2CdxgSfZWQAxb0s2baCuVIpvYfroQhZP/mi6q4xtxyQkc6PURN
 SuG2XgFzWxrxo4uA/IG60SPoMee94Cg44QXTek5l4AD1xq5AX/Webm/L8j9GctPrhb/n
 c9l5IlCmBJUBmeqjq66vKdYOOAH+k/Vm3ZIYptRBgTFg1YVTbULJLMZ9PmDQ6zhnkv4t
 q5R7QeQ9llL3gAygH/7vbS6jhZJ4x63Aq7WadCJlfjFHS3iu6igDsit+R9W/OpE/8Kue
 nVlg==
X-Gm-Message-State: AOJu0YwH9QOeV5jxCo5kp3UcSOxUyXbEs8sjtKDBCcSb/WKJtpUn0q+J
 DnNaCyrQDb3zMHKZ+IyHx+/qCkISSjXM0thaR+otlDib67IbWUj/ta+HFON2MQ==
X-Gm-Gg: ASbGnct6JeNKViGcDB0CXzyqmHnsYDQYUIBLCU3rc+mBE/h5FMs4lw7xSb0W5DDf96h
 yUXOOwArFqMTlxxx91mlNwg3ln3/ir8uN3Km6ukmut0oYOyK19MzxPNIctOSVUyvvOdVkuhaKln
 coNS79r4uJlkXw7YC04oODhrsj1HuCGNlQmT35G4YDExhYwMsB3ojuLIG6dC2/qKqV/83Nkv+NB
 XadMX2wa7HfpzKaxACJc4CHIJA+tPjFN0r9zCaefIDqx1NoyUE2iFslD9PsuZ+vHZ5vbusJBULe
 q6GslDdPQmjjc20QazyzelgEtv32zWNLPUOjw9nKW1H/lAxBxXIT4vPLHiJEHGL1Lf8EiZyJCeK
 a17X+fhqLTVoCKXz0kUJXahVZ0hGTkyqh2xXLdd+6I5hFnsOX/Gzezoy3AkXIuV8By1zibnvRYs
 P9Y+VyNNxwiZHVtOlx4qxTHfLLgSAdYA==
X-Google-Smtp-Source: AGHT+IFfoPoMxPrkwZt3HDfER22QQFavkntei0mD6vJY9yy/n/Bvp6qn3EV2zefFfHc2h9aZsGijpg==
X-Received: by 2002:a5d:588a:0:b0:3a6:d7ec:c701 with SMTP id
 ffacd0b85a97d-3b794ff3501mr5552959f8f.30.1753955062208; 
 Thu, 31 Jul 2025 02:44:22 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/7] drm/amd/display: Fix fractional fb divider in
 set_pixel_clock_v3
Date: Thu, 31 Jul 2025 11:43:52 +0200
Message-ID: <20250731094352.29528-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
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

For later VBIOS versions, the fractional feedback divider is
calculated as the remainder of dividing the feedback divider by
a factor, which is set to 1000000. For reference, see:
- calculate_fb_and_fractional_fb_divider
- calc_pll_max_vco_construct

However, in case of old VBIOS versions that have
set_pixel_clock_v3, they only have 1 byte available for the
fractional feedback divider, and it's expected to be set to the
remainder from dividing the feedback divider by 10.
For reference see the legacy display code:
- amdgpu_pll_compute
- amdgpu_atombios_crtc_program_pll

This commit fixes set_pixel_clock_v3 by dividing the fractional
feedback divider passed to the function by 100000.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 2bcae0643e61..58e88778da7f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -993,7 +993,7 @@ static enum bp_result set_pixel_clock_v3(
 	allocation.sPCLKInput.usFbDiv =
 			cpu_to_le16((uint16_t)bp_params->feedback_divider);
 	allocation.sPCLKInput.ucFracFbDiv =
-			(uint8_t)bp_params->fractional_feedback_divider;
+			(uint8_t)(bp_params->fractional_feedback_divider / 100000);
 	allocation.sPCLKInput.ucPostDiv =
 			(uint8_t)bp_params->pixel_clock_post_divider;
 
-- 
2.50.1

