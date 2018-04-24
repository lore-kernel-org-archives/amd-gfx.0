From: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] drm/radeon: Change the default to PCI on PowerPC
Date: Tue, 24 Apr 2018 21:56:42 +0200
Message-ID: <CA+7wUszw=fF_kUW+Et07nnX1=0VBtrPJU6yfZsuk_uLUJPQsmw@mail.gmail.com>
References: <20180424195512.491-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424195512.491-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

For reference:

https://lists.freedesktop.org/archives/mesa-dev/2016-May/115453.html

2018-04-24 21:55 GMT+02:00 Mathieu Malaterre <malat@debian.org>:
> AGP mode is unstable on PowerPC. Symptoms are generally of the form:
>
> [ 1228.795711] radeon 0000:00:10.0: ring 0 stalled for more than 10240mse=
c
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index b28288a781ef..2a7977a23b31 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -168,7 +168,12 @@ int radeon_no_wb;
>  int radeon_modeset =3D -1;
>  int radeon_dynclks =3D -1;
>  int radeon_r4xx_atom =3D 0;
> +#ifdef __powerpc__
> +/* Default to PCI on PowerPC (fdo #95017) */
> +int radeon_agpmode =3D -1;
> +#else
>  int radeon_agpmode =3D 0;
> +#endif
>  int radeon_vram_limit =3D 0;
>  int radeon_gart_size =3D -1; /* auto */
>  int radeon_benchmarking =3D 0;
> --
> 2.11.0
>
