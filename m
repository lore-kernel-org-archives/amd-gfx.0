Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36F2C2BA1B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E8C10E436;
	Mon, 10 Mar 2025 13:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RQ8qLKDc";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21AF10E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 10:47:08 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso7535395e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741603627; x=1742208427; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxe2UdMnuICWXIR/40yTHRWRgSj119FGmCYLgFhERXk=;
 b=RQ8qLKDc5svHoBtbsJlpdO+sl2G4W1JqPV+KeEvhgNG93WNseQhskto8aC7lXCiZc9
 sb+DRcsVpN8OUSEfN+4U9rMpdSsFE+TnYkoTZY1A5SwtR5OmhnZA5vubl1G5bdWQ8+UY
 Hs1cTcpmtrTl4fd/WApm+uzPdAiQwkF3/s7LiIktBj0cO0myUbxtSgd+BaKGUUPFLldk
 qjZclxpg/bjJgCdThzvyEdv6CT1WwxNOvOFKXXvOcE42wxWwk50BN0IiA/RGQqk53QzO
 s3X7bbWULEhCcfScIUa68KGGYgjbSUynB89MFxrZ+km1mULXZZ6utTmTRKy8c8T5nZiZ
 ZY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741603627; x=1742208427;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxe2UdMnuICWXIR/40yTHRWRgSj119FGmCYLgFhERXk=;
 b=BH5ND7OvKf+hTwHqTscD3yrBwiTCiuy0AG0xZuK29RwZtoU+lZARebxaBczsL8vgwU
 QNkZDFKKmUF1Yf0yzxq9MdFQqQFSCsIxBrdJ37yp04hLDgs8Mq6sE50nMohCj7XdhhyA
 UJo8NtphxJBKvGSGtM4SM63BEl3fx+dD+Uy/VN5kZaJ+NRRoS4DcQGnN0HNyre1wY7al
 Kkq7dlvhs3yOXQvMob/ABjAOCoZY6cXjQXNgXbC9Ihvzd79aLui+dyjodaAVWVZA/oIF
 /6WbdlSnXnWJkXNhYp4nL+UU0+YUrKKd7MJT5AodJ9Ddr+u8ekZ20KjxyUokSSCaQCL2
 ZDdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVILdkv2w7vrLIYb5sdR5jNlu+ikMvmCFA1S3IR6wFmqXjVfzEd7dw59m22tcvBLfniqwEXh0c@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxvf1EfdRcQub60ocsD/L84GgbKlluAaFgWvpeqMo9I59bEBLl8
 CBZ0pDSqxMeGPJkPYlyDJQs5d1tPHzwnPufPXSWol9OyJa0bSCqubP8DYhdpW2Q=
X-Gm-Gg: ASbGnct/ThmpHVjeAxkfKC2fw1eka88NaxLCWGZcAW4QlhDkY9r2VYLyZn/lmhWliI8
 7eWf69zKOtkw/Z9kjge8TSmjUqZcG1rEVQWhy9jNGkiYVvemPxmJSx9m+y4iHlPK81piJzTU5D8
 lZvrRg9URDUgsk6eG0sb2SfQT6mJFJInq8yhgvdmit7/+Xjkj7VqU8/OoSvPk+sLmeAOoPT90QW
 VZvKZzTPd26ZnKpV/KNvN4BOgtjuLk5nlZEAdtqnxJ3FsAEaO4rwGrSvESflf/zxSGRjVEK3qsl
 Ts5zOPKhKpp/oh4mseVRQSstUNmsOTdJxAIOVTOQnUk4urVuAg==
X-Google-Smtp-Source: AGHT+IHZYEMjLRapPZhjVBke2kOIMDf3xY9p9R2H2E6KyfQ0Ja2SOjNPA2cXqXY6FK9cu+NqkjeCfw==
X-Received: by 2002:a05:600c:474c:b0:439:9b19:9e2d with SMTP id
 5b1f17b1804b1-43c601e1393mr91960565e9.16.1741603626942; 
 Mon, 10 Mar 2025 03:47:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43bdd8dad73sm142867745e9.19.2025.03.10.03.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 03:47:06 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:47:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu/gfx: delete stray tabs
Message-ID: <92b9d527-fa20-4e4d-a4ce-7c442df9df0e@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Mon, 10 Mar 2025 13:09:12 +0000
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

These lines are indented one tab too far.  Delete the extra tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cb..984e6ff6e463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2002,8 +2002,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		if (adev->kfd.init_complete) {
 			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
 			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
-				amdgpu_amdkfd_start_sched(adev, idx);
-				adev->gfx.kfd_sch_inactive[idx] = false;
+			amdgpu_amdkfd_start_sched(adev, idx);
+			adev->gfx.kfd_sch_inactive[idx] = false;
 		}
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
-- 
2.47.2

