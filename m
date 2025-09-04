Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737FBCA101F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 13:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED6F10EBA0;
	Fri,  5 Sep 2025 13:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i/Zei/40";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378D610E267
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 18:58:54 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3ceb9c3d98cso868047f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Sep 2025 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757012333; x=1757617133; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=THAARjTe9E517vMG9YGk7Zlz2cjrMzVkQSu/T28Yamo=;
 b=i/Zei/40CnmYs0NUHiRNBhqsqxemQl98ygOtNUByiDTP+9TKsRndVUY7qEa6BQO5Xf
 9b3xEQQcSsAOhCqCXESOHNLil1ZshCz8x/J2yDwpZ7gCgETxJObpinPjBlIQex+gbXCR
 lQgpd1IoaIhOUe8XuALaMig5scBCfsuVuXc+kTVl5dfw6p9p4AE/wSJdY2FTdXFCpRAG
 Vh3tS9KQWsMvg5W2wJ1MoC30qvBFQf52+tpsQmvkczDIdixup0ucsYWs19Tvw18pljVK
 FTPcX8hoQu7ZvMUhkR2jioNK9jQq94D2xjxcPBMLEc06bb0Edg8kQ4PcIj3vD5+YgLFz
 5DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757012333; x=1757617133;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=THAARjTe9E517vMG9YGk7Zlz2cjrMzVkQSu/T28Yamo=;
 b=CrFkeNTrqjsvrPUT2IJClj6HpNig3z7J06Q98haDCKVe1HbYhqjFalzwWUIWUhBnLE
 8FfeiW0737qdkfp5AJ3zsLPogBKLf0O6fegbgo2MhyYnuJrtEpnBTVqnA/Getn6RGB5a
 sZ5wkF8hue7an3Tyu54IRiNOSVgpeCuOsdDuWfepJUvLTiSp8/n6dLj75/h9iZYjh6t9
 w+/mtZ3oH9pMNXZOf5MvDgFXKkiM6FIv0cqKBz2PmdvKDhLJH54WDEya7MKnh2pXmm2p
 y1xEHaN5K61HWIVzlds3XvSXNGyualPFx1ie7Ky5NZUUCJdtBLWhJYxrSonxc5/FAKCv
 cdhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNltTvspwTqshVss+HnH2ZGubEhRxcahc0N/3bRRV3ir5/w6TyHMBRJ5YHcfuFuymQhNoOWaBJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDROuF6LsllOgp2di0wgX0KGY2DCYuw26DUJDABws2ZrXa2dbE
 hUFbU+AwH3ISL+cxqYUTPE+JZ3o4UdZ/D0sD9CdP21yE/4klnUqQpBoQAREiahxTS18=
X-Gm-Gg: ASbGncsJgifW8xXqucQjrdBkZMQzCeXe8UD21foXfgwh1nf19B05zQxFUkGb6yk7hYO
 /isqD3rxVuyW0sXcE3h5ZiwXPAJ2InhZ7ejCuETF9SjmIu/3VPWjvm3OelmAlU8lwiOI+8WXcjc
 MComVug2UdY4UdHzErfvh1tOAoI46ph0Bl2nfGLJf66n6+iT2uh4DS9IDEqKquhXXaHs2dL3bId
 hp7gCTcIGY+Hev6d2STNL45f6Ovm3Gu8mWq8QeGQfivrp/UdSaRqsuO6pcZigWlPmM34ij+NrTV
 nZT7tRoqBpxa/RYn9W1ivJwlrMyJuRcWbsML7a1d0wCyKehhXMkdaJxK+5OEZaSqRyjV3rFL7Ob
 H82WNUl40k2koz95vMBSjekaea1P14BoYEZySBA==
X-Google-Smtp-Source: AGHT+IGHjaQMqzH68th7G1hlLUvy5iZJ7Ftrhmy23VSwVbhKc0VKhfXm8Y3FkmDt97UXGlsf+UOBzQ==
X-Received: by 2002:a05:6000:2906:b0:3e2:4a3e:d3ee with SMTP id
 ffacd0b85a97d-3e24a3ef991mr1671892f8f.58.1757012332670; 
 Thu, 04 Sep 2025 11:58:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3dbead0b247sm9395154f8f.6.2025.09.04.11.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 11:58:52 -0700 (PDT)
Date: Thu, 4 Sep 2025 21:58:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Francis <David.Francis@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Fix error codes if copy_to_user() fails
Message-ID: <aLnhaU9cLeAdim7J@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 05 Sep 2025 13:03:56 +0000
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

The copy_to_user() function returns the number of bytes that it wasn't
able to copy, but we should return -EFAULT to the user.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Fixes: f9db1fc52ceb ("drm/amdgpu: Add ioctl to get all gem handles for a process")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 63eb75a579ce..2b58bc805374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1067,7 +1067,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		drm_exec_fini(&exec);
 
 		if (num_mappings > 0 && num_mappings <= args->num_entries)
-			r = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
+			if (copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries)))
+				r = -EFAULT;
 
 		args->num_entries = num_mappings;
 
@@ -1159,7 +1160,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 	args->num_entries = bo_index;
 
 	if (!ret)
-		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
+		if (copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries)))
+			ret = -EFAULT;
 
 	kvfree(bo_entries);
 
-- 
2.47.2

