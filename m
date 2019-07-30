From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/13] nouveau: pass struct nouveau_svmm to
 nouveau_range_fault
Date: Tue, 30 Jul 2019 16:40:23 +0200
Message-ID: <20190730144023.GA6683@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-4-hch@lst.de> <20190730123554.GD24038@mellanox.com> <20190730131038.GB4566@lst.de> <20190730131454.GG24038@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730131454.GG24038@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 01:14:58PM +0000, Jason Gunthorpe wrote:
> I have a patch deleting hmm->mm, so using svmm seems cleaner churn
> here, we could defer and I can fold this into that patch?

Sounds good.  If I don't need to resend feel fee to fold it, otherwise
I'll fix it up.
