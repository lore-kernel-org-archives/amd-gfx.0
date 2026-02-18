Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2E1E9A03B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 08:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B24510E57B;
	Wed, 18 Feb 2026 08:09:40 +0000 (UTC)
Received: from MTA-15-3.privateemail.com (mta-15-3.privateemail.com
 [198.54.122.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CC510E20A;
 Wed, 18 Feb 2026 00:46:09 +0000 (UTC)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
 by mta-15.privateemail.com (Postfix) with ESMTP id 4fFyVm4BDgz3hhRv;
 Tue, 17 Feb 2026 19:46:08 -0500 (EST)
Received: from hal-station (unknown [23.129.64.147])
 by mta-15.privateemail.com (Postfix) with ESMTPA;
 Tue, 17 Feb 2026 19:45:37 -0500 (EST)
Date: Tue, 17 Feb 2026 19:45:31 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
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
Message-ID: <aZULq2bDnZpdXvIg@hal-station>
References: <20260212230905.688006-1-someguy@effective-light.com>
 <2e359cd9-0192-44d0-886f-7f93a8b0a4fa@amd.com>
 <aY99D-yXVydpMdwy@hal-station>
 <85319290-4027-4eb8-95d1-9009d23f2294@mailbox.org>
 <aZD0W7V_6--2yqNK@hal-station>
 <7f4a86ad-d642-444c-a576-17ff9caaa934@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f4a86ad-d642-444c-a576-17ff9caaa934@mailbox.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Wed, 18 Feb 2026 08:09:39 +0000
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

On Mon, Feb 16, 2026 at 10:28:13AM +0100, Michel Dänzer wrote:
> On 2/14/26 23:16, Hamza Mahfooz wrote:
> > On Sat, Feb 14, 2026 at 03:02:49PM +0100, Michel Dänzer wrote:
> >> Why couldn't a full modeset?
> > 
> > As far as I see it the only reasons why we should be timing out is
> > either an interrupt went missing (perhaps due to a race condition in
> > driver code) or hung hardware. In either case, the interrupt associated
> > with the page flip for the current commit is long gone.
> 
> That's a matter of bookkeeping, the interrupt isn't required to keep track of the commit and complete it.

Oh, if you're talking about sending out a "fake"
drm_crtc_send_vblank_event(), I had considered that. Though,
drivers that have hardware vblank counters take ownership of the
relevant `struct drm_pending_vblank_event` [1] pretty early on.
So, there wouldn't be a way to ensure that they send that out
and that would mean we never get a chance to force a full modeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_crtc.h?h=v6.19#n386

> 
> 
> >> In principle it's possible to do (the equivalent of) a modeset with the current state for all CRTCs, no need to do it separately per CRTC.
> > 
> > AFAIK that is what the uevent is already doing (unless I'm mistaken).
> 
> This is about just doing a full modeset, which isn't something user space can do in response to a wedged event.

I was referring to what compositors are doing in response to
`drm_kms_helper_hotplug_event()`. Perhaps, the enum constants should be
renamed, since the forced modeset is actually sent when the current
reset phase is DRM_KMS_RESET_NONE (the phase is updated before sending
out the event though).
