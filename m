Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A6CA5FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE5310F3FD;
	Wed, 30 Sep 2026 13:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZeo7GbD";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD1E10F3DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:25 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso12698945e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775204; x=1791380004; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7LkIy7MOX/mkToplYrl8HAlPOWNqr+oJhNr2lAA+yCk=;
 b=aZeo7GbD71r9YQk3u4a0IpLjzFr1WUudde2TtNgDoedc57B2L+/SWRdR5oHh8j0hk7
 VAXtkklM0GqSsZtg5GrnjM7SnXK3Gm4zBjpJnH6FZ2godm3EFamrN6KAcdnjOB+OdYsK
 j7Fb2kAgr41hxYtAUFPCii85/969RIVPxwCInucgl5maW3wFlo6zGGeG+cXK4/3UZjFP
 QPrkC0lf7lbazATrzj9h3/OEAi94qT4Pv7ffTHNFwssiHcKtBueXgYZg8Ht8VkKJvwij
 mDmsF7VUosSGLfMitoxbxHhgxuHaMTClEHUbTsm9s8CkUuXczfoT+A1MMZEPSZ/CyIAx
 nzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775204; x=1791380004;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7LkIy7MOX/mkToplYrl8HAlPOWNqr+oJhNr2lAA+yCk=;
 b=IPZKFxnuvXI/QrGwaC1hYviaoCGWMdyarn8eKv9afiei+u8/X9jXOzdvjvKEENVeyG
 VFb96lZLrFRkMM2nhcF/a6EYW583eTIbuRY7Vw6/YsP1aswg4+CRK6n2n769SEcL/+5x
 YKsIWY8RCDWIQrChFhFFwPb96xtLtZhqyoaRrnt+BbtN+KfzYV/J8WOdVfOq6d85haD4
 ZNN+tRR8npvXGDuOyhXSEFs6elNOV4HMCW0nmq7H7nEI81uPZnHA0lYSjF/pRzp6ddHP
 b/BzFmn485Xi1Sup0CE5/yoEaid4BFIdGQIIZ7BFOZ8G+wjjX1ta0VHWFYSGhMUPYprY
 HgjQ==
X-Gm-Message-State: AFuF++nHrZsO2sryFG2kwBQ2+dMq200L1ykUou1bmJ6rqLKWXYK58Tkg
 nHTDC9+KVDGjBzd2HisEj6juF3J9hGusZLKhz0vIStBZtmbjRTBycqjC
X-Gm-Gg: AYBFou3LRBz7Sm5BfQkAABPtq/oOBaXNnncUyveAxIF6gD2w5j+Xm8Kgmc7nOavs0ae
 7geoGXPvDunsG2IezVMH8f9pzF1BvU2zl7rz42zTNByVc4ESKKSY5JXAo8Bwnidr3xdU10S7Sq0
 07GmvtnJP58scsbAm9ts/xFe+nD8Sb+yPohUSnGRpC3S666qTNyycx+H5OfqWPEddHlwwldOe+D
 eP9j+z0F55MxAD3KPpxgbMPvhDLer3LIjYrmuPr8ySvqoQbjNKMZ0oN8CVAbvu9dud8HqrhcFvF
 PL+ua/ylOJzm+ULJhXaFw3kYZblCjxX0EA26jXwh9h/TEk7oR4EA+1EwlEObOSG8XzUlVi2yIeQ
 AbhvUZ5kGo/sxQ1V95/5yMPY2/IyS2Kiix2rg5eR3BOEJH1yhwn6SZEGNQpPNnoOhWh1Pqgqg+E
 ZdXqDYFL095CCVAmF2wvUCvjB39yTWBETJFXuLa9osQ9KUMYO21qJqfRwkbg/oPeC2i4clUW1O5
 Gckn6ABhas=
X-Received: by 2002:a05:600c:8b08:b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4a01b00226dmr27477425e9.33.1790775203524; 
 Wed, 30 Sep 2026 06:33:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amdgpu: use range unmap in amdgpu_vm_clear_freed
Date: Wed, 30 Sep 2026 15:33:14 +0200
Message-ID: <20260930133315.12270-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133315.12270-1-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of abusing the mapping function. Has the clear advantage that
unmap_range can't fail with page tables allocation should anything go
wrong.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b63c00e5ce9a9..c5fcb3cece845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1675,9 +1675,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_map_range(adev, vm, true, false,
-					&sync, mapping->start, mapping->last,
-					0, 0, 0, NULL, NULL, NULL, &f);
+		r = amdgpu_vm_unmap_range(adev, vm, false, &sync,
+					  mapping->start, mapping->last, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
-- 
2.43.0

