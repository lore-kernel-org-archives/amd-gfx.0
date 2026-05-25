Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFACD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE6810E2B7;
	Mon, 25 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ev9l3Sek";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C70510E2B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:17 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso32509865e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709515; x=1780314315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gN3oqgfs4Pqsb29pEkzVNVW2KsolBQdOTMWIClIWlY4=;
 b=Ev9l3Sek6ePMD8hkEVWq3tQof3cSBZ9dSW7JPAPZ3SvT3xaVdM5az+37D6x1iYauTm
 tNwjTqGQWP4JK+9imUxG5cpUlUr3l6V1WNttdK/AuibekCy/q5UYcIFHA8EhqS1gB8X5
 yBwyzzO0b+iToqwFAYSUCUEUGcquPpMgtpEOAscZQJMcdjtj9aYGd/EKpnGvAowckzRt
 y/y7EIPFgKaaBSjuZDD5pSdLp9rH52CVfp7rSu1WaFI3D4Jenh0b65FodIIVMxg07evM
 +FpoOp9MLmTHaWXS1EoiftX0A/KeIk8kn/sdScf2536lmvGVRyA69+Lti9gk63nIoV7E
 qE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709515; x=1780314315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gN3oqgfs4Pqsb29pEkzVNVW2KsolBQdOTMWIClIWlY4=;
 b=D0RW1OS2K20rKrdtrB2ll9GGTB+LJbZ8PI4wN/ou2qXSXViqZl7L8yKs0tBoID4Vau
 nQ44oJ9elAjaYy4F7HbEgn+/FwZKge8XrHNgcNEPALXIk6HyLuQv76WLsw4k/gAfXEzB
 JY+EhV72NE6U+GcEsSg+aCpdz+jPgOgl/8JtOX/dMkngjoc/V4tTZRk6UoG9tSbOAJkk
 nOGykfzy2F1Roj6c4aiZxZkoqOuV/wWMBVYYj+YbMI/zWj9/xueVXlamvmZowLnKRZGV
 kLM53kZq08hsRR4kgavC0J0+iQesz/93J/hxusaF9kn688MFHBN+bR1YA02MXZFV7Stq
 mZ2w==
X-Gm-Message-State: AOJu0YzFuN1M4CKCRrOIaSdQrKrbAO15/byM+8wKkHwm6DGMrfd1psD6
 YTVKq56R24cJ9klQaZClD1nGJFuWCuEvCjXjcKa2KN0paA2zyrySyFj1MNyNZQ==
X-Gm-Gg: Acq92OHrfY8IkXDqvUQTRzimOvsH+PN9hEdp/KjuywXFvco4fmvvpFIpem8m3RdE9j3
 BnyJIH+PhC71TP7GGC74EE1bo3Z9Bc67hz/Vnh+ZtuLoounkZxeB8MnLqNbaOs3NylK4Ds5Jn3K
 kq4fh0pe38hMTNYcj90VV95QTtDbpEea9r2qmApIMwMvQUGEfVByDnEJciep5WjNPQ9BE1Pyela
 RrAKBbkqSE/TdI2xCx5PcWY1rvEvrnOzFt2oMnvPAAA3yfNhjsYhYT12qRW+mhc9kS0W14xsqJg
 Yz6qsjmOR2NwnIgRUiG/Nom7DjJ4++QGI1SD1HXslI0w+DA/YehhpHljmL1rw0WZ8tF7kwlXmKQ
 L3oaeXdnkCokYch2QslMI6L2YhJs7FPyQMAfLy7jqprY6s0QGTqFrradMkVL1P1NTXYbSZvHCog
 o8T5ISQuq+0rjFw0hY+TjKb+Fxr/yv77uraRi+gGPKf2+UC/YsBW+sWkng8rbguiKB
X-Received: by 2002:a05:600c:4ecc:b0:490:3c15:7146 with SMTP id
 5b1f17b1804b1-490426cd872mr228037905e9.19.1779709515394; 
 Mon, 25 May 2026 04:45:15 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:15 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/7] drm/amdgpu/gfxhub: Respect noretry flag for retry faults
 on GFX12.1
Date: Mon, 25 May 2026 13:45:06 +0200
Message-ID: <20260525114507.24566-7-timur.kristof@gmail.com>
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

When retry faults are disabled (amdgpu.noretry=1),
the ENABLE_RETRY_FAULT_INTERRUPT bit should be programmed to 0.

Note that retry faults are enabled by default on GFX12.1
so this just fixes the case when they are explicitly disabled.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..d2edfe037da8 100644
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
-- 
2.54.0

