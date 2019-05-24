From: Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH] drm/amd/display: Don't load DMCU for Raven 1 (v2)
Date: Fri, 24 May 2019 17:09:41 +0100
Message-ID: <CAHbf0-FPr8EZoZeDJKpGp3=wF38JeG7fY-Ayq96jSqq3hMNM+g@mail.gmail.com>
References: <20190524153410.19402-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190524153410.19402-1-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi

Curious to know what this means for folk that have newer Raven1 boards
that didn't have issues loading the firmware

Cheers

Mike

On Fri, 24 May 2019 at 16:34, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> From: Harry Wentland <harry.wentland@amd.com>
>
> [WHY]
> Some early Raven boards had a bad SBIOS that doesn't play nicely with
> the DMCU FW. We thought the issues were fixed by ignoring errors on DMCU
> load but that doesn't seem to be the case. We've still seen reports of
> users unable to boot their systems at all.
>
> [HOW]
> Disable DMCU load on Raven 1. Only load it for Raven 2 and Picasso.
>
> v2: Fix ifdef (Alex)
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 995f9df66142..bcb1a93c0b4c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -29,6 +29,7 @@
>  #include "dm_services_types.h"
>  #include "dc.h"
>  #include "dc/inc/core_types.h"
> +#include "dal_asic_id.h"
>
>  #include "vid.h"
>  #include "amdgpu.h"
> @@ -640,7 +641,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>
>  static int load_dmcu_fw(struct amdgpu_device *adev)
>  {
> -       const char *fw_name_dmcu;
> +       const char *fw_name_dmcu = NULL;
>         int r;
>         const struct dmcu_firmware_header_v1_0 *hdr;
>
> @@ -663,7 +664,14 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>         case CHIP_VEGA20:
>                 return 0;
>         case CHIP_RAVEN:
> -               fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
> +#if defined(CONFIG_DRM_AMD_DC_DCN1_01)
> +               if (ASICREV_IS_PICASSO(adev->external_rev_id))
> +                       fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
> +               else if (ASICREV_IS_RAVEN2(adev->external_rev_id))
> +                       fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
> +               else
> +#endif
> +                       return 0;
>                 break;
>         default:
>                 DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
