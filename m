Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EF0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 13:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 340EA10E7EA;
	Fri, 18 Mar 2022 13:28:23 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135E510E5F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 08:29:13 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id i11so5774146plr.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZerwMZnU5WRGenUWw/mrV6k1v4q9EhMydhshaosUPPY=;
 b=T2JR3/lfNpGKK7qASyH6+wW97BBOWNrh7oRmcfnmWSqfgDCBAwtyhw6+z45yNahIVS
 eT7DsjSjEvXTznTI7qXdOGBWQS7eFEssrIgW0IBCHbilYllZhz4kW2weUObdWIu+O4X8
 KFf9ujVOZylaa3ymqWZq66ufRx7SrPJ6hbHD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZerwMZnU5WRGenUWw/mrV6k1v4q9EhMydhshaosUPPY=;
 b=hHkO0jy2o8N83MwHgMUR315dKQJgDXOAA6UXsqw82oBiU8FOSWtDApGt9f2oliavLQ
 7SHTLN0QQIUkb4I7vpqToZwAopeqIJbJqRfH4AedjpZRAE15/UoKMvkX8ZRJyiWMm+T2
 ybxq/Ke/9wS3O3FWbUS+2OvcmdhcZk69We3LZvTJTImOZOTbHSpkWl31m5Vjcpgy38iX
 ew6+raH2r1rEObhd9wPIQ7hSMX2KosavBPNaOj0UmA43S4lOumZrn7sLrITER5of/Cuk
 pWbF6YfV82zFuSNikRaCXZiRig6B25l+HeMk3HeHxtoSbxEcs7TTRM6PHn07VQ/jvN6H
 cu7A==
X-Gm-Message-State: AOAM5334rSp/q7KcNKEEEqIvNDPXM4Ybmzpq2ZMouJay9xggVLYxBrzj
 SKg+RuhVzF8O/RIDr6ueKpImBQ==
X-Google-Smtp-Source: ABdhPJxSlFaBTNqCJx14g1bDgmJ+YaO+Pg4LlRrGaMoIJ9J2tXiqSbojTVGwkQAUer85nUyOr+wzKQ==
X-Received: by 2002:a17:90a:ba10:b0:1bf:6900:2c5d with SMTP id
 s16-20020a17090aba1000b001bf69002c5dmr20601000pjr.36.1647592151148; 
 Fri, 18 Mar 2022 01:29:11 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:435a:ce78:7223:1e88])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 01:29:10 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v9 0/4] Separate panel orientation property creating and value
 setting
Date: Fri, 18 Mar 2022 15:48:21 +0800
Message-Id: <20220318074825.3359978-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
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

Some drivers, eg. mtk_drm and msm_drm, rely on the panel to set the
orientation. Panel calls drm_connector_set_panel_orientation() to create
orientation property and sets the value. However, connector properties
can't be created after drm_dev_register() is called. The goal is to
separate the orientation property creation, so drm drivers can create it
earlier before drm_dev_register().

After this series, drm_connector_set_panel_orientation() works like
before, so it won't affect other drm drivers. The only difference is that
some drm drivers can call drm_connector_init_panel_orientation_property()
earlier.

Hsin-Yi Wang (4):
  gpu: drm: separate panel orientation property creating and value
    setting
  drm/mediatek: init panel orientation property
  drm/msm: init panel orientation property
  arm64: dts: mt8183: Add panel rotation

 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
 drivers/gpu/drm/drm_connector.c               | 58 ++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  7 +++
 drivers/gpu/drm/msm/dsi/dsi_manager.c         |  4 ++
 include/drm/drm_connector.h                   |  2 +
 5 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.35.1.894.gb6a874cedc-goog

