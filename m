Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC976E73156
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691B010E458;
	Mon,  2 Feb 2026 11:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANc69jcD";
	dkim-atps=neutral
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E0810E454
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:20 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-43596062728so3294508f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031518; x=1770636318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP/TvqKP05WSc/r+ew7gDd6ei07sTs/GTog3TcYLIOI=;
 b=ANc69jcD5g66gU92rBxTl9ndxshsuJPl/aeyqT742GB+ICWu+g2zDnA0nQEi9WdYg7
 Pj37qrK56jCTJ93F+HvdFPw+kdcj0EPK58jMxMzL+lZYOBwT/EUX4ejJth2R13zpNC1x
 iXmb4QD++UoI2qy7TRnZXxUA27Ik8THMcDvlUXnEYy+yGhFvI0vXp06kjq2mSMFEjjx5
 B2oLVQ8DoBPvljWgi2CKbn604/v8ZA5KTofsCTXSc/O56IAr7KDcZrjzepLdFw56GqVo
 hhLZvSAAF9aWskQcQ0nVSJfpz/HiqeOOUf3tEZQPczyDuz5ewfUZ71KVPV54G3FxDHdh
 X8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031518; x=1770636318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YP/TvqKP05WSc/r+ew7gDd6ei07sTs/GTog3TcYLIOI=;
 b=r6F7rR/gQcSDBJY/dIAnhTFiX4v/UE44/LOiYNgDgrSps9JssZveg9eQ+8wSMhIqkA
 T1P9y4J/ceAfQ7wzAr7IdkOjNVCQQd4jJgQIgv0udiPftplg3p2RTabNrsjd9xv8CYck
 xvu/czu6Jy1Of8oVBMU02SIM9O64aA3qgXbRjzrjDKpqp/68hZUUEhjf01n+n5zHNUIY
 tPUcvdVhI9X2Ecx7We9jsOrTPoKtGw3XkIJ0yxFXQeAVW5bJAbg8zKNQgPz29bnLlkUs
 Vhd7oTFUnlGlo/GuQc/7A+eqF3E5CaCArRnnYo+GbusWwwTIPGGYMjhsNSMK5PbhWyAq
 xzdQ==
X-Gm-Message-State: AOJu0Yz2rxSgZKDL8kEGyfJuD9/GtHWlW4GZao9q4LGwVgz3AnLueA2s
 bMpIuv8ZPhoSh8s1RL21G1WtI8ULoFg9tYqFWG1a2/yhqYZqc8S3G2uuCy1ckgtr1aI=
X-Gm-Gg: AZuq6aI1MLtC4DHbYGCJUYNLlBvWA9p3hhZkBqvijVLQM7Rnt9SZlyQgtYqKbeFB8Xc
 bFYY5kZzWU48P7qjZLZjYlinfwSrnTkOWI5b6mQfXemq6DR0oa1jojs97c0i5stBR58VQUwwrmt
 fO6D7vlp0MVBdOiG2Q1R90MSk5Ru1AUCmkkdzOuq7ZyXMMBJRv9B0LKJ2eCevNp4SMVsKzWw8vq
 7jIs/j3bIoOsBTl3r0ea5BExpwKcAhpCRLqkZeK2emZNHdpzH4V9MstLd+D0o+Z5hKECDwdiwgK
 WLbi9ChDNly2NK7tqQVybp5r2Dsq/aPrz93NImZd7o99vV11IWio9WMesfKsndGCN9BRBHkST8H
 gwrRtfapiDtA8t6Dz5vlsp+LILHlMugFGOArkdU+wbo9eWAX5vFw+v6D4HMsac5jlhqvL+a/sIe
 s4jdWob94C1959
X-Received: by 2002:a05:6000:3105:b0:435:932e:f932 with SMTP id
 ffacd0b85a97d-435f429d77emr16068903f8f.7.1770031518295; 
 Mon, 02 Feb 2026 03:25:18 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:17 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/8] drm/amd/display: Remove unneeded DAC link encoder register
Date: Mon,  2 Feb 2026 12:25:08 +0100
Message-ID: <20260202112508.43000-9-timur.kristof@gmail.com>
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

Not needed anymore since we use the VBIOS function.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h          | 3 +--
 .../gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index f853e3c3fc75..8841000361fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -101,8 +101,7 @@
 	SRI(DP_SEC_CNTL, DP, id), \
 	SRI(DP_VID_STREAM_CNTL, DP, id), \
 	SRI(DP_DPHY_FAST_TRAINING, DP, id), \
-	SRI(DP_SEC_CNTL1, DP, id), \
-	SR(DAC_ENABLE)
+	SRI(DP_SEC_CNTL1, DP, id)
 #endif
 
 #define LE_DCE80_REG_LIST(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index c7e3feecaf85..5e9ba6a345c6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -226,7 +226,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	link_regs(6),
-	{ .DAC_ENABLE = mmDAC_ENABLE },
+	{0}
 };
 
 #define stream_enc_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index a26046c5dd38..3ba1d35e260c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -243,7 +243,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	{0},
-	{ .DAC_ENABLE = mmDAC_ENABLE },
+	{0}
 };
 
 #define stream_enc_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 809b507fb4a3..ee7556542dfc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -242,7 +242,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	link_regs(6),
-	{ .DAC_ENABLE = mmDAC_ENABLE },
+	{0}
 };
 
 #define stream_enc_regs(id)\
-- 
2.52.0

