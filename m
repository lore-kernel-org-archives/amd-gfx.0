Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A72C28B2E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86DA10E430;
	Mon, 10 Mar 2025 13:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qEOD6wfo";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6118510E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 10:47:31 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2139623f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741603650; x=1742208450; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sR/CcMTKsdlA9AlU4rM5jg8thXN0o1ZO9YRyBCXqGLI=;
 b=qEOD6wfoQmfVplkiMgzuVFJbU8XZs80NhGl01e5rFyn1LIRP3+80Dpbm3+qR9kA2SK
 3bRhXvf/vuPavVNdC9ixROoRVRTnXBQtoiGru7OkF51MBO0Ypg8BsXV+KzL98EkWPiwN
 /Cqc38i3WW9U/GwV6RrNnDCUIiJ3aA+7W13zfZL1nECY4PBAQYVZyU0rm5zALIdrYTas
 qJVihOP8bR4BPUF9TqH5w0PB8i7baCGVXzIl5/u4ZW4xgYeWqckvK7NGFjLIJ8hgSbs5
 32gwB3SR+sF/r+DqdcMMCHH3vqVssE9xqJE+OUR/7C2h/T3UuvF0I4usiwyUuS8g/1V+
 acJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741603650; x=1742208450;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sR/CcMTKsdlA9AlU4rM5jg8thXN0o1ZO9YRyBCXqGLI=;
 b=sa6cp5aIF2brHJVjfyb0Ty0XYSCZM5xUBk3SZAHp7prfhNG2y6XxtD5UTeRy1Mh8lP
 pI+GvFQN4yn9zh1z7ezykOVIrhYL3twOmXmVgnJQlnwa8CeRODIh5ctbXgwHmWEK+ZBg
 9yyID7es5euLuWQXy5HDA9SEKFUzaD168Ez54sY+w/MGMTirrJxkY2iKeqxFoSLcPHks
 279RXgIm+LEd2ex96/97zjqX0xPeFR6eWWwgxJjmg2esG3D41X6o4tEfzFAjSK5zr10P
 TBZcNI+iBHHo/gQnpZpt8o/eV6yZNHOHjugO3KHtApn4btT/q4Hr+g09KhcxLvqakNJC
 0O9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrekV2ZkI+FUYk6xgf8ssf3pj1zAcxV/UJEL588c0mhOUPIplqKz3KXfLAtDrmybMEIA9EOetR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5bW98Iyr6j395x0OwNbyETW4RZgvafdEB3AyB+EOIivZN2hAk
 +UO3dwBDMYTCzfhL1sV08a/o0/YPXkwA5AaOPEyb1w6/KYuco6uVZ3bABjBtG4c=
X-Gm-Gg: ASbGnctf6e0MqNsAzqvx4+F/lSZ8cZ7/LR3yUzDVftGgmgilV0tBvprB+BWVP9eCrU+
 XuApMelOxtw6aQLUhEyIG0yTRCwO0iOx+EG6/d2qEJIe3dHpoCwI3vs8T/h2YVDOl9L48GwdokQ
 L5gL3Ya3Pdse5bzwmChAYDcE1K89UGD3ttxmhctD7Ii/p8pXO2TTbm8ogZmUu75ev3kOiuJv0jE
 5qPgfoeOs7VBRov9hEjrKRGzLiXDyEJtRpuwTRqdVBGwdw5hYN4GsqXx12MqlX8TYETUB6zf8nv
 rq0JIR9NS8XTHRFjLy3ZcrMnqx5c1OapF73Lj8mNS06/OOkMzresy5W4yI5I
X-Google-Smtp-Source: AGHT+IG8QM+WxzxCzm0SZiOEb6aIF64Be3WE+Zs9nuUEYTEOzCjQ3A3RPLHlKVFRDpcen2hFRlv+hw==
X-Received: by 2002:a5d:5f45:0:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-39132da8e47mr7295090f8f.46.1741603649926; 
 Mon, 10 Mar 2025 03:47:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3912c01952dsm14227332f8f.45.2025.03.10.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 03:47:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:47:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdkfd: delete stray tab in kfd_dbg_set_mes_debug_mode()
Message-ID: <ece8324f-0d58-4c83-adca-7187f730c56f@stanley.mountain>
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

These lines are indented one tab more than they should be.  Delete
the stray tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 12456c61ffa5..ba99e0f258ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -357,12 +357,12 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 		return 0;
 
 	if (!pdd->proc_ctx_cpu_ptr) {
-			r = amdgpu_amdkfd_alloc_gtt_mem(adev,
-				AMDGPU_MES_PROC_CTX_SIZE,
-				&pdd->proc_ctx_bo,
-				&pdd->proc_ctx_gpu_addr,
-				&pdd->proc_ctx_cpu_ptr,
-				false);
+		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
+			AMDGPU_MES_PROC_CTX_SIZE,
+			&pdd->proc_ctx_bo,
+			&pdd->proc_ctx_gpu_addr,
+			&pdd->proc_ctx_cpu_ptr,
+			false);
 		if (r) {
 			dev_err(adev->dev,
 			"failed to allocate process context bo\n");
-- 
2.47.2

