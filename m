Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F8C47257
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0A72083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6DgfQm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0A72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E1A6E136;
	Thu,  7 May 2020 16:08:19 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B366E136
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:08:18 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id p12so833045qtn.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=auLDUTubyrxHGVyw6NU83acqytv17n3SyW+AVGuh/YY=;
 b=A6DgfQm6K7pQSupqC/+E3ybCOY7y5hWLs+/A13bEKXps7M0r1YVBdcA2VYwO9G8mN2
 gLHYmEAZaJK98XIQV0TnDykap1/Wz9sA0y/WEpreiNQAWxTX1IjOCdjq0lRM8ay8ODqE
 zcOLWfAu+cIjKGyPcUUf2pm/k75Xq7JNRH6MYypv3WRupqsek/hP7cscM8lqD7SNrNpr
 jjiz0F6x4wiHNq3hp0/gJFetOR0bnZbFw9vnxyv/P/rOYR5VSrBOyERntEKfkiYpaUVt
 LaSEWjn9klcXf2OrFVp6sRBCU/SOsNFxAp7zM3Yv0TutdILwS+cDUG9iX2BolyC2j+BV
 Qwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=auLDUTubyrxHGVyw6NU83acqytv17n3SyW+AVGuh/YY=;
 b=bwkVroX0u2OCSgakz/2BnmjuuKtUUmEbbZZElbrqkgpmyyf9+4V77cu+slhm+LduOF
 r7qgz55DhF6THGtAjGDyHuB5Vi9BH2gQ34uoxFIfX76TZSdmxX8pCK1MpDudrOBcAzDH
 PF3xafuDxJp/DOdqYHSaQjkoZUeG+1fjmb3Bm6pEYj/WIquJkdDHHs/KtDf+yPnahlqq
 sBNtPEvAK+30PzDZBGO/7gnlhzxCZ7kfOcNmk5iJ+zJT6DSbaWI/9WSsSVSna4XqnITm
 DEVRDnqMalnRP0pEIPQwf/LR1tUGyO2eNqGBobWL7YfN/0NNluqO6W/QSohqR8phRhVC
 S2Bw==
X-Gm-Message-State: AGi0Pub0RJzSClQ22umj4J/3w856t6cXTRBBR8Sw6St5igFqRS2Fn/7H
 uBFGlCBnpPC+lCe4oyKVlvN0qZRL
X-Google-Smtp-Source: APiQypJbtiQHIMOnKGtW8S/ZZpRZALrTOQl9UjA13mSKlZiR4cUipJ5hJj8pi/ShMZkCil/TX5CbuA==
X-Received: by 2002:ac8:4447:: with SMTP id m7mr14742154qtn.372.1588867697394; 
 Thu, 07 May 2020 09:08:17 -0700 (PDT)
Received: from localhost.localdomain ([71.219.37.167])
 by smtp.gmail.com with ESMTPSA id d6sm3186567qkj.72.2020.05.07.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 09:08:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: drop extra runtime pm handling in resume pmop
Date: Thu,  7 May 2020 12:08:07 -0400
Message-Id: <20200507160808.4250-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200507160808.4250-1-alexander.deucher@amd.com>
References: <20200507160808.4250-1-alexander.deucher@amd.com>
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

The core handles this for us.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea2b4254d30c..5407edeeccc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1174,14 +1174,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_dev->dev_private;
-
-	/* GPU comes up enabled by the bios on resume */
-	if (adev->runpm) {
-		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-	}
 
 	return amdgpu_device_resume(drm_dev, true);
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
