Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E12EA3F22
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FE710E4E9;
	Tue, 10 Feb 2026 08:20:30 +0000 (UTC)
Received: from MTA-06-4.privateemail.com (mta-06-4.privateemail.com
 [198.54.122.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC48810E48D;
 Mon,  9 Feb 2026 23:04:54 +0000 (UTC)
Received: from hal-station (unknown [23.129.64.210])
 by mta-06.privateemail.com (Postfix) with ESMTPA id 4f90d107YPz3hhTF;
 Mon,  9 Feb 2026 18:04:20 -0500 (EST)
Date: Mon, 9 Feb 2026 18:04:15 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Xaver Hugl <xaver.hugl@kde.org>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Ivan Lipski <ivan.lipski@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm: introduce KMS recovery mechanism
Message-ID: <aYpn74JYNIR5Kr-9@hal-station>
References: <20260206235846.1019172-1-someguy@effective-light.com>
 <2ac2dc2f-552c-4084-872b-179a1e489156@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ac2dc2f-552c-4084-872b-179a1e489156@amd.com>
X-Mailman-Approved-At: Tue, 10 Feb 2026 08:20:22 +0000
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

On Mon, Feb 09, 2026 at 10:35:05AM +0100, Christian König wrote:
> > +	/**
> > +	 * @page_flip_timeout:
> > +	 *
> > +	 * This optional hook is called if &drm_crtc_commit.flip_done times out,
> > +	 * and can be used by drivers to attempt to recover from a page flip
> > +	 * timeout.
> > +	 */
> > +	void (*page_flip_timeout)(struct drm_crtc *crtc);
> 
> As far as I can see a callback is clearly not the right approach.
> 
> The drm_atomic_helper_wait_for_flip_done() helper is called by the driver, isn't it?
> 
> So what we need is just to give an error code back to the driver.
> 

I guess we could just have the function return -ETIMEOUT, but then
drivers wouldn't know which crtc is timing out and AFAIK drivers aren't
supposed to touch `drm_crtc_commit`s so they don't really have a
sanctioned means to figure that out on their own.
