From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] drm/amd/pp: initialized result to zero before
 or'ing in data
Date: Wed, 6 Jun 2018 13:19:25 +0100
Message-ID: <530e612b-0b1f-bed6-035e-707bbf745216@canonical.com>
References: <20180606121831.3347-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606121831.3347-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 06/06/18 13:18, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current use of result is or'ing in values and checking for
> a non-zero result, however, result is not initialized to zero
> so it potentially contains garbage to start with. Fix this by
> initializing it to the first return from the call to
> vega10_program_didt_config_registers.
> 
> Detected by cppcheck:
> "(error) Uninitialized variable: result"
> 
> Fixes: 9b7b8154cdb8 ("drm/amd/powerplay: added didt support for vega10")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> index a9efd8554fbc..dbe4b1f66784 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> @@ -1104,7 +1104,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
>  	for (count = 0; count < num_se; count++) {
>  		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
>  		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
> -		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
> +		result = vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>  		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>  		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCCtrlResetConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>  		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCCtrlConfig_Vega10, VEGA10_CONFIGREG_DIDT);
> 

Oops, subject should be "initialize result to before or'ing in data"
