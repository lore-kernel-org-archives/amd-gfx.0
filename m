From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate header
Date: Mon, 26 Nov 2018 15:35:06 -0500
Message-ID: <CADnq5_NyW=w84HkHoL_M1=9M+e6dGLb3TYxZjTLZ9_O+5hS8bg@mail.gmail.com>
References: <20181122140126.GA3124@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122140126.GA3124@hp-pavilion-15-notebook-pc-brajeswar>
Sender: linux-kernel-owner@vger.kernel.org
To: brajeswar.linux@gmail.com
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, "Cheng, Tony" <Tony.Cheng@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Francis <David.Francis@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>, Souptick Joarder <jrdr.linux@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Nov 23, 2018 at 2:43 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove dce/dce_mem_input.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index d68f951f9869..c41408c3eaf1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -40,7 +40,6 @@
>  #include "dce/dce_mem_input.h"
>  #include "dce/dce_link_encoder.h"
>  #include "dce/dce_stream_encoder.h"
> -#include "dce/dce_mem_input.h"
>  #include "dce/dce_ipp.h"
>  #include "dce/dce_transform.h"
>  #include "dce/dce_opp.h"
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
