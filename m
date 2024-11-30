Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53568D7361B
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Nov 2024 23:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359C910E02D;
	Sat, 30 Nov 2024 23:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YnaZB3xG";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5001610E0C0
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2024 23:55:31 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-53de852a287so3329869e87.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2024 15:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733010929; x=1733615729; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=igdGJ+6WFp5yYbSTVfMkHAFbN2LBIGOZkBsdW6CIVmA=;
 b=YnaZB3xG1SkaALAmSaovCQAA9ZCHiOX2UMtHXfUK1XNZbu3K0xQGsJPJxXKUe0aKIA
 Ni01slDfKWMYPFOHDPkS7JFFXQQMb3Fu2GXujHZ6b80WbRiHQmI1BgGLJi68gkTMvY5u
 ysDEu5GqoKRU3v0Ztzl0LJu1I3aHjyRWph8BaeMAGaBOOZkupMKnQH3pXLWSYZZjdL+s
 MbZTuhhvL7wd8HozM9eLTmO8Ak7Bta7zkWq04nAW5rwaKwAfknXVnrK8JsOHkf2ivyzf
 LteX2B2xH5rmnhmXCksIc+a1VKKDcNGYzS5saOGIAamKA9unWtnOOpVBtMQqA3LCR+T3
 6mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733010929; x=1733615729;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igdGJ+6WFp5yYbSTVfMkHAFbN2LBIGOZkBsdW6CIVmA=;
 b=dO7hAecdTnAtQp39ww2i6qI68YlhUFKh++AMKmBbzapFYTS7sXYlWKLQG5Az4nuG3Z
 tTjuu5d4bnIqEwoqUN0PrggtKxOwy7pJUBS57cqzlA+2ysMWr3M10k8G+Y2BOZl7KK+v
 tUlWsg9d5fK3CMDLAIDADLgzEi9q8XwimvbpHTV241TLqcdqcytuMQjCFjH+6oheQHzR
 FOFSKg/CbDApICzJy5MUxQyqx/N2laWe2habXLvyNcLNjVDxG/f3ApBJ0KiQNZr4QkO6
 9zsy9nJJBZqlkwrYkBbuXZSxIFSTzWhmFIMWzXz+UamOLGJi2metoNHRbHbhsIHHIUdS
 fmCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYEKiQati1cVDRG4gW94u+LQURZehXDIFsEUBb0ds+gki1JECSRcfm1Alde5S7hIaVqlMTVsd3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7lnAYgcKVIGMJKCr5k3/om2mBI1lSSUL6wrGxKlph+M+dQzsa
 8fbfXt3cpaeys8bYUZ9lGpNfcRXad2zX2hS+5cb9XIpYAE66fCJPnXOil6RuT6U=
X-Gm-Gg: ASbGncu3XvxHm4eN/m3a1sYuvQGi4K+M0ruuzMDF7vImqk/9MWbbbhyPZs7sj7EH45Z
 IWz5GDmooa/NHbpgV/k5GJv53r3f0dLvG2dTcIDcSLXuHeHz4DgZpnTKG9YtKwsSAR4bNASwwAn
 pt6oD7pbxw/kt7v4rhcWToI+tJQnZNIz6uKOaUlTdCozJvnX2sFIrkwqEa/gMYBM31s6+vhJdy1
 aFDfr+9yqfinXdLLLB+bu+fFIRJ1e7gKznZx/QbvF10Gc3Mc14BzykFDg==
X-Google-Smtp-Source: AGHT+IH/lMi82z0v/iMa3bnH3O48sOuTvGtLHugaIGP26xUYLLpIeMPo9osg0TDFc6RKyN8BchLK9A==
X-Received: by 2002:a05:6512:124f:b0:53d:de48:7409 with SMTP id
 2adb3069b0e04-53df001cb8amr5926461e87.0.1733010929250; 
 Sat, 30 Nov 2024 15:55:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53df649647dsm900706e87.195.2024.11.30.15.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 15:55:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 00/10] drm/connector: add eld_mutex to protect connector->eld
