From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use memset to initialize variables in fill_plane_dcc_attributes
Date: Fri, 1 Feb 2019 16:07:26 -0500
Message-ID: <CADnq5_NTyJMt5Kipvx6vMKfGBAtcf76hwmAHVaj5N-Mp6ChRRg@mail.gmail.com>
References: <20190201201226.12812-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201201226.12812-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Feb 1, 2019 at 3:25 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2314:38:
> warning: suggest braces around initialization of subobject
> [-Wmissing-braces]
>         struct dc_surface_dcc_cap output = {0};
>                                             ^
>                                             {}
>
> Previous efforts to fix this type of warning by adding or removing
> braces have been met with some pushback in favor of using memset [1][2].
> Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
> compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.
>
> [1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
> [2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
>
> Fixes: 7df7e505e82a ("drm/amd/display: Set requested plane state DCC params for GFX9")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied all three patches.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dccad2d207ce..1c1c162c4eee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2310,12 +2310,15 @@ static bool fill_plane_dcc_attributes(struct amdgpu_device *adev,
>                                       uint64_t info)
>  {
>         struct dc *dc = adev->dm.dc;
> -       struct dc_dcc_surface_param input = {0};
> -       struct dc_surface_dcc_cap output = {0};
> +       struct dc_dcc_surface_param input;
> +       struct dc_surface_dcc_cap output;
>         uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
>         uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
>         uint64_t dcc_address;
>
> +       memset(&input, 0, sizeof(input));
> +       memset(&output, 0, sizeof(output));
> +
>         if (!offset)
>                 return false;
>
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
