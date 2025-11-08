Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21ACCCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 09:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320B310E369;
	Mon, 10 Nov 2025 09:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X4S+y831";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6068210E1F1
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Nov 2025 17:41:05 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-29516a36affso15824615ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Nov 2025 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762623665; x=1763228465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KjRGzSVrFGVIo2LvU9W8/+cuvbxA+DYtLbsyShtQ9uA=;
 b=X4S+y831LmQvbuFLMeRjzJ67opMbib5XzJeBTK2/JB+B4U0FlTEstj/BKY7Xr3grJ8
 SC7t5IsVutulrGioJ9u7/k5D8M84PL0ZvDbbvm/r8xvB5UhiZJHR5eXPl0mqkWXpyHpj
 J1Xz8NExfOdtxpLVPr7lUqMjtiZ8SZe9AY3n9oR9UIKYP3GZlUobbHYfd2g1dJrMQEWg
 lJjARS2DQ+AaoCODqK201PDB+KQONi4BOSi4exvQoMPlyADQhg+/EVWHdsjYRannQh2E
 32W6HTHwJ3AS4ga+x7X3sF+7mQZ0EcAHyFq7vh8fx+zIhpmNMY8bY8RkIG2z6rTAdd6D
 QWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762623665; x=1763228465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjRGzSVrFGVIo2LvU9W8/+cuvbxA+DYtLbsyShtQ9uA=;
 b=IzXStJh850+OvyClFSPKNJr0jcMs9eJ0tJt63nfSPe1fHp0q5G5r5BJwUVWsYghzaO
 R/PaIh3RLVlwp4OUNPxpSJ1VGNx4IlVJq6a83Wi8jUj+QAkoX1iwXs4RrOCBX/pAm08U
 P8nHRM5A9HmuQG5ikoBcfjqxFVIGIWzNVMjdaJ/TdUsD54VzZUqUONgwfh+rXASnDJNz
 S+AVNYqxNFg4Rqjp97m4sd7dYhplIvjQ9G+O1K+JlfauFXeK15km3OjKsx4ilpEhBddR
 YxtWs5QOLLxIv2+u8j3kXsOdwoN6XwSvaOCPkka9lXh2Hz5Jge6rem8awneKuNmfHRmU
 n+kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/IZPnKnq/tdw3g124emrOJk9NmlSFZuJ7z+HcmT5ON5Z/A0B7HpW7C9HPyH7lcME/tHUmxawQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoW4wTRAZak4BO+a/Q1LfgLvkB4n61zzjiyc+QqMB4xpUZDNIw
 kDdWmxDILDFEoSh0vKmt0krx7Sdv6KDx+zLCMB9tLTperi4T9C/wSMI/
X-Gm-Gg: ASbGncv0r5ughGhF2Kp4ACDSGXM6Fce3PtLxHTIv929T2EJ4INqFXzE+bcg4vOM2GLc
 nIR7woGkmLnqzmwzA3HnJ3/d90b3Wv0sE6hD8D5wsMKmdbUKFd9tGER+Mf+XH5sQDGNy8TXnp9P
 YcxbbL7BG6OvieLDbrMdOgVW/PDE5qf9fZI7NcA5JWR46dgE5a0/h8Vy6v0sg+yGDqH/tmjh0dx
 EAgNG+pCyGn0FSxuh5q9Sfj0rnS6b1z9MGgkBuVGU+oOItRW9OgIA5XRzNQ1uoQzxZ01vYKonDT
 t8nRseskcxCQg3pGZ0djGmV9BADM7IbpdYTKsAhWW/k3mJbklmEYYF5VnStjvFlMi4qw7mAN8Vo
 ZaSopHQ8Y2Alz4xICUjnoPvMHUe7Fsy05wGJhlC1lHUxYWs4=
X-Google-Smtp-Source: AGHT+IGHulV1SjTVkaEnfmlUppgot/eDXD6crirZT1rmC/ueBEuHwHH/akpWt3ntSVv9RzINXXUgwA==
X-Received: by 2002:a17:902:f54d:b0:295:7423:4be2 with SMTP id
 d9443c01a7336-297e540d866mr38620785ad.3.1762623664852; 
 Sat, 08 Nov 2025 09:41:04 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c740a9sm94585115ad.53.2025.11.08.09.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 09:41:04 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: amd: display: shrink struct members
Date: Sat,  8 Nov 2025 09:40:47 -0800
Message-ID: <20251108174047.7029-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Nov 2025 09:25:20 +0000
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

On a 32-bit ARM system, the audio_decoder struct ends up being too large
for dp_retrain_link_dp_test.

link_dp_cts.c:157:1: error: the frame size of 1328 bytes is larger than
1280 bytes [-Werror=frame-larger-than=]

This is mitigated by shrinking the members of the struct and avoids
having to deal with dynamic allocation.

feed_back_divider is assigned but otherwise unused. Remove both.

pixel_repetition looks like it should be a bool since it's only ever
assigned to 1. But there are checks for 2 and 4. Reduce to uint8_t.

Remove ss_percentage_divider. Unused.

Shrink refresh_rate as it gets assigned to at most a 3 digit integer
value.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    |  3 ---
 drivers/gpu/drm/amd/display/include/audio_types.h    | 12 +++++-------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 3005115c8505..852c117fe5b6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1480,9 +1480,6 @@ void build_audio_output(
 						state->clk_mgr);
 	}
 
-	audio_output->pll_info.feed_back_divider =
-			pipe_ctx->pll_settings.feedback_divider;
-
 	audio_output->pll_info.dto_source =
 		translate_to_dto_source(
 			pipe_ctx->stream_res.tg->inst + 1);
diff --git a/drivers/gpu/drm/amd/display/include/audio_types.h b/drivers/gpu/drm/amd/display/include/audio_types.h
index e4a26143f14c..6699ad4fa825 100644
--- a/drivers/gpu/drm/amd/display/include/audio_types.h
+++ b/drivers/gpu/drm/amd/display/include/audio_types.h
@@ -47,15 +47,15 @@ struct audio_crtc_info {
 	uint32_t h_total;
 	uint32_t h_active;
 	uint32_t v_active;
-	uint32_t pixel_repetition;
 	uint32_t requested_pixel_clock_100Hz; /* in 100Hz */
 	uint32_t calculated_pixel_clock_100Hz; /* in 100Hz */
-	uint32_t refresh_rate;
+	uint32_t dsc_bits_per_pixel;
+	uint32_t dsc_num_slices;
 	enum dc_color_depth color_depth;
 	enum dc_pixel_encoding pixel_encoding;
+	uint16_t refresh_rate;
+	uint8_t pixel_repetition;
 	bool interlaced;
-	uint32_t dsc_bits_per_pixel;
-	uint32_t dsc_num_slices;
 };
 struct azalia_clock_info {
 	uint32_t pixel_clock_in_10khz;
@@ -78,11 +78,9 @@ enum audio_dto_source {
 
 struct audio_pll_info {
 	uint32_t audio_dto_source_clock_in_khz;
-	uint32_t feed_back_divider;
+	uint32_t ss_percentage;
 	enum audio_dto_source dto_source;
 	bool ss_enabled;
-	uint32_t ss_percentage;
-	uint32_t ss_percentage_divider;
 };
 
 struct audio_channel_associate_info {
-- 
2.51.2

