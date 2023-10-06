Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C514AE81DEC
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 12:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8E210E1F2;
	Fri,  6 Oct 2023 12:11:57 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A475F10E1F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 12:11:54 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so3763618a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696594313; x=1697199113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=O8zsG9o7Qpo/4RLFth8f0x2xkS+laBSc0VNrZG5oUUU=;
 b=Uexy6w1++08rKZ/jKXPyVDNIT2753h8KUEInym/wqRBLBuFXKPUgXMvxkfGByJw7xK
 eHalxbHHRWI9VI/aMOxauKkQjWNCILa7wIhdmqQJAgy8MoXyLhqS6iDzqEJgnL0ZpAUS
 7jXiXay8ZwmMNxPQ8GDeiWW1vt3pDbGDcR3//lQogZgQDAvCzzKoFF8GhOF8fh9aRmeZ
 ppX6To9Sl73pA7kinixEEk1Wk093dgF5hd8xgQ0ACsgT8MD1ZclqTXJiyg+xr+WQ1Kbs
 XiD1dVIOy01f+vikxbCrdJn6Rr7GHmY6k2zGMnwUhNsjJgQ8SCoQVtx5L3PcKPrmMcNO
 yslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696594313; x=1697199113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8zsG9o7Qpo/4RLFth8f0x2xkS+laBSc0VNrZG5oUUU=;
 b=xHHVHtF2wrA5fwruAoC8IP4Y6TW02nZmqUz8Gys1d+ouAleYfHR0HcTCnXErOAPnX0
 tP+xw2I6X0MTO4YoYd1+e56mGXpG2x7xXQ98mIIi/591dn1ivPt4Kqb+coSG9o2ZWC/K
 J+NblTKau23Wjp45yiwL/jiDnDeloVDrfvhNHMOR48HdNA7JjQhojAFADpiQab6N+Bn6
 AUYzM/hyYg43sQZcfYjoBkeOnySEuPt3d8kixBUKjfhc2xPKdzx+Kh5E6br9kP8jjuc/
 X9XxY99hNeuv5gQivrI+9VKOCgY+8KfP/WQasW1aqe0xS+VZMdleVUfBdiadpJr4Y7vE
 MA2A==
X-Gm-Message-State: AOJu0YzwHWW/1f3TmyUzGJUEpmI0gPHzv9jSaGjc0pircnxrqEZtvRAn
 X+okT9MzE9b2bickabjnrdu/QAZUvoQ=
X-Google-Smtp-Source: AGHT+IF7FiwmDHWexYX155bD1bvS+UPF1J349zheI99ykLQWjqubkVYQhYbCU+Ykoot0IBM/tU8XdA==
X-Received: by 2002:a17:907:7713:b0:9b9:f46f:8925 with SMTP id
 kw19-20020a170907771300b009b9f46f8925mr2733773ejc.48.1696594312747; 
 Fri, 06 Oct 2023 05:11:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b8:f800:fc78:7c22:555a:57cd])
 by smtp.gmail.com with ESMTPSA id
 p27-20020a17090635db00b009b654751c14sm2785835ejb.47.2023.10.06.05.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 05:11:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: samuel.pitoiset@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add missing NULL check
Date: Fri,  6 Oct 2023 14:11:51 +0200
Message-Id: <20231006121151.1502-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

bo->tbo.resource can easily be NULL here.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index f3ee83cdf97e..d28e21baef16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -252,7 +252,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
 
-	if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
 		return false;
 
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
-- 
2.34.1

