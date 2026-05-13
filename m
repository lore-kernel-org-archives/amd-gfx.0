Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7028CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7802110E5EF;
	Wed, 13 May 2026 16:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pn3+0/94";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F85F10E34B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:30:49 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488d2079582so73038675e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689848; x=1779294648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im0E/Z2gMGnYf0JdAdE8JsPlQCNaCyeNH0F35t7f85Y=;
 b=pn3+0/94+ET15RaJX2uonuYWeu6ICpbW2GS8O9IJVRxEVDeJm2w9uYwzwGqIMTwujR
 tEadr0GAsswaxvFMfuvljJKiSyqampz0I1y2gQpYNZ3MnGWyWBLNzusd/UiWTLDiGiKC
 d5iu+/1oSrUbJbuRnuDhonwzLpxe4Lc5O6XaQygydY3ogPeAIpC3CIBEpklUz1PMfVWR
 iIC+zEjJDMEvGsiV9rq7ok5ZxOc0ersDkGJYqw7p8cRqOOEmtR/HFppKvMGeIf9YaEEW
 EjUPaI+98fs6V/s3naQ9BWPTLOUjS7MijVVaqKOuxYE5fmopgULvhU+b45olvwgqb515
 mO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689848; x=1779294648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Im0E/Z2gMGnYf0JdAdE8JsPlQCNaCyeNH0F35t7f85Y=;
 b=d2Opx7dlAzEJmLUvBFE0e1q0sdJHwgoQbWNMEB1qVl8kQrXHGRxbEW1ZWx9NDrkBFF
 ktIVBdr7DI347D6t/2CuEaAv0j6aUfWsqznn2Udi3/P0GnHyOttKV/arMuEaTD8mBuzt
 26Tg5B7bkOEPDhYZ01P5HgNSl/ngF8ASHQxRBeSAzf2O3h4rGbbpqTxnZt0Xf8pk8jSR
 VNhlk8GgANNLlYkIWI1Tc7llZ13/iEcNiXSYtzCf3icQgk+H/7TKiu0lkMum9fH+nM+U
 GKbTKb5Ws2RhzLb4d5Xjy491S0hLANeWww0vul0sPf8Q5+8y/vH5ES1hEYOHhg564hgb
 rvsw==
X-Gm-Message-State: AOJu0YzncB+u+sl55S6abLSooTTtEycifIXtjFDxIUmxQjhKc+lrL4bh
 295bV00ixr30RlAANbTxxGtCfLX/kF2f+lbpFRAa2RX5YNgK4BUBWKWvsLho8A==
X-Gm-Gg: Acq92OHiWbCXbpL3oR5D8QnV7oY3Mt6CrEqCplDUMC8tlzvqRmGHbSNOrXtsgMiYTuK
 vaWelkS8CHvUCxmCsYlvCL94dGOxvVE6ykM2gzZdA52wuaBh+1ZZdL8Qwg0Zw9px71CZKiF/TiK
 W+nLTe01nhhllPir6lwM2W39iZpBatpuN8/V9CWwDuozvFrN17IUDoTBXdpLde5nCJtapKJBd4S
 U1fgRvxaxmZeNMVX3G2+LtjSBXG9qxLMbnrUz8G637yTp6a7KOTae3IiHxa1EFNhnKt9cy04DG3
 kT5NnvqBR2QgsL+myJ7dCqo0YYDdN2U23//s7tGz5aJvz8YeFTd/0XCPpB/r8EA5A5g7b++RHLn
 eF8L+hICJt1O8R4iuoCQ7GV+kFtoYFLYhzGilwPyBWxEfQqgh8lVe/jCCksMA1Sl6hBUKVTmWwX
 dA/8DNmMoJb8lZ29biGDxHl4wjysX+Kp9xMCLpKbpv107gXZE0Ni96+HFjlQ==
X-Received: by 2002:a05:600c:154a:b0:48d:1a94:56c with SMTP id
 5b1f17b1804b1-48fce9da5e0mr48896445e9.18.1778689847688; 
 Wed, 13 May 2026 09:30:47 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64b5271sm1846385e9.14.2026.05.13.09.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:30:47 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/6] drm/amdgpu/gfxhub: Enable retry fault interrupts when
 needed
Date: Wed, 13 May 2026 18:30:39 +0200
Message-ID: <20260513163043.8725-3-timur.kristof@gmail.com>
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

Enable retry fault interrupts when retrying page faults is
enabled in amdgpu (ie. amdgpu.noretry=0).

Needs to be done for each GFXHUB version at once,
because none of them actually enabled this interrupt.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 5 +++++
 9 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index f845ba698b40..8fdf66ad265c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -456,6 +456,11 @@ static void gfxhub_v11_5_0_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v11_5_0_vmhub_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index ba78b5a1a7cd..84344c67013a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -461,6 +461,11 @@ static void gfxhub_v12_0_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v12_0_vmhub_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 3544eb42dca6..e505aaf8b447 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -648,6 +648,11 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 					    CRASH_ON_RETRY_FAULT, 1);
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regGCVM_L2_PROTECTION_FAULT_CNTL_HI32, tmp);
+
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+			ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+		WREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index a7bfc9f41d0e..c8a615147904 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -410,6 +410,11 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static void gfxhub_v1_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 6c03bf9f1ae8..afc8c6a6f1bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -523,6 +523,11 @@ static void gfxhub_v1_2_xcc_set_fault_enable_default(struct amdgpu_device *adev,
 					CRASH_ON_RETRY_FAULT, 1);
 		}
 		WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+			ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+		WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 793faf62cb07..a27bb37b2a11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -425,6 +425,11 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index aceb8447feac..db56f7a61d61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -456,6 +456,11 @@ static void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 631f99e3741a..97585c7b879c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -453,6 +453,11 @@ static void gfxhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v3_0_vmhub_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 8a87410ce016..72f24372a4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -441,6 +441,11 @@ static void gfxhub_v3_0_3_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		ENABLE_RETRY_FAULT_INTERRUPT, value && !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v3_0_3_vmhub_funcs = {
-- 
2.54.0

