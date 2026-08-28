Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF6DC61DDA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD72210F364;
	Fri, 28 Aug 2026 11:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FUXzvw5f";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B319710F34D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:31 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so156221066b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917290; x=1788522090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J4TiqWNg8SKKRz63Rtd6ngas0owtz021gEy91v/1l3s=;
 b=FUXzvw5fvTF25dzB9LUWZM6GhU/03sccCz6zjbdvLvCghaUAvVd2/7/4xpuBj8us1G
 NV2gFnhrgyTIsogr+aLlfGllfkJ5xFJhqWKMnM3G21MuSBv0DN1L6mK56QuYhhNioBYM
 nearowXi66fku9wZyhvY30yxSHNiT1B41Hi8NARAlE8JZsIP+MC2Cd8IUq/dVuOhtR8R
 /4R3IbNfAA3+yLT5jiP0WNcJbE7qzhzwNZHCO9QROBIbDV7fpIWXEtC0eleCSwCmrBAY
 BTyQFhCYpqR3u0Cpn210CHkullFkCd3V5HqYTHJBYRruXPQzbpOrF5l9OjDlP0erQBaZ
 Nn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917290; x=1788522090;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4TiqWNg8SKKRz63Rtd6ngas0owtz021gEy91v/1l3s=;
 b=HoxDX5wyNJyGtrGtzmlXkR7tsE+0r575pTd4leVHdcoPuU5IYT4PeFDjUGpDtNoCci
 o1ypW4xPgZOtNWtKEeI436qyS1QFsU5OTErhN4o1l9qO6/btRJLySTa3opEbWTfZariB
 MEqPJ6yK8QQB2AOEZ7s+1t55B3F3Rw3AWsregIYL07ziZAAvul7Tfl9kdrkrTrrjqU/o
 GjHucUkj+yB85nmtGoCGX4b3rW68QcofLzJp+mxzYGVVl+H19Q99wfIAd9JhG4/M5Ptw
 7xn+zg4eVviUG7oCyNSHUcG/uEflY2YxzP6cSDLOlKp5X0icmmjfBoQ+EEKYnFw+dewz
 FEZA==
X-Gm-Message-State: AFuF++nwd+9CiHWPL2Uo3u9edIUZgJbVWdVvQ6Tk6AEb4w22mTyOHu//
 ypFhzpRCrEcVxz/dlIl+Dkeq/dkPQdEWj5qTGnziKKvo9viAYwtKXbZmDQdy3wb9
X-Gm-Gg: AR+sD11e2G+P5Lv8KldRBwswmVINFJPFadoX3QizPvR2is3N/2PY+bOb51/DEEuc/Ef
 6WQEClwNXm/gj7IiV0FGhbgTzTW0ix9uJLm3IvjyH0rnr7tDmUNSKd76iyJfNLvL0hSgcX04WO3
 BOza8FlCvg2mhYvKMduc3ete1uZIUKeLAp06PgA9WWnUr6FYcz9DZoagjBgw3Pifqoa8RsDdTFC
 9FNUS70zBLM4hM6l9FVqsYQo66uNRCzlZnVl3TLNirdKu/FihP855xMnmA90NTsSZrQtmU0HjQu
 YSNcbCOZGMnig+ghwRP/htrFGf1RNnaRrmZuP+Kcba82pkiaEUtv4F0/9uRP6iNZlQlqOOEp92+
 QwJzPviR/z05ZRanaUcRKALrek66hE4f7ymCeW9CUDBEM8AYsygpzZPX0CkVxpSbmV3f+ulI9qV
 lV35lYpChr8EAc7pSq+36M1jqsHeZuG6HN39eq/wxs5n6/D4wBbctQfQmyQKjc/Gw4Sved0l/RS
 cVSSaIrnWe8KpfN4ZpAQWEQmN6oXQCtGL8=
X-Received: by 2002:a17:907:3d43:b0:c15:e118:9b99 with SMTP id
 a640c23a62f3a-c25571f4342mr343921266b.23.1787917290098; 
 Fri, 28 Aug 2026 04:41:30 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:29 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/11] drm/amdgpu/vm: Use init PTE flags in
 amdgpu_vm_handle_fault()
Date: Fri, 28 Aug 2026 13:41:11 +0200
Message-ID: <20260828114113.13523-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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

PTE_IS_PTE seems necessary for handling retry faults on GFX12.

For reference see:
amdgpu_vm_pte_update_flags() that explains the problem
svm_range_get_pte_flags() that uses the flag on GFX12

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 88249aa89ee3..c5353c74f87a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3050,7 +3050,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
-	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+	flags = adev->gmc.init_pte_flags |
+		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
 		AMDGPU_PTE_SYSTEM;
 
 	if (is_compute_context) {
@@ -3063,8 +3064,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		/* Redirect the access to the dummy page */
 		value = adev->dummy_page_addr;
 		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
-			AMDGPU_PTE_WRITEABLE;
-
+			 AMDGPU_PTE_WRITEABLE;
 	} else {
 		/* Let the hw retry silently on the PTE */
 		value = 0;
-- 
2.55.0

