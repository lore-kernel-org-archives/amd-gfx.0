Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1135C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772E920657
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihit5e8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772E920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2565E6E369;
	Tue, 19 May 2020 15:44:49 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A056E362
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 15:44:48 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id g20so6700324qvb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nlFHWArWoqOK3CumI5M6Tbe9Nk7KAOuK8vFgZUTAgwg=;
 b=ihit5e8b/aUQNQfXnBBonpgShvCXICuIbZxZ23ios22f+Ibt5RAxzr33ZpSKZf8CKd
 g64m755nx4LZhJVBEUzQvrouUhTRq5B/hbXs95+pGrjyHnvYYdwt375o4ekhhhhYOBtf
 6XZWEgTOggc8NJ+oFjXZWM3jT/Zok2xs1FAuynANTiPKSmErDbkb6EM6LpFUSAKdPAUV
 H/i7cl+G9JPpB64ukYfAgCUx2SpZxTO6SsaZ57BDhqQacQ4WePUUDA1I7taXblbDR3NH
 wlYTU96VUOlnm2ci1ZI8iFTlJFUlzLgNVBVtUXbRtcrvyYe2js/7b7ZumsuLc7NkUERf
 yIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nlFHWArWoqOK3CumI5M6Tbe9Nk7KAOuK8vFgZUTAgwg=;
 b=PcrqI/rgS1Y8CR/AiZ9nSN45eZ5gqobMtx5k1t/bt6KuFAu9WX1YE5hWQEKkrjh77N
 0PMcAsDaeEygt/PmgyRqYeMd/l8WwY0aqbDClwe/JUxtQEU+7cnHHU0g67EdZDee8jJd
 l/pKQmleymCbpvW6Obfy/1WZeX2SDJJVMLdRdst7wQVFMUdIH3DYgAg7l+n3UK1s9Fqh
 yE+bqJYWuXoGJz3Q4AT6jC74XCsO8VqYxx7Xp7v3Zr682A3bWOEY0ZWErC5V1OXdrKKh
 gcn7AHWGJhBPesFhS49Ymo3LDDNv+FjCbMpkPENdunKzZHyVEiuDPBEv295BTN2wNfyz
 p7NA==
X-Gm-Message-State: AOAM5323vmJpW0pDse+OdaylZTxRkPhUN2LVtvBdZ+BOSFjII5ZGKYGc
 Hyff6BnbPAHP271tJ5Z3O94HFmmp
X-Google-Smtp-Source: ABdhPJxSl4i4zKPodMRN97Em9Fh2D5yAxDnJaXPBuYQd7nHSl/nACbUO6RDLUHVtyqef3cou3f2PLw==
X-Received: by 2002:a0c:ed21:: with SMTP id u1mr184080qvq.206.1589903085970;
 Tue, 19 May 2020 08:44:45 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id l133sm10819975qke.105.2020.05.19.08.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:44:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu/sdma4: simplify the logic around powering up
 sdma
Date: Tue, 19 May 2020 11:44:25 -0400
Message-Id: <20200519154426.1752937-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519154426.1752937-1-alexander.deucher@amd.com>
References: <20200519154426.1752937-1-alexander.deucher@amd.com>
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

Just check if it's an APU.  The checks for the ppfuncs are
pointless because if we don't have them we can't power up
sdma anyway so we shouldn't even be in this code in the first
place.  I'm not sure about the in_gpu_reset check.  This
probably needs to be double checked.  The fini logic doesn't
match the init logic however with that in_gpu_reset check
in place which seems odd.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Can someone test this on renoir?

 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8545018747d6..4b47a267cbe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1913,9 +1913,7 @@ static int sdma_v4_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if ((adev->asic_type == CHIP_RAVEN && adev->powerplay.pp_funcs &&
-			adev->powerplay.pp_funcs->set_powergating_by_smu) ||
-			(adev->asic_type == CHIP_RENOIR && !adev->in_gpu_reset))
+	if (adev->flags & AMD_IS_APU)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
 
 	if (!amdgpu_sriov_vf(adev))
@@ -1942,9 +1940,7 @@ static int sdma_v4_0_hw_fini(void *handle)
 	sdma_v4_0_ctx_switch_enable(adev, false);
 	sdma_v4_0_enable(adev, false);
 
-	if ((adev->asic_type == CHIP_RAVEN && adev->powerplay.pp_funcs
-			&& adev->powerplay.pp_funcs->set_powergating_by_smu) ||
-			adev->asic_type == CHIP_RENOIR)
+	if (adev->flags & AMD_IS_APU)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true);
 
 	return 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
