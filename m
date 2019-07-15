From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Please pull hmm changes
Date: Sun, 14 Jul 2019 19:48:40 -0700
Message-ID: <CAHk-=wgHKrYEMDbA9CxZ2Sw8JuW3=Wxr1fZo+EvXXLhg4iUOmw@mail.gmail.com>
References: <20190709192418.GA13677@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709192418.GA13677@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 9, 2019 at 12:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> I'm sending it early as it is now a dependency for several patches in
> mm's quilt.

.. but I waited to merge it until I had time to review it more
closely, because I expected the review to be painful.

I'm happy to say that I was overly pessimistic, and that instead of
finding things to hate, I found it all looking good.

Particularly the whole "use reference counts properly, so that
lifetimes make sense and all those nasty cases can't happen" parts.

It's all merged, just waiting for the test-build to verify that I
didn't miss anything (well, at least nothing obvious).

                      Linus
