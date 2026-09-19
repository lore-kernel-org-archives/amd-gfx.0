Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7090CC982F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B20210E361;
	Mon, 21 Sep 2026 07:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMjKw3sw";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7CF10E423
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 16:55:25 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-86212a185dcso2060897b3a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789836925; x=1790441725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBON69wGqa+UQkdsinIc8KziB78dqC2CQ1FksjSvMsE=;
 b=kMjKw3swrZOtWVdUWhSCss4vcU5/bjNL9yq8z4BdiOV5onGjfHNiXvAcdg/WgoB9fU
 JC3uzW19/ua3skDeg57VvmgleCbQvVBAjjk9ljBjtadQlMP/O0nCDwXFP9HBNfQO8h6W
 cu6aoquM8Cokx3Cy+Ef2XnYpeTrf7j+h3LTs+JxBJmlqPvg3Ow2xqP3N2CMQQh1oVr5D
 dmFEBGOrII8zUf1EsO2w2z9aYqgMY7X6QdNYEZAE974N4l6pkMVdDF3XtHFHFCA8vYef
 NBaIl2GwCvtQV3x0Hipwa0pVbgQUIcUYZFB6WDUec+uuY91gA4CrsIVXKiBX9b+xuWBK
 XH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836925; x=1790441725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBON69wGqa+UQkdsinIc8KziB78dqC2CQ1FksjSvMsE=;
 b=aQVr5C0sABPqhn7mv8GLql8sGksH1ZX6VcrkuJfFWoaGAMB4S2xXZpacPTh6Suu3a0
 UcNf/XZfjKBKHac1AuW/B6ZhfoWsubbiNiBcN04gsrJr86fzUaWRR83cSEAwfdnzGDWu
 f+2GxXAcq0IcUuWTGJ6jMGM0XHHwrS4NgKLESwn9uJkLk4b7upVi8tHxx6EFGdwBr0UG
 kseqRaL3gQJuvBK4GmEoWMRGi2OrcB0wkbbf487EdrP2JnfnjSvqRjQn50O6wuH+d1t+
 9KBoNsYVqMw16+BKWG6bdIGOZHiB4donk4yi0RJTCSFTEp2ZmqyQE8euHj2wncjDjxu5
 SFqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2yjd0wjwD38cjbCVUM0U73Qxcz+ZtyAdqsU8xRHJzVdf5csEjfBK+lOr3dO+MYssE6iHh3QPn@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3FgZReRZmrAZnWDbwuxUcSjsjThqe0kVepeSW1bIM+o9dW4r5
 6K8P89D/COU5j/ie9US/aE6pznbhyz9fDvyUFlAoJWO3tmHQdRV3frZlDLPIsa6P42g=
X-Gm-Gg: AYBFou1liMig6VRgF7hklhZwdBzGbmy/X/4XnvrqhUQ0kjIJhcjWorpvIXtM5qd5Bym
 JCyijj1XOhQvpFe2UNiZ+GPsjPOMJDTVdFK0Q3OhTWcYjkirigj3dJUG9HHPc+CKRs/BhqULvqI
 0YFGquvcJuw3wvqMLrcSdFtonOWCZtymMvC9Hbi7+BddLGl+HRncsea8OqZddFKTV2BSUODXVeC
 jiFOvvAhL2VnKMJe8TIF+5x8ATJgxcbm/swh8yPg2BDnA6IQBHqY8RwSDGOY18R52njsvCAPnQ3
 Vwf+ZHul9o8oJIVO0Ae9e180/nQ4bwcvhkVCI8vcXnfc3kXkdGRoWa134zAcUI//vthDeR5+TmB
 2vnVYv7b4DiRZ7NKDz1v+5ub+vHmpJdcX/9l5tZ91swkn5pTFF4fqCVGacMrICL2Ki+jXBHmING
 hMaK8klsmDuH0McbQ9ksGToMol3dyneBhip49PI4zoF7TKVkL1nR8Ggw==
X-Received: by 2002:a05:6a00:2d1e:b0:878:34d7:6a34 with SMTP id
 d2e1a72fcca58-87834d76ed2mr2182854b3a.40.1789836924948; 
 Sat, 19 Sep 2026 09:55:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a94f238csm1146617b3a.21.2026.09.19.09.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:55:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Tim Huang <tim.huang@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix IP instance memory leak on kobject add failure
Date: Sun, 20 Sep 2026 00:55:11 +0800
Message-ID: <20260919165511.3687822-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:11:54 +0000
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

amdgpu_discovery_sysfs_ips() allocates ip_hw_instance with
kzalloc_flex() and initializes its embedded kobject before calling
kobject_add().

If kobject_add() fails, the return value is ignored and execution
continues without dropping the initial kobject reference. The failed
kobject is not retained in the kset list, so the normal sysfs teardown
path cannot find it. As a result, ip_hw_instance_release() is never
called and the ip_hw_instance allocation is leaked.

Call kobject_put() when kobject_add() fails so the initial reference is
dropped and ip_hw_instance_release() can free the allocation. Keep the
existing best-effort sysfs behavior by continuing with the remaining IP
entries after the failed registration.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a404d8aa13ee..4b1ad1c0a10b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1314,6 +1314,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
 			res = kobject_add(&ip_hw_instance->kobj, NULL,
 					  "%d", ip_hw_instance->num_instance);
+			if (res)
+				kobject_put(&ip_hw_instance->kobj);
 next_ip:
 			if (reg_base_64)
 				ip_offset += struct_size(ip, base_address_64,
-- 
2.43.0

