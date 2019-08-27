From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/2] mm/hmm: two bug fixes for hmm_range_fault()
Date: Tue, 27 Aug 2019 19:48:04 -0300
Message-ID: <20190827224804.GA31299@ziepe.ca>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 23, 2019 at 03:17:51PM -0700, Ralph Campbell wrote:
> I have been working on converting Jerome's hmm_dummy driver and self
> tests into a stand-alone set of tests to be included in
> tools/testing/selftests/vm and came across these two bug fixes in the
> process. The tests aren't quite ready to be posted as a patch.
> I'm posting the fixes now since I thought they shouldn't wait.
> They should probably have a fixes line but with all the HMM changes,
> I wasn't sure exactly which commit to use.
> 
> These are based on top of Jason's latest hmm branch.
> 
> Ralph Campbell (2):
>   mm/hmm: hmm_range_fault() NULL pointer bug
>   mm/hmm: hmm_range_fault() infinite loop

Applied to hmm.git

Thanks,
Jason
