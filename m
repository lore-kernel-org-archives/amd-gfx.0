From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Date: Wed, 24 Jul 2019 16:16:49 +0200
Message-ID: <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
References: <cover.1563904656.git.andreyknvl@google.com> <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugen>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jul 24, 2019 at 4:02 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Andrey,
>
> On Tue, Jul 23, 2019 at 08:03:29PM +0200, Andrey Konovalov wrote:
> > On Tue, Jul 23, 2019 at 7:59 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > === Overview
> > >
> > > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > > tags into the top byte of each pointer. Userspace programs (such as
> > > HWASan, a memory debugging tool [1]) might use this feature and pass
> > > tagged user pointers to the kernel through syscalls or other interfaces.
> > >
> > > Right now the kernel is already able to handle user faults with tagged
> > > pointers, due to these patches:
> > >
> > > 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
> > >              tagged pointer")
> > > 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> > >               pointers")
> > > 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> > >               pointers")
> > >
> > > This patchset extends tagged pointer support to syscall arguments.
>
> [...]
>
> > Do you think this is ready to be merged?
> >
> > Should this go through the mm or the arm tree?
>
> I would certainly prefer to take at least the arm64 bits via the arm64 tree
> (i.e. patches 1, 2 and 15). We also need a Documentation patch describing
> the new ABI.

Sounds good! Should I post those patches together with the
Documentation patches from Vincenzo as a separate patchset?

Vincenzo, could you share the last version of the Documentation patches?

Thanks!

>
> Will
