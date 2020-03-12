Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C9C2BB1D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 16:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54A92071B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 16:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A92071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D996E241;
	Thu, 12 Mar 2020 16:16:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 162226E241;
 Thu, 12 Mar 2020 16:16:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FFCA30E;
 Thu, 12 Mar 2020 09:16:36 -0700 (PDT)
Received: from [10.57.15.252] (unknown [10.57.15.252])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E971F3F6CF;
 Thu, 12 Mar 2020 09:16:34 -0700 (PDT)
Subject: Re: [PATCH] mm/hmm: Simplify hmm_vma_walk_pud slightly
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <5bd778fa-51e5-3e0c-d9bb-b38539b03c8d@arm.com>
 <20200312102813.56699-1-steven.price@arm.com>
 <20200312142749.GM31668@ziepe.ca>
 <58e296a6-d32b-bb37-28ce-ade0f784454d@arm.com>
 <20200312151113.GO31668@ziepe.ca>
From: Steven Price <steven.price@arm.com>
Message-ID: <689d3c56-3d19-4655-21f5-f9aeab3089df@arm.com>
Date: Thu, 12 Mar 2020 16:16:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312151113.GO31668@ziepe.ca>
Content-Language: en-GB
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/03/2020 15:11, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2020 at 02:40:08PM +0000, Steven Price wrote:
>> On 12/03/2020 14:27, Jason Gunthorpe wrote:
>>> On Thu, Mar 12, 2020 at 10:28:13AM +0000, Steven Price wrote:
>>>> By refactoring to deal with the !pud_huge(pud) || !pud_devmap(pud)
>>>> condition early it's possible to remove the 'ret' variable and remove a
>>>> level of indentation from half the function making the code easier to
>>>> read.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> Thanks to Jason's changes there were only two code paths left using
>>>> the out_unlock label so it seemed like a good opportunity to
>>>> refactor.
>>>
>>> Yes, I made something very similar, what do you think of this:
>>>
>>> https://github.com/jgunthorpe/linux/commit/93f0ed42ab3f9ceb27b58fb7c7c3ecaf60f16b36
>>
>> Even better! Sorry I didn't realise you'd already done this. I just saw that
>> the function was needlessly complicated after your fix, so I thought I'd do
>> a drive-by cleanup since part of the mess was my fault! :)
> 
> No worries, I've got a lot of patches for hmm_range_fault right now,
> just trying to organize them, test them and post them. Haven't posted
> that one yet.
> 
> Actually, while you are looking at this, do you think we should be
> adding at least READ_ONCE in the pagewalk.c walk_* functions? The
> multiple references of pmd, pud, etc without locking seems sketchy to
> me.

I agree it seems worrying. I'm not entirely sure whether the holding of 
mmap_sem is sufficient, this isn't something that I changed so I've just 
been hoping that it's sufficient since it seems to have been working 
(whether that's by chance because the compiler didn't generate multiple 
reads I've no idea). For walking the kernel's page tables the lack of 
READ_ONCE is also not great, but at least for PTDUMP we don't care too 
much about accuracy and it should be crash proof because there's no RCU 
grace period. And again the code I was replacing didn't have any special 
protection.

I can't see any harm in updating the code to include READ_ONCE and I'm 
happy to review a patch.

Thanks,

Steve
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
