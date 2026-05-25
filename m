Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C937ECD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686A810E2B2;
	Mon, 25 May 2026 11:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SGy0ZCsG";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560DF10E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso9427075e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709512; x=1780314312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hY73QwaK8uRdSumezg1/2QzH2guuBM1JVzoaieXxqk=;
 b=SGy0ZCsGgIcK8RUKl5imlmIOxH8n1wx0e1byrMVHh+yC+TOXP414m03xla2FwoE8Uz
 c0Uvmn7766BPBbsZ+trq8WfhVXAnorVri2yYOmDRMpgZ+3pzZgk2yXr3X2pA5i1DfQFf
 /1oqwEaasH4KuwR0+ve1a5fK5FaKQUzX5+Okn+e/VGc6l2HSaV1ISP7KoSUh73g/oP1s
 QhbSc3oH3jvrf/ir/1H+9SBhSeBMLUpAWMVdqnmzQtYkeo9Yt8KIxKSzmKE+mBe+V/fn
 KbGEW5uIsIDYaslv00t5zbOnyztwBhIJkFqkAIY0oatzfwrYQG90hWKkMlZywXA8CSXC
 VB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709512; x=1780314312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hY73QwaK8uRdSumezg1/2QzH2guuBM1JVzoaieXxqk=;
 b=q7iczUfSYE7b8ZeDHUwx1cuLIk/vBj9pn5qbT/3W9x4i46I3OcvutpYuU5Eb+W82G+
 XuMiDZB0t6D2NG1gJNGQv+Sn+s9D1BCKYQIac08KaN1vgvJSu4aRWvTOkI/evZzPwzUE
 AhXlKRNzoysRUs+DaOMGjtUcAP4vuqdRQuPcTDznyFibiBFWSScFTAK4DVBy3ZHCW4xL
 8AjLY8Ys/fNnFM3zvIV/iTPQCiqPpk5ThzD+VmuiibiSDahmMRBd6hT32v7D8Bio5e4/
 dnNS08Jpetx5oYhtDc3RAjW1z5Rhx4TSA3D1MzWmqhUn0lZB6UyiRwgBUxUOIpTUkdC+
 VboQ==
X-Gm-Message-State: AOJu0YytQFW9JP6cN+CIliSKyrhdkHLjLPO2xS8ER1YdFLChXix54+mT
 TTs7PHw+WO4+CF2XAy6BuVELZsYzQ76LsksBRjWhYOFrmyBwnTP7/2dl19MTug==
X-Gm-Gg: Acq92OGRkm1L76Mzvc5b2UqrlzpmfNhMC29lQKWNdbgv5OKw3G6EosYLUfVwJ8ZENy7
 XcE2bmLuwvUC3kwgb/x0PX92H7AMLNDc6KI/FjKbEPh3TqOp/FFRg8lq9ke/dbtrEMjZaz39+e1
 lzoruKqvyxgam8hSjl4Q40DPg9/3lwo6waF+vkD/GpXj/eOw7yndmINYbjuWePBUa1KmG+ZZCHF
 C69VriBa8ijAYlnoqJeW1YqD9LCkTgqZuYvZ283rEImn/LeYP64lwn/sQA5nkxo9M4ze+elhGD5
 McNCAV3Atuettm1pnwhlgD0YEFLD5bKaUfJM91Lchd4QBL7hui7mtBy1wW++bVF6eMCHNR2zWAo
 pMxwvitWEnTQp8rMqCcwNHp8POf7rNC2Z/vc+4deJSQ7JbV+58ij+ra2bp5FzN98rOe2PKlE1f2
 SxfshvkqoOr1Z0S8cPErHlgKCUBs7QT1NW70hLsal22T0HNAQ0X/YjA7obfXKwY4E3s4Zh8LpbU
 ew=
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-490426bc737mr260654945e9.19.1779709511701; 
 Mon, 25 May 2026 04:45:11 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/7] drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as
 needed
Date: Mon, 25 May 2026 13:45:02 +0200
Message-ID: <20260525114507.24566-3-timur.kristof@gmail.com>
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

When the fault stop mode isn't AMDGPU_VM_FAULT_STOP_ALWAYS,
these bits should be programmed to 0.

Program CRASH_ON_NO_RETRY_FAULT and CRASH_ON_RETRY_FAULT
always, to make sure to clear the bits when we don't want
to crash.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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
index f845ba698b40..652eea6eae4a 100644
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
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index ba78b5a1a7cd..6cbf837d50dd 100644
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
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 3544eb42dca6..4c2fd1e6616e 100644
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
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index a7bfc9f41d0e..bfe247b1a333 100644
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
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 6c03bf9f1ae8..fbdf46070b38 100644
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
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 793faf62cb07..9ea593e2c719 100644
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
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index aceb8447feac..30b90d35abd0 100644
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
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 631f99e3741a..9e6a6e13dec0 100644
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
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 8a87410ce016..b3b1085c7cd3 100644
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
 }
 
-- 
2.54.0

