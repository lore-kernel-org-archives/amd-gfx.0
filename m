Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AB4EA3F26
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DC810E4F2;
	Tue, 10 Feb 2026 08:20:25 +0000 (UTC)
Received: from MTA-06-4.privateemail.com (mta-06-4.privateemail.com
 [198.54.122.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF5610E46D;
 Mon,  9 Feb 2026 22:53:58 +0000 (UTC)
Received: from hal-station (tor-exit.csail.mit.edu [128.31.0.13])
 by mta-06.privateemail.com (Postfix) with ESMTPA id 4f90NS0WXBz3hhTH;
 Mon,  9 Feb 2026 17:53:27 -0500 (EST)
Date: Mon, 9 Feb 2026 17:53:23 -0500
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
 Thomas Zimmermann <tzimmermann@suse.de>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/amdgpu: implement page_flip_timeout() supporty
Message-ID: <aYplYyf6Pp20lOAD@hal-station>
References: <20260206235846.1019172-1-someguy@effective-light.com>
 <20260206235846.1019172-2-someguy@effective-light.com>
 <8c5ed6e7-e2e3-4aba-9b3c-bc1609765d14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c5ed6e7-e2e3-4aba-9b3c-bc1609765d14@amd.com>
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

On Mon, Feb 09, 2026 at 10:36:23AM +0100, Christian König wrote:
> Well that might work but is even worse than a GPU reset.
> 
> Have you tried to just signal the page flip as done?
> 

I have tried that actually and it didn't work in my case (outside of
your contrived scenario [1], though forcing a full modeset should take
care of that case regardless).

Though, I strongly suspect a firmware hang with the issue that I'm
seeing since I get DMCUB errors before the timeout. i.e.:

amdgpu 0000:06:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[...]
amdgpu 0000:06:00.0: [drm] *ERROR* [CRTC:364:crtc-0] flip_done timed out


[1] https://lore.kernel.org/r/30f2480d-016f-417e-9ddf-7805e4943e7b@amd.com/
