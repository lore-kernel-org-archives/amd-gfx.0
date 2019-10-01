From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: Re: [PATCH] drm/amd/display: memory leak
Date: Tue, 1 Oct 2019 12:51:41 -0500
Message-ID: <CAEkB2ETM9zAnUMkx1GYJmGz2X_QYhkJEmr4Qi5xNV2AX=Qcb-Q@mail.gmail.com>
References: <20190917032106.32342-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917032106.32342-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Nikola Cornij <nikola.cornij@amd.com>
Cc: Navid Emamdoost <emamd001@umn.edu>, Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eric Yang <Eric.Yang2@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Ken Chalmers <ken.chalmers@amd.com>, Eric Bernstein <Eric.Bernstein@amd.com>, Roman Li <Roman.Li@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, hersen wu <hersenxs.wu@amd.com>, Charlene Liu <Charlen>
List-Id: amd-gfx.lists.freedesktop.org

Would you please review this patch?


Thanks,
Navid.

On Mon, Sep 16, 2019 at 10:21 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In dcn*_clock_source_create when dcn20_clk_src_construct fails allocated
> clk_src needs release.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
>  7 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index 6248c8455314..21de230b303a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -667,7 +667,8 @@ struct clock_source *dce100_clock_source_create(
>                 clk_src->base.dp_clk_src = dp_clk_src;
>                 return &clk_src->base;
>         }
> -
> +
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 764329264c3b..0cb83b0e0e1e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -714,6 +714,7 @@ struct clock_source *dce110_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index c6136e0ed1a4..147d77173e2b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -687,6 +687,7 @@ struct clock_source *dce112_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 4a6ba3173a5a..0b5eeff17d00 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -500,6 +500,7 @@ static struct clock_source *dce120_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 860a524ebcfa..952440893fbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -701,6 +701,7 @@ struct clock_source *dce80_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index a12530a3ab9c..3f25e8da5396 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -786,6 +786,7 @@ struct clock_source *dcn10_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index b949e202d6cb..418fdcf1f492 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -955,6 +955,7 @@ struct clock_source *dcn20_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src)
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> --
> 2.17.1
>


-- 
Navid.
