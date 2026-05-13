Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB1FCD4F25
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCA610F033;
	Wed, 13 May 2026 20:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRsJHo80";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDFC10F033
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:22 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so4462264f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702661; x=1779307461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3gbNF7v9L3Rq+drCGCrG3mePKBrkNEpG87ukve6V2k=;
 b=eRsJHo80pwY1SHYMXqhHCtBjt55ygw0xrG1LWkvHvr3d+LGB7xIT0KScw0rFWNZe2p
 oo6iItG6Ky5WY0FaziGjXb/bDODLT0glRtKRSnJZhVGw5pgP2nqL7oabvvXo7MirRsYX
 2AevGdi3RnDbRxvsfJGIU9huggv1vMGFMLn6NXs3whxQNzFnFIh7yLw5KDKtDbNAw9Bm
 xuJwp+QmaHjCIhcJ9LlGzLMQ2zcJ/GB1k6+T6dSV93GqvvUo4LpOCzsr1KeBGMqbtNq3
 Ex+goxh1baJQamoee3M9ejY0ACBHDxeh8iC2W3wGPYUS9MRiKovEEL3K2SWRZIzsDL6j
 VmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702661; x=1779307461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h3gbNF7v9L3Rq+drCGCrG3mePKBrkNEpG87ukve6V2k=;
 b=CTpDeLMVTzdfENKHcL96mSE4u6shaI1pRFKXJ1t4+s39o0je0N7ncyM9b+XnKTx/JY
 Z/DzHi7EJ6ELDursmHHZqb38YEmJrFrDrz4JLB3ctVlu9RihNdQvWlHhXZYszDm1N2ci
 fP/BL6pkJ8d1FK+Nm6j/X5DUnwqIDs7Avxc6y2t3r7gQTHVCmMrR1FCnhtPXa2QJHrei
 O7wsZZOAOBK67Zgq0rWiWwweCRLJXGG8UX4R/0MMiF9ALmQZur19ykwGWcwA56yDpx6W
 JQOyXfP0c7bVjKwjVfLICSdJTt7s7sU/6vwQfAkmsVCyaw3xFKzqIKj3g3gC3VMmxejF
 Le4w==
X-Gm-Message-State: AOJu0Yx2u427mDrlH9TZkY6Upjg3Ic1U1hIp7aAyebCB1tIDNkY6p7GQ
 5cTgQRQNMo4V/y93UU3GvldxoW6dRpM0mHz8IJ/oOQroK45XiFnyeTxhsKe7UA==
X-Gm-Gg: Acq92OHJISCKCPm4TcHOxstrBTb5LSl9djkhzNvBxTuX2cS+xImGyl6nVsUF9gL340Z
 k7HI5adXGUkDJK8WGchMQgMBtfCM81MGfHS4YGBaEK0WmURKK6bhoEMCHLG7ahRXOTs7/V9x62/
 eDiQVO3mDoWWEyIDNiAT663yh3xblIhky7fxHRhdMNXfYhMjd7pyatkvWrkQjXgrfXOYdu4Fxkf
 zYgoKfYLtexSpeyZ+RXXxs5iPACPELC7M3pq0Xky5LTdh5dwGzh8UKoVSWbz3/9NGcxgmcz1DHu
 zPW0PjfBijtoGXxhwLsuT2QFrXldq3Jqkn/a01hIiMYwkgNKfLx27KP0V/6CjILEQSeeNWIAznr
 bwC7hj6MDxv89M+WEgilNTJwtEXmu34KvD+9Dqjldx3ux6RfvfEr2IU+9DS+ggLYoh1dryJO2iF
 W07WILUC1GaltmR1PB7fbM1zC5yP1RVMpJra1v0AAl/NVgeOdg3qjCJfiy6Zv/M1b42H7zujoeK
 UU=
X-Received: by 2002:a05:6000:4404:b0:448:908a:398b with SMTP id
 ffacd0b85a97d-45d9288b8c2mr967653f8f.14.1778702660808; 
 Wed, 13 May 2026 13:04:20 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/9] drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
Date: Wed, 13 May 2026 22:04:09 +0200
Message-ID: <20260513200416.35631-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513200416.35631-1-timur.kristof@gmail.com>
References: <20260513200416.35631-1-timur.kristof@gmail.com>
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

When ensuring the low 32-bit address, make sure it is
less than 128 MiB, otherwise the VCE seems to fail to initialize.
This seems to be an undocumented limitation of the firmware
validation mechanism. Note that in case of VCE1 the BAR
address is zero and we can't change it also due to the
firmware validator.

When programming the mmVCE_VCPU_CACHE_OFFSETn registers,
don't AND them with a mask. This is incorrect because
the register mask is actually 0x0fffffff and useless because
we already ensure the addresses are below the limit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 5b7b46d242c6..edabec442cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -313,17 +313,17 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
 
 	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
 	size = VCE_V1_0_FW_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
 	offset += size;
 	size = VCE_V1_0_STACK_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
 
 	offset += size;
 	size = VCE_V1_0_DATA_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
 
 	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
@@ -527,11 +527,15 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  * To accomodate that, we put GART to the LOW address range
  * and reserve some GART pages where we map the VCPU BO,
  * so that it gets a 32-bit address.
+ *
+ * The BAR address is zero and we can't change it
+ * due to the firmware validation mechanism.
+ * It seems that it fails to initialize if the address is >= 128 MiB.
  */
 static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 {
 	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
-	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
+	u64 max_vcpu_bo_addr = 0x07ffffff - bo_size;
 	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
 	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
 	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
-- 
2.54.0

