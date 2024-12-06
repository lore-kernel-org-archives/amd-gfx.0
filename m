Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F03E77180
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C8510F08F;
	Fri,  6 Dec 2024 09:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kcq+MBog";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36E710F089
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:43:23 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-30020d33d05so15706111fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733478202; x=1734083002; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AlZ85fU7bMEdCr3Ivk/JPNhlYCX1et1nGUUrgQd3Dz8=;
 b=Kcq+MBogSImjRuf0r23Di3TI20XBt+nBVqaeVQJ6UlqIZP+KIGfQGc+SrXDd+QsjwC
 +DwVjBKifDBAtPhCfAnOGNtRpfN0341JxXKcfb9Wf6b92TxintFvxRlZtPeiW+eGUOkF
 0a9jvQxBm4uuaRj7xt/i4t3CPA1HNTgvX9PFozjFL7TbKGBgUdnadSnF/0LV+qQjkIVi
 HsciJdKkORS7q2r5TOSavGbEy/0DRusEvyubzIwge7d48b62yTRmJIUahLT/ULD+0sSh
 KISWI5QcXaTKwC8AphU6nZvEa1eCRt9X2s35hIA0rluPEi0j/b4UJ7yplv/RhGOAecJ4
 Ty1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733478202; x=1734083002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlZ85fU7bMEdCr3Ivk/JPNhlYCX1et1nGUUrgQd3Dz8=;
 b=rPGueqOVcaSSxXyWxxHn9eft28HRWuyoJv1KYMUBigsTuZXmCeBYY5oHtqstFUjP4+
 RQiybTb1Fk6KyN4EnINZLDq8fWbNwOJzJJ+VWTpN+IGRvFa6uqhBg6+mQs/2KSW+agU+
 XnzKteegAT1ZReEOVAVKbdkp9PNj5dUbdqNvNLt6rtQzgQVHahJDndS1NEpsJMSVE3ih
 dcmETPFO5hbtxMnhXUH9SiHPRduu8AhuTGbh9wtPN27ZHQL1c8TTTvDQ0HVD9Htr7XKi
 mU8nt22SduCavybAZygI0iHu5UdlXAxxpft29GmdlQxEDQTK7sikhkrcCjIiH9j6DwT/
 wITw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUadjU+ryjRBArEb4oLG9wqiBjaG7G3RCOx1Cfpj2gfqD1v5fGIDhMqM9xMQUynmRjSXq9KnMuJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzR6/eFWWNYxBX+tHVJ3+3yc2GgCmNjYRpGc6qGfuZP+3toeJTy
 7iH+hN72v7tE/hvKuNYldQvlSm4dldD7xz75/ZvAJYC7LCp3L85C4I+ZOhTh0A8=
X-Gm-Gg: ASbGnctaJjoNx6mcnFjv10rbYL7MWm1LgkbVk3Mojb4AndDM+pPEtXJubwVjc0pRYPr
 dzPFI6OCmWIIIKfFcDnykyMeEzGNGtmYc4XLQvtsE3vTLEmb0ZSbaaLJvQ/9aN8pmPge4mN6u/J
 AnDfCFRyvO/7R19wqfsW2kTrf20Ne43JSEsVN/3NcFAv4cF5onIHib5/my4z4iW+aqua8bjDKAj
 iDqJkJgxkoHiPrWFDPTeaYbFG+3Pg0ofkottxuUSxKHuupzcdoS/V3DWQ==
X-Google-Smtp-Source: AGHT+IGE6b4F5G8fB5UzCy612X2zS/z9Gws1TIKohedsOmxkKxomXTuE6wjdB8eKM7SaKj4xHi2otw==
X-Received: by 2002:a2e:a9a6:0:b0:2ff:bf0a:2226 with SMTP id
 38308e7fff4ca-3001eb8e67dmr19885601fa.17.1733478201781; 
 Fri, 06 Dec 2024 01:43:21 -0800 (PST)
Received: from umbar.lan ([192.130.178.90]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 01:43:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:07 +0200
Subject: [PATCH v2 04/10] drm/amd/display: use eld_mutex to protect access
 to connector->eld
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xBnYTDnWSnfj2+gm2t5bxnQqQ5FnybkVoMOlzhUTQDQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscueDleWgUKJKAcLnM9AVfyZmdn0HpKF5uCT
 kBmRHGm9H6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLgAKCRCLPIo+Aiko
 1eleB/9rtsqyEXNmADXNUhLtuCtrT54s5AaOypZT19JWbxxkqIS98oj7wNLlcf7TA1rOQTNS5RC
 dvsjFVOL4cizIF20+Xp8TdJpnBVVRKORmoXxY/g+sGQsD+EyOh+b04CJUaXVrWxd8DJsAwzaO8w
 75HquG2asaq4K33OkBPkZ85wATKlXdb9yjA+34HEfbGr4Dd71VsgTtQ3Ozs0zJ7lDxU778quIl/
 b+/N+ADy5pyhsVGIAgmAr74L8TzRGdbpMnzmSPT2IwV7qsqdNr+KY8fyDGlhRaj2FA4wIhoLac1
 9tx5/gz16qNpAiJ9A8ijUf1L2Ck59EMtUlTVlC/at/0sY+sa
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 19a58630e774029767bf2a27eb4ddf17e3c21129..04c68c320252b5ce9647f0606fb86fe57f347639 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1037,8 +1037,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 			continue;
 
 		*enabled = true;
+		mutex_lock(&connector->eld_mutex);
 		ret = drm_eld_size(connector->eld);
 		memcpy(buf, connector->eld, min(max_bytes, ret));
+		mutex_unlock(&connector->eld_mutex);
 
 		break;
 	}

-- 
2.39.5

