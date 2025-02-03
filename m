Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A57C02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 11:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D1E10E495;
	Mon,  3 Feb 2025 11:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZUXGOc6";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D251E10E495
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 11:58:49 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso31653895e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2025 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738583928; x=1739188728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4uhajgKuIKNXhznhjeXP+/fqZXJW6Pdme/EXXkFG0+c=;
 b=NZUXGOc600pCjylbq7gWJfeiqVd9RSjbL7DmxIYvi8jeUo0lxpHh7qNgXsjbQOnhYd
 tGSmeW7qIiaBT2QgL9ARXfyreep7dGbRPBsPKAfXe5+uexWsc8pYABHUoHyHln8PgKHD
 6+ICAZU6mIl/1521oQq9kAC+uq1TyFNUIehxGLeNZLJC9BJ2OWVrA1yKvn4vUxieGuP2
 oFhDMjiTgEodERQe8dt3y7q1JKQs12Z3SXzjrDb5BUUtwhcYsE7+hlPBSGyMaalY/Ues
 1ktQ4LsJTYFhVKi+ojLiU8qKjkC1/6nBrGo6J3D9pLEHYabfCD7VGyuamkgiDzAFw3Im
 LIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583928; x=1739188728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4uhajgKuIKNXhznhjeXP+/fqZXJW6Pdme/EXXkFG0+c=;
 b=nECXMcjs3leiuszrQQ0ruphkIrN2mlxR2Pi7uxybRBKSvqVzk81teWl8pcusD88g2L
 nMMpJ1qnUKo8DeuOj62PNZ7SYt3/KobWFL7uWuvrygj2SZrda4EzVevOMVXx1kA+Vt1k
 KnRpVJAXJhRXjR3y0jMTjc/iMDrId1oerz8T8tuRAFOmU76WSldo72a0S4RWYazw2MTs
 MYY+cdUPx0qk7Zb0ijgyVLpyyRSNHKo/Pd4lFB/wBkASuiFsaixvHJ19TYfaU0zD2uTI
 2lUZPn+rlo4YexfyNQPvK1RIISP6d58nz+pWqysuuR67AzKeBbWdbHBMYJsSXRwVy9+y
 G/gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRKDfyypCvs6F35rqP2hfxJkj2dwgepl/xjyPbkOgkoifVCFu++ionrwk1Ut5TvucRHdP2jtnE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywfc0hfkQlZVOau5jAvqX7JnEVKO+7+oYw+neByrTNts5NKICuo
 0D04QJbCfCvJh/6CWD+AehHzrwYo6Hd1XdFQeKFc+OyqKDulgOJM
X-Gm-Gg: ASbGnctyV4KsWDNDP7Fi0L6PwGIwmWFz+hsc4G4mudLLegHBfNocEoPWAAT++wuyfRe
 iLP0VUlzMJ/STnGHWiHlrZzWq5VNCKXav6g9skfZ4QIS5UQgEBcmsA+55qGU4miEoBjUVCrVuO2
 57NcER/gH+w1aVJwRdTzokm1YzCnM9+Bc9LGj2N22oiW72RuryNbr2fGMaTZaMzbeJFBzQOPn39
 bCrltbCGe/8s292VG3Y7bligRVngx+eSoYEt/N0HZ7xbEgOhufogjlSVHsXP3RALB2wG1YD95nG
 R3z9bRTWGJwuLlhxwQyMrL4ntJE=
X-Google-Smtp-Source: AGHT+IFeeCcOOqIfZYZMe0Np02zNrQ13D11CTcJhcAATAx0znv05m/LDYdQV+DZ2spVOUk4/Ozudag==
X-Received: by 2002:a05:600c:1c99:b0:431:5044:e388 with SMTP id
 5b1f17b1804b1-438dc40be3dmr168206465e9.22.1738583927987; 
 Mon, 03 Feb 2025 03:58:47 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c2:700:903a:ba89:5ce0:8312])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1017besm12298928f8f.26.2025.02.03.03.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:58:47 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 1/6] drm/amdgpu: grab an additional reference on the gang fence
Date: Mon,  3 Feb 2025 12:58:41 +0100
Message-Id: <20250203115846.13142-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We keep the gang submission fence around in adev, make sure that it
stays alive.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d6b473217c8b..aaa8f9f7b6b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6753,6 +6753,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
@@ -6765,6 +6766,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
-- 
2.34.1

