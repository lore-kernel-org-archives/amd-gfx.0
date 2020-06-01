Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B21C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215B32073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W193x2tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215B32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC516E359;
	Mon,  1 Jun 2020 18:22:34 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978006E359
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:33 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id e16so8523773qtg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/QCteXn5FdAWX4SKYfDYey9Zjo2l8UcoogA1E/jpLPk=;
 b=W193x2txUQP+Sp5wGA/OzCiGdK7akYUOhXnE2qd4eMwSUYtfMUFKt3x0PJPdDTO9Tp
 ARl7COeXUm2MCclb3/P9y0QyGSTuMehixXm3KDMGh/JVF4pinsWQ7F7MyTjiHglk+CGb
 zzBMZRvDr1O7Yz07JnKjqqc6GzUj4WRtJmFkGrkKzZNAISo+yf4hfqhYRx/8WkJAfNdo
 4fv4Quo7hclxzpYm1Jb0KKxCnci+FN6xr5gIA0xza9ChU/xH+Ax29q4aCCEZ+hUQ6kOw
 01FF+fLgSVk4RwIT8OBfsG63YNfJXbE/yW3iQHNETtnYhZdS5ub9uT4jvx/fRLsNsbkD
 Zrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/QCteXn5FdAWX4SKYfDYey9Zjo2l8UcoogA1E/jpLPk=;
 b=fpk1rFfE6sHPvCjHIJU18xWYCJbS8obveQ4asTnnQlhmLhejagEHFzVJ7Og6cNu3/2
 SZKb22R0KDxtcOJOg1q/fac+XS22DvhjzGt6/hiSyDpsy0x1ZeBOXYxaHgcIM18xFuRR
 IK9lYIaPV1DC3L5+rK9TCbpd+obtBWztc1xm8pQUCPdi9iADJAZy0AEtl6VNGU5cfpFu
 dWSVwjQeDQfbaaMfhafRrW7xxYKAkZwrtIXBqSIc5q5eunnvgN6hEoX0TJ+4Dsqhx6qr
 h/sE4IbIF9BSsPy5ZUoEj9ZwrPB9zbZzCJfC8mVZo7G49n8DUs+SKNmVNOjXi5wbILxX
 E9cg==
X-Gm-Message-State: AOAM532C3RaUI7hb8L3iywyAMagyp9GAiCtzl2gn3LHVc00VNnw3Q3gS
 H3utVJGQHBtd9bq878+AcJA9+1Ao
X-Google-Smtp-Source: ABdhPJyFigmX1C1Nx6atHtB3TbZdfprxYC6PCMlt86KrQ6n/ja474RYMGQJhsCD3Uq07KsgPOUMoZg==
X-Received: by 2002:ac8:3779:: with SMTP id p54mr23779236qtb.156.1591035752619; 
 Mon, 01 Jun 2020 11:22:32 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 158/207] drm/amdgpu: skip GPU scheduler setup for KIQ and MES
 ring
Date: Mon,  1 Jun 2020 14:20:05 -0400
Message-Id: <20200601182054.1267858-69-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Fix the coding error to skip GPU scheduler setup for KIQ and MES ring.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8712a2e1b869..0ce82686c983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -470,7 +470,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 		return -ENOMEM;
 
 	/* No need to setup the GPU scheduler for KIQ and MES ring */
-	if (ring->funcs->type != AMDGPU_RING_TYPE_KIQ ||
+	if (ring->funcs->type != AMDGPU_RING_TYPE_KIQ &&
 	    ring->funcs->type != AMDGPU_RING_TYPE_MES) {
 		switch (ring->funcs->type) {
 		case AMDGPU_RING_TYPE_GFX:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
