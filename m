Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E2CA0FF5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Sep 2023 19:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DA810E1ED;
	Fri,  1 Sep 2023 19:03:56 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385E310E716
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Sep 2023 02:01:52 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso1774464a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 19:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693533710; x=1694138510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pokgHgBHA/frweJZw9pAQLhKs+o4E+Q0Uc8h5ILdkh8=;
 b=VSkYwsj1ddyZiAgfQuELe6fAS/9K0Q04hfbjFJIJclWmG5/MjUf5TcRigEYwLtGCXv
 SF9A2NhaSaXAT/lHB6LgSa9F6BHStMvmbfFEZbUC8tptQZ4qH2a/CBK+RplcdLF7e8uO
 Ug5KUrB/oScWCsz+cxBDwr0ZL8R4J6glugwHCvPQKjyW4JoUkyESspk08Pz4qfLnv2id
 7MQMUwc8vAbLUDIRPxnlgtWLAn1arseKW7zJdYrtcu/bm1Y9zoVrgfzIYcHMS82o6+Nd
 +J6SOC0i0ZpIJXMb4kBb9m4UwFVOGTIw98V6QiJd1i5LoAwuVoBLKOQE1rMKXlh3+M50
 F4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693533710; x=1694138510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pokgHgBHA/frweJZw9pAQLhKs+o4E+Q0Uc8h5ILdkh8=;
 b=B9oyl4yT9u5WEW44O5aOh5kB+cIClJ/4Np6x9xZOoZCDtWDyQtjyJQN3wfk0imeMvK
 iVfU0Ul3FXxVphTtOMsWHfbHNvhm+qE4SA188Y0npzxxvCsemx/CsKZ538+3njXxRuY8
 709qzEpPlQw8TurcscpzDcFDJP8ZjEcBQLMFypJdzXMRtGPY6/LcS3IqrD5ZBMQrGXnz
 1fux17bY6Y1fgenj3sUCmOkJR78yYreyb80xNDs/aBT8D7We4D/SvviOrdjMcRFpLMHT
 mlnAwSo79enLTvzAQ9NrDRzK3hiN2TFOS3e4RYvacy9wDjdYeFar5s/FxRr/PHooKu8Z
 dDGA==
X-Gm-Message-State: AOJu0Yx/M6DY4qON5+4EAZ+vzwWAc6q5fQNvyEn/p9bLrdDgWiocMZNe
 7aAUp492HgY8oZwv82h3m1UlpM5xFf5ZnCw1
X-Google-Smtp-Source: AGHT+IEVwEzvCKk1MR9o3/KdYTukZ4SFi2xXYW3SKCvhAQ1Cz0GLUFiNOaqP2gnjnBTqoQ9g6uyCTw==
X-Received: by 2002:a50:fc09:0:b0:523:3e5d:8aa2 with SMTP id
 i9-20020a50fc09000000b005233e5d8aa2mr887923edr.14.1693533710303; 
 Thu, 31 Aug 2023 19:01:50 -0700 (PDT)
Received: from debian-buildmachine.bernkas.tel
 (cpe-188-129-73-117.dynamic.amis.hr. [188.129.73.117])
 by smtp.gmail.com with ESMTPSA id
 a9-20020aa7d749000000b005257da6be23sm1481163eds.75.2023.08.31.19.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:01:49 -0700 (PDT)
From: Simon Pilkington <simonp.git@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd: Make fence wait in suballocator uninterruptible
Date: Fri,  1 Sep 2023 03:01:15 +0100
Message-Id: <20230901020115.2442-1-simonp.git@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Sep 2023 19:03:54 +0000
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
Cc: Simon Pilkington <simonp.git@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

c103a23f2f297c6ab2e5e74e39b655439f3524a6 made the fence wait in
amdgpu_sa_bo_new() interruptible but there is no code to handle an interrupt.
This caused the kernel to randomly explode in high-VRAM-pressure situations
so make it uninterruptible again.

Signed-off-by: Simon Pilkington <simonp.git@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index c6b4337eb20c..10df731998b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -81,7 +81,7 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, 0);
+						   GFP_KERNEL, false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
-- 
2.40.1

