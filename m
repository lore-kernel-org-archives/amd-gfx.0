From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] gpu: fix typos in code comments
Date: Mon, 20 May 2019 13:18:40 -0400
Message-ID: <CADnq5_OURX-qSsendCS9qOfi1CoWUK9BV9HJgTkFzB87bgjMmA@mail.gmail.com>
References: <20190518134141.23214-1-houweitaoo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190518134141.23214-1-houweitaoo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weitao Hou <houweitaoo@gmail.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Daenzer, Michel" <michel.daenzer@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, Ken Chalmers <ken.chalmers@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, May 20, 2019 at 1:04 PM Weitao Hou <houweitaoo@gmail.com> wrote:
>
> fix eror to error
>
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index f70437aae8e0..df422440845b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -183,8 +183,8 @@ static bool calculate_fb_and_fractional_fb_divider(
>  *RETURNS:
>  * It fills the PLLSettings structure with PLL Dividers values
>  * if calculated values are within required tolerance
> -* It returns   - true if eror is within tolerance
> -*              - false if eror is not within tolerance
> +* It returns   - true if error is within tolerance
> +*              - false if error is not within tolerance
>  */
>  static bool calc_fb_divider_checking_tolerance(
>                 struct calc_pll_clock_source *calc_pll_cs,
> --
> 2.18.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
