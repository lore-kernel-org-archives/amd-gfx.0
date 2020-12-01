Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C71C64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 23:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C61A2220B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 23:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C61A2220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F1A6E95B;
	Tue,  1 Dec 2020 23:18:28 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C1B6E95B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 23:18:26 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id g19so1749428qvy.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3wusBcuO1U06z/NLsWyzhnZ7xcnSlKl2NpO5jPeJs/Q=;
 b=Ce64qVzJgrBbWmOSovBrZx2bnn7h8zKe1+7vnRao0/ivvqc8arCtb2OfLYo7cQImkW
 T0j5glm4Egn6ewJ7ymm+LoTLXn58JTyQJ7wXn/tKQlhq4gQ9z1TP9Sxfp0eDVX/2W+Lb
 VFXSgMsK5gQ55kHRaNBEuBQuRAEGeNeH2asIqlNVdfsajnwQRZ6WEzf8fsQM/MH7fwtJ
 6yOEyTT+u0XH4N/HocrWEKPZ+PszB35kVrU/IKf5zmgz869jZvYAxsrJ+FDw0whPS/4Q
 FUPZUyVCZNZ3zj6eqG5vS5UJ1IEEO9jxFbWAW6/DOjjPr7nbyj21spncF9Kr9hyvmFwz
 DbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3wusBcuO1U06z/NLsWyzhnZ7xcnSlKl2NpO5jPeJs/Q=;
 b=ZkJWcW7huLiAy21AKqjpRFzBCzEHGwlTdS/ahyRliIKqRS0cMHPKK0Kro4gWjSlhrC
 SPEPFfqPfdJEAGrmiF2gYO/THAAjZB/DXEsZz7JvDlf/hk9PLJj48kYCAs7PqxBmYNj0
 LrdLzX+CoiSDsXS7gQ0h/v2WhEVo3OxNl/th25XhlW51H2b/vbcstEKQ+JB+1bPw1xRM
 /Ei9dO/H3Cj52f9IUIrf1R8ooMkpXdBFGG3suhEgVevmlSj0v66H4byDTbzPO2XTfgrB
 mEYZZb/FFZimTPCyRuf+7Iz4Ispp4Tnysl+QT4+OwR0Anddw8325wYt2+XjVUCX7LXsI
 jJxg==
X-Gm-Message-State: AOAM532AaGD1XqpWmjzEjNd1/JSgbQ/pe7uD4LglROIhboVWuNkjHlkZ
 mvJEw7kWAF4fIdc6xguqcw8sN+gS880=
X-Google-Smtp-Source: ABdhPJwKkh/V2Pm+J00n25z2A88wqBK5XIdBqDWjoPOqHr2HjqGBtUuBohoFKlROghDvh7V6qdnD/g==
X-Received: by 2002:ad4:4b01:: with SMTP id r1mr5557276qvw.51.1606864705874;
 Tue, 01 Dec 2020 15:18:25 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id r8sm1294615qtj.94.2020.12.01.15.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 15:18:25 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/sdma5.0: enable ctxempty interrupt
Date: Tue,  1 Dec 2020 18:18:15 -0500
Message-Id: <20201201231816.1241159-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

This is may be required for proper gfxoff operation with
SDMA workloads.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b208b81005bb..2699b8ea82ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -810,6 +810,15 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
  */
 static int sdma_v5_0_rlc_resume(struct amdgpu_device *adev)
 {
+	int i;
+	u32 sdma_cntl;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		sdma_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, CTXEMPTY_INT_ENABLE, 1);
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), sdma_cntl);
+	}
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
