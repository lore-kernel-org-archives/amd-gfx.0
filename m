From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix missing break in switch statement
Date: Mon, 22 Jul 2019 15:10:20 -0400
Message-ID: <CADnq5_OTmx==m+1fJbf1PxPhPM0H0O8GRjq4eWeX6sw889YPrA@mail.gmail.com>
References: <20190721214935.GA910@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190721214935.GA910@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Philip Cox <Philip.Cox@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Sun, Jul 21, 2019 at 6:12 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to case CHIP_NAVI10.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 792371442195..4e3fc284f6ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -668,6 +668,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>         case CHIP_RAVEN:
>                 pcache_info = raven_cache_info;
>                 num_of_cache_types = ARRAY_SIZE(raven_cache_info);
> +               break;
>         case CHIP_NAVI10:
>                 pcache_info = navi10_cache_info;
>                 num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
> --
> 2.22.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
