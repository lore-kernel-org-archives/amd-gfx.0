Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906B3C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 14:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4BD10E12C;
	Thu, 27 Mar 2025 14:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JTIvMD8T";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9035110E12C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 14:29:31 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so592119f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743085770; x=1743690570; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/P/Lg/lelVJhb13kRNnRQXN8+MIvTIQZfQ8FoVfI6Pk=;
 b=JTIvMD8TfsLY3xW+l0bVK7adSJEEinvR7MujrFIWVrgfUn5BcCEDmWv9CZrha3TtIo
 /PbdX1v81KoqO1DyCwXV2kSgBvePffQ1Eag8C2+r3gxyKd5RYgHpgv/BU6tDXAVXVHYZ
 bMG+1Ht0N+iZPtSNXm3Qua+ZBMEybkV9Yv1t4sOGMRqauS7lNlAQTqG9YGiT1SYs7Q+1
 k5ke6DYkdyxGBXkkDXUsouyEKzUzlMGFbBYkQw662mNyivEhjGoSsHGcSY44oQjxddba
 1Hbg23bA8RYbVo66Fo+MqblqQ/nc5Tn33sWih2EvhmBRHQVoBW8KHLfiV3mRZzmyPmzb
 pB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085770; x=1743690570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/P/Lg/lelVJhb13kRNnRQXN8+MIvTIQZfQ8FoVfI6Pk=;
 b=nLAfyILvjjj4kcPiqumx49h5AO64ysZXz/lku58KJnq6Wqeq0W6HFftIoKRwsjiLwR
 vwQSqQCW8bIKAZKOOxmgC3qqcuCcAKGawQgdfZ0i/mabZZRr3g/UgTYmUnNAQfhDDiPX
 6nWqvTbGSU5x1GyCSOJXu51WXHdqnIXBqdUXanvZPBc0CriYQUi7XeFk+83/TTUsnL+d
 ph/uBpNpppKsrmqYt5j1R/Zxs0wLpWSPa/tAT/1N1PkzoAZ5GWV0z5wnVQ0Rjvr0S/nH
 WEaBMxSCrYOqBdxbd5wBIOznjrCyVBsrGEB8DsmnpNVg367HnfR86+tvJQAFCaIUGnya
 DpMQ==
X-Gm-Message-State: AOJu0YwLJwNC4OMktJNKGHDt1DmTAWQfJ7Ss2KLa7BBOlUStpo+DbCiO
 M1IMi3BN7ytegIl/XyhXn2vKjVcUIuy0iROWZ1hZaqmB6cGP7f/X25EX5A==
X-Gm-Gg: ASbGnctYmGT2kblPVu+ZzzkWm8beaTRb4bsKHuo38tmIlMgOIlBhasQxCjIsZkvzg/v
 2Kk+9EdXrUsRQH7dPN2zO1ueEt23MA4WASVRJdFUJar8ku4FJIGPHQU+mnPwCfEms+MosY0FRlH
 AeL8l4srPSlOEWx05b4vlzNVFfbYdBhzYmwFMSyFlxclG1uAlr/z2kWI37GIyxDGsex/NN/j7sB
 +9vOL3BXBkl/KyXppMbEVSOkP/ogjo2uDab+Wjy3492eul+Z2iZOzwzrRQLAR7jieMndZR7P4Nw
 r21MVHUJ9gN5ngxc+SR+8Td7Xh6PuUvdWN5cuLUWKSSzqd22TlJAlAR6
X-Google-Smtp-Source: AGHT+IG926S/WKmRXCBN3QUYWIhmozD4OIGqDN8ypnmYSlv2aSDx2Ap5KKX1y3XC5PPyR6nGBXtl4g==
X-Received: by 2002:a5d:5849:0:b0:38f:483f:8319 with SMTP id
 ffacd0b85a97d-39ad17836f1mr3615152f8f.51.1743085769948; 
 Thu, 27 Mar 2025 07:29:29 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:f800:2d33:ae6d:5fb:b944])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efc9bsm19776279f8f.87.2025.03.27.07.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:29:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: immediately use GTT for new allocations
Date: Thu, 27 Mar 2025 15:29:28 +0100
Message-Id: <20250327142928.2193-1-christian.koenig@amd.com>
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

Only use GTT as a fallback if we already have a backing store. This
prevents evictions when an application constantly allocates and frees new
memory.

Partially fixes
https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d09db052e282..d90e9daf5a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -163,8 +163,8 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		 * When GTT is just an alternative to VRAM make sure that we
 		 * only use it as fallback and still try to fill up VRAM first.
 		 */
-		if (domain & abo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
-		    !(adev->flags & AMD_IS_APU))
+		if (abo->tbo.resource && !(adev->flags & AMD_IS_APU) &&
+		    domain & abo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
 			places[c].flags |= TTM_PL_FLAG_FALLBACK;
 		c++;
 	}
-- 
2.34.1

