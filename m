Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7026C4CECE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6D120637
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFHap9SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6D120637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54BE6EC67;
	Fri, 13 Mar 2020 20:18:05 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497FC6EC6A;
 Fri, 13 Mar 2020 20:18:04 +0000 (UTC)
Received: by mail-lf1-x141.google.com with SMTP id 5so1810296lfr.2;
 Fri, 13 Mar 2020 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BOrKdqp0xX849tkbGYoL5GifZ0fJWuSnmKvneHoBEPI=;
 b=SFHap9SA3MQWq/rDzTcpj95GukhT+WmakBXzY2/W/iVbaG3CYS78HgdDNCnklu2dLE
 kFU0QDG9SImIs7hlVZiJyUAgm7YUizziMveCoCVIzJ9O8cqrKgolPpoV6am7DfhU89XJ
 ltxCH8nvbIYs393MHpsDO6BhvtaKdvLKO1cCTYQMgnrpgZsHazgpH66LACi+70HhiJ6l
 AJYv+s/W3gch6gNZXXxxbLFCll+TfRRcrcTxa5xQeHRhtYaQSbszeLTX6zP5G5Jz7Jm/
 gUDVBMvSktGH2MZ2dnKv8dJAIQub63dYzfpzuua04+X6h9+JvUqOMVK/Ctt+DZXCV3Yi
 OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BOrKdqp0xX849tkbGYoL5GifZ0fJWuSnmKvneHoBEPI=;
 b=sNgEe6sL5fmsJvZg6DENjvlvAbH7W9tUFEMsbqmj4tM2yhOWqgIQdPkAPP6Pu2sgcW
 J2ymXhb+aWulex4AiLGksIVilwnhF6S5fg65oYkqyMOqyTVr92rih92xIxMoWDrWDm+M
 KQfn9JW2YE4MUz3cicr1fQFszUMaqnvm2p7WFv0kz6hJlSLMn5mj558Dvf/Q5vZMpKz1
 BIdx/vMgui+sQVkry75haJZOAMgFS7yxkJigvtXHQpBwwo0Y53tKmMeY/GOpMsGtqShf
 2EXHljWctpLukVSoxYN+N/yGC/j1fPg7fN5pTBFwY/28+LTNqJpNf/5VB1BDab73RloZ
 OEUw==
X-Gm-Message-State: ANhLgQ12ZGewcw6wIbx0ApZqogI+ynRapw1wqycQZMJ2QT6NDlb+jP+6
 OOXyqPseLc7Sa5TRfhKXf7k=
X-Google-Smtp-Source: ADFU+vuWMe8I2528Uyu2tKaIGPqCCGIWF6uu2OphKJd6rnCU8MYCRJ3bIyFwbbl07L6oMFBFxGQoig==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr9463704lfc.111.1584130682588; 
 Fri, 13 Mar 2020 13:18:02 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
 by smtp.gmail.com with ESMTPSA id
 v10sm30774074lfb.61.2020.03.13.13.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 13:18:01 -0700 (PDT)
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v1 3/3] drm/atmel-hlcdc: Use drm_encoder_init()
Date: Fri, 13 Mar 2020 21:17:44 +0100
Message-Id: <20200313201744.19773-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313201744.19773-1-sam@ravnborg.org>
References: <20200313201744.19773-1-sam@ravnborg.org>
MIME-Version: 1.0
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>, Jose Roberto de Souza <jose.souza@intel.com>,
 virtualization@lists.linux-foundation.org, Gerd Hoffmann <kraxel@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-stm32@st-md-mailman.stormreply.com,
 Emil Velikov <emil.velikov@collabora.com>, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 NXP Linux Team <linux-imx@nxp.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Boris Brezillon <bbrezillon@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

atmel-hlcdc has no need to extend the functionality of the
encoder, so use drm_encoder_init().

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index a845d587c315..96e0d85748d2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -22,10 +22,6 @@ struct atmel_hlcdc_rgb_output {
 	int bus_fmt;
 };
 
-static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static struct atmel_hlcdc_rgb_output *
 atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
 {
@@ -98,9 +94,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 		return -EINVAL;
 	}
 
-	ret = drm_encoder_init_funcs(dev, &output->encoder,
-				     &atmel_hlcdc_panel_encoder_funcs,
-				     DRM_MODE_ENCODER_NONE, NULL);
+	ret = drm_encoder_init(dev, &output->encoder, DRM_MODE_ENCODER_NONE);
 	if (ret)
 		return ret;
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
