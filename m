Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EAC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 01:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6561220739
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 01:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q8yRQ8Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6561220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFEE6EAB8;
	Fri, 20 Mar 2020 01:33:10 +0000 (UTC)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABB56EAB7;
 Fri, 20 Mar 2020 01:33:08 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e741cf10000>; Thu, 19 Mar 2020 18:31:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 19 Mar 2020 18:33:07 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 19 Mar 2020 18:33:07 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 20 Mar 2020 01:33:07 +0000
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca> <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de> <20200317124755.GR20941@ziepe.ca>
 <20200317125955.GA12847@lst.de>
 <24fca825-3b0f-188f-bcf2-fadcf3a9f05a@nvidia.com>
 <20200320001428.GA9199@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <8d549ef6-14ae-7055-58c8-d56de8bf4ba6@nvidia.com>
Date: Thu, 19 Mar 2020 18:33:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200320001428.GA9199@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584667889; bh=0XrmkYqlA+KPtFLXc9j6McuShC8myf+16OYVMSLPN98=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=q8yRQ8OgBCDzsDjIi7BZWgW2W6wpR+FQ9bo0pOdEKoDHdimpX9OlV1kxhTKGxCsdK
 y7oGNmhxCYODXGZbFeJdZEagt9ppPLakBoNElC0LiRiYd/f4G5cClYDE/oM846Gca1
 m+mW8C4/i21sEKSuLvhfqFle1bJELFzb9iAxvgXvYXuG3ISf6g1cRwlGQeREzIY+MB
 VkbG0wNleCaEdDy/5biJSdif8WCwBTrVsrsENIUiCRuDE8RrpgajhsBXiSiJfJ7RGp
 ropfu4FvhZlxXPEZ7zcifJz6ZW7mhcjktbl6+ToyvLn0TCLionmVu5NS2mntJg0+e0
 M+COmpAgYcPfA==
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Bharata B Rao <bharata@linux.ibm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/19/20 5:14 PM, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2020 at 04:14:31PM -0700, Ralph Campbell wrote:
> 
>> +static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
>> +			 unsigned long end, bool write)
>> +{
>> +	struct mm_struct *mm = dmirror->mm;
>> +	unsigned long addr;
>> +	uint64_t pfns[64];
>> +	struct hmm_range range = {
>> +		.notifier = &dmirror->notifier,
>> +		.pfns = pfns,
>> +		.flags = dmirror_hmm_flags,
>> +		.values = dmirror_hmm_values,
>> +		.pfn_shift = DPT_SHIFT,
>> +		.pfn_flags_mask = ~(dmirror_hmm_flags[HMM_PFN_VALID] |
>> +				    dmirror_hmm_flags[HMM_PFN_WRITE]),
> 
> Since pfns is not initialized pfn_flags_mask should be 0.

Good point.

>> +		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
>> +				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
>> +		.dev_private_owner = dmirror->mdevice,
>> +	};
>> +	int ret = 0;
> 
>> +static int dmirror_snapshot(struct dmirror *dmirror,
>> +			    struct hmm_dmirror_cmd *cmd)
>> +{
>> +	struct mm_struct *mm = dmirror->mm;
>> +	unsigned long start, end;
>> +	unsigned long size = cmd->npages << PAGE_SHIFT;
>> +	unsigned long addr;
>> +	unsigned long next;
>> +	uint64_t pfns[64];
>> +	unsigned char perm[64];
>> +	char __user *uptr;
>> +	struct hmm_range range = {
>> +		.pfns = pfns,
>> +		.flags = dmirror_hmm_flags,
>> +		.values = dmirror_hmm_values,
>> +		.pfn_shift = DPT_SHIFT,
>> +		.pfn_flags_mask = ~0ULL,
> 
> Same here, especially since this is snapshot
> 
> Jason

Actually, snapshot ignores pfn_flags_mask and default_flags.
In hmm_pte_need_fault(), HMM_FAULT_SNAPSHOT is checked and returns early before
checking pfn_flags_mask and default_flags since no faults are being requested.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
