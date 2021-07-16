Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A718C636CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 07:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EE7611AE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 07:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EE7611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905C66E924;
	Fri, 16 Jul 2021 07:13:15 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49F66E90E;
 Fri, 16 Jul 2021 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=VR1glNZml+cTngi5rUbI6ULJ1OKrHv//v+DP7nQTGl0=; b=dzDy1eMNhsQwHC+WQNrYul8CWx
 Y6mW9QCyzhNbeeF0ctSnl3+YbpQ8Jh9vBAmic9Pbe9HZIFMJjlhdYcuQdGMTOYsGDmFtk7dbnIHyt
 hI8ustbwqloWrGN2tDNDY5bLp8yNvxuAcROI2N9dkeq1cmvCK2zCYRaeoFlihgD1gqTIhoqJ6byaz
 /491z9uRA1UAhyS7qHI0TPdWk/MJtxfOdOxQgjZAjN15C/A4ELKuJzf909nFSuQyH6WDwwXA25LoL
 YZWipdUHiN6IwSrcqZJ1UCiJAo4J1RaoRhFwvTIgsWSxbOtZwe924AkvrIMeKh7g6vBYZg6eAMQ91
 IA/x8RVQ==;
Received: from [2001:4bb8:184:8b7c:6b57:320d:f068:19c6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4HAg-004CuL-CT; Fri, 16 Jul 2021 06:18:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 3/7] vgaarb: move the kerneldoc for vga_set_legacy_decoding to
 vgaarb.c
Date: Fri, 16 Jul 2021 08:16:30 +0200
Message-Id: <20210716061634.2446357-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210716061634.2446357-1-hch@lst.de>
References: <20210716061634.2446357-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Fri, 16 Jul 2021 07:13:14 +0000
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
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, kvm@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, intel-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kerneldoc comments should be at the implementation side, not in the
header just declaring the prototype.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/vga/vgaarb.c | 11 +++++++++++
 include/linux/vgaarb.h   | 13 -------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index fccc7ef5153a..3ed3734f66d9 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -834,6 +834,17 @@ static void __vga_set_legacy_decoding(struct pci_dev *pdev,
 	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
+/**
+ * vga_set_legacy_decoding
+ * @pdev: pci device of the VGA card
+ * @decodes: bit mask of what legacy regions the card decodes
+ *
+ * Indicates to the arbiter if the card decodes legacy VGA IOs, legacy VGA
+ * Memory, both, or none. All cards default to both, the card driver (fbdev for
+ * example) should tell the arbiter if it has disabled legacy decoding, so the
+ * card can be left out of the arbitration process (and can be safe to take
+ * interrupts at any time.
+ */
 void vga_set_legacy_decoding(struct pci_dev *pdev, unsigned int decodes)
 {
 	__vga_set_legacy_decoding(pdev, decodes, false);
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index ca5160218538..fdce9007d57e 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -46,19 +46,6 @@ struct pci_dev;
 
 /* For use by clients */
 
-/**
- *     vga_set_legacy_decoding
- *
- *     @pdev: pci device of the VGA card
- *     @decodes: bit mask of what legacy regions the card decodes
- *
- *     Indicates to the arbiter if the card decodes legacy VGA IOs,
- *     legacy VGA Memory, both, or none. All cards default to both,
- *     the card driver (fbdev for example) should tell the arbiter
- *     if it has disabled legacy decoding, so the card can be left
- *     out of the arbitration process (and can be safe to take
- *     interrupts at any time.
- */
 #if defined(CONFIG_VGA_ARB)
 extern void vga_set_legacy_decoding(struct pci_dev *pdev,
 				    unsigned int decodes);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
