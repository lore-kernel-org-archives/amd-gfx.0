Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98DFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 07:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BD010F56E;
	Tue, 31 May 2022 07:45:34 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F16110E11A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 08:19:30 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id 202so10004541pfu.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXGQfQ7lsNUfjhcCcz/m8HUah1p/vDnEfDkpaJXX40Q=;
 b=j7HdUtSWpyZjY31tsETWgaBomYbcUL4NPjLRCEhLhcJhNgIJMPG4h8aVerkAWtdhJA
 6xH+tfkb3bQV9uMkXvjv7squthw5m7QHVK9FPoxGwWesDXlxRpcFVzLVr8fh8Qp0i1Oy
 Cqr4umRydtfoIGytttZl5eX60xAiPR+cvlQfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aXGQfQ7lsNUfjhcCcz/m8HUah1p/vDnEfDkpaJXX40Q=;
 b=neRZBunr/kFfVcZDqBArppAcn/iAvsPb0G33Pbk8TLHeil8YlK0yYZm/mFIsm6aTRM
 +LQrwpXaqPQCFFoo4S6tDc71CsfD4uawKTaCCk2dxqOdXM1t6t073ajDgdgELnD2hqdY
 XnAtyJvjkxFD2fd62SeC225tTjplZw2QEhqRnjM/z8Gyevz7VKjFlc67OT0QiSIpWOQl
 fRxnFahUrjUO08CNNKYiTj1A9winVM9Q7wNgycp9przVG0m4j5E2LtgTt/D/v4ymM+Xr
 nrQwfoNyNO92MYAf48OY4IqWFW6dB1igikQfnaghiML4E+h8BAOY8PbVsSmFGKAhU6dK
 FJ9g==
X-Gm-Message-State: AOAM532mca4/aVZ9YXhZr1mKX3Z90mTQi4v+Zabtp8boxcwHpQHSF0hN
 Lkp2CAHG2R3bMb38kOKWDzFLTw==
X-Google-Smtp-Source: ABdhPJznWw2scunjHm2cr/VTVq8k2dY3+xmqHFPQlQtp4K4hBNUYcOpZOCvf/PBzDXdbEYlNMCt0bA==
X-Received: by 2002:a63:2107:0:b0:3fb:ac79:50ed with SMTP id
 h7-20020a632107000000b003fbac7950edmr12877684pgh.105.1653898769559; 
 Mon, 30 May 2022 01:19:29 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:ae1c:3d63:abec:1097])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902f64100b001618b70dcc9sm8537900plg.101.2022.05.30.01.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 01:19:29 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v10 2/4] drm/mediatek: init panel orientation property
Date: Mon, 30 May 2022 16:19:08 +0800
Message-Id: <20220530081910.3947168-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220530081910.3947168-1-hsinyi@chromium.org>
References: <20220530081910.3947168-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 31 May 2022 07:45:33 +0000
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
Cc: Rob Clark <robdclark@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Alex Deucher <alexander.deucher@amd.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index d9f10a33e6fa..3db44d9b161a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -822,6 +822,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	ret = drm_connector_init_panel_orientation_property(dsi->connector);
+	if (ret) {
+		DRM_ERROR("Unable to init panel orientation\n");
+		goto err_cleanup_encoder;
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.36.1.124.g0e6072fb45-goog

