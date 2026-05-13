Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02305CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871C010EF43;
	Wed, 13 May 2026 16:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RF4GEvjN";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C8910EF5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:30:52 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so62595725e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689851; x=1779294651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjyM8Fhw5HJm6g0/bDmujdKm3OZbrMwhTn3i3zaT8wc=;
 b=RF4GEvjNjvXq0syH6NxpN+ESdEcnwo6UvcUdyC+0ZhaeWobqlj8xh6L43n2JQAPNOD
 ROAhE88KC5jTopBEeP86jb49a0nKjtRzGO+e4r10mQqrW1hmx3PRhix87eZ+ZiRZvDsm
 wi98zS8GhVJWg0yZCTTj4Nb2Fnr7TKtCK1r6N/0k+dEL6DslIx05gg+4orEriYzTWGk7
 3UKpM9M+XT3CDPa/pWKJtTtPE1WZZoIyjIhVU+JoXCWE9QJpETOAhswyXiAWwz1qtqYN
 zuEdXdiJhTWJHJ6R3wuA4lEQKGxqXEjsex2icBfylXjv5RRl1g+ylvAT16+FXXaXroSP
 H3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689851; x=1779294651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bjyM8Fhw5HJm6g0/bDmujdKm3OZbrMwhTn3i3zaT8wc=;
 b=ioq9q6cQ9wttsL/UZXd/oj7c70PBl/zEp4u5VSDdF+B1KzdDqPbb66HKjV1fnoC71I
 rykX9g7ZzjAHJK+S2JvBTiwKbdKmYW5L8wHnwN6laxiCeUpRR63cZ0eY+/KEU9C6lvNz
 n/2XT0WMF/dZCKtRmYjYJz1qJlsuANMFLeXw6uIX2/714PKk2JCMmO1F8Svz5L6M6Dp1
 JdILeqzsnOqNlSY+3dtMs7T3XHyvVI8zlq21NPPDD+xLjQO+b+1PoXf73qmrijWe8zAL
 alyQE3ujgGTLRLPP/1D8nmejNx89MvkUtXtPJsX5/L+j4oIfeBBO17lxSxRkit3LL1bh
 72Bw==
X-Gm-Message-State: AOJu0YyJohlZ1IJIdc3q2qzctej6k3gVIy6Lef0xwiovFg0n1ZrO/++M
 FzQ7PoIcoZaVRRBqBECKDm58D9230IXcFT1pFIJF1Wrmdhpp2M4hTaHZ+CVyBQ==
X-Gm-Gg: Acq92OHkJXjQPLqW+mUBxcT8V8w5VDOu1trkW09nP+tRekEdIcJ/HO6XlHFnBtkHHJ9
 +70R5x2D984qlbj2ZEJs9fkWLG9Q/03UY0XLBZUlsWNPt3ldjG/ZzkiJLXfFVXJK8NpWq0JDfPJ
 AfLf70AvPSn03TPdXI/PYUOocOL//raPL6gl6DdOuep5QN5kFY1kwLYZFm5zX2/fqcbdS9GlBK6
 WtvjcSvmfPnCY6e/elORVOU1A4bHbaesl55CBBLkfUjbvtQNe+9zfLvgf1GVhXgVk8PvOZLkmH9
 AEXVjjSbQ/JlpNuYn7U235wCP+ACO/TyDDY4WTv9VBmzhYdTUwpYpsXdSl6JwfUSzjtRmGNM0jh
 /0gptP2GjwlZjgOxZo0vOvQhzlYx0+Kh1gG48t71qInGfrtV1LVJLqfUNfPagiJJN6MeLU+hqzt
 3Eudfo5mVtbxM49aYE2KC56Sooiwa8MJ30PJ0sBKYeB0SuX95sLetAN+i/amtDdXsiBEvE
X-Received: by 2002:a05:600c:c84:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-48fce9eac86mr55961785e9.13.1778689851286; 
 Wed, 13 May 2026 09:30:51 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64b5271sm1846385e9.14.2026.05.13.09.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:30:50 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/6] drm/amdgpu/ih: Add retry_cam_ack IH function pointer
Date: Wed, 13 May 2026 18:30:42 +0200
Message-ID: <20260513163043.8725-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513163043.8725-1-timur.kristof@gmail.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
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

Instead of writing the doorbell in amdgpu_gmc_handle_retry_fault()
directly, add an IH function pointer which can be defined in
a different way for different IH versions.

This is to allow implementing the filter CAM without a doorbell.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 8 +++++++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 52258f1341c2..d790b7619ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -565,7 +565,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 
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
index 6de9e87e04e1..c2431f4c2671 100644
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
@@ -858,6 +863,7 @@ static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
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

