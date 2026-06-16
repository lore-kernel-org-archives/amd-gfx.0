Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BEBCD98E6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1610710EB83;
	Tue, 16 Jun 2026 12:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RaE+nkUP";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DD310E7B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 02:12:45 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-59e23d70dfaso1775047e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 19:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781575965; x=1782180765; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYXYxrbWc/WjXDWZfhsiF8HOxov43e74zyHDtduTo5A=;
 b=RaE+nkUPhynZYuxF5p4KximJlcULixiwo3sDsWspTQd1oWKBkiRtuS3we/PVBZrhho
 Hb3pt+yA2N6JTpByWb7AZgPkO6iuqQM4dwf9m0t5gzNp9YkAGO4U7xsbo7kTXD9euGF+
 yMd1onXPOuemlJCPIbfXBUcbSf4zryvbleO+OTA7c7ATmWJsF53Tiq3uKSi1L1O9w7C7
 LfkRZu+/JIijYgfBDFjulGq4SBucqNqkEBt1hCm977twiUQqMHBWyz96Z9jtWR8uuUCo
 G9TxsyLxqevJ+jJ2B9/f5hfgY8kGEYgUddVyWnB0ft8bTvRGTk2fgFbCXFpiqDxWS0nn
 dR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575965; x=1782180765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wYXYxrbWc/WjXDWZfhsiF8HOxov43e74zyHDtduTo5A=;
 b=k/umSQTkTHWQ/GaHaMMhZ8vlpHaW+saorr5qE10ALt1VL3Ivu0pcraPGoIIT2j9uVG
 uMTTU0qVXWaYQW6xesaWAkox27/AkewR8CzoQduPOpPyNLMZbZO6VSGI6quXOkHMHHsm
 qbEyTASn6wWgI22cT9l9eKovA4JageePxmvOonnjYkGBNwGkSMZM5annQopbFaE4xJEV
 z4YsW3lGdxSsE74yYMpZtM7kaU5qTk+LjMItI7q4ha1FiDPeDgVycwMEyztjedovIUQ8
 NxCpseKpE03xHU6p1Y4xNxA+UPCoT+WNNw/iD/CHQoafcJ8Bcl5PBQC3ZYkKW6PjyR1a
 IHGA==
X-Gm-Message-State: AOJu0YyStfRPgezYkEUFgtf7H2wSt+GWxZc96ZyVl4EgUy/Qxackm1qT
 0gN+81c96gKWk6OTeRGAiB5b0NzK6jDJ6U3LnfMDoN2LRl39ZkhNj30/zqg686OYueM3peUyrxK
 kugPS
X-Gm-Gg: Acq92OHUR9N2x8FE3ZM5eHZo3/pCLRtFsxM+dagxDyTo7a/Aq2Fw1Ft2SvqHJXgyg73
 ygFHBCwpcnNQG2xWx2gNvCmEE/X9qlDpCcdgmZikPsSv+UgjmnEgimRA/XcThrJY2uHlV0d8YZw
 cWLlllznOirnp6tCsPlNUkC0h9o+YZkduLMAdKsUOWASx1gdwqX2WphyQp/Qp7gQq03kZbwtF5h
 k/7hywx9VVzZVBTf3oHN4aQ9ghdIyqud3ACRAUkXTSxF36IgEU/Dj4enk15A7gzn60/kxpoDnPW
 QrMpJ17RwmiNRwxKcBRCUbReaDypCyyHVztmZFaueQXdeOaPr1IcupTsSCxjczXbDlV80GzedJt
 TiTEdUMWrc22ATm+6rTo1opIjYsPF9QecXZy4qlN3ktszq/Z7Wac4M1T5p1/MbaCdWUuezCNABN
 TpS9URJfLJjxSXVLRuuAlyttxRosxE1eLPDK0BQEYUHFk9PLedp1ARyLmStLEcyXwF1E/nCf+GT
 iaLTZVSWUrmywtPyg==
X-Received: by 2002:a05:6122:3d03:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5bb6c01105bmr8345774e0c.1.1781575964854; 
 Mon, 15 Jun 2026 19:12:44 -0700 (PDT)
Received: from voyager.. ([179.119.39.86]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb900138e8sm5514855e0c.6.2026.06.15.19.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 19:12:44 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org
Cc: luiz.f.f.fernandes@usp.br,
	Tiago Dourado <tiagodourado@usp.br>
Subject: [PATCH RESEND 2/2] drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0
 process_interrupt
Date: Mon, 15 Jun 2026 23:08:31 -0300
Message-ID: <20260616020942.18980-3-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616020942.18980-1-tiagodourado@usp.br>
References: <20260616020942.18980-1-tiagodourado@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 12:49:33 +0000
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
in jpeg_v5_3_0 and reuse the jpeg_v5_0_0 version via a macro alias.
Export jpeg_v5_0_0_process_interrupt through jpeg_v5_0_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 +++-------------------
 3 files changed, 8 insertions(+), 20 deletions(-)

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
index 1821dced9..92aaf5dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -32,8 +32,11 @@
 #include "vcn/vcn_5_3_0_offset.h"
 #include "vcn/vcn_5_3_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "jpeg_v5_0_0.h"
 #include "jpeg_v5_3_0.h"
 
+#define jpeg_v5_3_0_process_interrupt jpeg_v5_0_0_process_interrupt
+
 static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -608,25 +611,6 @@ static int jpeg_v5_3_0_set_interrupt_state(struct amdgpu_device *adev,
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
-- 
2.43.0

