Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C35FC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D6F10E81F;
	Thu, 24 Sep 2026 12:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nv/hVViy";
	dkim-atps=neutral
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E117910F0A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:56:35 +0000 (UTC)
Received: by mail-lr2-f8.google.com with SMTP id
 38308e7fff4ca-3a59dae8ce5so6597541fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175394; x=1790780194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
 b=Nv/hVViymZJn0Hm1bC5X3zXVaqZ7AbOs1mtbHH3JQ969JVQfk1C3kPYcklL6JzdeZm
 ToJn+bskf6Lh8O56w831zgSWI2hQQp//vNyVM4olTpF8Vrdxhv9VrsGvHuKINJMsSGKJ
 +zLybHG6Vso0SMgIvoazfJXZSqj9DdM52l0/jFkNTMmN4jHN9UTwIUVvMwJlLD/GyIG/
 WdLK9S9zVVa1gWrltx0MYP1N57VCN/prneBN6deLe55Q0xv4dssUzzRT3Xy4CIJJKNtF
 SYomp5NAvaxY7TuiNTzoYjE64VdSUlhztBLLCr5lWr59JuReiqG8TuQThcbHjnbyqy8Q
 yLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175394; x=1790780194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
 b=qqcswehhHJIz4ETnrTr2Nopggt3Prt1io/3DSu8mF0xNy1vA7j+OYwwJEI2nD5CJf8
 vp3/KY0dcEAtSNKGUEc7xyp0+YRZhbtLMEXJn84tEBFuE/CFVlIdYwlrYQghV2EB043t
 Ycsy4KR1vBdqTB6Dk9Pqf5Oe4HWs76t4frscdSmKHC1p9au4fdV7TsFTHByxxy0qMXFx
 xMDj801vJjcV3EtgGKnNNKj0D3EfhZm0t7ZS8IheYim/wFwEXJkhfc6LhuPE4TYbcjwn
 M8jCmxtLSwznm9hD8NB1I+aaraUv+WZV3EMqpQxgovtJgQwbPWpjexCklBu14eMzXP8R
 WsdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgd5dBwGcMC7qzdwVo/Jy8zsAmTY/wTwq/gIsXv5aW84GCYLqvXo4e1l06DcOyw+BrCSSrAavf@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwgwKLANmJ54ogdKgzvXlX8LDpHKJ+BqyZyE3AP61TaqyrlZxw
 MJQL3X61+ABQ6P9x04TC3iItAMEDyvRwqIhvC8seIY4wnWSqq+bUqjUy
X-Gm-Gg: AYBFou0lt8CrTkVvG8us67eEdXadyPwnD6q3IBRuI/Q0C5otLgjiP+KK7nM7B1Lmuf9
 1+VDXrysCmPcLgF2MB1+mzHqPReebJ9gGS1EPVIqc6lRbMu2OcTRZV/d2TEdfcj50TP1FsJZYIH
 AS92uWVYkDbn5gDrE/erifAH1DFKHdjHlsCvJgu8uwGMyoJrzK7z3Wj8dtkMc+OQztr8ajrGJ2z
 NrxNqQ3aa/tacd0GXymha/Pm71uuYgmRRJWUeAR9hRGa1XSSPWDfJOeoOm4aNDvSI4llmuPA9xT
 iFRuaqPHdS4bhBUZCQ8e+AIC21KxaSw6l+JGhNBbpKFbJV0bCb7xZ9hlXv/S+QptfEse7dXCULw
 COmxGTYBY5n3SbT3MyAW4mIgmU2lfjKSQ+HQmKG+ajcJhdg2Au7OU7s1nH+6XFQonO+mZ7SBz5j
 kvOh2y82camhL0fBRmXnxhZbT3oOS9zF2ARGOfOHjHV6JpwYY0jMoIb54N6TJ7p7WzuyaPzqGci
 3L0t9bRpauKyyi6
X-Received: by 2002:a05:651c:a201:20b0:3a5:bb28:3324 with SMTP id
 38308e7fff4ca-3a63067b2ffmr5677661fa.28.1790175393880; 
 Wed, 23 Sep 2026 07:56:33 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f53b4efsm7512171fa.39.2026.09.23.07.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:56:33 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sasha Levin <sashal@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Fang Wang <32840572@qq.com>
Subject: [PATCH 5.10 2/3] drm/amdgpu: Use vmemdup_array_user in
 amdgpu_bo_create_list_entry_array
Date: Wed, 23 Sep 2026 17:56:19 +0300
Message-ID: <20260923145622.76242-2-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
References: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 12:46:10 +0000
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit c4ac100e9ae252b09986766ad23b1f83ca3a369d upstream.

Replace kvmalloc_array() + copy_from_user() with vmemdup_array_user() on
the fast path.

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Fang Wang <32840572@qq.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Stable-dep-of: c833d6c7199c ("drm/amdgpu: Limit BO list entry count to prevent resource exhaustion")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 9fb8012007e2..22d7b7c504db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -224,43 +224,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 				      struct drm_amdgpu_bo_list_entry **info_param)
 {
-	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
 	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
+	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
+	const uint32_t bo_info_size = in->bo_info_size;
+	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
-	int r;
-
-	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 
 	/* copy the handle array from userspace to a kernel buffer */
-	r = -EFAULT;
-	if (likely(info_size == in->bo_info_size)) {
-		unsigned long bytes = in->bo_number *
-			in->bo_info_size;
-
-		if (copy_from_user(info, uptr, bytes))
-			goto error_free;
-
+	if (likely(info_size == bo_info_size)) {
+		info = vmemdup_array_user(uptr, bo_number, info_size);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
 	} else {
-		unsigned long bytes = min(in->bo_info_size, info_size);
+		const uint32_t bytes = min(bo_info_size, info_size);
 		unsigned i;
 
-		memset(info, 0, in->bo_number * info_size);
-		for (i = 0; i < in->bo_number; ++i) {
-			if (copy_from_user(&info[i], uptr, bytes))
-				goto error_free;
+		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
 
-			uptr += in->bo_info_size;
+		memset(info, 0, bo_number * info_size);
+		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
+			if (copy_from_user(&info[i], uptr, bytes)) {
+				kvfree(info);
+				return -EFAULT;
+			}
 		}
 	}
 
 	*info_param = info;
 	return 0;
-
-error_free:
-	kvfree(info);
-	return r;
 }
 
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
-- 
2.53.0

