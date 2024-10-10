Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85578D1625E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 12:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2895A10E29C;
	Mon, 14 Oct 2024 12:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEk7NgH2";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6083710E0FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 18:35:42 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4311420b63fso9239495e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728585341; x=1729190141; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iy+C4p8CaCgRadOFK5HsELQcw6dO91MMQyaigcmnelk=;
 b=zEk7NgH2OkMOUAEJNhUngIiUwYUtkbPlimKqXxAj10iKaj+6HoXUoGjkYVMjdCf3iO
 1Ueq/iXflFluM4HwcuPunMYn00Rf5hx1RpJIgVlL7qf+RqSqKMMrtYb9Wd783Q0mHtlm
 2f3CwIv2olJ3vJBVO1YJjq5FG9RW+7qwJTUSXYmYsLgncO8JMqiZHlDt1r9OA5vj9bOm
 XcWjHzudQQ5s9HtuBLNx2dE9UJgZxyAi4zGj78IaFXM6BgJBNKWEu3QM6n8E1eJer08O
 VHg0gVqGc6DSQ44IQm96Ukv8rKU0KaRRU2NzqCG9PS92kMAVrHoj+hP4X26qtQ+C3f8i
 ogKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728585341; x=1729190141;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy+C4p8CaCgRadOFK5HsELQcw6dO91MMQyaigcmnelk=;
 b=NLDYeaUX9V0veyUB305Dy15KERlkn+H/oTu3h9haedcrTB35Nf5Sgs030iglz24uAj
 n6gIH3VuiyWbltRomMI7aaCQ6b2wWCT+3d7ZHLGsIunnx09yN1HGBkRh1QG4Lr5z92xf
 thg/sy1iGZcIF+vj7jSHc+bGt6dpC7IqtukgONz8V5pXBnvenHqZChkeDqKRgklTUrS8
 dRtqUDhhf8131S2vXvrb8pwXxQ9RpSqckivIys6dTuOAc00ooDnn950UCsxqzzf6o61u
 geccTwQzbJhIyMsKMA5fmOecaKMTuudkdbJhnrFyJ7S+wTloxvW57VxWm9Gnd+zjEgzJ
 Enyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGe04/qj79Ng6Gf9OWoN/ZlBz02wwqiE2UK70hZ1nJY4ra5LofUP0DLL1Oh1Tyk+O+4uTqnPcJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqLfPrVwSdZp79UWMSnd1UQ64aVDPdJPFpBEd3jboFY1cf3BZQ
 sIclZZBGUzKgoA4e2UNINiZTIxwU41ZmV5rULFyyeJiav5VHrWnEvzfD0uee7Vw=
X-Google-Smtp-Source: AGHT+IEG5XeqWq0+eyA+3/83jP6vMylO+zmJtnB5SbNtZ56GnxMRoNYSys5K69hCWruqjJKATBUPqg==
X-Received: by 2002:a05:600c:3b9b:b0:430:5846:7582 with SMTP id
 5b1f17b1804b1-430ccf1b335mr57690205e9.7.1728585340737; 
 Thu, 10 Oct 2024 11:35:40 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43118305ab8sm22967065e9.21.2024.10.10.11.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:35:40 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:35:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Fix off by one in
 current_memory_partition_show()
Message-ID: <f3cf409f-2b04-444f-88f0-9b4cfe290667@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Mon, 14 Oct 2024 12:50:04 +0000
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

The >= ARRAY_SIZE() should be > ARRAY_SIZE() to prevent an out of
bounds read.

Fixes: 012be6f22c01 ("drm/amdgpu: Add sysfs interfaces for NPS mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ddf716d27f3a..75c9291ac3eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1199,7 +1199,7 @@ static ssize_t current_memory_partition_show(
 	enum amdgpu_memory_partition mode;
 
 	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-	if ((mode > ARRAY_SIZE(nps_desc)) ||
+	if ((mode >= ARRAY_SIZE(nps_desc)) ||
 	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
 		return sysfs_emit(buf, "UNKNOWN\n");
 
-- 
2.45.2

