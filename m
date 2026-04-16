Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF00F8D76E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 20:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D38A10E231;
	Thu, 16 Apr 2026 20:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lu18mx5V";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4AD10E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 20:26:53 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so87866885e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776371212; x=1776976012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dn+OB9qQMzTfzW/NDItl3MXsU2FiXozHBBJHcWirLPw=;
 b=lu18mx5VX7LRxSXJvdT4DhlyHccKdPsWIuNqSqjwC8Du/52P8axmyHWCl3SqoKSZIa
 a9myCdg4ftjm2+CZBqkbTFFg/sTvZRHzIAbPHaVc/3aEMXOc3r+PuovitQVshbcvaHCu
 WFwF8dOkaSlZC1WQ3HlCnmN6gHG4SCjcWu8WRu1VlZe4xXB33oF88BC7uKqcwwtARF8p
 eq1S3AOAdWBy0tMb29hQza9PrYHswVyHpxj4+TpCynBNUyN4cXYcDdhukRPLdltUTtFr
 13bOCQL/jHkV+o141vcOeMOz7gsDcWQTDZvEFJsH/7wuowD/gdyOnBgzmxQxEh6ZbIgV
 4ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776371212; x=1776976012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dn+OB9qQMzTfzW/NDItl3MXsU2FiXozHBBJHcWirLPw=;
 b=ILS4gXOw3v8f/I/n9Gz1/nxRuWVBjvQC4rSWczAPaBdv2VmLQnLcGMUFG2qvkRI9nd
 HoHE/quWCz0uKaRyvMfm+Kz1j/X/o2AN8mCnswNjgwoFWoewo303A/I/JlO6raZ+PKYD
 pJeyUZNQ2pwHomqDpBlQZRdA1A4pRgY3cR55+Sednbeqo2GTTkc6fFyDffCgk6nNdfZ3
 3JM/Gw64N/gCjmCN12+1AiT9spqZ8lT5x+9A1ikWXS/UfoIK+hPhpcvslWy9Sa4ADAQ6
 +pzjHwjYg9eK1l3isT/S8QBC2rRtZjiqjn+8sLjzhSNrO+Fg73kXYj4wD/nnf7ur6y7A
 PKgA==
X-Gm-Message-State: AOJu0Yzw9FycIfFEmI8EitF2g1OEXLoVG1Iy1lQ1zDg5Fo48KXIc80i5
 Tu5FurjN2ggcaJF+RY1n71DnGOeQQXpTPaRl09IVnyWrxjlnRAtckMPyG0XH8A==
X-Gm-Gg: AeBDieuo33TZ60IMSGM2PlY+jWZSi1OZ8VxhB8cQ4sm+vKGHKy+xWDZ8k/4bCrmIPSy
 MS+8pPHOoM6zIw19GOOJ3vp+MGrRxu7EJk2vKu7zbS79zoAXRnVkLkNA+ymDsBNeQfVo3Yi3v0g
 RpBlVXg/Q4xD9/ojzqhG1J8R8puyOJLa782Cs04v9fnw1po5cpkm8Io2FdDnyTQNhHFPDoXZu/a
 gGXm4cjpHTxyHy7rBYBcWX5JdYYr4dOgHhWcnJEPyPm/9w2RooVnCORAMDbukaMIPOlDiUHY4wD
 EfUebn4vbvNrLXg4bDgB15RfFTU2jeExCjUN4vg4FWKLCA3HnR6bPUmxwUIevNy209hG47RBDXz
 LaaK4o6p1oJHuvwVyb/EXGrYCIB8DnGkMTkdzlCvciPKH6OxzcND4L5RIgVBgsy/zDQwBK9RYs9
 8kyIxKEUZoX6d/ty/BIUdpVOAzVlsh7LxjaY8VmQdvd33uhaaLI/H/UcJhVjO2tD5QHRUR9rpTO
 63C+g==
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488fb793c6bmr1298205e9.28.1776371211639; 
 Thu, 16 Apr 2026 13:26:51 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm76941355e9.5.2026.04.16.13.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:26:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/7] Documentation/gpu: Add TCC, update TCP in amdgpu glossary
Date: Thu, 16 Apr 2026 22:26:42 +0200
Message-ID: <20260416202643.25350-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416202643.25350-1-timur.kristof@gmail.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
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

These are the L2 and L1 cache on some AMD GPU architectures.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 033167025fcca..d553dd599c966 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -233,8 +233,15 @@ we have a dedicated glossary for Display Core at
     TC
       Texture Cache
 
+    TCC
+      Texture Cache per Channel - L2 cache attached to the memory channels.
+      May be used when shader cores are accessing memory.
+      Despite "Texture" in the name, this is used by any kind of memory access.
+      TCCs may be mapped to TCPs, depending on the architecture.
+
     TCP (AMDGPU)
-      Texture Cache per Pipe. Even though the name "Texture" is part of this
+      Texture Cache per Pipe - L1 cache attached to each CU.
+      Even though the name "Texture" is part of this
       acronym, the TCP represents the path to memory shaders; i.e., it is not
       related to texture. The name is a leftover from older designs where shader
       stages had different cache designs; it refers to the L1 cache in older
-- 
2.53.0

