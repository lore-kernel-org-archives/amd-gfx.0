From: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 1/4] mm/hmm: make full use of walk_page_range()
Date: Thu, 12 Sep 2019 10:16:51 -0700
Message-ID: <973b7159-513f-0776-668d-8ba1adf87f1c@nvidia.com>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
 <20190911222829.28874-2-rcampbell@nvidia.com> <20190912082613.GA14368@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190912082613.GA14368@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: amd-gfx.lists.freedesktop.org


On 9/12/19 1:26 AM, Christoph Hellwig wrote:
>> +static int hmm_pfns_fill(unsigned long addr,
>> +			 unsigned long end,
>> +			 struct hmm_range *range,
>> +			 enum hmm_pfn_value_e value)
> 
> Nit: can we use the space a little more efficient, e.g.:
> 
> static int hmm_pfns_fill(unsigned long addr, unsigned long end,
> 		struct hmm_range *range, enum hmm_pfn_value_e value)
> 
>> +static int hmm_vma_walk_test(unsigned long start,
>> +			     unsigned long end,
>> +			     struct mm_walk *walk)
> 
> Same here.
> 
>> +	if (!(vma->vm_flags & VM_READ)) {
>> +		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
> 
> There should be no need for the void cast here.
> 

OK. I'll post a v2 with the these changes.
Thanks for the reviews.
