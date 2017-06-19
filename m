From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: adjust default display clock
Date: Mon, 19 Jun 2017 13:36:59 -0400
Message-ID: <CADnq5_PP=wMVi5JayAcF-0HGKAeZbhS+pyhV1OW5LeW1dVqHsQ@mail.gmail.com>
References: <1497539827-26354-1-git-send-email-alexander.deucher@amd.com> <1497539827-26354-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1497539827-26354-2-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

ping.

On Thu, Jun 15, 2017 at 11:17 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
> Increase the default display clock on newer asics to
> accomodate some high res modes with really high refresh
> rates.
>
> bug: https://bugs.freedesktop.org/show_bug.cgi?id=93826
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 1cf78f4..1e8e112 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -693,6 +693,10 @@ int amdgpu_atombios_get_clock_info(struct amdgpu_device *adev)
>                         DRM_INFO("Changing default dispclk from %dMhz to 600Mhz\n",
>                                  adev->clock.default_dispclk / 100);
>                         adev->clock.default_dispclk = 60000;
> +               } else if (adev->clock.default_dispclk <= 60000) {
> +                       DRM_INFO("Changing default dispclk from %dMhz to 625Mhz\n",
> +                                adev->clock.default_dispclk / 100);
> +                       adev->clock.default_dispclk = 62500;
>                 }
>                 adev->clock.dp_extclk =
>                         le16_to_cpu(firmware_info->info_21.usUniphyDPModeExtClkFreq);
> --
> 2.5.5
>
