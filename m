From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Cleanup: replace prefered with preferred
Date: Thu, 24 Oct 2019 14:47:28 -0400
Message-ID: <20191024184728.GC260560@kroah.com>
References: <20191022214208.211448-1-salyzyn@android.com>
 <20191023115637.GA23733@linux.intel.com>
 <fa12cb96-7a93-bf85-214d-a7bfaf8b8b0a@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa12cb96-7a93-bf85-214d-a7bfaf8b8b0a@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Thomas Hellstrom <thellstrom@vmware.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 23, 2019 at 08:40:59AM -0700, Mark Salyzyn wrote:
> On 10/23/19 4:56 AM, Jarkko Sakkinen wrote:
> > On Tue, Oct 22, 2019 at 02:41:45PM -0700, Mark Salyzyn wrote:
> > > Replace all occurrences of prefered with preferred to make future
> > > checkpatch.pl's happy.  A few places the incorrect spelling is
> > > matched with the correct spelling to preserve existing user space API.
> > > 
> > > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > I'd fix such things when the code is otherwise change and scope this
> > patch only to Documentation/. There is no pragmatic benefit of doing
> > this for the code.
> > 
> > /Jarkko
> 
> The pragmatic benefit comes with the use of an ABI/API checker (which is a
> 'distro' thing, not a top of tree kernel thing) produces its map which is
> typically required to be co-located in the same tree as the kernel
> repository. Quite a few ABI/API update checkins result in a checkpatch.pl
> complaint about the misspelled elements being (re-)recorded due to
> proximity. We have a separate task to improve how it is tracked in Android
> to reduce milepost marker changes that result in sweeping changes to the
> database which would reduce the occurrences.

Requiring checkpatch spelling warnings to be correct based on function
names is crazy, you should fix your tools if you are requiring something
as looney as that :)

> I will split this between pure and inert documentation/comments for now,
> with a followup later for the code portion which understandably is more
> controversial.

Please break up per subsystem, like all trivial patches, as this
isn't anything special.

thanks,

greg k-h
