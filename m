Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490A8CD4F3E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9735210EF27;
	Wed, 13 May 2026 16:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqRY4eqd";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F06810E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:30:50 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b150559bso54845715e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689849; x=1779294649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p140O06N7wRLF4/dlqXnecpoInoV106tOAmk5U+2K/U=;
 b=dqRY4eqd6ZZ1RNVSElkqSYBLWiTmI+Kz2Ar/qm2JPN5IwXsur2yt8agNCKWCpCQfwk
 wF7WMeaPup4O4CTmePIl0xGfBMGwfUzb+xXhCMCzEFIFHwJ75m0d/GmOf9xwsu7X3Jrh
 rmgG5p/NMti7i0yHEdGfJtyuO2LFBfzcbmRnRVS+I5h4nD+XHMxeGxBdtYaazc9OLqvB
 knizXfu+ZIGgsV+wKIVfiCwupaFi9orpl8WxG3cgiJhCjkLi2I1q2ScZs9ADoqPUI6YJ
 DxMJkQOul3HMXR6X+NSrT/5sJHgr6VGJEiF4Zk0b4rZgD2QVzEUD3GUfjmZpGz1Nifnm
 /0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689849; x=1779294649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p140O06N7wRLF4/dlqXnecpoInoV106tOAmk5U+2K/U=;
 b=OjL/MvcG3fJX3ocnKcI0/r4Ai6OxByA4qtR2SQCJ1i8e/wkZHxHjdSjDizmuaQPEXI
 uNkwx+A/jb3S+jSimaV4a9GR6cqHNwK8vh/zooYkeISYG0P2khTGuygDn3q4wSRODaPD
 2jMlIQOHNXlqZ7/PISaoGLdFRQoNUe4cv5WQR56OrhHcZBXAZWVLbm/01lN+p0/H1ZTj
 VsWSSZv7FTyOqj6Vb4yAGFKm/xQ4tH1v/n9bHs/HVrt2LQ5asn5daL5VE6WQlIInoP3B
 eX24LLLyHDFEYdJZb3lrc5EgvDAXB2TB74cOTP5wEe8deXSzv7j06H5nNjzDnanL3+5J
 UgnQ==
X-Gm-Message-State: AOJu0YyRo8BpOpGRoqcl9oURyyNEgFzvTqFn4K4hZZGt+pJhjseA27Bd
 mKOeUC5Gs0o3K5l1HQ4fNtJjwD2INztqwQ/MRA8gXggkUL++aJe3ZPb4/W8p1A==
X-Gm-Gg: Acq92OEO0lPM2DVOf87Q+dNKarH85p5fvGVH858DF3x2YQXFueWn7E14GUZ/9fj+m9y
 3opBrERV6rUfcCfjcJgrhLqHt4qIHhIl1ErTfrbDxq1VjYN3SEBA3utQkOAPl351S2VwEjs9sPk
 WeeFEzRfwZuJmvwWQf9TwKs1fWcVIhh4FL2O0Y+mRIJNdM6PzjzuSNvOFpAXqi6sSp0dluBIWjS
 oZeCVSPmODtMFZ1XnAcMDPP2YZFT+kLnbf6KMSXk0CYSKdSCe0YekB/d39+v4HzHOqH1SDFAPK+
 1kyxJwsNHFyK28f/jinFZb8u98CeanU6lRcvIjjs/lOh/I+SVhb1c10tp6bhkeUfGG4mYAefg8B
 GH0H16ciYEHidr40ZxzQzXCgwyAAH/CfuFaPWchiRJIrhlblJ6S41ifke4tuev5/ELeLSs0Obp8
 DkLSuwPnbT5wn8eavocFcPsxtKi5fhkW8PP6dZDLLd2Fr/G8L+jD1CadyhDg==
X-Received: by 2002:a05:600c:4e4c:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48fc9a30d48mr71824865e9.15.1778689848669; 
 Wed, 13 May 2026 09:30:48 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64b5271sm1846385e9.14.2026.05.13.09.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:30:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/6] drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as
 needed
Date: Wed, 13 May 2026 18:30:40 +0200
Message-ID: <20260513163043.8725-4-timur.kristof@gmail.com>
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

When the fault stop mode isn't AMDGPU_VM_FAULT_STOP_ALWAYS,
these bits should be programmed to 0.

Program CRASH_ON_NO_RETRY_FAULT and CRASH_ON_RETRY_FAULT
always, to make sure to clear the bits when we don't want
to crash.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 14 ++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 10 ++++------
 9 files changed, 38 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 8fdf66ad265c..3c6c20e529a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -449,12 +449,10 @@ static void gfxhub_v11_5_0_set_fault_enable_default(struct amdgpu_device *adev,
 			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 84344c67013a..9234a66a439a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -454,12 +454,10 @@ static void gfxhub_v12_0_set_fault_enable_default(struct amdgpu_device *adev,
 			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index e505aaf8b447..82ee96b5ef4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -633,19 +633,17 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 		tmp = REG_SET_FIELD(tmp,
 				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
 				    OTHER_CLIENT_ID_NO_RETRY_FAULT_INTERRUPT, value);
-		if (!value)
-			tmp = REG_SET_FIELD(tmp,
-					    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
-					    CRASH_ON_NO_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    CRASH_ON_NO_RETRY_FAULT, !value);
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regGCVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
 
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCVM_L2_PROTECTION_FAULT_CNTL_HI32);
-		if (!value)
-			tmp = REG_SET_FIELD(tmp,
-					    GCVM_L2_PROTECTION_FAULT_CNTL_HI32,
-					    CRASH_ON_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_HI32,
+				    CRASH_ON_RETRY_FAULT, !value);
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regGCVM_L2_PROTECTION_FAULT_CNTL_HI32, tmp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c8a615147904..2b20b86236be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -403,12 +403,10 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 			WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 			EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index afc8c6a6f1bb..182cf3994512 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -516,12 +516,10 @@ static void gfxhub_v1_2_xcc_set_fault_enable_default(struct amdgpu_device *adev,
 				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-		if (!value) {
-			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-					CRASH_ON_NO_RETRY_FAULT, 1);
-			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-					CRASH_ON_RETRY_FAULT, 1);
-		}
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_NO_RETRY_FAULT, !value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_RETRY_FAULT, !value);
 		WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index a27bb37b2a11..35ef43137f1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -418,12 +418,10 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index db56f7a61d61..c6b610c48540 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -449,12 +449,10 @@ static void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
 			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 97585c7b879c..0d8b8980898e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -446,12 +446,10 @@ static void gfxhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev,
 			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 72f24372a4e8..766dc0ce738b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -434,12 +434,10 @@ static void gfxhub_v3_0_3_set_fault_enable_default(struct amdgpu_device *adev,
 			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
-		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
-	}
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_NO_RETRY_FAULT, !value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    CRASH_ON_RETRY_FAULT, !value);
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
-- 
2.54.0

