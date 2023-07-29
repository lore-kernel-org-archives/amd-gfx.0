Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48022C001DC
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jul 2023 08:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA64A10E05E;
	Sat, 29 Jul 2023 08:41:53 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AAE10E7B3
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jul 2023 00:49:18 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe216edaf7so1339181e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690591757; x=1691196557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeTSuwZPlptjGhIuO9GsGe/aAqJgvkK628OoK+PRdAE=;
 b=VsttY5+SOr9fF9DKFAkD1fpnsZIU2pLzIzH48JAnNTF5WLWlpLyduf34wSQbvaNWAb
 q0T98HLRjion0v+Y7GwNdbH2nO50r6azAiH0r5Frq1ZaCCH8lItorpS6m2+vQR62eH9A
 yCcuwR3l9OiBfirFtuZ7x38cXj0lPnJHQNKLKigfGi84TTJgUD4g3GhZP3EK0oE51Ey5
 dYiVwpdI8VzxFLpdaBvu+EZApctr+dAKbxBXZzNoF5/W7MeqLK177oiDz4ESd7tEX8gi
 2Otd6PUFptJhMXbFJrehHaYdH0YZ4JJ8iqOxiPYAmbgnXuoHCYlwShe9sd7G0vTI7HkK
 PLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690591757; x=1691196557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeTSuwZPlptjGhIuO9GsGe/aAqJgvkK628OoK+PRdAE=;
 b=QqRrGPvPX8uP7+2ZrFiQT0ZUDFL3fcRCirB7X2j/lxO0GgI01Z1jWjrv5SDm0NYRen
 IkdLPTI9rKIBjmq6V8eDGiqHDO54u6UEa0hl1xBfGYACw1dopG+bjalPdAB9FfLXo0AP
 FzdRTlvflDPWXUtQ2zIitB9G1E3egxw/jE2xfJklCL4r6s094SmC1dRso2iF85VDOPZq
 0NvdkTvPLuKn2lmajsiWuLQmW76fUC5rGMERvwXebkHetxLDfBjBgYsmjdCydnJnuYAP
 W2iSu/D7G4DfUlfQ1y3wne4Dlo1Tb71XIzOHYR/GgjdmmTYEpCh4e8g/CSM+J9DtF2dd
 U1Iw==
X-Gm-Message-State: ABy/qLYUOAzTbogw5nNpT9S8w+1t/D76knZ0rmhnGDusEa+GVUNFn4+t
 q+XopVh5xyMPhcrjxIpNE5nFYg==
X-Google-Smtp-Source: APBJJlGnkBGsncWn163VGZiB6FNproqXBRlBWlgFqMTpY6qxbaEinFwvcwwZIU85m+UD+VdKOfxU6g==
X-Received: by 2002:a05:6512:2825:b0:4f8:6d9d:abe0 with SMTP id
 cf37-20020a056512282500b004f86d9dabe0mr1946529lfb.33.1690591756849; 
 Fri, 28 Jul 2023 17:49:16 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a19f818000000b004fe20d1b288sm500702lff.159.2023.07.28.17.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 17:49:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Simon Ser <contact@emersion.fr>,
 Janne Grunau <j@jannau.net>
Subject: [PATCH 3/4] drm/uapi: document the USB subconnector type
Date: Sat, 29 Jul 2023 03:49:12 +0300
Message-Id: <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 29 Jul 2023 08:41:52 +0000
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
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To properly define the USB-C DP altmode connectors, add the USB
subconnector type.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 include/uapi/drm/drm_mode.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index a6066e4a5e9a..9e96b038f5d0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1050,6 +1050,7 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
 	{ DRM_MODE_SUBCONNECTOR_DisplayPort, "DP"        }, /* DP */
 	{ DRM_MODE_SUBCONNECTOR_Wireless,    "Wireless"  }, /* DP */
 	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
+	{ DRM_MODE_SUBCONNECTOR_USB,	     "USB"       }, /* DP */
 };
 
 DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 92d96a2b6763..0f74918b011c 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -398,6 +398,7 @@ enum drm_mode_subconnector {
 	DRM_MODE_SUBCONNECTOR_HDMIA       = 11, /*            DP */
 	DRM_MODE_SUBCONNECTOR_Native      = 15, /*            DP */
 	DRM_MODE_SUBCONNECTOR_Wireless    = 18, /*            DP */
+	DRM_MODE_SUBCONNECTOR_USB         = 20, /*            DP */
 };
 
 #define DRM_MODE_CONNECTOR_Unknown	0
-- 
2.39.2

