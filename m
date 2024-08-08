Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73848C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEA710E62B;
	Thu,  8 Aug 2024 01:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="Uz88bmH+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A5910E629
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:15 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-42808a69a93so518275e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079353; x=1723684153;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mk19J4czagCxai+r5jF8bwVwIFcSAuE4MleUvEcRkNs=;
 b=Uz88bmH+EOfaSAtPmritTidRVi8Q6PVfeeQlcO5AXSwInr0D9ZfTvyW8NxLzgAPk4r
 Kmq8eO7ozVoZPnqG0vW66YrQU/3zNr7ANVkfNp/DkqxuBxr1b7FlBtUg9Ermk98j5uHH
 lYds+pv7fzycKbmU6CKoTEZLujGcw+0rxHcYCh+2z+r0wXsCOPrWObAuqeM/gqjttjNe
 hsfNsi7vQ6MwHet4wAYFpAneGTOquOVtOt39YC/5dZl0RHBv7Cv2QhAh13zPTDlKxFZN
 /ro38mYQ/Sn1hHBpYGI6IP8LkuMt7wBSxiGWpBVH9B1XDtn8N97mFcg+Z508hoQnhHw5
 7B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079353; x=1723684153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mk19J4czagCxai+r5jF8bwVwIFcSAuE4MleUvEcRkNs=;
 b=Xu6gkaeREdv1Ujo8WaVzyaHdlvNkR42A6SGSCaVfWu1KYZDZdL+Xb+zy9XAOXlJ8hU
 wwLbz5CFVusS5j+BpDD7sxASRZxedVkHIPErAOmyoZLa/EMnMt+aYylSFtxPVMQfieyO
 h2B6iE7vKSL4KKaYpbX49VMVTldbUWO44F97HjCiwFnO7ZCU9ba0JfdwAvntzT+ZyX0R
 hjM8EIslSwol0bVV9mGnMRzpvyR25cvvD4iyFsxDAaHMZ1NsRzQoseKSSiNnOBR/E27U
 l8vTXoS1oQzED1L14d0VymMnAHy2sohLAShiatQOq6yhZfoZkwK3rVYd1tAfBi1W7P4i
 Jd6g==
X-Gm-Message-State: AOJu0Yw75ZtYG3Drd4To2tsU1V9AJ2yD8gSSY7NkcuY2hCDVJieXyRe5
 S1Ejet0Xfpu8uotkWkG8p4qwcT0s73V2wax8G7/bk3r0ySEF8ZJoRTPfvd8Yr6wDA820FYu20xe
 v91I=
X-Google-Smtp-Source: AGHT+IHWL3LcToNrSuRla/Y/EE2j9CW3akls8tYzDwMdvb6TlH1iBe2fEMe/y7oS9WLXvgLtw7kFfQ==
X-Received: by 2002:a05:6000:2a2:b0:368:4c5:1b5b with SMTP id
 ffacd0b85a97d-36d27633ef3mr77050f8f.10.1723079353286; 
 Wed, 07 Aug 2024 18:09:13 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:12 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 6/6] drm/amdgpu: Bump the driver version for the new flag.
Date: Thu,  8 Aug 2024 03:09:05 +0200
Message-ID: <20240808010905.439060-7-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
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

AMDGPU_CS_NO_IMPLICIT_SYNC.

Probably wildly out of date because amd-staging-drm-next
didn't boot for me.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f430..bf36b7d8929f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -116,9 +116,10 @@
  * - 3.55.0 - Add AMDGPU_INFO_GPUVM_FAULT query
  * - 3.56.0 - Update IB start address and size alignment for decode and encode
  * - 3.57.0 - Compute tunneling on GFX10+
+ * - 3.58.0 - Support AMDGPU_CS_NO_IMPLICIT_SYNC.
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	57
+#define KMS_DRIVER_MINOR	58
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.45.2

