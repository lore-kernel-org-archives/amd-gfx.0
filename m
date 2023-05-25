Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A478C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 15:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EB210E193;
	Thu, 25 May 2023 15:52:05 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27D110E7B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 08:05:00 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f50020e0f8so1809625e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685001897; x=1687593897;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9umes8XISbIusyvA0kgjtSvDb/BpqYd/IdRr2QRP+U=;
 b=LBoXwcKwwosXKjASUGjXThGnq4/uabFkaVvjc2ybnlwL7IfetKEolw8aOAzAJXnOJC
 vyyurtXYn+3HtvsGReWUQ2NuxcbR6V0MsgX2x2Fise5PadAlWSFzV8Vb0lmtAtVoT478
 8xu/JEmD1K5apoDkFQLQ3K9wZk0ti5YW9XqBw+UusB4JaYm0byM/626xs+qC0jfodzUu
 HehNFznp9qP51fvHVnsAtUHwZOQ7mZugzGomcpUZFM9DpcwWy9lRe0OKTyXCTelGSCgV
 s6K+LFzRgkgkfy+JpKPnb4VIiYhBLScbKIpBUAZaP48rik050xyLZJ5c68Yl5OVo9txY
 DIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685001897; x=1687593897;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X9umes8XISbIusyvA0kgjtSvDb/BpqYd/IdRr2QRP+U=;
 b=W+AYQTPi4HvyT0Kaf3Vb0K90L4vijj00RO6zG7CjjQesb2f08m1z5eYMI6SV1UXY4y
 cbmlcaODNfUOtUWoa2BWhbCJD/u5ZCpE6LpGYcWqWip7ru7cN5T9wB/jWqFU++0EBkGn
 P/l0dtJtulwojbvrEF97qwjn1lQv2KBtgxFxLByWalGZc0KKoUnUDflZsNG5vz6F7x0F
 YPuQZeDOHvh7zieUea7o0k9O5uheswOKsPWTnF7+6WgTHh/BPubminszxqyaqoyEqz1B
 k7/EPl2c4M/Yos5FhAR0LUNMRp/MbcJ5V/tHBrXPYKQiNhVoV5kaaiunQ6bZIJzs4iPR
 Pv3g==
X-Gm-Message-State: AC+VfDzT6qugPnY0QVwYFKRAwU+bXXOB0i3FwOqudmPPF6ZKcLCThVCw
 44WdyV0e2mSELpM2dtuz37K0QA==
X-Google-Smtp-Source: ACHHUZ4jvFv2dvB/8oIkBX3T35h24vm5rz4vxKJzmZmi2frn0oX3g2PZrOcndOeytuhkyXa+v1fyqQ==
X-Received: by 2002:a05:600c:35c7:b0:3f6:557:6893 with SMTP id
 r7-20020a05600c35c700b003f605576893mr1290274wmq.19.1685001897163; 
 Thu, 25 May 2023 01:04:57 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 24-20020a05600c22d800b003f4e47c6504sm4875434wmg.21.2023.05.25.01.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 01:04:55 -0700 (PDT)
Date: Thu, 25 May 2023 11:04:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix up locking etc in
 amdgpu_debugfs_gprwave_ioctl()
Message-ID: <bd6a37e2-438d-4292-81e8-5a8f0b10d647@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 25 May 2023 15:52:00 +0000
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
Cc: Victor Zhao <Victor.Zhao@amd.com>,
 =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 kernel-janitors@vger.kernel.org, Sebin Sebastian <mailmesebin00@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Le Ma <le.ma@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are two bugs here.
1) Drop the lock if copy_from_user() fails.
2) If the copy fails then the correct error code is -EFAULT instead of
   -EINVAL.

I also broke up the long line and changed "sizeof rd->id" to
"sizeof(rd->id)".

Fixes: 164fb2940933 ("drm/amd/amdgpu: Update debugfs for XCC support (v3)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index c657bed350ac..56e89e76ff17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -478,15 +478,16 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
 static long amdgpu_debugfs_gprwave_ioctl(struct file *f, unsigned int cmd, unsigned long data)
 {
 	struct amdgpu_debugfs_gprwave_data *rd = f->private_data;
-	int r;
+	int r = 0;
 
 	mutex_lock(&rd->lock);
 
 	switch (cmd) {
 	case AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE:
-		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_gprwave_iocdata *)data, sizeof rd->id);
-		if (r)
-			return r ? -EINVAL : 0;
+		if (copy_from_user(&rd->id,
+				   (struct amdgpu_debugfs_gprwave_iocdata *)data,
+				   sizeof(rd->id)))
+			r = -EFAULT;
 		goto done;
 	default:
 		r = -EINVAL;
-- 
2.39.2

