Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A0DCC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 12:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E542E10EA11;
	Thu, 15 Oct 2026 12:56:29 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0393B11229D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 09:58:30 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6aa9164072cso7625498a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792058309; x=1792663109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6qvl8uPBElqhzytuAE7BkBQ1TnHFeTQQ5pxPHhsWis=;
 b=egIlLbP6jyEpeyJnhMfqLnj5eIFJYHjxjdxphyqMRH33w3FDC8QH7Z5irH0Cr/nw66
 T6V++GKuFLPf+ZeJB1quDyr7Q+pHoxxOHVVsKYnOK4MFe+hIZRCH/osd8HA4RV2V0Cgp
 YySSZ64i28+MH6GhBR0FMtxDXiIKskUApP39LFD4n/rk3yWCLrBhCkLNIfduHGQ506OI
 qzwl9B17lq56w5UF8FvNhym65UdcABdzW40eh1a5ZsPPNo/bUdsxI9VEX2nLM1TZhlG9
 awL/LuYNDEpo/MjEBM9IhLal0WNQAO366MP0IeDAjU8gyUy2IvZX9jhftv+xd6BB4/xo
 sFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058309; x=1792663109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6qvl8uPBElqhzytuAE7BkBQ1TnHFeTQQ5pxPHhsWis=;
 b=IJ0IcnW1FZc3tpNNJtMgNp7L8q+dAtJm4hhnwxOzy/QSrCA5i3pYrlu72xPyEGzKPg
 IMrQrhW//Jv0NyAHGWVdKkG4XKrctTTLnnvjmmu/2uwGOctHBq+dbYPOJR/0AMnr43Pn
 6SUNJh9dpswJPkbM9xnlN7pVG8HSnyt+OOG7oPiHuCxGfI5g1o9SXWspOqYv9YKHEiFt
 raQf7Bq1nFoBbkGPn1IrCs++maxScv4T1CGqkHHy5tt3I+hvom0y3B3XrScCuCF9HABv
 a3XPCPD87NkornXKWSsAQI3IPOI0HGXm/1RaEDAa3cJdChUA91pJawzgYxRXyTm/DxOq
 SKPQ==
X-Gm-Message-State: AFq9FYL8szvRoGUGu7X+YnlzP04zKTHKb1T717jeHe14LKeqFIVcNQCo
 L9PfSNLyq3GpCU8ae1lw4rYTDGSLgKABGQxuxlW73wlYtkai4I/Aq/194OlQQ4O5Rkw=
X-Gm-Gg: AYBFou2h3fKmUj7zohtmvyDpuX/VAZfhbLdPEsVKPSbntEwVjGREg5O+PhFZrzcwR12
 9fZcAsc8TyhEPGKxsLNvw0q6a4cPU2DQyv8KD6w8NXnOU4cF/64ZCs3oyp6DoeGerW/ravjh16L
 hNGEFlem6TGIaCCPed5C2TNptph33khcBomfcOwec6HSot8ufNaZnF1bSvXQJo2gnNfWEe/jcCC
 8VIbWq3mb1POh+1XlKxRAEw5Dxz+zCSZeNTvmXRhZesMur3SgL+WqmNjAscFB9+hk3AvX9mb9Pu
 KIQYurCpigTVS0spgqT1THPs6gWKvWdowp12l9cRlDvtA9QTW5AoUgNGlwXyauncw5PIxN+iAmw
 miFxXQ3T+qTGgI5tj53p1mDgDVgDK7V8s7TTytkQimbG/xxrtG6mBgquHaOcDpsXClYctYoTs4s
 Nw5bPd4rQt/iD6cjCo+FBI60q3gKrOPlqY5umrRPagKi0eY9NjoIFEiuZLnfodMjzLBZffWM0u/
 uWRE8/SbkZA++mlGU08
X-Received: by 2002:a05:6402:4341:b0:6aa:9830:aa21 with SMTP id
 4fb4d7f45d1cf-6b17c27b50cmr13522035a12.39.1792058309194; 
 Thu, 15 Oct 2026 02:58:29 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b2038aa1aesm2182227a12.32.2026.10.15.02.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:58:27 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with VRAM at
 0
Date: Thu, 15 Oct 2026 11:57:13 +0200
Message-ID: <20261015095713.20560-4-qchcio@gmail.com>
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
reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
bare metal, the driver then keeps using the old layout.

vi_reset_quirks[] handles this for the MacBookPro14,3 by PCI ID:

  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Add the test that SI and CIK use: an Apple subsystem vendor and VRAM at
0.  Other Polaris MacBookPros then get the same reset at load, for
example the MacBookPro13,3 if its firmware leaves VRAM at 0.  These
boards are not tested.

Keep vi_reset_quirks[].  Its MacBookPro15,1 entries fix a different
failure, a module reload after S3:

  commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")

VRAM is not at 0 at that point, so the new test may not cover it.

After the reset, FB_BASE is not 0, so the new test does not fire again
on a module reload.

Only compile-tested.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a0435fd55..cad6bbfce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1405,6 +1405,16 @@ static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 	unsigned int i;
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
 	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
 		if (adev->pdev->device == vi_reset_quirks[i].device &&
 		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
-- 
2.55.0

