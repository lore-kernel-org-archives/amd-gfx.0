Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78D8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 13:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6918210E066;
	Thu, 10 Nov 2022 13:00:16 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CFA10E066
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 13:00:14 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 p13-20020a05600c468d00b003cf8859ed1bso1094687wmo.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7bY2rgwP3tMrluPXwz06V76dXD+NISw13BpQ3yCDFRk=;
 b=BnnobZvNewjr5VhLps+zWMZtse0VCHRiRZQLEIyA5VwZfO/Ogz20+5Ydbw0mRuF1QJ
 1VoGgLaBjs/QYOhYIoTOeigk1aR5UPhz1FSC/YsRBpLSz88dmWN5qcwKExoDDOcHHoH8
 mGR/MWYM38/QLnyNzn8SW+zGB7Ua++y71ZvKDN8ctNYH2BNyR2XiNRyrQkdEmrOkxbl4
 YGvUdTlSw9gDe+GsGZake7o5Nc2Y8UBm7yFsteiMMnm2jLh1+3CuiHRulh5oG9lQ4wAO
 aznPCrfNnfLQaMyHfVGW5Ny3FVuBIJsneZ2odrZqjo5NmnloU25qG8FqljdTqiPpjhr4
 4ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7bY2rgwP3tMrluPXwz06V76dXD+NISw13BpQ3yCDFRk=;
 b=Xzg7QQ7cyafSSCpDLe/5PxAzpldvG0UmYuvORisw/7Ktr3A85iCx2iNY/b7k0S3cMg
 xAUcKWa0AGLVsfK5lZZ1z/9ROveh9GYabG8oZVC8qcFo4SqbxyRvIWCw3P2sGfGMi+PN
 057mc4OXqrFu5q9+gUpRsH08DYNZIwmonAxMoSfujBWQ1bvUvRnpr+fitPbF+un0SPXG
 Jdqt3aCThNt2VEwN8p5kkCmbCjpiQvCSA/kcGCwJlad+vo2ln1D/oPl2SVbCtH3CvjzD
 vqlvxzopaQ7TN0trFvCNpVVGHZWUyivSOOr8G9nUxkn2AG2iiDAq46MY4fzIJP9Zi68h
 SSiA==
X-Gm-Message-State: ACrzQf19r71EJgARfB1JyOU1AL8Jp4wloJgsapOmdKkGrPljwSMX48H4
 08nIs/KlNUswZ+1GJy43PJo=
X-Google-Smtp-Source: AMsMyM7yrmZ+jGewpT32veAFwT9/G51cRYK5secWqDoO3i2ktgY4aalhQGKrQjPhbEPl7GhSdRXi9Q==
X-Received: by 2002:a05:600c:3b9e:b0:3cf:93de:14b1 with SMTP id
 n30-20020a05600c3b9e00b003cf93de14b1mr22934388wms.148.1668085212656; 
 Thu, 10 Nov 2022 05:00:12 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 az11-20020a05600c600b00b003b4cba4ef71sm5318965wmb.41.2022.11.10.05.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 05:00:11 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: always register an MMU notifier for userptr
Date: Thu, 10 Nov 2022 14:00:06 +0100
Message-Id: <20221110130009.1835-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since switching to HMM we always need that because we no longer grab
references to the pages.

Signed-off-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8ef31d687ef3..111484ceb47d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -413,11 +413,9 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto release_object;
 
-	if (args->flags & AMDGPU_GEM_USERPTR_REGISTER) {
-		r = amdgpu_mn_register(bo, args->addr);
-		if (r)
-			goto release_object;
-	}
+	r = amdgpu_mn_register(bo, args->addr);
+	if (r)
+		goto release_object;
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
 		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
-- 
2.34.1