Date: Sun, 01 Dec 2024 01:55:17 +0200
Message-Id: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWlS2cC/x2MwQqDMBAFf0X23AUTFWx/RXoIyVMXNJGNLYL47
 wYvA3OYOSlDBZk+1UmKv2RJsYh5VeRnFyewhOJka9saWxsOurJPMcLvSRlL4PW34+DeNW/XdCj
 oqdSbYpTjOQ/f67oB3wr3/2kAAAA=
X-Change-ID: 20241201-drm-connector-eld-mutex-8a39a35e9a38
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=h9SpCjrnoVeyG6yy+hC7dnaQqGomdEDru9YX9FtBpig=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS6XsZ1/pqxgC30AKzvdNBVrv5HQb2dJZaZ5zn
 VEhrpDwtKOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0ul7AAKCRCLPIo+Aiko
 1ew4CACbQcTx0V9Sgmz8qhhsUnlM0Vh+dbbDTDz41dhDdcEgbBBokvib8Go3fPRoR2hiD5m4p3q
 Inrqmtu6WxnuFTZ0QoZhHX0EdGBd/UJUWQcfS5pdXJ3Xg23dIDNSEqxBkJVEmRicpeJ9ZaUAQMi
 YdIJpl1FT2/ANTrI2tncuw5hhWL1lQ7u+U8y6VrDr5QZjFXAAeZ0Zu3y8lTuITAxcxTLjSfCapq
 SK73gIYvnestQ4yiI9RsX3EIyujQ6z18dGKF1awnRjx9cXrXrBMiBVD5XtL8+PtSrfWgAuHy9qW
 g8v2j0eW+fy5k2eNqU4JbP7IJfm7WWm2CTjtdsikNnIqWkIv
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
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

The connector->eld is accessed by the .get_eld() callback. This access
can collide with the drm_edid_to_eld() updating the data at the same
time. Add drm_connector.eld_mutex to protect the data from concurrenct
access.

The individual drivers were just compile tested. I propose to merge the
drm_connector and bridge drivers through drm-misc, allowing other
maintainers either to ack merging through drm-misc or merging the
drm-misc into their tree and then picking up correcponding patch.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (10):
      drm/connector: add mutex to protect ELD from concurrent access
      drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
      drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
      drm/amd/display: use eld_mutex to protect access to connector->eld
      drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
      drm/i915/audio: use eld_mutex to protect access to connector->eld
      drm/msm/dp: use eld_mutex to protect access to connector->eld
      drm/radeon: use eld_mutex to protect access to connector->eld
      drm/sti: hdmi: use eld_mutex to protect access to connector->eld
      drm/vc4: hdmi: use eld_mutex to protect access to connector->eld

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 drivers/gpu/drm/bridge/analogix/anx7625.c         | 2 ++
 drivers/gpu/drm/bridge/ite-it66121.c              | 2 ++
 drivers/gpu/drm/drm_connector.c                   | 1 +
 drivers/gpu/drm/drm_edid.c                        | 4 ++++
 drivers/gpu/drm/exynos/exynos_hdmi.c              | 2 ++
 drivers/gpu/drm/i915/display/intel_audio.c        | 3 +++
 drivers/gpu/drm/msm/dp/dp_audio.c                 | 2 ++
 drivers/gpu/drm/radeon/radeon_audio.c             | 2 ++
 drivers/gpu/drm/sti/sti_hdmi.c                    | 2 ++
 drivers/gpu/drm/vc4/vc4_hdmi.c                    | 4 ++--
 include/drm/drm_connector.h                       | 5 ++++-
 12 files changed, 28 insertions(+), 3 deletions(-)
---
base-commit: 44cff6c5b0b17a78bc0b30372bcd816cf6dd282a
change-id: 20241201-drm-connector-eld-mutex-8a39a35e9a38

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

