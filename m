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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF369C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8400C206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbcG5PnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8400C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5113B6E421;
	Tue, 21 Jul 2020 18:09:15 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34086E10E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:09:11 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id l6so20239512qkc.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=twMGEkdOC2Xs5I1flqbc7kkTt5buxo+JWIRI5WGvke8=;
 b=AbcG5PnRj1G6OQJMOJWciyCEJSofrTe5iM5zPPg3yyem2FnPli0+WS+yjYSpsgBCuH
 u8V2hA2KSpS+k6AU3GcBBhAP7+NWvIged74rvkkgCEyGjUgwCYd0DrHYOWi68jC2T231
 vWi+0Req+iWPu366n+aYF/2RafhgxFzbaQQ2grzZgqZ5TvsEiyVX9KOMEU6ofjei6kIn
 fqG/byw4eZSBtm1Rwu3tFVoLqnrDqsb2TgkXY2erfLEXScKUXSfszxnKqDZkXbS/06lE
 YsvnU2w0OwzEQ6y925Piy1wpBS1Ze21P+8xkLvs/o1ujVx482VbANHaSqdYDR6O2Nm2U
 xNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=twMGEkdOC2Xs5I1flqbc7kkTt5buxo+JWIRI5WGvke8=;
 b=Oab9bkEP9JgwiksUJqfoMdRbkc76kc0nMSw82glxts/7Kvc5mRqak9t+zhynPSNdaa
 cS+RLpKGRBf5/fpAvKh8pYkFmfNx1u7fc5nAO8bsyq2195++bwxrXcnG4YAdNyZkUraR
 OiAWWdj2j2ZJ4LknIinFGMIWqmzmdY+IA4f4m/OAWrOooTFDyNT7VKbfYUKGVP+pjgAP
 SYqh8vHPYS1pVw13yzaRNJIK4U6MXFQ9pPmS+YYTfjkEbp8ZPJdr2V2cG5Gv4ZDSZ1T0
 vXA8jYFMtFbqk1J5jYQSDJGC3JYJQ65tJiO044apKAfqCCZGREeuavmxc7h+dwHk4FDa
 6slA==
X-Gm-Message-State: AOAM533R10VfqzQ+OOs40uUF1D+lT4wJDenJ9npiJANklHAYZSo8w6ok
 uCHrvmEcBKhSN2BVdY6Pg189KlrT
X-Google-Smtp-Source: ABdhPJzuvSaw2DoBR17ghTwaCOG6uC/Q/loneFIEmNGbu+s5R8TA9MLlOdGjZTUpY0BWJCYBIozcaQ==
X-Received: by 2002:a37:9fd0:: with SMTP id i199mr7328646qke.248.1595354950635; 
 Tue, 21 Jul 2020 11:09:10 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t65sm2957284qkf.119.2020.07.21.11.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:09:09 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu/vega20: enable the smu i2c bus for all boards
Date: Tue, 21 Jul 2020 14:08:47 -0400
Message-Id: <20200721180850.813406-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721180850.813406-1-alexander.deucher@amd.com>
References: <20200721180850.813406-1-alexander.deucher@amd.com>
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
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no longer a ras dependency so it's safe to expose
on all boards.

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
