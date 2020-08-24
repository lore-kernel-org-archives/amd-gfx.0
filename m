Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637D620738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsbjvPMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637D620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124D06E332;
	Mon, 24 Aug 2020 16:16:01 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2293895E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:59 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id t6so3980185qvw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xSMCnJXUgVEjbYwuFgOj13JLGcy/vKv8//CyHG1n4GE=;
 b=ZsbjvPMzI44zBl6uYVJjZBdX0kphT3YqrSk62JlvAFaPtjdCB3ebqQs5Ak7OlFwGuA
 hA9jaOo1V9blq+0Kk7wIWplWSnsZgglY8Ul3bva26ps3pT30fWUFcAYr9X3KtUkRg23N
 USH9Y8OqsXo6PDXhMX+nw+rqWn2kKRT4+LBx7ncMht6M2WSlcNcShWbu/GOUji5fnpNu
 VTXfvP9f049CtGElwOO697njTpMUE8oP9nwHoel8Uv18AMmSq3JpD8t9pi4DRKJLzfjU
 UKRj+zUiMtlSXo7BKdfsdnztzj8/4CCuyvhchNAuL16S/SgR+qI6GleUNKuaY3qqcAeX
 fKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xSMCnJXUgVEjbYwuFgOj13JLGcy/vKv8//CyHG1n4GE=;
 b=kZ39mjM5EH809kI8mfgDeiRr9/AvHf7qDRPk+Tz9SOChEI2cPyNP8F9np+HnwCsG4/
 7le9w0kKyfhsNZBPaRediMizwg7EkWj7QKfyV43ySNiOc9yDjOLKxO6VJ/tgVrv8nY0P
 qmAsexwKCDczysoNYrfN0XM15uRdWUyUhTxQGWvSUpA6hWvEbi2Dik0h5bqrTZdReIKo
 uG6XYyg8oQGBzkGqjuXCIVAGNFl+DQnQwsu/dMxqTwvFuFT8T1NYdsxSpW/vpdtZxyFJ
 9R2pHHutrfeF6kF5YOaEOPICP4VeDFrOpWy+j0igE53pOcQOgqmudIK2QyE9W6lIYKQQ
 NSjg==
X-Gm-Message-State: AOAM530v9VcVjcweVktZOXtu1Pg8eKjbykfyW87VW4tvvPdEr3SlcMcD
 aQU/B4mHUYvALCRtbjDVowJ9tRfcbMk=
X-Google-Smtp-Source: ABdhPJySnl0wLVX40xbmcUwLG+f9nTLF1Sgixqi8iHVweZl9uDnynFHThYz+Uh9LCl2QPc8n+09MFA==
X-Received: by 2002:a0c:ea21:: with SMTP id t1mr5515046qvp.62.1598285754874;
 Mon, 24 Aug 2020 09:15:54 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:54 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amdgpu: add a wrapper for atom asic_init
Date: Mon, 24 Aug 2020 12:15:27 -0400
Message-Id: <20200824161527.2001591-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200824161527.2001591-1-alexander.deucher@amd.com>
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
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

This allows us to add asic specific workarounds for atom
asic init while keeping the adev specifics out of the
atombios parser code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6573e1112462..e41aa1e885ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -653,6 +653,20 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
 	BUG();
 }
 
+/**
+ * amdgpu_device_asic_init - Wrapper for atom asic_init
+ *
+ * @dev: drm_device pointer
+ *
+ * Does any asic specific work and then calls atom asic init.
+ */
+static int amdgpu_device_asic_init(struct amdgpu_device *adev)
+{
+	amdgpu_asic_pre_asic_init(adev);
+
+	return amdgpu_atom_asic_init(adev->mode_info.atom_context);
+}
+
 /**
  * amdgpu_device_vram_scratch_init - allocate the VRAM scratch page
  *
@@ -3203,7 +3217,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			goto failed;
 		}
 		DRM_INFO("GPU posting now...\n");
-		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
+		r = amdgpu_device_asic_init(adev);
 		if (r) {
 			dev_err(adev->dev, "gpu post error!\n");
 			goto failed;
@@ -3552,7 +3566,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
-		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
+		r = amdgpu_device_asic_init(adev);
 		if (r)
 			DRM_ERROR("amdgpu asic init failed\n");
 	}
@@ -4109,7 +4123,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_atom_asic_init(tmp_adev->mode_info.atom_context))
+			if (amdgpu_device_asic_init(tmp_adev))
 				DRM_WARN("asic atom init failed!");
 
 			if (!r) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
