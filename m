Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD9C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 07:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B20510E0CB;
	Wed, 29 Mar 2023 07:54:00 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F0510E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 05:27:50 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id j24so14410212wrd.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 22:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680067668;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WeQ/sOncvnANQNphvPs5lHLCwBueTwnNxBud57wwVnQ=;
 b=g6dYsmufGz+mac52ggb7T1tx2HzETOO5bHT4DD5M8nZ6qyLNOEEGrF3EPJoRXv38Ep
 5Fo1AahFWFeNLsdAo1mR4UZuSLEey1IxF7DeZp2a9cMouqiUdOAmbrTCchFV4oOwBwLe
 4t8BSRmtu8e8xshqBl8RFb5KMFGpQR3nILgHo+U6rjTHowL/PNSq92x7Yzh/otaV4i0Q
 VtJCdQhFwg78W+bJEbUXWGwOB4N2T9b1JqZU+EscUcPbz/ferrOYGhGLCuwvYYnPqmt1
 /qDmBXiqjqU7smaEZpunjyqlJYxCjtyLvKcSPhHt+XBvirBIYfpXDbr9DYm+L+zjHiow
 C9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680067668;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeQ/sOncvnANQNphvPs5lHLCwBueTwnNxBud57wwVnQ=;
 b=KH6efPKxZmJEBKKGAQvMP3bgBT042aObaXInRi03AQpbe2Y/ASJ5WhsVLY92reG5bL
 w9vWwvHg+BRrdYHl4vXibU1QHvW8QduWaLgusPkJftguZUnaOVLZU0Loqtcflx+SsGlA
 vnRuUMolVVf1ZN1sf1k5ZwABtT96csjnTH0gx/fVAkzOMjJ6pjd4g9IsvOI+wAdlq1sC
 jmuT74iYwbsfHydT97yhQJJfIfMfCnGeJh7FA5OO81aZD9DFZGgDsbhcWsN/9N7Yil9U
 iSczWW+D+mWhMHH9l68RKrktHCuSUsVLyURSE9gi51Mfm989p+fkSHb43lI8voGAVnVm
 9q3w==
X-Gm-Message-State: AAQBX9eCnLRO/CD0eKgVr0k3REeCHvkVj4gH7nNl1BOD4oS+BMNM5YsT
 vSmttziyzFoPk46njln4cnE=
X-Google-Smtp-Source: AKy350busIuXZ5du0beLTAckg2jZkMI5wGvgABsSD8Un2dej76ZAcUhY4TeLe/BmyRnFGNol7MfLCA==
X-Received: by 2002:a5d:526a:0:b0:2d0:58f9:a6a with SMTP id
 l10-20020a5d526a000000b002d058f90a6amr14848429wrc.57.1680067668388; 
 Tue, 28 Mar 2023 22:27:48 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 o6-20020adfeac6000000b002c71a32394dsm29256299wrn.64.2023.03.28.22.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 22:27:47 -0700 (PDT)
Date: Wed, 29 Mar 2023 08:27:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix AMDGPU_RAS_BLOCK__DF check
Message-ID: <580414df-4adf-49cf-9930-743f7c539d46@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Wed, 29 Mar 2023 07:53:59 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 YiPeng Chai <YiPeng.Chai@amd.com>, "Stanley.Yang" <Stanley.Yang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Victor Zhao <Victor.Zhao@amd.com>,
 Candice Li <candice.li@amd.com>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a mixup where AMDGPU_RAS_BLOCK__DF is used as a mask instead of
a shifter.  It means that this condition will be true for
AMDGPU_RAS_BLOCK__MMHUB instead of for AMDGPU_RAS_BLOCK__DF.

Fixes: b6f512168478 ("drm/amdgpu: Add fatal error handling in nbio v4_3")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
From static analysis.  Not tested at all.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fac45f98145d..4069bce9479f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2564,7 +2564,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			adev->nbio.ras = &nbio_v7_4_ras;
 		break;
 	case IP_VERSION(4, 3, 0):
-		if (adev->ras_hw_enabled & AMDGPU_RAS_BLOCK__DF)
+		if (adev->ras_hw_enabled & (1 << AMDGPU_RAS_BLOCK__DF))
 			/* unlike other generation of nbio ras,
 			 * nbio v4_3 only support fatal error interrupt
 			 * to inform software that DF is freezed due to
-- 
2.39.1

