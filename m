Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED16BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 07:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABF210F568;
	Tue, 31 May 2022 07:45:34 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CC610E11A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 08:19:21 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id a10so1075496pju.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pBLLK5jVhwbNway5d1jcnH/mwgI9yxE1r2VmUrlYtDU=;
 b=LLgjKgp2+ro4rOIKxUWfMFimQjfxFWRvVWoMjpqWUvgtX/IIENmwdkMHUIq88hcolf
 ROFZ7vAAUlY+NJsshhvUkkommU11wX7sGxpjL1CjmCeZgVV/zkVhk3p7u/ZyNujeoi9J
 QxRXyXc9nqN8qIybleH4/7N9FDZp9fBXbaLPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pBLLK5jVhwbNway5d1jcnH/mwgI9yxE1r2VmUrlYtDU=;
 b=5ZwempkJPUM+7VG+OaZvaXP97rcXbIK6kgHnMbdVWIX82bmwu6tOfYlS8Rpmz+zNqd
 MIzxby0HyjylmkXs8PsIp6M4nqMpfBADr37jUrc5kMwZw5k/zEfY1tQ3HmbEN5HEUtKr
 ULjMkwEbVwrw4cUURElCykV2qKQzmDhSbS5TvDLysrur/s5iQ2JtS5Dm87UGDLqlP2CF
 lA/YXwLKzZkZ+sqr1bDOMGTQjv0pr6W6p4hec9OeRUIDXXK95nD6yqll/KQbk+Y3m+x2
 Yp5mCHjPZ2pg0Jn19qmZVrcGqp0ojl2sqYFcMtyOAWAZ2qjYmRyXuTiQPhvsU64aEMh8
 gbEw==
X-Gm-Message-State: AOAM530bITxdZFMy8S0YSaDQ92p5CwvMl9ksmySZTJotK05V2bnSRnV8
 Y9yT9870pag5zJ7SOe/ETazqrgpfpopR4A==
X-Google-Smtp-Source: ABdhPJz+H5PQ1/wn0WMWpccN62eOSMQ6CsdGl2YYPW6OhEKjBgqYnlaum+TZJlp8G3W0bq500UZXIw==
X-Received: by 2002:a17:903:124a:b0:154:c860:6d52 with SMTP id
 u10-20020a170903124a00b00154c8606d52mr55869147plh.159.1653898761542; 
 Mon, 30 May 2022 01:19:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:ae1c:3d63:abec:1097])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902f64100b001618b70dcc9sm8537900plg.101.2022.05.30.01.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 01:19:21 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v10 0/4] Separate panel orientation property creating and
 value setting
Date: Mon, 30 May 2022 16:19:06 +0800
Message-Id: <20220530081910.3947168-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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

Some drivers, eg. mtk_drm and msm_drm, rely on the panel to set the
orientation. Panel calls drm_connector_set_panel_orientation() to create
orientation property and sets the value. However, connector properties
can't be created after drm_dev_register() is called. The goal is to
separate the orientation property creation, so drm drivers can create it
earlier before drm_dev_register().

After this series, drm_connector_set_panel_orientation() works like
before. It won't affect existing callers of
drm_connector_set_panel_orientation(). The only difference is that
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
2.36.1.124.g0e6072fb45-goog

