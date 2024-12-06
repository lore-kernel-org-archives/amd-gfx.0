Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90845E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FE410F073;
	Fri,  6 Dec 2024 09:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rcZBAASm";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A1C10F070
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:43:16 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2ffdbc0c103so16743771fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733478195; x=1734082995; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VnGo6ZNwboubgG4PK3zPxjFnyRb2ICdQLCcJ6lGvxCQ=;
 b=rcZBAASmatwg9f76M348+EcTSbYZaeOPRCNcWgVEfPuDGFP0Lw1InpBU18rx5IMwSF
 0FOMKdojjnA6cVidyXqJuqab6EiOo8CzGIUkwVQ1TybSKbJ/8tPKb2LmO8d3/Fm5Js5+
 7+77NIJgJ5VJvVy+7b7WBgOke9BeueQ9ZhmNRf9qeF5juzMgNSNOCOg3ZBZqCzHzM/+b
 9a/N+exj+lodJHs55sGWUS3sdPYgSREmQMlRV3TFWsOAKWrayrke6ybZcs+kk9J2wB08
 cixjq8o5l644vwGlIRoWLY65oOBblIkJXRoz/0gI+/RkkgQkM9H4brvcuEusF6PIQUVO
 ouZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733478195; x=1734082995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VnGo6ZNwboubgG4PK3zPxjFnyRb2ICdQLCcJ6lGvxCQ=;
 b=OMXMbr2kBxZFZLC+8u94hgh3/fLsklT5H7qgTiepML9BXricG54JIM4M9wChbAFRCI
 hnRNyLCcWfexvh7H3AVMaoDSRyOCrJv+4UT4wryG5ExQaOnHYP7n6iLuXVvtMsUXM+8I
 wNKavDX/RFoXfzGa9MMZPf1Wctc9buEga9PGLXr3nV6YJkV5H1bGumjOBRSEU90zAATk
 RScs6M4G+uz/rVZxAQ6ktWMz/6MDWKiHNy5R2vjZky0tfMADfbqYFd+ZxFSdNBIqUReE
 2g9sO2us/wgmg37CNWb8pqcz52veL4z3WWz48IwkOfK+AG5kY1JEA2588mjWRfEaoHZx
 wV/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO/LTaaF8SSVbhnAU3glA3j76aOCrN3JiAYJqFguvIb9uAkhokHnxLd3srDzvAfZK0sllSCTTM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxsPXVhHK0tumKfkbiBjMrLGgjt2UOQ93aABH3cOkNYu8c5Lnl
 L87E+AnIh7uf8gBDcPRTeM+ZSXTIsWvz5aIGizml6RwCZlXxI5BQc3h8slaSEqn6HlmoT6PHcAz
 n
X-Gm-Gg: ASbGncupgSWzbWwRMaH3bnY8xJqWBHbl1ZMIrOgTMpO3ALNaNYEKXS8o4+kt2/IWoN0
 IjvsKVVW8gfMe6gXX92jFNJKkvmJD9yq2EL1zZFonZ2UfsybNVLtHjO4bQh4zuKZlzcWpQoASbk
 cntYs/fJC4H09D65pkRCxUooWXVD9prr0IuIJQPM9vNvVx/PuOL0baeIwm2oqkFr8iwQDjdfFRn
 41m+5ud/FnyaStziM4NyTZ5yAQ0H6SHnjIdp66Xtfz+S4E9p65Mur2Zzw==
X-Google-Smtp-Source: AGHT+IHOfIBmoyEolZXZdyLfUjfRu7LK9x/y6e2NRNb0G1IfVvxWYDXdxw9kGPS8sm9OVNX+a5FRXQ==
X-Received: by 2002:a2e:bea8:0:b0:2ff:df01:2b43 with SMTP id
 38308e7fff4ca-3002f8aaef2mr6873121fa.18.1733478194869; 
 Fri, 06 Dec 2024 01:43:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 01:43:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:04 +0200
