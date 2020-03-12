Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDBC0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF7D20739
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YxQcvPK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF7D20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6F989704;
	Thu, 12 Mar 2020 01:48:25 +0000 (UTC)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6484589704
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 01:48:24 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e6991070000>; Wed, 11 Mar 2020 18:31:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 11 Mar 2020 18:33:22 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 11 Mar 2020 18:33:22 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Thu, 12 Mar 2020 01:33:22 +0000
Subject: Re: [PATCH hmm 4/8] mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 <Felix.Kuehling@amd.com>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-5-jgg@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <8dcf74fd-84ea-d233-bb19-81f8dd1da026@nvidia.com>
Date: Wed, 11 Mar 2020 18:33:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200311183506.3997-5-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1583976711; bh=U1rl/UiabWfnOWXl4vCuGxodlfNhgrYhMzFJH5JLC5I=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=YxQcvPK/mWR4Apm9cuq2r3rAKnQkzHAu45B/ITC8KV+03Vt602vlTt6wbkFfwbkgO
 WQo6CtjlzjXmlMbfEPrED8EaUxSPapFKtsfUAHTArULW0WyiyMMz9Yf3uKxTqhwHh9
 ZDikR1wIskm+aeFCD5eOPsPkf50zSS7IohQtwaTfT/Igunp6KKjQOFVY+wvvvkkZjx
 2GVwTkmCH3Pc8Ghz9rf3YPI0mrUZd8WQ45qO7Sr6hamKfRVnZJ1KVKZSt7eynJudej
 /bt//OtYxgGchG+PUjKiiRPxZ5Fw6puFRSQB2P8EAThMwLdYySEuRvGGyKD8KhU8qK
 9I1b0pipWo+JA==
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/11/20 11:35 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> All success exit paths from the walker functions must set the pfns array.
> 
> A migration entry with no required fault is a HMM_PFN_NONE return, just
> like the pte case.
> 
> Fixes: d08faca018c4 ("mm/hmm: properly handle migration pmd")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hmm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 32dcbfd3908315..5f5ccf13dd1e85 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -394,7 +394,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>   			pmd_migration_entry_wait(walk->mm, pmdp);
>   			return -EBUSY;
>   		}
> -		return 0;
> +		return hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
>   	} else if (!pmd_present(pmd))
>   		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
