Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A9C43602
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D443C10F046;
	Wed,  1 Jul 2026 16:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDYYbNqL";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56B210F03A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493b7612475so7178225e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922652; x=1783527452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ks9mnOFajrxnipdCC/EXDT2nyMHgfwJ78ah1e8IDTng=;
 b=BDYYbNqLVjEXgYUeN46GUwDhSaGyfGWBSHX4VdXSQ/5hmPru8fltJxzCvmxquy2NK4
 Z5JVGq/C9Q1oS7suhikexzXmp4CtZ+mOxF5XR7zCwOl2mNBbkFkolvDzUlZG3xqTwh9I
 H3rxYFPm9IdFEWb8pXTS9k6m/Bbd6hM0d2RjNjEGd1yHeOvPn/v2bA94MF4wX96fx/cF
 2MtDJ7TiCrdo2s7sm6ugTINVqkjnOEiEkbyBReIwsC8p1eGPux77NFd4nmgLhpimCwOn
 KlLorBH/3eRcfaTA/snCUmedfnOZS1yysQW9AVaqAPe9JxOOVPPLxKFs7BWVgxgR15kc
 v9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922652; x=1783527452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ks9mnOFajrxnipdCC/EXDT2nyMHgfwJ78ah1e8IDTng=;
 b=frlu8jh3ddLGdAycH8f8UHj8aSe4skVxXF2H66QPcvV6WeeHGCZKdprwBYuUoAgF6W
 ep5jZ5ClllJiudSil6MbWfkk3SyFrm0e7+6XgIwmnfpy3i6geLlYcbUL5/vKh7l5Q8Et
 Pd2QfkzRn0O8B1jlzVdX+Y/s0ZewPEhU/HGz53Yt5CS0l6ywLW7e339fREzLUj1axP0P
 2+zZfwKNyqguSbaEraLX2A5Di69a4YMM7sdE+rEykkppPpLZgFhhwj14s2XIyFy8AQMk
 c9AloXUQkJVpUVelx2yupnjyLs+YAlOE3XXMYSIliuA8O37XQcyUuADHiBxLMWpHlnL7
 sKmg==
X-Gm-Message-State: AOJu0YxAVbX7yxXsbbS0EO61wMMmbAGmt/GIZ8ABTkSUfPKGGpoDjVQB
 LGl7pLMJXGe5GbRjnX3xOGBwQya3KNlEBKmrxjYFaxtxAHmoYBskz6bUslu9YqVK
X-Gm-Gg: AfdE7cmy1adAujphYxW/h1nunL+ol8R8gYBYbfuXele2m5kHnlbfWPTpdzeUYHnmL4q
 NZJnXhNyPbCv5sLcHA14NHG2T0Jqq+kj2/jN/HuX4Ag3YuBiBMMIh7sHBAkm1gmFZYdRnE/KxIm
 6F5R0Icxz1HQu9WKQzZer6RVdO1nxyGNT1PPllHKrmo0Idg5shm+sgxdx9G2h5v9he8JaXoMtsF
 Ls5MYaymw133hkgdezcu/LyQ5Zw5Ac8L2pv2dbbB9WfLbGHamPs2lL+roZZXK5dfEwrJdGo5aWt
 kL04ryNqm92/onrdfUdhAzKn4kt/LGyy9JyuFmCQsosCSe2oP8e9JkW7Sx38uZVEaxGBWzWkAXx
 j6iNTxcvKy2ZstmI5axDYpIl5VnbUUZWV5ELX1R9i1nDOq1d9gVY9+h+BnGnX9u4gi69BK8Ri5I
 QJUFB6ZjkUD9+vhyyb3VF/+0h1+cE=
X-Received: by 2002:a05:600c:8b44:b0:493:bb0e:2832 with SMTP id
 5b1f17b1804b1-493c2ba6eeemr44377775e9.37.1782922652141; 
 Wed, 01 Jul 2026 09:17:32 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:31 -0700 (PDT)
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
Subject: [PATCH 01/14] drm/amdgpu: Respect noretry flag for retry faults on
 GFX12.1
Date: Wed,  1 Jul 2026 18:17:08 +0200
Message-ID: <20260701161721.85681-2-timur.kristof@gmail.com>
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

When retry faults are disabled (amdgpu.noretry=1),
the ENABLE_RETRY_FAULT_INTERRUPT bit should be programmed to 0.

Note that retry faults are enabled by default on GFX12.1
so this just fixes the case when they are explicitly disabled.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..0cada13d92a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -243,7 +243,7 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
 				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
-				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
+				    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
@@ -447,7 +447,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 			/* Send no-retry XNACK on fault to suppress VM fault storm */
 			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-					    1);
+					    !adev->gmc.noretry);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regGCVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 49b7f16a941f..f2c549737e02 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -320,7 +320,7 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
 				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
-				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
+				    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
-- 
2.54.0

