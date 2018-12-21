From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Remove duplicate header
Date: Fri, 21 Dec 2018 18:05:49 +0530
Message-ID: <CAFqt6zbRVuJ2=5nMb1S3am86tPE6117cSU32Rtyrwf8Ajk_Xrg@mail.gmail.com>
References: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
Sender: linux-kernel-owner@vger.kernel.org
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: rex.zhu@amd.com, evan.quan@amd.com, "Deucher, Alexander" <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, airlied@linux.ie, Hawking.Zhang@amd.com, ray.huang@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sabyasachi Gupta <sabyasachi.linux@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Dec 21, 2018 at 2:49 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove hwmgr_ppt.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> index e5a60aa44b5d..07d180ce4d18 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -28,7 +28,6 @@
>  #include "hardwaremanager.h"
>  #include "hwmgr_ppt.h"
>  #include "ppatomctrl.h"
> -#include "hwmgr_ppt.h"
>  #include "power_state.h"
>  #include "smu_helper.h"
>
> --
> 2.17.1
>
