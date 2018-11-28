From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/pp: fix spelling mistake "dependancy" -> "dependency"
Date: Wed, 28 Nov 2018 15:26:48 -0500
Message-ID: <CADnq5_Nxz3o2ttyAkN=+Ti+N8RMkWx5bQHqM+bsbZ53=bNF3-A@mail.gmail.com>
References: <20181127141943.27110-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127141943.27110-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Nov 27, 2018 at 9:19 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are spelling mistakes in PP_ASSERT_WITH_CODE messages, fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 88f6b35ea6fe..5dcd21d29dbf 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -269,7 +269,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>                                         hwmgr->dyn_state.mvdd_dependency_on_mclk);
>
>                 PP_ASSERT_WITH_CODE((0 == result),
> -                               "Failed to retrieve SVI2 MVDD table from dependancy table.",
> +                               "Failed to retrieve SVI2 MVDD table from dependency table.",
>                                 return result;);
>         }
>
> @@ -288,7 +288,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>                         result = phm_get_svi2_voltage_table_v0(&(data->vddci_voltage_table),
>                                         hwmgr->dyn_state.vddci_dependency_on_mclk);
>                 PP_ASSERT_WITH_CODE((0 == result),
> -                               "Failed to retrieve SVI2 VDDCI table from dependancy table.",
> +                               "Failed to retrieve SVI2 VDDCI table from dependency table.",
>                                 return result);
>         }
>
> @@ -317,7 +317,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>                                 table_info->vddc_lookup_table);
>
>                 PP_ASSERT_WITH_CODE((0 == result),
> -                       "Failed to retrieve SVI2 VDDC table from dependancy table.", return result;);
> +                       "Failed to retrieve SVI2 VDDC table from dependency table.", return result;);
>         }
>
>         tmp = smum_get_mac_definition(hwmgr, SMU_MAX_LEVELS_VDDC);
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
