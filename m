From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix incorrect null check on pointer
Date: Mon, 29 Apr 2019 15:29:14 -0400
Message-ID: <CADnq5_PwaZkbQ24vO=zi4HvMXTjayUKV3mnTiBt6X9AV=fXEBg@mail.gmail.com>
References: <20190426214811.12310-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426214811.12310-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Apr 26, 2019 at 5:48 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently an allocation is being made but the allocation failure
> check is being performed on another pointer. Fix this by checking
> the correct pointer. Also use the normal kernel idiom for null
> pointer checks.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 43e3ac8389ef ("drm/amd/display: Add function to copy DC streams")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 6200df3edcd0..96e97d25d639 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -168,7 +168,7 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
>         struct dc_stream_state *new_stream;
>
>         new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
> -       if (stream == NULL)
> +       if (!new_stream)
>                 return NULL;
>
>         memcpy(new_stream, stream, sizeof(struct dc_stream_state));
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