Subject: [PATCH v2 01/10] drm/connector: add mutex to protect ELD from
 concurrent access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-1-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3318;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3Q5pbMu5lborNDPG00HVqHDspCjjhjGT9968qr3bz9k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUsctUfPifOTQ8tgTrVr4NDA9HQHo4lV6wGZ/x
 802YkRE+OKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLQAKCRCLPIo+Aiko
 1YTBB/4+LnnhEaD+gppGgLjgyd7DzGULNQMgJ2hoRulbF1tCZiqhH2JwwQgaiFxKaCK13GN72v/
 +MlHzrTYbtF24x6wcNLxIFk87u2wdjCt5dO8xqKiiFF4My86VJebVFFgPQmUXcFvMWkWUS3PByj
 f9McLONHSWPtO0XRW3DbeQ8zzl5cChJhSN8/mkvwrNqq0BkWWOEDxxROis0bi2KSFK0/SBEJ2rN
 X+RhP/l08plhS1bGyEvzzOyAMvtpjSEsEYXf5mCZGGnypfY+YKJQ1VDkpPcX3/Si3R6D3pZ0Vpw
 Wfr3vj5voa6Xeg3e/NqY4k/PPQjahgFQwpQeJMdgalo1w5Zq
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
access. Individual drivers are not updated (to reduce possible issues
while applying the patch), maintainers are to find a best suitable way
to lock that mutex while accessing the ELD data.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 drivers/gpu/drm/drm_edid.c      | 6 ++++++
 include/drm/drm_connector.h     | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fc35f47e2849ed6786d6223ac9c69e1c359fc648..bbdaaf7022b62d84594a29f1b60144920903a99a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -277,6 +277,7 @@ static int __drm_connector_init(struct drm_device *dev,
 	INIT_LIST_HEAD(&connector->probed_modes);
 	INIT_LIST_HEAD(&connector->modes);
 	mutex_init(&connector->mutex);
+	mutex_init(&connector->eld_mutex);
 	mutex_init(&connector->edid_override_mutex);
 	mutex_init(&connector->hdmi.infoframes.lock);
 	connector->edid_blob_ptr = NULL;
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 855beafb76ffbecf5c08d58e2f54bfb76f30b930..13bc4c290b17d556d654b7cdd8c48c24a32aba9c 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5605,7 +5605,9 @@ EXPORT_SYMBOL(drm_edid_get_monitor_name);
 
 static void clear_eld(struct drm_connector *connector)
 {
+	mutex_lock(&connector->eld_mutex);
 	memset(connector->eld, 0, sizeof(connector->eld));
+	mutex_unlock(&connector->eld_mutex);
 
 	connector->latency_present[0] = false;
 	connector->latency_present[1] = false;
@@ -5657,6 +5659,8 @@ static void drm_edid_to_eld(struct drm_connector *connector,
 	if (!drm_edid)
 		return;
 
+	mutex_lock(&connector->eld_mutex);
+
 	mnl = get_monitor_name(drm_edid, &eld[DRM_ELD_MONITOR_NAME_STRING]);
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] ELD monitor %s\n",
 		    connector->base.id, connector->name,
@@ -5717,6 +5721,8 @@ static void drm_edid_to_eld(struct drm_connector *connector,
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] ELD size %d, SAD count %d\n",
 		    connector->base.id, connector->name,
 		    drm_eld_size(eld), total_sad_count);
+
+	mutex_unlock(&connector->eld_mutex);
 }
 
 static int _drm_edid_to_sad(const struct drm_edid *drm_edid,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index e3fa43291f449d70f3b92a00985336c4f2237bc6..1e2b25e204cb523d61d30f5409faa059bf2b86eb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2001,8 +2001,11 @@ struct drm_connector {
 	struct drm_encoder *encoder;
 
 #define MAX_ELD_BYTES	128
-	/** @eld: EDID-like data, if present */
+	/** @eld: EDID-like data, if present, protected by @eld_mutex */
 	uint8_t eld[MAX_ELD_BYTES];
+	/** @eld_mutex: protection for concurrenct access to @eld */
+	struct mutex eld_mutex;
+
 	/** @latency_present: AV delay info from ELD, if found */
 	bool latency_present[2];
 	/**

-- 
2.39.5

