Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E3DC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8BD206E2
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lRxPbdAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8BD206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7756EB30;
	Thu, 12 Mar 2020 19:34:07 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632F76EB30
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 19:33:12 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id f3so8325255qkh.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=is+aAM3kx5GKU9icuIhwFwERZb/T1GECd3Vc+iyHsrs=;
 b=lRxPbdASo0evc/F+Ip6xqFmx6SR5Ep4C+HmDXCsADxBM/3Ke9ZrSnd8OLI9/+Ba18R
 N5a2wgvLDNxgULstqz0noI6VPXtVwUu8JngxGZs1UC5YPlq2H93z9xSfSOPdldqeSa4/
 hatJPBEgZOOseMT1S7YUlHG2jZYe0YM1TmYEuk89SVmxTdNfqS3h8ICchbxaNu8Q/cAZ
 aEAKi7bYJ81g9JwKnY6ybmslylnp+c5JRQ3G98ykTev743ZLpqbGtV9REVg+YL86yupH
 DXUhmmzZuEPGZDN7VLByJzgabZZQxQjNYMoTm2pezJL4F/dgTXcrObPWfXS38ruNqv42
 nl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=is+aAM3kx5GKU9icuIhwFwERZb/T1GECd3Vc+iyHsrs=;
 b=Ae7zrbY+sC26lE4Ct89DZLzogV4uYxo1BYVydw5PE+UObP1VyXzc58/FnABhpq6LUH
 Y/aQHAZhKizjhjHEkqe5joPg2cCrY0EHty3/UGlIl1oLPCV4ucP90EKb3mwz41oe8+lg
 VwR8+A5ihKJIn5eH9CADzIUa5Er0Il8ZcTWLUoE5bLKWXPSjVgj/4B/mcmxhty5U0U9o
 Eq2jVN1v9Oxm4DiHAr64sWGY/+JouqFNH1IZPa690oHl+pKYQ9F2VxmO+jQh7jJFqY6Y
 t0SWgqGEbPqG+XSQf0ZsaY8saakcod6HIjZh2mlZvII4ZTBpFvrjjukkAoqXz3ftbOhr
 Z8Ig==
X-Gm-Message-State: ANhLgQ3T7Ydhk5+eE1DLXmHcyH4VEguqycVHutMJuTilSfyaesgFPRYc
 CNDApx1OKGKKWipGDcsy1g9uHg==
X-Google-Smtp-Source: ADFU+vtXZiDTvpbqkqoe3aZfzQFFBVJratdXNcqXhW8TtJt9L1GxnDlVMfvoDpoJhcH5PsM3O8V7Jw==
X-Received: by 2002:a37:5b81:: with SMTP id p123mr8518904qkb.284.1584041591327; 
 Thu, 12 Mar 2020 12:33:11 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id o16sm28188049qke.35.2020.03.12.12.33.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 12:33:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCTZu-0000QR-65; Thu, 12 Mar 2020 16:33:10 -0300
Date: Thu, 12 Mar 2020 16:33:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com
Subject: Re: [PATCH hmm 9/8] mm/hmm: do not check pmd_protnone twice in
 hmm_vma_handle_pmd()
Message-ID: <20200312193310.GA1190@ziepe.ca>
References: <20200311183506.3997-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311183506.3997-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 12 Mar 2020 19:34:06 +0000
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
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pmd_to_hmm_pfn_flags() already checks it and makes the cpu flags 0. If no
fault is requested then the pfns should be returned with the not valid
flags.

It should not unconditionally fault if faulting is not requested.

Fixes: 2aee09d8c116 ("mm/hmm: change hmm_vma_fault() to allow write fault on page basis")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Bonus patch, this one got found after I made the series..

diff --git a/mm/hmm.c b/mm/hmm.c
index ca33d086bdc190..6d9da4b0f0a9f8 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -226,7 +226,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	hmm_range_need_fault(hmm_vma_walk, pfns, npages, cpu_flags,
 			     &fault, &write_fault);
 
-	if (pmd_protnone(pmd) || fault || write_fault)
+	if (fault || write_fault)
 		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
