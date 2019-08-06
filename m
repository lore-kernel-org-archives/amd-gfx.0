From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 14/15] mm: make HMM_MIRROR an implicit option
Date: Tue, 6 Aug 2019 14:44:51 -0300
Message-ID: <20190806174451.GL11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-15-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-15-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 07:05:52PM +0300, Christoph Hellwig wrote:
> Make HMM_MIRROR an option that is selected by drivers wanting to use it
> instead of a user visible option as it is just a low-level
> implementation detail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig |  4 +++-
>  drivers/gpu/drm/nouveau/Kconfig    |  4 +++-
>  mm/Kconfig                         | 14 ++++++--------
>  3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
