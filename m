Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE36EC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6327823A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grh5rSAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6327823A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA4F6ED75;
	Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE816ED7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:40 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q63so4126615qkf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fQXvFBbQkhBYtQYHR4W+MRvISa30AgX5pmDdEMFGf7U=;
 b=Grh5rSAMMx+0KM/r5HQpBQ4ScLjOsuHQZ2/Gm3//7vZt1fYsA0RhYdcw0z1Qb80Rpm
 cimWwrlkovPgfR8pd/VTdEvnYX7r9APnY4seV1bexD9YwuB6NcGctTWRCTJ3JhvqUTSV
 6SkSmqLx1rVTjdrvSEd7nA9vNS5Gubfh5bQCtcKXmNindKTen01uslYjpQOChgMXrnSg
 bdZtJzZFhk4yzDpKaO7qiBLuCfkovBQ2wHmbtvuCH6bbl9N7IZbljQ00Fes5QLxnyQqI
 ewA8+KbaW1jRxcO1EEpQ29Kl9f+qDJcuT7OwqPLWdg+nw8w+XW5gQZ7N2m8bBWsl8Hqq
 N6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fQXvFBbQkhBYtQYHR4W+MRvISa30AgX5pmDdEMFGf7U=;
 b=bd8IkuSEifhrZrHLMtDl3L12zx9HkrKO4E9Dfq9osHvILopRpGjrlGkZnW9kQa+I2p
 u1FYdozCD6LMEAnk3eRUxpmoWVq/ZuEekbe6SDlAjApz6yMP56VM0L3yLR9wBlfVsF93
 ufZr7yLVrXUsjzGtOVXYzj4hXOgHgJPfUavXjWhfMDsX++w+QlQsA/0CABg9h7A0KGoH
 ufcZw1Oorf27nIm1LcxORveHoaj7WhNo5WqwXgdOZ4K74iiMo+zeSTcrTzOs7zCSzuLC
 GyE/e8h0PsLzUhMWqaLMCHeDZTKPxweTKImrstF7kOxjHzSVwKimGCiXmkM8GgB7ZLdY
 IUpw==
X-Gm-Message-State: AOAM530AaVTRVogRlzQFsRkuNmC7sdcd8l2X6EnYeaDcHUDvH/62Fp8N
 Xb3HE6Nq5lfmrlXgdmiDjKF1GitmWVQ=
X-Google-Smtp-Source: ABdhPJwnEMybWJRMCUFcpLgz2du5kC/N2UbUAJ6e4e2gkEoaNLROLZJW6BJPZ8tnJL3XHys+ao+sZA==
X-Received: by 2002:a37:b146:: with SMTP id a67mr1761963qkf.55.1601064699394; 
 Fri, 25 Sep 2020 13:11:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/45] drm/amd/powerplay: partially enable swsmu for vangogh
Date: Fri, 25 Sep 2020 16:10:16 -0400
Message-Id: <20200925201029.1738724-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to partially enable swSMU for vangogh for the moment.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3010cb31324a..5534125f1df3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -466,6 +466,9 @@ static int smu_late_init(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
+	if (adev->asic_type == CHIP_VANGOGH)
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -1090,6 +1093,9 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
+	if (adev->asic_type == CHIP_VANGOGH)
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
