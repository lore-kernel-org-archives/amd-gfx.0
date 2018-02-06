From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: delete some dead code
Date: Tue, 6 Feb 2018 14:26:39 -0500
Message-ID: <CADnq5_PtZYDD5-S1UM3BEk+UeyE1=Tx_d=bJb_QvvEUtO99vhQ@mail.gmail.com>
References: <20180206123500.GA9203@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180206123500.GA9203@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Eric Huang <JinHuiEric.Huang@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Feb 6, 2018 at 7:35 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We deleted some code in e154162ef75d ("drm/amd/powerplay: refine pp code
> for raven") but there were a few related bits that were missed.  Let's
> delete them as well.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks!

Alex

>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> index 565fe0832f41..0b0fbb228edf 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -608,7 +608,6 @@ struct phm_dynamic_state_info {
>         struct phm_ppm_table                          *ppm_parameter_table;
>         struct phm_cac_tdp_table                      *cac_dtp_table;
>         struct phm_clock_voltage_dependency_table       *vdd_gfx_dependency_on_sclk;
> -       struct phm_vq_budgeting_table                           *vq_budgeting_table;
>  };
>
>  struct pp_fan_info {
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> index c3e7e34535e8..7545776a774d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> @@ -1697,9 +1697,6 @@ static int pp_tables_uninitialize(struct pp_hwmgr *hwmgr)
>         kfree(hwmgr->dyn_state.vdd_gfx_dependency_on_sclk);
>         hwmgr->dyn_state.vdd_gfx_dependency_on_sclk = NULL;
>
> -       kfree(hwmgr->dyn_state.vq_budgeting_table);
> -       hwmgr->dyn_state.vq_budgeting_table = NULL;
> -
>         return 0;
>  }
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
