Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F43CCA490
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB1A11269B;
	Fri, 16 Oct 2026 08:55:45 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974F110EA98
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:19:09 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c3f8d72d7ceso143410766b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792088348; x=1792693148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
 b=fna2XrcBO9QBN7HXpz38Fpbuw/kvUMh1TTlAhGd+vFwUo5dZ6O6UKR4Y1b5Gi+J2Bb
 N9P12TP07L7k5BzcbsnQD6z0HYOWRjQnBZNf4VhFlHL2QjrkgpWGAAK/VMASFOnlIZTp
 jDQyhicEX23PKoktnKCz2vPL0cmPijKUiXiF87rdEYOqosFZV3TkG6au5calDvcIujYJ
 lqu8KL+pkePu5KfQZeH5e+fHwmttKQF36PrnFBvts9n0P8UWTX5RgnCILODeUosp1WTz
 h3dDbcSI/Z9kTMJQ3ILsGI9N9Fq9w01H1IajxCr+zDtuId3PtS1ZkzbT+mUtBEm9ki3V
 UXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792088348; x=1792693148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0BT3ak9vMatktLwT+0i2Bx2HTKVL1fUGlR0dbooOuoI=;
 b=FrV7fNar5i4prpyn4DJvjkvQeb2y9C2vJ8SWXEobqGff9ImqSNQiiDi86QmnjaSSup
 WzOUKDTpexmeL2zoKot9918zGfiOidCBcVmICUMM4/40RWJ73FduUTW/mZQ+rzLJEqHh
 53Q91IOZ2ij5kYhLkUYrzghf5yOh0WR+BcrTlxyi5e7v8hT2lpxNPyCWFqno3FM6/HHK
 JKvNv2myZEzgqv+0famX1xpxnrQYGs63EDBEd6+dSvDWb7mqyKikeHthsb4fN+v0FAq5
 jeqZDcEn+/UFsrfMcgaJ+YtGTiimz1jqDLtIzyQY2UZxepCotTLnte/Hw+dcIWO42LBr
 iAPw==
X-Gm-Message-State: AFq9FYKBhWXiclMje3d6LINtWG5i2KB8apfDD4KXPvsEfHVlU9xqABxI
 NCu/cSBg2E1EP0+kRdT+1TablnpB/CgT3B4w0kwYtC64d0HhRzejdh6hdpSmSzXLLXI=
X-Gm-Gg: AYBFou0KlRmZY/k024JX0ou+D7A8+IlVVzr/s6rhEx17YU2yYyhvSp77VkyB/uAb7qZ
 KkguMh9CwGXr2Gfb8JXepAtUZjqJm4k7zQyCXa3DTQD0Oc0FWcjuaJY2O9bv5deMF7ebt60mjTz
 +8rn+WyRHi777zVktoOKIU/3PjBAOofk5AarqsDG2FA8GQbX0BXJPkdK8bFV3b/fdeMD6OjN1++
 HVscPNEYwqBlis87FIzm5GJvn9ooCa2fXeKjTP9DknAxO1Szw8waOc+qXj5JzKI5ZwVyCMh2Icy
 n5SGgrLs5HuiGNeNyec7AV2C6xXfka/5VJ/h51fBSiUgJc+x5sQk3noRm/AS2nUHxcoWtDTgA3b
 7aQhmcDkEq9+BKlXpPB73KEGZ9f8dL9j9wOAbEnXVXbpbIT246mwQgammaI1c+/5xwuGaITztHk
 ZdY3hI3Zx3tdYWcUE3v6XKH++bSauZ+SnoijPDpNbO5Y/KtXQcTEXmrffKIQ/cCt0i7NR8MCFKv
 tbXEZm2PT8XM7+OKIpi
X-Received: by 2002:a17:906:d54f:b0:c2e:7fe7:289f with SMTP id
 a640c23a62f3a-c31a9d31c9dmr1819431666b.25.1792088347810; 
 Thu, 15 Oct 2026 11:19:07 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:19:05 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/amdgpu: reset CIK ASIC on Apple boards with VRAM
 at 0
Date: Thu, 15 Oct 2026 20:18:36 +0200
Message-ID: <20261015181837.41690-3-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181837.41690-1-qchcio@gmail.com>
References: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
 <20261015181837.41690-1-qchcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 08:55:44 +0000
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

