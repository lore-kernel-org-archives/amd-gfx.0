Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99941C5AE59
	for <amd-gfx@archiver.kernel.org>; Sat, 24 May 2025 19:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB8610E218;
	Sat, 24 May 2025 19:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WDb17eO2";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9951910E0A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 16:09:57 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-445b11306abso41187455e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748016596; x=1748621396; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ui+xdwWINFM5L07zkqDWB9NaMyj6SNEWap+rmv8ceEY=;
 b=WDb17eO2UAOHGn9rBt0BFt6MQBHefcEzrQIkaClD/jU3n6DNWKype+/9/m/wM4cMol
 o/lRQ4HmzKh6q7B8tYsZ50RLwyPUeXG9yDjpx16x2sFKLQj8tUhlIjvt4EgVa8L0eRnp
 GqEKCMEhhGokBYf1YVhqGkEptjroPN07PkpJXEQu8yX8w45OprTzfu25VoyamLQCuTpY
 PvzMBV6blgosC+/AAusdnn1l2UZK35p0TO0+7PXIzUA+u2A+npzL7vhlk9hAr8oV2drX
 Wv2YS7eOwfdSxCUSTPNbDdbTOKVjAjKI+UJr6SeCssj6SfQEZx4/AAShJKQyw0D/dOtq
 evgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748016596; x=1748621396;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ui+xdwWINFM5L07zkqDWB9NaMyj6SNEWap+rmv8ceEY=;
 b=IbW4EXbN6/trtPgDQnbdCO0Me9CL1KEZqUyoaf8FlZqInXMh4Q1qKLdRT6ppcLfOY5
 7kg1JFwpF25abGrFGA/UCfHrDmcjEkDlODd3ymhKUNufUjNcmQAffROkBDHrEccD/nxY
 chOPPd26K0rPFBrAjkiyYiW9lTCPmgxXO365Ocr9ejIHVMPTmVJKWWNPbe8mh6kBsZi9
 FODvoSNinKbxEk9b+zFvhr2iqp4tx5opOp6x2W1VvStweiOTB+8qC1u2PMXmDLaigCWA
 xIXm2MNIaQm6PZLyLzTtc3lhxz8Sv0je1rOisnc8FDWWDtvzjWArtxnSsUVb/Yb3E5BS
 eO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFPekBat9oPj+nS6q+g4HVdGS4MPltXHkZQIOGmvQ36d00Zs8thpE9uC2iRFIdZxy7RBNn0Q/E@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPgo4ar816vf6Vb8HmIpzRAAEt9wEmyurVzjiHvfSk3F1ioHgC
 wqg4Wlac/Q18N7sKzjssmW6bNaXFvL1xHSgcFhob8gICn7tARKQKk8blKXcPzJeu3RE=
X-Gm-Gg: ASbGncv02/6NysWGUJaH885QMI/BiRNGyRMA15H3vdxN0u1rgdsVP76aCc5C8IphZ/4
 zj8kh896grf3PFDsHYmYz/HbM8jOXQUKyMWUqw3AMnQLOC8lJ9QJnWtrejmmU9S80AFrrP1nBsB
 NNST4IH/qeMGiqVkCUvuGPAv2qPc2kxXmiG1dc9j0/OHb5q5wSZynBmexYvw4b1xCUpElJz71pD
 0netg08TPGZlK9ehzjbPqag3LzG8YyfDUER62I0J7ecVH4jPQDUes3MGddZz5pHsNnHcMW9RXYY
 uq418/fYdmKxRGr5G3LKT+uNorUN7011Y2YE+Jl++DuushdojPWYtZGG5wIcBN71aJ4=
X-Google-Smtp-Source: AGHT+IGqMESqzvP/96nvyjOYKe0RppaRLZiQpOwJY6/fZFSF8xVdTA+Yk7GHTTmFzbVLBQ3RWhPt3Q==
X-Received: by 2002:a05:600c:64c5:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-442fefdad81mr267539755e9.1.1748016596132; 
 Fri, 23 May 2025 09:09:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-447f78aeb8csm144108785e9.28.2025.05.23.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 09:09:55 -0700 (PDT)
Date: Fri, 23 May 2025 19:09:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arvind Yadav <arvind.yadav@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, Frank Min <Frank.Min@amd.com>,
 Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix integer overflow in
 amdgpu_gem_add_input_fence()
Message-ID: <aDCd0MrLste5b2HM@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Sat, 24 May 2025 19:20:04 +0000
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

The "num_syncobj_handles" is a u32 value that comes from the user via the
ioctl.  On 32bit systems the "sizeof(uint32_t) * num_syncobj_handles"
multiplication can have an integer overflow.  Use size_mul() to fix that.

Fixes: 38c67ec9aa4b ("drm/amdgpu: Add input fence to sync bo map/unmap")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..0ecc88df7208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -58,7 +58,7 @@ amdgpu_gem_add_input_fence(struct drm_file *filp,
 		return 0;
 
 	syncobj_handles = memdup_user(u64_to_user_ptr(syncobj_handles_array),
-				      sizeof(uint32_t) * num_syncobj_handles);
+				      size_mul(sizeof(uint32_t), num_syncobj_handles));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
-- 
2.47.2

