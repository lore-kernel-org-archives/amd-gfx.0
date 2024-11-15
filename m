Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4429AD68BD2
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2024 09:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D066210E3EA;
	Sat, 16 Nov 2024 09:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6MEEdBZ";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAE810E8C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 21:18:11 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7b1601e853eso56585a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731705490; x=1732310290;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ktpPIpScaeZrvvX2nXn5N10awI15hiN2fEar3uZkg4=;
 b=m6MEEdBZXdU3VMHMRnK9rSSNvxcRGdhWT9e+r3XbOg5Ga0qhotS2EuupazX5YuMX4o
 EmNsTOUQQG4w7051W021G7cLWOdaRrD3FXdSifjqT/6z8C9KdRfVZdv2uUEuc3mKGc6V
 FuNtzckRHZ3WYMNV7mO2uUBIM0dop6VHHG/Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731705490; x=1732310290;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ktpPIpScaeZrvvX2nXn5N10awI15hiN2fEar3uZkg4=;
 b=ZN5ciUjs4aVzm8l9qy1CCCS4/un8Fph0PoORcG0oU8t+myoSaAQIfuTB6bbXmPa6+S
 ejOPbd3KUNrV13c5jUCDKcFXwyRu8Zdws8PWpOx8LIw4d5m5syx9zdconiHaozdvC+Ld
 035YwHWLdq3hoB+NGzoiD4A4m6NONFVF6M8xeSYmMpg60Sc8gBjV7KXA2gwESSo7lCGD
 q4WhON+CChavQI47ph/5mKQgeB0yev4ms9hS5vUXe4B/R89f3TDXFv+bFChcwo35vWzv
 8M84+t/Ll5aSvLYTh+E1cApZ+7be9FaeHRUvOGLArdLh/QkSxU2xiRQDV04gLBf7Jq6K
 +LvA==
X-Gm-Message-State: AOJu0YyLsNbI0HJyCAobOXmgrl+wpfId1RtlzyAePluuPHHTS/VLlU+r
 9xCGlTR57mIYxz0IDAHpci5Nv04qAcR+hnZTdeX1dLUsv8NXuEDl4mwlHOuXHg==
X-Google-Smtp-Source: AGHT+IE2A9GCtwE3/owQJADRhxcYUckzzduFbZHTdlECCq0jAYNjYOc/PgF+/w+kQmwAjzx8y1wjNg==
X-Received: by 2002:a05:620a:c4d:b0:7b1:4536:8dc1 with SMTP id
 af79cd13be357-7b36236406dmr634270585a.62.1731705490448; 
 Fri, 15 Nov 2024 13:18:10 -0800 (PST)
Received: from wilburliny.c.googlers.com
 (204.246.236.35.bc.googleusercontent.com. [35.236.246.204])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca58f06sm200356385a.113.2024.11.15.13.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 13:18:10 -0800 (PST)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Fri, 15 Nov 2024 21:17:58 +0000
Subject: [PATCH] drm/radeon: Fix spurious unplug event on radeon HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-hdmi-audio-radeon-connectors-v1-1-d6d66d3128dd@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIW6N2cC/x3MwQqDMAwA0F+RnA1YmaD7lbFD16Saw5KRThHEf
 7d4fJd3QGEXLvBsDnDepIhpRWgbSEvUmVGoGvquf4QQBlzoKxhXEkOPxKaYTJXT37xgHnOOaRq
 nT0dQi59zlv3uX+/zvACACToWbgAAAA==
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Sat, 16 Nov 2024 09:51:56 +0000
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

On several HP models (tested on HP 3125 and HP Probook 455 G2),
spurious unplug events are emitted upon login on Chrome OS.
This is likely due to the way Chrome OS restarts graphics
upon login, so it's possible it's an issue on other
distributions but not as common, though I haven't
reproduced the issue elsewhere.
Use logic from an earlier version of the merged change
(see link below) which iterates over connectors and finds
matching encoders, rather than the other way around.
Also fixes an issue with screen mirroring on Chrome OS.
I've deployed this patch on Fedora and did not observe
any regression on these devices.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1569#note_1603002
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3771
Fixes: 20ea34710f7b ("drm/radeon: Add HD-audio component notifier support (v6)")
Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 47aa06a9a942..5b69cc8011b4 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -760,16 +760,20 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 	if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initialized)
 		return 0;
 
-	list_for_each_entry(encoder, &rdev_to_drm(rdev)->mode_config.encoder_list, head) {
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		const struct drm_connector_helper_funcs *connector_funcs =
+				connector->helper_private;
+		encoder = connector_funcs->best_encoder(connector);
+
+		if (!encoder)
+			continue;
+
 		if (!radeon_encoder_is_digital(encoder))
 			continue;
 		radeon_encoder = to_radeon_encoder(encoder);
 		dig = radeon_encoder->enc_priv;
 		if (!dig->pin || dig->pin->id != port)
 			continue;
-		connector = radeon_get_connector_for_encoder(encoder);
-		if (!connector)
-			continue;
 		*enabled = true;
 		ret = drm_eld_size(connector->eld);
 		memcpy(buf, connector->eld, min(max_bytes, ret));

---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241115-hdmi-audio-radeon-connectors-f8ffac989b0d

Best regards,
-- 
Steven 'Steve' Kendall <skend@chromium.org>

