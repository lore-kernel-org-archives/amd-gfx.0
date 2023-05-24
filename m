Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A11FC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 15:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8874E10E226;
	Wed, 24 May 2023 15:25:15 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D323F10E226
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 15:25:13 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53eee18a192so390486a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684941913; x=1687533913;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clsLU15GLcIOQSvBcrogvQDw08garrGLWVkzeYz/uDY=;
 b=E+/BC4CAkdnIoLdlv8nl03nfngRBjJKkXSLe7oynmVh8HPexKV+2BCd2QaCVos7wbC
 12O6t0wOZJgY0UF//E14cimf4E5OqwVxwCfN5f8ZR1NyXQ6z8PWz1kbuHDKWa10BjGjm
 /6aZd9a88LF6JitKfy7iNBY8sxPGyLxB3sZp1WTwl/vuaq0JdZNXcmGMzDIbdjCNl027
 Ef3EP4s7hxI3iAEi+urjJHVhpEuhSjwQP5OSYp5KUQ3W26HUSeIXnyRAoAkMHMYyUJqz
 X/TWTtvQVgb3HJPK700F+GJkA2akvz9hp/jMdmPPGosDgQPrTY7TrRmwxdZ/Cw3lYUiv
 p63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684941913; x=1687533913;
 h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clsLU15GLcIOQSvBcrogvQDw08garrGLWVkzeYz/uDY=;
 b=hakkME4uCIZAk79sWmeXznAfKraEwgvnqRGzP3WF4X0T5V3tfsXmkP7vMQK7C0fFZ+
 jePuIbk6gPO0BhNEOdbeP8R6xroJYSSZt88jPsO5UtLsHBsVsKyhNPhmB0EcO542CqFl
 sn2EdJhnqbHdtaZuKM5CXZRPZ0LwZBIqPKN4cmnBvtQfcGB+HEhTW+Iz+25aqknPLgg9
 rfU9zrmbzSwlC/8Ld676pAnyiW7MpigVEILxvqZsombAH10Wmi7nvAunc7VYaH0lO+Cx
 z4wXsidoLGII1lhqhkAfbm3DE8w+nxp5N5BO+h4cZj6Bsjd0/L6/cT9rEeXR8ZCVNTH+
 Mx6A==
X-Gm-Message-State: AC+VfDyL1+R7I5NhcbOctFpdeYRr62bzLJoH0gSljolUQpTeOvOKYP7a
 Rhubdjyer5wNHEhKVdRqke4=
X-Google-Smtp-Source: ACHHUZ47CIz21wZp5Ttvdc1bRln55OtCgtRpYza6UsIR7M+htz0bEb2QV7vPpW0lvnftuE8t5GSrVQ==
X-Received: by 2002:a05:6a20:6a0b:b0:10b:189e:c1de with SMTP id
 p11-20020a056a206a0b00b0010b189ec1demr13884707pzk.10.1684941912945; 
 Wed, 24 May 2023 08:25:12 -0700 (PDT)
Received: from localhost ([123.56.124.140]) by smtp.gmail.com with ESMTPSA id
 17-20020a17090a19d100b0024bcad691d4sm1580623pjj.14.2023.05.24.08.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:25:12 -0700 (PDT)
Message-ID: <646e2c58.170a0220.4f979.2ba7@mx.google.com>
From: ghostfly233 <ghostfly23333@gmail.com>
Date: Wed, 24 May 2023 23:02:15 +0800
Subject: [PATCH] drm/amdgpu: Enable GCVM_CONTEXT1_CNTL after page table addr
 is set.
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
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
Cc: ghostfly23333@gmail.com, daniel@ffwll.ch, airlied@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
enabled before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
cause undefined behavior.

This patch enable GCVM_CONNTEXT1_CNTL after page table addresses are set,
so that it can ensure no undefined behavior will happen.

Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 4aacbbec31e2..791afc8e9e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -333,6 +333,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
-- 
2.34.1

