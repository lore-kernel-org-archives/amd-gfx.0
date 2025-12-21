Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB3CE6749C
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D41110E5B4;
	Mon, 22 Dec 2025 08:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="tNubzC36";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963FA10E046
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Dec 2025 19:24:26 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-888bd3bd639so41962136d6.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Dec 2025 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1766345065;
 x=1766949865; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WNRXomm/9h0iGidBrRD9xr6yFpj6CojlLOaAVzHjsKs=;
 b=tNubzC36R+FN8+3qraNd+MfHoVWKaroczLB/iuR+AkT5kCv1c+S+RYE18Ua3phYUNd
 4/bpYqdWWbR5uS7+KHz+tU3Hki/LSHwuHB8OJpVjDrdVkGBp/o8FPpRH6IGuIEAOu96Y
 f0IUBv6WahRTf+E5KgWoWsnyGR4QvgxyoNUagSis3Ho6Ml+z0xineuFPKM8Psr+CLhL9
 iC4+7taurunHu6hwKTTL/7LC6vAz1JWvQy0/vGJ7Pinlwh2xKJx+m0G6DR7Fcvrw+uUn
 faMNH6uPPRGp5wACFR3H4PIxp9N3alhfzzoGYrk4Mdbkq2716uh5HHkNBRu7UXCOcEGb
 VPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766345065; x=1766949865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNRXomm/9h0iGidBrRD9xr6yFpj6CojlLOaAVzHjsKs=;
 b=TaueOQ/1AYXiRzEgqdxN2TRjtNHkvlFFddzXlwFhTRAwmPOy+VaeBhbw593s3mOM8I
 LfvWQS4bMb2vbTPFKzWcLMqipAwmWXjXCRpyM8w72VW2l3LTWE3Zy7MQaIPeJf+id0iT
 gpAJauZj859erqC0nTHLs87VnibBRyo5Ul0e0O37C2Jt/ziXBkXLdhXQSNYLHQh2q0Da
 PVi/z2PBcEvI5gKkjBCSu591yBLHEc+2i8M69KyMCIZu29pkCWRmEjHabmtUSh6UE2hK
 fnXfo2a+6zNFkNlfVNxMrSJVNxclMm+WqFIV9A0F1T5I/4upEnZu/UJrBcOpQs6x+94V
 gJWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGnRBPmrU89+qXtgkBtmq1eOyEHflhQlnVjzy0WaneB2aoDft4E/9H+Ws4HhpPN6HU2JiTpcBf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGsMXDL8BABh1EkGC9Aqxj2KI+P9nXNOyiz5y4xQbZ03PEew5b
 OCgEoAhsGFdqbJvAuTDGpxsJlYjAyBYO7lt3OdFctt2pAJLtYr9Pz9II1LR5tvNGLw==
X-Gm-Gg: AY/fxX40jnkSoVVePL841x8cTzx+PzDfYz3vMqGeJig4eY0K0KcRfmEtNV5F0ehxrP8
 nMJOJrLeUaPultm47/5iVHOqNqgvD3Y5E5srU2KiSQ7e7+YZorcX+23b2xnHaeWUoVAjCzult2p
 rlLGy/72rOgs2/jD2Hxbnp9EBLXqFx7MbnZU/E9v4laPk4aufZ6/spItiS3mSqazawvUmw+imx0
 ILp6ii+NF6KgIABbb+qJVk9tsB66C7d9/dP8NllAWUc6aWSiGLtw1VFKGpgzYnZ/yCJ+EC1bJpZ
 hb0X5icfqvuORg6EKz0SpNKIjDQMuU4nBGC8dG1SusgeknPEDY3rxqY/W634XZTSS5VAhQAO+0y
 /9UhraxNxzWehFMB3w46193ileuo4dMnyFDywWmVOKCixclze1Zk4Rhwha33pxxWR/fAdlxqxL2
 mYsXaiaFQCqHhTbyormQ/iKXrLJ6cgUhXNrFYas/uYc3sPQ9VUU9PJK5eeoQb7qjjbyQ==
X-Google-Smtp-Source: AGHT+IHgVYbByF5NCXxaki3N51wWAG7AvtLQAnsyAdqjgDj7hWSlDWpoheIh4kbzxiW2kzJablQFjQ==
X-Received: by 2002:ad4:5be1:0:b0:88a:375b:ed7c with SMTP id
 6a1803df08f44-88c533b360fmr188839156d6.35.1766345065382; 
 Sun, 21 Dec 2025 11:24:25 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca.
 [135.23.195.66]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d99d7e8d4sm68043356d6.41.2025.12.21.11.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 11:24:24 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Simona Vetter Thomas Zimmermann <"simona@ffwll.chtzimmermann"@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add quirk to disable custom brightness curve
Date: Sun, 21 Dec 2025 14:24:17 -0500
Message-ID: <20251221192422.2726883-1-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

This series add the necessary plumbing in the drm_panel_backlight_quirks
module, and in the amdgpu module, to correctly support disabling any
custom backlight curve a firmware may have provided.

Basically, this is the same situation as with the other quirks, some
firmware data is sub-optimal. In this particular instance it makes the
backlight control jerkier when using the firmware-provided curve.

The last patch is authored on top of a just-sent change, which adds an
additional device to the list of known quirks. It was sent separately as
it should be entirely uncontroversial. Otherwise the changes in this
series were made on top of 8f0b4cce4481, the current drm-next.

-> drm: panel-backlight-quirks: Add Minisforum V3 SE
Link: https://lore.kernel.org/20251221185608.2718273-3-samuel@dionne-riel.com/

Samuel Dionne-Riel (3):
  drm: panel-backlight-quirks: Add quirk to disable custom brightness
    curve
  drm/amd/display: Implement disable custom brightness curve quirk
  drm: panel-backlight-quirks: Disable curve on V3 SE

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 drivers/gpu/drm/drm_panel_backlight_quirks.c      | 2 +-
 include/drm/drm_utils.h                           | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.51.0

