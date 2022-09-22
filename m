Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EE5C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 13:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2CD10EA95;
	Fri, 23 Sep 2022 13:25:11 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC09410E76A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 23:05:18 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id jm5so9201939plb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=KwS/Nl5CyO/iGcJglyc8vlm8JEKp7t4tMPCpmLoVzmU=;
 b=b/kDreQx+OMg1mdgoxW23nVE07mFgYadIxg7ZG0v6Aw359dnNFopE0XFqjSMgIq/zG
 ZhB6aQEGE0IqkTauGckV+Hg/ifANoN8sy2OTcZlP8Omd9RQD+1g2bBfrCY6BB8k6hwLw
 pUae2AznLvq70w1WinR5Bt+OQY32775bKQpw1vFxOGHvJcqc4RWTZFsngol9M/UarC0R
 waVHfBW8XewNVKs9ORpekN9YK2q/7ninrvB5Xfhji/GOpM+CMFwV8HRVWHUFGc1edjaV
 P9ogzE6SfPFBtjQqqxUQfbhhoWCi/InzzE+/aEyAOMMaEEvHab+C9+7P8yP9veCqGJxE
 zvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=KwS/Nl5CyO/iGcJglyc8vlm8JEKp7t4tMPCpmLoVzmU=;
 b=RCE4D4K1zZAANHw8pfO7tgw1CWxK8uZ/wNTfEPq3PkXUgdKkWU/36ZkoaJzZeAaWRQ
 KdCbb9QkNBWK3a4z0ACWIjBkwiGMM+PgMAMMizJtNSwj5Ox82V4of/Wo+lB82Az+UuWN
 5oPmi7ADpfVPDUAqjf9vJ4rqSbV+cVjWp4lIAPJtLk3JYnSdcW03gLJAKTuErwfIDJsi
 SbEfYjwv1VBmZSinWVOjIXA4AOp01Jk5LkqhI9KKH9PjzCnx3m4kgAcwuKREkkN/c6fj
 wBiglZPiDsSbIca37z2Cpt99ggL4ABpNyUcRzb2P3RmyScMINyOrAFN97nBDEkodkskn
 /tAg==
X-Gm-Message-State: ACrzQf3hYloP5NmWt95WBAjX4CjiyjQFVn4mSI+ZVtu7Wyym3ivq7Y29
 VGFtjhD45GLDxhNI4Y0K6Q4=
X-Google-Smtp-Source: AMsMyM66xub6tr39MYclN6GXeDl6cGN4Z1GzoxF0RYoAxpR2imA2+gmiBHi63t1ZAdwdmNT7TGBezQ==
X-Received: by 2002:a17:902:dac4:b0:178:42d4:dcc9 with SMTP id
 q4-20020a170902dac400b0017842d4dcc9mr5587710plx.167.1663887917787; 
 Thu, 22 Sep 2022 16:05:17 -0700 (PDT)
Received: from paxos.mtv.corp.google.com
 ([2620:15c:202:201:288c:7b77:3924:c081])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a17090a4a1600b002004760a66csm322366pjh.13.2022.09.22.16.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 16:05:17 -0700 (PDT)
From: Lepton Wu <ytht.net@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Always align dumb buffer at PAGE_SIZE
Date: Thu, 22 Sep 2022 16:04:52 -0700
Message-Id: <20220922230452.3903316-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Sep 2022 13:25:06 +0000
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
Cc: marek.olsak@amd.com, Lepton Wu <ytht.net@gmail.com>,
 christian.koenig@amd.com, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since size has been aligned to PAGE_SIZE already, just align it
to PAGE_SIZE so later the buffer can be used as a texture in mesa
after https://cgit.freedesktop.org/mesa/mesa/commit/?id=f7a4051b8
Otherwise, si_texture_create_object will fail at line
"buf->alignment < tex->surface.alignment"

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8ef31d687ef3b..8dca0c920d3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = ALIGN(args->size, PAGE_SIZE);
 	domain = amdgpu_bo_get_preferred_domain(adev,
 				amdgpu_display_supported_domains(adev, flags));
-	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
+	r = amdgpu_gem_object_create(adev, args->size, PAGE_SIZE, domain, flags,
 				     ttm_bo_type_device, NULL, &gobj);
 	if (r)
 		return -ENOMEM;
-- 
2.37.3.998.g577e59143f-goog

