Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB4AC433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5FA207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DExYgivy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5FA207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FBE6E5C5;
	Wed, 29 Jul 2020 17:34:56 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7975E6E5C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:55 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 11so23046360qkn.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r18oPVXv0IMyymb52P6a5Lmr7QX+ngKP34/PJcJgsYM=;
 b=DExYgivyRO9Zt/DsVHu4LHcd/TbGpygLKiKNZMNDYU50/ApW3jdbl+SQTPRurnee22
 hnLwVMq5w/IcULBvHBlj2Vnp8X5TkSBaeXe8zeCVK6aY0eBdlMOVjW8CPfJ2ozJkET9E
 e6Y0G4KycXKcMfLDb4KYMqB17XPxjx2YTiIs+sc6j5msjHFJhukI16Ba1lSOmCG8J/G8
 PaiUbs0q5U/j+3Nct4/cOdJfeChhZFqJLC7iZmTQxbt6dUPHJA0bkgvIUXR05nYmjOU0
 Nl8G+d5Fw0W0UyBS+DjyIqh9iWS27ATgYobtFU9NZogkuZJHOGcID6fA1P9IOeM54exo
 367g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r18oPVXv0IMyymb52P6a5Lmr7QX+ngKP34/PJcJgsYM=;
 b=kJFQLDFoE2h9Ls/ByBBx7DrYwyGRxqWU0TNpcmJF3ro4DF04u7BW/Y9UTTYGb3NlP4
 5GDapAnWchgM0PcfS3wGwmDtSoxhvPeERdQwSUNpV92glhCBbDjjSW0JbmmWhi+mzNU/
 +Lr12gVKNxzhW45GLjjSSYfahdqNgznV6Zn68ai1F/KF2XiO/UD5OrP9HNhO+apG4PWL
 gBAkM7A+TGBloobTSSdOyJHsoTHIQPQczoDqMYy7gYaAgvtbZpTp1rv38mgEdS3Hp1is
 nGksuAvkChSyYagmBXHumBHur99M3jFSTnZfk9NoGFowbwXiG5CayutLU9J5JYaYDQJx
 5W9A==
X-Gm-Message-State: AOAM5334VcLt+qeU15B2fA3kS1O/Xp/b3rQOLyg5GrrA1O2YRKWlGvqv
 0ppzgW+4Zzm5oXsZSPqIzPpVjb8E
X-Google-Smtp-Source: ABdhPJyyIDAF+33AKqiDzTIW0dNV3OV9DpcCzWczGufwDtEWHQtlPiJJSlcyAGzpCrIFLlGs/WjdkQ==
X-Received: by 2002:a05:620a:15e8:: with SMTP id
 p8mr33416828qkm.182.1596044094493; 
 Wed, 29 Jul 2020 10:34:54 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/17] drm/amdgpu/gmc6: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Wed, 29 Jul 2020 13:34:30 -0400
Message-Id: <20200729173439.3698-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The new helper centralizes the logic in one place.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 28ddb41a78c8..95a9117e9564 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -812,9 +812,6 @@ static unsigned gmc_v6_0_get_vbios_fb_size(struct amdgpu_device *adev)
 			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) *
 			4);
 	}
-	/* return 0 if the pre-OS buffer uses up most of vram */
-	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
-		return 0;
 	return size;
 }
 
@@ -862,7 +859,7 @@ static int gmc_v6_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_vga_size = gmc_v6_0_get_vbios_fb_size(adev);
+	amdgpu_gmc_get_vbios_allocations(adev);
 
 	r = amdgpu_bo_init(adev);
 	if (r)
@@ -1136,6 +1133,7 @@ static const struct amdgpu_gmc_funcs gmc_v6_0_gmc_funcs = {
 	.set_prt = gmc_v6_0_set_prt,
 	.get_vm_pde = gmc_v6_0_get_vm_pde,
 	.get_vm_pte = gmc_v6_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v6_0_get_vbios_fb_size,
 };
 
 static const struct amdgpu_irq_src_funcs gmc_v6_0_irq_funcs = {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
