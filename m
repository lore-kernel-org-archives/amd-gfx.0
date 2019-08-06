From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 08/15] mm: remove the mask variable in
 hmm_vma_walk_hugetlb_entry
Date: Tue, 6 Aug 2019 15:02:09 -0300
Message-ID: <20190806180209.GN11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-9-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-9-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 07:05:46PM +0300, Christoph Hellwig wrote:
> The pagewalk code already passes the value as the hmask parameter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/hmm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
