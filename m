From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
Date: Wed, 28 Mar 2018 09:47:48 -0600
Message-ID: <c81df70d-191d-bf8e-293a-413dd633e1fc@deltatee.com>
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-2-christian.koenig@amd.com>
 <20180328123830.GB25060@infradead.org>
 <613a6c91-7e72-5589-77e6-587ec973d553@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <613a6c91-7e72-5589-77e6-587ec973d553@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: christian.koenig@amd.com, Christoph Hellwig <hch@infradead.org>
Cc: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



On 28/03/18 09:07 AM, Christian König wrote:
> Am 28.03.2018 um 14:38 schrieb Christoph Hellwig:
>> On Sun, Mar 25, 2018 at 12:59:54PM +0200, Christian König wrote:
>>> From: "wdavis@nvidia.com" <wdavis@nvidia.com>
>>>
>>> Add an interface to find the first device which is upstream of both
>>> devices.
>> Please work with Logan and base this on top of the outstanding peer
>> to peer patchset.
> 
> Can you point me to that? The last code I could find about that was from 
> 2015.

The latest posted series is here:

https://lkml.org/lkml/2018/3/12/830

However, we've made some significant changes to the area that's similar
to what you are doing. You can find lasted un-posted here:

https://github.com/sbates130272/linux-p2pmem/tree/pci-p2p-v4-pre2

Specifically this function would be of interest to you:

https://github.com/sbates130272/linux-p2pmem/blob/0e9468ae2a5a5198513dd12990151e09105f0351/drivers/pci/p2pdma.c#L239

However, the difference between what we are doing is that we are
interested in the distance through the common upstream device and you
appear to be finding the actual common device.

Thanks,

Logan
