Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F64ECD98F7
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26A010F0E7;
	Wed, 17 Jun 2026 19:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpjw2D/M";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2420310F0DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:51 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so438525e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723690; x=1782328490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYPAYtgMN+0/jLfYSFLrY2oWVEXuKHjJb7SX18RgFfg=;
 b=kpjw2D/MikdgUB7vPsKFiQpu8c0yZQtwbiYFIkU3B8i2gkANdN+d8p4IXeFun+xCxD
 e6AyaHRPPZ+HbPznONUqWY50etZiH7Haz6vW8LDkor7ZUtBk6+6ECe/GDavu/qFmJcEo
 Z+GwIYci2EDwyL3y8+TMcBU8uSg6MI64PbChVb1n7KGyuioIpS3Q6Vjuw7U8Q2RIkR6I
 UMm+0/K/ZcO+I+dBqiE+1ZT18SM4XvZ1EkgJuq3ci5KvKYajClwCgYN5CCBay+O3rw4L
 35ATRMFnrZx3ENDASWtP/Dxpk2jJltKsi/BPebU4VKmuuOWGSz5qDFO+121l2BQJkW/c
 EpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723690; x=1782328490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYPAYtgMN+0/jLfYSFLrY2oWVEXuKHjJb7SX18RgFfg=;
 b=ScMY5YwmiONBccg0PPgkJMGzpy+UuUeVlx2dLZaeLyqRGknafjtifK96eYRCRvDtQC
 TEB1SB2cJ06ENd6BQ9Sa2PjwVZZMWze1yef6OFcUZA/893zXWfjGcT8j+u1BP87uGZF9
 NJjFsyFZvf3vtLCNKYtaPMdJVTSz4FU5SNgcNymj2o7Bp014k0RV+rU0VZR66suKBUnZ
 QSPH9hYzkgfUf56UCiuCxT0S9nyOyww/mFj5dMrsuEhsdONUdTxtCtwx+bZsoVHcJecJ
 soH3tr4nghkCGDc2IrrfSDv3anr9DgifwC6WM4noJAZLaH5n4AX0bpwI2h031/vGK/0U
 OcgA==
X-Gm-Message-State: AOJu0Yy7k9z4X0tUrvE8DBvRT/UNNvbAQIO2cH8NuCgJrwCKnZ2RAT4K
 Cq8h00Ytx9CA1yTXI2zHpuBvvBlc+z3H0dzZyArqPteqIM26YJLra1VjiGOpdg==
X-Gm-Gg: Acq92OFiS8hWhxAmBIa56+kdCe1JMO8pjT1xmboSo9BIikPx3MCEfMKLl+9Fg5f5wo4
 iMrkRcuwwsi0wEd0N7+gJImNtywYKQ2Oe/Ch2NSUSSQRoXB5tHCAGKU62IwvpnU7RQHl4NwbaNI
 PZNwumLcW138rMhhEcIK+tWXUsW2qwA+KSt9SbI8AjNBp8okMpDjePfQg7/WVUkgHOCaZZ67OW+
 +MNfMgTvY16nGMNz/JS8vOOajFAx4bqciy9uT8Mbq7FlX26AGopuP4Sqeupr0715kOVn6u2iNaF
 b4Keq572+HxWfuma03g1z8QE4MzZhTCTKop0R0Ie13zbYr47+pYm46K8ljl8FPERFnpqtM9BcxL
 on+qm6eSCRQxxKhEEWQ1eC+2dxE2y6z2ENeFkQQSx9WPNJcBRu7iKhiR7/c2Mr2V9+ANYoSlm55
 ivnELoA3sp10si0KiOicowun34PdeFs81Dbq+f1Q76N/mCyWR8LmjOxM+nPQLL5VEn
X-Received: by 2002:a05:600c:a30c:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-492333bf7bamr82194005e9.14.1781723689653; 
 Wed, 17 Jun 2026 12:14:49 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 15/17] drm/amdgpu/gfx8: Adjust EDC GPR workaround
Date: Wed, 17 Jun 2026 21:14:26 +0200
Message-ID: <20260617191428.1784083-16-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

When the compute queue is unavailable to run the IB,
return -EBUSY instead of silently failing.

Make sure the IB is always executed during reset:
Set preempt condition (may be cleared during reset),
and flush HDP cache so the GPU sees the updated value.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 3c181628d87e..1366d6070481 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1487,7 +1487,14 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 
 	/* bail if the compute ring is not ready */
 	if (!ring->sched.ready)
-		return 0;
+		return -EBUSY;
+
+	if (amdgpu_in_reset(adev)) {
+		/* Set preempt condition to execute IB */
+		amdgpu_ring_set_preempt_cond_exec(ring, true);
+		/* Flush HDP cache so the GPU can see the updated COND_EXEC value */
+		amdgpu_device_flush_hdp(adev, NULL);
+	}
 
 	tmp = RREG32(mmGB_EDC_MODE);
 	WREG32(mmGB_EDC_MODE, 0);
-- 
2.54.0

