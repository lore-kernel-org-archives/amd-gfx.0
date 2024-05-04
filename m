Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8EFC25B5F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 10:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB41A10EBCD;
	Mon,  6 May 2024 10:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tlBJTZl4";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D06110EA02
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 May 2024 11:26:18 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-34de61b7ca4so295542f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 May 2024 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714821976; x=1715426776; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=acScVzoT0UgSxQf+NXyCSZ3pQCph88n8DycCWGq+e7Q=;
 b=tlBJTZl4Rl3+lhuvxwx5uRh3b9jd/4bo9bdZQl3IMeP3bqNfN0zcTqE6zhy2YL9xpt
 yyqIgmhH+xcg0VtZSTGTBAKPB9p+ySHyWh+YI1PoFQGeeRU6sa2T0ypsSfP82IAw2G63
 wZ28ebEUuNjzDmyQSi14496j9Uar8Cnj2AT+j3gusaC3/ZKEDGv+es0j6DCAHekv5Knm
 JHubgiSVa0sEhQPeD9Tf6lTkJw6krddSBx3FZIefNLAV+xmiRecS00WbXhsdmG9FP+C4
 bC4Mgn9/JBNMmHjuPHbbKr6HT7OY/gWkcif8jXEg/SrBOOMb+t79AC6suKHEKbp3q1w3
 cXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714821976; x=1715426776;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=acScVzoT0UgSxQf+NXyCSZ3pQCph88n8DycCWGq+e7Q=;
 b=LWHVnkt4mqHEN3JITahzmOpWpa4MSnRQiMeASXyJIhYKzxZGmx87FQXUTaLHl0wce3
 ynIHYjGo5EEYdPQD8SR/EsgLqFqV08Dd5JHgsKMras4YWM326qCxfutEtFb+8zN3SCpH
 poVt8HN+34MSJwBX01r8U4A3HzS3BYCYnh4ALSR9twCiml7wOC/5DtUZmG820kPhAfNH
 fLr8X7p9loFf9YRFL9yLmhVgmD4ywONhpPeJe1hnXwAzz8KIZA/+f6gP7ck9c4bygNl4
 ZEHUr9s7N6oVNPP5Q0+0rxoDxbJW/vbtn2Mr4RGsn28fvmczvX2hBk0QMVZ5C+6Y2tKX
 caBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQ3wmxvWya7AcTCjquivthytBxrvE6Z3tcWwC8lhA2cHa0EB/ODpf24/8ejViaQYgUljyD1vaiMZj1gad7lFVxHHaYjgmdIZvWz6lbw==
X-Gm-Message-State: AOJu0YwZKgz0CYtrKvM1zKFZRIy4Ppz7g1s++6EGH83kHx5+1qIc9PDt
 kJgyfoVxIZEIKQD0kidFZ1FojImmX4E1wYsRGzFaEIr+UIx5vqttEGgWAJ3jrk4=
X-Google-Smtp-Source: AGHT+IFhfIrzcRrSB3PRVXEa7IfD64x3DWvrLyolPJso7AtMaTEliUXy1Di5c3Y9F+bGsvZnwecfpw==
X-Received: by 2002:a5d:5542:0:b0:34d:1d09:f06d with SMTP id
 g2-20020a5d5542000000b0034d1d09f06dmr4990315wrw.13.1714821976417; 
 Sat, 04 May 2024 04:26:16 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 p8-20020a5d4588000000b00341ce80ea66sm6013320wrq.82.2024.05.04.04.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 04:26:16 -0700 (PDT)
Date: Sat, 4 May 2024 14:26:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Tim Huang <Tim.Huang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Ruan Jinjie <ruanjinjie@huawei.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Fix error code in vega10_hwmgr_backend_init()
Message-ID: <502fda28-fde7-4851-b17f-4d48848955bc@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Mon, 06 May 2024 09:59:59 +0000
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

Return -EINVAL on error instead of success.  Also on the success path,
return a literal zero instead of "return result;"

Fixes: e098bc9612c2 ("drm/amd/pm: optimize the power related source code layout")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 37c915d7723c..9b9f8615070a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -924,7 +924,7 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	data->total_active_cus = adev->gfx.cu_info.number;
 	if (!hwmgr->not_vf)
-		return result;
+		return -EINVAL;
 
 	/* Setup default Overdrive Fan control settings */
 	data->odn_fan_table.target_fan_speed =
@@ -947,7 +947,7 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 			"Mem Channel Index Exceeded maximum!",
 			return -EINVAL);
 
-	return result;
+	return 0;
 }
 
 static int vega10_init_sclk_threshold(struct pp_hwmgr *hwmgr)
-- 
2.43.0

