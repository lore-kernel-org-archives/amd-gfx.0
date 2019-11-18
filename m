From: Chen Wandun <chenwandun@huawei.com>
Subject: Re: [PATCH] drm/amd/powerplay: remove variable 'result' set but not
 used
Date: Mon, 18 Nov 2019 15:16:32 +0800
Message-ID: <71d72dc4-5dae-2ae4-9f10-89cca72458da@huawei.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
 <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

OK, it indeed should return the 'result' to caller,
I will make a modification and repost the patch.

Thanks
Chen Wandun

On 2019/11/18 14:50, Quan, Evan wrote:
> Thanks. But it's better to return the 'result' out on 'result != 0'.
> 
> Regards,
> Evan
> -----Original Message-----
> From: Chen Wandun <chenwandun@huawei.com>
> Sent: Saturday, November 16, 2019 11:43 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Cc: chenwandun@huawei.com
> Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not used
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function vegam_populate_smc_boot_level:
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warning: variable result set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>   drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 2068eb0..fad78bf 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -1361,20 +1361,19 @@ static int vegam_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
>   static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
>   		struct SMU75_Discrete_DpmTable *table)
>   {
> -	int result = 0;
>   	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
>   
>   	table->GraphicsBootLevel = 0;
>   	table->MemoryBootLevel = 0;
>   
>   	/* find boot level from dpm table */
> -	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
> -			data->vbios_boot_state.sclk_bootup_value,
> -			(uint32_t *)&(table->GraphicsBootLevel));
> +	phm_find_boot_level(&(data->dpm_table.sclk_table),
> +			    data->vbios_boot_state.sclk_bootup_value,
> +			    (uint32_t *)&(table->GraphicsBootLevel));
>   
> -	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
> -			data->vbios_boot_state.mclk_bootup_value,
> -			(uint32_t *)&(table->MemoryBootLevel));
> +	phm_find_boot_level(&(data->dpm_table.mclk_table),
> +			    data->vbios_boot_state.mclk_bootup_value,
> +			    (uint32_t *)&(table->MemoryBootLevel));
>   
>   	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
>   			VOLTAGE_SCALE;
> 
