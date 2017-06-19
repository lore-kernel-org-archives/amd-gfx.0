From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: fix ps allocation size for EnableDispPowerGating
Date: Mon, 19 Jun 2017 12:58:18 -0400
Message-ID: <CADnq5_NQvtnLjGuwDPK2yOVUWcG=twAzXmGbyiXg+vODGymeNg@mail.gmail.com>
References: <1497539827-26354-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1497539827-26354-1-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Ping?

On Thu, Jun 15, 2017 at 11:17 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
> We were using the wrong structure which lead to an overflow
> on some boards.
>
> bug: https://bugs.freedesktop.org/show_bug.cgi?id=101387
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/atombios_crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> index 8c9bc75..8a0818b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> @@ -165,7 +165,7 @@ void amdgpu_atombios_crtc_powergate(struct drm_crtc *crtc, int state)
>         struct drm_device *dev = crtc->dev;
>         struct amdgpu_device *adev = dev->dev_private;
>         int index = GetIndexIntoMasterTable(COMMAND, EnableDispPowerGating);
> -       ENABLE_DISP_POWER_GATING_PARAMETERS_V2_1 args;
> +       ENABLE_DISP_POWER_GATING_PS_ALLOCATION args;
>
>         memset(&args, 0, sizeof(args));
>
> @@ -178,7 +178,7 @@ void amdgpu_atombios_crtc_powergate(struct drm_crtc *crtc, int state)
>  void amdgpu_atombios_crtc_powergate_init(struct amdgpu_device *adev)
>  {
>         int index = GetIndexIntoMasterTable(COMMAND, EnableDispPowerGating);
> -       ENABLE_DISP_POWER_GATING_PARAMETERS_V2_1 args;
> +       ENABLE_DISP_POWER_GATING_PS_ALLOCATION args;
>
>         memset(&args, 0, sizeof(args));
>
> --
> 2.5.5
>
