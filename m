Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB40C55181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21FB206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eoFRErMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21FB206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418506E9B8;
	Wed, 22 Apr 2020 06:54:58 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B0F89AEB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 00:21:48 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id l78so727535qke.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3AJD6Oyv0KkjbAk8YeqvLT90vRQu+LIvDFZSopXsRbA=;
 b=eoFRErMA4gp+OK9MtuQ4K4bjXWkeBBeQPbFumCt3H5LHNkqaTX6DBvgor6rkgnO1M7
 rT91T1rPd+vUOAuTDV3NLDyP9NSb9xUHfuPuy1IbETv5fwpEBXwKwar5O8GmjdAlhT1f
 EvU1RP/AaSISFodw/P7iQGUHxtiRd4g80nJIOANv8h9J5b8JidJW1h1FPkCoaZFW2ORG
 wSaif0wopRKyY4vU/o1KkYbu9U/APRXAoQ94U4hSff0L7IxLBX6DYBR7aagLMjZCu1TV
 Wi64MfEMrxnx21mOo5TUh76Znt2Ow3oyfXWzQh+PxqT1pTzAI+rGR4eUGUNVXiIu6XsH
 MOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3AJD6Oyv0KkjbAk8YeqvLT90vRQu+LIvDFZSopXsRbA=;
 b=Q0wkZeZJQeiJdnAZlm9WRAq9K7gMsqwg5me4oF8wzTY/2OwSn0sszinDvgDIoSJxXl
 ldHB+VaIY8l9WOgzCd/HdsPyIsDOnR/R7V5/kgXwO963p324aNZTI//chmIcL0A6fnLH
 uujN2HlwDx5v9b4J3F/ThtNQ9qbuTITBgsLR8betPzCtTn6Nk97V/C6eRqSorMp7PDu/
 r9H22s8XnhyKkiIXxtsNn8nLA5TvJtmQ5+4E7vwTnjY2jfeadbveC1+GhbCrrEno4YR/
 fLlfRkwwHf9oQzq6frzHxo1s074NwdFab8sj+uTbfSumvtPPayrr+6q1tmJkIyUY8EhQ
 C5ig==
X-Gm-Message-State: AGi0PubCAdw0qlXEUF8bxNqwgP6KLUCww18NTFMXyIjIFS/nGB7F6hjh
 fWQWzN69y4KouoIgCG1GWtzIYA==
X-Google-Smtp-Source: APiQypL7V4/8cAx/9ZlxeBiNsXj+Qtd7NYDaEN35jT+/a0xFMxv1zWFbIOqW9KBRUrqtUtHkDyTw4A==
X-Received: by 2002:a05:620a:249:: with SMTP id
 q9mr9360042qkn.389.1587514907240; 
 Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id 18sm2866823qks.98.2020.04.21.17.21.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Apr 2020 17:21:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jR398-0000Az-C2; Tue, 21 Apr 2020 21:21:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH hmm 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a select
Date: Tue, 21 Apr 2020 21:21:42 -0300
Message-Id: <1-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Apr 2020 06:54:54 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

There is no reason for a user to select this or not directly - it should
be selected by drivers that are going to use the feature, similar to how
CONFIG_HMM_MIRROR works.

Currently all drivers provide a feature kconfig that will disable use of
DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
they don't want the overhead.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/powerpc/Kconfig            | 2 +-
 drivers/gpu/drm/nouveau/Kconfig | 2 +-
 mm/Kconfig                      | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a926008..8de52aefdc74cc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -455,7 +455,7 @@ config PPC_TRANSACTIONAL_MEM
 config PPC_UV
 	bool "Ultravisor support"
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	depends on DEVICE_PRIVATE
+	select DEVICE_PRIVATE
 	default n
 	help
 	  This option paravirtualizes the kernel to run in POWER platforms that
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index d6e4ae1ef7053a..af5793f3e7c2cf 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -86,10 +86,10 @@ config DRM_NOUVEAU_BACKLIGHT
 
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
-	depends on DEVICE_PRIVATE
 	depends on DRM_NOUVEAU
 	depends on MMU
 	depends on STAGING
+	select DEVICE_PRIVATE
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	default n
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c358c..7ca36bf5f5058e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -805,15 +805,10 @@ config HMM_MIRROR
 	depends on MMU
 
 config DEVICE_PRIVATE
-	bool "Unaddressable device memory (GPU memory, ...)"
+	bool
 	depends on ZONE_DEVICE
 	select DEV_PAGEMAP_OPS
 
-	help
-	  Allows creation of struct pages to represent unaddressable device
-	  memory; i.e., memory that is only accessible from the device (or
-	  group of devices). You likely also want to select HMM_MIRROR.
-
 config FRAME_VECTOR
 	bool
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
