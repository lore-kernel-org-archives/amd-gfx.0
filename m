Return-Path: <SRS0=6PJh=FR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B22C0018C
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266EF2220F
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266EF2220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BC189E2B;
	Sun, 13 Dec 2020 22:53:29 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E7E89E38
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Dec 2020 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uQ8fK930B+jaBjA3cmT4gmsgM95LRL09TjhMN9sB9Us=; b=DlJhc7mbm+7ntBfyDyN0tCvMcG
 QM1mQgP+4JD11bHLkqdR4iZO8C/LaOv1bB77jr5vVgBZw1+ssN/8XuPTFtMBLWOE2YCEfrpEys7dO
 g6WLnvJ2IgH1D4tZihCu4kCO73W2ZcCVBhfKMdtvdKYyIN2xslaTo5QDctv7G13SDG1l8bCmZBv/E
 pqzG1WNzqg9ooVLWzt/CyN+gnDik97cRhl+bF5zy2NF0CpMISLcn+n9Fla3tdoU35TCRDvyRAodBO
 q0FYflSsRqIATcLSQW5M/pQVVCviEJAdlBgsfa858kvRYlU/PmEFUU+R1W+DgzoEQvYOTyb9J8xlx
 HLZux1Ww==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koaF2-0004Qu-Rl; Sun, 13 Dec 2020 22:53:24 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] amdgpu: implement a BAR size quirks list
Date: Sun, 13 Dec 2020 22:53:22 +0000
Message-Id: <20201213225323.6752-8-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201213225323.6752-1-devspam@moreofthesa.me.uk>
References: <20201213225323.6752-1-devspam@moreofthesa.me.uk>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: Darren Salt <devspam@moreofthesa.me.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Intended for devices which are misreporting available/supported BAR sizes.

This may be insufficient to identify some devices. The inclusion of the
reported BAR sizes bitmap is to assist with identification.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0f05a75be34e..442eca5fc6a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -897,6 +897,34 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 		__clear_bit(wb, adev->wb.used);
 }
 
+static const struct amdgpu_rebar_quirk {
+	u32 chip_vendor, chip_device;
+	u32 subsys_vendor, subsys_device;
+	int reported_sizes;	/* 0, or as reported by pci_rebar_get_possible_sizes */
+	int available_sizes;	/* bitmap (-256 for anything >= 256MB, effectively automatic) */
+} amdgpu_rebar_quirk_list[] = {
+	{ 0, 0, 0, 0, 0, 0 }
+};
+
+static int amdgpu_rebar_quirk_check(struct amdgpu_device *adev, int reported_sizes)
+{
+	const struct pci_dev *pdev = adev->pdev;
+	const struct amdgpu_rebar_quirk *p = amdgpu_rebar_quirk_list;
+
+	while (p && p->chip_device != 0) {
+		if (pdev->vendor == p->chip_vendor &&
+		    pdev->device == p->chip_device &&
+		    pdev->subsystem_vendor == p->subsys_vendor &&
+		    pdev->subsystem_device == p->subsys_device &&
+		    (!reported_sizes || !p->available_sizes || reported_sizes == p->reported_sizes)) {
+			dev_info(adev->dev, "quirk: overriding BAR possible sizes list.");
+			return p->available_sizes;
+		}
+		++p;
+	}
+	return 0;
+}
+
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
@@ -918,6 +946,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	u16 cmd;
 	int r;
 	bool nospc = false;
+	bool override_bar_sizes = amdgpu_override_bar_sizes;
 
 	/* Bypass for VF */
 	if (amdgpu_sriov_vf(adev))
@@ -954,10 +983,16 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (!res)
 		return 0;
 
-	if (amdgpu_override_bar_sizes)
+	if (override_bar_sizes)
 		available_sizes = ~(-1 << rbar_size) & ~0xFF;
-	else
-		available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
+	else {
+		int q = amdgpu_rebar_quirk_check(adev, available_sizes);
+		if (q)
+			override_bar_sizes = true;
+		else
+			q = pci_rebar_get_possible_sizes(adev->pdev, 0);
+		available_sizes = q;
+	}
 
 	if (max_size >= 0) {
 		/* Cause larger sizes to be ignored unless that would leave
@@ -999,7 +1034,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	     rbar_size >= 0;
 	     rbar_size = fls(available_sizes & ~(-1 << rbar_size)) - 1
 	    ) {
-		r = pci_resize_resource(adev->pdev, 0, rbar_size, amdgpu_override_bar_sizes);
+		r = pci_resize_resource(adev->pdev, 0, rbar_size, override_bar_sizes);
 		if (r == 0) {
 			break;
 		} else if (r == -ENOTSUPP) {
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
