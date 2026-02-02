Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D7E73158
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153FF10E439;
	Mon,  2 Feb 2026 11:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmTBCios";
	dkim-atps=neutral
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D524E10E433
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:13 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso17878305e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031512; x=1770636312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCIhQnWWCvsVWTXWPIlq+JEo1QqAi9qd0fgT7pNht60=;
 b=lmTBCioskzJuKgvwlBrxcFVOOb2zyGIk0eIcamANMoS6DIsnPifzxExRknNdlBbuXs
 BsbkJne3wW3ADIOmF4NZzqgjs4soD0gQir7ytFCXhGklUcc3+SMkMZLNuk10Cuc0RzBc
 wjaWEoVT6okO53e6UxjyD22o7RfrzAiHSya/nhqG8ORR7yTafvTKl3I/32mv3nxlD27m
 7adQih+Pbbu4oIAB4yhPzijTBpCysKfPUOexgEZdevwPrDmxql8QUDp0OLxSSTF7pnmf
 Mq4gDs8GQqi0qdBzfjUOj0fQV7JfIOAGxvYu3lsTdmxGqlkHm8rJeZSaHRD+vrTglmOo
 i8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031512; x=1770636312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCIhQnWWCvsVWTXWPIlq+JEo1QqAi9qd0fgT7pNht60=;
 b=RctCasLpXqePitFrL233ZPOWTolp37TZSwSMwgyAq8NGG4YQLlzbu99VBQGmRGFOJs
 pdkv7ycWIsVB8eOKM8+ilc4kAYjaLta2wgAjsG7bg/m8q5CED82KCPXYFhH1kfOswVzA
 mUk77wPMoZ04gHECZQwboTwtmX56NHG61UiPJlc/TGS9dKpHiEIcKRR6Igl5PsXKXq/Z
 nqMIXtd8K1FUxEU6mNowk8UMG6y1OcFIQHFH+Eqs4ovUPsUBjxt12n0Rul+EPzAZvOBo
 EiUynM6rbXwJnsapXcW3p1bQmh1DeQ5EwN261RBkEQlFxk2mHu7BjfsBEzeequtunZh/
 vySg==
X-Gm-Message-State: AOJu0Yx3NPSLi8ybPWs0oWi2yPQQrn0KNi0DDHmGlK9cin4W5XgJkSke
 kxgVkJhmKtDG7r2qLSpuXPLkpdXYDcDoiHoID9QxjFjd9HAaKH0KEaWkSoO1ZiSnf1Y=
X-Gm-Gg: AZuq6aLqfsML1IqPsFlu3/AMZy8KB+Cf1fbaFG/y/TBPS9JIBbyXPWugIFoUehpy4ew
 t/nkJrxCxcE8tWclndZs7koox6OVAmVY0R1QFievTRhMZD/NcSZFwXNDrHLCHQ8UGdKTUyogsre
 naXWyGPTk4IIx+82U64LmZHfTpWPnFAdYAtH67BcVI2ruvpem6B0XWjFmKskWthYT+IYFzKoE4v
 snoDZCnbQew1qOSoaqbOOU6c9NVm9lZNHxFEaTe7CXpEhaJ9d7C5THTGt/JLvjMk6S6F0mtTMBp
 rkRbQwQTWiZaiNOyFx0ojteTMdcQLraTehdYmJm7iPbX2awJC43yM5fx0VpN8+2ZTpo0m9g6Ilj
 TuOn3pAqQ/jfRDerCTvX49U+16ObdoVvhcQE4ldxj3mRjErGbrOdRkcMmr6JA6+a1vogjgkIziD
 a+XlIgkTrON47A
X-Received: by 2002:a05:600c:19d2:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-482db21399emr125832105e9.0.1770031512076; 
 Mon, 02 Feb 2026 03:25:12 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:11 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/8] drm/amd/display: Use DCE 6 link encoder for DCE 6 analog
 connectors
Date: Mon,  2 Feb 2026 12:25:01 +0100
Message-ID: <20260202112508.43000-2-timur.kristof@gmail.com>
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

DCE 6 should use the DCE 6 specific link encoder.
This was a copy paste mistake.

Fixes: 0fbe321a93ce ("drm/amd/display: Implement DCE analog link encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index f0152933bee2..068fb1df8d88 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -734,7 +734,7 @@ static struct link_encoder *dce60_link_encoder_create(
 		return NULL;
 
 	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
-		dce110_link_encoder_construct(enc110,
+		dce60_link_encoder_construct(enc110,
 			enc_init_data,
 			&link_enc_feature,
 			&link_enc_regs[ENGINE_ID_DACA],
-- 
2.52.0

