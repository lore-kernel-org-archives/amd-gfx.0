Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346B6CDE01E
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B6810F4B1;
	Fri, 26 Jun 2026 07:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="FawCGcFn";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DCB10F3F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 03:00:28 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-137335bc3caso1050912c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442827; x=1783047627; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtS/kmZ/uTxQKqZxPH1/+2V/jDxVEHNoVXNcZX4R18E=;
 b=FawCGcFnUpkRyOQ9sfHk6fTaRtmRqD2o6ZBFMsYVUAf5vCJqRyygyQV+FtyMCYckt1
 Nc5+on/MpbvNVABqjGae6a3j1hRyvZxqDO/Knpk7upz3xxU1EBrN5DLW5dAhM1v80hAG
 LRqDx44Ha8bxMTveQQ0ZNtM/ubK03hzcQbFCH52nTYxATzW9z1iw4m9Bht7m8sKYSQo0
 59QwWRcAJqiV5ot2cEPzThO/lpRh6xRwlp/aCMWMyukU2v76dUDDD2RBnbgYW5joZ6Uh
 syglF/kCvUJe5jC4dZe5BimxkXNaUNgw7OProRxg6CENv+PEMdbc5mA/jfWSeRkJWREh
 CkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442827; x=1783047627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JtS/kmZ/uTxQKqZxPH1/+2V/jDxVEHNoVXNcZX4R18E=;
 b=rlOTzdixJ7VTJzH9NRLEaAmBrqIka9v685wrMZOKTSGiEzDRulqzHKIOwYFc7jn1mo
 mOQHckOv5NivhGm7JRD930vaxckI5MqTB4NohYEh/jQBIWrzfX/aDDjyGCdPoAVRqn/F
 BINBpKA7GE1V1ql6qPFeWBRPbxCNyu7aAj6aCZQe9iGYeffuu9pNAqKBWnhAD/yoqsFW
 q8TRo46mu5+7pQfv8eihUKsI/HoATsUkXWcXlovajX1hew+2eQ5mJ9sYpYTtRAXtqbPe
 FvF1Mq0Au8ANvxrTixKc1yCz6YJlku2SJYJSkmLd273aN2LQLoDWQiF3pzeeQU0//1FD
 C60w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oO3HFN1KUiW8o/6gN0ZIXvJYOFgxWQs4c4AzRjDbefo4z0rdI6v88bT/QtJTKj478Sa/SCNQq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9SjPngkYRG2SI7ce1VK1cW8fePteteRHbksq3he9wJ+0qc1ub
 xHJCY1BHnuc0V68mh/HcM95fw9uHltnVseheWIXrEwqibmiMFgJJmjVbjtSJMfuQbYk=
X-Gm-Gg: AfdE7clk4a2/ZZqSFE6TFDO6IqKZvJTb2Fe8+ElLey+CIHI18SO9L307lp6ZAY6Zslw
 QhZ6RxjNaVSWiuY/0SIaMfQtbBQHrOM4sAjGwEnDXJ955oK4Kze8eHVMev1Y6sRMrsUAV7ZC6HH
 O/MdmdhaHd/nIhINF7RKGl9nqde46JYEM28HaMaFUch4PMtyaZzLr5bNWZLDay/r/tV7yu70mhy
 b9bq5n7i6gLCBcMrDPQIdUVlJqcc1dZI51BksFlHBen1OdNc/Sj+hq4h0KWkmFfUCBIBqTuHD+S
 1qLsYjj7uZXRpACeSArucVkGqDOfJFc9084kgBLdDy7hnC/+NWCb1hrQRi0d6vsCSreIeNjT5gy
 VFFu/FQ5uyQCTu4j1d6OEQdFC1OeLqniFrz8YDCj7Dw+CeLlNnQubaVKanUWrLWL4qE++tThu0K
 eN+SAJJHBr9OdgcRoMcDhcsdd37ty6GcFlzilyV9va0yiOpiFXyj91BRcpyp83tPgQ2iNEWg==
X-Received: by 2002:a05:7022:2585:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-139dbac8341mr4161859c88.21.1782442827217; 
 Thu, 25 Jun 2026 20:00:27 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm13048415c88.6.2026.06.25.20.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:00:26 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch
Cc: Tiago Dourado <tiagodourado@usp.br>,
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0
 process_interrupt
Date: Thu, 25 Jun 2026 23:59:13 -0300
Message-ID: <20260626030013.20569-3-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626030013.20569-1-tiagodourado@usp.br>
References: <20260626030013.20569-1-tiagodourado@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:54:04 +0000
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

The jpeg_v5_3_0_process_interrupt function is identical to
jpeg_v5_0_0_process_interrupt. Remove the duplicate implementation
in jpeg_v5_3_0 and assign the jpeg_v5_0_0 version directly to the irq_funcs struct.
Export jpeg_v5_0_0_process_interrupt through jpeg_v5_0_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---

v2:
- Assigned function directly to irq_funcs instead of using a macro.

 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 ++--------------------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 46bf15dce..4575d1f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -625,7 +625,7 @@ static int jpeg_v5_0_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
index 5abb96159..4eeb0c147 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
@@ -32,4 +32,8 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
 
+int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry);
+
 #endif /* __JPEG_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 1821dced9..a67c6e916 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -32,6 +32,7 @@
 #include "vcn/vcn_5_3_0_offset.h"
 #include "vcn/vcn_5_3_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "jpeg_v5_0_0.h"
 #include "jpeg_v5_3_0.h"
 
 static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
@@ -608,25 +609,6 @@ static int jpeg_v5_3_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	DRM_DEBUG("IH: JPEG TRAP\n");
-
-	switch (entry->src_id) {
-	case VCN_5_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
-		break;
-	default:
-		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
-
 static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
@@ -696,7 +678,7 @@ static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_3_0_irq_funcs = {
 	.set = jpeg_v5_3_0_set_interrupt_state,
-	.process = jpeg_v5_3_0_process_interrupt,
+	.process = jpeg_v5_0_0_process_interrupt,
 };
 
 static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev)
-- 
2.43.0

