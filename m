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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76017C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EDD2068F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtBEd8+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EDD2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D686E41B;
	Tue, 21 Jul 2020 17:22:36 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516F26E41B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 17:22:35 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id g13so16745678qtv.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xpLKbL3vgwkN0kdxuf5m1p/WBDFco4l8e72x6h+wv60=;
 b=NtBEd8+u6fFkbignDeYdSd04nFvxqYVlwiKuhfo1t2emcD0m0X6CZQd1B3upM/vRdZ
 8DhtUhdySxUOmyGqAKwVv/2ebbmECIfY+uOiHohJXtsKCCf50/K6d+k0QX1TGubuy+v6
 9YulcsRDmtd6pi18glpn/XRnRmf0CBgSACv/ih6WdkxfkCvjMBlBch5ecTzLqVkAsW5N
 8fMyyYZFiaIsioHxX4biLF+khIgo5ga1p05ul8Kbtdx4x2g1nH3KkbpgKAmRey1/VAu4
 xkZ/fYjFr6nRQTWXUSovgkgm+X4dMDBDgoAShLReqe/qfMFRbfa4Bfl3wdNGrg+q6YkD
 x7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xpLKbL3vgwkN0kdxuf5m1p/WBDFco4l8e72x6h+wv60=;
 b=LAZh4o4bsdR3xeiACm5YO5GaA7137/xqzWvnFuT7qPeGGpF0bH6R6lYeoLwKj05gaZ
 P85SNfohnJK5V8ArkWvq6HxJZQzwt0ejrBPBC9F5lpMzm0Zs/bjE3aWFnaln/lULAk/Z
 5DCEX8hKiol6DJQNAADbzbMfbR7JeEJXF8fD5MGI5GhsY5PDghl33x8nVEMRo2M6lsrj
 JuQRtl9ifpy7mHroqxWeXH9SJnqGpopn5Vz6xDgl1xGuUnIZ6HWcvL+lw0Xi7HopBO0r
 wXgTXsloFY/IFWSaDqjm9FDwslAfsmvBGMUHbn7H68AtAhu8VEik2O7GKJ0CeJC+/YTq
 kCgg==
X-Gm-Message-State: AOAM5317U9sT8xC4292GZZYG5akBfSJ+agZSq6lJfdjzWOQN+O9uTnrE
 5SKDlNf4hdntnXUvMtQgADTeftJg
X-Google-Smtp-Source: ABdhPJwd4SoYBnBE1j6+QeerUfrqfyXQqv8q1CKR4Yicvif+jKIRkdXOY80WSzKvB1IgVD3/OaHVpA==
X-Received: by 2002:ac8:7c87:: with SMTP id y7mr1044131qtv.375.1595352154104; 
 Tue, 21 Jul 2020 10:22:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p17sm2731906qkj.69.2020.07.21.10.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 10:22:33 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix warning in navi10_ih.c
Date: Tue, 21 Jul 2020 13:22:24 -0400
Message-Id: <20200721172224.570061-1-alexander.deucher@amd.com>
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

declarations after statements.  Trivial.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f16909989c0d..350f1bf063c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -58,11 +58,13 @@ static void
 force_update_wptr_for_self_int(struct amdgpu_device *adev,
 			       u32 threshold, u32 timeout, bool enabled)
 {
+	u32 ih_cntl, ih_rb_cntl;
+
 	if (adev->asic_type < CHIP_SIENNA_CICHLID)
 		return;
 
-	u32 ih_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
-	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+	ih_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
+	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 
 	ih_cntl = REG_SET_FIELD(ih_cntl, IH_CNTL2,
 				SELF_IV_FORCE_WPTR_UPDATE_TIMEOUT, timeout);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
