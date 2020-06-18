Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F2C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9638920739
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdjg/D02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9638920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B7B6EA5E;
	Thu, 18 Jun 2020 14:51:30 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8E76EA5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 14:51:29 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t194so5964618wmt.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m5rMIGz6XIEnAqRrP7LEstP0WG4sB80s9px6sB1+9a0=;
 b=vdjg/D02yInpxWg+L1tKPZWZWf8MIm/MChdmt8WGa189CUbfOQ/e0Uw49EdGz3KV9Z
 pi/Kg6HnjvEdn/rwvYv9orUAYBbEwoUh4v1Hj+auKwDMki9zKSPLBYV1Xh4ug+rIlAQT
 pN5jPZh8GyULW48/O3cyt21VF9f3XsbHESl0kIUHzgggJ3XHe6loD0h0/EXwvtaHOxjq
 bMS/nlOoxHq2E1Q5/22MBsGQVv8N53t5PqOMz+lnbzL0taSI7PaWo2DZ9YdhFEq7TzXt
 PuCHADAHVBw4zXr7yBzwgps8xdjkOzD7w8gH8L133VMhBP31ZduyERBcRnzyNSVLf5oW
 Y5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m5rMIGz6XIEnAqRrP7LEstP0WG4sB80s9px6sB1+9a0=;
 b=L3H6tk9gkYWMLTzKOFSQhXrjUA4WbSeE3jegJOmWve7m/pwYel/2OC7d0OmVoBRAuC
 /AsSD/vq/9uIpHA6z6mIO7nyHdS1uiOicFOuv4rtKNYhxiPC4J2+lxSlS2vP+mxPOtzZ
 qte9D5NNW2Gj0lt6dskB0h+Q3seIKbk3bHohNSZan/JIdFKC/SrCmcN6T0cbjNfnkp3m
 AcPrgswpZ3ZuEM3mD2ZpSEVvT276fT3MG0yp/j3Bf8SGJY3nCHDAcv2pYPZLUKdtCaMq
 19vYElab88W/afYFI+AJrBtA0kl6gyu3TcbuyQ7KfI7Dbeo1oBLJFTfKtSCdNHzbwfbN
 3qEg==
X-Gm-Message-State: AOAM530vnJ+KFi9BzNVCCFyLeJDdxPuqaIE++rpetAJL/jURXFGLe433
 gJKo996EroT9Ya3HbRQl2MLUfz3HTgMivg==
X-Google-Smtp-Source: ABdhPJwTko3CJfjG1J5y9Qp45gMQM+OTwUSxuOc5FQV7iUQhHgdmp/ff4/zwajunIyxsRmHkB58L8w==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr3761734wmj.31.1592491887374;
 Thu, 18 Jun 2020 07:51:27 -0700 (PDT)
Received: from brihaspati.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q4sm3668900wmc.1.2020.06.18.07.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 07:51:26 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: remove unused functions
Date: Thu, 18 Jun 2020 16:52:35 +0200
Message-Id: <20200618145235.52039-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused amdgpu_xgmi_hive_try_lock() and smu7_reset_asic_tasks().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c         | 5 -----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 91837a991319..e3a3755cb999 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -144,11 +144,6 @@ static const struct amdgpu_pcs_ras_field wafl_pcs_ras_fields[] = {
 	 SOC15_REG_FIELD(PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS, RecoveryRelockAttemptErr)},
 };
 
-void *amdgpu_xgmi_hive_try_lock(struct amdgpu_hive_info *hive)
-{
-	return &hive->device_list;
-}
-
 /**
  * DOC: AMDGPU XGMI Support
  *
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 2c9cac8c170c..ffe05b7cc1f0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1548,12 +1548,6 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-int smu7_reset_asic_tasks(struct pp_hwmgr *hwmgr)
-{
-
-	return 0;
-}
-
 static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
