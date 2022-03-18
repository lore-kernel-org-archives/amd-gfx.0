Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 13:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A2D10E7EE;
	Fri, 18 Mar 2022 13:28:23 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E099E890E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 08:29:18 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id h2so8882078pfh.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q2qDv8+2Xs33bi39/5/bjWNq0xuzMLMZxKb+gV1x31A=;
 b=eTONqs9Y3piBGOdMGuMMcivDYzwSqMFZNucfhrjl17FHlTN4WIDwk19K4HOLMrk1iG
 Z9JW2BgOFS6i/9zHUZ4edoYzRasX/YYBjOmMTiYZs7tNSG0obMlHx/UiAhEyi5mPC4pm
 v6CMgLmDzK6uqrkCKkhh8Yn/oXduyc8b1UTyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q2qDv8+2Xs33bi39/5/bjWNq0xuzMLMZxKb+gV1x31A=;
 b=fzLU2X2frrJzOEYejXzT6CfsxiHh7wSZK9WHZqV3QVdIBYAGX2GEB3aeR7cnOmIDhN
 e7oc9uz/t8NYyt7mfjFOVyRTtnAnQ9F/DWWWDUMkrvce3K867OiByCa8w6FjshLorHj5
 OY99dkwOqCNj+UYMhuGlJc0hf84bRsKi6yOPHebFkHg5HQPtviuZtX4djfMIqWySw/BW
 /Ag7Ytkij0PqOauruyoj5iHidRCOYM1NCrXjFoeBwE70fd1taqm/i7OKBEzvsfhW6V6z
 8wIIQC2OYVCXoyEjly95KpaV3Ujpn51fXEBQrfHul3lZyTU6RvIRgOO7VH6GzKeUYqAI
 Kkkg==
X-Gm-Message-State: AOAM53237KsROPKYXe4cXvtQCa+w4zFgyrRo0I2LFVYWn9L3J/nPgS+Z
 QV1R0hn77tewkh8tk/5zLU/0PQ==
X-Google-Smtp-Source: ABdhPJwY+UTwJjQ5VdFDo/eVbZpRc9OL3AwGqrGv0hDioITcQk7K+bwpwLu/Vcu5+u/31peEfDYCaQ==
X-Received: by 2002:a05:6a00:1310:b0:4ca:cc46:20c7 with SMTP id
 j16-20020a056a00131000b004cacc4620c7mr9191847pfu.44.1647592158327; 
 Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:435a:ce78:7223:1e88])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 01:29:18 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v9 2/4] drm/mediatek: init panel orientation property
Date: Fri, 18 Mar 2022 15:48:23 +0800
Message-Id: <20220318074825.3359978-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318074825.3359978-1-hsinyi@chromium.org>
References: <20220318074825.3359978-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Mar 2022 13:28:22 +0000
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
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Emil Velikov <emil.l.velikov@gmail.com>,
 devicetree@vger.kernel.org, Simon Ser <contact@emersion.fr>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org
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
index ccb0511b9cd5..0376b33e9651 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -810,6 +810,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
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
2.35.1.894.gb6a874cedc-goog

