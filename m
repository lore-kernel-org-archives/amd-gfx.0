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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CEC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3155215A4
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di0AqrWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3155215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935F26E2B2;
	Mon,  1 Jun 2020 18:04:16 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE57F6E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:15 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q8so9924993qkm.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OwTe9JvUSk5v3eiqKY3CNmQu/y65Ok6pLX+34ncY1Vs=;
 b=Di0AqrWrFrT36RpgWMmIYl2/RrMDQiYZd9C6b7F7CXzRlte0CN0ejYr27RMes8WuC8
 czdwm8TrKA2dOjkGdi++Af8I9AnC70ueMY/dC25uE21UcUNBLHwsXm+RV4ckiKBjREja
 pkIXSnfyTAk8YDvySTdBrWfO9jrWNT8F4Pt+wlf2I3z8Fl1C9V5CU8lGLQw1tAL8lcsJ
 B+8L9eN+3uGcmChkx+xNCSCtSld5D6maPg5AesiC0CKBGlLdbQxIXo7TAQHcldLj9Fd8
 +60pd8srO5DeRtL5cgb9gC4KsGRAzn7XsoyqPYeFTKzGf4R4J62h2woxilwGHgDVj+rp
 om8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OwTe9JvUSk5v3eiqKY3CNmQu/y65Ok6pLX+34ncY1Vs=;
 b=Vs5Yz9XxWdHKsnLrQRYRHgpvZfidRxhgoPhmD+uPsiZBj+vII+54ltip5q7pBfVvZ5
 knxEMDRyNDX/XNGVlZN7o3j3aclB5dOg3lSN+EFjKQDdQ582mh+UD4y/+Fq11rCW6/Tg
 U8KxuGYd0EFc86AsL1q9ypVKitQmn7uty4cGR76LxMffUqUYPjFN0vHMStEcurWRv4nC
 zp/i/vDkqMb3K3ZZpWLzzwLffARiG6OZntd97RfElrdXHWYSJKxoq2gokV3AqmCuZp6v
 TlYlBgrT2HHkc2/hUqZimH+xmqKyaYc/OfSeljQzkmoZCgbhcXKEvWEv8h7X0EPR429F
 ks/g==
X-Gm-Message-State: AOAM533BgH5tRGKTdfnAd6a1cNey2KmiN5uP9/V7qO1T6ZP7dWjoVsNa
 baL7eMVEFmOm89IyP0unTgRBfJpt
X-Google-Smtp-Source: ABdhPJyYnrhZ2UnDVk6gAY+BQYjxdN33JqFWCPrQfhtqw2aARLM+AUcn4vSCJNzqXm8AhPbD9ajkJA==
X-Received: by 2002:a37:b14:: with SMTP id 20mr21161866qkl.401.1591034654793; 
 Mon, 01 Jun 2020 11:04:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 062/207] drm/amdgpu/mes10.1: allocate mqd buffer
Date: Mon,  1 Jun 2020 14:00:14 -0400
Message-Id: <20200601180239.1267430-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Allocate mqd buffer preparing for mes queue setup.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 80f6812d8ecf..ace82c477f01 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -28,6 +28,7 @@
 #include "nv.h"
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "v10_structs.h"
 
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 
@@ -375,6 +376,32 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
+{
+	int r, mqd_size = sizeof(struct v10_compute_mqd);
+	struct amdgpu_ring *ring = &adev->mes.ring;
+
+	if (ring->mqd_obj)
+		return 0;
+
+	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
+				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
+	if (r) {
+		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+		return r;
+	}
+
+	/* prepare MQD backup */
+	adev->mes.mqd_backup = kmalloc(mqd_size, GFP_KERNEL);
+	if (!adev->mes.mqd_backup)
+		dev_warn(adev->dev,
+			 "no memory to create MQD backup for ring %s\n",
+			 ring->name);
+
+	return 0;
+}
+
 static int mes_v10_1_sw_init(void *handle)
 {
 	int r;
@@ -390,6 +417,10 @@ static int mes_v10_1_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = mes_v10_1_mqd_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -397,6 +428,12 @@ static int mes_v10_1_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	kfree(adev->mes.mqd_backup);
+
+	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
+			      &adev->mes.ring.mqd_gpu_addr,
+			      &adev->mes.ring.mqd_ptr);
+
 	amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj,
 			      &adev->mes.eop_gpu_addr,
 			      NULL);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
