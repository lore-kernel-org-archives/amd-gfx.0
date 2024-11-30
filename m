Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A06ED7361D
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Nov 2024 23:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE52C10E5EA;
	Sat, 30 Nov 2024 23:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C9FCgACV";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764E710E5F0
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2024 23:55:46 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-53de84e4005so3430078e87.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2024 15:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733010945; x=1733615745; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=36yDOxib/1gmocQMgVorj80a3sqs2EFrrs6+X9Hy7i4=;
 b=C9FCgACVDNrvMzlTOwuUicmUbDO8jDSSjAdWTcyzjr/yYYe5k+Hyfxvak+lgsb65zy
 4L/6CbdEoZOVEU3Zp6Aid0Fkjk6s5wKgkAQBMsZK9OzUsOKYGXQ1a26kDWQaO738IFld
 N3EwOyg0gZ08jwpiIcLpHePsv9rrrM6PCbINQtio7ngWc+xVgUnOq93YxDeuISHSofua
 aB7t337PSjjJzUZVzNya3xLShsvsb3c0cQ+eSTiznHGLjJHQrZWlPWHhoOD3wXLMTnjX
 C9ugEZjOwi6YNhrmWHlqWRyhrpvnlaNnd8yJiQJeLdgnkRkVaX2wEayCRnHdYzdyiVkz
 NzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733010945; x=1733615745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36yDOxib/1gmocQMgVorj80a3sqs2EFrrs6+X9Hy7i4=;
 b=nHH6yx65CEvnP3auT6+HHKgiAoW1j6m0oVlkZLxiVztHdwieTUKylgs6XbBaeJE31F
 NAeZeWq4pe3Q7Sov9O1P6IHF7qUZqvpTmT85s0N5h2FttBUYYvUUvseZ0BxyhtljwOuw
 kESCi+C+JO3UN/4n2+dbl2Z3xLsyqE2qiRZ14iQOLu3kNFYsRemAd09HsxSJWC5NUWID
 KXpV5FTt4Fkj2XbM3HdOt340y5yJuez4Zft6oi7eqI8CQ9UoWzPJB2NtUxCKT2o5tbiz
 89ueXAPgHP2vZBu9vndXJDOz9MVqLhVZWw2fwwocZzQXLXcfo+RkPS/rmXqsSRzIgVLB
 RxXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDMI9PEmYRL3/QOAFnhgmYFaUOsQc4fEWgxY2WcYLaqsQM3GaIl+3LeAbmv5C5h63VCuoiQMHQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyZ+h22d3RSyYz7QvKIOIzfsKmZCPfm6uRXUEh9l8TUwqt/DTC
 V2OwgRwf1taA66VIonwnjHY4TybUAnst/kH0udjR27kTMsS3gR9YNBxfFE6WSx4=
X-Gm-Gg: ASbGncs5Y8uKnXuGq1tTCy+t8XWeZkM/mb+FJJPRCwfNdcjwmM+l8dAr4xiKGW+IIUb
 DOKOfcsldIMRbcn3yVEVUflCb1efpexbp8OVnymIKEmd//JikuOhxbEdpjQ/Cbq27PEZoVgz6ER
 LvM0ma7u3xSJauGfwSanHjb6XP2SSu34p6cShtMGd2M2arPVi9iK2rRkmmK1CIlXcm2CVe13cO4
 4dN5cdGIMYswVPhI3cgslNILbl5vVSFdlVshby2fqzpUqf00RN9MxNtcw==
X-Google-Smtp-Source: AGHT+IH1Dd+tGUe6sC5VDohyZs6YM5bJlrw02OG47IUbMBnDEhuVmgxIpQdpIhppnPqJWxsmsvhkAA==
X-Received: by 2002:a05:6512:3c9c:b0:53d:e544:3fda with SMTP id
 2adb3069b0e04-53df0114865mr10496986e87.55.1733010944592; 
 Sat, 30 Nov 2024 15:55:44 -0800 (PST)
Received: from umbar.lan ([192.130.178.90]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53df649647dsm900706e87.195.2024.11.30.15.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 15:55:43 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 01:55:23 +0200
Subject: [PATCH 06/10] drm/i915/audio: use eld_mutex to protect access to
 connector->eld
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-connector-eld-mutex-v1-6-ba56a6545c03@linaro.org>
References: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
In-Reply-To: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ocQZIy+T4sFAsnN5vtnQkv7E1kptjCde/MaB/nCVvag=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS6Xtmjf6X7lDNnSYnbN8EtG+XlG2iAcozEYaN
 vKRL0ru9MOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0ul7QAKCRCLPIo+Aiko
 1YA7B/4nI6CxdNCnT52tQHBg9M36pI1GVe1vqRtK5C3wJVqMCVhoJSG54VKPili2oAyP9q7Y5SM
 wfFkEzkHUs2iCBzvmcSxgtU8l7GXrHr4G37JlP3I6B3mtLZs7nUZ9Uh0WxA3RWI3Mvs0QxgkdOt
 d+fckwL/7V2GpA+I74A7OYQiz5GdF3miJBFmjtYL0TbdSjNBXXtzdj187qJpxJ5kogVYysHQ+Jx
 JRXPmwqhg8MNbZs+6GsTbv/A+sTxNTCEgU7RZ077JdqBKJNYgCqGX3SbCj59ZG+wd6EGcLw7COJ
 TaQwbVrLdRTZHn6/hP9VyBUkVHX5G7ONl7SU4lh2FjAe8VoW
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

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/i915/display/intel_audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 32aa9ec1a204d2ecde46cad36598aa768a3af671..3902ab8431139c3ff4dc17b841d94b6d3241dec3 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -699,10 +699,12 @@ bool intel_audio_compute_config(struct intel_encoder *encoder,
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
 
+	mutex_lock(&connector->eld_mutex);
 	if (!connector->eld[0]) {
 		drm_dbg_kms(&i915->drm,
 			    "Bogus ELD on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
+		mutex_unlock(&connector->eld_mutex);
 		return false;
 	}
 
@@ -710,6 +712,7 @@ bool intel_audio_compute_config(struct intel_encoder *encoder,
 	memcpy(crtc_state->eld, connector->eld, sizeof(crtc_state->eld));
 
 	crtc_state->eld[6] = drm_av_sync_delay(connector, adjusted_mode) / 2;
+	mutex_unlock(&connector->eld_mutex);
 
 	return true;
 }

-- 
2.39.5

