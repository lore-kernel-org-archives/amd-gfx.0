From: Nathan Chancellor <natechancellor@gmail.com>
Subject: arm32 build failure after abe882a39a9c ("drm/amd/display: fix issue
 with eDP not detected on driver load")
Date: Mon, 17 Jun 2019 18:11:24 -0700
Message-ID: <20190618011124.GA67760@archlinux-epyc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Koo <Anthony.Koo@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi all,

After commit abe882a39a9c ("drm/amd/display: fix issue with eDP not
detected on driver load") in -next, arm32 allyesconfig builds start
failing at link time:

arm-linux-gnueabi-ld: drivers/gpu/drm/amd/display/dc/core/dc_link.o: in
function `dc_link_detect':
dc_link.c:(.text+0x260c): undefined reference to `__bad_udelay'

arm32 only allows a udelay value of up to 2000, see
arch/arm/include/asm/delay.h for more info.

Please look into this when you have a chance!
Nathan
