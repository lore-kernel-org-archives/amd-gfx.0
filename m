From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Warnings on amd-staging-drm-next branch
Date: Wed, 04 Jan 2017 21:51:39 +0000
Message-ID: <CAHbf0-GH6_+kZ0MQxpaonXsHVyo08=vb6=hCG6Svkro3vN5hQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0963938950=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0963938950==
Content-Type: multipart/alternative; boundary=001a11463018c1571405454bca94

--001a11463018c1571405454bca94
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

I get the following warnings when using GCC 6.3 and the new
amd-staging-drm-next branch

axion agd5f # make -j20
 CHK     include/config/kernel.release
 CHK     include/generated/uapi/linux/version.h
 CHK     include/generated/utsrelease.h
 CHK     include/generated/timeconst.h
 CHK     include/generated/bounds.h
 CHK     include/generated/asm-offsets.h
 CALL    scripts/checksyscalls.sh
 CHK     include/generated/compile.h
 CHK     kernel/config_data.h
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.o
 CC      drivers/gpu/drm/amd/amdgpu/atombios_crtc.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.o
 CC      drivers/gpu/drm/amd/amdgpu/atom.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fence.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_object.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gart.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_display.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fb.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bios.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_test.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pm.o
 CC      drivers/gpu/drm/amd/amdgpu/atombios_dp.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.o
 CC      drivers/gpu/drm/amd/amdgpu/atombios_encoders.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sa.o
 CC      drivers/gpu/drm/amd/amdgpu/atombios_i2c.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_prime.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ib.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pll.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sync.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.o
 CC      drivers/gpu/drm/amd/amdgpu/vi.o
 CC      drivers/gpu/drm/amd/amdgpu/gmc_v7_0.o
 CC      drivers/gpu/drm/amd/amdgpu/gmc_v8_0.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_irq.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ih.o
 CC      drivers/gpu/drm/amd/amdgpu/iceland_ih.o
 CC      drivers/gpu/drm/amd/amdgpu/tonga_ih.o
 CC      drivers/gpu/drm/amd/amdgpu/cz_ih.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.o
 CC      drivers/gpu/drm/amd/amdgpu/dce_v10_0.o
 CC      drivers/gpu/drm/amd/amdgpu/dce_v11_0.o
 CC      drivers/gpu/drm/amd/amdgpu/dce_virtual.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.o
 CC      drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o
 CC      drivers/gpu/drm/amd/amdgpu/sdma_v2_4.o
 CC      drivers/gpu/drm/amd/amdgpu/sdma_v3_0.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.o
 CC      drivers/gpu/drm/amd/amdgpu/uvd_v5_0.o
 CC      drivers/gpu/drm/amd/amdgpu/uvd_v6_0.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vce.o
 CC      drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_job.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.o
 CC      drivers/gpu/drm/amd/amdgpu/amdgpu_mn.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/cz_smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smc.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smc.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/tonga_smc.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/iceland_smc.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hwmgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/processpptables.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/functiontables.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/pp_acpi.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_hwmgr.o
 CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_clockpowergating.o
 CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/process_pptables_v1_0.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomctrl.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_powertune.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_thermal.o
 CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_clockpowergating.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventmgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventinit.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventmanagement.o
 CC
     drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventactionchains.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventsubchains.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/eventtasks.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/eventmgr/psm.o
 CC      drivers/gpu/drm/amd/amdgpu/../powerplay/amd_powerplay.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt31_32.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt32_32.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/grph_object_id.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/log_helpers.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/signal_types.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/basics/vector.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser_interface.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser_helper.o
In file included from ./include/linux/agp_backend.h:33:0,
                from ./include/drm/drmP.h:35,
                from
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:29:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c: In
function =E2=80=98create_target_for_sink=E2=80=99:
./include/linux/list.h:385:29: warning: initialization discards =E2=80=98co=
nst=E2=80=99
qualifier from pointer target type [-Wdiscarded-qualifiers]
 struct list_head *head__ =3D (ptr); \
                            ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:972:20: n=
