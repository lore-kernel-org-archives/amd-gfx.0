From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms
 wait
Date: Tue, 25 Jun 2019 16:12:15 +0200
Message-ID: <1561471935.2587.11.camel@pengutronix.de>
References: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
         <20190625140046.31682-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625140046.31682-1-harry.wentland@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, airlied@gmail.com, natechancellor@gmail.com
Cc: sunpeng.li@amd.com, Anthony.Koo@amd.com, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, Jun.Lei@amd.com, Bhawanpreet.Lakha@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Hi Harry,

Am Dienstag, den 25.06.2019, 10:00 -0400 schrieb Harry Wentland:
> arm32's udelay only allows values up to 2000 microseconds. msleep
> does the trick for us here as there is no problem if this isn't
> microsecond accurate and takes a tad longer.

A "tad" longer in this case means likely double the intended wait.
Please see "SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms)" in
Documentation/timers/timers-howto.txt.

The sleep here should use usleep_range. In general the DC code seems to
use quite a lot of the udelay busy waits. I doubt that many of those
occurrences are in atomic context, so could easily use a sleeping wait.

Digging further this seems to apply across amdgpu, not only DC.

Regards,
Lucas

> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 4c31930f1cdf..f5d02f89b3f9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -548,7 +548,7 @@ static void
> read_edp_current_link_settings_on_detect(struct dc_link *link)
>  			break;
>  		}
>  
> -		udelay(8000);
> +		msleep(8);
>  	}
>  
>  	ASSERT(status == DC_OK);
