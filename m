Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F2CD0C606
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 12:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885EC10EA9E;
	Fri, 25 Oct 2024 12:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c2RmtRy/";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0EA010E13B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 08:17:22 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-431481433bdso6149765e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729757841; x=1730362641; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jmI8CZ4fHAq0Xmul0DkZ8lYpCWQ/gTUaITTUgzA92+U=;
 b=c2RmtRy/TIg0nBSP0MqppUOL6RdgnGOn9fRmmLwMznsloRodFx5YrVPEtKwQ3KQzME
 MG+8+WT/9jK8rzoWzXyL4FZehVaRNq5Dd/TyRXhALwKQGx3zhyoXf0ngTx7IOLoSXaPu
 fqEgyoXF/jbgzXz4/dQOm1YGM4Z8c05CI8uP8g2rhTWqdvy6z8XpbK/g3vvv/ZjvYjyF
 hqwBOqKDXj7KyvDjGgLFBaIkpSCUAG6onGmOqYe8c5vKnxtY+L33XJfvXYj4dUsDGzt9
 m7bk6J8YQjqFy2H3KqNKeaDCm0VHFIDWriTHHJo/+y4iCbiT26btZFHIQTXZM1YsUOJK
 eovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729757841; x=1730362641;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmI8CZ4fHAq0Xmul0DkZ8lYpCWQ/gTUaITTUgzA92+U=;
 b=DPVeC2tOt3UIgWoFITr10WqEipg3SayKKGk07m1pUqwG0TeGk6WQRaGjACOWlR2aQl
 ZSWD9p2SmdRUdrYvbKSeCzQrYAU8C46E+brGYb0p/N3rCyfVFfirJ870Jw1vbxJ1r/pD
 Ajd9o00W4BpCZrD2+6LIrDy/CPL2UTFJ6/twWEivc9fazy09DjFubFviqs0vWoLzkVhQ
 MVAGw2NCMH9aOWW8nz+3fkhAWNYp2fPSVdfB07YtQu2lkiAZb5+XcWE3M6BPKpdog7LS
 kT0CG0WaGDT8cZsK4PjLaeLHub9G2evMbPk+Siwcd2iYZO88K20nIhGwbXDmZopP3JQ/
 MDDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4bPeeHxZJCnQ7SuePjMEqkc8rkpRgAFPnKAiIacJzctvN9Gb0oQaIiN6vzmuJ80DRUS/pQEIJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywyu4IplsKJ58E8YDG2fqDwq7Flt623+9YsdKoOWtmlB1wrkwlx
 3RQEYzu53VqkpCtP7Ex7ltIPFNMqzOKC4n+tFnpKD+EiZybk/e1tiv/6yIOhb7s=
X-Google-Smtp-Source: AGHT+IE3Nx3OTYwJ2zj5wQUJ52gt4WAcF+S2WAkAz8S9e4+HmoQbErAeCCyoj3cZNQaSJWvWbko8rg==
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-431841aff4emr45292785e9.29.1729757840836; 
 Thu, 24 Oct 2024 01:17:20 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c0f4cbsm38315275e9.38.2024.10.24.01.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 01:17:20 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:17:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, Victor Lu <victorchengchi.lu@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Fix amdgpu_ip_block_hw_fini()
Message-ID: <f4fc849e-4e76-4448-8657-caa4c69910b0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 25 Oct 2024 12:48:03 +0000
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

This NULL check is reversed so the function doesn't work.

Fixes: dad01f93f432 ("drm/amdgpu: validate hw_fini before function call")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 91c1f2188498..f12fab13386a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3309,7 +3309,7 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	if (ip_block->version->funcs->hw_fini) {
+	if (!ip_block->version->funcs->hw_fini) {
 		DRM_ERROR("hw_fini of IP block <%s> not defined\n",
 			  ip_block->version->funcs->name);
 	} else {
-- 
2.45.2

