Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7A3C982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 07:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB7510EF59;
	Wed, 23 Sep 2026 07:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L87tZLu3";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2DC10E6D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:38:56 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so32182695e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790091535; x=1790696335; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F5jxz2R7aklALF1c07VlaANJo82uSjv4mznBGg6lztU=;
 b=L87tZLu3ZYlqt4tEAkAXNgnaM4AUUqvzjfnJSHnw+84IzWskxIm10bzJxsGnuuAXbD
 AoDFGDGaB5eX603sNycEvZ0vJKekCfHt15TspRnHo39r99dy6brc6ab9dchmiehO7nkf
 JI1ud3iU50XGVQV3fjlE1Eh6aDdXx6HIUa8QBssAlY7pT1TTeJ2YikQ3oD3Go84q27iq
 CB/JR+LkPSQUIRwIf5OpuXL23a/j4auZ3AZuACNkQ8nLCoqHh/oIBy2KYa8P32Mm1lCF
 23mXPXikyLzg7CE78QzOPm5gZOPwMOL+C7Tt59XyP40L48bXzZfo7bNdVi+rNRiEvzdu
 vUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091535; x=1790696335;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F5jxz2R7aklALF1c07VlaANJo82uSjv4mznBGg6lztU=;
 b=qW30hfLj7q+QwkO75qkwAyN5vKqiNVZuSmc9pymx628en7TKetdW4hOl//owbdx+67
 SBetcdpgvMyxir8GB9tXKZIyBpXUCwge7CUvDJ5vTMTqMJQvwW3zGGFOnkRSxTuwTo3R
 sWwaaheZYoBmgzwtzr0O7unZrNWlvjP9Cf3GV6jWVhzsmew9g9ryyrVM1wh/K89HnBr0
 Hv3rzknQEIOGJAsBx++a0723WWTHVW8lUentRXSt1TdBBw2ejVjhQqVO7QqxHWaHW3qT
 23MlMVidipBsiabUt1yg/8J1F1s/46GJs/G8OV2raac9sI9VGj3A7uHMRK6BBY0iWLxQ
 Cwmg==
X-Gm-Message-State: AFuF++lsJo/DfBv8SfMGsV8epsGqKIBqH+lLDuQZn7sgp6qLzT/aSsY+
 6JUGZlQJMn7GXP2Lxs8b3kfj+7c3wMLH/qS2KndNIuodSkd9yeetQUO1
X-Gm-Gg: AYBFou1rWqG+R9boA105XTqZ58Sb/e8OXc0aamwoGTqfOFjH3E8ZO4l0S4neaECKk2W
 jLJg0p3Rd3kYsNQdKplsmt7/2TlEewh9ImcSiaOrtUG/705vWWKobKuaDQNDvsPzVg9bXwah4ls
 +2gZVu3024coi+IXwrAK8L+NGMtZ6jiZIB7ulz/a6cqIyX2xNfTq4sBQtgKbYmAwBxhBgq1R492
 C9CppbAsSpyziBMsaHRrwyxIEFhlojIPP9eB7DOsPtdL8zk0315tpASAflsgTohe3XjBKrBCpIr
 IYcNJR1rQr4xsMgY/R/JkZ8WR3anBIzQ2wbalfWNOOh9x3XTeVQiIreD3j/VCNQSnXtVs1NdOK5
 ILnPlULNsN145ib65vs4jjWcEtc+HhUu1v05ygcjgvVgVbK+Rgmx448gUHM7s2NNSRPbyk5Vl8+
 bNEvx5yde5y9LynCQOVm4fXIWDs4pKiYWwE27KW16kerl1+mRdBp8a+4GpLZ/FvFek2wy2uwvPw
 zH2lZEpN1U1axDWy9Njl/nlM5js1PMteeH37gK5bgkRp/M=
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49fc56811dcmr212862655e9.4.1790091534593; 
 Tue, 22 Sep 2026 08:38:54 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862786f40sm5410966f8f.27.2026.09.22.08.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:38:53 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:38:52 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: unmap GART dma pages before free
Message-ID: <arKhDFCSoPDNYaxX@michalis-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:55:58 +0000
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

amdgpu_gart_table_ram_alloc() maps the GART dma pages
and neither the error path nor amdgpu_gart_table_ram_free()
unmaps those pages before freeing them, which could leave
the device writing to freed memory.

Fix by unmapping the GART dma pages before freeing them.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..780fb01530e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -209,6 +209,8 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 error_resv:
 	amdgpu_bo_unreserve(bo);
 error:
+	dma_unmap_page(&adev->pdev->dev, sg_dma_address(sg->sgl), adev->gart.table_size,
+		       DMA_BIDIRECTIONAL);
 	amdgpu_bo_unref(&bo);
 	if (sg) {
 		sg_free_table(sg);
@@ -240,6 +242,8 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(adev->gart.bo);
 	}
 	amdgpu_bo_unref(&adev->gart.bo);
+	dma_unmap_page(&adev->pdev->dev, sg_dma_address(sg->sgl), adev->gart.table_size,
+		       DMA_BIDIRECTIONAL);
 	sg_free_table(sg);
 	kfree(sg);
 	p = virt_to_page(adev->gart.ptr);
-- 
2.43.0

