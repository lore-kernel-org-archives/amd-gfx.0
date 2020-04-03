Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F01C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0432206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAXLDpr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0432206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DAB6E15F;
	Fri,  3 Apr 2020 16:33:48 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2506E15F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:33:47 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id k13so8650730qki.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=24AofGgMVjMoBqVQBXAUX35c9dFVVqllrDLSvBQYdY0=;
 b=RAXLDpr1qerzOlg1nKowHehv3nhU9YBVIuL+qjq+zZsBxYHOSYP1kPzNK2nx7quoT0
 4cejkx0AzmKnv4IrAvNKg4uosiwBIV/jVK+LjEMwPRf2Ezfj/jMLOS3S5c7DYwVs80Rn
 MyN8gKYYtRmdK8XLVQ84KXk8TDi0kVPu3MmumLzvXddFQY+0UZ9gf5YYCIStdEZpgyXU
 jaYH5n3m/cgMliamL6KjmS7pmYN4J6hlM1t8u5cb+cWew5tehNZ/zIdyYXa2Rf6qbuNH
 Z26zo30CkGobhmmBM/1+9gBWuq31zYW5Zhak1qGYsWB7tn1tIp/pHeK0ROVB84WddSuq
 DQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=24AofGgMVjMoBqVQBXAUX35c9dFVVqllrDLSvBQYdY0=;
 b=aYK9w67+l19pqmrdH76SKTkDYztrmKBR3uPvEk1F+gKslzbfWKraUfS1NkNuEH+Nkv
 knzgjfvbmkvjBMqZCYmZwC6JP48ZZ4k+mLnvBmBER391iteqx/maA4y04QKWk/Y7V19s
 JoozN8Je9I+EuKoZ0cCkfXpRAkMqxQWw5q1VPlLjK/lOL2K1MaS2c7B5Ha9Vzuc88uPI
 /eQ5LCj3SFAFBv8HnnBFcUydQD6mKc1p/LyAC0+aN0Ln4bmFQHNyXaQi8VgSCCki1tbn
 ChIGyFr3/pBR/g1a9RE4JrvGagZE921L0EmCp+TFbm2Jwos1SLIoIbbJRHIChlUg0bDn
 WUgw==
X-Gm-Message-State: AGi0PuZHeRG3yQ1Izp2oKRFVtPlhhbXdrwNHRuQZkOIA7DVenn2fx/9s
 G4xkOEjpkPJi5mPGM/J9AohpcVLK
X-Google-Smtp-Source: APiQypKLLb/4nraqpgALgpKd8iz+vfQ7JAfsPWpwM0n08nz7L2d9WISmLI5wtJ2WNVQsMW2lezl6Cw==
X-Received: by 2002:a37:5b82:: with SMTP id p124mr9950209qkb.130.1585931626693; 
 Fri, 03 Apr 2020 09:33:46 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id x6sm6583134qke.43.2020.04.03.09.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 09:33:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/psp: dont warn on missing optional TA's
Date: Fri,  3 Apr 2020 12:32:39 -0400
Message-Id: <20200403163239.63400-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
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

Replace dev_warn() with dev_info() and note that they are
optional to avoid confusing users.

The RAS TAs only exist on server boards and the HDCP and DTM
TAs only exist on client boards.  They are optional either way.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dbaeffc4431e..5d67b1838951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -822,7 +822,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 
 	if (!psp->adev->psp.ta_ras_ucode_size ||
 	    !psp->adev->psp.ta_ras_start_addr) {
-		dev_warn(psp->adev->dev, "RAS: ras ta ucode is not available\n");
+		dev_info(psp->adev->dev, "RAS: optional ras ta ucode is not available\n");
 		return 0;
 	}
 
@@ -906,7 +906,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 
 	if (!psp->adev->psp.ta_hdcp_ucode_size ||
 	    !psp->adev->psp.ta_hdcp_start_addr) {
-		dev_warn(psp->adev->dev, "HDCP: hdcp ta ucode is not available\n");
+		dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is not available\n");
 		return 0;
 	}
 
@@ -1052,7 +1052,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 
 	if (!psp->adev->psp.ta_dtm_ucode_size ||
 	    !psp->adev->psp.ta_dtm_start_addr) {
-		dev_warn(psp->adev->dev, "DTM: dtm ta ucode is not available\n");
+		dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not available\n");
 		return 0;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
