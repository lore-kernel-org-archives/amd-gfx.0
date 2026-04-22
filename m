Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D2F94CDE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E49D10E977;
	Wed, 22 Apr 2026 08:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="QBR98L3M";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBDC10E947
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 00:40:35 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso1476075c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776818435; x=1777423235; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYXYxrbWc/WjXDWZfhsiF8HOxov43e74zyHDtduTo5A=;
 b=QBR98L3MxlzE+YLb3LfXDjojR4xcmMujnGBityEp4k+1VwfqcPVCrkr5GwQqAMA2qc
 QIjmwMmJ9VS5oNCyoARMTaTFhOfo8wANf+2uZzzdxTcbCkdLfHsn/F0uJzOnCRE1R+yW
 vRCQG/jQkPcvXYw82bwDY8FVPhApaKeVLkcuyuvianEJSsfo6+yTOidYrkFRVRhrcPDc
 o1Y8B/Z7HKU6gxmV5TSOYBnwYTTrM33QrD7H2qKwqnqLe7Ekksc2KwCDFuZHX70mYHO9
 ESxBhQRLiA9LZ00df6DNpclP2B3HFsupRgqzfyZQr5paypczAoiVq3IbWgRYJ+4raLO1
 Xa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818435; x=1777423235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wYXYxrbWc/WjXDWZfhsiF8HOxov43e74zyHDtduTo5A=;
 b=msyrwASf0BHZxhGsZtla5klQFiSKN+FqokXy+wDt29mUSc6UAwXEpAgr/3OTtI3xHs
 ZJ/gtSXjN7nxCgP3J3Rf9xoAp7Te/28k4jmMaK1LBmAwQwCBxM7q4TPf2beGMj2+8HjI
 4Uf7a0F0mWOjPSKiftR0bhsjRizV9RiVbIpNnCfweMx5P9h5nuP3F2hyI7AT18iHc0oH
 XqMM1aUZ1YcVlVc6MDzZqtWlPkDtdYSaGqspQGlVeSD2A3YS2XH3SlGNNq9lz0yqjL1N
 Hr9lQHPCbrwNyW+KhRYE4L8QDBU+/LBAog27Nuwyym0972NEIeePYNsteyq/Grfp4GgD
 Hwkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96udHoV/blrP4qekS8cEJJXl3wSm1pQINmt099gFZVhLj41emshLJqUc173A2K355Mw2odGEcR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypHhFjTNrATgK6TeLoC9i6MLVHdt/D5OBpYbdT+yBUagS3pSyH
 3NAPu5Ty4cCK25PD2NWM3dh/S8P7v5jeMJ2tcc7DOSUIQAFxpZBKn/+RfJRh7kaFQu/2vDstQS1
 +goSJ9WfDiQ==
X-Gm-Gg: AeBDietL3gyGi3gMnLLTkAa/fKdmiIBx5zRGMgQANVo+8R7IBVkkuFbFHjQBn/vrgkO
 hOii8+OPpe3eLYE0E9WuLrKSxulPi6s/CP2C/fDSS7Mqm2Nq3GPt6cGNS8ioK6czFZQYhEZW4Dy
 FjtTqBakLTMnFmG3TvgCB7KgavfEyb361ZDSCCvzxc/PMytLcm9Jqet5kDVAADz3KYxI7d2Gi+c
 nntR4mlXVDoiFHqQBUI42ZUqCg1i2jkLLEUWDXrbASVNHGXsKLNlsbXsP/PZs9usfRicNTbMl9G
 JLFE3NmATeSV7mpm8haanhMfwl70Y5WA5ltgfXtZlt34+vCOrIuwCFEm3ElrfxaJnFkDZCHQIrV
 K+MZ/16GLaE494FCFrfmaaCc1DZERNTKELBgG7EyYOUnfl4NH7GCsuWq6rQz27OHILcTn0W+3dm
 T3YgD49pUBzkxTMENBGNMbFpfyujAPIa/zMkAVEWDfFSSCgzS+GbyMRvUAel4AIpyXKEISx/1M/
 ySW1bGTwwY41hrxnjo=
X-Received: by 2002:a05:7022:6289:b0:12c:6ec9:3f1 with SMTP id
 a92af1059eb24-12c73b4b076mr8692913c88.21.1776818435088; 
 Tue, 21 Apr 2026 17:40:35 -0700 (PDT)
Received: from voyager.. ([191.251.25.148]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbaab165bsm552462c88.6.2026.04.21.17.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:40:34 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt
Date: Tue, 21 Apr 2026 21:38:45 -0300
Message-ID: <20260422003911.33841-3-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422003911.33841-1-tiagodourado@usp.br>
References: <20260422003911.33841-1-tiagodourado@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:27:32 +0000
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

