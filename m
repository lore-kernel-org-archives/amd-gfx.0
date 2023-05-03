Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B5CC77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88C110E128;
	Wed,  3 May 2023 15:29:36 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF0410E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:09:26 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f18dacd392so33896875e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1683126564; x=1685718564;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hrqzZ7cl8VrtR/TAxnvpJyyUePNXIse9aaN0F9mcED8=;
 b=k+mEvhkF3uKpEJD2wjFkUiNyY14LN6OGYP9piujHBpmYpEqYvzmS4UT95OzVxmlRjK
 QBUXbRpMvjzzliHlpDfc7taXh1uGmew5OHFFAwWoBzQP8zLfvfCHXJrpBr0Vc4OYaUpY
 +YEpKVW/Yp0UFr9HsI5NR97FwRlBF3aPjPaxVn91pRQ6lSLVKknj4s+DjpsM0e4ngb99
 +xixWMDGLb0cXiDgj+DbtYYFz+Ue8W/rmqTyf7HU2/X5yszZ7Qzl/3QxgUL9FADCJv7g
 JdBfkq89Yq9wKRRyZCiAveWgnvWXG9afgSLq3CtfCUR/uN4tep/ZTH0bdI/LxfGVGNyF
 6LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683126564; x=1685718564;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrqzZ7cl8VrtR/TAxnvpJyyUePNXIse9aaN0F9mcED8=;
 b=OUgFUdzBhqupFHrua3UzC30aYyItSNawHFICj1cxC2i0Mf0o+mwIW996rALlU5jP0o
 Ogk5xn/V7Tjc9el1e2EdTxVFOv9K/IyqcMoQYu/tqXbNWpyDsz9w9ui6644J/4M3Cjlw
 EXrdD7pLIEw685M/IjgfEbGmASDxi7zZRqEUKljaptQ/phJxErzBK7fKZYnMNYaRUatF
 hQXT7TG/Ni7uoi1tFm/R6dtyhxPdP0NOXcDVaxbZUdAtrVGJwnL+Q2ipK26KjvwZ8/Pv
 7swJLJDjw25ap79s/nsFHUSl4jl7J1ELamTvlC9+JABIc/kj7UpS7hmos+XXMMyWQSAs
 UFfw==
X-Gm-Message-State: AC+VfDyACyGTIwEMd/ANdf2bn3EdMlJGNdNQbp2zTAijus8C8yR3bkKV
 7erseqTL/srt86YeOq85+zeoQw==
X-Google-Smtp-Source: ACHHUZ59pkQEr7QUrGFWqjZnRra9u6FwHuf75XZEu80zdhinKzCq+M1Huv7BZqixQDqcC0WMwmTArQ==
X-Received: by 2002:a05:600c:2212:b0:3f1:7aff:e14a with SMTP id
 z18-20020a05600c221200b003f17affe14amr15227267wml.39.1683126564433; 
 Wed, 03 May 2023 08:09:24 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 z18-20020a1c4c12000000b003f188f608b9sm2164834wmf.8.2023.05.03.08.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 May 2023 08:09:23 -0700 (PDT)
Date: Wed, 3 May 2023 18:09:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Le Ma <le.ma@amd.com>
Subject: [PATCH] drm/amdgpu: unlock the correct lock in amdgpu_gfx_enable_kcq()
Message-ID: <072c8bbb-76bd-42f8-bb97-ebc38acad470@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Wed, 03 May 2023 15:29:35 +0000
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 YiPeng Chai <YiPeng.Chai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We changed which lock we are supposed to take but this error path
was accidentally over looked so it still drops the old lock.

Fixes: def799c6596d ("drm/amdgpu: add multi-xcc support to amdgpu_gfx interfaces (v4)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 60bb4bba1994..1de3fffae9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -566,7 +566,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 						kiq->pmf->set_resources_size);
 		if (r) {
 			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-			spin_unlock(&adev->gfx.kiq[0].ring_lock);
+			spin_unlock(&kiq->ring_lock);
 			return r;
 		}
 
-- 
2.39.2

