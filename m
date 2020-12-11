Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CEC4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F119B23DB4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F119B23DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934716E5CD;
	Fri, 11 Dec 2020 00:55:14 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD3E6E506
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PljTzuNFtjsFgYgx3zr/6ki0gwe38T6MiYc1BUyz9Ao=; b=NX/WDQKI78tYPtZdqeiPep+rKb
 FI6/n4l1Rel23XVX7BqvVeoTl/6cyw+PtP3Ly32/+BKP8cSijCkqt9GqbkMhTgOU2OmVHDkIrtrn/
 yFBudCUS5v0TmKeK43xbdSxMtdHSpy8oaHP80w5Lq10SGl0hgHqvAT0blBvjQ7IUyU1MRVsiV6yDj
 D01F29kUi//HKT1zwqapc/W0UYDDE5d8/aiorASDmi4J6X6uvP3ay/+yYKuRJlYtCTrC0RDLN5yo9
 KF6aQiTKHom7rFlFHc40kQN37S2wLCiEzw11EBPmUrBYfwDvGbiRMMbrfxbYOUNArpo/m0CGJRcaX
 5E0WO/MA==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knWiB-0002lw-Ib; Fri, 11 Dec 2020 00:55:07 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] pci: allow for overriding the list of advertised BAR sizes
Date: Fri, 11 Dec 2020 00:55:05 +0000
Message-Id: <20201211005506.4554-7-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
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
 drivers/pci/setup-res.c | 4 ++--
 include/linux/pci.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 5eee18969fe8..f33494d92512 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1238,7 +1238,7 @@ static __always_inline u64 pci_rebar_size_to_bytes(int size)
 }
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
-int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
+int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size, bool forced);
 
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
