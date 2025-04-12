Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46324C369AE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 16:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE43890EB;
	Sat, 12 Apr 2025 16:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwXb2Pfp";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C76710E29D
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 14:39:32 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1767362f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744468771; x=1745073571; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fH5ONljI8GT+5P19EKjih5JtNzqqyZ9zYDYMcWxctBA=;
 b=mwXb2PfpBl5Hn4qAzi9Hx+6xXkcfhozEzNkK/v2ZVTYuobNzXAdDuLuQ00ppBX5+V+
 BYdFe9vO5Mz1GF6b4zHuIUn0AW/4r+LilIGhaQxh7puFLAd/GHyh6DZVe+io2lTXbYBj
 o3sLuogWIDyKVCymA9+TuKsf+CypGgJ1B2WDBemIqOTlTG5fglJymtBn3b8YkB9jwc4V
 JL9rSsCArXKUlULuIMeEv9Mdba6y5YT2FaVl+Vj8801MmcL03w/Wdactq2fRcADe6ypO
 MdV4WPx4pEQC/izu75Z8s9ZRZwuv49jW1IwZhInEqMKSA/ZH8JXt9EiH+Rhu3SWm+N18
 kwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744468771; x=1745073571;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fH5ONljI8GT+5P19EKjih5JtNzqqyZ9zYDYMcWxctBA=;
 b=ROAyogB94a89Ye/H3LOKbwLoeO5dLyp1UiJ4rGbi25uFYYsgeXbdGh/drR8hHl04Lh
 0/mEg0AV5zGMYPdBJsX28QcxgntIP/vRzCqax959PItUBsJlv2QqLygxxDn706so14V8
 hZAFQdWt1UwJ4s5v+xBBUkVGgvkNGlunF+oM7XGKA1fK/VJ3tU5RITvGgwvxKukXhDpR
 Cc7L1pEA236riS5TB0/XcPp7zIjVc9FOmnb+pa95CIOwK0tfNdQd7R6N2GnjDOq+E2Jz
 lByUr/4vppC1zhQHqsQDPycVvP2C7OPaBQKdJhLCZ7f1DytSP4+IWoa7oAuSgFa11bxY
 38+Q==
X-Gm-Message-State: AOJu0YwFkhl2QoTs5tS+nff7u0LQhz8P/MVIPp4UPlj6kPKfj0Kuk0K5
 Pmam3M2Ay4jSB8Zry6byRImjICPCwS4vSkl7w1aRVYz3y5Msh+PTmp+lDFpCsfz8qmXyRWDgjHX
 v
X-Gm-Gg: ASbGncsz/pCSxnM4QPLMOC7GgSQ5dHtkOohLZ5AAG0OMac/Oj7thtBUjdmq+U67RM2Z
 6qbVp6fmwN/bMdgt9sF4Epxdy8RU8cE9xlLHFSUu7kA2F7IZxWQSWPaL86xu4fDW1JhG7/skK/+
 YZxXeR+UWFkvGjWZMYucBMnQljJV9JG6g1EBRJbHXNm2FDnBw4BL1KMmId7UiJvFOKirtwXKkMc
 cTWgsM3GUMk5e8RQwqdeyA42lsET+aSElyo9YJ48RLPapSD1BnjQdEwSpYcAoBo+DZ5JHthtrFd
 BxKtmMJo7hzXZk7o1Lm8Nv1Su2umFZ7R6L2Hp8qvKxlUIw==
X-Google-Smtp-Source: AGHT+IF4Ob5u/42ggewD7xMGFQEe6dX1to90QjwleLQR/ueLvNKKi8zaTz7pgBKjx4hQiQ1U9Aob6A==
X-Received: by 2002:a5d:5f4a:0:b0:39c:dcc:6451 with SMTP id
 ffacd0b85a97d-39eaaebc75dmr5347890f8f.43.1744468770666; 
 Sat, 12 Apr 2025 07:39:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43f2066d14fsm120982665e9.21.2025.04.12.07.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 07:39:30 -0700 (PDT)
Date: Sat, 12 Apr 2025 17:39:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shashank Sharma <shashank.sharma@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/2] drm/amdgpu: Fixes to amdgpu_userq_fence_driver_alloc()
Message-ID: <cover.1744468610.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sat, 12 Apr 2025 16:07:59 +0000
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

This fixes a double free on one error path in
amdgpu_userq_fence_driver_alloc() and cleans up another error path.

v2:
Did some additional cleanup

Dan Carpenter (2):
  drm/amdgpu: Fix double free in amdgpu_userq_fence_driver_alloc()
  drm/amdgpu: Clean up error handling in
    amdgpu_userq_fence_driver_alloc()

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

-- 
2.47.2

