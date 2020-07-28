Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EECC433F2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA80207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kynn1lUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA80207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973556E436;
	Tue, 28 Jul 2020 22:46:44 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E986E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:40 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id l23so20475658qkk.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7dMaeAygtG0vok8AWu+2J1d/1uBRyk0M9cBu3I+nmYY=;
 b=kynn1lUD8miGy24vgpSHzcH2Mb8m/fZuqP3apaDugCExrS5j96u2rO8JhijohQkjKb
 525WWMMNfTYFOsHwpHIynOOHg/4iy6q+PpIH4oN473wsqia2fBLlDKYUJJVV1BH2RAsc
 GUcf1OHjswZxy1cix428Pe4CpiEAOiMd5GhIdPkdCefrU4IOwjmkHQWY+kfkRHVO5tgz
 AHwRz79YDoQMOksS6WlGjXVVQPK34/gdrHE0396oVu2XhAtVh6L3/foyMzVuhOoaPPDy
 3KEnKmvqaNOwg22f+Uhyku3OgczgiioPFlUSwoVPQ8J+mR3xM+4ANVCJfq/gYv2Y9OVX
 jXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7dMaeAygtG0vok8AWu+2J1d/1uBRyk0M9cBu3I+nmYY=;
 b=dxHaC0pJ+Xjqx3JmorMPh9yr16ShdYZfuyuV/y5zzgQMEH2mmhh5LF+6o+S3tziaqm
 8R7fZGnMhrFRpoMM+1RYFW/5V8sXLv4U5sDYyj7FRsA2rcUME7drbS9jky87vyw3gSxn
 r3reMeh3bg6S+Haq3StNUI+IsM8ltv5eNU6s226X2JgBAjmdncIv//hTsnmWb7P5sglA
 TFpQxs8dpOesQjT9ihjCid+7w1ixU6yzmwiQ+byXFfWdoVba+3/k9RTt9QjyaDyY9FCt
 NoWtXdbjWUo5fBkRNwetpz0ZxPNMEmgX9LvyjzH+5RR0hkbOtWWrBTohs0Qp7WRNVGLi
 ErPQ==
X-Gm-Message-State: AOAM531H2iPcUlprDdVtlEY2aD5blsk+l/c+3hyLxTTpgnj9t8427m1d
 r5bPKMe8Ug1jr2B+4OWBTKAdeGeO
X-Google-Smtp-Source: ABdhPJzD7HqXZltIJW8qBveDuSHhqgMpo61mUSs+aksbB308OnVuFKfxmiu6PHlQGwUOTWNIUJSUug==
X-Received: by 2002:a37:a2c2:: with SMTP id
 l185mr29365415qke.417.1595976399930; 
 Tue, 28 Jul 2020 15:46:39 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/14] drm/amdgpu/gmc7: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Tue, 28 Jul 2020 18:46:00 -0400
Message-Id: <20200728224605.3919-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728224605.3919-1-alexander.deucher@amd.com>
References: <20200728224605.3919-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The new helper centralizes the logic in one place.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 8b8ecbb99d84..80c146df338a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -977,9 +977,7 @@ static unsigned gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
 			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) *
 			4);
 	}
-	/* return 0 if the pre-OS buffer uses up most of vram */
-	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
-		return 0;
+
 	return size;
 }
 
@@ -1035,7 +1033,7 @@ static int gmc_v7_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_vga_size = gmc_v7_0_get_vbios_fb_size(adev);
+	amdgpu_gmc_get_vbios_allocations(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
@@ -1372,7 +1370,8 @@ static const struct amdgpu_gmc_funcs gmc_v7_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v7_0_emit_pasid_mapping,
 	.set_prt = gmc_v7_0_set_prt,
 	.get_vm_pde = gmc_v7_0_get_vm_pde,
-	.get_vm_pte = gmc_v7_0_get_vm_pte
+	.get_vm_pte = gmc_v7_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v7_0_get_vbios_fb_size,
 };
 
 static const struct amdgpu_irq_src_funcs gmc_v7_0_irq_funcs = {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
