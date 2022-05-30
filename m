Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9BAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 07:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B53210F56B;
	Tue, 31 May 2022 07:45:34 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB4910E048
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 08:19:34 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 v11-20020a17090a4ecb00b001e2c5b837ccso3792605pjl.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DngeuiJs1gkZdqFRMCVvHoL93k8N7yG0MeWJK9ZEK3k=;
 b=IqL1Mg8WnZDtXb3yyaSQRaeibgzLzDCSjzxs2JJ81/LU/mT9HMq1woD+CE/FphDXTH
 GnabHy2Ip2oVOYcPjiQ1WwYT2VtY4CQG3boKYbVWHxYOBjBrj1GEcBMoB1z1qeA4GCV1
 8WB0hTYwZDmiOgIt5tnLdJsOq3i7hVAzVDu9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DngeuiJs1gkZdqFRMCVvHoL93k8N7yG0MeWJK9ZEK3k=;
 b=ASEBrGOFbaj3yQSrZVau0nUhUiDAPtW19Xdef0bhCH46cQNAeNQalyHBb7Me77jAZ/
 RQetlYJfSF4QLDGyhBAoSl59+nLjboO5QPcDO6PoJyn8+n1WiQrPwkJCIQQjc5hHckLK
 ucWkA0k/1RErZ6GyXz5XymuS6SI95m9v6WHLoG3Lk5vOI9p92j/3JcnBjerZ8N1UWBa2
 Q297aY8AInj48l8FYN5/gGeUKdbSFgtLRNKMekRmE4LRdtw6PDgcEwxWhLc9I9K1EnEz
 JIWVCOVPeergVpKkYU8UXpdHpVfDcrRwzJMO/UJcQJieweXSXipD2Vw6A7rgy3PqLXkF
 iF5w==
X-Gm-Message-State: AOAM532hcpoOC+uUCjt1lJR2mDsg7+n3O+dg8V3gQ8D4ilQknAzmdxeu
 5lZHXrbjJhW+r4GYXFk6NxO/4A==
X-Google-Smtp-Source: ABdhPJwMisSwwoUx/1CnfaxFxra5CHlr+0BrN6Jv+hKSLKGk6/BuFuOZ6hgtXERtcSsiW+uir2UNtw==
X-Received: by 2002:a17:90a:6941:b0:1e2:f37a:f889 with SMTP id
 j1-20020a17090a694100b001e2f37af889mr5209221pjm.160.1653898773678; 
 Mon, 30 May 2022 01:19:33 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:ae1c:3d63:abec:1097])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902f64100b001618b70dcc9sm8537900plg.101.2022.05.30.01.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 01:19:33 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v10 3/4] drm/msm: init panel orientation property
Date: Mon, 30 May 2022 16:19:09 +0800
Message-Id: <20220530081910.3947168-4-hsinyi@chromium.org>
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
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index cb84d185d73a..16ad3d8fab4d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -669,6 +669,10 @@ struct drm_connector *msm_dsi_manager_connector_init(u8 id)
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
+	ret = drm_connector_init_panel_orientation_property(connector);
+	if (ret)
+		goto fail;
+
 	drm_connector_attach_encoder(connector, msm_dsi->encoder);
 
 	ret = msm_dsi_manager_panel_init(connector, id);
-- 
2.36.1.124.g0e6072fb45-goog

