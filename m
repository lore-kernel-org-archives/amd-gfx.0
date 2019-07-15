From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3 05/24] drm/amdgpu: remove memset after kzalloc
Date: Mon, 15 Jul 2019 12:19:43 -0400
Message-ID: <CADnq5_ODy9iAbB60CC4nFAPLx51jBh_KJCRWO9rdqzWPpP0FFQ@mail.gmail.com>
References: <20190715031731.6421-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715031731.6421-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 15, 2019 at 3:57 AM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kzalloc has already zeroed the memory during the allocation.
> So memset is unneeded.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied. thanks!

Alex

> ---
> Changes in v3:
>   - Fix subject prefix: gpu/drm -> drm/amdgpu
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c            | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         | 2 --
>  5 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index fd22b4474dbf..4e6da61d1a93 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -279,8 +279,6 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
>                 return DAL_INVALID_IRQ_HANDLER_IDX;
>         }
>
> -       memset(handler_data, 0, sizeof(*handler_data));
> -
>         init_handler_common_data(handler_data, ih, handler_args, &adev->dm);
>
>         irq_source = int_params->irq_source;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> index 1cd5a8b5cdc1..b760f95e7fa7 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -1067,8 +1067,6 @@ static int pp_tables_v1_0_initialize(struct pp_hwmgr *hwmgr)
>         PP_ASSERT_WITH_CODE((NULL != hwmgr->pptable),
>                             "Failed to allocate hwmgr->pptable!", return -ENOMEM);
>
> -       memset(hwmgr->pptable, 0x00, sizeof(struct phm_ppt_v1_information));
> -
>         powerplay_table = get_powerplay_table(hwmgr);
>
>         PP_ASSERT_WITH_CODE((NULL != powerplay_table),
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> index 669bd0c2a16c..d55e264c5df5 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> @@ -2702,8 +2702,6 @@ static int ci_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>         cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
>         cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
>
> -       memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> -
>         result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
>
>         if (0 == result)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> index 375ccf6ff5f2..c123b4d9c621 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> @@ -2631,8 +2631,6 @@ static int iceland_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>         cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
>         cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
>
> -       memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> -
>         result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
>
>         if (0 == result)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> index 3ed6c5f1e5cf..60462c7211e3 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> @@ -3114,8 +3114,6 @@ static int tonga_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>         cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP,
>                         cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
>
> -       memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> -
>         result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
>
>         if (!result)
> --
> 2.11.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
