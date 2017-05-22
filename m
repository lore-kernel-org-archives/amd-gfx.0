From: Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v2 0/3] Cleanup evergreen/si IRQ handling code
Date: Mon, 22 May 2017 09:52:23 -0400
Message-ID: <1495461143.2944.1.camel@redhat.com>
References: <20170516211202.20325-1-lyude@redhat.com>
         <20170519234840.5644-1-lyude@redhat.com>
         <51a14f4e-8771-3bca-b05f-25732da50b34@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51a14f4e-8771-3bca-b05f-25732da50b34@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>, amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Sat, 2017-05-20 at 13:39 +0200, Christian König wrote:
> Am 20.05.2017 um 01:48 schrieb Lyude:
> > This is the first part of me going through and cleaning up the IRQ
> > handling
> > code for radeon, since after taking a look at it the other day
> > while trying to
> > debug something I realized basically all of the code was copy
> > pasted
> > everywhere, and quite difficult to actually read through.
> > 
> > Will come up with something for r600 and cik once I've got the
> > chipsets on hand
> > to test with.
> > 
> > Lyude (3):
> >    drm/radeon: Cleanup display interrupt handling for evergreen, si
> >    drm/radeon: Cleanup HDMI audio interrupt handling for evergreen
> >    drm/radeon: Cleanup pageflipping IRQ handling for evergreen, si
> 
> I don't have time to do a line by line review, but what I saw looked 
> very good to me.
> 
> So the whole seres is Acked-by: Christian König <christian.koenig@amd
> .com>.
> 
> BTW: You don't want to take a look at the other hw generations as
> well?
Oh don't worry, I'm already planning on that! The next chance I have
available I'll be going my coworker's GPUs so I can get the hardware I
need to test refactors I write of the rest of the hw gen's IRQ handling
code. :)
> 
> Regards,
> Christian.
> 
> > 
> >   drivers/gpu/drm/radeon/evergreen.c      | 943 ++++++-------------
> > -------------
> >   drivers/gpu/drm/radeon/radeon.h         |  27 +-
> >   drivers/gpu/drm/radeon/radeon_irq_kms.c |  35 ++
> >   drivers/gpu/drm/radeon/si.c             | 655 +++++------------
> > -----
> >   4 files changed, 344 insertions(+), 1316 deletions(-)
> > 
> 
> 
