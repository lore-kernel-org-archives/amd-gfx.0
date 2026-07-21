Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F37C44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C0C10E958;
	Tue, 21 Jul 2026 11:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L79j8+Bg";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F055810E93A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:32 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69e8ea2783aso4333655a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634211; x=1785239011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q2uQAA9QHX2O04UFuwBDGXae5MxqfG03Ckkv5Tt/nu4=;
 b=L79j8+BgegFWKBYLueN7DHb10FXu+xqst99Gnrz9QHQqPXku4R1KgVuwtwpa9wstSl
 R9auQus8Ogistzr2FUeocX8joTg/HbfLJ6CgbYGDroMn720W2W7N4XItHO3dA/OWwrXQ
 EymvuYmp+nOcVAYCAFwECBgjQE+F/sUTgaHU0bCZGuOnDbttWiOMMM1+nyPnZNiy+3sA
 ukC9wBeD+lX8Ct8o9taAd0285lLU4iTnTq46geGhTuqOV59EjyajZByEE815atrwWcLI
 54L8Xyj4zYT0h6uv5VcJpKVqk+FAT5JgiStVN52Ighl0P4T22BH16wkfZgcDqsirmcRN
 xTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634211; x=1785239011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2uQAA9QHX2O04UFuwBDGXae5MxqfG03Ckkv5Tt/nu4=;
 b=VrPYbVo2QnUsJKJ5DOWAROwnFoWEHZaAZRsjJBAfGQqOgJvr1dKh5xsdrkMyH3TJuB
 96d1lnZU4gj1nJTUXqQMNafliBSEMWK8eOMKYnHzzffkrUQAarag7PWVzl/LDqi91jWh
 H2KDZEJ/1SPDKyK/fi96nDl8MQ1n0lngMput1nchH1c+9sQFMCU6GJMqjm4LwizvolzB
 EjRSTqAcHi6V3B+UnwM9XZLSWv4Jd9Yeu+V2EUrTvfFOko1unOBckavI5HavtMPqQk1f
 tPTzKTakMJ8+qCgj+LbosX8UiXzJ0LuPmgG4q6ilXwtamlaeFU+F1MeluNL2WC57nVLk
 ou9g==
X-Gm-Message-State: AOJu0YyhEQO+AxNUxyS5fY3q89pVAC4N4M3qcaPrl1ljnxPPdHQmOWRK
 WN7z6YJ2Ody3btixOxQ1v3QB46oH1G+nHNGz9x0xYzT5M2qKfPdtPf5YZ2UriPOz
X-Gm-Gg: AR+sD13JovJujp4YSLDNfy25kZwtI6kImKyQynMFQVt+iU+x4wLVe+ygZcnsstcEF9k
 2zGxyfIhybktPOguqS0eBZetedsJtbRwDqY2d66Ty/abLmoszMpaHK1mWqyG71riKiGeGzD3XYF
 MurNAHT6tiySpAURN5I7v5L3CgE8rA46/OOSAuVwGfkjp4fCJxVcfqcuj6eILzIUrmMTKBFLUn7
 T3RkWSUqT6ShkAmZf0fA4iaIE+Cayml8x4OpGSxALdYhSPBwF652w3StETupSxfX5Q4PhTFht52
 4WGI5+JC8VOe+Tny9FX0Q3X2bJ/E88hLeAKaH21sDHePDKqFuB50Pcaz8xT4+qYD/TPhR3m2xW3
 eYZKKBZCUW6oHpx7nNzcYNvaRlCJLr6MBuWbQ6PhtfmViq/p43rjeeqUDy0w6xJrZR1wlH2W6Ib
 RlcALy+WZ0KPPccXFgmSIZ/jZwyYVJ6X+sbTBs609QUPo=
X-Received: by 2002:a17:907:3f86:b0:c16:a6b6:42f9 with SMTP id
 a640c23a62f3a-c16b4899c4cmr794015766b.60.1784634211252; 
 Tue, 21 Jul 2026 04:43:31 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/9] drm/amdgpu/gfx7: Return error code when failing to start
 GFX ring
Date: Tue, 21 Jul 2026 13:43:17 +0200
Message-ID: <20260721114322.17535-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
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

Return an error code instead of silently failing.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 12ad29e1a75a..a1dcf452ed17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2576,7 +2576,10 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB0_BASE_HI, upper_32_bits(rb_addr));
 
 	/* start the ring */
-	gfx_v7_0_cp_gfx_start(adev);
+	r = gfx_v7_0_cp_gfx_start(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.55.0

