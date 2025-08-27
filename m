Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80E0CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 11:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B0A10E0B4;
	Wed, 27 Aug 2025 11:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QEC+RSa3";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A954410E0B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 11:47:46 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45b4e5c3d0fso16648395e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756295265; x=1756900065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0KEtl0G1QcEOxF8N8q9ZTb7EJqp1NEzEuzpVYkZc0Ec=;
 b=QEC+RSa3r/XrlMsnh7Nfzlo49H+m8uP529KdRfgxlC+RqncoIIyP1PELAylmwl9jvJ
 ICUV3PZnWLQwK/VUjfpSZ5k7MhIPKc/lP3pbq69uje0cpp2X1tVWEgMvLZN+T1osQtzx
 87ZTbw6HBoxkYKJpsSoFkKhBbPJTRvOcG0rQ0KIjlNVtSTwTcxpBlVP1tzxOVVBlI+kf
 T4MdyQMmq8sjscXpKdD11bot45lMBRWWDaHXSGt/8UOyv3ZE0LSQS57KwRKU3EWzwWOE
 +gqQR6Z5w+AwVhIVjOdIOvNsZNtoknox2wOkj3vkvC1QtPiV2ccS1sC92HYyhLzxrxuA
 DHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756295265; x=1756900065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0KEtl0G1QcEOxF8N8q9ZTb7EJqp1NEzEuzpVYkZc0Ec=;
 b=Tm3WNNIb66gq53Ye9/X+L6T3xtZGAPEP2yjR+EN4jLY1BUvHNljzAhHm/5Bv6M6enQ
 SSNwqRFZFlvi8Pv+Q6OwpTZC0R9oLAxbmFe2mF6aTjPRis5dkSIowPrhtwVoYT8XyG61
 7XWkNALRsMwEfTi613Av+6kE3UVVNNe0bkU+8xm0Sw2PoESB11K1EmIhbX+vWfPi/8oo
 ps40OOU5VLW6ZEB7DNT/6qvvj7/LCJbrJQnAo0kS8Dj7RCEgEfTMCzXsAVVCYq4YjnSZ
 2X+2BP3mILqJ0aeWy9ZnGpJUthpG45k688kFN/7WLuaCfFJC0mPxgvcB4oD0+boSb5rR
 CcdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqeOrqe/M4BVOjbCSIyEegpvdWbMvxWs8c9ALRxcCSGPxSrnKKuNWIyaYDxqQ3F7RhrG81+1vF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJXG7TKbYVosCLauFL+4y369nieTayaFyPlN+xa+e5Vf8xwiXN
 k2MkwwxqqiZrrxevQ3x4HXWo61P1vZ57vgkOJ0sxa9GdPi/fdbIJTsfv
X-Gm-Gg: ASbGncvvlOjrqXCqlEzW2wrDK2TVyH6dgRLBMYuwgvniZ/wqKFGWT2q26mr716dmsFz
 DEQXGm8xipc6s4luk/NpOkWBJLH/IhQUMR+fLb1GUc/pjd2gZvFRGZKPjUtvTv4Bnw4MB/aMaFd
 ImF3fBupXrVlD3kHvXlT7DfbxCRN8kyhCI19tCg/oSjzQkZ/46XCmmzIpY8b/l2o+RUcZqaqrrH
 94c4gG64sPC3z4+U7ZlansrLhBO8tzgMJrrUHVm3sLweTmqnwORMhyJCwyeXcbkZVykIu/TWH3e
 xwDOfYNATZ8iHB8DiwB7DjIRcHFvoaQnPPeXhkx9eDbkL/fl3GKMaGOuZlIdkrgJcWtIwVAGe2W
 +el2ZU+UGWFnqwZpzprXevj9t0iUbz3fyZyUy2KIH7jyJ9g==
X-Google-Smtp-Source: AGHT+IGQ5kNpxdtSJ7FpTR/0v64trroa1Q5uFmRLDozr3kHfZkpj9BNPG/rEPuPCOq2y43M+UUU73w==
X-Received: by 2002:a05:600c:4689:b0:458:bc3f:6a72 with SMTP id
 5b1f17b1804b1-45b517954femr166155915e9.4.1756295264909; 
 Wed, 27 Aug 2025 04:47:44 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1498:5800:1e25:9081:2109:a4cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66c383b1sm35131415e9.3.2025.08.27.04.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 04:47:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Yifan.Zha@amd.com,
	Alexander.Deucher@amd.com,
	Hawking.Zhang@amd.com
Cc: haijun.chang@amd.com, ZhenGuo.Yin@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: reject gang submissions under SRIOV
Date: Wed, 27 Aug 2025 13:47:43 +0200
Message-ID: <20250827114743.9579-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

Gang submission means that the kernel driver guarantees that multiple
submissions are executed on the HW at the same time on different engines.

Background is that those submissions then depend on each other and each
can't finish stand alone.

SRIOV now uses world switch to preempt submissions on the engines to allow
sharing the HW resources between multiple VFs.

The problem is now that the SRIOV world switch can't know about such inter
dependencies and will cause a timeout if it waits for a partially running
gang submission.

To conclude SRIOV and gang submissions are fundamentally incompatible at
the moment. For now just disable them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index cdc02860011c..494d6c4797b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	if (!p->gang_size) {
+	if (!p->gang_size || (amdgpu_sriov_vf(p->adev) && p->gang_size > 1)) {
 		ret = -EINVAL;
 		goto free_all_kdata;
 	}
-- 
2.43.0

