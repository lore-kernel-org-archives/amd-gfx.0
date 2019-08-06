From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Date: Tue, 6 Aug 2019 18:13:36 +0100
Message-ID: <20190806171335.4dzjex5asoertaob@willie-the-truck>
References: <cover.1563904656.git.andreyknvl@google.com>
 <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
 <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190724142059.GC21234@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dri-devel@lists.freedesktop.org, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Dave
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jul 24, 2019 at 03:20:59PM +0100, Will Deacon wrote:
> On Wed, Jul 24, 2019 at 04:16:49PM +0200, Andrey Konovalov wrote:
> > On Wed, Jul 24, 2019 at 4:02 PM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Jul 23, 2019 at 08:03:29PM +0200, Andrey Konovalov wrote:
> > > > Should this go through the mm or the arm tree?
> > >
> > > I would certainly prefer to take at least the arm64 bits via the arm64 tree
> > > (i.e. patches 1, 2 and 15). We also need a Documentation patch describing
> > > the new ABI.
> > 
> > Sounds good! Should I post those patches together with the
> > Documentation patches from Vincenzo as a separate patchset?
> 
> Yes, please (although as you say below, we need a new version of those
> patches from Vincenzo to address the feedback on v5). The other thing I
> should say is that I'd be happy to queue the other patches in the series
> too, but some of them are missing acks from the relevant maintainers (e.g.
> the mm/ and fs/ changes).

Ok, I've queued patches 1, 2, and 15 on a stable branch here:

  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/tbi

which should find its way into -next shortly via our for-next/core branch.
If you want to make changes, please send additional patches on top.

This is targetting 5.4, but I will drop it before the merge window if
we don't have both of the following in place:

  * Updated ABI documentation with Acks from Catalin and Kevin
  * The other patches in the series either Acked (so I can pick them up)
    or queued via some other tree(s) for 5.4.

Make sense?

Cheers,

Will
