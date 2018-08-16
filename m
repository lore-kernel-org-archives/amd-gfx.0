From: Leo Li <sunpeng.li@amd.com>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Thu, 16 Aug 2018 15:55:49 -0400
Message-ID: <0e2639d6-7816-4e85-3212-74fcd118e396@amd.com>
References: <20180811155554.3382650-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180811155554.3382650-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, dri-devel@lists.freedesktop.org, "Lazare, Jordan" <Jordan.Lazare@amd.com>, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org



On 2018-08-11 11:54 AM, Arnd Bergmann wrote:
> Building the DCN 1.0 Raven display driver with CONFIG_KCOV_INSTRUMENT_ALL=y
> and CONFIG_KCOV_ENABLE_COMPARISONS=y results in warnings about many functions
> that do a comparison of floating-point variables:
> 
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_bw_calc_rq_dlg_ttu':
> dcn_calcs.c:(.text+0x263): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `hack_force_pipe_split':
> dcn_calcs.c:(.text+0x155b): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_find_dcfclk_suits_all':
> dcn_calcs.c:(.text+0x190e): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_validate_bandwidth':
> dcn_calcs.c:(.text+0xe121): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_mod':
> dcn_calc_math.c:(.text+0x22): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_min2':
> dcn_calc_math.c:(.text+0xb2): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_ceil2':
> dcn_calc_math.c:(.text+0x2a0): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max3':
> dcn_calc_math.c:(.text+0x325): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max5':
> dcn_calc_math.c:(.text+0x3c3): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_log':
> dcn_calc_math.c:(.text+0x54e): undefined reference to `__sanitizer_cov_trace_cmpd'
> dcn_calc_math.c:(.text+0x57c): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `scaler_settings_calculation':
> dcn_calc_auto.c:(.text+0x5c5): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x137c): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x9233): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0xb70f): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x121fd): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `display_pipe_configuration':
> dcn_calc_auto.c:(.text+0x15a2f): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x17c2d): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x19362): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x25575): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x27f33): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `get_refcyc_per_delivery':
> display_rq_dlg_calc.c:(.text+0xb5): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `calculate_ttu_cursor.isra.1':
> display_rq_dlg_calc.c:(.text+0x9f6): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `dml_rq_dlg_get_dlg_params':
> display_rq_dlg_calc.c:(.text+0x82cc): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_refcyc_per_delivery.isra.0':
> dml1_display_rq_dlg_calc.c:(.text+0x6c4): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_vratio_pre.isra.2':
> dml1_display_rq_dlg_calc.c:(.text+0x957): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_swath_need.isra.3':
> dml1_display_rq_dlg_calc.c:(.text+0xc8e): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_extract_rq_regs':
> dml1_display_rq_dlg_calc.c:(.text+0x30a8): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
> dml1_display_rq_dlg_calc.c:(.text+0x41ee): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
> dml1_display_rq_dlg_calc.c:(.text+0x8f95): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.o: In function `dml_round':
> dml_common_defs.c:(.text+0x77): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o: In function `adjust_ReturnBW':
> display_mode_vba.c:(.text+0x4490): undefined reference to `__sanitizer_cov_trace_cmpd'
> 
> We already prevent the driver from being built on non-x86 architectures
> because of its use of floating-point arithmetic, this extends the
> dependency to also cover Kcov-enabled builds, which arguably is a much
> more severe limitation.
> 
> I tried implementing the two functions in KCOV: __sanitizer_cov_trace_cmpd
> and __sanitizer_cov_trace_cmpf, but that fails to build on architectures
> that do not support any floating-point functions, or would require making
> that code x86 specific as well.  I also looked at what it would take to

Hi Arnd,

Is there a reason why we can't make __sanitizer_cov_trace_cmpd and
__sanitizer_cov_trace_cmpf X86 dependent?

I sent out two patches to disable DCN1, but would prefer implementing
these two functions as opposed to disabling a component.

Thanks,
Leo

> convert the code to fixed-point arithmetic, but quickly gave up. This
> is probably the right approach, but it requires a non-trivial amount of
> work and certainly won't be appropriate as a bugfix.
> 
> Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
> Link: drm: amd: dc: don't use FP math when Kcov is enabled
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: rebase on top of 4841203102a3, which removed the option for
> CONFIG_DRM_AMD_DC_DCN1_0. The problem still gets hit occasionally
> in randconfig testing.
> ---
>   drivers/gpu/drm/amd/display/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 325083b0297e..b132d434e572 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -3,6 +3,7 @@ menu "Display Engine Configuration"
>   
>   config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
> +	depends on !X86 || !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN
>   	default y
>   	help
>   	  Choose this option if you want to use the new display engine
> 
