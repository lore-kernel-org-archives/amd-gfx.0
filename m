Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A56CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 13:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9688D10E7D4;
	Tue, 16 Sep 2025 13:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aWdU0eR0";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F02D10E75E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:30:19 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-32ec291a325so40862a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758015019; x=1758619819; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xMegCBQz7YTxSeWsApsavoRdrbMxT8WcHe9sV3hQY/k=;
 b=aWdU0eR0MXkbcD06Hlq4p4BVUIpdyZtmsQU+jHeHTCYGtQBQow3MVl4n+5BNPyNkBA
 acGkacsrd0sQka8K5dInxUY2iJxYmDL2aNDw/sigGySppEr3/X15GdzXEyZTc31zmhuH
 CznhSAUTrKJSDO1CW+tcT7HQFf08QS4A/MFJMpZJQE8BfrWetNF1kDyGUks+Yvb9BVGJ
 Qkg0i2FvaSmaSRqC2oWYldAeXXxr1ONMzfUdWyfVd3S9Ae2KCbcclGh+YLNCBxs6uEQA
 B2IyiWb1IsGK+yjWwAODE/h2/nLvn0fjMuoQVo86/aKt5Z0bTE+9WNQ5GwDperOedN4P
 KWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758015019; x=1758619819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xMegCBQz7YTxSeWsApsavoRdrbMxT8WcHe9sV3hQY/k=;
 b=BdHLvalRu9HhbJrNlFUlprXmI7QAKCVM2v77bODpOhMFKt8ACtlbwlZ2Anl7KZoNmu
 dWH/LIAWyAjJa0CqWnuQPVWPbnDu5ZWDrWhItTJwrs9Gus79JZXWNUSEboN7YTXnyVR/
 XAY0y5hzxXraJjhTUZB57Lx0lOvlBxbMVE9JLEqBwLW5kO/xLniX4ughVWJxrAWiy5IH
 XrX14bnoIvmJCyeg+xVAcyoObi+M5KAdS5e6okFdPJkycT5AcjWXbmffpZtaSX802tYt
 UXNq81UDwcHIb5AN+A3D2TQbI/sHA7fx1F1XsFifwCHb6IQ8xdgtFcZdLqE62A7UE+FC
 IvQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa1ySZphmGk0/VgvCodK3rBxAbYNLR0i9/N5fu0kqwe628d6sTtJLdOV9u6aqjg0dB4idpSYPv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7RaPVvvh0KcHLNK3HSgyuXehn2mkO4/9Cm2FSatqgLnA5rlf5
 10A9uhV2u2rHyuZTehezBPsK5ab47Jr2CLKe/azana4ocACfGM4ELAk0
X-Gm-Gg: ASbGnctIzSBwuCmrLbD+iR9nvn1Yla04rjmzJ070X46pIP0rlD+mbjS+Xc3l6sJ52YL
 NwtrEauq0xxzDXv26ZF+ILfHOms5DHw0hp/VLKZyq5MaQB7bvUt1gciYAslzmLaXCJM4uTI8nL0
 WNTX90YphNZ5ClX+VjrVrcnz3cTC9wUG+6TialNprP37efAa0/KN1TOPr5XpbD+7sXJ3OEmduUg
 zixKqrbbE+fpqA5gURHeh30iSKg8ACgcBOiJIwLC0Py3qszxbgoqoQSVC691S11T836RhposNak
 APFKKc4lNDQrXsH6PERyWY8EGOdaHzEnfxBotMq9+cDxAGB9YDJno0FzN9URJLM+nCTKwzCPJig
 GvpXPIagMmZz+BbW0P7b5uQz27T9MnznRaKMc9aRgVp9FFR0=
X-Google-Smtp-Source: AGHT+IHaY5c65oxrMkdcTL0n+OlnjEx6RcD6jC9gi1YeTOzARVykTuROW5jlE0gu3jOJro1VNfqXFA==
X-Received: by 2002:a17:90b:38d2:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-32de4eabfbamr18284658a91.6.1758015018661; 
 Tue, 16 Sep 2025 02:30:18 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ea3c72dacsm869074a91.4.2025.09.16.02.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 02:30:18 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, rk0006818@gmail.com
Subject: [PATCH] drm/amdgpu: Use kmalloc_array() instead of kmalloc()
Date: Tue, 16 Sep 2025 14:59:49 +0530
Message-ID: <20250916092949.4118999-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:04:06 +0000
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

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in amdgpu_amdkfd_gfx_v10.c
to make the intended allocation size clearer and avoid potential
overflow issues.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 04ef0ca10541..0239114fb6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -352,7 +352,7 @@ static int kgd_hqd_dump(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -449,7 +449,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
-- 
2.43.0

