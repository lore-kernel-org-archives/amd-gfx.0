Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85AC54FCF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 08:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57E020409
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 08:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j2Fj9mGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57E020409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BCC6E466;
	Tue, 24 Mar 2020 08:14:18 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73196E43B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 01:15:14 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id l25so12845031qki.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 18:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BtjvXIRl7JvjxGCCwhwKty2zmKTxYCK8uhb2/phXd0E=;
 b=j2Fj9mGGXkb0s5jfx+PaOyQglxSKvi9DzQ14cmVcTgbF31/1q+wroCRgzrwp6o0lQ/
 PMrHTYwMUGlLwsiNJF2XuxvJX4Aj6pKrULOtMy1PyM1vypcNPVUYzBmwCBJNESpWOsyS
 JOkIyj3fbVfemR9nxyftNMco7DJxkZ6NYasYiV3jSGP2jWoKOaqJekhfAVS0HndDoMRY
 sEKvbkkAiciWAwNov/v7Qg1GYL8sIHnYstAwrJO22Txcxgv2IyW8RiB5s9/XVFJogf6L
 DJNCkbc11+nvZK7Tq18ykvSovfN4GbCtjxmOr3RGIWx/7vmJWd3LSencrwufu6ElenGz
 CxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BtjvXIRl7JvjxGCCwhwKty2zmKTxYCK8uhb2/phXd0E=;
 b=UX5jlsBVXuNSUB30a+jGY2nlRJZJPZLv8Q1pterIkk1AWadt6hadHqDQy73+6e88nO
 zLCHfHjjY8zZa4H5uSnf490rpJD5g9l1aho5941Aw3/CK6mQGxI0sv3/XzT2QjmZtyq0
 xhV0a6zPucpze7hGNTcDJ3KiGkYwbTPSTQlXi7gBNCg8acNiw0LsT6VK+1fpdE1b4oDp
 t7MBfGNgNFWMPe8YQ0lGDOFZ8uWswfxaZYOEeqNkkU+5vSCeZfr8hV8ODqZRWXCqanwq
 r8v8Dl/FNmuQFME+BN2ut62xMebbFfTmAuuxuo4A8C+pMV6jso9IFGYrFFOxJ3MrgDUH
 iZGA==
X-Gm-Message-State: ANhLgQ3XwiRiUc6+Pk7G/txY25eUJG5NuUBYrsIPu1tFmTghf7jTdoqy
 FrIN1tTO+9lGIZNW2GVxErFYCQ==
X-Google-Smtp-Source: ADFU+vuqtjILT193yy1E1b2Co21btJLxUdSeIXs67XJc39y6GefW1zq10kzN67rE1jTtVo2ZUkW7VA==
X-Received: by 2002:a37:9a81:: with SMTP id
 c123mr18495488qke.176.1585012513991; 
 Mon, 23 Mar 2020 18:15:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id 199sm12325170qkm.7.2020.03.23.18.15.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Mar 2020 18:15:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jGY9u-0000rI-Aa; Mon, 23 Mar 2020 22:15:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 6/9] mm/hmm: use device_private_entry_to_pfn()
Date: Mon, 23 Mar 2020 22:14:54 -0300
Message-Id: <20200324011457.2817-7-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324011457.2817-1-jgg@ziepe.ca>
References: <20200324011457.2817-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 24 Mar 2020 08:14:14 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

swp_offset() should not be called directly, the wrappers are supposed to
abstract away the encoding of the device_private specific information in
the swap entry.

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f59e59fb303e95..e114110ad498a2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -266,7 +266,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 */
 		if (hmm_is_device_private_entry(range, entry)) {
 			*pfn = hmm_device_entry_from_pfn(range,
-					    swp_offset(entry));
+				device_private_entry_to_pfn(entry));
 			*pfn |= range->flags[HMM_PFN_VALID];
 			if (is_write_device_private_entry(entry))
 				*pfn |= range->flags[HMM_PFN_WRITE];
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
