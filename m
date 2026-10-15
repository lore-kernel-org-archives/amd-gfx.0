Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07B1CCA48B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BBE112697;
	Fri, 16 Oct 2026 08:55:44 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9636810E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:19:18 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso854114066b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792088357; x=1792693157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lEhb3zN1lMktgIigAcsrDFhn7TsuN5FvDjBWQSOK/08=;
 b=tJIceuLZg3261cLQUJUtk/etOA7QjSf/Y/ull48PFLUyVrxGHMdHSQLfKKSyRD1STq
 UPaS44ApnbfbBOqt1wPysR90+9KuYSATCf+ByvFDYQ3CffI0+PZkgSQpWQ1T81ftHLVP
 z9e2HR24yyhaMOx/PXv6K4bG7eKlh9yeBKU3pXDCpBqfZqxLVr1qOGoZ8pJQFNq4VzZb
 QOhOjnGFl/VdSPMl/M223ATojbfneZK+YtsAvlA7pnnyzzy5aUeHUmeuXw1mbclGshIO
 a616mCfd7bVt5y5nKQmZzGp7dzXtp1rxpJvVQSCN3TT8D7o9dQokvJ029ITuHhbrCog4
 xXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792088357; x=1792693157;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lEhb3zN1lMktgIigAcsrDFhn7TsuN5FvDjBWQSOK/08=;
 b=auvatq+P62hYYvKA28U5ZraaNPyCvfAFcmJBtONxTdZj/6dYrKPXc308vVYgjSLOxZ
 wMnfxuD8WiR3y8CpuvjRpqMR6WwL3pYERHx1+OutjPXGArYimAmjPker+scNg2id8ZBQ
 QstnT6VTMq97EWOLvZOWEV3V6ZgaOVtIDgdr9AkRexf8XUEuhaZXorAd4tYpjAA4lJbw
 u6qjR3jASFcmR8CgS0KIBNYh1kFC3Ou4R/Z5v1B1uHY9IggMx8Z+ZvSwD5z8KCrxcRvq
 +UxnHCMcsZTql5aNCyVu0PY/6EjsuivJFzybtAkPnhavB2Cd4ZmAgZqMwTaU5q3Bt4tB
 5VPg==
X-Gm-Message-State: AFq9FYJXL6AisGVpPAFn+UJEk1OqG5d7Db5wssmITRSKqq1tvbuQ7Pf6
 +o2DleMrsv7RUTtBwrL9Guuu8FHqyJzW8rFlWQyue1ygfJ6B0rsMVdi3S2SJpH7IWq0=
X-Gm-Gg: AYBFou2aWMn4ZlkmF2BGN0oGBp5oNC12dpyJXawsliegKxhh5dQtqxicLIEtvtF3Y4l
 WzbEiVaXHiUTzPX0jpo5j0O9/pRCWFmdfQtSgC2UwyXCnNqfp69+1kzECjwWMnyq/Bzv9IGTmuI
 NEtp+cLF4nnJj+gihLQdNpQE7BX+HXiLpN78pRpc6VEqkQLa0jcPV3Xje9tApWKlY8ksaYARxTZ
 yoMyN8HY36N2JI969xqMTUg0DCPS7/uiv4rHwmLosdZbEXoFEcUxd5qc8nhzskDYndjahrro169
 uP/UrOddm/eH7dSjmoTIoFznMqC3jLiKojub4aiBgTNEZ4zZStUyRIO816Bh96l4vWHtMBPlogE
 4ZlOPYp+fyBbN3XHqhdn8MN+r1qH7fZm5Muih8avjRPfEho23XYP6PFiornDpV5IZQAWXvndPUM
 E9FlmV4Rz/IcvPih6+1+MM/BzpF7YrBzDZ7/lBLayvYgDRgmzA474JSUWCP+Qlqhjk3IP4iK2Px
 b+WDAC7JlH+IQYcWLjm
X-Received: by 2002:a17:907:c60f:20b0:c32:4e81:fe1f with SMTP id
 a640c23a62f3a-c324e820e1emr1129681066b.27.1792088356858; 
 Thu, 15 Oct 2026 11:19:16 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:19:10 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 Andre Eikmeyer <dev@deq.rocks>, Frederick Morlock <me@freddy.us>,
 =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/amdgpu: reset VI ASIC on Apple boards with VRAM at
 0
Date: Thu, 15 Oct 2026 20:18:37 +0200
Message-ID: <20261015181837.41690-4-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181837.41690-1-qchcio@gmail.com>
References: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
 <20261015181837.41690-1-qchcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
bare metal, the driver then keeps using the old layout.

vi_reset_quirks[] resets these boards at load by PCI ID:

  commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Replace the table with the test that SI and CIK use: an Apple subsystem
vendor and VRAM at 0.  Other Polaris MacBookPros then also get the
reset at load, for example the MacBookPro13,3 if its firmware leaves
VRAM at 0.

On the MacBookPro14,3, MC_VM_FB_LOCATION is 0x007f0000 at load, so the
new test covers it.  The MacBookPro15,1 entries fix a module reload
after S3.  With the reset at first load, later posts keep VRAM where the
driver expects it.  The reload failure on these boards is then expected
to go away, but this is not tested.

After the reset, FB_BASE is not 0, so the new test does not fire again
on a module reload.

Only compile-tested.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Andre Eikmeyer <dev@deq.rocks>
Cc: Frederick Morlock <me@freddy.us>
Cc: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a0435fd55..999aeb797 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1387,30 +1387,19 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
-struct vi_reset_quirk {
-	u16 device;
-	u16 subsystem_vendor;
-	u16 subsystem_device;
-	u8 revision;
-};
-
-static const struct vi_reset_quirk vi_reset_quirks[] = {
-	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
-	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
-	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
-};
-
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 {
-	unsigned int i;
 	u32 clock_cntl, pc;
 
-	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
-		if (adev->pdev->device == vi_reset_quirks[i].device &&
-		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
-		    adev->pdev->subsystem_device == vi_reset_quirks[i].subsystem_device &&
-		    adev->pdev->revision == vi_reset_quirks[i].revision)
-			return true;
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
+	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back to
+	 * the vbios default, so reset and post on load to start with the
+	 * vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MASK))
+		return true;
 
 	if (adev->flags & AMD_IS_APU)
 		return false;
-- 
2.55.0

