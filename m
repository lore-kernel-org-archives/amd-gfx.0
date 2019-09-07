From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch alignment
Date: Sat, 7 Sep 2019 10:58:03 -0400
Message-ID: <CADnq5_Mfee4xmzMJ-Hmw251QCMfabWPKd8PX+o70D97qdCDJ8g@mail.gmail.com>
References: <20190903162519.7136-1-sashal@kernel.org> <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net> <20190903170347.GA24357@kroah.com>
 <20190903200139.GJ5281@sasha-vm> <CAKMK7uFpBnkF4xABdkDMZ8TYhL4jg6ZuGyHGyVeBxc9rkyUtXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAKMK7uFpBnkF4xABdkDMZ8TYhL4jg6ZuGyHGyVeBxc9rkyUtXQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Sasha Levin <sashal@kernel.org>, Dave Airlie <airlied@linux.ie>, Yu Zhao <yuzhao@google.com>, Greg KH <gregkh@linuxfoundation.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, stable <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 3, 2019 at 4:16 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Sep 3, 2019 at 10:01 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Tue, Sep 03, 2019 at 07:03:47PM +0200, Greg KH wrote:
> > >On Tue, Sep 03, 2019 at 06:40:43PM +0200, Michel D=C3=A4nzer wrote:
> > >> On 2019-09-03 6:23 p.m., Sasha Levin wrote:
> > >> > From: Yu Zhao <yuzhao@google.com>
> > >> >
> > >> > [ Upstream commit 89f23b6efef554766177bf51aa754bce14c3e7da ]
> > >>
> > >> Hold your horses!
> > >>
> > >> This commit and c4a32b266da7bb702e60381ca0c35eaddbc89a6c had to be
> > >> reverted, as they caused regressions. See commits
> > >> 25ec429e86bb790e40387a550f0501d0ac55a47c &
> > >> 92b0730eaf2d549fdfb10ecc8b71f34b9f472c12 .
> > >>
> > >>
> > >> This isn't bolstering confidence in how these patches are selected..=
.
> > >
> > >The patch _itself_ said to be backported to the stable trees from 4.2
> > >and newer.  Why wouldn't we be confident in doing this?
> > >
> > >If the patch doesn't want to be backported, then do not add the cc:
> > >stable line to it...
> >
> > This patch was picked because it has a stable tag, which you presumably
> > saw as your Reviewed-by tag is in the patch. This is why it was
> > backported; it doesn't take AI to backport patches tagged for stable...
> >
> > The revert of this patch, however:
> >
> >  1. Didn't have a stable tag.
> >  2. Didn't have a "Fixes:" tag.
> >  3. Didn't have the usual "the reverts commit ..." string added by git
> >  when one does a revert.
> >
> > Which is why we still kick patches for review, even though they had a
> > stable tag, just so people could take a look and confirm we're not
> > missing anything - like we did here.
> >
> > I'm not sure what you expected me to do differently here.
>
> Yeah this looks like fail on the revert side, they need to reference
> the reverted commit somehow ...
>
> Alex, why got this dropped? Is this more fallout from the back&forth
> shuffling you're doing between your internal branches behind the
> firewall, and the public history?

The behind the firewall comments are not really helpful.  There aren't
any "behind the firewall" trees.  Everything is mirrored in public.
Yes it is annoying that we don't have a direct committer tree, but the
only shuffling is between public trees.  The problem is 90% of our
customers want packaged out of tree drivers rather than in tree
drivers because they are using an old distro or a custom distro or
something else so we have to do this dance.  I realize there are other
dances we could do to solve this problem, but they all have their own
set of costs and this is what we have now.  The patch shuffling
doesn't help, but regardless, the same thing could happen even with a
direct committer tree if someone missed the tag when committing.

Alex

>
> Also adding Dave Airlie.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
