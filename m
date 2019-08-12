From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix a typo - dce_aduio_mask --> dce_audio_mask
Date: Mon, 12 Aug 2019 12:09:14 -0400
Message-ID: <CADnq5_MM+ojG+jmuW-FpdusYzsa2BW_pguGPoMYSQFo4d5z72g@mail.gmail.com>
References: <20190809201219.629-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809201219.629-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Sat, Aug 10, 2019 at 9:55 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This should be 'dce_audio_mask', not 'dce_aduio_mask'.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c          | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.h          | 6 +++---
>  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> index 549704998f84..1e88c5f46be7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -937,7 +937,7 @@ struct audio *dce_audio_create(
>                 unsigned int inst,
>                 const struct dce_audio_registers *reg,
>                 const struct dce_audio_shift *shifts,
> -               const struct dce_aduio_mask *masks
> +               const struct dce_audio_mask *masks
>                 )
>  {
>         struct dce_audio *audio = kzalloc(sizeof(*audio), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> index a0d5724aab31..1392fab0860b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> @@ -101,7 +101,7 @@ struct dce_audio_shift {
>         uint32_t DCCG_AUDIO_DTO1_USE_512FBR_DTO;
>  };
>
> -struct dce_aduio_mask {
> +struct dce_audio_mask {
>         uint32_t AZALIA_ENDPOINT_REG_INDEX;
>         uint32_t AZALIA_ENDPOINT_REG_DATA;
>
> @@ -125,7 +125,7 @@ struct dce_audio {
>         struct audio base;
>         const struct dce_audio_registers *regs;
>         const struct dce_audio_shift *shifts;
> -       const struct dce_aduio_mask *masks;
> +       const struct dce_audio_mask *masks;
>  };
>
>  struct audio *dce_audio_create(
> @@ -133,7 +133,7 @@ struct audio *dce_audio_create(
>                 unsigned int inst,
>                 const struct dce_audio_registers *reg,
>                 const struct dce_audio_shift *shifts,
> -               const struct dce_aduio_mask *masks);
> +               const struct dce_audio_mask *masks);
>
>  void dce_aud_destroy(struct audio **audio);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index 6248c8455314..81116286b15b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -304,7 +304,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 764329264c3b..765e26454a18 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -331,7 +331,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index c6136e0ed1a4..3ac4c7e73050 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -337,7 +337,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 54be7ab370df..9a922cd39cf2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -352,7 +352,7 @@ static const struct dce_audio_shift audio_shift = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 860a524ebcfa..2a1ce9ecc66e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -322,7 +322,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index 1a20461c2937..1c5835975935 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -270,7 +270,7 @@ static const struct dce_audio_shift audio_shift = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
