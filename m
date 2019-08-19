From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH ARM] selftests, arm64: fix uninitialized symbol in tags_test.c
Date: Mon, 19 Aug 2019 17:44:56 +0200
Message-ID: <CAAeHK+zf_VKOttBVfZUdp-ra=uNTx_faCmJkrM81BzgEaOZjSQ@mail.gmail.com>
References: <00eb8ba84205c59cac01b1b47615116a461c302c.1566220355.git.andreyknvl@google.com>
 <20190819150342.sxk3zzxvrxhkpp6j@willie-the-truck> <CAAeHK+xP6HnLJt_RKW67x8nbJLJp5A=av57BfwiFrA88eFn60w@mail.gmail.com>
 <20190819153856.odtneqxfxva2wjgu@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819153856.odtneqxfxva2wjgu@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christop
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Aug 19, 2019 at 5:39 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Aug 19, 2019 at 05:16:37PM +0200, Andrey Konovalov wrote:
> > On Mon, Aug 19, 2019 at 5:03 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Aug 19, 2019 at 03:14:42PM +0200, Andrey Konovalov wrote:
> > > > Fix tagged_ptr not being initialized when TBI is not enabled.
> > > >
> > > > Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > Guessing this was Reported-by, or has Dan introduced his own tag now? ;)
> >
> > Oops, yes, Reported-by :)
> >
> > >
> > > Got a link to the report?
> >
> > https://www.spinics.net/lists/linux-kselftest/msg09446.html
>
> Thanks, I'll fix up the commit message and push this out later on. If you
> get a chance, would you be able to look at the pending changes from
> Catalin[1], please?
>
> Will
>
> [1] https://lkml.kernel.org/r/20190815154403.16473-1-catalin.marinas@arm.com

Sure! I didn't realize some actioned is required from me on those.
I'll add my Acked-by's. Thanks!
