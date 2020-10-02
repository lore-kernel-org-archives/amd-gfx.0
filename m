Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721B4C4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269BB206CA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbIxyoAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269BB206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50926E9B4;
	Fri,  2 Oct 2020 15:10:02 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBFC6E9B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 15:10:01 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id o5so1635357qke.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Jro7vrVMqWlHoCwtaiq+0ubfYvn7FdjhmIM9GuBPDM=;
 b=sbIxyoAyM9k+DzB/IzkMP5U6ei0Isw0KTTFeKzqumifjodQ6lP2wHnHjLv5aLVU7X2
 w3ZFBxM/40fmAe+1eRKEL4si7gzCUdNWlFHbqnMpu4jiRSTxE1V77JTAvPwybV2t6CuQ
 Y+wgjSv8J6GOPfEpOlKmcqhVxT6mNgtjrayz/5oTSLBl9f7/SGdI/cbCFDYXdroupxl2
 YQrIgdmuSPHF+s7zvnMm7ef+EXEYKRIKX/lP2uHVlvV6rq3/PL4Yi2G5TLxzrWkXLRv4
 4dCCDgETfMz7tFmHIfa8V5pAcXS3LeotEf1X3s7o7WDWRM3mE6kLsBebQpLJwj8Y0OJc
 9pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Jro7vrVMqWlHoCwtaiq+0ubfYvn7FdjhmIM9GuBPDM=;
 b=V/9ggsjemuBXhtikOXUqKS+EfJgJhboRmtRkhZlXKE2qNmlnfIxFDtSpYEVRbEBBdz
 WNrRao/BX6hVynnjHTFGJ91qr1R1hniP+TTW3F4KiiigseLKsOHuRjGZ2a9GsD3Ljbyc
 0AvPeLk4tfgby9hkIugEtEKMzk1RJLXnGSqVf+bUg4CEgey4slBxR7CEg4h5zqvGHecy
 Ln8BMv1VjYfSZkLLXZlMwyFKb/TAg740CiCPkOVODFfFfqpBX4TWhUNiBxu5+FBhbLFm
 0wv3SrSZON+6Jh9Xv6C7+ujt/qnbw4KaDIWTJU50S19pNgI3O/wDpsY420R+o/w+30YQ
 k5fw==
X-Gm-Message-State: AOAM532gQBgWoFM1QXvwz74cwlk0CCkUTc40zg9BaUJJ5Zlb8QWr2O4A
 PeX4OY2lCiqsLsASxEjGlw4Cd2hiUUU=
X-Google-Smtp-Source: ABdhPJxQXUnd5XPII1LlCmvYd01in378WzTLbAbcGPqPXaX8G/IWVf69joizAtXalzO/DZqqsiMw6Q==
X-Received: by 2002:a37:a189:: with SMTP id k131mr2469789qke.34.1601651400436; 
 Fri, 02 Oct 2020 08:10:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm1248435qkf.98.2020.10.02.08.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 08:09:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: enable green_sardine_asd.bin loading (v2)
Date: Fri,  2 Oct 2020 11:09:39 -0400
Message-Id: <20201002150940.1103949-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201002150940.1103949-1-alexander.deucher@amd.com>
References: <20201002150940.1103949-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch enable green_sardine_asd.bin loading.

v2: use apu flags

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 75489313dbad..dff5c15b4858 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -39,6 +39,7 @@
 
 MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
 MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_asd.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -54,7 +55,10 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 
 	switch (adev->asic_type) {
 	case CHIP_RENOIR:
-		chip_name = "renoir";
+		if (adev->apu_flags & AMD_APU_IS_RENOIR)
+			chip_name = "renoir";
+		else
+			chip_name = "green_sardine";
 		break;
 	default:
 		BUG();
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
