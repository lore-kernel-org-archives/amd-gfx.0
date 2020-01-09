Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4436AC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1845A2067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyEDeuCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D5D6E38A;
	Thu,  9 Jan 2020 03:16:13 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBBF6E388
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 03:16:12 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id h126so2181200ywc.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 19:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rnLLkeTtI5qaNduigC1rQcKiaK5vxVFJ4T+czDQDH6o=;
 b=OyEDeuCzoVJAwP4qb1inoTvbnlXzhfDbaIdEtmXUyjijQR/7yNmmuAkXLOCsLhiKOW
 rjSSEXW/yv7BtGeK1r1xhfX6ZPel/IDreaFR2asyQzoGk0HCGy0KI6HMTyWUX9erAc+f
 MceKupRLpRZ8oauFwPDtz3cdaas4XbBvkl7sU41ACFY32ac5hqXjdHhLhyp7/aWKAmO8
 jb066mYCnWGSzo9gsRsOkQ5pL7+hx2jGXdPuGm1K3ZE/MhzOs1BGOKMjHiK4Axzx/4R9
 J/CFPoksUK0Z7nF5h7fjy7KGtTMeVFtZHFqp74VSl3kccpYZT9KVY+NZBOw6l9+xm1mQ
 WijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rnLLkeTtI5qaNduigC1rQcKiaK5vxVFJ4T+czDQDH6o=;
 b=BE3q8m0yAegRQZQ9WMnwN/HtakxaqoS4ymiMFRr28cICbjDrlaYyx6Cde0vRAfzGmg
 0NmUFl49ibnpjtJ6QEkCkOnOw1XEfb4YED4vjQD4RfPT6BG9jVMNVpI31YJZOM5ul3fj
 CGnO9dxyebR5RKIWxhOwkXJKFKJ2VuavJl8r9/PJJSM9DwxpJ7QPk41NNk0nsetDPkrC
 UK8G/gIiL1Mr07bqd4l7XFcFzCRcZ43yEy7AKeV4AQ683unpekovoiP20cqq1SaA2NzH
 VmC21sKuZOwDJyeVY3amD94KScT2TRMa8cICNjBy5EjG5k/QC29rvcipGWDBi3w8YCN+
 Lotw==
X-Gm-Message-State: APjAAAVy5j/ICXB3JL4BnV9RhLYSsXmWj+dvOgfl8r4f2ItN5752wMaq
 noGoY9Dfpxmtu3wNNJZ33yQ5awCe
X-Google-Smtp-Source: APXvYqwSj5TfvgoUh1ku5gklvGKPkx7/Tke2+ggg9+WvnzkTMSgcuKTglmJYSI4/xfRwOjZE7ilTSQ==
X-Received: by 2002:a81:a802:: with SMTP id f2mr5900114ywh.90.1578539771274;
 Wed, 08 Jan 2020 19:16:11 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e187sm2464973ywd.7.2020.01.08.19.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 19:16:10 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gmc10: free stolen memory in late_init
Date: Wed,  8 Jan 2020 22:16:02 -0500
Message-Id: <20200109031602.343800-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109031602.343800-1-alexander.deucher@amd.com>
References: <20200109031602.343800-1-alexander.deucher@amd.com>
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

We don't need to store the pre-OS console memory after
the driver has loaded so free it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index faa310b76b50..5ad89bb6f3ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -566,6 +566,8 @@ static int gmc_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	amdgpu_bo_late_init(adev);
+
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
