Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C010C47420
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BB72399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwW8LQnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BB72399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DF06ED6F;
	Fri, 25 Sep 2020 20:11:25 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B946ED65
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:21 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id h1so2033683qvo.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5DMjdDdy9MWbNC8Uyo+udb2bGv0LTTxGFYyF/FADlnc=;
 b=CwW8LQnXPLHkMFwY/5hGs0zQazLQK4HX9vv+b46368VHxFv1wX51vjNgFH++JgIzoM
 8T8ypDzt8UZuPTe5nYlsdt/yJZJGgeLQwj1k6NaiH42WZd772D/iImMBL9CBb3yOs05/
 lJTbOavhsDT6Jxuum7DsnyBNWtN+xJuVhVSAKCG2VRilANR/CgUc9WX9/S301afLGS0Q
 kRlfyT35tj5D1NHqbvFEhJSmwSim9E0v/He2dcl8SRS/qwLOO6yPZPlNw/HeIaplZhUH
 Z5cjD1Z2iDMRTYDCCo4IrRQaFelosgRTtG1EOI4huJf90EY3EImRVQdHVV2vUkeWbu84
 2neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5DMjdDdy9MWbNC8Uyo+udb2bGv0LTTxGFYyF/FADlnc=;
 b=EjF1eHqN0mPuiRgO3Haw0hbrOwsixxJGSy7C8KT0ioI6/0HnOqGEu92GMndRc9MurF
 9pH/VwJmoN5A8bQCGbMIaNxIdbtvWuOlrcsZ7OaRpqkET+ldH8WKzuJoYeKNoB44L59/
 sWKNhqg5sJRP+jP8sZB6Srk2k/6h8MyvsYJiOJduS96o1jaVM28UbQtqyrz+eQAAVqoq
 HXl1yLQ/71tfeGoQIywwKV+Ra9n3wp97CKeLmCN2vsAZiaf9ZLH0cuOrQhygyrBUYYer
 RbdIg5SAYPaQB6J2Am44/1YaDcKO1n1pEjywV/hqgs+3/tG/bHC+rxIQkYaFfFqNv5nS
 WIbQ==
X-Gm-Message-State: AOAM5334cqz32CgW7eNS5Q4rBBtqiy+sS7vXJCBTxrK92hyMwr20NAX3
 D+TKLXwRy5fQKowDgDu7cryFN2hVOUk=
X-Google-Smtp-Source: ABdhPJwVjSwIRb3gofhcjnMPeHckQKY4c354E36bioc2NvLAngkfEl1/D7AIosJbZoSHlj0HLoW93A==
X-Received: by 2002:ad4:57a7:: with SMTP id g7mr381161qvx.10.1601064680762;
 Fri, 25 Sep 2020 13:11:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/45] drm/amdgpu: add sdma support for van gogh
Date: Fri, 25 Sep 2020 16:10:03 -0400
Message-Id: <20200925201029.1738724-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch adds the sdma v5.2 support for van gogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 9f3952723c63..100d0a921ede 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -47,6 +47,8 @@
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sdma.bin");
 
+MODULE_FIRMWARE("amdgpu/vangogh_sdma.bin");
+
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA3_REG_OFFSET 0x400
 #define SDMA0_HYP_DEC_REG_START 0x5880
@@ -87,6 +89,7 @@ static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		break;
 	default:
 		break;
@@ -160,6 +163,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 		chip_name = "navy_flounder";
 		break;
+	case CHIP_VANGOGH:
+		chip_name = "vangogh";
+		break;
 	default:
 		BUG();
 	}
@@ -1171,6 +1177,9 @@ static int sdma_v5_2_early_init(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 		adev->sdma.num_instances = 2;
 		break;
+	case CHIP_VANGOGH:
+		adev->sdma.num_instances = 1;
+		break;
 	default:
 		break;
 	}
@@ -1567,6 +1576,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE ? true : false);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
