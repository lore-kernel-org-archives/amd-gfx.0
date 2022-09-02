Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5AC54EE9
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Sep 2022 07:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559BA10E792;
	Fri,  2 Sep 2022 07:36:35 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1324F10E78A;
 Fri,  2 Sep 2022 07:33:25 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id f24so1101117plr.1;
 Fri, 02 Sep 2022 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=FoP5SmxHDvhR5MMTOuBriKm/iqFz8ohbUwqXDgamLLk=;
 b=gF8tVsKd7Ez2eCBfvRC2B2SL5HnknuIJ6R7e2FCDHwsjA9fOrWh367rTYJgIjM8mtR
 acAABfdewhPTbtouDv/F7C3IQbmM33vDU6sCNEbUzMqshNrfje16PeTZ9Giy571iAnQE
 cb9ZRe8qWVcvq9WgAxIj2jVQiHYVnWlDwE24spqxIlpu8GQK0s9NKahjTlKDZEV5EKMD
 ZdkP8EuJyaA6wiEb+JKu3YIxwWeyIlHkk5EOYsvULHRWuaiRBOpT8+d2KYeDNn32nd0S
 lwltICqlvOlKyRV0uHeHW+StdMj8Zj2SK4WIsaF0mylZU0f8ASwalVcPR7ME0nAIPGBz
 Fm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=FoP5SmxHDvhR5MMTOuBriKm/iqFz8ohbUwqXDgamLLk=;
 b=uyvwJUf2jAQa239RXc4da0gRtoGTyMcBAS/jwLZ5rclsTAQ8fwo7orWUjEs2kyO6Bq
 hagW0V5pw3nUyiMRcQwRIUVsef1AP2jFzqluoVuRO2NQt805jLDpgQFx0X8aT1o26yXA
 2N+Eon5M3EYuyIbX0SmXzVrEWrd7XljOV/LD42kMiYWhFNp4hmahGIXHPcI3vPdWM9wb
 MGpApG2IqV79FFFfpkS2DqdDP9Nei2Rb9T0XgmjX+9ocBIs/VKuqE4HvTVwPV6a2paVD
 coaYcnmRpZsxx8xvN10pfHT7m806EIFFRjAhb8K0N783tmZ9ASxgUh9Mhn0xyRYadGGt
 Y82Q==
X-Gm-Message-State: ACgBeo0VCasgWaB3o29KfukbyuV2lee5BWijfAl2PC2l8p2ZDw4UKgm5
 IRwFuRSy7y6oEsAD43AD1ew=
X-Google-Smtp-Source: AA6agR6+XHZX67T+BoAgwjK44Hrl+fIrbkXTuWyVPr7aaZVbk0t2Z1gXtLYB7b5yiqDbVnygn8Jb6w==
X-Received: by 2002:a17:90b:2704:b0:1fd:aaa9:6d0b with SMTP id
 px4-20020a17090b270400b001fdaaa96d0bmr3430674pjb.128.1662104004641; 
 Fri, 02 Sep 2022 00:33:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902680a00b0016d4f05eb95sm855797plk.272.2022.09.02.00.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Sep 2022 00:33:24 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To: alexander.deucher@amd.com
Subject: [PATCH linux-next] drm/radeon: Remove the unneeded result variable
Date: Fri,  2 Sep 2022 07:33:20 +0000
Message-Id: <20220902073320.319673-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Sep 2022 07:36:30 +0000
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
Cc: airlied@linux.ie, ye xingchen <ye.xingchen@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value radeon_drm_ioctl() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index a28d5ceab628..6cbe1ab81aba 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -512,14 +512,11 @@ long radeon_drm_ioctl(struct file *filp,
 static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	unsigned int nr = DRM_IOCTL_NR(cmd);
-	int ret;
 
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 
-	ret = radeon_drm_ioctl(filp, cmd, arg);
-
-	return ret;
+	return radeon_drm_ioctl(filp, cmd, arg);
 }
 #endif
 
-- 
2.25.1
