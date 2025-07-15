Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC5C83F2D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DFC10E67B;
	Wed, 16 Jul 2025 07:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l/kPPqir";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF39210E69D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 22:58:49 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-73e64e87d49so179623a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752620329; x=1753225129; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dQdS/fnesxZHeRTbK+njettpxhb9T3PJtvTTlq4Hbyo=;
 b=l/kPPqirYsZPtX9w8YMJqfk6aLgUP69VB02X9pN3Z0/87toKBr/B/BYhuIwMfHQ/1x
 sR6bMkQ0l74KvfL9kioFian9GizNa9T0hCO65te76EXamyn9/BoH4FkPz4eMuh8YJue6
 nwIXOiB/S1QlLHC/cRx0Vw/A26SCfiIwIwwdVSCMZLGoPy668h/06jSq2x2ztHa/oiwQ
 Ge6WaEi1kMxYx8WtwebBQt2bFWsXTwT92tr2F3lRgKXpRVSjI/hwzypPxl91b3BKgddF
 9GhfXY9jlPD/x8UOPiz2psxRz6l5HHdq03BFlRM09OaUyx265zLDXpoepO3CbrZeeeGB
 UsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752620329; x=1753225129;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dQdS/fnesxZHeRTbK+njettpxhb9T3PJtvTTlq4Hbyo=;
 b=lFepsy2C7znR7hcgV+F4+oIkXvDZ8jCYuPMJfJ3Zg22/8kzcu42l3zBIqxM3ZPGELJ
 WSoGDpejyM7E5iKbn55bIUgBav42QaaCqTtr4+5oAC+s1WWF5fcZc32eaNA1Ay1eB6Xr
 g+1Im/L1JMgqD2qsCjaNzOpw6pEtmrMjX7cwNAAFmoBG/Dv5skvka526LHrE8bdRInOr
 fyZTeqg025co1ueXScH2w9COmVW92Ytzx6Eek6f6FHG2Jgwy1jVFRZMZdbVYwpY0ZKqD
 2lx7c2i2ZU9G/WYmRwOQTWyMa5zBe7LqB7Zu/eI7pIPYp0/WPSVL6BVXNY+3+I3Msyq+
 Xxfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkj7BNI3QrmiN4QdQYC7+WIWSlWG1Bpse+ZWCrAiPBRSwrBoBNo9vavKyLYReU3hVI+SpeA2Zf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfNZ6LAyBxatyppVzHkVmRvG2i/+xHYY/j+bHI6m2cvChZpOmZ
 qfBsYHD06Dj26Gd/1khvZ9BOJpZaN9VEDDV5h5qjHmF5TWa9GDWzs/4G2NBNl1dYriY=
X-Gm-Gg: ASbGncsFVgfcjr6tijFP+JC87HM/nP0NYQt6kaeBDdWA/wNJqCdpMAiqhlo1EXABFry
 6c7mUBfBgwujWKhtdaG8vkYx0gWB2Dn5P9lhwMIdillVZi/TMksNiSVt38c4lnBs697cZgUO7Qr
 pWxOlnk/rFKy14CYD6991CMipgZFgdppi35i93jF89RDZshyzOAxb+L5MDhGF8JuFktTpW4XSpn
 Z306FXO/d8va3A4qDdzZhW63UvablYSlkXLeFdqBfqsOrNmTaE00C43Zq2wEVPFpN7KK6rbwYIZ
 WVI20EbPedth4p/lsdxqu9yTBhqHOg5llP5v7VwyLoMINyOINcIZeN8N0ime+esu/h60mC8YTMB
 E7F0vIm5BGgB+8RRYIqHB7czoW5v1
X-Google-Smtp-Source: AGHT+IF8MmVG4ypCu726fhwqLEetif2ChyidvWvdhwWbSrW4wyOjZnawR/MGOE0avl2B+dB2nPbJkg==
X-Received: by 2002:a05:6830:2d86:b0:73b:2751:eee2 with SMTP id
 46e09a7af769-73e66613225mr334520a34.23.1752620329043; 
 Tue, 15 Jul 2025 15:58:49 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-73cf10857b2sm2518429a34.16.2025.07.15.15.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 15:58:48 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:58:47 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: unlock on error in amdgpu_userq_create()
Message-ID: <ef53ff29-4d1e-4f07-a431-c0b91578f93b@sabinyo.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Wed, 16 Jul 2025 07:19:36 +0000
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

We need to drop a couple locks before returning if the kasprintf() fails.

Fixes: c03ea34cbf88 ("drm/amdgpu: add support of debugfs for mqd information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 492f1089316f..c3ace8030530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -521,8 +521,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
-	if (!queue_name)
-		return -ENOMEM;
+	if (!queue_name) {
+		r = -ENOMEM;
+		goto unlock;
+	}
 
 #if defined(CONFIG_DEBUG_FS)
 	/* Queue dentry per client to hold MQD information   */
-- 
2.47.2

