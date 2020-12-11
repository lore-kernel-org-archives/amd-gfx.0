Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134AFC0018C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F1E23DB4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F1E23DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4496E5C1;
	Fri, 11 Dec 2020 00:55:12 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CC96E5B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S++5raZLvfPMXX3uGwnz/PCZiqtMN6zk21K+ikqAPAQ=; b=STwEwayx+V1SkUGDEjbl6lBtHF
 Iqaw51t9sFde30hJCDgW5pDboNyuj5S/88JRtyDxiH75sJki1MS9mesfuek+cvAqkdMEu3SsXgkr5
 VZBD+bi8Dk0Y7HbfVNAda0RhYP6EuYoigRuyVOtXEO9GYjSy7VCvG40FBRi8Vv4AXB9Spdq+xvCyc
 uhZ9YuUyPHPwuMgvjI3HxNg7JBXIBYBe7aId3iIyhcaGfQYSHs5+M8kNLh6ALEIcBcXDKhJIvo6fM
 5uNcnES1CrlSgtPOLm8/iPgrL9TPEx2fq4sRS8I0HCJxB9wcsd9I8BLlISaNkhPH6J/CsTl0CqiBA
 ohomi+wA==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knWiA-0002lw-T1; Fri, 11 Dec 2020 00:55:06 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] pci: add BAR bytes->size helper & expose size->bytes
 helper
Date: Fri, 11 Dec 2020 00:55:01 +0000
Message-Id: <20201211005506.4554-3-devspam@moreofthesa.me.uk>
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

This is to assist driver modules which do BAR resizing.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
---
 drivers/pci/pci.h   | 4 ----
 include/linux/pci.h | 9 +++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8373d94414e9..9a3837a30369 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -609,10 +609,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 #endif
 
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
-static inline u64 pci_rebar_size_to_bytes(int size)
-{
-	return 1ULL << (size + 20);
-}
 
 struct device_node;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5aa035622741..5eee18969fe8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1227,6 +1227,15 @@ int __must_check pci_assign_resource(struct pci_dev *dev, int i);
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
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
