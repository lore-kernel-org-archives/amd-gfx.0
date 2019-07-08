From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: vega20: fix uninitialized variable use
Date: Mon, 8 Jul 2019 12:03:09 -0400
Message-ID: <CADnq5_NGiM+Bs_AwBC5GUOv2Dx11_fvaqJXtQZKR_drVy68O8w@mail.gmail.com>
References: <20190708140816.1334640-1-arnd@arndb.de> <20190708140816.1334640-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708140816.1334640-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Chengming Gui <Jack.Gui@amd.com>, Kevin Wang <kevin1.wang@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 8, 2019 at 10:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> If smu_get_current_rpm() fails, we can't use the output,
> as that may be uninitialized:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: error: variable 'current_rpm' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
>         ret = smu_get_current_rpm(smu, &current_rpm);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
>         ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3024:12: note: uninitialized use occurs here
>         percent = current_rpm * 100 / pptable->FanMaximumRpm;
>                   ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: note: remove the '?:' if its condition is always true
>         ret = smu_get_current_rpm(smu, &current_rpm);
>               ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
>         ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
>          ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3020:22: note: initialize the variable 'current_rpm' to silence this warning
>         uint32_t current_rpm;
>
> Propagate the error code in that case.
>
> Fixes: ee0db82027ee ("drm/amd/powerplay: move PPTable_t uses into asic level")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 9ce3f1c8ae0f..20d477f8dc84 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3021,10 +3021,13 @@ static int vega20_get_fan_speed_percent(struct smu_context *smu,
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
>
>         ret = smu_get_current_rpm(smu, &current_rpm);
> +       if (ret)
> +               return ret;
> +
>         percent = current_rpm * 100 / pptable->FanMaximumRpm;
>         *speed = percent > 100 ? 100 : percent;
>
> -       return ret;
> +       return 0;
>  }
>
>  static int vega20_get_gpu_power(struct smu_context *smu, uint32_t *value)
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
