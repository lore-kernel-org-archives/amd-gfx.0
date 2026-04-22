Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E2F9B5E4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9C810E985;
	Wed, 22 Apr 2026 08:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="woRjzRCe";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA29F10E947
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 00:40:30 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c565476d7so11317338c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776818430; x=1777423230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi/anKo0gGqlfMkLrdymWNF41Yu2KeWLiH5QFrH1EaY=;
 b=woRjzRCe5cxc5Z3U1exLZlycnkLjMPXrq4F+qhL9HF7J3YBmmRw7z9+zK2HLj7A3cO
 gehCmg9TBRqYYRqf0B+17n+3Vh+Nr48l1na15tAntjlPVNnx+tm4mDLcXU1NFGNtltQZ
 7gr3+OvwG0/UWDjXQVGgG1LTaQrVn3/Bf1SYWwzp+NPIYvKQV+KgkyVezDuW1m/JoeJl
 UCnkyY+LsUxYRwRKsZhytshZgAIagqCFpZNRcvolFZXe/r+TkKUP8uUJE2QsyhTNfF7F
 YqzRQyUO/ZNdVUE37d8J5bdtlz7pzKLmCs8oFNUy9MauFQzVs+PEveQ7J2wyv3wxYJWG
 snVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818430; x=1777423230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vi/anKo0gGqlfMkLrdymWNF41Yu2KeWLiH5QFrH1EaY=;
 b=kaalceQ5gY9SEivt0p7ByGQ1ogRvTEhH/zWgZWtsBnRO/2+xGJB71nmJ5/bO/Yb9PM
 yF7N6dggHrG1HeF0e7Ra3xxAKl9AwCFimnUYew5wOAgBM6hJNHE9XpPeD5hcE8CHZZLd
 eZZ8CZ4I4tR7sRzT8sfI3MPREgMkZzY0Zxqee16Xd+HySlY9WuwEoOsIcou/721ApdbF
 c0pH1luQ23r65dXqSu59gwLI9M+kOKi3GsTGwXhKGDMzhTw8h1Nrs2tYPHgue/Yq4b3r
 +MJFdXnStY2YppYVDXbAhTWjp7D3068FB4o44ylrahAMa/alnuKDP38FUc6REVmGPzSz
 4RDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DEeaJmIGA4uSRF5KQMrG8NIs4j77KzFFaTC2LZ9AwJ5jGNHBWFZFoJgsuiFthxuxuevsT6P+G@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4jr9HpT5d58Gsr8rwv7/Im15G9dmd/b03I683vd6J4W/CmUs3
 H5ZMp4vQKncMjWwkiAG4rc/wNL5em4bB69dbWIZ4Tlbc1y5EG9x+70XAllZ13jNk6vA=
X-Gm-Gg: AeBDievb1Y0CcIkalsw2Oi7g+oyFJPmmLjfBBXZu1YlT4EkjNZwTGTxriwikCx62dta
 05phtr7EHbBMmweXU671W4eCWEP9lnwQEgqqCmNEy2mGxWDPJDMc7QBwSzmaQ+1TczxEzylgl1V
 yTwaA/EG1lUvRQVLMUM1qT0Lh6cG9Pm00R9Sdle16THk5kHMNbdF6TSU4hk18AWfvifkY82OvC1
 zYQAahT0rP1SdSH03RCQrFAmbFUbX5y3r7pXI6MbPCjQwgFVYCcU9BrsPZqgs2hV8rulzbTY8Uk
 g0ErfVqnCnCViROGQyYH5qiMinnlhhCq8ynMy5IYcffsuqJ94YDPCIurExQXq9lCu4z6eZuuqKV
 VZeU8p8H81mDYc4rRdtymzA7ktDIZJYZHcn3RJ09C5jg+TJ7aqN9HANqfC0bhl7BTyV4DDu1n1x
 G5CqwuHTggxr5l9JJPkbWuPTMoJVLfd14UoMq959psxiFI7z8T8TKMPGpd8e8H073EeCPlkg9PO
 8w0yITkInCWmXYCkJM=
X-Received: by 2002:a05:7022:12b:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12c73f996d4mr11348980c88.18.1776818429938; 
 Tue, 21 Apr 2026 17:40:29 -0700 (PDT)
Received: from voyager.. ([191.251.25.148]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbaab165bsm552462c88.6.2026.04.21.17.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:40:29 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
Date: Tue, 21 Apr 2026 21:38:44 -0300
Message-ID: <20260422003911.33841-2-tiagodourado@usp.br>
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

The jpeg_v3_0_process_interrupt function is identical to
jpeg_v2_0_process_interrupt. Remove the duplicate implementation
in jpeg_v3_0 and reuse the jpeg_v2_0 version via a macro alias.
Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 ++-------------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab..9006fc57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83..4f400fb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
 
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry);
+
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
 #endif /* __JPEG_V2_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622..5010dafc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -34,6 +34,8 @@
 
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
 
+#define jpeg_v3_0_process_interrupt jpeg_v2_0_process_interrupt
+
 static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] = {
 	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
@@ -539,25 +541,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	DRM_DEBUG("IH: JPEG TRAP\n");
-
-	switch (entry->src_id) {
-	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
-		break;
-	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
-
 static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
-- 
2.43.0

