From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Date: Fri, 9 Aug 2019 10:28:00 +0100
Message-ID: <20190809092758.GK10425@arm.com>
References: <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
 <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com>
 <20190806171335.4dzjex5asoertaob@willie-the-truck>
 <CAAeHK+zF01mxU+PkEYLkoVu-ZZM6jNfL_OwMJKRwLr-sdU4Myg@mail.gmail.com>
 <201908081410.C16D2BD@keescook>
 <20190808153300.09d3eb80772515f0ea062833@linux-foundation.org>
 <201908081608.A4F6711@keescook>
 <20190809090016.GA23083@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809090016.GA23083@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Christian Koenig <Christian.Koenig@amd.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, Lee Smith <Lee.Smith@arm.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Vyukov <dvyukov@google.com>, Ev
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 09, 2019 at 10:00:17AM +0100, Catalin Marinas wrote:
> On Thu, Aug 08, 2019 at 04:09:04PM -0700, Kees Cook wrote:
> > On Thu, Aug 08, 2019 at 03:33:00PM -0700, Andrew Morton wrote:
> > > On Thu, 8 Aug 2019 14:12:19 -0700 Kees Cook <keescook@chromium.org> wrote:
> > > 
> > > > > The ones that are left are the mm ones: 4, 5, 6, 7 and 8.
> > > > > 
> > > > > Andrew, could you take a look and give your Acked-by or pick them up directly?
> > > > 
> > > > Given the subsystem Acks, it seems like 3-10 and 12 could all just go
> > > > via Andrew? I hope he agrees. :)
> > > 
> > > I'll grab everything that has not yet appeared in linux-next.  If more
> > > of these patches appear in linux-next I'll drop those as well.
> > > 
> > > The review discussion against " [PATCH v19 02/15] arm64: Introduce
> > > prctl() options to control the tagged user addresses ABI" has petered
> > > out inconclusively.  prctl() vs arch_prctl().
> > 
> > I've always disliked arch_prctl() existing at all. Given that tagging is
> > likely to be a multi-architectural feature, it seems like the controls
> > should live in prctl() to me.
> 
> It took a bit of grep'ing to figure out what Dave H meant by
> arch_prctl(). It's an x86-specific syscall which we do not have on arm64
> (and possibly any other architecture). Actually, we don't have any arm64
> specific syscalls, only the generic unistd.h, hence the confusion. For
> other arm64-specific prctls like SVE we used the generic sys_prctl() and
> I can see x86 not being consistent either (PR_MPX_ENABLE_MANAGEMENT).
> 
> In general I disagree with adding any arm64-specific syscalls but in
> this instance it can't even be justified. I'd rather see some clean-up
> similar to arch_ptrace/ptrace_request than introducing new syscall
> numbers (but as I suggested in my reply to Dave, that's for another
> patch series).

I had a go at refactoring this a while ago, but it fell by the wayside.

I can try to resurrect it if it's still considered worthwhile.

Cheers
---Dave
