Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50495E9A741
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71C310E64E;
	Tue, 24 Mar 2026 09:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YkCS/Gxp";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8762010E44A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 22:45:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so31657135e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774305913; x=1774910713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=66u/VBwHFIYtSS0ffR+AH+e9AgRhJBGf6jfFuy18y7Q=;
 b=YkCS/GxpJnEVTlKO8ztWdRV/vsXQijEsAeLqnwpRy4km3OQFNU4NjRO2TPxzYL9Wt3
 +9Ax3czyyxWjJFy1m9LRd77Vx7jhzxoLtG7JtxrOCgv5D4uRXZx8mHPlHqkZ04iDWyQ5
 YheUFrgk0F0a2hM/LQuCqLZrMVKfa2h6c8oot5BM65nTJpN0zuCsPfoJxVrQjnRDwAGb
 5sGv9vytO1PgZTFYMxWjNIkAHPi5LZJEoYtPy68SY7yKq0+He8wJzSMVc8ufxacuK9Ft
 tegRgYY7eAJxEbn6YbJaeN85IQZvbIfbvp+UP1O/FS++e1EkLNsP3Db2vUgiVaA83O1w
 uFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774305913; x=1774910713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66u/VBwHFIYtSS0ffR+AH+e9AgRhJBGf6jfFuy18y7Q=;
 b=EmRKEOsl0VmvXE58VJtpTkvZ/+dNikz62pZU/hQsRM6OuSc/2ct76SgYMTkVw4Ic9Z
 3WBXAkda5ZayTowQD5RgMRkbZZA+pNvYmE1xvswy7X/EN6J6W//847TvKtjIxI88ld/0
 z3kyILiU/A9ZQjT3GMKjQX8kXl1ONMx/TEarCukrXoUyjOF5b1z/EGYSYttmXRIAEKzm
 7+RBKFCpjw0nT+fBu7+Xsz/TXjnlq8KFI7kGLkkNcbMgbciOrcJPuEvSpo5Xh/L2oVXB
 X4bPj1iccA/bV5Gc89iRnhmt+K6uVqnOebV2NgBzT+4DBSaF7aipzViGa2EhKF9gCdYZ
 siiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtzoT84Exlu0l1vtujKRHHhk5nyrYtVIEK/lNtYbmw4Evr5cDKg+Z/o4iOdQ8Q9sT32yEjJILF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWsxORrFtKI4wQ4+IBVzz0J776kdhcO6lqewWysVUfLP/W2QDa
 afIQK78abC3qw6QAVxeoXjNb9yP6TLUGgI+cvlG5/XXTUgVuZz7IgiQt
X-Gm-Gg: ATEYQzySOxiO3jgfgG9VkaFiuvIVS1aQkBFDtgVF8RI+uPl30N/ijHZn+JkuWazloq7
 xtJFqHhWvvg9F5RcaRjQF+LyCFQYvWrxoFr8wLEwv3fO5ND0bSwBtyFGhVM2/xhWHSVhz0fCIs7
 BkEtK4J04K+p+QexBhSICLvBBFX1CFF1fcrDViLa8q/nUoi38+5+kVw8/M8t62CVfvsTMMh5S3s
 XgCMZTUcSoLZp2ZaRgSvNLpX9TsELWszMs5A22+SlE2tQQAtakh8XylUOjq+rY7gu/M85WH3t7I
 QK7p60xO4vu8viBCDnvSeMZnqIrFyjG904i/XeVY7WF2JamXAmU3DKMaH158eYIZSWF7tABcnIO
 083QMpl/iA3APXNx2n4/HkcujLh8AmZ666JMx9F6a9kj/qOzJjKJ8zFzKfMozitCdHFPtlSa3q+
 iEqevAVT/oiMPdL99RYJ2HYw==
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id
 5b1f17b1804b1-486febbc648mr193158595e9.1.1774305912768; 
 Mon, 23 Mar 2026 15:45:12 -0700 (PDT)
Received: from localhost ([87.254.0.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4870f6d5fd9sm4775495e9.4.2026.03.23.15.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 15:45:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][nexr] drm/amdgpu/mes12_1: emove extra ;
 from declaration statement
Date: Mon, 23 Mar 2026 22:43:48 +0000
Message-ID: <20260323224348.343495-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:40 +0000
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

There is a declaration statement that has a ;; at the end, remove the
extraneous ;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5dcc2c32644a..0e9089544769 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2227,7 +2227,7 @@ static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_bo *meta_bo = NULL, *ctx_bo = NULL;
 	void *meta_ptr = NULL, *ctx_ptr = NULL;
 	u64 meta_gpu_addr, ctx_gpu_addr;
-	int size, i, r, pasid;;
+	int size, i, r, pasid;
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0)
-- 
2.53.0

