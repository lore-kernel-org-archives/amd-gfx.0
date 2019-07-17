From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
Date: Wed, 17 Jul 2019 15:36:37 +0200
Message-ID: <CAAeHK+yyQpc6cxyVeUUWUwiQYy8iAgVXmOVO=EQYSNzy9G8Q0A@mail.gmail.com>
References: <cover.1561386715.git.andreyknvl@google.com>
 <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com>
 <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca>
 <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
 <20190716120624.GA29727@ziepe.ca>
 <CAAeHK+xPPQ9QjAksbfWG-Zmnawt-cdw9eO_6GVxjEYcaDGvaRA@mail.gmail.com>
 <20190717115828.GE12119@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190717115828.GE12119@ziepe.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Linux Memory Management List <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jul 17, 2019 at 1:58 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 17, 2019 at 01:44:07PM +0200, Andrey Konovalov wrote:
> > On Tue, Jul 16, 2019 at 2:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 12:42:07PM +0200, Andrey Konovalov wrote:
> > > > On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > > > > > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > > > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > > > > > tagged user pointers (with the top byte set to something else other than
> > > > > > > > 0x00) as syscall arguments.
> > > > > > > >
> > > > > > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > > > > > only by done with untagged pointers.
> > > > > > > >
> > > > > > > > Untag user pointers in this function.
> > > > > > > >
> > > > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > > >
> > > > > > > This patch also needs an ack from the infiniband maintainers (Jason).
> > > > > >
> > > > > > Hi Jason,
> > > > > >
> > > > > > Could you take a look and give your acked-by?
> > > > >
> > > > > Oh, I think I did this a long time ago. Still looks OK.
> > > >
> > > > Hm, maybe that was we who lost it. Thanks!
> > > >
> > > > > You will send it?
> > > >
> > > > I will resend the patchset once the merge window is closed, if that's
> > > > what you mean.
> > >
> > > No.. I mean who send it to Linus's tree? ie do you want me to take
> > > this patch into rdma?
> >
> > I think the plan was to merge the whole series through the mm tree.
> > But I don't mind if you want to take this patch into your tree. It's
> > just that this patch doesn't make much sense without the rest of the
> > series.
>
> Generally I prefer if subsystem changes stay in subsystem trees. If
> the patch is good standalone, and the untag API has already been
> merged, this is a better strategy.

OK, feel free to take this into your tree, this works for me.

>
> Jason
