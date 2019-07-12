From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] drm/amd/display: return 'NULL' instead of 'false' from
 dcn20_acquire_idle_pipe_for_layer
Date: Fri, 12 Jul 2019 10:57:15 -0700
Message-ID: <20190712175715.GA21080@archlinux-threadripper>
References: <20190712094009.1535662-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190712094009.1535662-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Nikola Cornij <nikola.cornij@amd.com>, Charlene Liu <charlene.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Jul 12, 2019 at 11:39:52AM +0200, Arnd Bergmann wrote:
> clang complains that 'false' is a not a pointer:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:2428:10: error: expression which evaluates to zero treated as a null pointer constant of type 'struct pipe_ctx *' [-Werror,-Wnon-literal-null-conversion]
>                 return false;
> 
> Changing it to 'NULL' looks like the right thing that will shut up
> the warning and make it easier to read, while not changing behavior.
> 
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
