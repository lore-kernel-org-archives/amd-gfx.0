Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A5FC369A9
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 12:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F18210EB94;
	Fri, 11 Apr 2025 12:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WPBIV2xY";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F24210EA04
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 16:24:55 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-39c2688619bso624221f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744302294; x=1744907094; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Q0HEw3hrYVGi9s56H8x5ezvg01Afiad6GaTNJBgE4g=;
 b=WPBIV2xYzXx2f1YnKFJWHS1hfjhzZukFalWUFE7oyKohHg8GdFngV1eeYRuPOjDtiF
 iV6cwuEbX+rvwB8hGRxwGstVvtEtTngWfdK9QJsIIfzc0PJRMpi+vBnBxfDwvTmMkXYn
 v1DIXqeZUuyW2htKu29edUJ8u4VUsXFwop6Sh+kakw0BAx3Qkoze5rspb+r7BF7cbNJt
 qefgL3VeHhNh3ylyMw+OWm18FuPg8zncDaqfIazYFEkdF9Gg9+2U+UuqQEKYlRo4bjSm
 vEq8qXAKCmMHk+fA8UVnbtlnoKFOvoMakFEOu/FtWLejzvCAp5Go1gGSkqTzNl2aGrtz
 jPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744302294; x=1744907094;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Q0HEw3hrYVGi9s56H8x5ezvg01Afiad6GaTNJBgE4g=;
 b=tLcjDCk5Ava5AloqQxV4xda5h+4IODv/hUG6HDnJohagJbgrOHilZW5UOyOUW0Sq0l
 hftIZsy7+YaPg2XN238khbFLc7OiG3NDKYk1G98KMRZe44d7h+VXSUpmw5Kr2A5ufQLv
 QNhmLrb7BczjU8MMqHzcB/3TQIPxjtnR14vqelVAqvnQIU5KH9O8SQpht2T1CGm3A7PM
 dudkdULgs+Da7Wg4zjyDIdQMeMZ3rcuh3eHZPL4UVlpS/jMcJ0FkUmK861XwxsFGOnsR
 xqvnzHFVHHqipE5RbuHRbErW9jwY5mWrKHr3UinvT2PZJk/2DgHoLj436w/jkQTx5L0j
 XGMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKh2UpsjCQfb9u8NFiruXgrhEu5dXs1aKvEHmVux1QJ9FgTJsJRpWFi7wVOKgmkjMLf6482d75@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIjiUGjXUL+knLUOoA/9lscnAvNJ2fH8Bk+wZMXucIr/CVYczL
 sU2Ai/dWGgva0UlfghFrq+rC1ZEI3OU+qJ0Iva+WU2pdx/pDj79utHDHyl6GKi0=
X-Gm-Gg: ASbGnct/+eCKQMqy11RxMRcEU7cVCzTTMFsy+AuKM3oYYFtOSMhKgOCAP4lXJISDUEa
 BqocPQz2onSSW7ylsCCMbiQ7sZDh7lagSYSln0RYG1XCpbnawu0Ejv/o1lCKDn70O2/FclhXH7m
 Ah3wFdaALoZHPtwk7BXnjBvlIth0IDU0wz+Som77lUOPHwjdOmLnDEDiGHTdd+e+xIX9oKBLcvy
 yISvkxAHqmElhynqeMz6ZtxTunUqVf1WpA8dvXqT2Y/L+ZJoFWelSkx+GD/KAks/+Hblj+Ieqg9
 Rx2NMeptXf9FxSH10jzF5Lxa2SNrIE0qDQFWlcS79aIXrw==
X-Google-Smtp-Source: AGHT+IE5gbRW9QyJ582gnS5/K6En7dv4OcdtzrH6WqFi8GhS+S5YHvq23DQaLTjIP0Syy2HVbmP5YA==
X-Received: by 2002:a05:6000:1785:b0:39c:dfa:e1bb with SMTP id
 ffacd0b85a97d-39d8f4dcf9amr2828748f8f.42.1744302293770; 
 Thu, 10 Apr 2025 09:24:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39d89402a08sm5153257f8f.100.2025.04.10.09.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 09:24:53 -0700 (PDT)
Date: Thu, 10 Apr 2025 19:24:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Fix double free in
 amdgpu_userq_fence_driver_alloc()
Message-ID: <5ff4d367-b5bd-40ae-9529-56d08ea6c1d0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 11 Apr 2025 12:24:49 +0000
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

The goto frees "fence_drv" so this is a double free bug.  There is no
need to call amdgpu_seq64_free(adev, fence_drv->va) since the seq64
allocation failed so change the goto to goto free_fence_drv.  Also
propagate the error code from amdgpu_seq64_alloc() instead of hard coding
it to -ENOMEM.

Fixes: e7cf21fbb277 ("drm/amdgpu: Few optimization and fixes for userq fence driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972..b012fece91e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -84,11 +84,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	/* Acquire seq64 memory */
 	r = amdgpu_seq64_alloc(adev, &fence_drv->va, &fence_drv->gpu_addr,
 			       &fence_drv->cpu_addr);
-	if (r) {
-		kfree(fence_drv);
-		r = -ENOMEM;
-		goto free_seq64;
-	}
+	if (r)
+		goto free_fence_drv;
 
 	memset(fence_drv->cpu_addr, 0, sizeof(u64));
 
-- 
2.47.2

