From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 7/7] mm/hmm: remove hmm_range vma
Date: Fri, 26 Jul 2019 08:25:04 +0200
Message-ID: <20190726062504.GD22881@lst.de>
References: <20190726005650.2566-1-rcampbell@nvidia.com> <20190726005650.2566-8-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-8-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Jason Gunthorpe <jgg@mellanox.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 25, 2019 at 05:56:50PM -0700, Ralph Campbell wrote:
> Since hmm_range_fault() doesn't use the struct hmm_range vma field,
> remove it.
> 
> Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
