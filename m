Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F32F36C5C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567B610E55A;
	Mon, 20 Apr 2026 12:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ga9Kt50w";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF04C10E557
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:50 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso22527475e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687049; x=1777291849; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEXZbEAN9MmJ4xUJ5/ssK0F2ECKH9ynQWVCAOYRBOrQ=;
 b=ga9Kt50wy7Lf4aMd9RhJvRNSaaNriG6e4O5/qbTE8JOnuIA1fV9Nv9V4QmhjNI1tIt
 XktQmVqn/HsqhvujBptDE6sfaxFTi9bMtF/Qwi0NHtnqeMkOdxMuyD+DpzdeIIxUTteN
 b0VY3UkHSoQ3x30oCl/dKzGY1Er/uAYqh68Oy28CTvyUteafH7PQKUWWZAVb9o8pnzv7
 wwBO0pCadKCgqKG2+xn9FHVcrDSa6c3VDfAmO9D7d336QD8GOHn4Aemoa8PfRzpr0GLx
 qKjWudN7SebFvtA82UrgsdqjGvIUDj3MEmzVoG3NbaLCrVRmAep/eSG2a7KVbBZGXzB7
 UZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687049; x=1777291849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEXZbEAN9MmJ4xUJ5/ssK0F2ECKH9ynQWVCAOYRBOrQ=;
 b=lkTsQCpDNWAnDfT6U5Lzgq5qwBJiSX6wUSknVkUe8GTZvF6Ydw2gbV4wnU/VeQRjJA
 2TMSEY7QHxbX9Q8sJFgy5dtVl5c9mv/HWpT8fvWLlZgY4GV4/qAiYXN5Dh9wmEVpgt6O
 lBRTBEjx8FDIWUppjkiUDz7Oke1RJHE42rGvrMoBJmg0stmw+azOaUFF1C2BdblCtClx
 3Kt2T0JjTso2RV7tTOJZXeJxTxtehgzU4668H2x0FqamOcLQRxLe4nuploqObLZd1tK6
 l/C9yQTgLIzIDuQL8ZPwWC9UDyuZuBmT7HB3iCtX2H2o991qvvVj8iQMtGUp4UKAfl4n
 rLlA==
X-Gm-Message-State: AOJu0YyRv4mmk27ISTdajLHoU6NPgmLRrzpLcmYrR3gsgQPDbWSlE/n3
 GrS+pTNcgvJpawXjcBwS31fQUqKbD5KCk91unnnsUWDwc1DEwmxtqeDNAyxvjQ==
X-Gm-Gg: AeBDievULcq1zJ73wRm1lxSPyCQm0XjFhw2nruc9OFZSpD7i+mCQdxoj5Oz1xT46MTt
 mCXPE0AmB133Hzuj0PhGO4lEAEY11KjmWzL3C+j0ArOCal487dY3DDqQ/kUtqMCGNxIAYmcjjdH
 5oceerbC5737XpMTGYYr8oniOZRwSRYIa1f1pIDSpsc9NFbbeFejUyB33oIxPYelYVGxKuz8XLN
 loGOWMjcC+sWABVhwG/SzoOMMwbMTantMccDqRUknqoRPw4E7FJlxTOLSQTH/NJm54Xyrm7NY7l
 f3NHcDS1UApWVVxw2yQ6VSe3O9LzVNl9pqRBgteoVYAYjKTMKCx22LUvW8ps4KIttKhHhDsovBH
 7mzXJBP6LYmQYK55+sGafdJTmR1RxpNjAmal5cKrl7DLTuCWR3ewX45QM+bua4RG1JVlvJ4BQqu
 12DgEQagVjaQ6O2EKMFX0B2ibFgjFuaIWJbsTzb7g2jOA1DAJmXP/sVyYPP5Q/OtaeofEJU1qED
 V5Kdw==
X-Received: by 2002:a05:600c:c0db:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-488fb73b259mr139440085e9.3.1776687049334; 
 Mon, 20 Apr 2026 05:10:49 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/7] drm/amdgpu/vce: Align VCPU BO to nearest power of two
Date: Mon, 20 Apr 2026 14:10:39 +0200
Message-ID: <20260420121044.155030-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420121044.155030-1-timur.kristof@gmail.com>
References: <20260420121044.155030-1-timur.kristof@gmail.com>
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

VCE accesses memory, including its firmware, through a BAR.
It works slightly differently on each generation.
In case of VCE1, the start address of this BAR is zero
and we can't change it due to the firmware validation mechanism.

Align the VCE VCPU BO to the nearest power of two after the
byte size of the BO in order to prevent it from crossing the
boundaries of its BAR.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f3..0658f13f0bdf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -218,7 +218,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 	if (!adev->vce.fw)
 		return -ENOENT;
 
-	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+	r = amdgpu_bo_create_kernel(adev, size,
+				    roundup_pow_of_two(size),
 				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->vce.vcpu_bo,
-- 
2.53.0

