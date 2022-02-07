Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E61C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 09:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA75310F4E4;
	Mon,  7 Feb 2022 09:10:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B707310EAC3;
 Mon,  7 Feb 2022 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=wqaArwblmIFSHxUdNBNekbGuuQV19X++bRGa4XtI21U=; b=lxdZaX9HdECBxS8xbH3caitLbH
 PgJ/rcSWAsPKp0w4j5ndf9woh4inxdIS2JIDFXPeAEbv6jdzH9Jo2ntSfHkuj6mUQ7HTrOAokh5qc
 4is/Xb5dtZG07+ioaAog0Tey/v1edHRBpVlQ/9G50rLriinhvV/d9n8u3P6DkytAHoAIRzQrVcWVu
 qUeK/m7kl6g5AO82aINiKwrYAOVXXo11IEJlHfxptb1ZQ4JeiUUJojms+atQUIJLsKgoZPQaQcKqS
 Ppu19zrTCt3BV/fiLaL5lgHLtEmxSGihd4Tx+0ttgGEEJ7i2vxcU+OqN3HDnjubScKNcKlfoiC4Nm
 uoHWy8CQ==;
Received: from [2001:4bb8:188:3efc:2cbe:55d7:bb63:46d2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGxa4-0099Hh-Pj; Mon, 07 Feb 2022 06:32:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
Date: Mon,  7 Feb 2022 07:32:43 +0100
Message-Id: <20220207063249.1833066-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207063249.1833066-1-hch@lst.de>
References: <20220207063249.1833066-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Mon, 07 Feb 2022 09:10:31 +0000
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
Cc: nvdimm@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>, linux-mm@kvack.org,
 nouveau@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

__KERNEL__ ifdefs don't make sense outside of include/uapi/.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b19223..7b46174989b086 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,9 +3,6 @@
 #define _LINUX_MM_H
 
 #include <linux/errno.h>
-
-#ifdef __KERNEL__
-
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
 #include <linux/bug.h>
@@ -3381,5 +3378,4 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.30.2

