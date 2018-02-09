From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 1/4] ASoC: dapm: fix debugfs read using path->connected
Date: Fri, 9 Feb 2018 13:25:30 -0800
Message-ID: <20180209212530.GF116483@google.com>
References: <20180209212216.71447-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180209212216.71447-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Justin TerAvest <teravest@chromium.org>, Craig Bergstrom <craigb@chromium.org>, KaiChieh Chuang <kaichieh.chuang@mediatek.com>, Mark Brown <broonie@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Sorry, I unintentionally 'recycled' git send-email parameters, please
ignore this patch :(

El Fri, Feb 09, 2018 at 01:22:13PM -0800 Matthias Kaehlcke ha dit:

> From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> 
> This fix a bug in dapm_widget_power_read_file(),
> where it may sent opposite order of source/sink widget
> into the p->connected().
> 
> for example,
> static int connected_check(source, sink);
> {"w_sink", NULL, "w_source", connected_check}
> 
> the dapm_widget_power_read_file() will query p->connected()
> in following case
> 	p->conneted("w_source", "w_sink")
> 	p->conneted("w_sink", "w_source")
> we should avoid the last case, since it's the wrong order (source/sink)
> as declared in snd_soc_dapm_route.
> 
> Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  sound/soc/soc-dapm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index a10b21cfc31e..ee6d9d9a3c5e 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2026,7 +2026,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
>  	snd_soc_dapm_for_each_direction(dir) {
>  		rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
>  		snd_soc_dapm_widget_for_each_path(w, dir, p) {
> -			if (p->connected && !p->connected(w, p->node[rdir]))
> +			if (p->connected && !p->connected(p->source, p->sink))
>  				continue;
>  
>  			if (!p->connect)
