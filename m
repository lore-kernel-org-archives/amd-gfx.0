Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01C7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311F910E585;
	Tue,  8 Feb 2022 08:26:48 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000B110E56B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 07:37:23 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 p22-20020a17090adf9600b001b8783b2647so1326199pjv.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 23:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B51vztbAqanx3odcGYslN+f+8QXuSl3IGdZkOcgCEP4=;
 b=B11JIsqRugzE1lPzLbVrLBxQRW5fnSgxLSLKgwr1IROc+g9ZzYhWrC1z2DTdGwYxxc
 zTZC5C6/ehGlzMo1J6qtuwveXNMaFeY7njbnbEiu43w4jwaanMcHAXwYob4oTe4haPpH
 OSqw2rNF9vvlgVMfdSEmvclOIi10EZASOCcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B51vztbAqanx3odcGYslN+f+8QXuSl3IGdZkOcgCEP4=;
 b=kMwIec2W64W7PFOGg0IDFMRaWymBcCoY3DNw7rocn1jL6U69ysvy/gFnvDRYOgnwmW
 YrLmaUSnf6mJ6r0r3HeTvuRfJfdMkywK/hT3dhJgrwMIPBy7lYPyxiwESRxz3FNYBPI6
 h9CgoYcHhDsimCRBpMiz5GKLrehYtCZiJTffwZ+NaJHKtyPM8zdYh+ItahI8+liFxzf4
 oW0zTeVDxnCDKndyQr0FBwG4+5d/LHS5osj6ylvM1BT5DxwKlz2trbbusSqNsPDbDw/T
 qvQ+5WAZusC+zA7fQ4Y0fWaOl4dnFhJEcSICO6zUPGurEjU+vAJoQst7WcXBHUiuoUCo
 Erng==
X-Gm-Message-State: AOAM533tpf+1UhKwY/Grua2306D4T7L+3//pnHVyoM9fxi+m+B9neSir
 AWKzf0hlO38xFNKpR0nj1R84qg==
X-Google-Smtp-Source: ABdhPJxwrTpJBtY7yw1Sd0APOFBVLEGy3Kepc+/jvxRR/t7rzd5FBc9Yf4VRdbT05jYEsKVObL+Oiw==
X-Received: by 2002:a17:902:7609:: with SMTP id
 k9mr2997567pll.143.1644305843446; 
 Mon, 07 Feb 2022 23:37:23 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7d9a:166e:9d34:ff4f])
 by smtp.gmail.com with ESMTPSA id ip5sm1677243pjb.13.2022.02.07.23.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 23:37:23 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v7 2/3] drm/mediatek: init panel orientation property
Date: Tue,  8 Feb 2022 15:37:13 +0800
Message-Id: <20220208073714.1540390-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208073714.1540390-1-hsinyi@chromium.org>
References: <20220208073714.1540390-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Feb 2022 08:26:44 +0000
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
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, devicetree@vger.kernel.org,
 Simon Ser <contact@emersion.fr>,
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
index 5d90d2eb001935..491bf5b0a2b984 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -965,6 +965,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
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
2.35.0.263.gb82422642f-goog

