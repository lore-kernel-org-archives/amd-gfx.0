Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A7CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E56206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUYioqnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E56206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646596E5B9;
	Tue, 11 Aug 2020 16:05:10 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF59F6E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 16:05:08 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id n129so6446025qkd.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lnQqYRoZW0E0IIb42GLRuXbpo2s3E35txyYfms/I5cU=;
 b=YUYioqnKZ0JctYctIOZ4Ik/WwKcb8tGO6WIsCjrFRQtOGSFlsE/oNHPgV8mz3oa66X
 nxetWGTWiVgXUtMZXaF4QxNhG33i5ZSKAJI5/6tnr1EYp665YTaxrEtWOSGzT730jpM8
 Kaa4cc5vZ8njWBLVFPByyZ7I/EdDDDqrCSVDJW9KMYjrDQ3eYywT0b3KPV/eJZk7E0mz
 RRoTq1wuMgrjwp5yf338LPaG9iTFzEodnaWlQXE6ctmP4YqlqYuOqNndYNeHNXXLuT4+
 q4E/0sLdnt/UBj7YfjdSyh/inGdul89fDef+WXuwuwIQIXoqWZUukzNRFgLqHrC3vtWz
 EGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lnQqYRoZW0E0IIb42GLRuXbpo2s3E35txyYfms/I5cU=;
 b=eisosM8MwuZovk9j6dHQr74xWRVVQaAGuDolnH5rwa0GfUq7uOeSb0vxskPQpYtOz+
 E1ozHHsOnw3sxaRaFhxyt7iCmeSnkKxuJ/LyDoqUn8sSpnd8OpFLRwArOX/M9AR5SUfF
 2rgp4ILEAZdhsRvETOPe0Q/RHH27pVVDzqISpNgU3x4rB5GwHF7TAwnfZ0F/ftisk7uv
 IYrUNdk16HHUt+NBSqB1T8OX/DjmyvpCWmYha5JvTQswGB/p6VUiS79h1iimX8yrpry6
 oHRLoFaQg5b5DKZYFWfAHNFdyu6ooy91utBhzd+A6RNueXQWhYCKamdnoDHtpd9Z7fSN
 RxIA==
X-Gm-Message-State: AOAM533g89Dp7GGGExg2szEMXkPefYgh0fXcXj0FYpldUxYmntTRdIBV
 +5kB0S/W6NvdMG5K1xP++Lo9Su+p
X-Google-Smtp-Source: ABdhPJyiAvKfKZL376PIcc5/Yr7WE+7eGnEU2eUToHRTbLiDGvI5gv6NH9Qg+GszH5RdBnd2lrVvqg==
X-Received: by 2002:a37:4ccc:: with SMTP id z195mr1824221qka.270.1597161907571; 
 Tue, 11 Aug 2020 09:05:07 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id e23sm18971868qto.15.2020.08.11.09.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 09:05:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: note what type of reset we are using
Date: Tue, 11 Aug 2020 12:04:57 -0400
Message-Id: <20200811160457.1073325-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200811160457.1073325-1-alexander.deucher@amd.com>
References: <20200811160457.1073325-1-alexander.deucher@amd.com>
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

When we reset the GPU, note what type of reset will be
used.  This makes debugging different reset scenarios
more clear as the driver may use different reset
methods depending on conditions on the system.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/si.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/vi.c    | 2 ++
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index c2c67ab68a43..7e71ffbca93d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1366,8 +1366,10 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		dev_info(adev->dev, "BACO reset\n");
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
+		dev_info(adev->dev, "PCI CONFIG reset\n");
 		r = cik_asic_pci_config_reset(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index da8024c2826e..54e941e0db60 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -379,7 +379,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		dev_info(adev->dev, "GPU BACO reset\n");
+		dev_info(adev->dev, "BACO reset\n");
 
 		ret = smu_baco_enter(smu);
 		if (ret)
@@ -387,8 +387,10 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		ret = smu_baco_exit(smu);
 		if (ret)
 			return ret;
-	} else
+	} else {
+		dev_info(adev->dev, "MODE1 reset\n");
 		ret = nv_asic_mode1_reset(adev);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e330884edd19..eaa2f071b139 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1302,6 +1302,8 @@ static int si_asic_reset(struct amdgpu_device *adev)
 {
 	int r;
 
+	dev_info(adev->dev, "PCI CONFIG reset\n");
+
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
 	r = si_gpu_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 84d811b6e48b..3cd98c144bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -580,10 +580,13 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
+			dev_info(adev->dev, "BACO reset\n");
 			return soc15_asic_baco_reset(adev);
 		case AMD_RESET_METHOD_MODE2:
+			dev_info(adev->dev, "MODE2 reset\n");
 			return amdgpu_dpm_mode2_reset(adev);
 		default:
+			dev_info(adev->dev, "MODE1 reset\n");
 			return soc15_asic_mode1_reset(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index f6f2ed0830b1..f03314300ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -752,8 +752,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		dev_info(adev->dev, "BACO reset\n");
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
+		dev_info(adev->dev, "PCI CONFIG reset\n");
 		r = vi_asic_pci_config_reset(adev);
 	}
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
