Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F0C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8690E2073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4eKQo+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8690E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457566E1A2;
	Tue, 21 Jul 2020 16:52:55 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B914A89C93
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:52:51 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id m8so9620574qvk.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b5bCgOpCM5OdkVRSZw4msZ3exmUlXU3K3qIKrKoP2Z8=;
 b=X4eKQo+8qD5vs4KBSbZUaW3VJZMN/QeVQy1v100kXAWVUIZPMGiihU7XYj/DEHcARh
 AZ3lC70A8xSE+Khs2nZiJcQ4wH2YnXsebXxyHOfnDzB1M1ecniqbEeXyQcqhhbRpYG2D
 DrGaQo3Mm+E9mm3B65SGfe0LEbQSyhPPHvDFBSkVjZygGsUuir7jUL3QidxdZy249Eim
 elc8/wyN8kA7h/GI/wREc4391me9b2Qys+KU9TBfIvwHE+eQEdHXrgi8VgfFCAZutyU7
 y+QwHHT1s7WgVYOlYRccVczASTDjXYFbDaGeDpu8y3zNZfe2XKPQwtnUS/eyULI1Z51H
 hb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b5bCgOpCM5OdkVRSZw4msZ3exmUlXU3K3qIKrKoP2Z8=;
 b=Gj5KZERnXzbiblUO0BmvDvehSoBXSFR/1AasT1NbUTOr8R0ZSB/nabQlaoPswvHv/P
 rFF7Z3xeo9yf4iKMUeLrC9OxD8U1j+czZLbk6nLg165IXyNIx/stVYzfk7FecVKqFyzJ
 A6xDmBeFtmGDRe+pPgXPR9/0A5UAaozWfRwc8D85186+U0QuoY+KqqKTlVE4qdyLWfbh
 IGvu+n5I/DU+90H/4WGLNVOnquf3jOEP6CY4SkSB8J5p8HCvhE5W7MiZ0iUK5Ho0L+QX
 +u85U4neht95ZkCfaIxG7/2uU4sBfM7rkBC6ZtQHVVnHCB6n89UMOG3Hebm3r0PBLtOo
 n5DQ==
X-Gm-Message-State: AOAM530nsffWfeGXvM5AWLGE8HhysrWjffrswSVv/6kkelBIKtPeRwvB
 5f3O0e+WoIzfhbeK8npBQc+ZkACV
X-Google-Smtp-Source: ABdhPJzXhlf0rISRATpc4rvQBwwoUd0LXijFHsPezPTsCi8yuAafrvzaTkG0P0EhgKJVE5FD45qMWQ==
X-Received: by 2002:a0c:83e6:: with SMTP id k93mr26666278qva.112.1595350370623; 
 Tue, 21 Jul 2020 09:52:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d16sm2709212qkk.106.2020.07.21.09.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:52:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu/vega20: enable the smu i2c bus for all boards
Date: Tue, 21 Jul 2020 12:52:37 -0400
Message-Id: <20200721165240.296265-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721165240.296265-1-alexander.deucher@amd.com>
References: <20200721165240.296265-1-alexander.deucher@amd.com>
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

There is no longer a ras dependency so it's safe to expose
on all boards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index d1b7955bb4c7..cf43629d29d2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -522,11 +522,9 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].version = 0x01;
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
 
-	if (adev->psp.ras.ras) {
-		ret = smu_v11_0_i2c_control_init(&adev->pm.smu_i2c);
-		if (ret)
-			goto err4;
-	}
+	ret = smu_v11_0_i2c_control_init(&adev->pm.smu_i2c);
+	if (ret)
+		goto err4;
 
 	return 0;
 
@@ -562,8 +560,7 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (adev->psp.ras.ras)
-		smu_v11_0_i2c_control_fini(&adev->pm.smu_i2c);
+	smu_v11_0_i2c_control_fini(&adev->pm.smu_i2c);
 
 	if (priv) {
 		amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
