Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEBACD5BD5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A70B10E2B3;
	Mon, 25 May 2026 11:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yk5pQ5l0";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EED10E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:15 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso45706645e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709514; x=1780314314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjyM8Fhw5HJm6g0/bDmujdKm3OZbrMwhTn3i3zaT8wc=;
 b=Yk5pQ5l06c1xlQyZKQeBBqjLLbJePlv0pYhlTKPFJT/PO/+Wljv7UgAROAkwOQ07cS
 ZO3q3kwsIv5rXHY+FoZWUeUyptkZ+cSezm4eFhVfDLPiHXhVZ8yYZkDtU2Dz01FwctSr
 tJf3KhsrHf7MtDthm25StKa2yBomUG8S1qes2kK8VWLfGgOUGXmwtzueBoIhfopDOa+I
 lXwe95tDmhHClGTYP4dbE8fuBkq/gmBAqUVWmftD2J5JhoGDVP0QOUy5ZUC3afdD58UL
 xzk7RRha7mNMBV+zrQ/nJVi2Hve9+SfGikAy8ZkF12ItXxgyNKuDgJhHdOS1horDPXnf
 1dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709514; x=1780314314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bjyM8Fhw5HJm6g0/bDmujdKm3OZbrMwhTn3i3zaT8wc=;
 b=cl4N0itm4WCAl+QNmc6xe6uvTLBZxVFfvM/F9nBZ97SwG1ySO4giPUggJm4oDDTfCE
 muGpQEnvIQ/rB8H+UnbV4hTz0YbFUWru3wJuJNYE0Jl99j7rJaQX8k0Jc9TPua3Wqhsf
 jjqN3oxwrojSxH7FO0Pwq8la6kWFtVeWFSUzNBTu5+z0QyFKCjknChC5/0lQAiTpO6wr
 Fcz17jgBVS6IxISw3Ux8BU10lw4Ud5ks8Sd01pCy5rT4LQJOJuFwgGjQTijYTXLkBReG
 5aozu1sH5EHbajeL8cra8vhEOkxssIshfDStKzrhE5GEWSySuF3cFNr86j5ycxc+m3FN
 ZCBg==
X-Gm-Message-State: AOJu0Yy2Up1eqgJvi+qApZJEYzIJglq/WwF+bya3qxA/jqsRsYJ8BBql
 CqwsAynefEZU+K0JshTo0tXKN5qgp5d06o7e3e9ZRtJkpjGznPlzyRX1LMyHTA==
X-Gm-Gg: Acq92OGVl+dvStQ01D7wkNKdjtnNG1fPrEApKopemJwqSZ67gHg/C6DEDu/x+aEt2uJ
 WB4UcPyRamq2giOyY/DrjqESIRmRhGUpZ5m826s8qRhcryjVfe3kYQts2fsg2WEDyfym6CEIrBU
 D66+kBKB3YDFOvbWZb3bFZP69qvjNN97p/S9CygjKzCtRJCSq/c/WSt6ywA7mHbXSyvc7mfJscZ
 mxnYDP6bV5fFmGRFeO8CcHFeN8UJ0iIP1QcQTZcEuMsf5i6h2q+nIo8iCN50Blg6DIWMkqPb92E
 tniKn9AtvypA3/O7Dtwq0SM8jZgKFwK86SBv9mfiEEZ/6su0VwUNh8J/hSDMfDPHtS+lWv+/XIo
 VMg1ah5EEuUt+KkKQh+BnLI1PL6m15Z8Oxrt+w0+uEPA1eo70xIhLa7UjUqO6L6RFY+QeD+RTEo
 kOPgQDYJ7mUpu7KRN02IBYKbQPnP3ZzMvGk12CWQTxSUUjy41gtVU9l9dmrnfPnmOm44dPTHHQK
 Qfa8Kg1EADeoQ==
X-Received: by 2002:a05:600c:474a:b0:490:51e2:d992 with SMTP id
 5b1f17b1804b1-49051e2daa6mr167532315e9.13.1779709513522; 
 Mon, 25 May 2026 04:45:13 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:13 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/7] drm/amdgpu/ih: Add retry_cam_ack IH function pointer
Date: Mon, 25 May 2026 13:45:04 +0200
Message-ID: <20260525114507.24566-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525114507.24566-1-timur.kristof@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
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

