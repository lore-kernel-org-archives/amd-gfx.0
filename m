Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398AACC6B3C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 12:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE0710EB92;
	Thu, 15 Oct 2026 12:56:29 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437AF10EB9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 09:58:22 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so7390412a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792058301; x=1792663101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
 b=bFzry+wKS7B+K0L/4VUrS0sM8+tu3mn1E7qDHx5XDAHcC8luLKiH6tlLMid/e4HxAw
 ede9cQTu94/KKZmiFKLyatDTttE/h2egzrGmQR05ik49SYCQGqu5eSlgimffjdC5YPMh
 2mth7YZq5ApasZQKKsIJ+yKnc02k1Qj2R+agyEl90eKjPnM9geG5svBsnNk7iFj6FKXe
 0YOcsYEafimSj8NoJozHDbKeuapCe2mXcmPUBzUUUZCHPJFYyGZjGDdzxuG7iZTB4ul8
 UfISX+p38UwsjdSXjbiCf6CKDLK5ij3DmGFq3ArXZXdE04gIpWRFmk2LUENlO0jH74vD
 Yr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058301; x=1792663101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
 b=W+HpGLFEPRtrfYuqOAvjQBCkQFEa26kQ/FSEFjgXGf4K3hCJEzh9k6V0/49Ok8qn26
 TRKBfAHnmU+f1xJt/Ubdy+6EkV/j1B/VdUwEBVCVQHLh7zicU5ygH8f2D35ty4QrpgBN
 D4SKKRUhUcgKheDVZudXtBYoH+o8JDvxiq5upL/ctN0m+eBv8YHqPsNWkHBzsSWm3LWu
 gZYxzz5Ddu55Hl1HbHEkP0pa97PdPZQoQ57C9z4I71QZRxCu4uNdPxkACQhPY1D/x3vr
 hqs6w0E7V5VpCwLaDwBgnTHActHAiw8JlVAb+O02VOq5sP6IacwuCBxAYO5/sg8D23Gx
 9gSw==
X-Gm-Message-State: AFq9FYI7Kg3xEhhJvNRfBvAkm+HSnoCF7KKWUDXlvFRg4OEVZcfJRVbc
 Z6UFX1LPkVJkf5cvke5ldc5HnnzihiowooSvsGcvC0k7vvtoIEbvuFpt1Tuuur3XLMk=
X-Gm-Gg: AYBFou1nlx1qo1FMwup6uWM6R3K/dO2pDumor7DexIRplWNbxouESTKPpH+zJJwCJMK
 E53E5Lm93dq0vzX6Kh17aZEFlL3HI+0OLetaAmndqK1P1I3jnhw9wocWUGn9slMzhto+uZ4Ew+s
 Kts30zSWNxWmsBxPahIfiiBVeRAkH5F6uXMnIhDd3+SsVKbbGVQ6darjqrrHrhcFWuO6OaG2iyv
 SpURJArF425wGa3wE7i1oqSCcYWSvPsyl4FjQYx/+Tf+1URVxq8AEYggjm5+ziN1y8rPJ0sIMm3
 5j5qQ9TusGPYD3yDPO7yWkxv+xSpWzhtGznEcQ3IAxRjgwI8dO/yFuelUc/YMRxnVF2jKirN15k
 DWH1Wbq9HoSEwRRxFZfzLdmXuiwMxaeyqZF/dCtm3oFAsQFz/ZV4WOHN14y3IhFTGrCz88SMtqd
 ez+2YVjbj86+VbjJqLz+/lUZcoeQlVd7duYrADAXvtMdKtYmG0DX/7SyLBZxk2YrOlOr+NttpyV
 av16bMFQertJq5daK0P
X-Received: by 2002:a05:6402:321d:b0:6aa:f198:4e39 with SMTP id
 4fb4d7f45d1cf-6b17c294025mr15477544a12.44.1792058300579; 
 Thu, 15 Oct 2026 02:58:20 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b2038aa1aesm2182227a12.32.2026.10.15.02.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:58:19 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amdgpu: reset CIK ASIC on Apple boards with VRAM
 at 0
Date: Thu, 15 Oct 2026 11:57:12 +0200
Message-ID: <20261015095713.20560-3-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015095713.20560-1-qchcio@gmail.com>
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20261015095713.20560-1-qchcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 12:56:28 +0000
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

On MacBookPros with switchable graphics, the firmware puts VRAM at MC
address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
reset) moves VRAM back to the VBIOS default.  The SI fix resets and
posts the ASIC at load, so the driver uses the VBIOS layout from the
start:

  "drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0"

No MacBookPro has a CIK GPU, and no affected CIK board is known.  Add
the same test to cik_need_reset_on_init(), so that SI, CIK and VI
handle this firmware layout in the same way.  gmc_v7_0 reads
MC_VM_FB_LOCATION once at init and does not reprogram it.  A CIK board
with VRAM at 0 therefore has the same problem as the SI boards.

After the reset, FB_BASE is not 0, so the new test does not fire again
on a module reload.

Only compile-tested.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index d29991a4a..e1029239b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1927,6 +1927,16 @@ static bool cik_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 clock_cntl, pc;
 
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
+	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back to
+	 * the vbios default, so reset and post on load to start with the
+	 * vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MASK))
+		return true;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-- 
2.55.0