ote:
in expansion of macro =E2=80=98list_first_entry_or_null=E2=80=99
  preferred_mode =3D list_first_entry_or_null(
                   ^~~~~~~~~~~~~~~~~~~~~~~~
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_help=
er_dce80.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_hel=
per_dce110.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce112/command_table_hel=
per_dce112.o

 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/bandwidth_calcs.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/bw_fixed.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/gamma_calcs.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_scl_filters.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clocks.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_base.o
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/gamma_calcs.c:201:13: warnin=
g:
=E2=80=98round_custom_float_6_12=E2=80=99 defined but not used [-Wunused-fu=
nction]
static bool round_custom_float_6_12(
            ^~~~~~~~~~~~~~~~~~~~~~~
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_factory.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c: In
function =E2=80=98dce110_link_encoder_construct=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1066:2:
warning:
this =E2=80=98if=E2=80=99 clause does not guard... [-Wmisleading-indentatio=
n]
 if (BP_RESULT_OK =3D=3D bp_funcs->get_encoder_cap_info(
 ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1071:3: not=
e:
...this statement, but the latter is misleadingly indented as if it is
guarded by the =E2=80=98if=E2=80=99
  enc110->base.features.flags.bits.IS_HBR3_CAPABLE =3D
  ^~~~~~
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_gpio.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_hpd.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_ddc.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function =E2=80=
=98
regamma_config_regions_and_segments=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:122:11: warning: unu=
sed
variable =E2=80=98value=E2=80=99 [-Wunused-variable]
 uint32_t value =3D 0;
          ^~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function =E2=80=
=98
dce110_opp_set_clamping=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:568:11: warning: unu=
sed
variable =E2=80=98clamp_cntl_value=E2=80=99 [-Wunused-variable]
 uint32_t clamp_cntl_value =3D 0;
          ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function =E2=80=
=98
program_formatter_reset_dig_resync_fifo=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:734:10: warning: unu=
sed
variable =E2=80=98counter=E2=80=99 [-Wunused-variable]
 uint8_t counter =3D 10;
         ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c: In function =E2=80=
=98
configure_graphics_mode=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:813:21: warning: unu=
sed
variable =E2=80=98ctx=E2=80=99 [-Wunused-variable]
 struct dc_context *ctx =3D opp110->base.ctx;
                    ^~~
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_translate.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce80/hw_translate_dce80=
.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce80/hw_factory_dce80.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce110/hw_translate_dce1=
10.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dce110/hw_factory_dce110=
.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_translate=
_diag.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_d=
iag.o

 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/aux_engine.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/engine_base.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2caux.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_engine.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_generic_hw_engine.=
o

 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_hw_engine.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/i2c_sw_engine.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2caux_dce80.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2c_hw_engine_dc=
e80.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce80/i2c_sw_engine_dc=
e80.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce100/i2caux_dce100.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2caux_dce110.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2c_sw_engine_d=
ce110.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/i2c_hw_engine_d=
ce110.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce1=
10.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce112/i2caux_dce112.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/diagnostics/i2caux_dia=
g.o

 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/irq/irq_service.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce80/irq_service_dce80.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce110/irq_service_dce110=
.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/virtual/virtual_link_encoder.=
o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/virtual/virtual_stream_encode=
r.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_compressor.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_hw_sequencer.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_mem_input.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_cursor.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generato=
r.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_regamma_v.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_csc_v.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generato=
r_v.o

 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_v.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.o
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_hw_sequencer.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_ipp.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_ipp_gamma.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.c: In
function =E2=80=98dce110_ipp_set_degamma=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_ipp_gamma.c:75:11:
warning:
unused variable =E2=80=98value=E2=80=99 [-Wunused-variable]
 uint32_t value =3D 0;
          ^~~~~
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_timing_generator.=
o

 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_compressor.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_mem_input.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c: In
function =E2=80=98dce110_set_output_transfer_func=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:296:2=
9:
warning:
unused variable =E2=80=98prescale_params=E2=80=99 [-Wunused-variable]
 struct ipp_prescale_params prescale_params =3D { 0 };
                            ^~~~~~~~~~~~~~~
 CC
     drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_hw_sequencer.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_hw_sequencer.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_target.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_sink.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_hwss.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_ddc.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_debug.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.o
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In function =
=E2=80=98
set_hdr_static_info_packet=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1740:2: warning=
:
ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
 struct dc_hdr_static_metadata hdr_metadata =3D
 ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1760:2: warning=
:
ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
 uint32_t data;
 ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In function =
=E2=80=98
set_avi_info_frame=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1495:38: warnin=
g:
iteration 28 invokes undefined behavior [-Waggressive-loop-optimizations]
  info_packet->sb[byte_index] =3D info_frame.avi_info_packet.
                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  info_packet_hdmi.packet_raw_data.sb[byte_index];
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1493:2:
note: within
this loop
 for (byte_index =3D 0; byte_index < sizeof(info_packet->sb); byte_index++)
 ^~~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In function =
=E2=80=98
set_hdr_static_info_packet.isra.8=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1734:11: warnin=
g:
=E2=80=98i=E2=80=99 may be used uninitialized in this function [-Wmaybe-uni=
nitialized]
 uint16_t i;
          ^
 LD      drivers/gpu/drm/amd/amdgpu/amdgpu.o
 LD      drivers/gpu/drm/amd/amdgpu/built-in.o
 LD      drivers/gpu/drm/built-in.o
 LD      drivers/gpu/built-in.o
 LD      drivers/built-in.o
 LD      vmlinux.o

Would you like me to raise bugs for any of these or are they already known
about?

Regards

Mike

--001a11463018c1571405454bca94
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I get the following warnings when us=
ing GCC 6.3 and the new amd-staging-drm-next branch</div><div><br></div><di=
v><span style=3D"font-family:monospace"><span style=3D"font-weight:bold;col=
or:rgb(255,84,84)">axion</span><span style=3D"font-weight:bold;color:rgb(84=
,84,255)"> agd5f #</span> make -j20
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/config/kernel.release
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/generated/uapi/linux/version=
.h
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/generated/utsrelease.h
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/generated/timeconst.h
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/generated/bounds.h
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/generated/asm-offsets.h
<br> =C2=A0CALL =C2=A0=C2=A0=C2=A0scripts/checksyscalls.sh
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0include/generated/compile.h
<br> =C2=A0CHK =C2=A0=C2=A0=C2=A0=C2=A0kernel/config_data.h
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_drv.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_device.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_kms.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_atombios.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/atom=
bios_crtc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_connectors.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/atom=
.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_fence.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ttm.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_object.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_gart.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_encoders.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_display.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_i2c.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_fb.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_gem.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ring.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_cs.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_bios.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_benchmark.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_test.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_pm.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/atom=
bios_dp.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_afmt.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_trace_points.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/atom=
bios_encoders.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_sa.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/atom=
bios_i2c.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_prime.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_vm.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ib.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_pll.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ucode.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_bo_list.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ctx.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_sync.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_gtt_mgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_vram_mgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/vi.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_=
v7_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_=
v8_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_irq.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ih.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/icel=
and_ih.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/tong=
a_ih.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/cz_i=
h.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_dpm.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_powerplay.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/dce_=
v10_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/dce_=
v11_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/dce_=
virtual.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_gfx.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_=
v8_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/sdma=
_v2_4.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/sdma=
_v3_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_uvd.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/uvd_=
v5_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/uvd_=
v6_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_vce.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/vce_=
v3_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_amdkfd.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_amdkfd_gfx_v8.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_cgs.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_job.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_ioc32.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_acpi.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu_mn.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/cz_smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/tonga_smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/fiji_smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/fiji_smc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/polaris10_smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/iceland_smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/polaris10_smc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/tonga_smc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/smu7_smumgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/smumgr/iceland_smc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/hwmgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/processpptables.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/functiontables.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/hardwaremanager.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/pp_acpi.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/cz_hwmgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/cz_clockpowergating.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/process_pptables_v1_0.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/ppatomctrl.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/smu7_hwmgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/smu7_powertune.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/smu7_thermal.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/hwmgr/smu7_clockpowergating.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/eventmgr.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/eventinit.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/eventmanagement.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/eventactionchains.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/eventsubchains.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/eventtasks.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/eventmgr/psm.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../p=
owerplay/amd_powerplay.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/amdgpu_dm/amdgpu_dm_types.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/amdgpu_dm/amdgpu_dm.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/amdgpu_dm/amdgpu_dm_irq.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/amdgpu_dm/amdgpu_dm_mst_types.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/amdgpu_dm/amdgpu_dm_services.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/amdgpu_dm/amdgpu_dm_helpers.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/conversion.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/fixpt31_32.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/fixpt32_32.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/grph_object_id.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/logger.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/log_helpers.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/signal_types.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/basics/vector.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/bios_parser.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/bios_parser_interface.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/bios_parser_helper.o
<br>In file included from <span style=3D"font-weight:bold">./include/linux/=
agp_backend.h:33:0</span>,
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from <span style=3D"font-weight:bold">./include/=
drm/drmP.h:35</span>,
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from <span style=3D"font-weight:bold">drivers/gp=
u/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_types.c:29</span>:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
amdgpu_dm/amdgpu_dm_types.c:</span> In function =E2=80=98<span style=3D"fon=
t-weight:bold">create_target_for_sink</span>=E2=80=99:
<br><span style=3D"font-weight:bold">./include/linux/list.h:385:29:</span> =
<span style=3D"font-weight:bold;color:rgb(255,84,255)">warning: </span>init=
ialization discards =E2=80=98<span style=3D"font-weight:bold">const</span>=
=E2=80=99 qualifier from pointer target type [<span style=3D"font-weight:bo=
ld;color:rgb(255,84,255)">-Wdiscarded-qualifiers</span>]
<br> =C2=A0struct list_head *head__ =3D <span style=3D"font-weight:bold;col=
or:rgb(255,84,255)">(</span>ptr); \
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,25=
5)">^</span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
amdgpu_dm/amdgpu_dm_types.c:972:20:</span> <span style=3D"font-weight:bold;=
color:rgb(84,255,255)">note: </span>in expansion of macro =E2=80=98<span st=
yle=3D"font-weight:bold">list_first_entry_or_null</span>=E2=80=99
<br> =C2=A0=C2=A0preferred_mode =3D <span style=3D"font-weight:bold;color:r=
gb(84,255,255)">list_first_entry_or_null</span>(
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"font-weight:bol=
d;color:rgb(84,255,255)">^~~~~~~~~~~~~~~~~~~~~~~~</span>
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/command_table.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/command_table_helper.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/dce80/command_table_helper_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/dce110/command_table_helper_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/bios/dce112/command_table_helper_dce112.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/calcs/bandwidth_calcs.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/calcs/bw_fixed.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/calcs/gamma_calcs.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_audio.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_stream_encoder.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_link_encoder.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_hwseq.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_mem_input.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_clock_source.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_scl_filters.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_transform.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_clocks.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce/dce_opp.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/gpio_base.o
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/calcs/gamma_calcs.c:201:13:</span> <span style=3D"font-weight:bold;color=
:rgb(255,84,255)">warning: </span>=E2=80=98<span style=3D"font-weight:bold"=
>round_custom_float_6_12</span>=E2=80=99 defined but not used [<span style=
=3D"font-weight:bold;color:rgb(255,84,255)">-Wunused-function</span>]
<br> static bool <span style=3D"font-weight:bold;color:rgb(255,84,255)">rou=
nd_custom_float_6_12</span>(
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">^~~~~~~~~~~~~~~~~=
~~~~~~</span>
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/gpio_service.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/hw_factory.o
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_link_encoder.c:</span> In function =E2=80=98<span style=3D"font-=
weight:bold">dce110_link_encoder_construct</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_link_encoder.c:1066:2:</span> <span style=3D"font-weight:bold;co=
lor:rgb(255,84,255)">warning: </span>this =E2=80=98<span style=3D"font-weig=
ht:bold">if</span>=E2=80=99 clause does not guard... [<span style=3D"font-w=
eight:bold;color:rgb(255,84,255)">-Wmisleading-indentation</span>]
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">if</span>=
 (BP_RESULT_OK =3D=3D bp_funcs-&gt;get_encoder_cap_info(
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">^~</span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_link_encoder.c:1071:3:</span> <span style=3D"font-weight:bold;co=
lor:rgb(84,255,255)">note: </span>...this statement, but the latter is misl=
eadingly indented as if it is guarded by the =E2=80=98<span style=3D"font-w=
eight:bold">if</span>=E2=80=99
<br> =C2=A0=C2=A0<span style=3D"font-weight:bold;color:rgb(84,255,255)">enc=
110</span>-&gt;base.features.flags.bits.IS_HBR3_CAPABLE =3D
<br> =C2=A0=C2=A0<span style=3D"font-weight:bold;color:rgb(84,255,255)">^~~=
~~~</span>
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/hw_gpio.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/hw_hpd.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/hw_ddc.o
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:</span> In function =E2=80=98<span style=3D"font-weight:bo=
ld">regamma_config_regions_and_segments</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:122:11:</span> <span style=3D"font-weight:bold;color:rgb(2=
55,84,255)">warning: </span>unused variable =E2=80=98<span style=3D"font-we=
ight:bold">value</span>=E2=80=99 [<span style=3D"font-weight:bold;color:rgb=
(255,84,255)">-Wunused-variable</span>]
<br> =C2=A0uint32_t <span style=3D"font-weight:bold;color:rgb(255,84,255)">=
value</span> =3D 0;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span styl=
e=3D"font-weight:bold;color:rgb(255,84,255)">^~~~~</span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:</span> In function =E2=80=98<span style=3D"font-weight:bo=
ld">dce110_opp_set_clamping</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:568:11:</span> <span style=3D"font-weight:bold;color:rgb(2=
55,84,255)">warning: </span>unused variable =E2=80=98<span style=3D"font-we=
ight:bold">clamp_cntl_value</span>=E2=80=99 [<span style=3D"font-weight:bol=
d;color:rgb(255,84,255)">-Wunused-variable</span>]
<br> =C2=A0uint32_t <span style=3D"font-weight:bold;color:rgb(255,84,255)">=
clamp_cntl_value</span> =3D 0;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span styl=
e=3D"font-weight:bold;color:rgb(255,84,255)">^~~~~~~~~~~~~~~~</span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:</span> In function =E2=80=98<span style=3D"font-weight:bo=
ld">program_formatter_reset_dig_resync_fifo</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:734:10:</span> <span style=3D"font-weight:bold;color:rgb(2=
55,84,255)">warning: </span>unused variable =E2=80=98<span style=3D"font-we=
ight:bold">counter</span>=E2=80=99 [<span style=3D"font-weight:bold;color:r=
gb(255,84,255)">-Wunused-variable</span>]
<br> =C2=A0uint8_t <span style=3D"font-weight:bold;color:rgb(255,84,255)">c=
ounter</span> =3D 10;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"f=
ont-weight:bold;color:rgb(255,84,255)">^~~~~~~</span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:</span> In function =E2=80=98<span style=3D"font-weight:bo=
ld">configure_graphics_mode</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce/dce_opp.c:813:21:</span> <span style=3D"font-weight:bold;color:rgb(2=
55,84,255)">warning: </span>unused variable =E2=80=98<span style=3D"font-we=
ight:bold">ctx</span>=E2=80=99 [<span style=3D"font-weight:bold;color:rgb(2=
55,84,255)">-Wunused-variable</span>]
<br> =C2=A0struct dc_context *<span style=3D"font-weight:bold;color:rgb(255=
,84,255)">ctx</span> =3D opp110-&gt;base.ctx;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"font-weig=
ht:bold;color:rgb(255,84,255)">^~~</span>
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/hw_translate.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/dce80/hw_translate_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/dce80/hw_factory_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/dce110/hw_translate_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/dce110/hw_factory_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/diagnostics/hw_translate_diag.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/gpio/diagnostics/hw_factory_diag.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/aux_engine.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/engine_base.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/i2caux.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/i2c_engine.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/i2c_generic_hw_engine.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/i2c_hw_engine.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/i2c_sw_engine.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce80/i2caux_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce80/i2c_hw_engine_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce80/i2c_sw_engine_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce100/i2caux_dce100.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce110/i2caux_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce110/i2c_sw_engine_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce110/i2c_hw_engine_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce110/aux_engine_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/dce112/i2caux_dce112.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/i2caux/diagnostics/i2caux_diag.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/irq/irq_service.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/irq/dce80/irq_service_dce80.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/irq/dce110/irq_service_dce110.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/virtual/virtual_link_encoder.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/virtual/virtual_stream_encoder.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce112/dce112_compressor.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce112/dce112_hw_sequencer.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce112/dce112_resource.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce112/dce112_mem_input.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_ipp.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_ipp_cursor.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_ipp_gamma.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_timing_generator.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_compressor.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_mem_input.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_hw_sequencer.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_resource.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_opp_regamma_v.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_opp_csc_v.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_timing_generator_v.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_mem_input_v.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_opp_v.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce110/dce110_transform_v.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce100/dce100_resource.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce100/dce100_hw_sequencer.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_ipp.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_ipp_gamma.o
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce110/dce110_ipp_gamma.c:</span> In function =E2=80=98<span style=3D"fo=
nt-weight:bold">dce110_ipp_set_degamma</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce110/dce110_ipp_gamma.c:75:11:</span> <span style=3D"font-weight:bold;=
color:rgb(255,84,255)">warning: </span>unused variable =E2=80=98<span style=
=3D"font-weight:bold">value</span>=E2=80=99 [<span style=3D"font-weight:bol=
d;color:rgb(255,84,255)">-Wunused-variable</span>]
<br> =C2=A0uint32_t <span style=3D"font-weight:bold;color:rgb(255,84,255)">=
value</span> =3D 0;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span styl=
e=3D"font-weight:bold;color:rgb(255,84,255)">^~~~~</span>
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_timing_generator.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_compressor.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_mem_input.o
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce110/dce110_hw_sequencer.c:</span> In function =E2=80=98<span style=3D=
"font-weight:bold">dce110_set_output_transfer_func</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/dce110/dce110_hw_sequencer.c:296:29:</span> <span style=3D"font-weight:b=
old;color:rgb(255,84,255)">warning: </span>unused variable =E2=80=98<span s=
tyle=3D"font-weight:bold">prescale_params</span>=E2=80=99 [<span style=3D"f=
ont-weight:bold;color:rgb(255,84,255)">-Wunused-variable</span>]
<br> =C2=A0struct ipp_prescale_params <span style=3D"font-weight:bold;color=
:rgb(255,84,255)">prescale_params</span> =3D { 0 };
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,25=
5)">^~~~~~~~~~~~~~~</span>
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_hw_sequencer.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dce80/dce80_resource.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_link.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_resource.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_hw_sequencer.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_target.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_sink.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_surface.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_link_hwss.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_link_dp.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_link_ddc.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_debug.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/core/dc_stream.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dc_helper.o
<br> =C2=A0CC =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/../d=
isplay/modules/freesync/freesync.o
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:</span> In function =E2=80=98<span style=3D"font-weig=
ht:bold">set_hdr_static_info_packet</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:1740:2:</span> <span style=3D"font-weight:bold;color:=
rgb(255,84,255)">warning: </span>ISO C90 forbids mixed declarations and cod=
e [<span style=3D"font-weight:bold;color:rgb(255,84,255)">-Wdeclaration-aft=
er-statement</span>]
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">struct</s=
pan> dc_hdr_static_metadata hdr_metadata =3D
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">^~~~~~</s=
pan>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:1760:2:</span> <span style=3D"font-weight:bold;color:=
rgb(255,84,255)">warning: </span>ISO C90 forbids mixed declarations and cod=
e [<span style=3D"font-weight:bold;color:rgb(255,84,255)">-Wdeclaration-aft=
er-statement</span>]
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">uint32_t<=
/span> data;
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">^~~~~~~~<=
/span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:</span> In function =E2=80=98<span style=3D"font-weig=
ht:bold">set_avi_info_frame</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:1495:38:</span> <span style=3D"font-weight:bold;color=
:rgb(255,84,255)">warning: </span>iteration 28 invokes undefined behavior [=
<span style=3D"font-weight:bold;color:rgb(255,84,255)">-Waggressive-loop-op=
timizations</span>]
<br> =C2=A0=C2=A0info_packet-&gt;sb[byte_index] =3D <span style=3D"font-wei=
ght:bold;color:rgb(255,84,255)">info_frame.avi_info_packet.</span>
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"font-weight:=
bold;color:rgb(255,84,255)">~~~~~~~~~~~~~~~~~~~~~~~~~~~</span>
<br> <span style=3D"font-weight:bold;color:rgb(255,84,255)">=C2=A0=C2=A0<a =
href=3D"http://info_packet_hdmi.packet_raw_data.sb">info_packet_hdmi.packet=
_raw_data.sb</a>[byte_index]</span>;
<br> =C2=A0=C2=A0<span style=3D"font-weight:bold;color:rgb(255,84,255)">~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~</span>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:1493:2:</span> <span style=3D"font-weight:bold;color:=
rgb(84,255,255)">note: </span>within this loop
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(84,255,255)">for</span=
> (byte_index =3D 0; byte_index &lt; sizeof(info_packet-&gt;sb); byte_index=
++)
<br> =C2=A0<span style=3D"font-weight:bold;color:rgb(84,255,255)">^~~</span=
>
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:</span> In function =E2=80=98<span style=3D"font-weig=
ht:bold">set_hdr_static_info_packet.isra.8</span>=E2=80=99:
<br><span style=3D"font-weight:bold">drivers/gpu/drm/amd/amdgpu/../display/=
dc/core/dc_resource.c:1734:11:</span> <span style=3D"font-weight:bold;color=
:rgb(255,84,255)">warning: </span>=E2=80=98<span style=3D"font-weight:bold"=
>i</span>=E2=80=99 may be used uninitialized in this function [<span style=
=3D"font-weight:bold;color:rgb(255,84,255)">-Wmaybe-uninitialized</span>]
<br> =C2=A0uint16_t <span style=3D"font-weight:bold;color:rgb(255,84,255)">=
i</span>;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span styl=
e=3D"font-weight:bold;color:rgb(255,84,255)">^</span>
<br> =C2=A0LD =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdg=
pu.o
<br> =C2=A0LD =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/buil=
t-in.o
<br> =C2=A0LD =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/built-in.o
<br> =C2=A0LD =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/built-in.o
<br> =C2=A0LD =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/built-in.o
<br> =C2=A0LD =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmlinux.o<br></span></div><div>=
<span style=3D"font-family:monospace"><br></span></div><div><font face=3D"m=
onospace">Would you like me to raise bugs for any of these or are they alre=
ady known about?</font></div><div><font face=3D"monospace"><br></font></div=
><div><font face=3D"monospace">Regards</font></div><div><font face=3D"monos=
pace"><br></font></div><div><font face=3D"monospace">Mike</font></div></div=
>

--001a11463018c1571405454bca94--

--===============0963938950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0963938950==--
