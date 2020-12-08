Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E7DC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 16:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAF023AC8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 16:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAF023AC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5202B6E96D;
	Tue,  8 Dec 2020 16:06:10 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1956E96B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 16:06:09 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 1so16417690qka.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 08:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TzPohbh5RC+jGnzG+KFXYPOuV8EmOWn6vnkGv7YyTyU=;
 b=oDN0LakKXyaFQg3F78ninf6GB6RcL7Kk0Tg1DQkTYfoIExmb2xY/Homun/mhV6B6VK
 89Q8CMvgTKFMxNH4juZe6Ejr1KO0bwJvJiiw9Xh4rm16Jswz995Zxm+sNtqflF31vCvj
 P3tnUBYrE+2/FgHscsHc2egtOilJujc3kL6ks3AcgKN+L+SWh8+hVtAWuFgwdliUa0wv
 SUDNJ2hogMmNygo2DN9FYWDrn8OPTxjWEuOfpmuHJZlBNJ0fhrpoeAYCOTGYPKx1X4oD
 ahcMVzTHBxFk1K+8CoyqH8vksMeQEJWLbsKSqDGQaXVb8/62h9KsSTVgOt09E/7CtiPd
 apeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TzPohbh5RC+jGnzG+KFXYPOuV8EmOWn6vnkGv7YyTyU=;
 b=QCwNexwRhvduQXMJx8KtJpjoKYRf99pwxwFk0wdXosgxrnBkkNxL5ILLXjABS7tESc
 pXU5WB2ok0dMoEKqaia2M/IKpCxPSsJaTmqDZ2RrSnuIfaasEbSZF1Q+wPNKXMoqJwJI
 PMChE1m1c7OBI2GfCwS0rHB1ecTZ0/9wCopF3v9Wx0Z1rhULXW0G4sDxqie+ryQV7qTm
 qH7bX84N3mks9Omu3lBTSbHV6evt14VWHZSWM8cqWn07WPWmd+EnyvbFL+qaRBoWwn/o
 sG+JpB8fRsupVljslLmpLA20v7+DvYZBu2QdkRlzp5NDj5tgw5teB4ANGUviYptpS+DB
 Rakg==
X-Gm-Message-State: AOAM533jvayo5ts1D0k2k54NCCHk3TCPQhEbmc2GyTWyokhHcsJv5Ute
 AwoiI9AjhPzl6Yo8FUR2xzbUsoJ466o=
X-Google-Smtp-Source: ABdhPJx3Y/M+AbZbjmRysOAQQCzRWtv3CR02MoASGI9WvMHC+H6EKissyyPpKOYvamRwaT/bzsM65Q==
X-Received: by 2002:a05:620a:11ab:: with SMTP id
 c11mr4236438qkk.282.1607443568166; 
 Tue, 08 Dec 2020 08:06:08 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id u26sm1702482qke.57.2020.12.08.08.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 08:06:07 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: fix size calculation with stolen vga memory
Date: Tue,  8 Dec 2020 11:05:56 -0500
Message-Id: <20201208160556.39899-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201208160556.39899-1-alexander.deucher@amd.com>
References: <20201208160556.39899-1-alexander.deucher@amd.com>
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

If we need to keep the stolen vga memory, make sure it is
at least as big as the legacy vga size.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ff3afc82e73a..02c2a0d5b36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -501,6 +501,9 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	else
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
 
+	if (adev->mman.keep_stolen_vga_memory)
+		size = max(size, AMDGPU_VBIOS_VGA_ALLOCATION);
+
 	/* set to 0 if the pre-OS buffer uses up most of vram */
 	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
 		size = 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
