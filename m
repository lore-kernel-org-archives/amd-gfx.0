Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E427CC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 20:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576D520728
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 20:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqo/gWKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576D520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D164F6E8FB;
	Thu, 29 Oct 2020 20:31:46 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207936E8FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 20:31:46 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id s1so1883016qvm.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mSUAOnEcq+cpu4Pe9JI9TFBz7avBYPk484lce3g9HZI=;
 b=Qqo/gWKjSJkPosOCFXf0DLAROF5BFpBoDT/nUP5kUnqfILh1QswzGV1bklOa4rZOwr
 zozr2youNbppX9b+bDqUZTzU7kX/QrZA3N/JKGyLPPFnSwZe+CqdffjvJiVNCPZ1bGyF
 TbgS9dknlOUjcC3RjXsKIrk6qyXtFp88cywdPkgQFI5qLMsisNFt8hf5V1zRQm1c9OCr
 D4aqHjcENcEOyLUEE/19QbjQ8uP4+of81MhpLddTBDhJ3R1OiFZbBX3MkUoNop/CKVVK
 4gI02Z4bJb5q5jIDgNXuwxjYqjt8W4r9IoKFPlqJDJppqUYfbcpzvYBAe7KZiTkKb6fA
 7u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mSUAOnEcq+cpu4Pe9JI9TFBz7avBYPk484lce3g9HZI=;
 b=jZ5wWpIdfC0hQWUkkr3WA+NXpIOwE4sR53HD53egCoWjfZUeg7iWCRbBriRBOTn+os
 CUzU/O7doFLBYyjt61i8lvYUM9iDog9dkT4v+Q51giA/Ol9AjhdP+3BV51UT82pPpRg2
 +nvReD81ipok+qZjxqs2V3gdSfLu9wuV5b8vnyKqBQrUzwVaNyK3YDff6zn/frU6k+Kj
 Uiufk7rKBLZ4D5I/b1qAlIZ5vPo79Ot48i4Z7l0H+oelOz5Rsvg9S9bSMs9Ahnd31PXz
 FMJGRg+dmAshqvOwIEuKdTErJPl31DZ6kK5RFW3XnM1JCdeQjnKcTiGLvNoKI12VRV7E
 E9ag==
X-Gm-Message-State: AOAM531y3KVCnljqj29NNMoSatRSleblYTYP+pjoBq++OUEfLAWSJohg
 gHhvc2Udlm1qRObKATfA7nvP+VQTb1E=
X-Google-Smtp-Source: ABdhPJw+93xfpM6aw2E3eYT11bDJkUHinxm8TEoQmKftqiymbdBJ7POhVhtcrnvMiROwPFixZDGDJw==
X-Received: by 2002:a0c:eacc:: with SMTP id y12mr5933402qvp.31.1604003505151; 
 Thu, 29 Oct 2020 13:31:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 19sm1685976qki.33.2020.10.29.13.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 13:31:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: allow TMZ on vangogh
Date: Thu, 29 Oct 2020 16:31:33 -0400
Message-Id: <20201029203133.215585-1-alexander.deucher@amd.com>
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

Uses the same pathes as navi.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index fa799600a58f..1449489cbe78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -393,6 +393,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_VANGOGH:
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
