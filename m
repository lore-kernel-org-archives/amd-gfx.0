From: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Date: Mon, 26 Aug 2019 11:21:49 -0700
Message-ID: <9351886a-34b4-4d6f-95b0-d25007a38e61@nvidia.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-2-rcampbell@nvidia.com> <20190824223754.GA21891@lst.de>
 <e2ecc1a7-0d2f-5957-e6cb-b3c86c085d80@nvidia.com>
 <20190826180937.GI27031@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826180937.GI27031@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: amd-gfx.lists.freedesktop.org


On 8/26/19 11:09 AM, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2019 at 11:02:12AM -0700, Ralph Campbell wrote:
>>
>> On 8/24/19 3:37 PM, Christoph Hellwig wrote:
>>> On Fri, Aug 23, 2019 at 03:17:52PM -0700, Ralph Campbell wrote:
>>>> Although hmm_range_fault() calls find_vma() to make sure that a vma exists
>>>> before calling walk_page_range(), hmm_vma_walk_hole() can still be called
>>>> with walk->vma == NULL if the start and end address are not contained
>>>> within the vma range.
>>>
>>> Should we convert to walk_vma_range instead?  Or keep walk_page_range
>>> but drop searching the vma ourselves?
>>>
>>> Except for that the patch looks good to me:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>
>> I think keeping the call to walk_page_range() makes sense.
>> Jason is hoping to be able to snapshot a range with & without vmas
>> and have the pfns[] filled with empty/valid entries as appropriate.
>>
>> I plan to repost my patch changing hmm_range_fault() to use
>> walk.test_walk which will remove the call to find_vma().
>> Jason had some concerns about testing it so that's why I have
>> been working on some HMM self tests before resending it.
> 
> I'm really excited to see tests for hmm_range_fault()!
> 
> Did you find this bug with the tests??
> 
> Jason
> 

Yes, I found both bugs with the tests.
I started with Jerome's hmm_dummy driver and user level test code.
Hopefully I can send it out this week.
