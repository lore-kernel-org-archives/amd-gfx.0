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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE19207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVsWsuo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE19207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AD26E5CA;
	Wed, 29 Jul 2020 17:35:02 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243446E5CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:57 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id l64so16205789qkb.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zHNpl+LOqceyTzATokgDJbn7rrhFrKZSXVJV3VlMlyw=;
 b=KVsWsuo15idZyA3VKtGXoDD5m9zlHkHctgCtcpHGtuftsDwZjm83LzaCV3+kSBFHmU
 3/AAo8/M7C9Vn0u102AHpz2DPKACLK54hb+MmIXvo57MhSwnsd3M4HFsoVMeGBHIGW+r
 GMnxJpWKvTzjibXS670Kua5qlOXm4P8k7fHFG9xkssUSKHVkU2gpxvS6GpBDtCXRKA6t
 ApmvHmB9XCncaTcMiR5p1bL6XnojSWymANId+P+Eb7Aku6nVoH8bwFJVjwQhQM5hv+jd
 XuRWjUoZIp6ci2iv1IjoNL5chs3nN7bfJgO42Q4N5vQ6a4wtY+qRPj5faEgvUl9RTAat
 WB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zHNpl+LOqceyTzATokgDJbn7rrhFrKZSXVJV3VlMlyw=;
 b=c80foTh1qSkz/pUMDJ6tDCLzWo9NvXVadj4aOOjQERXcUnFadRX/c5ROw3vGjoTgOs
 ZW75JvT+6qSufFDhtxHE3GXieErdC6vvINHJwEBr9rSmyDHJHp1RFS4FDs9/fGw0wrQQ
 taOTjNDmqR3c68nzFzDjUB5upBU3ZKYikx+cci9bmyocCWH+qh6scnjCQwNNDRyiA+vm
 /ulGmC6bv0kWgzaq/JrzrKraagb6cmpPnCuxxOTS011cMhkzP3GgldhUXCAu7YSB+Za6
 LhQGQkkb5oxcJdWrgXR5Swt/q35qP8MdOy5RoxFie5J2hVKZpzLWhFepAdYtXSV4QvWv
 uL0Q==
X-Gm-Message-State: AOAM531NfNxSBEqtG2hkIqg+tNaVPskA1zQACqDsFQIjXW2hLcV4v9CN
 1/gxiSz5GTpgwQSEGT3WgufV5WR0
X-Google-Smtp-Source: ABdhPJwuwhN7WQqmrVkWMh+hVUVfAFZ4Ojog/zqOocrq5SgTDqV7S5LOxGjSrOhr32WL86REuF/cAQ==
X-Received: by 2002:a05:620a:152d:: with SMTP id
 n13mr32491108qkk.43.1596044095586; 
 Wed, 29 Jul 2020 10:34:55 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/17] drm/amdgpu/gmc7: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Wed, 29 Jul 2020 13:34:31 -0400
Message-Id: <20200729173439.3698-10-alexander.deucher@amd.com>
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
