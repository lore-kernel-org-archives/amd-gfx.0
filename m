Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7504E7717F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E0710F08D;
	Fri,  6 Dec 2024 09:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mrgD56eh";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AC510F074
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:43:30 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2ffd6b7d77aso22752391fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 01:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733478208; x=1734083008; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MGq6aED53P5HelbsA7MK6wW8IBVofd/BuTMfX8bnHpY=;
 b=mrgD56ehRb6CrZtJtHmOzOePsUhUkhNVsPxTe5ypKAMdcXpAd5zCyZLmHstxIQgC/i
 rmE8kpq8UORky0ezlnHvtI4vbH0id721qMCSGtkst27+HXglN70eAZMX85iByt3iwz+P
 AyPT0Q+/nnRXPvdOLddRPAlo4qnrblUe32wNVS1WLU+qwFruKwd4F6XLDIqg4aHPJBaz
 frKM143wTWZi+NTOR1xG2er1e5DxZM8xcFxhVfK5mmHDZUKYe9yijj8Ri2Bl8WpI3DaQ
 eL7wDvv4rXBier6LXnYFzbsdSltpbXsb6pWyEKfBN1mCzq7IF5vlOn5GjXdiNx05R03i
 4FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733478208; x=1734083008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGq6aED53P5HelbsA7MK6wW8IBVofd/BuTMfX8bnHpY=;
 b=tHI+fmKmRVogK8KdNNAua1JzqyfI9pdIVAQpY9h1rZ9gRPcgl2DuS7Jbvm0p6qkTl1
 9abd9xa/5Bj8HOAitz1tKPgSGXXcE+4KWPYdQN3veVGNEONmMxCo31hW+MHZX0xbtdA/
 ONR66EcGhtXEMp7VUZsm/WyrVEN8Pofl6XLqjr8bZqWzzUhoO8eHGPOEZPB+B8GVvtx7
 mzfQZoZRqPVqcUa8pF+AKCJow3PiDbL8Pjdn0VtuL8yzJMLK7ZS0o/QLMn39FvgGCpoq
 9QG8guL2A3iHEFF5wT+P95/DXxfXrStG5Vx9h/dAQ2KktXX+hyuh/Y6JXPeJqi1aw7Ot
 gA4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwkEoV72eMYwX87xNjPzflE14VPEt0ItR0LBNgToE0Sa8XqTxiy+i9nvQWRnWxesqAR6E4Us1G@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/l7ID4eSEIA4p9kCJrSRcvZ1y4zJmRcfYAlMdGTNOxk+ZiDgQ
 JUwAdovbEc1bBhyi52YAZS/CA7zSpiV8xjiNl8QL3WKrWAm5956IfXxG3ZLKF5Q=
X-Gm-Gg: ASbGnctmX0FY1GnStjcEjMQ92qmbcK87geNzpoh+RuqD77DyfgI5Sm86l2fxKlAYjxJ
 qv2cxCdezgfjp5S2vrPSn6g2ZhCUp/HhLBPOtTwxLqKYoV/qKokxEJI2Ya8iCp1aLQ+GC+d+tmY
 9mAmXeNSM4hVXDrf/myjQAP3VSGJKB0oAhzsiFT/zD1W8wmsjAD89rTDz+yyMoQwZUWMaeVChj/
 jxQzQb2hH8LUXwfn64t8YkfESPEuaV3e7+RV3o0EJ4CRAZlYyVJJ2zyBg==
X-Google-Smtp-Source: AGHT+IE/NYxmjluRmONb1EoU7KbKKPH87buJ0IjBEcYtxmwcZQlKK0G0iiNZoTWvmIko49pJuOa6eQ==
X-Received: by 2002:a05:651c:b29:b0:2fb:5f9d:c284 with SMTP id
 38308e7fff4ca-3002f8e7df4mr10594341fa.16.1733478208528; 
 Fri, 06 Dec 2024 01:43:28 -0800 (PST)
Received: from umbar.lan ([192.130.178.90]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 01:43:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:10 +0200
Subject: [PATCH v2 07/10] drm/msm/dp: use eld_mutex to protect access to
 connector->eld
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-7-c9bce1ee8bea@linaro.org>
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
In-Reply-To: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=g8XDt4tMHXpR+O+C6P49zaXUZ1QAJx0+8PEn0RE7Eo4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscuHK4m+of5M0K58J1Ue7FnC+JgeJ7oM6NSu
 bFPedJdqXmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLgAKCRCLPIo+Aiko
 1bfrCACW5hMSxLBb5or6qGH5D5AVPGJIvY9BGjNY1WTyi2PUHO7TE/oo3Ggc7rv7l860G7eGzQ8
 uVT1bon1fazOdXW+lYbtHJWim9TYibboTYhb22pQ3YrpWEiuV1UbYdHBB8vzbzO9jXkq/bJmQ1m
 +E4FMSQ4cvduHdnEWi/8FNjp7zOIShlJYI1KIxungwjDjpEKEtea0kLBR1PRGwCG8/yZZUFfQxI
 QckeAW77aJDzAZbPOuHWb2f1rJKPg5flOLCaaqtxskOhiUml7r060zILPXNfrxMo4DMSMj+jYwz
 1HVsVa0f3CLU5a7ZBeGqVsa/7rnSuUMsfCkuJrb6r9MQM91w
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

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 74e01a5dd4195d5e0e04250663886f1116f25711..0fd5e0abaf07828157085bd680bfd3c7d32deb61 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -414,8 +414,10 @@ static int msm_dp_audio_get_eld(struct device *dev,
 		return -ENODEV;
 	}
 
+	mutex_lock(&msm_dp_display->connector->eld_mutex);
 	memcpy(buf, msm_dp_display->connector->eld,
 		min(sizeof(msm_dp_display->connector->eld), len));
+	mutex_unlock(&msm_dp_display->connector->eld_mutex);
 
 	return 0;
 }

-- 
2.39.5

