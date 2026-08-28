Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763B0C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E15710F333;
	Fri, 28 Aug 2026 11:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LIITX36s";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0222710E510
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:19 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso1188650a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917278; x=1788522078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t3LVeu0pOiF68MWyYgvZbM4Oc3IRVGtDXef/rxe55us=;
 b=LIITX36secTWTkU7w7GXct3295piPKxSMKnMcilL2yJvzfe1Jh2BEB+v0W+zsdbWhz
 udVZPC3mEf69hH7dEdUtejrorZ7UJWTkDm5KzXBPQwdJE5DDa0agnu05FmbQ784qWg2u
 VSWogTyT/sBNUCB3/0kY1MG4oNzgcyOzhTUcFoLhGJBijDhcNYg6OzB6mv6D6eNU/2Oz
 UcgSth1DMu9XNcOh8WN5Dzqrxi64gdRfv5BdGCR1onxy8O1es0enW5Bbegb6tpK3JcKF
 CNOcn7e2jBmmikvGDhs68Z/a2qzwiZTCRmLD72fsVar/C0DbNJybzyUVkHAtpwFTGNxv
 cvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917278; x=1788522078;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t3LVeu0pOiF68MWyYgvZbM4Oc3IRVGtDXef/rxe55us=;
 b=hh6VrIO+eXEmQVTl1Zewl0i17YMAK6DevkdCb9gaWW3vLK+cPzFrMeaX2ZElRwSJ6y
 bqPfZee26etkOgcc+//1cXX32GrClorKHYxJ8/tu0JxKgC+td1Zu0rfLovj1X05SW9gQ
 9tb4Xi0F+zUTFakLHAGIoCQkg9vYFEQYxM2TpunQ9DBQ8E/ZbO0yC3ngNyUPcAPGiC9O
 W9HENceb9HdRPRqWc7DixdDsTLNo9wkptJOW1FhbhinQxJ4Ewk7ZI+aB41jmdz+AFaRn
 HrX1zoGCzL38sxo9ZCUq0niCji56CPxoY43VyY5ulrpl6rogEKxLSBXJaZzabOeUSEGp
 s8xg==
X-Gm-Message-State: AFuF++m22eFXUYe/5sRuus48gAfZEr3VPHCW0sGj+dBp85rIDS4RBhKU
 3fLwZ/GOLUK5MkYH2DJw3aSS6eyC1U3AU2I+ehTR+dxHnesmpYXsN53o9LDy6bZ8
X-Gm-Gg: AR+sD113GIugrMAG0UMg0UEhEv30gW0hh5p2V8GhgzKZscIrBncP3KDRuSHSdz95/Cq
 3Wxs8jIO7yPxEVEaJHr3lJ5qW8zYdCRFmTcUsajJOeSiPnGa3HSUio6+4PntsoV73QjywPUEjan
 nxOT8q7zutxoyG67hns5yLa2jaMh++qRyke+y7w7NMFprDmX2rUD3+GOydITdos4I2QAntqt6iF
 RSmGOBoWAjr/s06/rA8dOyoa8Lk9ioDcG4VS+D7DZuKuA5GlbxRlX5+erC+sWSE7f7A2BFx/1rc
 oBPSlCBqCsyzoVm1lh+LSJLBBA5/U1CDnD3GgRHjpsoKnjJe3jxbiOZZYGQ4Bz8NPyQxVUg4FQ7
 C+ieo8MJo12D1ORIYGCLhi87O+k+vAQsxUGX8vlYl2wj9dxTVhAF3X2FWsY75BUBeN9LQzgNHqH
 rh7QKixUmO91bqfLzO29Ublf4Z9gCKdM8uSKoRaqDr1d+a3hVahSGvvuhweOoUl1rLP78BlWb5Z
 Lc5A7RCuAnGOxU2Fd9+8a662w==
X-Received: by 2002:a17:906:fe4a:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c2556c4611fmr414890966b.8.1787917278203; 
 Fri, 28 Aug 2026 04:41:18 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/11] drm/amdgpu: Respect noretry flag for retry faults on
 GFX12.1
Date: Fri, 28 Aug 2026 13:41:03 +0200
Message-ID: <20260828114113.13523-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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

When retry faults are disabled (amdgpu.noretry=1),
we should program the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT
bit to zero.

Note that retry faults are enabled by default on GFX12.1
so this just fixes the case when they are explicitly disabled.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 15d2a8ec55a6..7fa451b373fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -436,7 +436,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 			/* Send no-retry XNACK on fault to suppress VM fault storm */
 			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-					    1);
+					    !adev->gmc.noretry);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regGCVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
-- 
2.55.0

