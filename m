From: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Fri, 16 Aug 2019 14:10:47 -0700
Message-ID: <c679d6b2-e7f6-3980-6905-94d48bfb056d@nvidia.com>
References: <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com>
 <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
 <CAPcyv4j_Mxbw+T+yXTMdkrMoS_uxg+TXXgTM_EPBJ8XfXKxytA@mail.gmail.com>
 <20190816004053.GB9929@mellanox.com>
 <CAPcyv4gMPVmY59aQAT64jQf9qXrACKOuV=DfVs4sNySCXJhkdA@mail.gmail.com>
 <20190816122414.GC5412@mellanox.com>
 <CAPcyv4jgHF05gdRoOFZORqeOBE9Z7PhagsSD+LVnjH2dc3mrFg@mail.gmail.com>
 <20190816172846.GJ5398@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816172846.GJ5398@ziepe.ca>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org


On 8/16/19 10:28 AM, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2019 at 10:21:41AM -0700, Dan Williams wrote:
> 
>>> We can do a get_dev_pagemap inside the page_walk and touch the pgmap,
>>> or we can do the 'device mutex && retry' pattern and touch the pgmap
>>> in the driver, under that lock.
>>>
>>> However in all cases the current get_dev_pagemap()'s in the page walk
>>> are not necessary, and we can delete them.
>>
>> Yes, as long as 'struct page' instances resulting from that lookup are
>> not passed outside of that lock.
> 
> Indeed.
> 
> Also, I was reflecting over lunch that the hmm_range_fault should only
> return DEVICE_PRIVATE pages for the caller's device (see other thread
> with HCH), and in this case, the caller should also be responsible to
> ensure that the driver is not calling hmm_range_fault at the same time
> it is deleting it's own DEVICE_PRIVATE mapping - ie by fencing its
> page fault handler.

Yes, that would make it a one step process to access another
device's migrated memory pages.
Right now, it has to be a two step process where the caller calls
hmm_range_fault, check the struct page to see if it is device
private and not owned, then call hmm_range_fault again with
range->pfns[i] |= range->flags[HMM_PFN_DEVICE_PRIVATE] to cause
the other device to migrate the page back to system memory.
