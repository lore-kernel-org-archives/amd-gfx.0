Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B42C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 22:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDCB20674
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 22:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BO6Oj0W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDCB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8D26E826;
	Tue, 17 Mar 2020 22:43:52 +0000 (UTC)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5914889D30;
 Tue, 17 Mar 2020 22:43:51 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7152460000>; Tue, 17 Mar 2020 15:42:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 17 Mar 2020 15:43:50 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 17 Mar 2020 15:43:50 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Tue, 17 Mar 2020 22:43:50 +0000
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
To: Christoph Hellwig <hch@lst.de>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317073454.GA5843@lst.de>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a8c5a33d-4c64-df74-2b98-26ddd5e6da00@nvidia.com>
Date: Tue, 17 Mar 2020 15:43:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200317073454.GA5843@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584484934; bh=2jZcafW9RvOYHM38DORumH5I1RwtHgySTT0aFTjNQuM=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=BO6Oj0W4mrkkdhTl+awAc50wbgQvTWvpmTQJd/2gjT8Fd+LDVf2mLhhknF+8JnEii
 UaRmmvajifNBnwzUIOCqy6/EAGyEHyVYr1Kj2tWuvuvPtu7kpQK4J/Zv/B4gTDOuoD
 UbsJb+Tz87eXdjbZjuy0rSVdqaG0ENtxEBqcXXztnwYOgYpMyi+jZf6Rn5iAesnROj
 iOHGVOKHirMOlGtyyAUQQHj0vnAK8rP0ogkGB3hj62Ms0+/utWir0qA5OzGhWhSSnT
 SQa2st7gbC6N2yS5vY3VS7bfM/HHpXgfXR7shKofCnTxEngkRmU50nVYaq/uwSSzFi
 z5eJsuv+P/Isw==
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
Cc: amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/17/20 12:34 AM, Christoph Hellwig wrote:
> On Mon, Mar 16, 2020 at 03:49:51PM -0700, Ralph Campbell wrote:
>> On 3/16/20 12:32 PM, Christoph Hellwig wrote:
>>> Remove the code to fault device private pages back into system memory
>>> that has never been used by any driver.  Also replace the usage of the
>>> HMM_PFN_DEVICE_PRIVATE flag in the pfns array with a simple
>>> is_device_private_page check in nouveau.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Getting rid of HMM_PFN_DEVICE_PRIVATE seems reasonable to me since a driver can
>> look at the struct page but what if a driver needs to fault in a page from
>> another device's private memory? Should it call handle_mm_fault()?
> 
> Obviously no driver cared for that so far.  Once we have test cases
> for that and thus testable code we can add code to fault it in from
> hmm_vma_handle_pte.
> 

I'm OK with the series. I think I would have been less confused if I looked at
patch 4 then 3.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
