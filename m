Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C98DCCD187
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 07:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F37710E943;
	Thu,  9 Oct 2025 07:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dUg9lcM8";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0E610E18B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 02:18:17 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso377013f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759976296; x=1760581096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfaOf0LMlbdtGGDx/Ijf4csp3yPAQB4jZH4m4DLONE=;
 b=dUg9lcM8foVxRfQ5U2rdJrYx4bFSkqiB0NJFZLZaDEym1Bnc2WupjCLN/9TwoNzDkg
 HOau4oY5Fm3/kyJpfa2GjH+ReBThF9MB4ML0ap1xCDIq6bENOI6+5n9Ach6izqZhWH+Y
 ndtGcoGGl/RQTX+e6kvizrP2ZRTuOaAVIwD5XnDu6MnTycIX5qkho/LuEYY2WNx6O0q+
 6iKHkRW7pBk6QgxoSS87mxmymu+5rf/QeL2FdsVGgORD0Ip81VtsvtqQtHD+SNmcEgwe
 dc/xLcKHxWSw3Sb+cw2dkGC+uNpe8ist1gRdoDBsvwWwWXORrDjjz0MhRy93FCgGeXEz
 gZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759976296; x=1760581096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJfaOf0LMlbdtGGDx/Ijf4csp3yPAQB4jZH4m4DLONE=;
 b=rwzaIl6Aau1L44BhG6uOJqzgQOqpZZPO6OtQiLHYNGl5HysalU5XmM4FbUoVxOI6Dd
 SpBF088yWAyTgU3FfQ0g1uG8fehKGSHeWI5Ajw+ND1CEUMb5gxfrXKCNfERxqWsj7QDe
 4Fik39m0u3YUBHvmZB3USKtALAfvW04lAc86fhaoDXwG07+Gs+LZaoht5smnHkksKaxI
 uPzFpFwO4vmWq6JgJd8zHAfusE1DcPL6greI5j6/fGHu+9H9whWgt7gayDunpL5VrlOM
 4wYlba+YCnKwVAzvn77a0wssbI63G1PvunBUIFmVg/LFt3YRBJv5R8OeexFtQid7skV8
 WPhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjVgN9leLgneXZ1E7QxnWagd4qcsl7fxrSLq6t7vnP8MhP/cfJzpdy4t1PNmGF6O9JU4qrQwef@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwP9rFOlWu7InnoEo4sxORwHDoN2pciS8d6ieymGDWRdr9QORw
 YJwetMROZXhLUbZOiyp9/cNMysBkumc308Shlq0pQPoY08Ftfl6sUHXz
X-Gm-Gg: ASbGnctjJK3c8pcIAE6LvLb9sZYcit9Olv+k2+AxfoILjke3/8Q7O09GhBD10k7iZEf
 6dCrtWOa2QY+/hhmKdASYqmUMMwa+ffAWrJqCs5M67YGngQORyHQbKGIU6v98rwwDPKKlqZdXFg
 A8xi0ln9JDlK0xVqP8Q/ums3WMIfJZdJKmNRQRb5URTNggLTUoiVzzYpzRScU/GAopMEI7zXDHv
 8wbBjQ2QOX3+/ZvB5AVKjY0uhlM5+f/OtO7OrOTQ4sV/BbB4fJa4i4uGTslSEg118nDcecvZGtS
 75xgnsRCtWI36qjfTJE8UwBy0zEdw+g9zAkRzpJXl1xmLZomC2WRd4Zn/4SvWsBto2T8iVUxWHg
 9RlK8otWUIFm/9M7LAJjDY6iPhr5Al2Nct3lTtMWs7ajCVjouv5GW+OEhp3v2IVk=
X-Google-Smtp-Source: AGHT+IFDWwCsyIH3udntapEMeZKsjzc8YDWsB8IzrNKOcKADqGXbJI8EsYvL5lJPVkIkMFPSMByYZw==
X-Received: by 2002:a5d:5d13:0:b0:3e9:4ae9:9f1 with SMTP id
 ffacd0b85a97d-42582a058bfmr6587708f8f.31.1759976296131; 
 Wed, 08 Oct 2025 19:18:16 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d7f91esm60094215e9.20.2025.10.08.19.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 19:18:15 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 mario.kleiner.de@gmail.com, hersenxs.wu@amd.com, Igor.A.Artemiev@mcst.ru,
 nikola.cornij@amd.com, srinivasan.shanmugam@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, eslam.medhat1993@gmail.com,
 Lang Yu <Lang.Yu@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.10.y 1/2] drm/amd/display: Remove redundant safeguards for
 dmub-srv destroy()
Date: Thu,  9 Oct 2025 05:17:11 +0300
Message-ID: <40a1a37aab140b0b0f444f8435b17dee5eae31f2.1759974167.git.eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1759974167.git.eslam.medhat1993@gmail.com>
References: <cover.1759974167.git.eslam.medhat1993@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Oct 2025 07:45:21 +0000
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

From: Roman Li <roman.li@amd.com>

[ Upstream commit 3beac533b8daa18358dabbe5059c417d192b2a93 ]

[Why]
dc_dmub_srv_destroy() has internal null-check and null assignment.
No need to duplicate them externally.

[How]
Remove redundant safeguards.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 45420968e5f1..b698d652d41f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1141,10 +1141,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	if (adev->dm.dc)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
-	if (adev->dm.dc->ctx->dmub_srv) {
-		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-		adev->dm.dc->ctx->dmub_srv = NULL;
-	}
+
+	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (adev->dm.dmub_bo)
 		amdgpu_bo_free_kernel(&adev->dm.dmub_bo,
-- 
2.43.0

