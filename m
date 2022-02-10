Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E3AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 08:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CB610E77D;
	Thu, 10 Feb 2022 08:30:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9A810E77B;
 Thu, 10 Feb 2022 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=cT0lgQLRNyTNcmoanfoLYEuqgQBo6jG7fWqTaM2xsVI=; b=WtXnyR0/9o8Ve39JA/IAs6kxRj
 +T3DdMelNYqpGXzKygkC4Y4CtpCWN/6tcAC/dBsxIY5S2HAa1ONMU3A3VdEBKd8Qvvk6phUj9gw8s
 qf0oxMsyITvf3j0B1ovCKTLGKdB+48mCGSFd+7ATgssvTFB5v08ay/qd+SAOe1JHFUn44Io2RZMAQ
 oEZyC2tZhuIyk5ylZU9lCNPDL3mYOudZ6I6bFj6addurE4AP+dLanx1P0RKhpQBRIRt+KUAbiP8q6
 8ffUhMXi1H/nvzHVwM+Lag8Uit/c5OfAwt6VydD4rL2duWM1tbopsEdfKuBA6Pqa7qLP0gPbcPAIJ
 NAo1KASw==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI3te-002sOv-8Y; Thu, 10 Feb 2022 07:29:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 25/27] mm: remove the vma check in migrate_vma_setup()
Date: Thu, 10 Feb 2022 08:28:26 +0100
Message-Id: <20220210072828.2930359-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210072828.2930359-1-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 10 Feb 2022 08:30:06 +0000
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

From: Alistair Popple <apopple@nvidia.com>

migrate_vma_setup() checks that a valid vma is passed so that the page
tables can be walked to find the pfns associated with a given address
range. However in some cases the pfns are already known, such as when
migrating device coherent pages during pin_user_pages() meaning a valid
vma isn't required.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/migrate_device.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 0b295594e7626d..03e182f9fc7865 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -462,24 +462,24 @@ int migrate_vma_setup(struct migrate_vma *args)
 
 	args->start &= PAGE_MASK;
 	args->end &= PAGE_MASK;
-	if (!args->vma || is_vm_hugetlb_page(args->vma) ||
-	    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
-		return -EINVAL;
-	if (nr_pages <= 0)
-		return -EINVAL;
-	if (args->start < args->vma->vm_start ||
-	    args->start >= args->vma->vm_end)
-		return -EINVAL;
-	if (args->end <= args->vma->vm_start || args->end > args->vma->vm_end)
-		return -EINVAL;
 	if (!args->src || !args->dst)
 		return -EINVAL;
-
-	memset(args->src, 0, sizeof(*args->src) * nr_pages);
-	args->cpages = 0;
-	args->npages = 0;
-
-	migrate_vma_collect(args);
+	if (args->vma) {
+		if (is_vm_hugetlb_page(args->vma) ||
+		    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
+			return -EINVAL;
+		if (args->start < args->vma->vm_start ||
+		    args->start >= args->vma->vm_end)
+			return -EINVAL;
+		if (args->end <= args->vma->vm_start ||
+		    args->end > args->vma->vm_end)
+			return -EINVAL;
+		memset(args->src, 0, sizeof(*args->src) * nr_pages);
+		args->cpages = 0;
+		args->npages = 0;
+
+		migrate_vma_collect(args);
+	}
 
 	if (args->cpages)
 		migrate_vma_unmap(args);
@@ -661,7 +661,7 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 			continue;
 		}
 
-		if (!page) {
+		if (!page && migrate->vma) {
 			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
 				continue;
 			if (!notified) {
-- 
2.30.2

