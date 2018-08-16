From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Thu, 16 Aug 2018 23:01:09 +0200
Message-ID: <CAK8P3a3Z8Z5WjgD2Y_-QfZA+bt59z7kCvfaBTzNuHn6QWCVxJw@mail.gmail.com>
References: <20180811155554.3382650-1-arnd@arndb.de> <0e2639d6-7816-4e85-3212-74fcd118e396@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e2639d6-7816-4e85-3212-74fcd118e396@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sunpeng.li@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, michel.daenzer@amd.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>, Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>, Jordan Lazare <Jordan.Lazare@amd.com>, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 16, 2018 at 9:56 PM Leo Li <sunpeng.li@amd.com> wrote:
> On 2018-08-11 11:54 AM, Arnd Bergmann wrote:
> >
> > I tried implementing the two functions in KCOV: __sanitizer_cov_trace_cmpd
> > and __sanitizer_cov_trace_cmpf, but that fails to build on architectures
> > that do not support any floating-point functions, or would require making
> > that code x86 specific as well.  I also looked at what it would take to
>
> Hi Arnd,
>
> Is there a reason why we can't make __sanitizer_cov_trace_cmpd and
> __sanitizer_cov_trace_cmpf X86 dependent?
>
> I sent out two patches to disable DCN1, but would prefer implementing
> these two functions as opposed to disabling a component.

I think it should be possible to implement them, perhaps not even hard
to do it in an architecture independent way. I tried this at some point
and couldn't figure it out, but I suppose it would fix the problem nicely.

This would assume that the two functions can only ever be called
from a context that already has access to the fpu, which I think is
the case here.

         Arnd
