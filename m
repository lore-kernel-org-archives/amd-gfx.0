Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC07CCD1A5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Oct 2025 08:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0853E10E3EC;
	Sat, 18 Oct 2025 08:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="Qj1yvM+K";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353C410E093
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 05:45:03 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso3645031b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1760766303; x=1761371103; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmUPjTR3yMW64aVQGfGVjFZpeabfMfYHxfBKINbWsBI=;
 b=Qj1yvM+KismuC2Q29F5UmaM3yCr6eceMdAbMVANRe0j4MCACSheMjF9G0Yg8lLtLvM
 UpY3hv0wXwgWpDUzBd+4KwAoHBQPKwMbE60JG9E9MMJeRQft+1mUbXcxc42KWjI1vqOb
 UXRwjUQVl71PHM8fOWgI3h/ctjx/k50JP+ncE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760766303; x=1761371103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmUPjTR3yMW64aVQGfGVjFZpeabfMfYHxfBKINbWsBI=;
 b=GbF+s02z33CsSSPYeRQobrBEBimjVL+8wZKXzzWZqj8aGIP84lB12M0XicCBxwgd8+
 68dBB9K1aK0rhh9cCnN2UdsJ/JVecVXUa2RFUE6BSfyoXY+Da1vZD5ydzKETkvVZUTt0
 +rlJKD5CzwyaI7Okvl7BK76wi9qUk0ZLOeTIjSWWMeRlRorWXd9v4zzd//Q3vYLqofdx
 ljzA3OktvnswoxbpyjGsj1G63b1e9UHFj62qk11VBbTKEEzbzWvmsLQ02hmNCW61/vmd
 NdOYX3fLRt1gs7Xo8z1RgicINApWIZeNwI8KTFhVSDZQcKq7+sHVPpHRTimjcY92gyLM
 MbqQ==
X-Gm-Message-State: AOJu0Yw2qO+/x+WG65zF7UDAS1YScCVC8BccV8mHeQoVUCBjiHLE3hPt
 z5zEbKKibhPofYzAG5aDn/xDZW7Ri2pVEUAxU02jWFf6xakE+a6sRe4JDbU9IA1jr+qpzF6V59d
 vVzenaU4=
X-Gm-Gg: ASbGnctB7lkXQJSiwuacELeU834qWBkjOv1reKgICzup8ydgE7FXEDsveB1Buko5Z+R
 sZGDfdTtEhQll2gKFUB57xLCkJaVWO5q7Bhf8sltppzjKHvJeN9BdUOnjw+WkeXcSkFpxlAXzLi
 dweVme6k1jYgCH73WN8OrS6xa/g1STdWyVEIiJEYYOpqhd2XHtDFUz68B0GbaGeSBNaR+ReMYaY
 ye28KdeG20aotqFAF7Y5ONAdzqKMaqQG5Nc0oV5cOiYNIOoX9knLq3LD3X+i4wYUGFTkclyqouK
 mexVtIYw3ez1E8ICYRTzMH0nbCniWHUZ8g2w2k9tUCMLRIvAOg2k3wAJCNAK+Y8ZI5jQ83aMO1V
 hInCrIbf4hwmMPB1Rh8l48QFMjTz2S1rJzxJ01XcOQLQrHygMvhG37Lr7vyybbOEU4EMX7isKjR
 pjlYZTZ1wr+8kh7Mnn1rKZ+DlTKTU7TSrxC5GYF2f/
X-Google-Smtp-Source: AGHT+IE0n5z7f/IMMhO8RMH8A+89s4jb/Yrjx1i30f1bpPQKuZW8GFOMc0cHZQNBYLb0n3r/GPAvpw==
X-Received: by 2002:a05:6a21:3e15:b0:334:b57f:554a with SMTP id
 adf61e73a8af0-334b57f5562mr3664489637.25.1760766302707; 
 Fri, 17 Oct 2025 22:45:02 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp.
 [153.222.3.188]) by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 22:45:02 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/3] drm/radeon: Do not kfree() devres managed rdev
Date: Sat, 18 Oct 2025 14:44:50 +0900
Message-ID: <20251018054451.259432-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
References: <20251018054451.259432-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 08:50:55 +0000
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

Since the allocation of the drivers main structure was changed to
devm_drm_dev_alloc() rdev is managed by devres and we shouldn't be calling
kfree() on it.

This fixes things exploding if the driver probe fails and devres cleans up
the rdev after we already free'd it.

Fixes: a9ed2f052c5c ("drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 645e33bf7947..ba1446acd703 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -84,7 +84,6 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	rdev->agp = NULL;
 
 done_free:
-	kfree(rdev);
 	dev->dev_private = NULL;
 }
 
-- 
2.51.0

