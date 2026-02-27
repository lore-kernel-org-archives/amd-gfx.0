Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423E9FEE4E2
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EA810E262;
	Sat, 28 Feb 2026 09:19:11 +0000 (UTC)
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com
 [198.54.127.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D687F10E0FC;
 Fri, 27 Feb 2026 20:59:16 +0000 (UTC)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
 by mta-12.privateemail.com (Postfix) with ESMTP id 4fN10M50PHz3hhTn;
 Fri, 27 Feb 2026 15:59:15 -0500 (EST)
Received: from hal-station (ip74-208-79-7.pbiaas.com [74.208.79.7])
 by mta-12.privateemail.com (Postfix) with ESMTPA;
 Fri, 27 Feb 2026 15:58:47 -0500 (EST)
Date: Fri, 27 Feb 2026 15:58:43 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm/amd/display: add vendor specific reset
Message-ID: <aaIFg53tniZG5woJ@hal-station>
References: <20260220171518.711594-1-someguy@effective-light.com>
 <20260220171518.711594-2-someguy@effective-light.com>
 <c5ef0c6d-3620-4c8e-8b44-0c217897e6ed@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5ef0c6d-3620-4c8e-8b44-0c217897e6ed@amd.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:19:10 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 23, 2026 at 10:34:17AM +0100, Christian König wrote:
> > @@ -11085,8 +11087,26 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
> >  	/* Signal HW programming completion */
> >  	drm_atomic_helper_commit_hw_done(state);
> >  
> > -	if (wait_for_vblank)
> > -		drm_atomic_helper_wait_for_flip_done(dev, state);
> > +	if (wait_for_vblank &&
> > +	    drm_atomic_helper_wait_for_flip_done(dev, state)) {
> > +		mutex_lock(&dm->dc_lock);
> > +		if (dm_dmub_hw_init(adev))
> 
> From Michel's explanation that is pretty much a no-go because it potentially causes other atomic commits to react in unforeseen ways.
> 

This code would only run if the forced modeset fails, which is to say we
are already in a hung state, so I don't expect any other atomic commits
to be firing off. Also, evidently the timeout isn't a one off, so it's
almost certainly caused by hung firmware and not by a bug in the
driver's vblanking code.

> > +			drm_dev_wedged_event(dev, DRM_WEDGE_RECOVERY_REBIND |
> > +					     DRM_WEDGE_RECOVERY_BUS_RESET,
> > +					     NULL);
> 
> Please completely drop that. This here is a sledge hammer and not going to fly anywhere.
> 

I don't feel too strongly about it, though isn't the point to inform
userspace that we were unable to recover? AFAIK the prescribed methods
are mere suggestions and users can choose to ignore them if they feel
that they are too hard hitting.

> > +		mutex_unlock(&dm->dc_lock);
> > +
> > +		spin_lock_irqsave(&dev->event_lock, flags);
> > +		drm_for_each_crtc(crtc, dev) {
> 
> This should go over only the CRTCs in the atomic commit currently handled.
> 
> Have you tried sending a hotplug event for the connectors in question as Michel suggested?
> 

Sure, I can look into that. However, we would still need the firmware
reload. Otherwise, we would just be forcing a modeset twice in
succession.
