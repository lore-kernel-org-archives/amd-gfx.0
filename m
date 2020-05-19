Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C92C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304EA20657
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqNn5CE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304EA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854F06E353;
	Tue, 19 May 2020 15:44:44 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F546E353
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 15:44:43 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id b6so15672351qkh.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tKklphGaurvdo5wDKsk7MDFvdV2AucX2Z9dXvTTxj2I=;
 b=VqNn5CE24sKzuigbyIoPNxPXYYMSjC9LM4W+JMhNJxAYSVyNXXKeq2M4WWUEyZfkpy
 9RPyKmjNBTEkNq08b++Uj+xHTa1g5svED8RzReGVlwfqzgUwxr2AnUkKIDm71x+VrF1x
 0+90Z2KRAnD04ofaTfsaiQXFZXEQZKzrQsunJI3sWlzVUjla/ZLppMOKdqXkV61KJtgq
 1ySMSXTVsHQAkT3EYh9MA7xYvMF9Ze13t03iEuLQDQUBbc/t31tpX2S2kTQso439TWCD
 5zy0C2d7I3IcoF7wsEfpzMiclJYQuW/TSXlEVeE/c6MYkZQDRN3fNSmJpFFBEKMj8PTW
 0qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tKklphGaurvdo5wDKsk7MDFvdV2AucX2Z9dXvTTxj2I=;
 b=mvg3iN+5aco1HwTyV7rnZQjsmSd33E8sGGOS+cEb91mI+M8wDvP1fsw4ZEwnh7P79U
 7MOI3HTsAYTEBlYM9NEdhP+0XqPvQUP8XuoBR38DCPiKxSKuXtx/E/aTq+P7Oaw3HSCa
 WHTv1LBO9q8j8FtcuxxqHhgopNoWQOH3502B+5RdiLEb7AJKhvcCF9xfyjokZLIcYssA
 LkkyX4XImxC6RVdt71RN8/Q/uXr40qZ8sub27HaoEfyLDIZbnXzwBPjMYRnnXrn5l7GK
 lhknxq8k6qEzaQFlNQmKdqsyf8gNGqmnYEq3/oxYFBYvG49jfNvAuTwK5du3eSC59df9
 7D+A==
X-Gm-Message-State: AOAM533uUoefaULV6GhE30fAFR+0fBrnvAtv2CFdXaHoZGBmCjGubN7z
 uo9Xptix1B5WC+t8pPAEvSoq3QbD
X-Google-Smtp-Source: ABdhPJxNZZ6/z1OmMc8kZnGPbYjS47gaW937zm/S5N0JUSTz9gWb9wUD0QvKl4cl74CKCd0le4IN6Q==
X-Received: by 2002:a37:e30f:: with SMTP id y15mr11182508qki.249.1589903082624; 
 Tue, 19 May 2020 08:44:42 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id l133sm10819975qke.105.2020.05.19.08.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:44:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: simplify raven and renoir checks
Date: Tue, 19 May 2020 11:44:22 -0400
Message-Id: <20200519154426.1752937-3-alexander.deucher@amd.com>
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

Just check for APU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a027a8f7b281..e036c868e354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1742,8 +1742,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case CHIP_RAVEN:
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
-		if (adev->asic_type == CHIP_RAVEN ||
-		    adev->asic_type == CHIP_RENOIR)
+		if (adev->flags & AMD_IS_APU)
 			adev->family = AMDGPU_FAMILY_RV;
 		else
 			adev->family = AMDGPU_FAMILY_AI;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 711e9dd19705..22943773ae31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1890,7 +1890,7 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->asic_type == CHIP_RAVEN || adev->asic_type == CHIP_RENOIR) {
+	if (adev->flags & AMD_IS_APU) {
 		/* TODO: double check the cp_table_size for RV */
 		adev->gfx.rlc.cp_table_size = ALIGN(96 * 5 * 4, 2048) + (64 * 1024); /* JT + GDS */
 		r = amdgpu_gfx_rlc_init_cpt(adev);
@@ -2384,7 +2384,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 
 	gfx_v9_0_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
-	if (adev->asic_type == CHIP_RAVEN || adev->asic_type == CHIP_RENOIR) {
+	if (adev->flags & AMD_IS_APU) {
 		amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
 				&adev->gfx.rlc.cp_table_gpu_addr,
 				(void **)&adev->gfx.rlc.cp_table_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a8cad03b1c42..8545018747d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1775,7 +1775,7 @@ static int sdma_v4_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	if (adev->asic_type == CHIP_RAVEN || adev->asic_type == CHIP_RENOIR)
+	if (adev->flags & AMD_IS_APU)
 		adev->sdma.num_instances = 1;
 	else if (adev->asic_type == CHIP_ARCTURUS)
 		adev->sdma.num_instances = 8;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
