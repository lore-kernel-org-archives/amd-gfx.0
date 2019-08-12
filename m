From: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] nouveau/hmm: map pages after migration
Date: Mon, 12 Aug 2019 12:42:30 -0700
Message-ID: <1a84e6b6-31e6-6955-509f-9883f4a7a322@nvidia.com>
References: <20190807150214.3629-1-rcampbell@nvidia.com>
 <20190808070701.GC29382@lst.de>
 <0b96a8d8-86b5-3ce0-db95-669963c1f8a7@nvidia.com>
 <20190810111308.GB26349@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810111308.GB26349@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Jason Gunthorpe <jgg@mellanox.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org


On 8/10/19 4:13 AM, Christoph Hellwig wrote:
> On something vaguely related to this patch:
> 
> You use the NVIF_VMM_PFNMAP_V0_V* defines from nvif/if000c.h, which are
> a little odd as we only ever set these bits, but they also don't seem
> to appear to be in values that are directly fed to the hardware.
> 
> On the other hand mmu/vmm.h defines a set of NVIF_VMM_PFNMAP_V0_*

Yes, I see NVKM_VMM_PFN_*

> constants with similar names and identical values, and those are used
> in mmu/vmmgp100.c and what appears to finally do the low-level dma
> mapping and talking to the hardware.  Are these two sets of constants
> supposed to be the same?  Are the actual hardware values or just a
> driver internal interface?

It looks a bit odd to me too.
I don't really know the structure/history of nouveau.
Perhaps Ben Skeggs can shed more light on your question.
