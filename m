Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C013CDB466
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 08:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7FB10E1C7;
	Sat, 20 Jun 2026 08:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y7CPfgVV";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0F010E158
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 06:12:03 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-36b8e1760ccso1351114a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781935922; x=1782540722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Xa9wRkzrxIHZBcHMfm9W7lFK3FEnhZDg4Ta4bDB4Rg=;
 b=Y7CPfgVVhJ2WDoIpv06qc6/LA8/AM8+UfJtsQJonrD8HIDn2gGK4PmFAyf13xdGdng
 Kc9HtXavydyvdaIhkqd4BrnJua4DlhxjZzWSr+JpqycPcuTKIxferGXLUUYYVAY+To8r
 oJrRqZKfPoTmx/iRFhNEclKFhuQAJhIlQD7Q8KB3kUcaAFrFzFvrdeVNDWxCaprFIaDt
 jsUkwvJICV3XwTR7jaUf4ejt2qsrRXlaElp59dZXIbaOfGFsKGrQ9GU9gqS48Po2IGsM
 IdizPtGXrDWXx5TjashtjLVRXoHtDbQmbWcYZRViiDxgwtx2CSyJ2gF6ASCVWLUUYF8A
 nh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781935922; x=1782540722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Xa9wRkzrxIHZBcHMfm9W7lFK3FEnhZDg4Ta4bDB4Rg=;
 b=jDRNB3WLWqyehPn/nEk+otOCl7U+1h/WH4px1Pk/MJnbdX2LmnUKNv2qwR3MsxqLJt
 bpZK/nQXIovTNo8ZCztGp/uEIa07O7vkCSvJ4UanOzZpkVSxE8mvvl41R2aU5tfxNFa0
 GcRuhLe2Pt2n92Ox6pnHWAtRhlGiTTZxxRvEfDa83Gwy6UWXazwNcbndHM1uH2wyRreW
 wbFgr3DDsOyQ1BuAzVc5M5x1TlPa5m8WPZZ9kI3hpSrt90NSvZ87bdeadJ50sA7M1DxL
 ypLMlizXF0MRDP7tWiLp2euc6PcYaF+ZTWdXvmLhAY2FlvYkgMvTxAXq9F3paIgIttfX
 r+QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CJbm3IPiz3+4wYmv2qg1PI1Hk4nv1nl7rxKxrgYkk4O8pQ5Z8DPN3KYi2yiqCaABWFzqOnfnQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6/PNILRu+qfWPh3cjwE8emhcSRkkT24DSXA6gdt/gNX+qU3Ga
 EvAngkPj7tud3DQ0wXMbm/ZXAF9FLopHNDUHwR7pL+vy8bPhHkfRo95e
X-Gm-Gg: AfdE7ckMIsqyMbe6pVRU7KN9zyvSZFVwPb6BdJxfAYy5l1a/k+E1qFPPnMLEcRjSJHa
 8I6B8XuU39GWObIMRPENNAMgTI3vFzdYAPzqayvR3Zpf5wMRHFdMRx1QIxwJdRcUrJuw237c4PL
 o9O6dqumXDLar+Sig19WDBvSs63/1TwVnSC2iErfZOwJW8lGnHeuGkLwgMIXALV8J/c9rPnk7eX
 wXER+YFD+sn4BVpeM4U8cbQYz5M+69MWUTEKDkWuaHhUU0eMNZWTRkRmmR+XDyNAhNuBx6Jx4sh
 fwKtx8EhLWGJQX5i4kFmVVJ1WFNDJNEp5KnsTOmDxktFceLC+AvLEcrDuHQEkHQZ9Ld0emrGEE1
 ncVzomxtLH3jexI1SYsW+XfctLYTkwwD0FekOBph2QogqbL65kLM3aoxq7AJ31y73V4sFrAtdxf
 OiNWYfaO1UhDWoz6Eh8Hjl2aInurPgrlqS
X-Received: by 2002:a17:90b:33c8:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-37d15fb0ae4mr6709367a91.0.1781935922584; 
 Fri, 19 Jun 2026 23:12:02 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:8e0e:956e:b09c:23cd])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eff2387sm1283232a91.5.2026.06.19.23.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 23:12:02 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, tao.zhou1@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v3] drm/amdgpu: initialize ret before UMC error record loop
Date: Sat, 20 Jun 2026 14:11:55 +0800
Message-ID: <20260620061155.1442056-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 08:50:44 +0000
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

umc_v12_0_fill_error_record() returns ret after walking the pages
reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
return zero entries, leaving the loop skipped and ret uninitialized.

Initialize ret to -EINVAL immediately before the loop so the zero-entry
path returns a deterministic error status while preserving the existing
loop behavior when at least one page is processed.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v3:
- Initialize ret to -EINVAL instead of 0 to match the original error
  semantics preferred by Tao Zhou.

v2:
- Set ret immediately before the loop instead of initializing it in the
  declaration, as suggested by Christian.
- Avoid describing the zero-entry case as an allocation-failure fix.

 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index db505ab32fa0f..382e6d2dda9c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -689,6 +689,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
 				page_pfn, ARRAY_SIZE(page_pfn));
+	ret = -EINVAL;
 
 	for (i = 0; i < count; i++) {
 		ret = amdgpu_umc_fill_error_record(err_data,
-- 
2.51.0
