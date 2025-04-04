Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144FC36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8732810E25D;
	Fri,  4 Apr 2025 05:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MkzLng8t";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A7B10E25D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:22:42 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6e8f7019422so14392656d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743744162; x=1744348962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dGrG5/7fNmHx+zAKimqETKQQkPhX2+GrogBayXXbWkI=;
 b=MkzLng8t5xP/TCL0K9BU8mcTPcayOzS7hIS96mq4ZHkzDxVTtWUFsEgC5gQo35iHsJ
 ajzPkHKUy+ntx8kd0hsr3flJuHw6e2k6U77GY/Z9ViHcPb/XwaXV6W9/j2D1cXBSdNrk
 BASw2wwtZnaF+OXa4d8QSXAaNeyC/Gv0w/ju9gUh5QTya4s+fjxAE42qY63TjGF3dZGL
 dDqf1aRI93e7P/KEghZtrdZprwNEyG6Do6heM37QwoDGkX/GHlzPL30fszLceqd/0t4D
 grbOmTFx4MLLvcaAtHEHdvapoc0fq/IBTn2jMuaD5kZc5G9wO0NruuRIQemffO6LyDBZ
 bmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744162; x=1744348962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGrG5/7fNmHx+zAKimqETKQQkPhX2+GrogBayXXbWkI=;
 b=rHP1I5NXSTNdnrjM6tPzXzSN+jTvOVVlLPCYcAGszAXM8uKWNxcCYCBEQLXF7uE6yJ
 bnzia8jt9tDxuMts1Tfs05CkrAfzOqAI/yGZ1vZ+D0X21671eFlWacYRJfVcW5GV3aI6
 aPjpHF3Jx7O9VLmB5eLHqF4uKRGdDq5e0VLNjQAf6DciSBhdFr/11VUpmMncw95kLIxI
 +HtK7xxhgTAwD+zzM2uvUl/iJ8FH7lrBdesviydS9HgXRLjnUto3jOtgiJjxfczvXjNS
 MxC6TdpIvKsqR2EKMqxqE2JUj82GoYIhmYWiKZST7a1M5/GB9BNpuJUllGqJQIomcobM
 fhvQ==
X-Gm-Message-State: AOJu0YxQD7YTq8RMJ9qbdDPfgwmqNV8jp1IMcpEzarz5tP3IlAWA7eue
 lVOcnI0NmKqGJO3eolC6ffWgFbENjvl6cL3ysZX2cgNfgZ78FjHsQ00jOw==
X-Gm-Gg: ASbGncvawNVXj8efYe80TgpSk2usOHO0icxkwQ1G7bZG7YWAqXDXp38YPSvaFZvRyRq
 W8zYhxirylV+dsFaxj5v4MiEBcGRb1brxuoVgJ2gW5oFlWCWpyoQ+Bp2lmb7OyscJh6gJEb9Wv+
 EOGEKuSozNMx3n/7ofZd4tk1ShrEsAa5wyE/qoIU9X2ryuzwYIz5QumVVUeQ2Uex+KA72BUP1im
 FcOScepsro3Pu6HKNRIECGwpwzkP1QbHb9LM85/wVpmBLevopFmjfuBU5vDDm1qrKChGjJcv4P0
 d/myuPD/r0/Eez2u8Oz1GdCJV4muZ042YpVmarO9d/zJ/eZ5brI7WGHHpLKYJ5WD9iJI
X-Google-Smtp-Source: AGHT+IHCIO6XXCZWUhCd43FEkXSZ848DDqJqWNnrstszekA1sqLCQrjW0xTbYWLYS3OLVEDbxnhyPQ==
X-Received: by 2002:a05:6214:1253:b0:6e4:4194:df35 with SMTP id
 6a1803df08f44-6f00debcad6mr31512026d6.9.1743744161637; 
 Thu, 03 Apr 2025 22:22:41 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4791b071b42sm17238651cf.27.2025.04.03.22.22.40
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:22:41 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: use "irq" in place of "interrupt" in DCE6/8
 as in DCE10/11
Date: Fri,  4 Apr 2025 01:22:22 -0400
Message-ID: <20250404052222.19955-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
References: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

