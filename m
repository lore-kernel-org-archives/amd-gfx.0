Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77FDC282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF1E10E411;
	Mon, 10 Mar 2025 13:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gAY+69F4";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D3A10E3F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 10:47:20 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so3034408f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741603639; x=1742208439; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/usSyZvOMqcO02UgIaZS38RjkJHQ2qzt+JqdGQEbLM=;
 b=gAY+69F4DL7VigeqCE0RN9F5kkDVPH7KAcFkfJ6DQMNowERtbW8Vdp5+C2uBSnznB/
 +8ycTUa5Kz7Kkr7n4be9FlEvUElDVZlBppLiKgK+agTRZiyYfpbu80QAE03MAx5tBYno
 cnKFUIMhqieq1nftzHfis92JZzAuGe6YA3EezwfBoTsZMDTVmx/DFY/06T0KgrO/x5PO
 lIYM2tclfykGd7SgLNLCMSzrOWpC2h/v5IQ5zBLa0dd9GCw0slZ8KtedRRZklwGn327e
 9AZvrvGg3W8gedyoEeQPIBLrKUXj3enNVKnulVeblVWDlsmgK0tNfv41b1hZdiwKeZVg
 UdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741603639; x=1742208439;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S/usSyZvOMqcO02UgIaZS38RjkJHQ2qzt+JqdGQEbLM=;
 b=hCQ0rrmtsqI35gVR24Wm8DgUXidO4dhppBL4RBrYJXs2NgztA1uivkwRbERlfUnOhF
 sJC3ctaBg6arbmVLqaF5gQ9HTW+wBjBHfQ3qZVCV/yuchtaOIL8NZKqJJrDs0hnA4TZK
 YBeBwXrWoL68c3YDPdPKoXLn5wlac+b6rsk8ysNFXdPsBkR/cIuYAsUw9Wj5RGGKplwr
 V6Zzf36t04Kk3GUjmOHG9dXN3c+U+VB8DFliJcib5Fi+m6Mb1QdioIjvqFS/8fmpfmSu
 Qz5U/zztJx+JZ3I8bhasnTGts2ZokQ6hXxRXWFxLSizf9JeT+trVqawn029TtpYvFwH4
 20CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvscH3uCEEXB3R+04ckDkJhC2SOc2B6hFd2gU8ti/YhkHxoZJeP2zYRbrTelQrLDfxLSXrP6dg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMk8pS5qogfRm8k49YpgiAIX73fVZ4jiuhYq9fm3d3Xxo8QtCk
 nAvfeQF5KMTPYazG8VrOH4fGxzm4KOw1Wf5S8nFVo8K04J48lUPWyHPqjWiyNzo=
X-Gm-Gg: ASbGnctGXeDpAdujFLywNBoafL0Rouuzemweluu+GRcS4xAv3iX2jGN7GnxpuJlDZvx
 WvqM3+2JuXr4MaKE+Mta/x0+jwdNBv8Q31CMBnYiVR9pIuJ6eSsS3smmGbEp1GZS5xLYtm4ZnB+
 /n4PSW6qae/maP/wXKYmh6BvGQvmQNOQ0/XlLjYOzjPUvhyITrVu63fbG6TmIQ3vhGP9JZx5o3b
 Pk3MMJxAhMAMjmFX94Xv0K3pfN6ok/3UTHBs2pFq749cQyuXxn3UJladZW/SXiH8vbm5wY6WJIE
 WRXLx3gAo7oOQhCMySScGGxCD1RrigfSGheTgFN9lMqzjV9xkljbTJYNPY6B
X-Google-Smtp-Source: AGHT+IG0DRVFzL2VYuk4+0xwXKcyqK/IIpus26os/g6Pm2aV01RIKQYEWia+Sq3ARp2iOSgT/MR1WQ==
X-Received: by 2002:a05:6000:4105:b0:391:41c9:7a8d with SMTP id
 ffacd0b85a97d-39141c97c1bmr2940385f8f.54.1741603638928; 
 Mon, 10 Mar 2025 03:47:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3912c0195casm14715253f8f.53.2025.03.10.03.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 03:47:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:47:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tim Huang <tim.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Use tabs for indenting in
 amdgpu_sdma_reset_engine()
Message-ID: <2503b45f-751e-4b50-96fd-8dad33821c40@stanley.mountain>
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

This line has a seven space indent instead of a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 39669f8788a7..3a4cef896018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -621,5 +621,5 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 	if (suspend_user_queues)
 		amdgpu_amdkfd_resume(adev, false);
 
-       return ret;
+	return ret;
 }
-- 
2.47.2

