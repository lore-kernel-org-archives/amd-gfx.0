Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90828C4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28315206BE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvC54t2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28315206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A168B6E95A;
	Wed,  7 Oct 2020 16:32:14 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D906E959
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:12 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id y7so107696qvn.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IpsvDR5R072tOE6t3n5XNhOYx/qhaGa+AyaP0k8SzKc=;
 b=PvC54t2De9oVU5yvH9PeNKY0a06jdSSfu7fYCUjvDHjqRWTwI1XmsaiVbKNErQhg0h
 bB8+oBXIVDUVthWqtZKPSxYGSgqsKqBnlcvVsR3NHix/TK6UH7jxKv069u0NKN6X+nnr
 GJIRMnPzrb2S0vHhWgzW5fJwVkNElDTcaY5hnb83MhqcpFwEnC02FLlMJQMSVhtwNoAA
 Ftx/UFJYGcwi5OYvt/Pq7yhcpAPKOVt5DRGf9vqR+cKCaL2jelOUrmDyWpSVxA+ULiSr
 GJaQbMjP4au5bI1zbJf1a79t7/rn0NjLTi3mdbrQFeGuV9TdEfUL9jp5woEpUqUMImHV
 foYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IpsvDR5R072tOE6t3n5XNhOYx/qhaGa+AyaP0k8SzKc=;
 b=Af9YDF51iXbkQQ462JHvODvw7sugaAvXGR1gsWQf2XjiJtanhfCeZqGz638SufE0qM
 vLfs7jkH8CNE/oisoU4qHoLUCREt/sacgf9/M7j08g1cyhdLUJDf5KDZ/HmuE0WBY+kh
 HmtmWFWJlQRqtOT82kTlZ67t7eoZ2VxfSflgzbLQN6ApdipP460ry6nj49k0shdy87vh
 VfswbrV/L8v9VZNsTz6KyOFIjFlV3mIJpN7YcdNLAxBGtQEOAtgshRA/AwJe7Ou6vhf0
 vCTxh0D0oEDcuoY4+Mz7iN7D4UbGX/5Jx/Tfa/SZv3xlpiJ1zlwEsCeIA/IP7RDoiIw/
 mY8A==
X-Gm-Message-State: AOAM532cGXbIuyN25dg79FYmwGrtFU2D9QgYRP03WZDCvFBF8jS7ujgX
 MKA+IdC0c57HZHkfIZ63qhg2KX8rGIs=
X-Google-Smtp-Source: ABdhPJxrB9I8jUH9xFpU+QzrAAd3d9tR/Dsmdw+KGPJWO9wWzeKyrN9xzMNslg0Xn/qXPxaRBnIdbQ==
X-Received: by 2002:a05:6214:146e:: with SMTP id
 c14mr4010184qvy.22.1602088331649; 
 Wed, 07 Oct 2020 09:32:11 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/50] drm/amdgpu: add sdma ip block for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:00 -0400
Message-Id: <20201007163135.1944186-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable sdma block for dimgrey_cavefish, same as sienna_cichlid.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 573c16f2c537..2974f45c4571 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -631,6 +631,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 100d0a921ede..18eca0d4dbcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -46,6 +46,7 @@
 
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sdma.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sdma.bin");
 
 MODULE_FIRMWARE("amdgpu/vangogh_sdma.bin");
 
@@ -90,6 +91,7 @@ static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		break;
 	default:
 		break;
@@ -166,6 +168,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		chip_name = "vangogh";
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		chip_name = "dimgrey_cavefish";
+		break;
 	default:
 		BUG();
 	}
@@ -181,8 +186,8 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	for (i = 1; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-		    adev->asic_type == CHIP_NAVY_FLOUNDER) {
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+		    adev->asic_type <= CHIP_DIMGREY_CAVEFISH) {
 			memcpy((void*)&adev->sdma.instance[i],
 			       (void*)&adev->sdma.instance[0],
 			       sizeof(struct amdgpu_sdma_instance));
@@ -1175,6 +1180,7 @@ static int sdma_v5_2_early_init(void *handle)
 		adev->sdma.num_instances = 4;
 		break;
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->sdma.num_instances = 2;
 		break;
 	case CHIP_VANGOGH:
@@ -1577,6 +1583,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE ? true : false);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
