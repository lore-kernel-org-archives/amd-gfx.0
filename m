Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826C3D715D9
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jan 2026 09:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB8110E102;
	Sat, 24 Jan 2026 09:41:20 +0000 (UTC)
X-Greylist: delayed 52713 seconds by postgrey-1.36 at gabe;
 Fri, 23 Jan 2026 14:44:56 UTC
Received: from MTA-06-4.privateemail.com (mta-06-4.privateemail.com
 [198.54.122.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949E410EB0A;
 Fri, 23 Jan 2026 14:44:56 +0000 (UTC)
Received: from hal-station.localdomain
 (bras-base-toroon4332w-grc-44-142-112-152-160.dsl.bell.ca [142.112.152.160])
 by mta-06.privateemail.com (Postfix) with ESMTPA id 4dyLL26hDsz3hhTD;
 Fri, 23 Jan 2026 09:44:26 -0500 (EST)
Date: Fri, 23 Jan 2026 09:44:21 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Message-ID: <aXOJRWALUJLcGWqh@hal-station.localdomain>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
X-Mailman-Approved-At: Sat, 24 Jan 2026 09:41:19 +0000
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

On Fri, Jan 23, 2026 at 02:52:44PM +0100, Christian König wrote:
> I can only see two reasons why you could run into a timeout:
> 
> 1. A dma_fence never signals.
> 	How that should be handled is already well documented and doesn't require any of this.
> 
> 2. A coding error in the vblank or page flip handler leading to waiting forever.
> 	In that case calling back into the driver doesn't help either.
> 
> So as far as I can see the whole approach doesn't make any sense at all.

It appears that resetting display firmware is able to put at least a
subset of these systems back into a consistent (usable) state. Though, I
don't have a reliable way to reproduce the issue that I'm seeing so I
can't say for sure what it boils down to.
