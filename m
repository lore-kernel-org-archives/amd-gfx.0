From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm/amd/display: include missing linux/delay.h
Date: Mon, 17 Jun 2019 16:41:09 +0200
Message-ID: <20190617144109.GA14528@ravnborg.org>
References: <20190617123915.926526-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617123915.926526-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Thomas Lim <Thomas.Lim@amd.com>, Eric Yang <eric.yang2@amd.com>, Charlene Liu <charlene.liu@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, dri-devel@lists.freedesktop.org, Tony Cheng <tony.cheng@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Hi Arnd.

On Mon, Jun 17, 2019 at 02:38:55PM +0200, Arnd Bergmann wrote:
> Some randconfig builds fail to compile the dcn10 code because of
> a missing declaration:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function 'dcn10_apply_ctx_for_surface':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
> 
> Include the appropriate kernel header.
> 
> Fixes: 9ed43ef84d9d ("drm/amd/display: Add Underflow Asserts to dc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 1ac9a4f03990..d87ddc7de9c6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -22,6 +22,7 @@
>   * Authors: AMD
>   *
>   */
> +#include <linux/delay.h>
>  
>  #include <linux/delay.h>
>  #include "dm_services.h"

Something has gone wrong here, as you add a second include of linux/delay.h.

We had this problem before, which Alex fixed by applying a patch to
include linux/delay.h


	Sam
