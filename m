From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove duplicated assignment to grph_obj_type
Date: Fri, 8 Nov 2019 11:30:19 -0500
Message-ID: <CADnq5_PdP3=gMbbcvTqf07=3mP-ZXdrvxWzmcpoFEd2_B9cTqg@mail.gmail.com>
References: <20191108144527.120927-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108144527.120927-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Nov 8, 2019 at 9:45 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable grph_obj_type is being assigned twice, one of these is
> redundant so remove it.
>
> Addresses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index be6d0cfe41ae..9ba80d828876 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -365,8 +365,7 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
>                         router.ddc_valid = false;
>                         router.cd_valid = false;
>                         for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
> -                               uint8_t grph_obj_type=
> -                               grph_obj_type =
> +                               uint8_t grph_obj_type =
>                                     (le16_to_cpu(path->usGraphicObjIds[j]) &
>                                      OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
