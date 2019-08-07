From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
Date: Wed, 7 Aug 2019 08:46:33 -0300
Message-ID: <20190807114633.GA1557@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-16-hch@lst.de>
 <20190806174437.GK11627@ziepe.ca>
 <587b1c3c-83c4-7de9-242f-6516528049f4@amd.com>
 <CADnq5_Puv-N=FVpNXhv7gOWZ8=tgBD2VjrKpVzEE0imWqJdD1A@mail.gmail.com>
 <20190806200356.GU11627@ziepe.ca>
 <4a040a3f-8981-3e94-2436-8295a0caa534@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4a040a3f-8981-3e94-2436-8295a0caa534@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 07, 2019 at 06:57:24AM +0000, Koenig, Christian wrote:
> Am 06.08.19 um 22:03 schrieb Jason Gunthorpe:
> > On Tue, Aug 06, 2019 at 02:58:58PM -0400, Alex Deucher wrote:
> >> On Tue, Aug 6, 2019 at 1:51 PM Kuehling, Felix <Felix.Kuehling@amd.com> wrote:
> >>> On 2019-08-06 13:44, Jason Gunthorpe wrote:
> >>>> On Tue, Aug 06, 2019 at 07:05:53PM +0300, Christoph Hellwig wrote:
> >>>>> The option is just used to select HMM mirror support and has a very
> >>>>> confusing help text.  Just pull in the HMM mirror code by default
> >>>>> instead.
> >>>>>
> >>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>>>>    drivers/gpu/drm/Kconfig                 |  2 ++
> >>>>>    drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ----------
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ------
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 12 ------------
> >>>>>    4 files changed, 2 insertions(+), 28 deletions(-)
> >>>> Felix, was this an effort to avoid the arch restriction on hmm or
> >>>> something? Also can't see why this was like this.
> >>> This option predates KFD's support of userptrs, which in turn predates
> >>> HMM. Radeon has the same kind of option, though it doesn't affect HMM in
> >>> that case.
> >>>
> >>> Alex, Christian, can you think of a good reason to maintain userptr
> >>> support as an option in amdgpu? I suspect it was originally meant as a
> >>> way to allow kernels with amdgpu without MMU notifiers. Now it would
> >>> allow a kernel with amdgpu without HMM or MMU notifiers. I don't know if
> >>> this is a useful thing to have.
> >> Right.  There were people that didn't have MMU notifiers that wanted
> >> support for the GPU.
> > ?? Is that even a real thing? mmu_notifier does not have much kconfig
> > dependency.
> 
> Yes, that used to be a very real thing.
> 
> Initially a lot of users didn't wanted mmu notifiers to be enabled 
> because of the performance overhead they costs.

Seems strange to hear these days, every distro ships with it on, it is
needed for kvm.

> Then we had the problem that HMM mirror wasn't available on a lot of 
> architectures.

Some patches for hmm are ready now that will fix this

Jason
