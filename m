Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFD8C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 08:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C39C10E1D1;
	Tue, 14 Nov 2023 08:18:13 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623F110E08A;
 Mon, 13 Nov 2023 11:24:09 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c50ec238aeso60840871fa.0; 
 Mon, 13 Nov 2023 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699874647; x=1700479447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Op/de/de9WVnMjIIu+X6jQDnWmnKOCxjgzgj2VkHDA=;
 b=ETiJdIxrCiymCDydg4ENXjR9Te2yvObiLkJSQMU1wdMq4risx6L0AtFtAhNQhe3XNx
 VLhszNtF0HX5Mox97rPdMRf4rsQmi58So3rKA+1wOs13CigEjiAcy58WCvvh2Ljl96pE
 t71lF0QZxQ52vwUQzR4sHM/4qiSTi/cAGxsffAxSuTbUjjXHOvRiYqYXJqM1HTlG5VDB
 dq0TuiR9IWtiu+6yZyMe1HYlGl64DwEPSiPGWwYe7PBgR6oZXbcV3xvj4MdMx38Po2EN
 JebtYH9FPLfF0F/wtFRrmw+k5WXvfdY+LqQQ3K7/eVcJIKo37RsVVC13r9/xaToFrqUq
 QYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699874647; x=1700479447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Op/de/de9WVnMjIIu+X6jQDnWmnKOCxjgzgj2VkHDA=;
 b=VX/jn0K56P1CeErYLZ5ayyRlVESf/pHsjUrsWW7PPUuS5e7EQXMZCtKEkNiqhVSPCq
 Di0AhEI6NTSXTTRdDkcMEXslXfjyFph9FK215WqQLYQcomEPEueB6VZC/af7CmmiZE8R
 c7DtbUgQEf3YvaxQVYx4eJaafEqyXepHa3ayisP4ZeIF5Dwa29sy1dmiHGxeKwaSSwtY
 CJtFtImMFldYIoB4fyylpFok7yCWzwAEE8OtsA8Pjs6AuX1G+rg4NpNgwPCYwwTP6stV
 e90/J3ew6CQpcK+b1+KTBTApVUipm3y5zPAcPWsfJ86LiLA5/VbdKR3CyQoLCFwmSNYd
 QqBQ==
X-Gm-Message-State: AOJu0Yxmpz+aBrx7GdrM/6c240WgfBFrdDbJvy5m258RixLwC5CK/V5M
 k+ZqdULEuF7iNcdgnbxxA9Y=
X-Google-Smtp-Source: AGHT+IEJsBMp4JbvFi4pspNX0Uzx9z5MBDoZN9PZxWzXZcpLsSgHiFtlq5yu+gjphO5CZmj++0wsZw==
X-Received: by 2002:a05:651c:1049:b0:2c5:1f70:a266 with SMTP id
 x9-20020a05651c104900b002c51f70a266mr4020462ljm.50.1699874647541; 
 Mon, 13 Nov 2023 03:24:07 -0800 (PST)
Received: from zotac.lan.
 (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de.
 [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 03:24:07 -0800 (PST)
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Wolfram Sang <wsa@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/20] drivers/gpu/drm: remove I2C_CLASS_DDC support
Date: Mon, 13 Nov 2023 12:23:31 +0100
Message-ID: <20231113112344.719-8-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Nov 2023 08:18:02 +0000
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
Cc: dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-i2c@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c |    1 -
 drivers/gpu/drm/radeon/radeon_i2c.c     |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 82608df43..d79cb13e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -175,7 +175,6 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 
 	i2c->rec = *rec;
 	i2c->adapter.owner = THIS_MODULE;
-	i2c->adapter.class = I2C_CLASS_DDC;
 	i2c->adapter.dev.parent = dev->dev;
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);
diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index 314d066e6..3d174390a 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -918,7 +918,6 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 
 	i2c->rec = *rec;
 	i2c->adapter.owner = THIS_MODULE;
-	i2c->adapter.class = I2C_CLASS_DDC;
 	i2c->adapter.dev.parent = dev->dev;
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);

