Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F8C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A04720709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WmQkIo8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A04720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5336E1D8;
	Fri, 20 Mar 2020 17:21:30 +0000 (UTC)
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6611E6E1A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 16:59:28 +0000 (UTC)
Received: by mail-vs1-xe43.google.com with SMTP id o25so696270vsp.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xRjX7T7eft/qC+6bf7FfyU/mPCvn6DuztC5RzuHCyVc=;
 b=WmQkIo8wgTcT+49UEOC761MjUtOoLumkxcQrNLGTV5XIF/8lT1bx+3pCSL8T9xMdZY
 cWLs8vQSQKBV1VXMxQM5NR78QAl2OuRSqAVNbbPsuMvJzg/GjnWpmqSoglfFIAkV31+z
 MP+DUTjrCLJ6J7p5c6jvdGCaDAE5JuorkDPWMCl3cc8f1/br3nbePeINlV2no2Zpv0lA
 x996mvxPsYAJubp73Du4S2nS/wtnN/9QxMhJQCWR+gg4WbHEtK82IFnTkGk0BMjclTq/
 UasFQVqNKpkfmX/un/MPsIzZfDYZXMiTwx9ovm8X8Wk5Xzm8VVcGiy4D9LEPu/vagLD/
 G03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xRjX7T7eft/qC+6bf7FfyU/mPCvn6DuztC5RzuHCyVc=;
 b=GpbKT5M1GQo+67NxUaSJjWjsLUFETtrQjQB2Vj9V9L1ynwY3EhUOflWlkDgmAVYb8u
 a7ydNfpIwEzVO+V4rCgVEcrqVFRN3uABiJg8i2/w3fBJ12pO/+iqvTWePN6B7HuvIWkI
 6otcjhaH9Zu0tw6JM6hSNQ3w9wjK3/qhIgpRFe5D+BBkhlASzke6dJV+CXvEEieemy0a
 PZQaZ/bU/8wt1LF7rvCpfubXQ+8dDjLLewOO+LAWqKqC3IbgI9cr2ZdCB6zhd149eBzp
 DQwYB1ptMFZKYNBH406XUnJR3r3qS1weOo2l2suv986fsfruW40OgAD/X78YtoBvCp89
 E0ew==
X-Gm-Message-State: ANhLgQ2xolOAnW7wTqWhKEO2XD2TRPARYyPFomv0p+bH2ecJxw4KGk9w
 4codlZQmz2K6tUAWk7LmEcueKF1w9I+PLw==
X-Google-Smtp-Source: ADFU+vtbRR/MYq87zJZvXdzKsxYqiR4x6njtZJXIu9qf6nhgSPf391EA27m+Q0Bt/DeLj3EN/58FoA==
X-Received: by 2002:a05:6214:12c7:: with SMTP id
 s7mr9363766qvv.218.1584723027380; 
 Fri, 20 Mar 2020 09:50:27 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id e2sm4452824qkg.63.2020.03.20.09.50.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 09:50:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jFKql-0005kU-FT; Fri, 20 Mar 2020 13:50:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH hmm 6/6] mm/hmm: use device_private_entry_to_pfn()
Date: Fri, 20 Mar 2020 13:49:05 -0300
Message-Id: <20200320164905.21722-7-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320164905.21722-1-jgg@ziepe.ca>
References: <20200320164905.21722-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 20 Mar 2020 17:21:22 +0000
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

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a09b4908e9c81a..fd9ee2b5fd9989 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -259,8 +259,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * the PFN even if not present.
 		 */
 		if (hmm_is_device_private_entry(range, entry)) {
-			*pfn = hmm_device_entry_from_pfn(range,
-					    swp_offset(entry));
+			*pfn = hmm_device_entry_from_pfn(
+				range, device_private_entry_to_pfn(entry));
 			*pfn |= range->flags[HMM_PFN_VALID];
 			if (is_write_device_private_entry(entry))
 				*pfn |= range->flags[HMM_PFN_WRITE];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
