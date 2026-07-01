Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B12DC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC9210EFBB;
	Wed,  1 Jul 2026 16:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FzDl5nR3";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5610D10EECD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:38 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b779003fso4406135e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922657; x=1783527457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZE2UZVOPJaHEAj/nXdanqxLIJuDuJCfXvCWuwEFSTU=;
 b=FzDl5nR3DzXJhMcLwxLxORNcAOIgC/RSp6vIZkYEfhEpZFoX2kOgZfkM+eOuXPbPFu
 kxjSF7WfeBRDrQ8CeD7ChkphK/6Z6G1lw1yl5Ty7a1OKD/9KrorXCIPMkA+9//amqdVK
 5k2VTNowpiE9PZWobTnrC38/QA9udgfdcubHFSuysH3hed/ASMVIUviPMsU7KAfIJL8Q
 F/+I14VQcRcANuR21cepRhzISYoSrW944tsP9TgK7CbDXthr94sWlrtT2DTb/Hhg3oMn
 /S/vQeeI938CFMyDvH+Gaz9kblRsVw8t6p8E22UKVTV3py88mcsmkYd8BVsUhGhYlRdv
 JABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922657; x=1783527457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ZE2UZVOPJaHEAj/nXdanqxLIJuDuJCfXvCWuwEFSTU=;
 b=LeXU5Lda2Gg22QCWTmIYlQ6t9ia28vQ9GluxLFuWfmkZv6Z8BIc0p/THKk7qDkD3L0
 wap/52tqo9XztQpd/u4rokPUk6vr1qDLO6uRITnVl4Oqgk4hLipkZCR4wpSuL9LLBiZw
 B0jdyxAyU39S3mLlow0IdymIy86+zFqbrzF6AoVlb1bPRtK1DElo+qfnnTe/POaW+kME
 QTbpU70oqEtXyqL7zblUuSCzK1ySBevfkRht5fh7nx+Jh2+XQ+vYFC1o1nPF3HHkwAQp
 i3MRMeREHw0hJd0TilUpjl5A8G0O4YgSgJuAgnXPxz8Q9BR5ivGgPZPs0OlOWDHMr/fR
 ta2g==
X-Gm-Message-State: AOJu0YyjGlCiyOBYB4GXZ20LYIF07nUr1wmw3itT0/0cRFmt4ziN/hI0
 Z5imm55zbUEOurAHlZuDSVXqDqCB/fn3M5PLwbfUf30GzrW4DadDh/URMJWvdZVl
X-Gm-Gg: AfdE7ckqQSjGYdySrYoAZlb9WuVnebJ2qse79hU00yd0m3tMKV48XW6eS4gDANoJqQE
 Rvtqv1/inZF/MxeoFQJSoZgVm9IX+P78UeuLs0//Zb7kY+WXu3DMYkyr5vGYRX1foSYYbzOnr/X
 YOSgBij4kALJi/+nk0q68F46HjOzbhK9sUPKAy6O4SUzQv8XrjfkmuOc51kIq6ZTz9qtoR52m/N
 +0sy0kTbkkvsMv2i4VV+zwXGHFA97yXCNrAv5re0k+RN4HI1Je92uPQQsBkYOEYXQDCQKyD50M4
 i9uiZeSOfGLq2xOcIZtI9+N7maiDfJ403Kl50EvcCyns1jRRohTn2jKgayhUDEHCN+4Q9D8hiqa
 fau6pfKq3YwZ6sYyXuymZuvJNdqDvpV+LdTRMiekc3FRooTLUOkDk4vXRx8NM802Sb7l8hb9oVX
 /3Gvc85QF/HqlcY+/Je9NX5NLgWBo=
X-Received: by 2002:a7b:c00f:0:b0:492:4911:8a with SMTP id
 5b1f17b1804b1-493c2b4b173mr29880685e9.12.1782922656719; 
 Wed, 01 Jul 2026 09:17:36 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/14] drm/amdgpu/ih: Add retry_cam_ack IH function pointer
Date: Wed,  1 Jul 2026 18:17:11 +0200
Message-ID: <20260701161721.85681-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional changes.

This is a refactor to allow different filter CAM implementation
in subsequent commits. The actual new implementations are
going to be in subsequent commits.

Instead of writing the doorbell in amdgpu_gmc_handle_retry_fault()
directly, add an IH function pointer which can be defined in
a different way for different IH versions.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 8 +++++++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3f0b1b7a557b..bb278a61dc9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -552,6 +552,11 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 	int ret;
 
 	if (adev->irq.retry_cam_enabled) {
+		if (!adev->irq.ih_funcs->retry_cam_ack) {
+			dev_warn(adev->dev, "retry CAM is enabled, but retry_cam_ack is NULL\n");
+			return -EOPNOTSUPP;
+		}
+
 		/* Delegate it to a different ring if the hardware hasn't
 		 * already done it.
 		 */
@@ -562,7 +567,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 
 		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
 					     addr, entry->timestamp, write_fault);
-		WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
 		if (ret)
 			return 1;
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 444437c30088..e6e34f6e86f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -97,6 +97,7 @@ struct amdgpu_ih_funcs {
 	const char *(*node_id_to_die_name)(struct amdgpu_device *adev,
 					   unsigned int node_id,
 					   char *buf, size_t size);
+	void (*retry_cam_ack)(struct amdgpu_device *adev, u32 cam_index);
 };
 
 #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index bd332e8cc5bf..24be9d726428 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -289,6 +289,11 @@ static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
 	return val;
 }
 
+static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
+{
+	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+}
+
 #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
 #define regIH_RING1_CLIENT_CFG_INDEX_V7_1_BASE_IDX    0
 #define regIH_RING1_CLIENT_CFG_DATA_V7_1              0x123
@@ -865,6 +870,7 @@ static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
 	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = ih_v7_0_set_rptr,
 	.node_id_to_die_name = ih_v7_0_node_id_to_die_name,
+	.retry_cam_ack = ih_v7_0_retry_cam_ack,
 };
 
 static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 85846fd08ce4..30a82fff3ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -293,6 +293,11 @@ static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
 	return val;
 }
 
+static void vega20_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
+{
+	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+}
+
 /**
  * vega20_ih_irq_init - init and enable the interrupt ring
  *
@@ -738,7 +743,8 @@ static const struct amdgpu_ih_funcs vega20_ih_funcs = {
 	.get_wptr = vega20_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
 	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
-	.set_rptr = vega20_ih_set_rptr
+	.set_rptr = vega20_ih_set_rptr,
+	.retry_cam_ack = vega20_retry_cam_ack,
 };
 
 static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev)
-- 
2.54.0

