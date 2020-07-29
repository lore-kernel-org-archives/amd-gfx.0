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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3603C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864D5207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohTu7/k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864D5207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9786E133;
	Wed, 29 Jul 2020 17:34:52 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D8F6E5BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:49 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id g26so23043957qka.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1tarS6IlLEJJT9eYW30QGrROKaWZf0PFl11yOyrkGdg=;
 b=ohTu7/k8K/SBIe2oN/KzUmmt0rP2beE1R1iNCkNb52O8ejvdPFSrvVykpIm/n2cZXe
 ybGLcQiAZdGWrT9iv0JrKIpqkgG0ciOVZhJwBWH5bTIKnAMRWDSY87D/wEraTae2eb+a
 LmiK/W9MgBaG7KNZJKheHOdRP3l3HcGKVOjX60APSz4w+K2zos/vYz/pG4mwyS9zStlE
 Li2B1bZEOxE9Da+LddPVAgWjj6LUMZeSGGVcrJMi7Y/RxoPcDDet7XRTrZxxHVsCi+os
 dHQPY6fxWuqTk2jYNfZE3bd6A8zkcRiZDJurDEXgLhHqxjnlLJXrmkaBltxq0Eknoa5j
 qEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1tarS6IlLEJJT9eYW30QGrROKaWZf0PFl11yOyrkGdg=;
 b=n44VuAKNjicbdiODhPO9854hymyU5ZpfDPGnnhTuhctgKiwNqD7egC87d9ur7q9mqc
 FNGcHTeSuunb8GQGmOFC3dadRUpNIZgxRFYP0u9XIzMLYKfdjZnDW/DF/vNCVZpEd3A9
 HxqEnxlucru/4mbLMstyUYkEVd7l/HRA5GWYIwn9UD9SiTBz2VUPTl6PQa2gR6JOLbJ9
 E597/u5H6bA4Q5lR5OYEurIsY5ZK82um9Z7A/6wW82qDnqLvS7k+LxEDQOVwDQnrxKEB
 iNhFCCz4bgqOuEa2VaFqeUiCZeKRGOO48cbTQ+b3FtR6pucB80YTE/3AzCG9v91QC8qn
 ogGA==
X-Gm-Message-State: AOAM530AMKfwscE6daw4MTCE91F8B3pVLABHS5yw29w/GUGgu05WeqHP
 virqHSsTRK2hnyvBm9gY+bqMxxw/
X-Google-Smtp-Source: ABdhPJzBQ187aKPSQ29gDMLReUvaQq/h0yiRccT5ISW3Rs5NOEbH5MfJBtndIA3JKcm1xA8AhuV82w==
X-Received: by 2002:a37:6883:: with SMTP id d125mr7023498qkc.160.1596044088416; 
 Wed, 29 Jul 2020 10:34:48 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/17] drm/amdgpu: use create_at for the stolen pre-OS buffer
Date: Wed, 29 Jul 2020 13:34:24 -0400
Message-Id: <20200729173439.3698-3-alexander.deucher@amd.com>
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

Should be functionally the same since nothing else is
allocated at that point, but let's be exact.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 605d266754f6..a188216bccc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1979,10 +1979,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
-	r = amdgpu_bo_create_kernel(adev, adev->gmc.stolen_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_VRAM,
-				    &adev->stolen_vga_memory,
-				    NULL, &stolen_vga_buf);
+	r = amdgpu_bo_create_kernel_at(adev, 0, adev->gmc.stolen_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
+				       &adev->stolen_vga_memory,
+				       &stolen_vga_buf);
 	if (r)
 		return r;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
