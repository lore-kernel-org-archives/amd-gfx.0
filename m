Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5506DC3064D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44DD10E039;
	Wed, 26 Jun 2024 18:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z3ZmJKDm";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A936610E009
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:31:57 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6b52eb2ee2eso20809426d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426716; x=1720031516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RI6sxovBRaTzVaGJD3BqNZr8Kpoeq5ftGK+Y2bq4uwQ=;
 b=Z3ZmJKDmxneu8RcG+0T5/hT33rxowD0DUlfs/3Erf3tQnKmy22LKb2tMBXDa8yU1pN
 ZBf+rpjmYz4U6dCVJThK8DME5w6Ce4Jq0ih1lgXr3OpaJ3NZ+3lXkluNi6PeSM8tW5np
 KTmb8Gvij/ezAw0q1r2HbfKcq9f/heOdLlQGWYQXAk/IkQrlQM9S0dBkcjUzeSygNLVR
 baXgMfgN4yVr9kCHhjTrYYVFXxeUYbcHw7/fAGDn1JiQJk7q3ZRj1wbKJnogKz0vV3Wp
 6YK5DXe338Pk69zXcMWyrdBfQY3KBBQOKbi/qDSLtmaj/iUzPbMERM03nkVfUDzA5j87
 KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426716; x=1720031516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RI6sxovBRaTzVaGJD3BqNZr8Kpoeq5ftGK+Y2bq4uwQ=;
 b=bBqvkii5z3NMM2pKKpScrvyUGfFVbmRDRiBGHsdFd0lC826XRD4E9r2wJ06wx2725F
 22WgscarT+xUmKah7FDTFStcjgx8vT1klz3BH/srgiHsXJfX0td5grd4xMYLJGJroLHA
 Mc2FB32z1tTR85EDuAkOX2e79H/HUDydORJOnvzZ30VWe4oWsx5TPU0h/27D9RLcet1p
 2xrGBdJ7QUjtYNbsRm6+Ns/tVS+M+PQqTizw1PjyT/uMFAFSzzVUMJooI4ad1YMqPPhz
 5rPo70pv9XUOSiTPlIV9q6fu1XbD3r3Odpup/3NXgl6XNaaAetLh6HkP3DNKOkyknscO
 BhsA==
X-Gm-Message-State: AOJu0YzACzJBf2UmY3pH5FNL4EugYL5SP9mX6sYciE+DULRCG8YOCi/U
 d0bU6iSmQoyFO0Y7wuExVtLBeU3sSF99UH+cdmpQMgPNBRdgqT6pQ5U31w==
X-Google-Smtp-Source: AGHT+IEaAUuHT4uE503egkxDuIB/rC9wJPNY+bj4bOjnJigQqfrJwLyEWdRnzSsndTbDJ5k4iPxhOA==
X-Received: by 2002:ad4:5882:0:b0:6b5:81e0:56b1 with SMTP id
 6a1803df08f44-6b581e0596amr16118586d6.51.1719426716236; 
 Wed, 26 Jun 2024 11:31:56 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:31:55 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 01/13] drm/amdgpu: check for LINEAR_ALIGNED correctly in
 check_tiling_flags_gfx6
Date: Wed, 26 Jun 2024 14:31:23 -0400
Message-Id: <20240626183135.8606-1-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index cfec85563bc6..3c5fb907bdd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -954,8 +954,7 @@ static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
 {
 	u64 micro_tile_mode;
 
-	/* Zero swizzle mode means linear */
-	if (AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0)
+	if (AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) == 1) /* LINEAR_ALIGNED */
 		return 0;
 
 	micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
-- 
2.34.1

