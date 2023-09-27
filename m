Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67F6E810DC
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 12:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364FB10E508;
	Wed, 27 Sep 2023 12:47:49 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708D010E4F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 12:37:56 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4053cb57f02so98864495e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695818275; x=1696423075; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8gt0z84tNKlqBU0ORxjwF1YuLnJ3DYpGxnw1e57pMcg=;
 b=t6BBZwM093Rdy4O7TKxAiF9ToqdvnNLIi6xn+0tHlUPr3E4OMyIgIy5y1R01F8j/Y3
 sWjcKNClemKvd4tLrBWNqrM4GZOV4RWMnhz7DNSTUOfWU7/07YI5mutPycm/96Kg/cBm
 qciwhnfOI2NWQ1JGcf6fh01ajrD9DolfKElrl+TdfVNKA8ul0CbYPpr2J2jXPMKH6M8T
 /Jl3+tHBcGZva3CtV6enhZGrJCmE7vnvm6rW9l6R48dEfwbXxZr+W8IZbaJjGOHIJY4a
 ILaP2aoEYdu9Q3Ss8U9szAJ8E23crThO6RusPR0TMxjD0XYsTtCBoo9tpZm/XWQlu5vr
 f9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695818275; x=1696423075;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8gt0z84tNKlqBU0ORxjwF1YuLnJ3DYpGxnw1e57pMcg=;
 b=PkIMppVC0fYDMxQ4v1ltt84EWtaShslh8am4iOzxhMMerGUSpxwdMWBTznqFn6R2Xm
 jecz3twMws+Ka7BcwtjPqa6yqSFE4l142Ql8Ds4Oun5hJWAZQvwlJ+Jk65+GrqjlU7QD
 PnEAg8RXm8Ui7emyfWQKX6WjtpJbKryAes9P9IZLrFyxT20SakZ9npPifhIPIFlohnVh
 CNMO0FT9ZoAZttd9BSQevn9fLGclszocObC1kmCaLHASQ+o7LrJU5iiqkrAOWFcxccsp
 jFR4Uuhlbr1CmGIn8xpvPKCjXIwQckjCBMnayX9tbawt4bWJj/YID1sbLUVI5xmtJgKV
 Z0yQ==
X-Gm-Message-State: AOJu0YwZ7hTC9oljfii8pssEoODq0o6UYxQXkn70dxp9pR3dd9plRW/9
 hxVWOCQ+B8Ss0+TtJ0Jj0cy6IA==
X-Google-Smtp-Source: AGHT+IF//SsjAFSKGtGIY4ySU5+yXbv00B5OFBnRt/YiczmsYbnBFnOPNKevQVsLvVlA2FKz/O/b1A==
X-Received: by 2002:a05:600c:365a:b0:401:b204:3b97 with SMTP id
 y26-20020a05600c365a00b00401b2043b97mr1810459wmq.4.1695818274882; 
 Wed, 27 Sep 2023 05:37:54 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c1d9300b0040531f5c51asm17841529wms.5.2023.09.27.05.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 05:37:54 -0700 (PDT)
Date: Wed, 27 Sep 2023 15:37:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Evan Quan <evan.quan@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: delete dead code
Message-ID: <b238c665-91d6-4afe-83a8-da2f2d59a75b@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Wed, 27 Sep 2023 12:47:47 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, kernel-janitors@vger.kernel.org,
 Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"ret" was checked earlier inside the loop, so we know it is zero here.
No need to check a second time.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..0ffe55e713f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2346,9 +2346,6 @@ static int mca_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_t
 			return ret;
 	}
 
-	if (ret)
-		return ret;
-
 	entry->idx = idx;
 	entry->type = type;
 
-- 
2.39.2

