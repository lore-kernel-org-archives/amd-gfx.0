Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E7C7EE39
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 07:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CD310E278;
	Thu, 26 Jun 2025 07:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="znZC0noK";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE4410E764
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 15:22:30 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so33662fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750864949; x=1751469749; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7AotgDT5LaYynHW/ZEfD1/SGeGKITLpNV/LQfaww2/4=;
 b=znZC0noKsS1okXYz50HRzZuLVnZNz7IStJP7OzNAP13A5eTC7eCFZJYX0tvFKC0qHa
 mfmYDcGeOCq/JE/xdELDLOCreKuHCoSurFrDVQWxyA1ekCJYdgROJeQRTlxN/R8eQD0i
 KuulBIh7xm/1G3HOkJOcTlemskA4x7uY/xkr0rbHvf3pvpoU5FmBW1K0+s5gakP1rNGa
 DOYrjlVP+npJbVqb2O1XEntde4dhGv2TyEuOnpIUzBAK5rJlhfQ2VhW5tSYThSmYJkl7
 4KVQvNnDva3hCFIFhVHF4dI9xyJrwrXk3UfOmnf717r2o4WS3pzMj3wh1x2pwMBsB5u3
 Ztlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750864949; x=1751469749;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AotgDT5LaYynHW/ZEfD1/SGeGKITLpNV/LQfaww2/4=;
 b=HPSO0x2Mv9Wsy7qeui3+3b3n23VsAPZASuN+Cta+QOkVakph1pdN3mIetqef+ZoDxF
 blDMoEpES5HqDDEpJYsZfEzb7ULDytw+EUIt5TnyCK9SUbNU3xpikxPwLzWN+8rweGcX
 VAvMUogAycJTQnfN3RIjj7M+uJSTYZNRchh3hUkkqSMWkMgxJ0uUPzyZjieWTsMXBWrJ
 PETMthG5FHXD1BOvxLksW8pXRiVG2diTu3SBvqX0MvarxpPav0uYccWe5+O0q6sPbf/g
 LNKHgf3zHjtW6accWXsuUAI5s3liPYkFpDfH7+viwHS7dddqg66tOCn0ybDz+Izl7Bu4
 9p0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd/4eq5doO5igbVPosLuBUbkXXV9D//BjFNDgxXKjARKB1evtCz5XfBpaEPDIlN0E7tzrJOzrA@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw67mMBnhkUwopCxah5MJRzk5phMH1NyAIj+4mxsODrw5/uS5Sn
 0Ttej9/xBykUNESPaXJqf3i/VLmMrYK80/atl/CVEw1JEtfn9wCtpq5HfqtYY95aD1M=
X-Gm-Gg: ASbGncvfWyYE5d0i+KiYEVKTdmY3o7fUFRYVTJGMoUbgLxaAUoJwm0shdZgngoz8KEM
 FmfqbghLHLvY5gc1iiKErozsT0esoCGfdRDbpGS0V7t+wYH7BKMFTDsQG1PKMUMPEwzmm2w2cJk
 Q4jRk5KFYORzvRFY3JwqbXFNbIuGXdYc76M/fZOi5gLz/Qh5IhOHn37b9t0vh+1wv+sHu+7I74k
 rMsMo8VkMFLV4mYnaBZG8UytkoQmeRlLL1ZM3Mp+KJLU/0UrQmCPZGGNSz0MZRfXl3uRS4Vkj0Y
 /CPt46TNP8JBYkYOrNZGtnrlxoFPOssxcMXF3jrdUDHX2EpMNCn7GtoLH03+dE3/B+PQag==
X-Google-Smtp-Source: AGHT+IGsr3ucc8CyFqc6Gm9yOw1rdKd2Ohl95Xek/6xI6751ZImxrSCLvS3rUdnLDFx5jkH5lTS+2Q==
X-Received: by 2002:a05:6808:1817:b0:406:1e0c:3196 with SMTP id
 5614622812f47-40b057f075amr3033719b6e.28.1750864949418; 
 Wed, 25 Jun 2025 08:22:29 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
 by smtp.gmail.com with UTF8SMTPSA id
 5614622812f47-40ac6d3f540sm2202840b6e.50.2025.06.25.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 08:22:29 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:22:27 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Min <Frank.Min@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Ying Li <yingli12@amd.com>,
 Prike Liang <Prike.Liang@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: indent an if statement
Message-ID: <5827884c-f269-4e38-8202-2a3fce280ae3@sabinyo.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 26 Jun 2025 07:50:55 +0000
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

The "return true;" line wasn't indented.  Also checkpatch likes when
we align the && conditions.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index d777c049747e..a0b50a8ac9c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1400,8 +1400,8 @@ bool amdgpu_is_kicker_fw(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(kicker_device_list); i++) {
 		if (adev->pdev->device == kicker_device_list[i].device &&
-			adev->pdev->revision == kicker_device_list[i].revision)
-		return true;
+		    adev->pdev->revision == kicker_device_list[i].revision)
+			return true;
 	}
 
 	return false;
-- 
2.47.2

