Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482C5CA1002
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 10:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD2F10E3F9;
	Mon,  1 Sep 2025 10:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pcgdshkm";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140B810E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 10:00:18 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so25106015e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756720816; x=1757325616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5SR5ZwYZOxoDwuZPs+pNZtEqoTB1LOlj3R7AWro2UE=;
 b=PcgdshkmgfPenbiRsedOzWGKbhE/haecsAb67OEcwJtALFcjenIwYmX3u7p3J8b42K
 FVdIqJN+9IKaeYCumciclvkb8UXzCMIQAxxvXICG+yeBq5nzT6//454hjZiCwdMcp7Xl
 giZgCV0vA4oDx2z8XLPVCbTRIW4B8ZVT8sdn/RulmDGHAT1GTxckEDVTwWG5Y9LjP81i
 16GNZLHDQqh/aaa3BEPM/WhMJZFARoZNgjdxU+6bV3SvhkWo4wHG6+kV1Oe6pOSVfK2J
 k7mHXA8YtaxGNvmIMUfZ6H2Z6eU1MGKTGq4rQdVJspKjnP051Os+fn3CuGQJxf14ng4g
 jlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756720816; x=1757325616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5SR5ZwYZOxoDwuZPs+pNZtEqoTB1LOlj3R7AWro2UE=;
 b=cOoHBzDavVuGWq3A+OjPnQPAb3cVEbws649RhVgok/Z+2fEj6/5qTDqzaz9l1QYMSX
 4xuY1JcnG8b3NYiaUBonsGRQCqlrgTDBjwzn9miQU4i8SaaS+g04OP66pNaUeoXfWeu3
 GC5wLjvazDqRjCNcerE1Fd/MHFDAUHkd7A9G6D/wqrCSnOhthA013ICF/8IcM45ALOEu
 Xiv9vz8JZ5gMb6UxYun0BgQZECXn+rd6UnLkiGffdQVS5gQnn8Yu94JMBLVYkiOmckl0
 muxBREehLVfEpYVhfbyuof67GZ9/nr0lmDr0gwOYL/6B/NJK0xfOGhcf1mToONJNKG15
 0XnA==
X-Gm-Message-State: AOJu0Yw8jyzED4JyFVU5VDSwRI/xZGQaYMeceRgezv/44AFctvkiYjH7
 ZkFiMXB0GbjNTUurn4SfA1Xektk8FUhDEqyGvd8GxPm1XReAtqr4vY5xN1J11g==
X-Gm-Gg: ASbGncu9/1D+y4ER/ACsg/kEulScaJmaFOCwqYD6nMAMa+kMJl1P77cEd+uNj0DZscJ
 kKNfTRLidE2ApYBJ4hTBRMjdo0rQIroANwbre8Edxlx/bQZJjm9Y/a5iB+diDNesBkKTaVtjyrq
 o+DE06Zt3HGz1zuFSdoL+A76ksJGGWBsyxPWeb8YBL72Mr7+pcGk1nQ5S0xo6BhNLPdz4xbg1vf
 bneHfy8GSZTzOTvT5N1bAdZzidqFIHvpoQj5AVfebA/pg2LP29hXJB8K77032+YkDeLLVt68HP/
 /1SD5yGiWmtseZqs902PMiyj/wpE4VL01HLRhOHJv2pqFvWk+VDTqPQ1eaXyOvE9RmfeQKb8L2M
 JsLh2GvnyD8JXKoIKoCyBgol6gX2j5lZMda3EDHS0qdRXw89Je4JwQFKC3UIs5q6jCwPHu/2aHL
 ZTIkmm85LmKIHuCfbDkJWXmcm+rw==
X-Google-Smtp-Source: AGHT+IG9aR4JspO8ANY5nBtXRvEW4dOdc41e3Q/WkFBajQlNWEcvnZzyAv0aDKctT2qVFggQJdjckQ==
X-Received: by 2002:a05:6000:402c:b0:3d1:54de:f4b3 with SMTP id
 ffacd0b85a97d-3d1dc5a395fmr5494442f8f.6.1756720816021; 
 Mon, 01 Sep 2025 03:00:16 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24C19400D6AB39BC9D60A351.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:d6ab:39bc:9d60:a351])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf3458a67esm14679142f8f.62.2025.09.01.03.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 03:00:15 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/4] drm/amdgpu: Clarify that BO size is in bytes in comments
Date: Mon,  1 Sep 2025 12:00:10 +0200
Message-ID: <20250901100012.439155-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901100012.439155-1-timur.kristof@gmail.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
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

To avoid confusion with dwords.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 122a88294883..9ffadc029ef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -220,7 +220,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
  * amdgpu_bo_create_reserved - create reserved BO for kernel use
  *
  * @adev: amdgpu device object
- * @size: size for the new BO
+ * @size: size for the new BO in bytes
  * @align: alignment for the new BO
  * @domain: where to place it
  * @bo_ptr: used to initialize BOs in structures
@@ -317,7 +317,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
  * amdgpu_bo_create_kernel - create BO for kernel use
  *
  * @adev: amdgpu device object
- * @size: size for the new BO
+ * @size: size for the new BO in bytes
  * @align: alignment for the new BO
  * @domain: where to place it
  * @bo_ptr:  used to initialize BOs in structures
-- 
2.51.0

