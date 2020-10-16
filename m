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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 14:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB3A20848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6JAN38I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB3A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF57C6EE1B;
	Fri, 16 Oct 2020 14:20:13 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947CB6EE1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 14:20:12 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id i22so2031419qkn.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4mTlku+2K4ZWfqhAJBg9ZiDD0+YDeYFyG2jqe4N2/24=;
 b=T6JAN38IPrxljMXsgi0Wxh7IYjfiIDkCv0yohfuZvpW38TNt0iWvLBH8sLglwoCdNT
 8vt1pBE431HHPeUSKiG2ahwUtGtm26QkYNPKiHSG7OcBx1KvLPSEzJFHDBaS+sUni6dI
 8zF3UqKLxEx6owUL340GknRr8JyLklEOfOXop+Ke4px53oEmuXSRYWCI4MPJbd3iDBtZ
 6V1TZshEjySQGF69sFZr1iacLDcWohBKUSxUkw4ltwuh0LfwJ6SJ/jTiN6su2zWyNmpc
 be8Dxi0ZfdG0s+QnGgOWrdEwPlF4RbzEkziMCm5904Bo89PQ7i2M0LUt5qmbSnPdNaJG
 flQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4mTlku+2K4ZWfqhAJBg9ZiDD0+YDeYFyG2jqe4N2/24=;
 b=OwD3WBIMwgVgRJox3JUp2xnxleavlfytodhxdGdJM8iWusDX7E8bBcZ+tRORbjrBtQ
 TRqqqdBWkct1rohBEM6sDtKNAn6ce9aCofajV6pghVOciglH8FVezBVE83iQPL1wYX1F
 mEXuGkyNEXzOdhTk/rlRUF8AoR9wCurEBUiPrd7Z56aBH26GdE/zchXGY42X6P8RYBbD
 LvIS8BOod+4/sXFU3lOxYYKqIYYo1JsBVNe9Qd7+xU35Vif0oVPYzsfgUPbRD+6PtD8y
 Z1Fp4QHXfTCy5JqzZTIib9dXz28Fif2XKU86qGzqG8KZFk6/plpzvutWV1K1oS7t/kLL
 OplA==
X-Gm-Message-State: AOAM531P32c71UeynzH/748WOAg1IMD7lXuS+t9+Bf+qx5kAs7hO5o8N
 tAE+8FHKKjXlaslPnRwFxcF58EhMeXc=
X-Google-Smtp-Source: ABdhPJzHOCJU7ZQuELD4iTmeYcfJF9qsfb4CQeS4MGedSdhTCIqbRd0Nm3a2/OMRdryKWY/hA2N6qw==
X-Received: by 2002:ae9:eb97:: with SMTP id b145mr4204690qkg.60.1602858011376; 
 Fri, 16 Oct 2020 07:20:11 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j92sm1050542qtd.1.2020.10.16.07.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 07:20:10 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: move amdgpu_num_kcq handling to a helper
Date: Fri, 16 Oct 2020 10:20:03 -0400
Message-Id: <20201016142003.1095354-1-alexander.deucher@amd.com>
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

Add a helper so we can set per asic default values. Also,
the module parameter is currently clamped to 8, but clamp it
per asic just in case some asics have different limits in the
future. Enable the option on gfx6,7 as well for consistency.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  3 ++-
 8 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index abddcd9dab3d..fb9e61f861e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1374,13 +1374,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	amdgpu_gmc_tmz_set(adev);
 
-	if (amdgpu_num_kcq == -1) {
-		amdgpu_num_kcq = 8;
-	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
-		amdgpu_num_kcq = 8;
-		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
-	}
-
 	amdgpu_gmc_noretry_set(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8c9bacfdbc30..e584f48f3b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -804,3 +804,14 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 failed_kiq_write:
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
+
+int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
+{
+	if (amdgpu_num_kcq == -1) {
+		return 8;
+	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
+		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
+		return 8;
+	}
+	return amdgpu_num_kcq;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 190753930b11..786eb4aa7314 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -393,4 +393,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 669c352c27af..b4df472194af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7406,7 +7406,8 @@ static int gfx_v10_0_early_init(void *handle)
 		break;
 	}
 
-	adev->gfx.num_compute_rings = amdgpu_num_kcq;
+	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+					  AMDGPU_MAX_COMPUTE_RINGS);
 
 	gfx_v10_0_set_kiq_pm4_funcs(adev);
 	gfx_v10_0_set_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 79c52c7a02e3..671c46ebeced 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3064,7 +3064,8 @@ static int gfx_v6_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->gfx.num_gfx_rings = GFX6_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = GFX6_NUM_COMPUTE_RINGS;
+	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+					  GFX6_NUM_COMPUTE_RINGS);
 	adev->gfx.funcs = &gfx_v6_0_gfx_funcs;
 	adev->gfx.rlc.funcs = &gfx_v6_0_rlc_funcs;
 	gfx_v6_0_set_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 04eaf3a8fddb..cb07bc21dcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4238,7 +4238,8 @@ static int gfx_v7_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->gfx.num_gfx_rings = GFX7_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+					  AMDGPU_MAX_COMPUTE_RINGS);
 	adev->gfx.funcs = &gfx_v7_0_gfx_funcs;
 	adev->gfx.rlc.funcs = &gfx_v7_0_rlc_funcs;
 	gfx_v7_0_set_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 94b7e0531d09..6487ea3cfdd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5295,7 +5295,8 @@ static int gfx_v8_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = amdgpu_num_kcq;
+	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+					  AMDGPU_MAX_COMPUTE_RINGS);
 	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
 	gfx_v8_0_set_ring_funcs(adev);
 	gfx_v8_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2c3224948ea5..d3df4c0441a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4635,7 +4635,8 @@ static int gfx_v9_0_early_init(void *handle)
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = amdgpu_num_kcq;
+	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+					  AMDGPU_MAX_COMPUTE_RINGS);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
