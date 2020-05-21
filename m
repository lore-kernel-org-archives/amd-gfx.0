Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EECC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A1020756
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A1020756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=improbability.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228DB6E20F;
	Thu, 21 May 2020 20:48:01 +0000 (UTC)
Received: from relay2.stackmail.com (relay2.stackmail.com [185.151.28.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DBB6E20F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 20:47:59 +0000 (UTC)
Received: from smtp1.mail.stackcp.net ([10.4.72.75] helo=smtp1.n4.stackcp.net)
 by relay2.stackmail.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <alan@improbability.net>) id 1jbrp2-0002jI-4x
 for amd-gfx@lists.freedesktop.org; Thu, 21 May 2020 21:29:44 +0100
Received: from slartibartfast.improbability.net ([87.127.90.134])
 by smtp1.n4.stackcp.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <alan@improbability.net>)
 id 1jbrp1-0004gT-KS
 for amd-gfx@lists.freedesktop.org; Thu, 21 May 2020 21:29:43 +0100
Received: from trillian.improbability.net (trillian.improbability.net
 [87.127.90.131])
 by slartibartfast.improbability.net (Postfix) with ESMTPSA id 133342490E;
 Thu, 21 May 2020 21:29:42 +0100 (BST)
From: Alan Swanson <reiver@improbability.net>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: resize VRAM BAR for CPU access on gfx10
Date: Thu, 21 May 2020 21:29:30 +0100
Message-Id: <20200521202931.15726-1-reiver@improbability.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Authenticated-Sender: alan@improbability.net
X-Scan-Signature: d11fac4c5f76761de25f3a616bfa7ac3
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
Cc: Alan Swanson <reiver@improbability.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Try to resize BAR0 to let CPU access all of VRAM on Navi. Syncs
code with previous gfx generations from commit d6895ad39f3b39
("drm/amdgpu: resize VRAM BAR for CPU access v6").

Signed-off-by: Alan Swanson <reiver@improbability.net>
---
Unfortunately cannot test this with my RX5700 on my AMD X470
motherboard as its BIOS "Above 4G decoding" option does not
remap the PCI root bus. Trying "pci=nocrs" also unsuccessful.
However, I assume it's just absent due to missed commit
overlap during gfx10 bring up and should work.

 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index edaa50d85..ba2b7ac0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -686,17 +686,23 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
  */
 static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 {
-	/* Could aper size report 0 ? */
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	int r;
 
 	/* size in MB on si */
 	adev->gmc.mc_vram_size =
 		adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
 	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_device_resize_fb_bar(adev);
+		if (r)
+			return r;
+	}
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
+	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
