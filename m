From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon/r300: Mark expected switch fall-throughs
Date: Fri, 12 Oct 2018 13:29:33 -0400
Message-ID: <CADnq5_ODxnRPUFe-Sr3TN3E7kq+kxXVo_VvOVpT5_CdNSu3oCw@mail.gmail.com>
References: <20181012161236.GA21768@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012161236.GA21768@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

This and the r420 patch applied.  Thanks!

Alex
On Fri, Oct 12, 2018 at 1:11 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced "Pass through." with
> "Fall through.", which is what GCC is expecting to find.
>
> Addresses-Coverity-ID: 114734 ("Missing break in switch")
> Addresses-Coverity-ID: 114735 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/radeon/r300.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
> index 21161aa..652126f 100644
> --- a/drivers/gpu/drm/radeon/r300.c
> +++ b/drivers/gpu/drm/radeon/r300.c
> @@ -814,7 +814,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
>                                           ((idx_value >> 21) & 0xF));
>                                 return -EINVAL;
>                         }
> -                       /* Pass through. */
> +                       /* Fall through. */
>                 case 6:
>                         track->cb[i].cpp = 4;
>                         break;
> @@ -965,7 +965,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
>                                 return -EINVAL;
>                         }
>                         /* The same rules apply as for DXT3/5. */
> -                       /* Pass through. */
> +                       /* Fall through. */
>                 case R300_TX_FORMAT_DXT3:
>                 case R300_TX_FORMAT_DXT5:
>                         track->textures[i].cpp = 1;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
