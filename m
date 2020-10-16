Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B794C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0654720848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaebppXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0654720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D826EE29;
	Fri, 16 Oct 2020 16:57:47 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083966EE29
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 16:57:45 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id h19so2016003qtq.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d/6WF8Zg2JJvsogq9NlfLIW6oBYVLGvm7zg4IRnhytc=;
 b=qaebppXmOdFKXVjRZLFuzQW3pR51j8jFwZaqd66j89Q4gGzIpXoWvIixnnOghgl7is
 ZByTMD+Av0NoLXUGt+8vtDyvrKNLGZOp6TWiJO8wJHvaCZ6lLe3s3wQenn3gcSte2btd
 xSPrC9mGR0zFmPcmUH1NUKjn25D5EKQyTVvPyl1kWseEnd8NXh+aCgPpvNQBhYO2cfS2
 DL6w6aYU/kZUqA31uwoU1ydI2IPj0uCUoEEQdoHDXjV+bSoyOXSXgUNklr3bRlI5Wlax
 nSmXlCvqNXjmZRStQCRHHYxoknKGNM3pIP5i4V8ZTinTG2gnHPBiqi7DKaWjSbM2yuDL
 BAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d/6WF8Zg2JJvsogq9NlfLIW6oBYVLGvm7zg4IRnhytc=;
 b=AOoFLyeb6Z1wrlBenrZbBus6/jFujfEua4VIYNfLln6cKwAHDQWIwqQ0OIiivRBj6R
 Gy95LKknihpnqIOGA0IKBumBdJLJpLp2VqCZixiAYm+vrrhJK38w+w3homXPHGUJ3TTi
 FOG26ugtsPUuqn2pXV5x8u0Qil0LXmCeu3+vr7Mqh6wAJlyhkJSNLWQlx+liMCghRP+b
 feWKLMcqyHuG6WvmJRbFMcy3unxogbiKErhydg0B524CxQX09clCAuAaZ0U8XNGHeaDV
 IESGJdcmUpzfBep0YzsakxWVoYK7OdPG3mVx9Hg0Of1g7HFzzMuCwJU+gBWjKzSexkSK
 Zhcw==
X-Gm-Message-State: AOAM532IxrYFYTogXlaQrdePvvO0mz/h9xQcC8eNkjwgABysDyVOH+GH
 d9WWU5eUsWXVehnyDBFa9wUnYknr2jM=
X-Google-Smtp-Source: ABdhPJxHJnUGC4ukR39TngNyG18IKOB9FqREl5kAezGKJcPLtoCevMhLlkGVyYftl1v9tsYZDe/Z3g==
X-Received: by 2002:ac8:709a:: with SMTP id y26mr4118372qto.383.1602867464988; 
 Fri, 16 Oct 2020 09:57:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k15sm1244396qtk.64.2020.10.16.09.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:57:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gmc10: remove dummy read workaround for newer chips
Date: Fri, 16 Oct 2020 12:57:35 -0400
Message-Id: <20201016165735.1232180-1-alexander.deucher@amd.com>
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

Sienna Cichlid and newer have a hw fix so no longer require
the workaround.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f7a8417b2946..40af17610207 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -107,7 +107,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		 * be updated to avoid reading an incorrect value due to
 		 * the new fast GRBM interface.
 		 */
-		if (entry->vmid_src == AMDGPU_GFXHUB_0)
+		if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
+		    (adev->asic_type < CHIP_SIENNA_CICHLID))
 			RREG32(hub->vm_l2_pro_fault_status);
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
@@ -232,7 +233,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 * Issue a dummy read to wait for the ACK register to be cleared
 	 * to avoid a false ACK due to the new fast GRBM interface.
 	 */
-	if (vmhub == AMDGPU_GFXHUB_0)
+	if ((vmhub == AMDGPU_GFXHUB_0) &&
+	    (adev->asic_type < CHIP_SIENNA_CICHLID))
 		RREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng);
 
 	/* Wait for ACK with a delay.*/
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
