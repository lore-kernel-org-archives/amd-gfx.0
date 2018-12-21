From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay/polaris10_smumgr: Remove duplicate
Date: Fri, 21 Dec 2018 13:32:03 -0500
Message-ID: <CADnq5_O3s4FgVDNz=5O4mKOuVeCJUSEfDUri=bQOQHUBv+zU2Q@mail.gmail.com>
References: <20181221141150.GA2872@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221141150.GA2872@hp-pavilion-15-notebook-pc-brajeswar>
Sender: linux-kernel-owner@vger.kernel.org
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>, Souptick Joarder <jrdr.linux@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Already fixed here:
https://cgit.freedesktop.org/drm/drm/commit/?id=7e07834c12b96214e95a473f7b14fc03b20e2e7a

Thanks,

Alex

On Fri, Dec 21, 2018 at 9:59 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove ppatomctrl.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 872d3824337b..2b2c26616902 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -44,7 +44,6 @@
>
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
> -#include "ppatomctrl.h"
>  #include "atombios.h"
>  #include "pppcielanes.h"
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
