Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD14C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 08:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DA910E99A;
	Mon,  2 May 2022 08:49:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7136B10E99A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 08:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651481342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g1EGMUSX4uhdpumN1AqArSCJZUMcx2qk+SIJN7jkMXI=;
 b=P0h/w4e8bqfdcfuw0MzVuqo30xCR92VaVbU/cZWVK81Y/aYl1Hulb/zDJv3U8VC527kV4m
 U3pcdK/902HbQJMV5WWF5w9oFoD/ZwFVMpxmPmcoChf4Hyn5g1NkQU2mmlN8tjAgL6rYg4
 MfeBdRSBapuQll01D5v+FmDRUTMF3OU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-X4Lko7mAMm6IFdFjuclDhg-1; Mon, 02 May 2022 04:49:01 -0400
X-MC-Unique: X4Lko7mAMm6IFdFjuclDhg-1
Received: by mail-wm1-f72.google.com with SMTP id
 v191-20020a1cacc8000000b0038ce818d2efso4844059wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 May 2022 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g1EGMUSX4uhdpumN1AqArSCJZUMcx2qk+SIJN7jkMXI=;
 b=Zqib0fIqhyb65ilrj6mJkCGG7l/0AuxmNZYhoej/FAaiMHSYYg8q9bgYu/3/F+Rc33
 j5YlmNpNAJmAED1AjqwciSr+aM5E6E85WAokb9LQmeEanfNujuu2GFiDCFGqXSebQKzG
 jVvkkCBv/GpVKeAD2IHouI+Y/7cdRjxS1Pc0lVSU0QxPB7RXcB9AOPgd1T58WKFAHhKI
 h1LEZE2Bamwq89Sbw+ae3vMb1PIxN+f5aY5QKfEtSiBO5EBVvvaE8AUnVUYaEUVgvVyu
 7ipL/kuaTN2D5OdER+1egrBze5CVybGPGA88YKJnaSBamWYNABn2A726tSzfXP7vXgk2
 qnlw==
X-Gm-Message-State: AOAM530qyqu1cmugxs+RYvCALMQg+monxbhjeiaVGSocBzgFiU0ZAkGB
 lpqMCGK69L9zem5CnbVPwWVbUc9ZnEB9GRhz4gMnS2cWgfFSEij4Ch8yyTQe+Y0T2Rkpq1xOwwP
 rukhz3Nj9/ZU2t+sC7ErVAh2rlQ==
X-Received: by 2002:a1c:7512:0:b0:394:16ee:ab9b with SMTP id
 o18-20020a1c7512000000b0039416eeab9bmr9917245wmc.176.1651481339936; 
 Mon, 02 May 2022 01:48:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1HDOH0L0J59jWzQqe8OCc8OrGCpxEDekTc2b0ViBR9lVxUT3tRNZw5Yfr7Gkyc9Gu0hnOLg==
X-Received: by 2002:a1c:7512:0:b0:394:16ee:ab9b with SMTP id
 o18-20020a1c7512000000b0039416eeab9bmr9917168wmc.176.1651481339590; 
 Mon, 02 May 2022 01:48:59 -0700 (PDT)
Received: from minerva.. ([90.167.94.74]) by smtp.gmail.com with ESMTPSA id
 i14-20020adfa50e000000b0020c5253d8c6sm8032307wrb.18.2022.05.02.01.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 01:48:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm: Allow simpledrm to setup its emulated FB as firmware
 provided
Date: Mon,  2 May 2022 10:48:27 +0200
Message-Id: <20220502084830.285639-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: Xinliang Liu <xinliang.liu@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com, Jerome Brunet <jbrunet@baylibre.com>,
 Samuel Holland <samuel@sholland.org>, Kevin Hilman <khilman@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, NXP Linux Team <linux-imx@nxp.com>,
 spice-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Alain Volmat <alain.volmat@foss.st.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, David Airlie <airlied@linux.ie>,
 virtualization@lists.linux-foundation.org,
 Mario Limonciello <mario.limonciello@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Dave Airlie <airlied@redhat.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Maxime Ripard <mripard@kernel.org>, John Stultz <john.stultz@linaro.org>,
 linux-amlogic@lists.infradead.org, Evan Quan <evan.quan@amd.com>,
 Yong Wu <yong.wu@mediatek.com>, Boris Brezillon <bbrezillon@kernel.org>,
 linux-renesas-soc@vger.kernel.org, Solomon Chiu <solomon.chiu@amd.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Brian Starkey <brian.starkey@arm.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Stefan Agner <stefan@agner.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabio Estevam <festevam@gmail.com>,
 Hao Fang <fanghao11@huawei.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Chia-I Wu <olvaffe@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Chen Feng <puck.chen@hisilicon.com>,
 Alison Wang <alison.wang@nxp.com>, Daniel Vetter <daniel@ffwll.ch>,
 Tomi Valkeinen <tomba@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Tian Tao <tiantao6@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Emma Anholt <emma@anholt.net>, Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Paul Cercueil <paul@crapouillou.net>, Nirmoy Das <nirmoy.das@amd.com>,
 Marek Vasut <marex@denx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-mediatek@lists.infradead.org,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Yannick Fertre <yannick.fertre@foss.st.com>, linux-mips@vger.kernel.org,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jyri Sarha <jyri.sarha@iki.fi>,
 Lucas Stach <l.stach@pengutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

This series contain patches suggested by Thomas Zimmermannas a feedback for
"[RFC PATCH v4 00/11] Fix some race between sysfb device registration and
drivers probe" [0].

Since other changes in [0] were more controversial, I decided to just split
this part in a new patch-set and revisit the rest of the patches later.

Patch #1 is just a cleanup since when working on this noticed that some DRM
drivers were passing as preferred bits per pixel to drm_fbdev_generic_setup()
the value that is the default anyways.

Patch #2 renames the 'preferred_bpp' drm_fbdev_generic_setup() parameter to
'options', and make this a multi field parameter so that it can be extended
later to pass other options as well.

Patch #3 finally adds the new DRM_FB_FW option and makes simpledrm to use it
so that the registered framebuffer device is also marked as firmware provided.

[0]: https://lore.kernel.org/lkml/20220429084253.1085911-1-javierm@redhat.com/


Javier Martinez Canillas (3):
  drm: Remove superfluous arg when calling to drm_fbdev_generic_setup()
  drm/fb-helper: Rename preferred_bpp drm_fbdev_generic_setup()
    parameter
  drm: Allow simpledrm to setup its emulated FB as firmware provided

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  6 +++--
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/ast/ast_drv.c                 |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
 drivers/gpu/drm/drm_drv.c                     |  2 +-
 drivers/gpu/drm/drm_fb_helper.c               | 25 ++++++++++++++++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |  2 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
 drivers/gpu/drm/sti/sti_drv.c                 |  2 +-
 drivers/gpu/drm/stm/drv.c                     |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
 drivers/gpu/drm/tiny/bochs.c                  |  2 +-
 drivers/gpu/drm/tiny/cirrus.c                 |  2 +-
 drivers/gpu/drm/tiny/simpledrm.c              |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  2 +-
 include/drm/drm_fb_helper.h                   | 22 ++++++++++++++++
 36 files changed, 80 insertions(+), 39 deletions(-)

-- 
2.35.1

