From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v18 07/15] fs/namespace: untag user pointers in copy_mount_options
Date: Mon, 15 Jul 2019 18:00:04 +0200
Message-ID: <CAAeHK+x2TL057Fr0K7FZBTYgeEPVU3cC6scEeiSYk-Jkb3xgfg@mail.gmail.com>
References: <cover.1561386715.git.andreyknvl@google.com> <41e0a911e4e4d533486a1468114e6878e21f9f84.1561386715.git.andreyknvl@google.com>
 <20190624175009.GM29120@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624175009.GM29120@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Yishai Hadas <yishaih@mellanox.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jun 24, 2019 at 7:50 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 04:32:52PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> >
> > In copy_mount_options a user address is being subtracted from TASK_SIZE.
> > If the address is lower than TASK_SIZE, the size is calculated to not
> > allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
> > However if the address is tagged, then the size will be calculated
> > incorrectly.
> >
> > Untag the address before subtracting.
> >
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  fs/namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 7660c2749c96..ec78f7223917 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2994,7 +2994,7 @@ void *copy_mount_options(const void __user * data)
> >        * the remainder of the page.
> >        */
> >       /* copy_from_user cannot cross TASK_SIZE ! */
> > -     size = TASK_SIZE - (unsigned long)data;
> > +     size = TASK_SIZE - (unsigned long)untagged_addr(data);
> >       if (size > PAGE_SIZE)
> >               size = PAGE_SIZE;
>
> I think this patch needs an ack from Al Viro (cc'ed).
>
> --
> Catalin

Hi Al,

Could you take a look and give your acked-by?

Thanks!
