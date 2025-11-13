Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787CFCD8CA7
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 16:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D4110E8CF;
	Thu, 13 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qt0+NBNu";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360A610E8CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 16:33:56 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47754e9cc7fso6540365e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763051635; x=1763656435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czvP83KyQBdRPVlTbn9FR9+q5Og5rOHrCB4Ws8Vsvr8=;
 b=Qt0+NBNuKqLfh50B10Hi6hZ9nGJFzKj53vLIYm7uZma2L5TNgbb0oKFtR7tfIcdypb
 O/cykke2dZt67F5RRBzFhauNmvYVs3/RMqSN9Pi2f5xEgoqf75tUWTWRQ3w7ITvrx+Zz
 UJSThg2QTJUW8N2h6LM69/yjsG/BR6/Z1pwVqV4FCKs8cSF8XlnlDViAfbdURpo/SbZ2
 E+xQlLeR2xzUbFLCuvUumQC0rOcaWRatyvXKm1KRrKMBeQj01a7r7fU094o7lEriJsYQ
 X9Sf5Eiq5rtroVjk/bvZafjhz9mnP0YyQ0fm4mgfb7aB+l87E63JJarnno7nKugNFcSe
 JDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051635; x=1763656435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=czvP83KyQBdRPVlTbn9FR9+q5Og5rOHrCB4Ws8Vsvr8=;
 b=KVg6mS2RjEpE+A4WugQ41wa7qOKljwvcm0rcMow8mODGC2IlCUtCL924SVCyi967uU
 8Z1FWjeAwkr2/ZtKzecv5HzVhG5hs6p6bpvnXvtfDRvaenVVW6eYf29VrydgL3jgVtvh
 epeuu2vkGi26uRqRNP6FCPiK0mQVK0Wu4clfY/uOYUnv6hy36Ny/LZsErtS2bS7wwuoG
 hZ53wuMit9GDOiVfGC94J6scISXyddvCTqBlivw8gIB4wL6WAYrMG6aOdt3tPmfKQSJ8
 4rcDVRaTc4a3D4EhxOc2G2QWHXCxt+iGwfl160kOW88aFT+JWpZYlX38/YWeIvxpCE+y
 GKeg==
X-Gm-Message-State: AOJu0YyLgVo7KGINmioKekiwdHNweETvNbb9WmivxafOnb2EzAEy6Mfb
 rTC/OpwzekLCS5Y9XB23VIyUEw64LqJkr+/4jDX/gB/muxEAMmpxXsqpJ1UM6Q==
X-Gm-Gg: ASbGnctCIUyOGFuMkHNSKXGfWSBjwbOgNHvZNbLxoCENEeUcrITdk8+Ho5JgkSNsvPl
 q3BMp+fcjS9dyw0hAzn6ezF3r6jHjrbBG8sy8ZvEy2LToRMmyHiJ9/mRAUF9l1Z49zK7ODdnl9l
 DpPgDYdBoVkTHv6i2NsRFw3ofYViwe6fG062dCytPZegTisRoFyoXk7CalHK5SgRKyW5+kRGi/u
 s3U3t4EF2qZ2smLsVRxJD0lJI8qed020Ed9hl4t6+/dOu4X78yDxhqxYEGoC12P/cQ3ee/FpKou
 ZF0OuB1eF3UX06p7UjAqeegpGKq/G8KedDalF0YaAtIlEj8MMYXE1wxydNuuCvtNpWB74/1cLJM
 kSsW93xvsKkooXy+snSDB6uVS7UlM6y+WwbAnkXXRcdpGybkOdeUqQzB2hLznoORf85FynROJ8b
 SxX1DttX3i6Lk9oa0cxCG6vxY7X8hJFz6on3Bj1mdnBGBG4+CBgFGX8ncshlzpHd8iGkgSF//d6
 boCmkv5wZCeemb3Uqc=
X-Google-Smtp-Source: AGHT+IHtZxsMghPViJNE4viMgcdCsozFyZpGKeYx8b0r2pV2FbLsT/Ld9zVNVJDs9cnkzUiuhIFhwg==
X-Received: by 2002:a05:600c:4f93:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4778fe588a9mr1085925e9.10.1763051634426; 
 Thu, 13 Nov 2025 08:33:54 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm76376335e9.13.2025.11.13.08.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:33:54 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com,
 Yu.Wang4@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Cleanup early return in construct_phy
Date: Thu, 13 Nov 2025 17:33:47 +0100
Message-ID: <20251113163348.137315-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113163348.137315-1-timur.kristof@gmail.com>
References: <20251113163348.137315-1-timur.kristof@gmail.com>
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

Match pre-existing patterns in the DC code base.
Instead of returning early from the construct_phy() function,
add a label at the end and use goto to jump there.
Additionally, respect the DC logger and let it log the function
even when it returns early.

Suggested-by: Ray Wu <Ray.Wu@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 7989baf3843c..b177069e4807 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -529,16 +529,16 @@ static bool construct_phy(struct dc_link *link,
 	enc_init_data.transmitter = translate_encoder_to_transmitter(enc_init_data.encoder);
 	enc_init_data.analog_engine = find_analog_engine(link);
 
-	if (!transmitter_supported(enc_init_data.transmitter) &&
-		!analog_engine_supported(enc_init_data.analog_engine)) {
-		DC_LOG_WARNING("link_id %d has unsupported encoder\n", link->link_id.id);
-		return false;
-	}
-
 	link->ep_type = DISPLAY_ENDPOINT_PHY;
 
 	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
 
+	if (!transmitter_supported(enc_init_data.transmitter) &&
+	    !analog_engine_supported(enc_init_data.analog_engine)) {
+		DC_LOG_WARNING("link_id %d has unsupported encoder\n", link->link_id.id);
+		goto unsupported_fail;
+	}
+
 	if (bios->funcs->get_disp_connector_caps_info) {
 		bios->funcs->get_disp_connector_caps_info(bios, link->link_id, &disp_connect_caps_info);
 		link->is_internal_display = disp_connect_caps_info.INTERNAL_DISPLAY;
@@ -805,6 +805,7 @@ static bool construct_phy(struct dc_link *link,
 		link->hpd_gpio = NULL;
 	}
 
+unsupported_fail:
 	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	return false;
 }
-- 
2.51.1

