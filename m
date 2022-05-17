Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78339C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 06:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CB210F582;
	Tue, 17 May 2022 06:06:40 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7FC10F5E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 06:06:38 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id i24so15996423pfa.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=tiTNAflq/sWZM5anJmY8iPjw5SEK1Af/QotbH0SevvI=;
 b=hYdEiaj5d4oA4TfHhKydsWP84aGbTxN7JgxViUD4jwwoirDxrsnfgYOYMD8ws/30ke
 jf+RbPQ/DPD5gq0sxl8yTfDWu1UreIs0GjYd7mqblsXK5tD8Jwlz8oVWw9zz6Va4WSYB
 LBLM6tcNcCwQyGWI8ThekHnpa3f+r2rJ20HXUpR94xWwl+3LKP0gy1q1UdFKMw5nxR7u
 E2yHixAW2ZfJbxEo+R/L7daA3MlfwquFKp4FpPF39tvOUE/mR+FWC6/WPjaRab5Vm2it
 nctdXtZIwe8Us2v/kq2DBobcSq0qo0bNkbOAC+GB22hNuKkyIzuRPoTTPrSDJUjMrxNZ
 wGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tiTNAflq/sWZM5anJmY8iPjw5SEK1Af/QotbH0SevvI=;
 b=eF92U8ALn6VI4pjwTIs8khVvp8RGfDNZnql2kdE7tM22VRwbArVWhACYJHod5DBPI2
 Jmp7pe81dwMs0Xn8BLtiV0FZOnDDHKk4VK9zacmFi+LTFcIbEIb09aTwTQqF4cWUj0kI
 EtM4/EYm65cXZhDRgMvk6GBiNnB0yUenYXSd0Z1YWVfWqSkS0a8Vp51xXR5DUaEUfKnA
 fP2Nm/1Th9Z64c5/q3Leogn+OiGyrKJ8KAdA1YOsL0SybcdculGXyPGc/1k9IKLhD4TO
 EGKXWihUl0XarO1oPWgz/NjDJg4Sgujla6osKBiAU773WaRlxNJBAaF62i231OINbiSz
 Moew==
X-Gm-Message-State: AOAM532WHgZpyZeimxqKHh5dgwDe8mWma76YCm1oMWXb3BAdtcq1oEhF
 MO+vBAeL1+J/0xZoYsFvzYHUfpqODfoZ1J3VASc=
X-Google-Smtp-Source: ABdhPJxybkjbXdl0SMxrkZlH4P5eYATXpdTNz8vmsojZS0zFrtZjKXf07SP0cpty+PMF/UJk33NhPA==
X-Received: by 2002:a63:8949:0:b0:3db:2f3:d7bc with SMTP id
 v70-20020a638949000000b003db02f3d7bcmr18246926pgd.362.1652767597453; 
 Mon, 16 May 2022 23:06:37 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170902d88c00b0015e8d4eb1fasm8188860plz.68.2022.05.16.23.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 23:06:37 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Set CP_HQD_PQ_CONTROL_RPTR_BLOCK_SIZE correctly
 in gfx_v8-v11.
Date: Mon, 16 May 2022 23:06:35 -0700
Message-Id: <20220517060635.30481-1-ricetons@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: alexdeucher@gmail.com, ckoenig.leichtzumerken@gmail.com,
 Haohui Mai <ricetons@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haohui Mai <ricetons@gmail.com>

Remove the accidental shifts on the values of RPTR_BLOCK_SIZE in gfx_v8-v11.
The bug essentially always programs the corresponding fields to zero
instead of the correct value.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 12f63d6aab12..dd8f4344eeb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6898,7 +6898,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
+			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a1bec70c719..82c98e59a13e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4082,7 +4082,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
+			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 90f64219d291..fb9302910742 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4490,7 +4490,7 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-			((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
+			(order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f49a2dd89ee7..f12ae6e2359a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3514,7 +3514,7 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-			((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
+			(order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
-- 
2.25.1

