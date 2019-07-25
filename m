From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v19 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
Date: Thu, 25 Jul 2019 13:17:32 +0200
Message-ID: <CAAeHK+x5JFgkLLzhrkQBfa78pkyQXLhgOfXOGuHK=AfwFLHntg@mail.gmail.com>
References: <cover.1563904656.git.andreyknvl@google.com> <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
 <20190724192504.GA5716@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724192504.GA5716@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Yishai Hadas <yishaih@mellanox.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alexander Deucher <Alexander.Deucher@am>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jul 24, 2019 at 9:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 23, 2019 at 07:58:48PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> >
> > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > only by done with untagged pointers.
> >
> > Untag user pointers in this function.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Applied to rdma-for next, please don't sent it via other trees :)

Sure, thanks!

>
> Thanks,
> Jason
