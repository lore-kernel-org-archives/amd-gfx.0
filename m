Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32339CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA43C10FCB5;
	Fri, 29 May 2026 10:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXiIEpUr";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3289C10FCB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so119834f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050669; x=1780655469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YnIfhEBXAVqrQgapNbKoi/d7QeFzzKs5AqsCpcPVBQ=;
 b=WXiIEpUr9q1+4p9SvEbeTBOOphTrz/u07x27A3qMh0nMRm2ilowjGA81v1u+xI+gVc
 +jbi7XgZoB7vNDqNJ/+uIZ2cVV+ZfwjuZ6liieD4Os1MUHyHl4hfN88/0/RFITRFnypg
 5cRmAGsR2fnwv1ra0iaPkai8w3Uh2Cr2pVzZpeM8aO080mI/dM9E/9Xp31P//FKX3fta
 N5QdDPl14FkpP0JOD2o266MdYvwlleSGEvn7fiIek8LoMjRy2j42+8YIUDhabQwIOV0r
 uIjmpT3xOh/SNtSo0qy62i+4H1/GD4IUCPyEwoxGHgbQLMwQGgmBXLf6fR01vZ52nVWS
 p+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050669; x=1780655469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5YnIfhEBXAVqrQgapNbKoi/d7QeFzzKs5AqsCpcPVBQ=;
 b=hkR345UidmPCx1N0UNma3JqQ5aH4vYDMx2KQ0JtpjUbe/dfp791qlymgjJbV3c/Sz6
 ilm+feZrdJhdstmkdeGjDOMdUsJ4JUjvGtFdu5WA09+SnJ5p7blckvNpK7FelnvoAfWl
 u6AFdtwZMq0ZLWOW89xQr3Q16bLAiPOU+0sk/BA2zjy7+AliGE8UgQdO3j4p88EZlyce
 2QzF9YIfqeDG2jAfGVhUSX3V5Ja6UKqFjm+QYnfWGArLrRdbDdlIiBzOLebcehQxqyPx
 x16kuQHETfHWXh9GSkZQaH2hr9h3N/ZT+A38HNR9RP4s7Ye+dpZz/dU6+h3maU3GEKjr
 MZOg==
X-Gm-Message-State: AOJu0YzMt27PcQ7iOcqID2fddqIdfImssieMeA4H5M50OtwkqOhiIuyS
 PXivyY2ucGnWYHeTcvvrFlcU0eAYMQ6ialNogZfx3tCo0sCsQy2ehhU0wlD2nwDKpvk=
X-Gm-Gg: Acq92OEuMXHrywYocc5coa2rvNayHIEkV0Q1DIyyo0UBMtXs0+B76Ayg4oe+X6MtihX
 1GmHOczcLRjxP9pLn30kplG1bSrvPMIagv2RTtDRoQNfPYvKqyUZsp9daMt4ep6OJCm2Am4FJsR
 j8lJcCICTzwH8Wr3RVBmt3KS0gMbil0eYlOtgmwlp/ZqwL0mut05y3N+D2DWipZTsoS6yICLICm
 16F+zxvgbtUBkYvSiAGDYkMqDgbpiCkTHWpxbv9SLiHTKBu5rrcLz7frf9fQYgF+l0zMTspPAZs
 DFdoA1AaWj96pj7LZFe9glVVG1/31atKjw9RHpf7yrOK6jV+KznR4TAsmxh7vN1VFwUFQjH/JYd
 zgM/V9OJfoDzUIqSLGJ4rNAEkOc4FZWT97MUTpCIGXJwPoXbgNBNI5WIB0BFl6bBuYfQri4IohK
 MME9/y+ZThSaW8+okRKrL6Q82sCwRZB1pMwgKZe9zAbrbGaaNeWMP+EShC9A/9PbiH1+vKEr1r5
 nJnnyV/6tDOjyoL
X-Received: by 2002:a05:600c:810c:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-4909c622598mr30529725e9.9.1780050668452; 
 Fri, 29 May 2026 03:31:08 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:08 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/7] drm/amdgpu/vm: Use init PTE flags,
 and NOALLOC in amdgpu_vm_handle_fault()
Date: Fri, 29 May 2026 12:30:58 +0200
Message-ID: <20260529103059.21470-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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

These flags seem to be necessary for retry faults to work.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f5e9b97e92a8c..80c07abc81565 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3002,7 +3002,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
-	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+	flags = adev->gmc.init_pte_flags |
+		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
 		AMDGPU_PTE_SYSTEM;
 
 	if (is_compute_context) {
@@ -3017,6 +3018,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
 			AMDGPU_PTE_WRITEABLE;
 
+		if (adev->family >= AMDGPU_FAMILY_NV)
+			flags |= AMDGPU_PTE_NOALLOC;
 	} else {
 		/* Let the hw retry silently on the PTE */
 		value = 0;
-- 
2.53.0

