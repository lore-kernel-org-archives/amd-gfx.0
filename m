From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3] drm/amd: Fix Kconfig indentation
Date: Mon, 7 Oct 2019 14:54:13 -0400
Message-ID: <CADnq5_MpRZKTKLbJhzKOS=boP8RwvXPzkk0vBnJeRPgTHxStJQ@mail.gmail.com>
References: <20191007173322.9306-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007173322.9306-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Oct 7, 2019 at 1:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.  Thanks!

Alex

>
> ---
>
> Changes since v2:
> 1. Split AMD and i915 to separate patches.
> ---
>  drivers/gpu/drm/Kconfig             |  4 ++--
>  drivers/gpu/drm/amd/display/Kconfig | 32 ++++++++++++++---------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 108e1b7f4564..7cb6e4eb99e8 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -226,9 +226,9 @@ config DRM_AMDGPU
>         tristate "AMD GPU"
>         depends on DRM && PCI && MMU
>         select FW_LOADER
> -        select DRM_KMS_HELPER
> +       select DRM_KMS_HELPER
>         select DRM_SCHED
> -        select DRM_TTM
> +       select DRM_TTM
>         select POWER_SUPPLY
>         select HWMON
>         select BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 1bbe762ee6ba..313183b80032 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -23,16 +23,16 @@ config DRM_AMD_DC_DCN2_0
>         depends on DRM_AMD_DC && X86
>         depends on DRM_AMD_DC_DCN1_0
>         help
> -           Choose this option if you want to have
> -           Navi support for display engine
> +         Choose this option if you want to have
> +         Navi support for display engine
>
>  config DRM_AMD_DC_DCN2_1
> -        bool "DCN 2.1 family"
> -        depends on DRM_AMD_DC && X86
> -        depends on DRM_AMD_DC_DCN2_0
> -        help
> -            Choose this option if you want to have
> -            Renoir support for display engine
> +       bool "DCN 2.1 family"
> +       depends on DRM_AMD_DC && X86
> +       depends on DRM_AMD_DC_DCN2_0
> +       help
> +         Choose this option if you want to have
> +         Renoir support for display engine
>
>  config DRM_AMD_DC_DSC_SUPPORT
>         bool "DSC support"
> @@ -41,16 +41,16 @@ config DRM_AMD_DC_DSC_SUPPORT
>         depends on DRM_AMD_DC_DCN1_0
>         depends on DRM_AMD_DC_DCN2_0
>         help
> -           Choose this option if you want to have
> -           Dynamic Stream Compression support
> +         Choose this option if you want to have
> +         Dynamic Stream Compression support
>
>  config DRM_AMD_DC_HDCP
> -        bool "Enable HDCP support in DC"
> -        depends on DRM_AMD_DC
> -        help
> -         Choose this option
> -         if you want to support
> -         HDCP authentication
> +       bool "Enable HDCP support in DC"
> +       depends on DRM_AMD_DC
> +       help
> +        Choose this option
> +        if you want to support
> +        HDCP authentication
>
>  config DEBUG_KERNEL_DC
>         bool "Enable kgdb break in DC"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
