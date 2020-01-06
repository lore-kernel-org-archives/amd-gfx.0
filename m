Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A46C33C9B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 18:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81FA2072E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 18:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlTKH5GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81FA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B008895B9;
	Mon,  6 Jan 2020 18:35:16 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B344389598
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 18:35:14 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id 21so40359075qky.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nx16DgunP8xbwRFywL6OVwMBmtIUhLsbBU+bBFUvy9o=;
 b=KlTKH5GOlzooFJrSME1C719P7orTG1fZr2xf0lORRZqhagbDqIzI5A+Pr/dAsG4Sgn
 eKOSyeF3HQFwV9VjIF/rhfe/eGetMe3ZoSAQHsaHiMav3QWkLaLC3+P94CXPi4D1v9ED
 8st3/7HXah7ICWicCuboFqQkovC3aB3pLkZKx1yVCWTHvWD8ijWicmZ9Fy348faVEWH7
 axEZd9/qnvUCfyn1vyXl7XIh/B8R9gNxRl4T8TTkRjtk+j+iQsoWWGEACquP3tcmE2pv
 SYo7zDdvgGjC/QZeIcHVokd24fTnpD0OLuGBuwLYg9xaprAcQ4udzn/V4iwyYlJFA45A
 FFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nx16DgunP8xbwRFywL6OVwMBmtIUhLsbBU+bBFUvy9o=;
 b=CwqLDIvwohH2bq8frryIDZYMCcdMUYm46r2cbxRQc+eK+Nu8rEw7OrV8Jo2PJBkv2O
 gPDsbiRv3hGYzFQH8dmMSMTRiiZhpDM4zIEptRTEyN0s3HSy8OGKfvkRTKMKuKenLPr3
 EuDMwukTk3uqdSRYos/M+verZ9QALNWEOMHKv9Di4cPzfAHCOVXI38eNk2qFBLPFRE2k
 69loc7K36fl6ZQNxirfB4LyU/RHBtu/KsliSKksUnoeGjdKoRZys4wacVcN2DTy9HF1h
 MJBkoEACqAWbQAnGoUDm2fuBWDdue1UBrW14RNOdUlATK6zDnZc7gU0AvEjegr9u+yc+
 2uxw==
X-Gm-Message-State: APjAAAVMHEaQzMVe+i9UTBqiEXnD0mZ/Q1X22oGh7RORczWsHP1DJV4m
 ejk0NhEiW8Us8kfBpJKqLQXiSedz
X-Google-Smtp-Source: APXvYqxwCSafqMdJy63d4/oWNAZC7JbsZtLY0GSfYCCf6G9RL5ngDJMHt78bL/s3D2x+niWkeG20Rg==
X-Received: by 2002:a05:620a:13fa:: with SMTP id
 h26mr82506124qkl.150.1578335713598; 
 Mon, 06 Jan 2020 10:35:13 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id t1sm18895879qkt.129.2020.01.06.10.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:35:13 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gmc10: use common invalidation engine helper
Date: Mon,  6 Jan 2020 13:35:06 -0500
Message-Id: <20200106183506.692030-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106183506.692030-1-alexander.deucher@amd.com>
References: <20200106183506.692030-1-alexander.deucher@amd.com>
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

Rather than open coding it.  This also changes the free masks
to better reflect the usage by other components.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

We always started at invalidation engine 4 on gmc10.  Was there a
reason for that?  I would have figured it would follow the same
model as older asics.  I can make this more flexiable if so.


 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 19 ++++---------------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d6901b274790..5884ab590486 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -335,7 +335,7 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 }
 
 	/*
-	 * The latest engine allocation on gfx9 is:
+	 * The latest engine allocation on gfx9/10 is:
 	 * Engine 2, 3: firmware
 	 * Engine 0, 1, 4~16: amdgpu ring,
 	 *                    subject to change when ring number changes
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f5725336a5f2..da9765ff45d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -564,22 +564,11 @@ static int gmc_v10_0_early_init(void *handle)
 static int gmc_v10_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	unsigned vm_inv_eng[AMDGPU_MAX_VMHUBS] = { 4, 4 };
-	unsigned i;
-
-	for(i = 0; i < adev->num_rings; ++i) {
-		struct amdgpu_ring *ring = adev->rings[i];
-		unsigned vmhub = ring->funcs->vmhub;
-
-		ring->vm_inv_eng = vm_inv_eng[vmhub]++;
-		dev_info(adev->dev, "ring %u(%s) uses VM inv eng %u on hub %u\n",
-			 ring->idx, ring->name, ring->vm_inv_eng,
-			 ring->funcs->vmhub);
-	}
+	int r;
 
-	/* Engine 17 is used for GART flushes */
-	for(i = 0; i < AMDGPU_MAX_VMHUBS; ++i)
-		BUG_ON(vm_inv_eng[i] > 17);
+	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
+	if (r)
+		return r;
 
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
