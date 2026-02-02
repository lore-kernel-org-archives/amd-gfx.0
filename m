Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C258E7315A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0727F10E2A3;
	Mon,  2 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WensQg59";
	dkim-atps=neutral
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777E910E43A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:15 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-432da746749so2467022f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031514; x=1770636314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MffpOnJoLRFLvwbE7DTz0LjPGpBihBOHae6sfuMYEAo=;
 b=WensQg59VI1EY4PUaGoUCqNSEEb/opNHdFTry1IPvfs84q3+mjLfWGmjzSfSXdZMWN
 7eX3fd8f0Yj+yngWEGzlmBFCZiFLentEJD76KfSRGORSF3srHBUH0qZzgIaaH4H6DOFF
 1NJfTVBVSUXD/6SjuEIiRt11OpX2okGncf+le3r8NDhjzQat4VU8EVYlIfDbmOOWlm3g
 UHpXAbSAagK/qau6ooDkje5idABKVHAduFi5p/zE4MRHeg+5wWTCcSJXoahOe8n2iMOc
 urxVPp94wE0xanA4FYDzG7OUeUMAwIvaO9zyd41/KkkpPjug+/fg/hjG42kV+JGXdvJ9
 y+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031514; x=1770636314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MffpOnJoLRFLvwbE7DTz0LjPGpBihBOHae6sfuMYEAo=;
 b=ifKjaLCBdzz8rvwTd/5Ms5THs/B0QuKZHJ40FyOuhbBm/ctwdgDkBjDm8cRe/4rUJb
 OSMYmfbuqWTzzE6lt756dYlOlhiMx+1tgQvgXVZ1we/6XGMVgTpKBxItVRdXxbZBATa3
 BRUctnxjJ/dIcKMIpiYlokCnqpG1vEzny3R7u7jtxaWp531MtiEZLtJY9nQF3g3RjtBB
 ucLaj9z9kvQ519teQuhcIFI/VLtdtS0oFE93CVce5EDM2ObOomDwmG8bsIRsAmOvpv5E
 Bc+VhwTPm4XtVm2KdbLZGfqkUJJeWbKBFAyf7hIiXH06ftwJmfRI4yoiaSdAEldUNZbb
 13Dg==
X-Gm-Message-State: AOJu0Yyt/gb22W9THnEOjfd6EEkA3CXAc3CyBhBo/LF5OYAKk/g+cq8r
 RddNtURyO+i/AaAN5GKDyHs8Mtaa3JaesG/w8Kc9++oEcFDBAlm3Mu0c+ybFt5x50RU=
X-Gm-Gg: AZuq6aKrEHKoH+CNJrYjEoZ1IFULJ3tTeSdbNTc25y5ySG9mVbrknkszfskscQPWw7K
 cmfeYLj+JUZ6keM1iCRMJkkoBDEiNIKJGPNv6cvLPZf7K7BcrSvVhDRNtIZHxdJIDsgaTAdNBfM
 eZFvmIwJe4NFF1h23O9dRrJVjk77Faz8S3FSMRqs+pIqF/h/qsKZM4XA5ZpE4oJS9nzFbZW1tnW
 j8vUoPPWnWFEN7LiD59kLnRZbNNnEpVWlfPNPr+6wyv4SW3yb1nGkoSMHreBN60YtuLFTtrDV6V
 gtZ91LmlTmQsEgM8qK+mDhlnMB0thDNffuWXjc74yfLHvezRFIuwbzJAMQN/Q85nPKdDsHPukBU
 2dLPWhR6jVfX9T9p89aOYqTqotW5GcVnybKTDJnsOy1VIePfWAqm7zmofBz/GSbdqqy7+AVmbNV
 d4RPQgimmI543JWlHnAm6KKEY=
X-Received: by 2002:a05:6000:4285:b0:430:f3ab:56a1 with SMTP id
 ffacd0b85a97d-435f3abaa14mr17113926f8f.42.1770031513906; 
 Mon, 02 Feb 2026 03:25:13 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:13 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/8] drm/amd/display: Don't call find_analog_engine() twice
Date: Mon,  2 Feb 2026 12:25:03 +0100
Message-ID: <20260202112508.43000-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
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

The analog engine is already there in the link_analog_engine
variable and assigned to enc_init_data.analog_engine already.

I suspect this was a rebase mistake.

Fixes: 740aa093701c ("drm/amd/display: Pass proper DAC encoder ID to VBIOS")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5fbcf04c6251..847d475ff4a1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -561,7 +561,6 @@ static bool construct_phy(struct dc_link *link,
 	enc_init_data.connector = link->link_id;
 	enc_init_data.channel = get_ddc_line(link);
 	enc_init_data.transmitter = transmitter_from_encoder;
-	enc_init_data.analog_engine = find_analog_engine(link, &enc_init_data.analog_encoder);
 	enc_init_data.encoder = link_encoder;
 	enc_init_data.analog_engine = link_analog_engine;
 	enc_init_data.hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-- 
2.52.0

