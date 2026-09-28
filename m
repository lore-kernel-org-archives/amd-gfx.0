Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3F8CA5FA5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781A910EAC0;
	Mon, 28 Sep 2026 15:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nFXejRs5";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A9A10EAB4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:53 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48881a62e09so1829232f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608252; x=1791213052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qMpVnwIg/zGdaYRq/5YKgRkdpcB1Ym7D2ep0qJZKnJk=;
 b=nFXejRs551NHWqp9xIPxo5GLSOt+pxD4fI6asDWlml3yTOCaaY/UgFCteWoRnOuAvj
 8xozERcFWdpYoMzeSdb7U3IpxaUaQr9T+DRGlnIwlVIwRphGRdEpXJNV95CU5L17Dae4
 Mw16EvCE8Is92bWZ0Ozs8W2ezdPGzc/uhCxkqJZJw4xM27/oPPf0r07kuFEIWVr+ufDM
 N6PNYj602VRYyxEVvbKf0Qzb9sRKyu42UA5nJhKYjRd0V5MRyt2ZJ9HVeRo3EDJJCPtD
 ADZyc5C8CqBVL8PaqeyUUUut02ta/6wAbdNCK1gLj/VTiM0gSfw3CnIUiYlBo1tSEND/
 qn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608252; x=1791213052;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qMpVnwIg/zGdaYRq/5YKgRkdpcB1Ym7D2ep0qJZKnJk=;
 b=lGIT3be6ZdfUlYn9khzurKzW6BCFjYkIbNxTydOq8j5xbkOyCWPPxer3nKiiR+CMSZ
 hCED286DY4xvsYBG/lErdkUX3HLkqmCh7LCcPvBeSaNdaA4CwhH94iYwSVhS8aRbd88I
 9NXsU9z/Wmn+DE2Om0SR4/0+zjKSZYoymhmQnPQUH78Ae4nJoTAr/FaQHJxUlCgX/Yc2
 0Uo0C3BlvNeZFKdK89hM8EGJ//KU5imoxP1gUsp3K0uPNiDO1ZjTgRiw2pE8L0NNmZ2U
 ILX229K4g+uQ6OUmaTU6ERJg2UaD8pROZ2LuQlrCq0R8mMy0SyW/SpJZnM4M40TtWEck
 oMRA==
X-Gm-Message-State: AFq9FYISSzQ4Qwc2BR5JWZe7z1Weo76ncWkDTcOg7yAPuks9LDjITfc0
 T1cBOtYXOa0a8CGNl6Nc71m9JlSMTJnzqoGeM7emIzhRTPMa3LzWdfXN
X-Gm-Gg: AYBFou2YGwLhTtQtmne0iwE2vUzULctELS2i6VP+Nyye5bu30dekmquVn6PtyWeEam1
 DqBL8DgV/7DVG2c9UtZcgvw523jvGnQC98Di4Xu2+56XfbQ0ofiQdUijolZUz0P4FCM2a09J0Va
 eNyNDEBiU6N1nAwYVNHQ4KoZHnXDhPm+Q1k+TbcFMjjOuB1Ha/g0qCk+p9TFABlo7fppR5g6qiP
 1PJOLUkEMIiAnRnOTF1qCm31Dg+EX9CgClapvuYdSyRbG6sDmPRmVtaGBX8xbkIDkZ+hgg8+yk5
 tTwz5n9eZPXiDkkXgXBoq1Gy7Apn4v1vCMPi45tG5cl3uufYTlarRCeNMAxX/pCwJmZQqSOfilk
 Af25aYjUiOApA2Ubm2y7KM5BEZTtPwVUH82SkshPeyFz1XbhScYSMBQU9Lrw4LmRNplucuCBE25
 xtqar9U2YLs96LC6McmE0fPOEQ5TwBYiWRe3Q4I9IWulfIoJ3xOhe7g6ZlArKQ2Jm7CysgMx49k
 akMZCJhFU4fs9xHT4QSBg==
X-Received: by 2002:a5d:59c5:0:b0:488:583a:715a with SMTP id
 ffacd0b85a97d-4887174b71dmr26229225f8f.35.1790608252008; 
 Mon, 28 Sep 2026 08:10:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amdgpu: use range unmap in amdgpu_vm_clear_freed
Date: Mon, 28 Sep 2026 17:10:41 +0200
Message-ID: <20260928151041.1857-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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
index 55bfe4eebc190..bdbd40e29528b 100644
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

