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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C9FC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F312073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agVGAaWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F312073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096776E32E;
	Mon,  1 Jun 2020 18:22:01 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0D46E32F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:59 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 205so10021388qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0b/IlMagmHvqQBQu4gqsN6sTQ37q0dDYbwbRxkkwUn8=;
 b=agVGAaWazux9aahgDknjJazVniAEbCqe70UBeBy0YQsGwDmwSfCK4Ogbv0gOc7uDEu
 PdXSl9FSNV3iOBmuEg9MJMUavaaQu0Fe/Kmgt3X5rnaAu213Vz5nrttZGl0+kt7uPPD0
 figaPWvSqL7CylM02W9jhKplcG+shdgC/ePaccoa6NrnvZvUFR8HhQLwD0Hdkfclivai
 P+7aqPi7e3RQH4Ibbe+6TjlTiZGyLAL8NnVpb5PFVg9mP2f/+XqIx6Ux5JCbXl4zCw/t
 xXkO92NADSU+0F5je03pjuvFEGzUfSfn0UdE0uAC03DKxgTWoAOQ7FgJRtiTDMa+aiLQ
 32RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0b/IlMagmHvqQBQu4gqsN6sTQ37q0dDYbwbRxkkwUn8=;
 b=S+NG8eYhr5j2vnqzUz1cASr1FQoYs4fO0VK25HajIp6Kmrqp+Wek1AifJdol6w/+GK
 IBKw0ShiiVTL32745toV7s8jqmQEC+LDCVf0nLyX+IPTgts103xfztjoVF3LoWWI1rMd
 BkY5yj6XYsOypkR2191RbIjVgIAWgkPKv5ev/Q7xGI/hHbkYzEPlpnpehijYQpMxe6XY
 P0JepuZY7UVnn2mzRJoEy4QNr322w9aHUwB6HsL/+tUHHZljpATfhwepIMZt4GR5oBUY
 iIxW3LSBt8x+Sb+oV/5ZJMGs0rJhgZLvMSp0W8+nEeE7jGgmfdm5e8aCdEJZlZwRc8Fo
 g8GA==
X-Gm-Message-State: AOAM531m5m87PV7sIweiBgtrMjCCg8ha4mPROoQi9Z0gat8z2g5FYcOJ
 uF114szR9q4QjOQ/Rglq5q6zddF1
X-Google-Smtp-Source: ABdhPJy7cKQ5S/Pjhlyc4HG5NBcav9d21/l/PFqhHyBjQyMaHykT2xqfv6a+4Cefx+stXfvVmlIrFQ==
X-Received: by 2002:a37:8a42:: with SMTP id m63mr20773650qkd.230.1591035718477; 
 Mon, 01 Jun 2020 11:21:58 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:58 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 131/207] drm/amdgpu/mes: allocate memory slots for hw resource
 setting
Date: Mon,  1 Jun 2020 14:19:38 -0400
Message-Id: <20200601182054.1267858-42-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Pass a piece of memory to MES ucode to fill contents.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 6ba0c04f7fb5..5c28868f7adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -562,6 +562,35 @@ static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int mes_v10_1_allocate_mem_slots(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) mes sch_ctx_offs wb alloc failed\n", r);
+		return r;
+	}
+	adev->mes.sch_ctx_gpu_addr =
+		adev->wb.gpu_addr + (adev->mes.sch_ctx_offs * 4);
+	adev->mes.sch_ctx_ptr =
+		(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs];
+
+	r = amdgpu_device_wb_get(adev, &adev->mes.query_status_fence_offs);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) query_status_fence_offs wb alloc failed\n", r);
+		return r;
+	}
+	adev->mes.query_status_fence_gpu_addr =
+		adev->wb.gpu_addr + (adev->mes.query_status_fence_offs * 4);
+	adev->mes.query_status_fence_ptr =
+		(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs];
+
+	return 0;
+}
+
 static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -876,6 +905,10 @@ static int mes_v10_1_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = mes_v10_1_allocate_mem_slots(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -883,6 +916,9 @@ static int mes_v10_1_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
+	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
+
 	kfree(adev->mes.mqd_backup);
 
 	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
