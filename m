Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31EC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08AF2074B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08AF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A266E0C6;
	Tue, 15 Dec 2020 01:09:06 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919D46E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LYAKmIxtrK+kH2QeM0Im/tjE/RBuc9fpbJsNF/EBqr8=; b=eQLXM4A1Lw8phM9z0LtrEXqS27
 3zZt+wgjEzAjaOUkTd3LxAif9pO9SDGAUft9tRFDySNr/Nu4G8PUR12FRvEh4StPSDZmxV9ayBz3X
 InAqAncOu6H1lfL+XtY8ZfCmL3YcpUCCiB+W09MKnm3XhAaOuQzEsQBwkQqM1slZZ0UT1l6NcPIuQ
 2rFI294FtPFYDGwRPHkBsLPopdQ1zaG9ZPYi7HBUG8/PDHy5X5EzfEFqglM3VW8mo9EiSEpS7XCGu
 iNtKQm8vlKq8gDYXYrzuxFrcAjKxwjXzhFBm5IHfUNN2ADvRuDZQMVkykjy4plEKJokaSbGTVOA2p
 hFC/q0MQ==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koypr-000334-95; Tue, 15 Dec 2020 01:09:03 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] pci: add BAR bytes->size helper & expose size->bytes
 helper
Date: Tue, 15 Dec 2020 01:08:56 +0000
Message-Id: <20201215010902.18945-3-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
References: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
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

This is to assist driver modules which do BAR resizing.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
---
 drivers/pci/pci.h   | 4 ----
 include/linux/pci.h | 9 +++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 640ae7d74fc3..0fa31ff3d4e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -610,10 +610,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
-static inline u64 pci_rebar_size_to_bytes(int size)
-{
-	return 1ULL << (size + 20);
-}
 
 struct device_node;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9999040cfad9..41e93ea9756b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1226,6 +1226,15 @@ void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 void pci_release_resource(struct pci_dev *dev, int resno);
+static __always_inline int pci_rebar_bytes_to_size(u64 bytes)
+{
+	bytes = roundup_pow_of_two(bytes);
+	return order_base_2(((bytes >> 20) | 1)) - 1;
+}
+static __always_inline u64 pci_rebar_size_to_bytes(int size)
+{
+	return 1ULL << (size + 20);
+}
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
