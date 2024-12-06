Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B99E7717B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FCB10F06C;
	Fri,  6 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="epyKVEOZ";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F354D10F079
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:43:27 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3001d009633so17070491fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 01:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733478206; x=1734083006; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gezQjvgIcYxaejQ8BDd64CZD9/Ck9vNVcEKNgvbZ4wE=;
 b=epyKVEOZiG9TA0frJ+ZaC406IOAZoogEPA6QaxfcLo/8nAcy3Ooc36Z06KESiSL1Dw
 +nV7CqGc8UN/sYH0atxPPNwkVJSqJ7vdbUqGvB1DFOGGkxdcFVDTY7KRQY6IjTSGnnEv
 g54CQpHJWhliBKswevP5Q22H3bx9I6WB6J2vtQPuiFsHnVVuwvOqsqA0SyEYELWrvR4R
 yIY9uWVdqWLhqpmZ0xpH1P5qgEw8Ax1Cxt5iWhCdriXqZj0PPbPov403CFozp8kU6Ulp
 15CTMGp4gfMVHV0qEkytr4oKZ57O2IyQ4V5QBvbRot3kpdoOjM8sDMlop+ak8t5cveoY
 kmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733478206; x=1734083006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gezQjvgIcYxaejQ8BDd64CZD9/Ck9vNVcEKNgvbZ4wE=;
 b=MCyMa76jdMH+h2uLdow1pOEOYkR3JbFdcM+ZcSZDhhB2JcD9ajI6G72KNZMbHqV0J1
 okQGgZzvrnINP4/PlNJunxEQKTnBuPPeEEm48InaakStNoqdnIr+J6yf84GKRk1GGGWn
 NG6rUN3N+jhWpiYOSho1AfU8WYcaajI9coEDDT5DAZO0iJB/ANTNmBXjKhxZfqKnJcJa
 z1mt07wBCxuX4PVsDS82Usu6qUFnSODmuEOeguZeduLD6YHCYWmggwZfWVVkoMll9dXT
 MIor9IRPIaHdp4CkHBd2XTh9CGJSQnV0ExX8gj2r236bSPbSru4IEH4Pa3uuPxHhSzov
 eZlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1HcQ1agTFE7fq8IXOAqV0yBV3vodHzEOkg4RGMAicggTmoOsjqm5IXuLXA6YqkBogWNqWyVi4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYmuAJXbkVeAcilRqqiugaEOOb1SglEOpOBMH70pjQfXDcUfMC
 qZQ0oC+b+ce6eDvGGW509rLzOA6vC7MYTLcGGNaj/HL5584OqZZnHhCldSDJnLY=
X-Gm-Gg: ASbGncuIlRPKTakA4YdN0sDsSD9nzGJdqAR/fMm28s2NsvGQLmNKjp3iLKLBsXw5mgl
 I9AngqpftkLn5g//6/4gwWEhJ+KvxN8KS5VyuArl5HOUn1wJkAjqXfY2v/UET5lrJAdzyGslz7E
 A2y2f2zXjMw31x0tKeS8l+R0PxfP4nowYaT857gSSh7OrCwh6wdodTj3yCB9kb+oM8yQeIgFFXA
 s2G65BjEneeW5YKsYVneOEGwcRCmgHjlh0jRbnoPoVkJ+RVnnldO/egbw==
X-Google-Smtp-Source: AGHT+IFIxMP3XivqZCXghDCnZTnDDHCeTBksUkUbx72OhyJC9NMw97gxwKXoTkYomD8vLYGmPlA77w==
X-Received: by 2002:a05:651c:150b:b0:2ff:c69c:db0f with SMTP id
 38308e7fff4ca-3002fd14d81mr7610671fa.34.1733478206004; 
 Fri, 06 Dec 2024 01:43:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 01:43:24 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:09 +0200
Subject: [PATCH v2 06/10] drm/i915/audio: use eld_mutex to protect access
 to connector->eld
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-6-c9bce1ee8bea@linaro.org>
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
 freedreno@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tgOWbzXmlfNkUNlgKabtbqj34BDfcm3kqO9iU9YutCA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscuyv5W8v1YTELbuHmMKcJNbiEngJDs2MHEM
 hFooEYTmIOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLgAKCRCLPIo+Aiko
 1axkB/99cecYxR+X5C1zAyfkKFkvE75Us55r2gVNp2BPRSD08mYQThqr5+QEsx38SPihPleo366
 eaLD1hT6L2kyK6wdMq+Lkkj0kbXEPPTe9pj1Aad/UleIfoTG7Ps/uhFSFLdKRs0DnQaSZQME+VQ
 M2v8AFXHFAYJgM+8WPJgC0HTtuPSWfqBz+0JZQvtJgjoKRndMOmhlxr4vbN5xbJVZBgEPSDBujk
 kmWs3fgGh1o3Yx1/EyUv6Zz4X6sBrwrTlNvZNOSrOmgizBJLo+cBQyXqidSxYnZIp1DqJdxMFo4
 Qq7ORf/cwV/dZd0e+mmP5jB0ifPb0a3lavlzcLRDNPRaca3O
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
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
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

