Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18A4C47258
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 14:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DBB10EB09;
	Fri, 12 Jan 2024 14:37:35 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9586D10EAF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 14:30:05 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e5a5b0fb5so26220265e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705069804; x=1705674604; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z+wi6LxV5EZ0n10N9SHFswFNcko0BVzpNz628Oa0p9E=;
 b=PAMcasgnH0xIUcfFkR9ZEbjAUrpLuEFhK26OB9XCqaUGpqDv9D1lxie+Vwar0qUPjA
 1X+GG1JrsuZtvV3i4z+QJXINTGcByutk8+9oAa6TzyuAdQRYbEQW3PaG3ZTDJc1Mbd4R
 nAQGVw5d3FB2k6LJiMHtHHyZSUxdCFd4fA1MVCypL3HB3Yiw39+C3zN5A3m5UF26fYoe
 6jZSAMwszoBnx0bePo1O6SkcYKSSMxvK4h+rMLjYxzIfhV8X9SCTbF5XCAcGUtyeNYt0
 qNFR0efuEYzaYIevprT/xUxpWJXKRYW+KaoIHdm24uQQzuogCTt76Lx2HWwiDiuvBl2I
 kvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705069804; x=1705674604;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+wi6LxV5EZ0n10N9SHFswFNcko0BVzpNz628Oa0p9E=;
 b=IM7VfFifG0+quaGZbhsru3xVlOtxAqkhPIapvbvcSjM26uWdoWagqmbuGAQC+OVOUG
 8YkdO4nZUxyAOqM8cN5Kfy4ucFBKDf8CUSL2nXmQq3QuB78HC9Y+LLLYjY7pq9dFpXNs
 q+WeKgUuY196bChlJT/HvY9Ez+3fhYtV0PPS55iOM0XoFcRrIjk9IhIS4lJbL1SvyuVG
 kd/vJOv+arztiQVhgCcWjTIrn/r9AQtpkPN5SFTOVLW7nqTCevfS/7HkcVChdLFG16Oq
 NSZ+DOodqUrUQdv1wtd4GZC9wxJX0VUZ8IL6fy65zD1QwuTQ8tjuiyttEHUriV+QqocC
 h8Aw==
X-Gm-Message-State: AOJu0YwHLPzqHMSK4IrwNAJbaW2GjWUComt0U5Ot6g0ae4OcIuTkfJgp
 gHn7WCBre94YeeH3RMtUHmOuxahQUGgsQg==
X-Google-Smtp-Source: AGHT+IFEpB1LZ1xc3CQ44FCbNbDdLXUyk9YByyFqv5s3twL1MZ7zUuKibTl7Ck+2HxkJODQhK7YCyQ==
X-Received: by 2002:a05:600c:4ecc:b0:40e:500c:23d8 with SMTP id
 g12-20020a05600c4ecc00b0040e500c23d8mr791947wmq.151.1705069804093; 
 Fri, 12 Jan 2024 06:30:04 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c0a0a00b0040e4bcfd826sm6116088wmp.47.2024.01.12.06.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 06:30:03 -0800 (PST)
Date: Fri, 12 Jan 2024 17:30:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix return value in aca_bank_hwip_is_matched()
Message-ID: <b311c5e2-ae9a-4558-a51a-a332d0fdfd9b@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 12 Jan 2024 14:37:34 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The aca_bank_hwip_is_matched() function is type bool.  This error path
return -EINVAL which is cast to true, but it should return false
instead.

Fixes: 22a4fa4709e3 ("drm/amdgpu: implement RAS ACA driver framework")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 6074a529caf7..1d3ae7c241e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -182,7 +182,7 @@ static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type t
 	u64 ipid;
 
 	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
-		return -EINVAL;
+		return false;
 
 	hwip = &aca_hwid_mcatypes[type];
 	if (!hwip->hwid)
-- 
2.43.0

