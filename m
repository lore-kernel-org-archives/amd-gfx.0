Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5D5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 13:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 286AF10E934;
	Fri, 18 Mar 2022 13:28:24 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6735689C59
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 08:29:22 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 kx13-20020a17090b228d00b001c6715c9847so5450130pjb.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wk/pqrVyJD3dZfuBlDvR3gvRx5qETAjydlq9k9fo89I=;
 b=MBv2nbtC77uuFP6FO9vF3JJunvP31eEWqLFqoiGIM3/E0+IkznfVBrTBIuGgXWfVv9
 5TBZHlNgegYmt3aqmPENYo8GhMqjeRQgRc3d1sr5+ApsSsOS0LqCL96pxslRickdXpwV
 ZNw9ExgEXTLbAqCs2ncXkhyskWqy7wd4OrW7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wk/pqrVyJD3dZfuBlDvR3gvRx5qETAjydlq9k9fo89I=;
 b=A6PhveXicI8aDOqToDVrhy2UF9KnLMwAkV7LyQCyeNdpqnyMYgsFJUdpx+uXTbcxH3
 FyULsJTBNRi0Sg+wqJVspDAdP/wUzKK09+aSH4iBUYCHJLeYW+9VE0edntgeL+MtXTIh
 jSzJ5EcJFVhjHluUjUoApZJ3kPJiU4n+SfX7AC4uKhBG1nAJGs+6ZQaHmhzW17bMHkoX
 mYarVnb/SKMpsZ8oae55A9KPMf/vnxDUfahY4T9EcwDsSDi/T9C8AEBeGNFvgj7ZgE2C
 Tu93ttVJuL0nfyqt1dI6V1QTJA3lbM4oJ9UU15/reF+DP6Jp6rRbv3swnypxaGXVjngC
 /ghQ==
X-Gm-Message-State: AOAM533ezZSQ5RVJV5CO40wRjDxZHtL6fR1Hyui8XJP97A9O6Jjw9g2c
 7RcxjHhNZjf6oJUjUNLOibqRdA==
X-Google-Smtp-Source: ABdhPJxZr+WrsVRD3EBe7ULBmlgFiXmGvjfKG8gVhn0pmPIZv9TgokVPdh4o8x0PeMOmdu3PzI1t6Q==
X-Received: by 2002:a17:902:e944:b0:14e:dc4f:f099 with SMTP id
 b4-20020a170902e94400b0014edc4ff099mr9105752pll.161.1647592161915; 
 Fri, 18 Mar 2022 01:29:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:435a:ce78:7223:1e88])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 01:29:21 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v9 3/4] drm/msm: init panel orientation property
Date: Fri, 18 Mar 2022 15:48:24 +0800
Message-Id: <20220318074825.3359978-4-hsinyi@chromium.org>
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
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 0c1b7dde377c..b5dc86ebcab9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -627,6 +627,10 @@ struct drm_connector *msm_dsi_manager_connector_init(u8 id)
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
+	ret = drm_connector_init_panel_orientation_property(connector);
+	if (ret)
+		goto fail;
+
 	drm_connector_attach_encoder(connector, msm_dsi->encoder);
 
 	ret = msm_dsi_manager_panel_init(connector, id);
-- 
2.35.1.894.gb6a874cedc-goog

