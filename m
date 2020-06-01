Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A521C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728B12073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMS2v61q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728B12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374646E2E4;
	Mon,  1 Jun 2020 18:21:09 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC66C6E2E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:07 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id c14so8975271qka.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=157IVVdma3xiqz0hLF00RnrFBmiPEXSmyRr3oklL18I=;
 b=QMS2v61qZW2gHLmgDiS1xlz4euTEGaAnatP6oh5fLdaiFpGUWArLHiOiF7MjS5ebU1
 fOczn/IR4RsC8oMIkAKqIWclsSZHK1FqOA5bAs0JOCZ/KJh/tu8Ujg6aubO/DtKv/gwQ
 dGEJAyIeVzuIGyNmqIp8KjXLW/Kbny5FnW+gVvzWFlCiNgYGcEGB7V+eJeQeSxMZUYjD
 VcW5rFxBORgeDHO9+3qhJb/ajQcLneaw/X8njwSkSJ/ZhMjEt86S9Pwd602Agan81fCx
 vQg2LzVoWUU/l7ONE/4qCg8GDBkYuiGSgLVVqgaH0hyfXsPeRGwgJukb0c/cvzfsQybx
 KNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=157IVVdma3xiqz0hLF00RnrFBmiPEXSmyRr3oklL18I=;
 b=axMm25EMG/u/6JbCoYgMt6iX9BKZ6gXa4UsFSBZ9Scigj3eMHHn492q7g7RP7nzQas
 9uTh+5whwvHHx8cc5QP9YgczRnvma2wEgC/aTr2f/qtgYYJj8DUe7UGP8yf0+olSD/bt
 Eiz1NhSWNpFzo24JqUsBPVYo1RylOcCrtqupqmu8nkdkbtRXzjcD5wAGZmceO1HimgK/
 +oyUN1wa7ydGGui9JPxbBgxw+t+QN00SE1xA6SIYbaQt/7rrnG/iPhAm18Zk0HE/yi96
 dxE0mjxUEhn6Aot55MZfFk2XA2qKdpNRWvLvkYL4z/PkQJyCKITKXvtpAgsSDtGipc+d
 XO7A==
X-Gm-Message-State: AOAM5305IH/qNDrHHYRv3yJMfSV+i/rZ33K9jdNFfPCiVuCXhVegOo9n
 T+N/UXytXgqVrhBSAdZ6wdISgTgU
X-Google-Smtp-Source: ABdhPJy/bRFf5it4llTwM9a9VMUoWJ9GqpCI1VVocbkzpiJH9jc6bQuHOaWwSUpYJZa6S5mQKD8lAQ==
X-Received: by 2002:a37:ec4:: with SMTP id 187mr19265794qko.124.1591035666881; 
 Mon, 01 Jun 2020 11:21:06 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 092/207] drm/amdgpu: force pa_sc_tile_steering_override to 0
 for gfx10.3
Date: Mon,  1 Jun 2020 14:18:59 -0400
Message-Id: <20200601182054.1267858-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

pa_sc_tile_steering_override is only programmable for
gfx10.0/10.1/10.2

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 750f2ff9ed9f..66d7ae456768 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -95,7 +95,6 @@
 #define CP_RB_DOORBELL_RANGE_LOWER__DOORBELL_RANGE_LOWER_Sienna_Cichlid_MASK	0x00000FFCL
 #define CP_RB_DOORBELL_RANGE_LOWER__DOORBELL_RANGE_LOWER_Sienna_Cichlid__SHIFT	0x2
 #define CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_Sienna_Cichlid_MASK	0x00000FFCL
-#define PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_Sienna_Cichlid_MASK	0x00300000L
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
 
@@ -4468,6 +4467,11 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 	uint32_t num_packer_per_sc;
 	uint32_t pa_sc_tile_steering_override;
 
+	/* for ASICs that integrates GFX v10.3
+	 * pa_sc_tile_steering_override should be set to 0 */
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		return 0;
+
 	/* init num_sc */
 	num_sc = adev->gfx.config.max_shader_engines * adev->gfx.config.max_sh_per_se *
 			adev->gfx.config.num_sc_per_sh;
@@ -4485,18 +4489,9 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 	pa_sc_tile_steering_override |=
 		(order_base_2(num_rb_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_RB_PER_SC__SHIFT) &
 		PA_SC_TILE_STEERING_OVERRIDE__NUM_RB_PER_SC_MASK;
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-		pa_sc_tile_steering_override |=
-			(order_base_2(num_packer_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC__SHIFT) &
-			PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_Sienna_Cichlid_MASK;
-		break;
-	default:
-		pa_sc_tile_steering_override |=
-			(order_base_2(num_packer_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC__SHIFT) &
-			PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_MASK;
-		break;
-	}
+	pa_sc_tile_steering_override |=
+		(order_base_2(num_packer_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC__SHIFT) &
+		PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_MASK;
 
 	return pa_sc_tile_steering_override;
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
