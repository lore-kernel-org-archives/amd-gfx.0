From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm: radeon: replace 0 with NULL
Date: Tue, 26 Nov 2019 11:27:55 -0500
Message-ID: <CADnq5_Mvx8yNG=PUYB6s+Dwqevbx4a0gC-K7iqmNtM-shrDOLw@mail.gmail.com>
References: <20191126003514.133692-1-jbi.octave@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126003514.133692-1-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jules Irenge <jbi.octave@gmail.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Tue, Nov 26, 2019 at 3:15 AM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Replace 0 with NULL to fix sparse tool  warning
>  warning: Using plain integer as NULL pointer
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
> index b9aea5776d3d..2269cfced788 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -288,7 +288,7 @@ static void radeon_audio_interface_init(struct radeon_device *rdev)
>         } else {
>                 rdev->audio.funcs = &r600_funcs;
>                 rdev->audio.hdmi_funcs = &r600_hdmi_funcs;
> -               rdev->audio.dp_funcs = 0;
> +               rdev->audio.dp_funcs = NULL;
>         }
>  }
>
> --
> 2.23.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
