Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ADDEF99DF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Feb 2026 21:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369E910E31F;
	Fri, 13 Feb 2026 21:43:58 +0000 (UTC)
Received: from MTA-13-4.privateemail.com (mta-13-4.privateemail.com
 [198.54.127.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D25D10E0C9;
 Fri, 13 Feb 2026 19:36:32 +0000 (UTC)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
 by mta-13.privateemail.com (Postfix) with ESMTP id 4fCMqM1DX3z3hhX1;
 Fri, 13 Feb 2026 14:36:31 -0500 (EST)
Received: from hal-station (unknown [23.129.64.148])
 by mta-13.privateemail.com (Postfix) with ESMTPA;
 Fri, 13 Feb 2026 14:35:59 -0500 (EST)
Date: Fri, 13 Feb 2026 14:35:43 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm: introduce KMS recovery mechanism
Message-ID: <aY99D-yXVydpMdwy@hal-station>
References: <20260212230905.688006-1-someguy@effective-light.com>
 <2e359cd9-0192-44d0-886f-7f93a8b0a4fa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e359cd9-0192-44d0-886f-7f93a8b0a4fa@amd.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Fri, 13 Feb 2026 21:43:57 +0000
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

On Thu, Feb 12, 2026 at 06:18:17PM -0600, Mario Limonciello wrote:
> Since you were able to (relatively) reliably reproduce a problem in amdgpu,
> how far in your iterative flow did you get?  Did you manage to need the
> vendor specific handling?  And presumably that helped?
> 

Every time I've tested it (with my repro) the full modeset has failed
and it was able to recover with the vendor specific handling. Though
it's worth noting that I strongly suspect a firmware hang in my case[1].

[1] https://lore.kernel.org/r/aYplYyf6Pp20lOAD@hal-station/

> > @@ -1881,13 +1886,43 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
> >   			continue;
> >   		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
> > -		if (ret == 0)
> > -			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
> > -				crtc->base.id, crtc->name);
> > +		if (!ret) {
> > +			switch (dev->reset_phase) {
> > +			case DRM_KMS_RESET_NONE:
> > +				drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
> > +					crtc->base.id, crtc->name);
> > +				dev->reset_phase = DRM_KMS_RESET_FORCE_MODESET;
> > +				drm_kms_helper_hotplug_event(dev);
> > +				break;
> 
> Since you're iterating multiple CRTCs if you manage to recover from one
> with this call shouldn't you keep iterating the rest?
> 

Most measures that the can be implemented at the kernel level (including
forcing a full modeset), can't save the the current commit. So, in all
likelihood we will just end up waiting an extra 10 seconds per CRTC
(assuming they haven't completed already, unrelated to the forced
modeset).
