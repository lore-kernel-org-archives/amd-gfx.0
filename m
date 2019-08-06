From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
Date: Tue, 6 Aug 2019 14:44:37 -0300
Message-ID: <20190806174437.GK11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-16-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-16-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 07:05:53PM +0300, Christoph Hellwig wrote:
> The option is just used to select HMM mirror support and has a very
> confusing help text.  Just pull in the HMM mirror code by default
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/Kconfig                 |  2 ++
>  drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 12 ------------
>  4 files changed, 2 insertions(+), 28 deletions(-)

Felix, was this an effort to avoid the arch restriction on hmm or
something? Also can't see why this was like this.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
