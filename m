From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Warnings on amd-staging-drm-next branch
Date: Wed, 4 Jan 2017 16:59:25 -0500
Message-ID: <ce7797b5-db3e-c517-2a0a-0393df760b86@amd.com>
References: <CAHbf0-GH6_+kZ0MQxpaonXsHVyo08=vb6=hCG6Svkro3vN5hQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1140889051=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-GH6_+kZ0MQxpaonXsHVyo08=vb6=hCG6Svkro3vN5hQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1140889051==
Content-Type: multipart/alternative;
	boundary="------------CB3AFCB9734F992C8C974C66"

--------------CB3AFCB9734F992C8C974C66
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, Mike.

Fixing these warnings is on my ToDo list. Expect a patch in the next 
couple of days to fix these.

Harry

On 2017-01-04 04:51 PM, Mike Lothian wrote:
> Hi
>
> I get the following warnings when using GCC 6.3 and the new 
> amd-staging-drm-next branch
>
> axionagd5f # make -j20
>  CHK     include/config/kernel.release
>  CHK     include/generated/uapi/linux/version.h
>  CHK     include/generated/utsrelease.h
>  CHK     include/generated/timeconst.h
>  CHK     include/generated/bounds.h
>  CHK     include/generated/asm-offsets.h
>  CALL    scripts/checksyscalls.sh
>  CHK     include/generated/compile.h
>  CHK     kernel/config_data.h
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.o
>  CC      drivers/gpu/drm/amd/amdgpu/atombios_crtc.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.o
>  CC      drivers/gpu/drm/amd/amdgpu/atom.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fence.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_object.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gart.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_display.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fb.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bios.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_test.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pm.o
>  CC      drivers/gpu/drm/amd/amdgpu/atombios_dp.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.o
>  CC      drivers/gpu/drm/amd/amdgpu/atombios_encoders.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sa.o
>  CC      drivers/gpu/drm/amd/amdgpu/atombios_i2c.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_prime.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ib.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pll.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sync.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/vi.o
>  CC      drivers/gpu/drm/amd/amdgpu/gmc_v7_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/gmc_v8_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_irq.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ih.o
>  CC      drivers/gpu/drm/amd/amdgpu/iceland_ih.o
>  CC      drivers/gpu/drm/amd/amdgpu/tonga_ih.o
>  CC      drivers/gpu/drm/amd/amdgpu/cz_ih.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.o
>  CC      drivers/gpu/drm/amd/amdgpu/dce_v10_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/dce_v11_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/dce_virtual.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.o
>  CC      drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/sdma_v2_4.o
>  CC      drivers/gpu/drm/amd/amdgpu/sdma_v3_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.o
>  CC      drivers/gpu/drm/amd/amdgpu/uvd_v5_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/uvd_v6_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vce.o
>  CC      drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_job.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.o
>  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_mn.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/cz_smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smc.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smc.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smc.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smc.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hwmgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/processpptables.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/functiontables.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/pp_acpi.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_hwmgr.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_clockpowergating.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/process_pptables_v1_0.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomctrl.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_powertune.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_thermal.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_clockpowergating.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventmgr.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventinit.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventmanagement.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventactionchains.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventsubchains.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventtasks.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/psm.o
>  CC      drivers/gpu/drm/amd/amdgpu/../powerplay/amd_powerplay.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt31_32.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt32_32.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/grph_object_id.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/log_helpers.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/signal_types.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/vector.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser_interface.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser_helper.o
> In file included from ./include/linux/agp_backend.h:33:0,
>                 from ./include/drm/drmP.h:35,
>                 from 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:29:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c: In 
> function ‘create_target_for_sink’:
> ./include/linux/list.h:385:29: warning: initialization discards 
> ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>  struct list_head *head__ = (ptr); \
> ^
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:972:20: 
> note: in expansion of macro ‘list_first_entry_or_null’
>   preferred_mode = list_first_entry_or_null(
> ^~~~~~~~~~~~~~~~~~~~~~~~
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_helper_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_helper_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce112/command_table_helper_dce112.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/bandwidth_calcs.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/bw_fixed.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/gamma_calcs.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_scl_filters.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clocks.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_base.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/gamma_calcs.c:201:13: 
> warning: ‘round_custom_float_6_12’ defined but not used 
> [-Wunused-function]
> static bool round_custom_float_6_12(
> ^~~~~~~~~~~~~~~~~~~~~~~
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_factory.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c: In 
> function ‘dce110_link_encoder_construct’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1066:2: 
> warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
> if (BP_RESULT_OK == bp_funcs->get_encoder_cap_info(
> ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1071:3: 
> note: ...this statement, but the latter is misleadingly indented as if 
> it is guarded by the ‘if’
> enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
> ^~~~~~
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_gpio.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_hpd.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_ddc.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function 
> ‘regamma_config_regions_and_segments’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:122:11: 
> warning: unused variable ‘value’ [-Wunused-variable]
>  uint32_t value = 0;
> ^~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function 
> ‘dce110_opp_set_clamping’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:568:11: 
> warning: unused variable ‘clamp_cntl_value’ [-Wunused-variable]
>  uint32_t clamp_cntl_value = 0;
> ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function 
> ‘program_formatter_reset_dig_resync_fifo’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:734:10: 
> warning: unused variable ‘counter’ [-Wunused-variable]
>  uint8_t counter = 10;
> ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function 
> ‘configure_graphics_mode’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:813:21: 
> warning: unused variable ‘ctx’ [-Wunused-variable]
>  struct dc_context *ctx = opp110->base.ctx;
> ^~~
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_translate.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce80/hw_translate_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce80/hw_factory_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce110/hw_translate_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce110/hw_factory_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_translate_diag.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/aux_engine.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/engine_base.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2caux.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_engine.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_generic_hw_engine.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_hw_engine.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_sw_engine.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2caux_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2c_hw_engine_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2c_sw_engine_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce100/i2caux_dce100.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2caux_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2c_sw_engine_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2c_hw_engine_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce112/i2caux_dce112.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/diagnostics/i2caux_diag.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/irq/irq_service.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce80/irq_service_dce80.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce110/irq_service_dce110.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/virtual/virtual_link_encoder.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/virtual/virtual_stream_encoder.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_compressor.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_hw_sequencer.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_mem_input.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_cursor.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_regamma_v.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_csc_v.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator_v.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_v.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_hw_sequencer.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_ipp.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_ipp_gamma.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.c: In 
> function ‘dce110_ipp_set_degamma’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.c:75:11: 
> warning: unused variable ‘value’ [-Wunused-variable]
>  uint32_t value = 0;
> ^~~~~
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_timing_generator.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_compressor.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_mem_input.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c: 
> In function ‘dce110_set_output_transfer_func’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:296:29: 
> warning: unused variable ‘prescale_params’ [-Wunused-variable]
>  struct ipp_prescale_params prescale_params = { 0 };
> ^~~~~~~~~~~~~~~
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_hw_sequencer.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_hw_sequencer.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_target.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_sink.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_hwss.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_ddc.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_debug.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.o
>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.o
>  CC 
>      drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In 
> function ‘set_hdr_static_info_packet’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1740:2: 
> warning: ISO C90 forbids mixed declarations and code 
> [-Wdeclaration-after-statement]
> struct dc_hdr_static_metadata hdr_metadata =
> ^~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1760:2: 
> warning: ISO C90 forbids mixed declarations and code 
> [-Wdeclaration-after-statement]
> uint32_t data;
> ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In 
> function ‘set_avi_info_frame’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1495:38: 
> warning: iteration 28 invokes undefined behavior 
> [-Waggressive-loop-optimizations]
>   info_packet->sb[byte_index] = info_frame.avi_info_packet.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> info_packet_hdmi.packet_raw_data.sb 
> <http://info_packet_hdmi.packet_raw_data.sb>[byte_index];
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1493:2: 
> note: within this loop
> for (byte_index = 0; byte_index < sizeof(info_packet->sb); byte_index++)
> ^~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In 
> function ‘set_hdr_static_info_packet.isra.8’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1734:11: 
> warning: ‘i’ may be used uninitialized in this function 
> [-Wmaybe-uninitialized]
>  uint16_t i;
> ^
>  LD      drivers/gpu/drm/amd/amdgpu/amdgpu.o
>  LD      drivers/gpu/drm/amd/amdgpu/built-in.o
>  LD      drivers/gpu/drm/built-in.o
>  LD      drivers/gpu/built-in.o
>  LD      drivers/built-in.o
>  LD      vmlinux.o
>
> Would you like me to raise bugs for any of these or are they already 
> known about?
>
> Regards
>
> Mike
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------CB3AFCB9734F992C8C974C66
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Thanks, Mike.<br>
    <br>
    Fixing these warnings is on my ToDo list. Expect a patch in the next
    couple of days to fix these.<br>
    <br>
    Harry<br>
    <br>
    <div class="moz-cite-prefix">On 2017-01-04 04:51 PM, Mike Lothian
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAHbf0-GH6_+kZ0MQxpaonXsHVyo08=vb6=hCG6Svkro3vN5hQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">Hi
        <div><br>
        </div>
        <div>I get the following warnings when using GCC 6.3 and the new
          amd-staging-drm-next branch</div>
        <div><br>
        </div>
        <div><span style="font-family:monospace"><span
              style="font-weight:bold;color:rgb(255,84,84)">axion</span><span
              style="font-weight:bold;color:rgb(84,84,255)"> agd5f #</span>
            make -j20
            <br>
             CHK     include/config/kernel.release
            <br>
             CHK     include/generated/uapi/linux/version.h
            <br>
             CHK     include/generated/utsrelease.h
            <br>
             CHK     include/generated/timeconst.h
            <br>
             CHK     include/generated/bounds.h
            <br>
             CHK     include/generated/asm-offsets.h
            <br>
             CALL    scripts/checksyscalls.sh
            <br>
             CHK     include/generated/compile.h
            <br>
             CHK     kernel/config_data.h
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/atombios_crtc.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/atom.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fence.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_object.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gart.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_display.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fb.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bios.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_test.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pm.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/atombios_dp.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/atombios_encoders.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sa.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/atombios_i2c.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_prime.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ib.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pll.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sync.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/vi.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/gmc_v7_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/gmc_v8_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_irq.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ih.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/iceland_ih.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/tonga_ih.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/cz_ih.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/dce_v10_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/dce_v11_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/dce_virtual.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/sdma_v2_4.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/sdma_v3_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/uvd_v5_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/uvd_v6_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vce.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_job.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/amdgpu_mn.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/cz_smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smc.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smc.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smc.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smc.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hwmgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/processpptables.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/functiontables.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/pp_acpi.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_hwmgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_clockpowergating.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/process_pptables_v1_0.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomctrl.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_powertune.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_thermal.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_clockpowergating.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventmgr.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventinit.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventmanagement.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventactionchains.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventsubchains.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventtasks.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/psm.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../powerplay/amd_powerplay.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt31_32.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt32_32.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/grph_object_id.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/log_helpers.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/signal_types.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/vector.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser_interface.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser_helper.o
            <br>
            In file included from <span style="font-weight:bold">./include/linux/agp_backend.h:33:0</span>,
            <br>
                            from <span style="font-weight:bold">./include/drm/drmP.h:35</span>,
            <br>
                            from <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:29</span>:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:</span>
            In function ‘<span style="font-weight:bold">create_target_for_sink</span>’:
            <br>
            <span style="font-weight:bold">./include/linux/list.h:385:29:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>initialization discards ‘<span
              style="font-weight:bold">const</span>’ qualifier from
            pointer target type [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Wdiscarded-qualifiers</span>]
            <br>
             struct list_head *head__ = <span
              style="font-weight:bold;color:rgb(255,84,255)">(</span>ptr);
            \
            <br>
                                        <span
              style="font-weight:bold;color:rgb(255,84,255)">^</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:972:20:</span>
            <span style="font-weight:bold;color:rgb(84,255,255)">note: </span>in
            expansion of macro ‘<span style="font-weight:bold">list_first_entry_or_null</span>’
            <br>
              preferred_mode = <span
              style="font-weight:bold;color:rgb(84,255,255)">list_first_entry_or_null</span>(
            <br>
                               <span
              style="font-weight:bold;color:rgb(84,255,255)">^~~~~~~~~~~~~~~~~~~~~~~~</span>
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_helper_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_helper_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce112/command_table_helper_dce112.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/bandwidth_calcs.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/bw_fixed.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/gamma_calcs.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_scl_filters.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clocks.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_base.o
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/gamma_calcs.c:201:13:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>‘<span style="font-weight:bold">round_custom_float_6_12</span>’
            defined but not used [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Wunused-function</span>]
            <br>
            static bool <span
              style="font-weight:bold;color:rgb(255,84,255)">round_custom_float_6_12</span>(
            <br>
                        <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~~~~~~~~~~~~~~~~~~~~~</span>
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_factory.o
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:</span>
            In function ‘<span style="font-weight:bold">dce110_link_encoder_construct</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1066:2:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>this ‘<span style="font-weight:bold">if</span>’
            clause does not guard... [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Wmisleading-indentation</span>]
            <br>
             <span style="font-weight:bold;color:rgb(255,84,255)">if</span>
            (BP_RESULT_OK == bp_funcs-&gt;get_encoder_cap_info(
            <br>
             <span style="font-weight:bold;color:rgb(255,84,255)">^~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1071:3:</span>
            <span style="font-weight:bold;color:rgb(84,255,255)">note: </span>...this
            statement, but the latter is misleadingly indented as if it
            is guarded by the ‘<span style="font-weight:bold">if</span>’
            <br>
              <span style="font-weight:bold;color:rgb(84,255,255)">enc110</span>-&gt;base.features.flags.bits.IS_HBR3_CAPABLE
            =
            <br>
              <span style="font-weight:bold;color:rgb(84,255,255)">^~~~~~</span>
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_gpio.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_hpd.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_ddc.o
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:</span>
            In function ‘<span style="font-weight:bold">regamma_config_regions_and_segments</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:122:11:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>unused variable ‘<span style="font-weight:bold">value</span>’
            [<span style="font-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
            <br>
             uint32_t <span
              style="font-weight:bold;color:rgb(255,84,255)">value</span>
            = 0;
            <br>
                      <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:</span>
            In function ‘<span style="font-weight:bold">dce110_opp_set_clamping</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:568:11:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>unused variable ‘<span style="font-weight:bold">clamp_cntl_value</span>’
            [<span style="font-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
            <br>
             uint32_t <span
              style="font-weight:bold;color:rgb(255,84,255)">clamp_cntl_value</span>
            = 0;
            <br>
                      <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~~~~~~~~~~~~~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:</span>
            In function ‘<span style="font-weight:bold">program_formatter_reset_dig_resync_fifo</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:734:10:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>unused variable ‘<span style="font-weight:bold">counter</span>’
            [<span style="font-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
            <br>
             uint8_t <span
              style="font-weight:bold;color:rgb(255,84,255)">counter</span>
            = 10;
            <br>
                     <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~~~~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:</span>
            In function ‘<span style="font-weight:bold">configure_graphics_mode</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:813:21:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>unused variable ‘<span style="font-weight:bold">ctx</span>’
            [<span style="font-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
            <br>
             struct dc_context *<span
              style="font-weight:bold;color:rgb(255,84,255)">ctx</span>
            = opp110-&gt;base.ctx;
            <br>
                                <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~</span>
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_translate.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce80/hw_translate_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce80/hw_factory_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce110/hw_translate_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce110/hw_factory_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_translate_diag.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/aux_engine.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/engine_base.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2caux.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_engine.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_generic_hw_engine.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_hw_engine.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_sw_engine.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2caux_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2c_hw_engine_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2c_sw_engine_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce100/i2caux_dce100.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2caux_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2c_sw_engine_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2c_hw_engine_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce112/i2caux_dce112.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/diagnostics/i2caux_diag.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/irq/irq_service.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce80/irq_service_dce80.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce110/irq_service_dce110.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/virtual/virtual_link_encoder.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/virtual/virtual_stream_encoder.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_compressor.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_hw_sequencer.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_mem_input.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_cursor.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_regamma_v.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_csc_v.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator_v.o<br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_v.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.o
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_hw_sequencer.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_ipp.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_ipp_gamma.o
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.c:</span>
            In function ‘<span style="font-weight:bold">dce110_ipp_set_degamma</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.c:75:11:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>unused variable ‘<span style="font-weight:bold">value</span>’
            [<span style="font-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
            <br>
             uint32_t <span
              style="font-weight:bold;color:rgb(255,84,255)">value</span>
            = 0;
            <br>
                      <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~~~</span>
            <br>
             CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_timing_generator.o<br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_compressor.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_mem_input.o
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:</span>
            In function ‘<span style="font-weight:bold">dce110_set_output_transfer_func</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:296:29:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>unused variable ‘<span style="font-weight:bold">prescale_params</span>’
            [<span style="font-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
            <br>
             struct ipp_prescale_params <span
              style="font-weight:bold;color:rgb(255,84,255)">prescale_params</span>
            = { 0 };
            <br>
                                        <span
              style="font-weight:bold;color:rgb(255,84,255)">^~~~~~~~~~~~~~~</span>
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_hw_sequencer.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.o
            <br>
             CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_hw_sequencer.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_target.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_sink.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_hwss.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_ddc.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_debug.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.o
            <br>
             CC
                 drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.o
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:</span>
            In function ‘<span style="font-weight:bold">set_hdr_static_info_packet</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1740:2:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>ISO C90 forbids mixed declarations and code [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Wdeclaration-after-statement</span>]
            <br>
             <span style="font-weight:bold;color:rgb(255,84,255)">struct</span>
            dc_hdr_static_metadata hdr_metadata =
            <br>
             <span style="font-weight:bold;color:rgb(255,84,255)">^~~~~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1760:2:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>ISO C90 forbids mixed declarations and code [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Wdeclaration-after-statement</span>]
            <br>
             <span style="font-weight:bold;color:rgb(255,84,255)">uint32_t</span>
            data;
            <br>
             <span style="font-weight:bold;color:rgb(255,84,255)">^~~~~~~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:</span>
            In function ‘<span style="font-weight:bold">set_avi_info_frame</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1495:38:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>iteration 28 invokes undefined behavior [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Waggressive-loop-optimizations</span>]
            <br>
              info_packet-&gt;sb[byte_index] = <span
              style="font-weight:bold;color:rgb(255,84,255)">info_frame.avi_info_packet.</span>
            <br>
                                            <span
              style="font-weight:bold;color:rgb(255,84,255)">~~~~~~~~~~~~~~~~~~~~~~~~~~~</span>
            <br>
            <span style="font-weight:bold;color:rgb(255,84,255)">  <a
                moz-do-not-send="true"
                href="http://info_packet_hdmi.packet_raw_data.sb">info_packet_hdmi.packet_raw_data.sb</a>[byte_index]</span>;
            <br>
              <span style="font-weight:bold;color:rgb(255,84,255)">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1493:2:</span>
            <span style="font-weight:bold;color:rgb(84,255,255)">note: </span>within
            this loop
            <br>
             <span style="font-weight:bold;color:rgb(84,255,255)">for</span>
            (byte_index = 0; byte_index &lt; sizeof(info_packet-&gt;sb);
            byte_index++)
            <br>
             <span style="font-weight:bold;color:rgb(84,255,255)">^~~</span>
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:</span>
            In function ‘<span style="font-weight:bold">set_hdr_static_info_packet.isra.8</span>’:
            <br>
            <span style="font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1734:11:</span>
            <span style="font-weight:bold;color:rgb(255,84,255)">warning:
            </span>‘<span style="font-weight:bold">i</span>’ may be used
            uninitialized in this function [<span
              style="font-weight:bold;color:rgb(255,84,255)">-Wmaybe-uninitialized</span>]
            <br>
             uint16_t <span
              style="font-weight:bold;color:rgb(255,84,255)">i</span>;
            <br>
                      <span
              style="font-weight:bold;color:rgb(255,84,255)">^</span>
            <br>
             LD      drivers/gpu/drm/amd/amdgpu/amdgpu.o
            <br>
             LD      drivers/gpu/drm/amd/amdgpu/built-in.o
            <br>
             LD      drivers/gpu/drm/built-in.o
            <br>
             LD      drivers/gpu/built-in.o
            <br>
             LD      drivers/built-in.o
            <br>
             LD      vmlinux.o<br>
          </span></div>
        <div><span style="font-family:monospace"><br>
          </span></div>
        <div><font face="monospace">Would you like me to raise bugs for
            any of these or are they already known about?</font></div>
        <div><font face="monospace"><br>
          </font></div>
        <div><font face="monospace">Regards</font></div>
        <div><font face="monospace"><br>
          </font></div>
        <div><font face="monospace">Mike</font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CB3AFCB9734F992C8C974C66--

--===============1140889051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1140889051==--
