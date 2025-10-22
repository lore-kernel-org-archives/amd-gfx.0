Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94D1CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0007110E8B6;
	Thu, 23 Oct 2025 07:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FDDr5FG0";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0E410E752
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:04:34 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso6138615e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761131072; x=1761735872; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qEafg9Klu5zOL06Nglfzdv2mgxyWpLG/yLgQwga+NA8=;
 b=FDDr5FG0SimetTw7Z0vlrBz2Ucdau/XGAMbA13O0FJxkhS+M4DnPxIJCCUenWVHk93
 WO/V/OMcpvhVda1hah6uGinRaVsDvVh6WNc1rR9ZmPrmW57t8IG+0tDk1WMMnW7wQGMl
 iWfwckCcSRwSag5+Liueas5hAD3Ke8aGBSSZZfDT/7+I2cTbLBdAw8TBZWhOibB2X91U
 TGBQc/akCJH+z3mCQHqdNd3c7LKpfK8S1G37oKmLJsLm4MU7hnD0WsKlgmIqDrryzyfD
 G8HaTMe8LzJUSijObJmDtoKom58rHob85JRZTywtKmvcFcDET9vwkmxrzzN4+JEPUQrA
 E9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131072; x=1761735872;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qEafg9Klu5zOL06Nglfzdv2mgxyWpLG/yLgQwga+NA8=;
 b=DwIbTcKHpNNyV7tHlFeK6JuLRYfFPwZ3Qqql5rEEOBKvU1kD65YFS5x9UKqNQ73S0T
 IeE8PLYVkDjhoHmi35Nv7oRnws9RY0+6JJ4WC1Gay/fqptEPtatBkR0aw3T10esfQZbJ
 Hu8FVGVfuPEnfP36BflW9qRNWMtBP4vSfiLMfvK9VEacbVobjaqNp5cbNuVXlaK07+Ee
 AFt432pTtctrz6AsSY6XPgMBFhJZ9R2lIdxU5GRQBKOZn5M5XWTrFDT5iLIH2rlGOOY2
 Um7fLqy+O6cl2Yyi1uJg7eKhCiJhU7ohAYrJ7+1e4ijIsB/ovKC7m9PezT/PZfvAKXmA
 eWjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/URrOjyLhHc7+Gdnm1X4KsxJyQPNzXDmj1U5VbVz3HH91hB8mnVcHUmbWDtLY9we2HfFZmMGk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhjMgzT+RqH9ZWXPcGlvR+04Z6uH42aem23sSADTL0qmtOIZyL
 V9ylJ6xvwqg4LdEkaaDKTWF4Zfsk7hoaiz5uXjtybGvvcww1kme/96EN3MXTz2U4JVI=
X-Gm-Gg: ASbGncsalrz8wvl9yAW5whXdN7pRdkZFMpGr2AZ4r89Xaz+fYWE4kHg1YiGrCTwA+IZ
 voo0vNIUELjanZErVL84B+8W4nRWvugXR9fm0VeYB1h9836/S24+zlaakTdsm4eCig5mD7PEloq
 i9cZ7OYZGMfAuqhLyg9kJHWMztI4t2EnxM4vlU6wNFwx4cz3icj54nTH4XyiVWc6pm7inkaAEk8
 alu6Ms6s31dvl6bpBIjvbzrNLl2BY5pkAE7GTwN8MQIAa1kLYc/aZwqDYgBKDIdIp80/UVqmHEc
 vPpFSfBbgmiCWbKJju17Hu8YdZDITXdQIaFJV4ax6hBwhbuoAJFw7sFT1fYLqY36szWDA2gQ8QV
 L3cjZFObxadvtCeredCAkoNo74qGvbquMPajF/gtHyjMqjrLYE9tWxmdUMlSnqIDexxpHaWf1yA
 u6Ferhmw==
X-Google-Smtp-Source: AGHT+IEvzeQmuJZVlQvxOVzt5DBIbtifvWSq41OHqDirBuHQNqktljPPP8+Q3xqBRDvi5bTZGQ8Z5A==
X-Received: by 2002:a05:600d:4265:b0:471:1e:ebe8 with SMTP id
 5b1f17b1804b1-475c6f5d0edmr6359645e9.10.1761131072473; 
 Wed, 22 Oct 2025 04:04:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-475c428a534sm44924865e9.6.2025.10.22.04.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:04:32 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amd/ras: Fix a NULL vs IS_ERR() bug in
 ras_process_init()
Message-ID: <aPi6PTnGfpG02RgK@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

The kthread_run() function never returns NULL, it returns error pointers.
Fix the error checking to match.

Fixes: ea61341b9014 ("drm/amd/ras: Add thread to handle ras events")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 02f0657f78a3..1d2f136fbe2b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -241,9 +241,9 @@ int ras_process_init(struct ras_core_context *ras_core)
 
 	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
 							(void *)ras_core, "ras_process_thread");
-	if (!ras_proc->ras_process_thread) {
+	if (IS_ERR(ras_proc->ras_process_thread)) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
-		ret =  -ENOMEM;
+		ret = PTR_ERR(ras_proc->ras_process_thread);
 		goto err;
 	}
 
-- 
2.51.0

