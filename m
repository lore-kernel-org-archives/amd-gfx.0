Return-Path: <SRS0=6PJh=FR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A7C4361B
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1532220F
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1532220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9245A89DE5;
	Sun, 13 Dec 2020 22:53:28 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 239DB89E15
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Dec 2020 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R8nYpA4ldcAcNlo2R9kPce04CN/+QYGG5xfA/tDHihc=; b=x+R8fboX5mJw/ycB3+kuYWuK8a
 rD3sYIdF/JicrRhAY8Q95nZDw7/0XFKlBDz3jdU/n5GUAk1gTupH+YRw8J0B80Dna71fEPRYBgA7L
 9eVsbqen09TsDlTd8J/qGRzKLWm6NAXBR1aVoLZN1BrenNpZYTabj9NSDIHtO77ywv4QE6QFy4sG7
 qes6wR95YE5jMY7FSh3OwuuKOcAi/sWyYCt3biFpgDzjbcNvetoUrEL4pXcgBzZnszIN/7ahXoBVP
 XMlOstI8F4E3Q8nRYv8H4rouI5gOOPqj+55rJ4Pbwx++jFATMbRQlDNuQNlEdZDi+xVTFbpKbw+TJ
 a8b/e7Yg==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koaF2-0004Qu-GR; Sun, 13 Dec 2020 22:53:24 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] pci: allow for overriding the list of advertised BAR sizes
Date: Sun, 13 Dec 2020 22:53:20 +0000
Message-Id: <20201213225323.6752-6-devspam@moreofthesa.me.uk>
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

This is intended for devices which are known to work with BAR sizes other
than those which they advertise; usually larger.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/pci/setup-res.c                    | 4 ++--
 include/linux/pci.h                        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c6495a86b280..ce3b8f8fea0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -995,7 +995,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	     rbar_size >= 0;
 	     rbar_size = fls(available_sizes & ~(-1 << rbar_size)) - 1
 	    ) {
-		r = pci_resize_resource(adev->pdev, 0, rbar_size);
+		r = pci_resize_resource(adev->pdev, 0, rbar_size, false);
 		if (r == 0) {
 			break;
 		} else if (r == -ENOTSUPP) {
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 43eda101fcf4..3651754de433 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -407,7 +407,7 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
-int pci_resize_resource(struct pci_dev *dev, int resno, int size)
+int pci_resize_resource(struct pci_dev *dev, int resno, int size, bool forced)
 {
 	struct resource *res = dev->resource + resno;
 	int old, ret;
@@ -426,7 +426,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (!sizes)
 		return -ENOTSUPP;
 
-	if (!(sizes & BIT(size)))
+	if (!forced && !(sizes & BIT(size)))
 		return -EINVAL;
 
 	old = pci_rebar_get_current_size(dev, resno);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dca2778c1738..c7d687370562 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1234,7 +1234,7 @@ static __always_inline u64 pci_rebar_size_to_bytes(int size)
 	return 1ULL << (size + 20);
 }
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
-int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
+int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size, bool forced);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