"interrupt" becomes "irq" in:
dce_vX_0_set_hpd_interrupt_state()
dce_vX_0_set_crtc_interrupt_state()
dce_vX_0_set_pageflip_interrupt_state()

It is easier when going through the code to just change the DCE number in
the functions' name to find and compare them across DCE versions.

Also, it standardizes function mapping inside a given structure where .set
and .process are both set to functions with a "_irq" suffix.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index aa205c5b268c..142661352bc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2927,7 +2927,7 @@ static void dce_v6_0_set_crtc_vline_interrupt_state(struct amdgpu_device *adev,
 
 }
 
-static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
+static int dce_v6_0_set_hpd_irq_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
 					    unsigned hpd,
 					    enum amdgpu_interrupt_state state)
@@ -2957,7 +2957,7 @@ static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v6_0_set_crtc_interrupt_state(struct amdgpu_device *adev,
+static int dce_v6_0_set_crtc_irq_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
@@ -3042,7 +3042,7 @@ static int dce_v6_0_crtc_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v6_0_set_pageflip_interrupt_state(struct amdgpu_device *adev,
+static int dce_v6_0_set_pageflip_irq_state(struct amdgpu_device *adev,
 						 struct amdgpu_irq_src *src,
 						 unsigned type,
 						 enum amdgpu_interrupt_state state)
@@ -3457,17 +3457,17 @@ static void dce_v6_0_set_display_funcs(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_irq_src_funcs dce_v6_0_crtc_irq_funcs = {
-	.set = dce_v6_0_set_crtc_interrupt_state,
+	.set = dce_v6_0_set_crtc_irq_state,
 	.process = dce_v6_0_crtc_irq,
 };
 
 static const struct amdgpu_irq_src_funcs dce_v6_0_pageflip_irq_funcs = {
-	.set = dce_v6_0_set_pageflip_interrupt_state,
+	.set = dce_v6_0_set_pageflip_irq_state,
 	.process = dce_v6_0_pageflip_irq,
 };
 
 static const struct amdgpu_irq_src_funcs dce_v6_0_hpd_irq_funcs = {
-	.set = dce_v6_0_set_hpd_interrupt_state,
+	.set = dce_v6_0_set_hpd_irq_state,
 	.process = dce_v6_0_hpd_irq,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 4491b82561a7..3870b6fd5b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2995,7 +2995,7 @@ static void dce_v8_0_set_crtc_vline_interrupt_state(struct amdgpu_device *adev,
 	}
 }
 
-static int dce_v8_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
+static int dce_v8_0_set_hpd_irq_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
 					    unsigned type,
 					    enum amdgpu_interrupt_state state)
@@ -3025,7 +3025,7 @@ static int dce_v8_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v8_0_set_crtc_interrupt_state(struct amdgpu_device *adev,
+static int dce_v8_0_set_crtc_irq_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
@@ -3110,7 +3110,7 @@ static int dce_v8_0_crtc_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v8_0_set_pageflip_interrupt_state(struct amdgpu_device *adev,
+static int dce_v8_0_set_pageflip_irq_state(struct amdgpu_device *adev,
 						 struct amdgpu_irq_src *src,
 						 unsigned type,
 						 enum amdgpu_interrupt_state state)
@@ -3521,17 +3521,17 @@ static void dce_v8_0_set_display_funcs(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_irq_src_funcs dce_v8_0_crtc_irq_funcs = {
-	.set = dce_v8_0_set_crtc_interrupt_state,
+	.set = dce_v8_0_set_crtc_irq_state,
 	.process = dce_v8_0_crtc_irq,
 };
 
 static const struct amdgpu_irq_src_funcs dce_v8_0_pageflip_irq_funcs = {
-	.set = dce_v8_0_set_pageflip_interrupt_state,
+	.set = dce_v8_0_set_pageflip_irq_state,
 	.process = dce_v8_0_pageflip_irq,
 };
 
 static const struct amdgpu_irq_src_funcs dce_v8_0_hpd_irq_funcs = {
-	.set = dce_v8_0_set_hpd_interrupt_state,
+	.set = dce_v8_0_set_hpd_irq_state,
 	.process = dce_v8_0_hpd_irq,
 };
 
-- 
2.49.0

