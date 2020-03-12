Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A17C0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B781F20739
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CMcPoqf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B781F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F89C89704;
	Thu, 12 Mar 2020 01:49:31 +0000 (UTC)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B781789704
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 01:49:29 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e6991770000>; Wed, 11 Mar 2020 18:33:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 11 Mar 2020 18:34:28 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 11 Mar 2020 18:34:28 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Thu, 12 Mar 2020 01:34:24 +0000
Subject: Re: [PATCH hmm 5/8] mm/hmm: add missing call to
 hmm_range_need_fault() before returning EFAULT
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 <Felix.Kuehling@amd.com>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-6-jgg@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <ff8f1592-174d-1c34-19f3-603afb90f7af@nvidia.com>
Date: Wed, 11 Mar 2020 18:34:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200311183506.3997-6-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1583976823; bh=H6HY2+/kp41Kgp7gi/py/25JmCnwy+qDX94nyRF1MN0=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=CMcPoqf5XKGty7Zg/ep0Y0t1dhNAd3LTJ6YI02TlXovm+JHFrCP0534wkJ2Yw/wQf
 gi7lNqCuciRMnUhFKSikVP5pAiOTlbRpCiEoh/Ey4bIL7MshP4IZhZDwhNC+CffSAW
 gEiheaNm5IS7PjRQJQbx3XBy5fp7/BsRCVWmhcSJwuTswhsbD7cs170GFb2eThOgUK
 iZSvU5cA9hV3K+7YKtpub5LUFJvL3SRVpmkU/CB5TrKt8pO9QFZxQI3xEU33zzVRpa
 5eYz87ifvo4YhiYOXTByGcdlkW17vl/KwFxB0+FhgcrREYYRfD0GvB4Nd64QO8RxVp
 GbitxHEStRbNg==
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
> All return paths that do EFAULT must call hmm_range_need_fault() to
> determine if the user requires this page to be valid.
> 
> If the page cannot be made valid if the user later requires it, due to vma
> flags in this case, then the return should be HMM_PFN_ERROR.
> 
> Fixes: a3e0d41c2b1f ("mm/hmm: improve driver API to work and wait over a range")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hmm.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 5f5ccf13dd1e85..e10cd0adba7b37 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -582,18 +582,15 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>   	struct vm_area_struct *vma = walk->vma;
>   
>   	/*
> -	 * Skip vma ranges that don't have struct page backing them or
> -	 * map I/O devices directly.
> -	 */
> -	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
> -		return -EFAULT;
> -
> -	/*
> +	 * Skip vma ranges that don't have struct page backing them or map I/O
> +	 * devices directly.
> +	 *
>   	 * If the vma does not allow read access, then assume that it does not
> -	 * allow write access either. HMM does not support architectures
> -	 * that allow write without read.
> +	 * allow write access either. HMM does not support architectures that
> +	 * allow write without read.
>   	 */
> -	if (!(vma->vm_flags & VM_READ)) {
> +	if ((vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP)) ||
> +	    !(vma->vm_flags & VM_READ)) {
>   		bool fault, write_fault;
>   
>   		/*
> @@ -607,7 +604,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>   		if (fault || write_fault)
>   			return -EFAULT;
>   
> -		hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
> +		hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
>   		hmm_vma_walk->last = end;
>   
>   		/* Skip this vma and continue processing the next vma. */
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
