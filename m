Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4499107BCD4
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED27610ECC3;
	Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxKogpGm";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02A410EC1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:41 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-467161c4ba7so1424212b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408281; x=1774013081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu46xPMmyhe3j2aI3EiB0/ULgdgDrucXaD4Bb/DoM7A=;
 b=kxKogpGmhw7mwAsLuF/cNhURBdNMPRLwWlsYMzzTJVmty2nGwGnZPB7dLsSRHoCloo
 To5TQop6InxG4TKSA08WuaCfUSpp76Yng+7Ckt6UgrO3LF+u1XqYAsfs9QLPXr+1cpY8
 7OzlzilvssTF/r4Cnz957a0behSAG0Jfg2TLA9aT4vRDZMs0fAveRmHYyZF6rtw/6C4Q
 iW9Yeq/xAnY5OY/YDNN3Dm1gQiNtKgH7/A5yLCFJT3AW/r0HzO8pOZEh1ogIYNd4Q8Qq
 PnNX25fMJGlkiHGfkmldWR8KLPUKiRaAbZO9MUPKAQ0MGnr/42OZB93JbTjksnFl+UfU
 DbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408281; x=1774013081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iu46xPMmyhe3j2aI3EiB0/ULgdgDrucXaD4Bb/DoM7A=;
 b=MXOMuepTbDAjpZD51aWMR4LmeoaKiW0tbgcTSeWo7gyuABEHEnkmge8O+viIuo3s12
 mjhTAL4DB9kdLzHN4YKC/3ZFEy1dkwUFYOAeHklw1Y6ZfUA91PWLk2jD4ltSjThEw2+O
 7TUhhfYo8LtGBUvxRygmppjS8rwfgkr+kY1dwwIhiqaGGcPJoAXQjPJA6X39oxEXyGod
 TCq8Ad27cl8SUsOLApcoyk4a+uxttTM0jca/GqtNQP7vuDF06Sd2f3VvyKCWNmLBXKrD
 tjxRwmljIleoQ9luOwk7xa5ymNQhFJW+jttTI75s8W/scrPCwmBtNXjfIWc1oVE2AGkv
 IFnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD1+doPR/LZ7PMFTwh/CTEAYnC9vJ24lECfWY/1yBnsL/0LVa79uXqUvQ81IBOJRJtCODMLAGY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp0/ZOdXsKYwIVWX9fdFmfAz+XTrfDa6Hq+8BblcqcWy8PAFeX
 OW4efpFVvFVQimTwTNoa4KmxkkOEcWFFSVS4oaYHt7k0SN5Denpd7Wu9
X-Gm-Gg: ATEYQzz0a7AXHvCb/wNtQg10nJboVC6CpWLACLuzMVxmU4b0Nx+JXqS8pohfi0m/16B
 EeSM651MmYRif7YMrIrUNGOhhQ47CuFoxtBPpy2h51yEFfBGf9CAGsG2pdNFCNCDvhq1hx8g34x
 ckXEu2p2dTYcLWMW9QqE1lN368Mf3O4x3mXt9nyinrBuitgVz+Q6eiqm+CUMaLgueJVqvt2wao5
 nh6xEutHryWAAPeo+lGhsbQgZbd3azUeNy0hwhLZAiYVMNdVKI/nnfAGvPjB1H4tlA9QGA3RaoV
 u7X0M/oh0lOQV8PzPIT1Ct4jYhCdkqQF3XF/zlEKslcFsI56xiBCZC05h6FNwc1tC8ztf0ZLc8I
 Rb2+Sd3Tzs6j1g8MugNpr8WOJMJTmtTTS7UQKfJwNqFoQena7KK3Ad6KRV0C12tlin3lqN8A4uy
 kz1V1Vq5T8X6/98AIRLKHFny6YaNbhBciZi/JMDSSCD7vEOq9M
X-Received: by 2002:a05:6808:c40d:b0:45c:80bc:964c with SMTP id
 5614622812f47-467557e5b52mr1847301b6e.26.1773408280854; 
 Fri, 13 Mar 2026 06:24:40 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 49/65] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Fri, 13 Mar 2026 07:20:14 -0600
Message-ID: <20260313132103.2529746-50-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

The gma500 has 126 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f5355f..92b18c76b44e 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -41,6 +41,8 @@
 static const struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * The table below contains a mapping of the PCI vendor ID and the PCI Device ID
  * to the different groups of PowerVR 5-series chip designs
-- 
2.53.0

