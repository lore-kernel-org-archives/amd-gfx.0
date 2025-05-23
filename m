Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E1FC5B541
	for <amd-gfx@archiver.kernel.org>; Sat, 24 May 2025 19:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E4C710E12A;
	Sat, 24 May 2025 19:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ItNkI3Qw";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E7510E82A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 16:06:03 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so77747605e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748016362; x=1748621162; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3PqxfXynfBYuWj+aBPHCbylQDdPJlTEN/Ktqk3XEWc=;
 b=ItNkI3Qw3Va0eL6dZCetgoUBDWtiCIt8JAqZxfWRw2gLngZUqKLjNudsWt+A11N34q
 if7oRqZWSgXXKVX6sTVxzmWxDkpR3rYiFkwCN0bcinO9ktJt6IjqYGnnyimu8NoVh0eX
 vJHhrf05KboWboOP6IwYz7duApwFaG64ZdjiyzK55defh/HYk43YyhdfHjrSnMCwks1c
 1oO171ple7mKS0stAWbaY4pYNTmomYFoNdtRwZ0cSXYU7q/3y2kNWvpn7bP7vSPTeN/x
 YHANQmH/lHxTyUB2HvTC5DcNDeQJygdzEMmqKVlNVYNNpeMfUhvQcZ9JaRlzwxdJXnm8
 5qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748016362; x=1748621162;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3PqxfXynfBYuWj+aBPHCbylQDdPJlTEN/Ktqk3XEWc=;
 b=UUvWJ4CRxj+9yGejEQg+ZeB5SE8LzSfYn3SKJIp3bPs8GKuh2E0XYqaLk1CE2M1xn9
 TeDIZCnp7C42mxLJnZcOoWsLBKtqOnRRMoPL6gEZdTjUkgBTVQQzzSTJWA/PdIgyqCYW
 3rP4Q4mLTNvKwP8Gv1Rs2gJ3Rycmy/5RehkNC1zMdWovSg/pbdvUTANm6SHt8K1XYBLu
 /RgGzv0uJecOobGujfwwITDspbQFd4gQC0m7kTBIDKPZfWyMwiakYs8rVex8bCeYG/1n
 hM4oS9oOZf9dBPMfzUMFdGasliCZPjwM+cN2W4aR5zXw2+CSuhTSyfJ8x6VzCYEOE9Yl
 nzAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUXue1j7sQjqa7SjogEz/Blo3YBz9JKiYtb4HhQJeszrtq/6BHRDEd2zUgsGW8w96bhTJGZ0m0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8e3JttsNFe/ja3W1r1+qY+WAfmkENbztYE1LkToURXzXTKM4c
 Jx/l1Zo/h7GWblbE9lBCJyAUKyF9T/2G43AHdYvPdNqwL27OzRKDu074SoyVIg8nnh4=
X-Gm-Gg: ASbGnctahZ3JNIjpemmLXim7q2dKx3D1yuOMiz7Gavk4qUVyStFzHGiU7QqRjFTFGdr
 jSVfNETn216LF/6v8bSqPepZ5cWrt2M7rH/IGVRgG9h96o3Q/F9+2CCaGuNau8RSXjRV7kNI20V
 ZeXD2Y0EK6IswQvN0tId/YEb1tcODJRVkSdWnD01dgzCCk50Xk0p3NTXgkLjz/00Q6vxukCKIlp
 xUbbv8yYq5gYMOfIPx1N6IIUi76IETJQJAtnxLy3cQQFgYdIPxSpiyqdDFVFGN61j80DTma6Ahd
 rymzoy7LGMWJwrzSH9uCzvcdfTz2WTL6ZCYyZP9TuHcLygdsDGbbH3T5
X-Google-Smtp-Source: AGHT+IFJ5XQsT7wDZaHxzFgw6dPrlGsnDhIqeTPzVlX0Fk5sLByi/O7PehwjP3rV11vD6uhtm2P9yg==
X-Received: by 2002:a05:600c:548c:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-442fd6759c0mr247232745e9.33.1748016361628; 
 Fri, 23 May 2025 09:06:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-447f73d3edcsm150813565e9.20.2025.05.23.09.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 09:06:01 -0700 (PDT)
Date: Fri, 23 May 2025 19:05:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix integer overflow issues in
 amdgpu_userq_fence.c
Message-ID: <aDCc5kawU4cWj-Cx@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Sat, 24 May 2025 19:20:04 +0000
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

This patch only affects 32bit systems.  There are several integer
overflows bugs here but only the "sizeof(u32) * num_syncobj"
multiplication is a problem at runtime.  (The last lines of this patch).

These variables are u32 variables that come from the user.  The issue
is the multiplications can overflow leading to us allocating a smaller
buffer than intended.  For the first couple integer overflows, the
syncobj_handles = memdup_user() allocation is immediately followed by
a kmalloc_array():

	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);

In that situation the kmalloc_array() works as a bounds check and we
haven't accessed the syncobj_handlesp[] array yet so the integer overflow
is harmless.

But the "num_syncobj" multiplication doesn't have that and the integer
overflow could lead to an out of bounds access.

Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 029cb24c28b3..bd79f105d77f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -430,7 +430,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
-				      sizeof(u32) * num_syncobj_handles);
+				      size_mul(sizeof(u32), num_syncobj_handles));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
@@ -612,13 +612,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	num_read_bo_handles = wait_info->num_bo_read_handles;
 	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
-				      sizeof(u32) * num_read_bo_handles);
+				      size_mul(sizeof(u32), num_read_bo_handles));
 	if (IS_ERR(bo_handles_read))
 		return PTR_ERR(bo_handles_read);
 
 	num_write_bo_handles = wait_info->num_bo_write_handles;
 	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
-				       sizeof(u32) * num_write_bo_handles);
+				       size_mul(sizeof(u32), num_write_bo_handles));
 	if (IS_ERR(bo_handles_write)) {
 		r = PTR_ERR(bo_handles_write);
 		goto free_bo_handles_read;
@@ -626,7 +626,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	num_syncobj = wait_info->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
-				      sizeof(u32) * num_syncobj);
+				      size_mul(sizeof(u32), num_syncobj));
 	if (IS_ERR(syncobj_handles)) {
 		r = PTR_ERR(syncobj_handles);
 		goto free_bo_handles_write;
-- 
2.47.2

