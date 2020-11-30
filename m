Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58798C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EC620725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE8xILPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EC620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CB68996F;
	Mon, 30 Nov 2020 23:13:26 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570698996F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 23:13:25 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id y197so12626316qkb.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O/EoVgfJa7oVZlTJeVxsCjx9gN9q1aEOfuTfoZOwcJE=;
 b=nE8xILPMsIEr3yGFdBHQJWqZhfpCMKvrO6ibO+sSyIB+govgpteTrI2fQUpl2yW2OF
 D6QLhPbn56vmi9ljm1Lc14MgUFT07N2RFgDVZbL/b0KNqPwUKgUXH1SG1NCtlCa1NZlq
 X4U3XCwCaUn25HbiWAmv2Nyac40cC+c9BJNOKS3FlPc5mwkQlsNo2uBtaLr+Tj7p00g4
 3QcThN6Ejdj7jW02PIty+hC0uvydIUW9o+uRxgy5AwOi1qGPAHJEU+BNxhGZFKeEMgR7
 xvtIpy07fMw5sYtFIPHep+8GPk/T3oJVMmv5TMJbqYSkBqeSszw+OyhEY34+moOisXUw
 OVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O/EoVgfJa7oVZlTJeVxsCjx9gN9q1aEOfuTfoZOwcJE=;
 b=e5pzdg9CF1ggi2CFp/wWFY56XuqhdpPNL/nbjqKGGpXeEJrm3jWHaLoQe4h3rXyHnY
 9pnGP99uBdFADFotVOGZEGDqOJl/NTdjBRsF7w0uUODIZHw7HrG9Tes1C+hcFr9O9g22
 fHrzV5AsaHDnxL1Ahpsd5mmFIsv/oDFC5cxSAt3JJKQCVfA5FZesEbqBxqI1DGuwR/IY
 99yqH7kH85rAultQX76jZCZhdjEMu4qC0ACTCwF5TSEEBjKSv13KeRiJFOYei4YiFbCA
 RrxkY+w3eMF0tFVZp87ZiP/5TJGmoJ16HBVkgYdUoSiDtyHpJymzbJtB/LuZAOsdFXfs
 Aaqw==
X-Gm-Message-State: AOAM530Hdl89kpoSs0r0ZSVOpR+9vsJhMJgsBU8DzviIt4or9BNrvLP+
 RCCy3jIhRy3KlaXZ6mH0IgotaXDw8mU=
X-Google-Smtp-Source: ABdhPJy02UTMk3qmiYRmYiUipff4Qgn/mSdHSTTz/IGf7M4iJ++RCf5ybv8NwCP1y7GnhtYCpb0c7g==
X-Received: by 2002:a37:470f:: with SMTP id u15mr26109464qka.37.1606778004464; 
 Mon, 30 Nov 2020 15:13:24 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id d9sm16688383qtr.68.2020.11.30.15.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 15:13:23 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay/ci: return an error of copying to smc
 fails
Date: Mon, 30 Nov 2020 18:13:17 -0500
Message-Id: <20201130231317.237210-1-alexander.deucher@amd.com>
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

Rather than just silently dropping it.  Also fixes a set but
unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 329bf4d44bbc..93a1c7248e26 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2193,7 +2193,7 @@ static int ci_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 
 	res = ci_copy_bytes_to_smc(hwmgr, ci_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
 
-	return 0;
+	return res;
 }
 
 static int ci_program_mem_timing_parameters(struct pp_hwmgr *hwmgr)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
