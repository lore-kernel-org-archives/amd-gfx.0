Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F72C33CB3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 23:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D89C2467A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 23:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoGMW7Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D89C2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2E66E075;
	Tue, 14 Jan 2020 23:41:47 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B346E075
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 23:41:46 +0000 (UTC)
Received: from localhost (mobile-166-170-223-177.mycingular.net
 [166.170.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F115724658;
 Tue, 14 Jan 2020 23:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579045306;
 bh=RsuImxKncFh921sEhbYmo2hrm0xBmtsUawKwojC/cxY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=aoGMW7Ylbi7mAlxbAkz9U6f9POkDbrJ2bADfo97cwN5JCmoNny4DH/i9OgAiHNwtG
 vyZh/4NJ7AW/mvgSGIQ7ktD+XrhveMW4zz6g9dhhHwzm/h+Xt9fEnvxpke8nftv5Za
 4pumKkS331yyTD+3/rIOvi9TTdVaJEWUwpBB4Ptg=
Date: Tue, 14 Jan 2020 17:41:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
Message-ID: <20200114234144.GA56595@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114205523.1054271-1-alexander.deucher@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-pci@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> We've root caused the issue and clarified the quirk.
> This also adds a new quirk for a new GPU.
> 
> Alex Deucher (2):
>   pci: Clarify ATS quirk
>   pci: add ATS quirk for navi14 board (v2)
> 
>  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)

I propose the following, which I intend to be functionally identical.
It just doesn't repeat the pci_info() and pdev->ats_cap = 0.

commit 998c4f7975b0 ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jan 14 17:09:28 2020 -0600

    PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken
    
    To account for parts of the chip that are "harvested" (disabled) due to
    silicon flaws, caches on some AMD GPUs must be initialized before ATS is
    enabled.
    
    ATS is normally enabled by the IOMMU driver before the GPU driver loads, so
    this cache initialization would have to be done in a quirk, but that's too
    complex to be practical.
    
    For Navi14 (device ID 0x7340), this initialization is done by the VBIOS,
    but apparently some boards went to production with an older VBIOS that
    doesn't do it.  Disable ATS for those boards.
    
    https://lore.kernel.org/r/20200114205523.1054271-3-alexander.deucher@amd.com
    Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
    See-also: d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken")
    See-also: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..fbeb9f73ef28 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5074,18 +5074,25 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
 /*
- * Some devices have a broken ATS implementation causing IOMMU stalls.
- * Don't use ATS for those devices.
+ * Some devices require additional driver setup to enable ATS.  Don't use
+ * ATS for those devices as ATS will be enabled before the driver has had a
+ * chance to load and configure the device.
  */
-static void quirk_no_ats(struct pci_dev *pdev)
+static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
-	pci_info(pdev, "disabling ATS (broken on this device)\n");
+	if (pdev->device == 0x7340 && pdev->revision != 0xc5)
+		return;
+
+	pci_info(pdev, "disabling ATS\n");
 	pdev->ats_cap = 0;
 }
 
 /* AMD Stoney platform GPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
+/* AMD Iceland dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
+/* AMD Navi14 dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
