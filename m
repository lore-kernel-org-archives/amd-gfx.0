Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F043D715E0
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jan 2026 09:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C2A10E316;
	Sat, 24 Jan 2026 09:41:22 +0000 (UTC)
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com
 [162.0.218.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAB510EB02;
 Fri, 23 Jan 2026 14:26:35 +0000 (UTC)
Received: from MTA-13-4.privateemail.com (mta-13-1.privateemail.com
 [198.54.122.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4dyKxM24g9z2xGP;
 Fri, 23 Jan 2026 14:26:31 +0000 (UTC)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
 by mta-13.privateemail.com (Postfix) with ESMTP id 4dyKxJ64Jnz3hhTT;
 Fri, 23 Jan 2026 09:26:28 -0500 (EST)
Received: from hal-station.localdomain
 (bras-base-toroon4332w-grc-44-142-112-152-160.dsl.bell.ca [142.112.152.160])
 by mta-13.privateemail.com (Postfix) with ESMTPA;
 Fri, 23 Jan 2026 09:26:00 -0500 (EST)
Date: Fri, 23 Jan 2026 09:25:57 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ce Sun <cesun102@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: implement page_flip_timeout() support
Message-ID: <aXOE9ckM2enIgFuX@hal-station.localdomain>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <20260123000537.2450496-2-someguy@effective-light.com>
 <10030872.eNJFYEL58v@timur-hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10030872.eNJFYEL58v@timur-hyperion>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4dyKxM24g9z2xGP
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

On Fri, Jan 23, 2026 at 12:20:30PM +0100, Timur Kristóf wrote:
> MODE2 reset _is_ a full reset on APUs, it resets everything but just doesn't 
> lose the RAM contents. Also note that MODE2 reset is not supported on 
> dedicated GPUs, so this will likely trigger a full reset for those.
> 
> Can you say how you tested this? I'd be happy to test it myself too.

Unfortunately, I don't have a reliable way to reproduce timeouts.
Though, that machine usually hangs if I leave it idle overnight and
forget to turn off the display (I have DPMS disabled). So, I just let
nature run its course, I guess you can say and checked dmesg in the
morning to find that it had reset and was still usable.

