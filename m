From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] drm/amd/powerplay: Zero initialize num_of_levels in vega20_set_single_dpm_table
Date: Wed, 20 Mar 2019 10:02:51 -0700
Message-ID: <CAKwvOdmBfCarhfJZLmfALsdhCVDWLdzS3XALXRNLpQCjZE88Mg@mail.gmail.com>
References: <20190320005842.25383-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190320005842.25383-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Mar 19, 2019 at 6:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:456:2: warning:
> variable 'num_of_levels' is used uninitialized whenever '?:' condition
> is false [-Wsometimes-uninitialized]
>         smu_read_smc_arg(smu, &num_of_levels);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:608:3: note:
> expanded from macro 'smu_read_smc_arg'
>         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:457:7: note:
> uninitialized use occurs here
>         if (!num_of_levels) {
>              ^~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:456:2: note: remove
> the '?:' if its condition is always true
>         smu_read_smc_arg(smu, &num_of_levels);
>         ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:608:3: note:
> expanded from macro 'smu_read_smc_arg'
>         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
>          ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:446:27: note:
> initialize the variable 'num_of_levels' to silence this warning
>         uint32_t i, num_of_levels, clk;
>                                  ^
>                                   = 0
> 1 warning generated.
>
> The if statement it mentions as potentially problematic is currently
> always true because the read_smc_arg callback is assigned at the
> bottom of this file but Clang can't tell that. If the callback were
> ever to disappear, num_of_levels would never be initialized. Just
> zero initialize it to ensure that the intent behind this code
> remains the same.

Thanks for the simple fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 870b996f955f ("drm/amd/powerplay: set defalut dpm table for smu")
> Link: https://github.com/ClangBuiltLinux/linux/issues/425
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 7e9e8ad9a300..41e6f49c9cb6 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -443,7 +443,7 @@ vega20_set_single_dpm_table(struct smu_context *smu,
>                             PPCLK_e clk_id)
>  {
>         int ret = 0;
> -       uint32_t i, num_of_levels, clk;
> +       uint32_t i, num_of_levels = 0, clk;
>
>         ret = smu_send_smc_msg_with_param(smu,
>                         SMU_MSG_GetDpmFreqByIndex,
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
