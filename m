Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C545DCE7A8B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 18:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE20D10E935;
	Thu,  5 Sep 2024 18:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sfVGEzZo";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CF110E6B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 08:01:50 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so2720879f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 01:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725436908; x=1726041708; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPGRyZgor+ICRd/PoCXOyw7qG7eZQ2SIyPr9G8EXgT8=;
 b=sfVGEzZoKPxkcJ47vcerr2fQTqINigy3ec60W9vkYOxmLwF7xJh8vZ6n6W5MHxQyUW
 DOLw9dn8rBrRkWpX8TyY/Adsrvim2WLwzgeZwiLpsco6sfiQ0Ii3DS90Yjbb/WsTGP8+
 /0cqpNTbnj8XKreV1jmhM89BSVW3V9f4CPE8V87+73HCBbIMeZz8hLZpNeyjWhBVJ52F
 FgkX5lTMuSBV4/spCyogyJYxSWAYkdufzdlynLP36lC0+2xg+/5jHTdmGrjVkWJCoN49
 wZXGmIEWVvdNB7I93/Vig6nxJMxDYO8qNYYGMh9F89Bzq8gKkbazamGhs/ll7SVTOujt
 4oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725436908; x=1726041708;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPGRyZgor+ICRd/PoCXOyw7qG7eZQ2SIyPr9G8EXgT8=;
 b=c0U7vygOEeMbprK5sSnl88Odk+q6umGmzd0SORbBAQiHBffMpi9i32BkOIU6T1Wfgb
 Zk5n7y24yP8ctTxiHf1Yo0O9YQcA3EqxLh7YVW8xl0GnwSooa7FPFv55ycKbHTEFFA10
 SVQFZP4F/QTykCNDZMGQHeWJnt8WkKvQdJWe9OylmAIMAcIddwseqkMYERdkplmNkTqp
 rehD45WDHuh+qSPgOaeTD6uPP2hGdyp8jZ97a+A3KZsdd3xGb6FjCedl3FjEuGiXA5ep
 POQkYJCwAoOAJayMcObClSTmpkSgFMLqcwtNSjs87KFxBys4unpGl4rySifCX3oMn8PE
 2VhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRGKjzCARLvEQkzLkcB9ia7CCU194PHVO5Q5YMmhmxLzhg09+rLnBI602usCt6ZN+a54FxPeHZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRIYMYCi1QN+0J+6fqyxsJ0kWppShPMKmcEW2cO3m5sa7rfXdh
 kv2bnbApXMcQvaE8nrB3eyI/uXqM37SsDO9huUOLQsppRYlCp2k9Q5qmXb2UlXo=
X-Google-Smtp-Source: AGHT+IHKnu53nThpZGWQqPEljZp+OwL7w/w0X/6FdYop1bPaA9q53NpXOxJ4zAW3vWCLnYcSEXQUDw==
X-Received: by 2002:a05:6000:144e:b0:374:d2a3:9806 with SMTP id
 ffacd0b85a97d-374d2a3989cmr5576698f8f.2.1725436908416; 
 Wed, 04 Sep 2024 01:01:48 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c4059811sm10059317f8f.4.2024.09.04.01.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 01:01:47 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:01:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiadong Zhu <Jiadong.Zhu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, shaoyunl <shaoyun.liu@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 chongli2 <chongli2@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu/mes11: Indent an if statment
Message-ID: <4152e10c-2ec5-4ac3-be47-c97fcafdb35f@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 05 Sep 2024 18:49:02 +0000
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

Indent the "break" statement one more tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0f055d1b1da6..ee91ff9e52a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -415,7 +415,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		/* wait till dequeue take effects */
 		for (i = 0; i < adev->usec_timeout; i++) {
 			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
+				break;
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-- 
2.45.2

