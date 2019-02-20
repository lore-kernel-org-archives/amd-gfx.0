From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 000/138] The new SW SMU driver of amdgpu
Date: Wed, 20 Feb 2019 14:30:52 +0000
Message-ID: <BN6PR12MB180934267E1E1D5FC0607FD0F77D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1548411945-12396-1-git-send-email-ray.huang@amd.com>,
 <MN2PR12MB330957C48B4613D0D35B1AE4EC7D0@MN2PR12MB3309.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2036855734=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB330957C48B4613D0D35B1AE4EC7D0-rweVpJHSKTpWdvXm18W95QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============2036855734==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180934267E1E1D5FC0607FD0F77D0BN6PR12MB1809namp_"

--_000_BN6PR12MB180934267E1E1D5FC0607FD0F77D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Series is:
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Huang, Ray
Sent: Wednesday, February 20, 2019 7:51 AM
To: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
Cc: Gao, Likun; Wang, Kevin(Yang); Gui, Jack
Subject: RE: [PATCH 000/138] The new SW SMU driver of amdgpu

Ping.
May I have your comments?

Thanks,
Ray

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Huang Rui
> Sent: Friday, January 25, 2019 6:23 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Gao, Likun <Likun.Gao-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang)
> <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Gui, Jack
> <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 000/138] The new SW SMU driver of amdgpu
>
> Hi all,
>
> The series of patches are to implement a new SW SMU driver for future asi=
cs.
>
> Background:
> The powerplay driver will be retired. The final version is for vega20 wit=
h
> SMU11. However, the future asic will use the new swSMU framework to
> implement as
> well. Here is the first version of new sw smu driver that is basing on ve=
ga20.
>
> Purpose:
> We would like to do re-arch for linux power codes to use a new sw SMU ip
> block
> for future asics. We hope to write a simple and readable framework for Li=
nux.
>
> Currently, the default path is still with powerplay on vega20. So far we =
don=92t
> plan to switch default path to new swSMU design for vega20. And we can
> use the
> module parameter amdgpu_dpm to switch it to new SW SMU design
> (modprobe amdgpu
> dpm=3D1).
>
> Development Items:
> - Setup new SMU IP block skeleton.
> - Implement SMC firmware loading function.
> - Implement SMC table data structure.
> - Implement SMU v11 indirect register (MP1) read/write and SMC message
> sending
>   helpers.
> - Implement SMU v11 SMC table initialization (read from vbios, parse,
> populate,
>   and write back to smc).
> - Implement SMU v11 memory pool location function.
> - Enable DPM feature for SMU v11 and implement DPM control callback
> function.
> - Enable interfaces for starting tools.
> - Implement SMU v11 power control and power containment functions.
> - Implement and enable SMU v11 thermal/fan control function.
> - Implement SMU interfaces placeholder for DC, VCN, and KFD driver.
> - Enable and align sys interface in the amdgpu_pm.c.
>
> So far, Kevin, Likun, Jack, and I have enabled features such as dpm, od,
> thermal, and etc. with new sw smu driver. (Thanks to Kevin, Likun and Jac=
k's
> great effort!)
>
> Any comments are warm for us.
>
> Thanks & Best Regards!
> Ray
>
>
> Chengming Gui (14):
>   drm/amd/powerplay: implement power_dpm_state sys interface for
> SMU11
>   drm/amd/powerplay: add watermarks related data structs and function
>     for SMU11.
>   drm/amd/powerplay: implement pp_power_profile_mode sys inerface for
>     SMU11
>   drm/amd/powerplay: add display_config to handle display config for
>     SMU11.
>   drm/amd/powerplay: add mclk_latency_table struct and smu_clocks struct
>     for SMU11
>   drm/amd/powerplay: add enable_umd_pstate functions for SMU11
>   drm/amd/powerplay: add get_profiling_clk_mask functions for SMU11
>   drm/amd/powerplay: add set_uclk_to_highest_level for SMU11
>   drm/amd/powerplay: add display_config_changed for SMU11.
>   drm/amd/powerplay: add apply_clock_adjust_rules for SMU11.
>   drm/amd/powerplay: add vega20_notify_smc_display_config functions for
>     SMU11
>   drm/amd/powerplay: add vega20_find/force_higest/lowest_dpm for
> SMU11
>   drm/amd/powerplay: add vega20_unforce_dpm_levels for SMU11.
>   drm/amd/powerplay: implement power_dpm_force_performance_level
> for
>     SMU11
>
> Huang Rui (53):
>   drm/amd/powerplay: add new smu ip block
>   drm/amd/powerplay: add smu11 sub block for SMU IP
>   drm/amd/powerplay: add firmware loading interface
>   drm/amd/powerplay: add fw load checking interface
>   drm/amd/powerplay: add interface to read pptable from vbios
>   drm/amd/powerplay: add placeholder of smu_initialize_pptable
>   drm/amd/powerplay: add interface to init smc tables (v2)
>   drm/amd/powerplay: add interface to init power (v2)
>   drm/amd/powerplay: add interface to get vbios bootup values (v2)
>   drm/amd/powerplay: add interface to check pptable (v2)
>   drm/amd/powerplay: add interface to init fb allocations (v2)
>   drm/amd/powerplay: add interface to parse pptable (v2)
>   drm/amd/powerplay: add interface to populate smc pptable (v2)
>   drm/amd/powerplay: add interface to check fw version (v2)
>   drm/amd/powerplay: add interface to write pptable (v2)
>   drm/amd/powerplay: add interface to set min dcef deep sleep (v2)
>   drm/amd/powerplay: add interface to set tool table location (v2)
>   drm/amd/powerplay: add interface to allocate memory pool (v2)
>   drm/amd/powerplay: add interface to notify memory pool location (v2)
>   drm/amd/powerplay: add interfaces for smu resume
>   drm/amd/powerplay: add resume sequence placeholder for smu ip block
>   drm/amdgpu: enable new smu ip block for vega20
>   drm/amd/powerplay: add new ppsmc header for smu11 (v2)
>   drm/amd/powerplay: add pptable header for smu11
>   drm/amdgpu: update atomfirmware header for smu11
>   drm/amdgpu: update new members in atomfirmware
>   drm/amd/powerplay: add smu table context structure
>   drm/amd/powerplay: add get atom data table helper
>   drm/amdgpu: move get_index_into_master_table macro into
> atomfirmware
>     header
>   drm/amd/powerplay: implement read_pptable_from_vbios function for
>     smu11
>   drm/amd/powerplay: update pptable header for smu11
>   drm/amd/powerplay: add data structure of bootup values
>   drm/amd/powerplay: implement get_vbios_bootup_values function for
>     smu11 (v2)
>   drm/amd/powerplay: implement get_clk_info_from_vbios function for
>     smu11 (v2)
>   drm/amd/powerplay: add vega20 pptable function file
>   drm/amd/powerplay: add append_powerplay_table function
>   drm/amd/powerplay: add get_max_sustainable_clock function
>   drm/amd/powerplay: add the function to set deep sleep dcefclk
>   drm/amd/powerplay: add two interfaces to set_active_display_count and
>     store_cc6_data
>   drm/amd/powerplay: add smu display configuration change function
>   drm/amd/powerplay: add get_clock_by_type interface for display
>   drm/amd/powerplay: add interface to get max high clocks for display
>   drm/amd/powerplay: add interface to get clock by type with latency for
>     display (v2)
>   drm/amd/powerplay: add interface to get clock by type with voltage for
>     display
>   drm/amd/powerplay: add interface to request display clock voltage
>   drm/amd/powerplay: add interface to get dal power level
>   drm/amd/powerplay: add interface to get performance level
>   drm/amd/powerplay: add interface to get current shallow sleep clocks
>   drm/amd/powerplay: add interface to get current clocks for display
>   drm/amd/powerplay: add interface to notify smu enable pme restore
>     register
>   drm/amd/powerplay: implement interface to set watermarks for clock
>     ranges
>   drm/amd/powerplay: remove unnecessary checking in smu_hw_fini
>   drm/amd/powerplay: don't check hwmgr while using the sw smu
>
> Kevin Wang (38):
>   drm/amd/powerplay: implement smu send message functions for smu11
> (v3)
>   drm/amd/powerplay: implement check_fw_status function for smu11
>   drm/amd/powerplay: implement check_fw_version function for smu11
>   drm/amd/powerplay: implement smu_init[fini]_smc_tables for smu11
>   drm/amd/powerplay: implement smu dpm context functions for smu11
>   drm/amd/powerplay: implement smu_init[fini]_power function for smu11
>   drm/amd/powerplay: implement smu_init(fini)_fb_allocations function
>   drm/amd/powerplay: remove header of smu_v11_0_pptable
>   drm/amd/powerplay: implement smu_alloc[free]_memory pool function
>   drm/amd/powerplay: implement notify_memory_pool_location function
> for
>     smu11
>   drm/amd/powerplay: add enum smu_msg_type to header
>   drm/amd/powerplay: implement smu vega20_message_map for vega20
>   drm/amd/powerplay: use virtual msg index to replace asic-related msg
>     index
>   drm/amd/powerplay: replace SMU_MSG_XXX with PPSMC_MSG_XXX
> message
>     index for smu11 (v2)
>   drm/amd/powerplay: implement smu_init_display for smu11
>   drm/amd/powerplay: implement smu_run_afll_btc function
>   drm/amd/powerplay: implement smu feature functions
>   drm/amd/powerplay: implement feature get&set functions
>   drm/amd/powerplay: implement smu_notify_display_change function for
>     smu11
>   drm/amd/powerplay: implement get_current_clk_freq for smu11
>   drm/amd/powerplay: implement smu update table function
>   drm/amd/powerplay: implement is_support_sw_smu function for new smu
>   drm/amd/powerplay: implement sysfs of amdgpu_get_busy_percent for
>     smu11
>   drm/amd/powerplay: implement sysfs of pp_table for smu11
>   drm/amd/powerplay: implement sensor of SCLK and MCLK for smu11
>   drm/amd/powerplay: implement sensor of thermal_get_temperature for
>     smu11
>   drm/amd/powerplay: implement sensor of get_gpu_power for smu11
>   drm/amd/powerplay: implement sensor of get_gfx_vdd for smu11
>   drm/amd/powerplay: implement sensor of get feature mask
>   drm/amd/powerplay: implement sysfs of get num states function
>   drm/amd/powerplay: implement sysfs of pp_cur_state function
>   drm/amd/powerplay: implement sysfs of pp_force_state for sw-smu
>   drm/amd/powerplay: implement update enabled feature state to smc for
>     smu11
>   drm/amd/powerplay: hwmon don't check powerplay when sw smu is
> enabled
>   drm/amd/powerplay: implement uvd & vce dpm enable functions
>   drm/amd/powerplay: implement sensor of uvd & vce power state for
> smu11
>   drm/amd/powerplay: implement dpm enable functions of uvd & vce for
> smu
>   drm/amd/powerplay: enable amdgpu dpm for smu
>
> Likun Gao (33):
>   drm/amd/powerplay: init microcode for smu11
>   drm/amd/powerplay: add function to parse pptable for smu11
>   drm/amd/powerplay: add function to check pptable for smu11
>   drm/amd/powerplay: update hw fini function to relase some memory
>   drm/amd/powerplay: add function to populate smc pptable for smu11
>   drm/amd/powerplay: add function to write pptable for smu11 (v2)
>   drm/amd/powerplay: add function to set min dcef deep sleep for smu11
>     (v2)
>   drm/amd/powerplay: add function to set tool table location for smu11
>     (v2)
>   drm/amd/powerplay: expose the function of smu read argument
>   drm/amd/powerplay: Change the allocate method of dpm context for
>     smu11.
>   drm/amd/powerplay: set defalut dpm table for smu
>   drm/amd/powerplay: add function to populate umd state clk.
>   drm/amd/powerplay: add function to get power limit for smu11 (v2)
>   drm/amd/powerplay: print clock levels for smu11 (v2)
>   drm/amd/powerplay: add function to get thermal range
>   drm/amd/powerplay: add function to set thermal range
>   drm/amd/powerplay: add function to enable thermal alert
>   drm/amd/powerplay: add function to set fan table to control thermal
>   drm/amd/powerplay: add function to start thermal control
>   drm/amd/powerplay: upload dpm level for smu11
>   drm/amd/powerplay: force clock levels for smu11
>   drm/amd/powerplay: add function to store overdrive information for
>     smu11
>   drm/amd/powerplay: add function to set default overdrive settings
>   drm/amd/powerplay: add golden dpm table to backup default DPM table
>   drm/amd/powerplay: print overdrive percentage information for smu11
>   drm/amd/powerplay: get overdrive clock and voltage information
>   drm/amd/powerplay: add sys interface for pcie for smu
>   drm/amd/powerplay: add function to update overdrive settings
>   drm/amd/powerplay: add sys interface for set sclk_od/mclk_od for smu
>   drm/amd/powerplay: add sys interface to set pp_od_clk_voltage for smu
>   drm/amd/powerplay: adjust power state when set od_clk
>   drm/amd/powerplay: dpm clk can be set only when performance level is
>     manual
>   drm/amd/powerplay: Unify smu handle task function
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |    2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  364 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c                 |    9 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   99 +-
>  drivers/gpu/drm/amd/include/amd_shared.h           |    3 +
>  drivers/gpu/drm/amd/include/atomfirmware.h         |   44 +-
>  drivers/gpu/drm/amd/powerplay/Makefile             |    2 +-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 1198 +++++++++++
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  732 +++++++
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |   89 +
>  .../gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h    |  128 ++
>  .../gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h  |  147 ++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 1683
> +++++++++++++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c         | 2146
> ++++++++++++++++++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.h         |  129 ++
>  19 files changed, 6624 insertions(+), 185 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>  create mode 100644 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
>  create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
>  create mode 100644
> drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
>  create mode 100644
> drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
>  create mode 100644 drivers/gpu/drm/amd/powerplay/smu_v11_0.c
>  create mode 100644 drivers/gpu/drm/amd/powerplay/vega20_ppt.c
>  create mode 100644 drivers/gpu/drm/amd/powerplay/vega20_ppt.h
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180934267E1E1D5FC0607FD0F77D0BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray<br>
<b>Sent:</b> Wednesday, February 20, 2019 7:51 AM<br>
<b>To:</b> Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br=
>
<b>Cc:</b> Gao, Likun; Wang, Kevin(Yang); Gui, Jack<br>
<b>Subject:</b> RE: [PATCH 000/138] The new SW SMU driver of amdgpu</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping.<br>
May I have your comments?<br>
<br>
Thanks,<br>
Ray<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Huang Rui<br>
&gt; Sent: Friday, January 25, 2019 6:23 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Gao, Likun &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang)<br>
&gt; &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Gui=
, Jack<br>
&gt; &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 000/138] The new SW SMU driver of amdgpu<br>
&gt; <br>
&gt; Hi all,<br>
&gt; <br>
&gt; The series of patches are to implement a new SW SMU driver for future =
asics.<br>
&gt; <br>
&gt; Background:<br>
&gt; The powerplay driver will be retired. The final version is for vega20 =
with<br>
&gt; SMU11. However, the future asic will use the new swSMU framework to<br=
>
&gt; implement as<br>
&gt; well. Here is the first version of new sw smu driver that is basing on=
 vega20.<br>
&gt; <br>
&gt; Purpose:<br>
&gt; We would like to do re-arch for linux power codes to use a new sw SMU =
ip<br>
&gt; block<br>
&gt; for future asics. We hope to write a simple and readable framework for=
 Linux.<br>
&gt; <br>
&gt; Currently, the default path is still with powerplay on vega20. So far =
we don=92t<br>
&gt; plan to switch default path to new swSMU design for vega20. And we can=
<br>
&gt; use the<br>
&gt; module parameter amdgpu_dpm to switch it to new SW SMU design<br>
&gt; (modprobe amdgpu<br>
&gt; dpm=3D1).<br>
&gt; <br>
&gt; Development Items:<br>
&gt; - Setup new SMU IP block skeleton.<br>
&gt; - Implement SMC firmware loading function.<br>
&gt; - Implement SMC table data structure.<br>
&gt; - Implement SMU v11 indirect register (MP1) read/write and SMC message=
<br>
&gt; sending<br>
&gt;&nbsp;&nbsp; helpers.<br>
&gt; - Implement SMU v11 SMC table initialization (read from vbios, parse,<=
br>
&gt; populate,<br>
&gt;&nbsp;&nbsp; and write back to smc).<br>
&gt; - Implement SMU v11 memory pool location function.<br>
&gt; - Enable DPM feature for SMU v11 and implement DPM control callback<br=
>
&gt; function.<br>
&gt; - Enable interfaces for starting tools.<br>
&gt; - Implement SMU v11 power control and power containment functions.<br>
&gt; - Implement and enable SMU v11 thermal/fan control function.<br>
&gt; - Implement SMU interfaces placeholder for DC, VCN, and KFD driver.<br=
>
&gt; - Enable and align sys interface in the amdgpu_pm.c.<br>
&gt; <br>
&gt; So far, Kevin, Likun, Jack, and I have enabled features such as dpm, o=
d,<br>
&gt; thermal, and etc. with new sw smu driver. (Thanks to Kevin, Likun and =
Jack's<br>
&gt; great effort!)<br>
&gt; <br>
&gt; Any comments are warm for us.<br>
&gt; <br>
&gt; Thanks &amp; Best Regards!<br>
&gt; Ray<br>
&gt; <br>
&gt; <br>
&gt; Chengming Gui (14):<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement power_dpm_state sys interface=
 for<br>
&gt; SMU11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add watermarks related data structs and=
 function<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; for SMU11.<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement pp_power_profile_mode sys ine=
rface for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; SMU11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add display_config to handle display co=
nfig for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; SMU11.<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add mclk_latency_table struct and smu_c=
locks struct<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; for SMU11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add enable_umd_pstate functions for SMU=
11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add get_profiling_clk_mask functions fo=
r SMU11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add set_uclk_to_highest_level for SMU11=
<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add display_config_changed for SMU11.<b=
r>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add apply_clock_adjust_rules for SMU11.=
<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add vega20_notify_smc_display_config fu=
nctions for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; SMU11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add vega20_find/force_higest/lowest_dpm=
 for<br>
&gt; SMU11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add vega20_unforce_dpm_levels for SMU11=
.<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement power_dpm_force_performance_l=
evel<br>
&gt; for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; SMU11<br>
&gt; <br>
&gt; Huang Rui (53):<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add new smu ip block<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add smu11 sub block for SMU IP<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add firmware loading interface<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add fw load checking interface<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to read pptable from vbio=
s<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add placeholder of smu_initialize_pptab=
le<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to init smc tables (v2)<b=
r>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to init power (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get vbios bootup value=
s (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to check pptable (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to init fb allocations (v=
2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to parse pptable (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to populate smc pptable (=
v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to check fw version (v2)<=
br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to write pptable (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to set min dcef deep slee=
p (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to set tool table locatio=
n (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to allocate memory pool (=
v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to notify memory pool loc=
ation (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interfaces for smu resume<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add resume sequence placeholder for smu=
 ip block<br>
&gt;&nbsp;&nbsp; drm/amdgpu: enable new smu ip block for vega20<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add new ppsmc header for smu11 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add pptable header for smu11<br>
&gt;&nbsp;&nbsp; drm/amdgpu: update atomfirmware header for smu11<br>
&gt;&nbsp;&nbsp; drm/amdgpu: update new members in atomfirmware<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add smu table context structure<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add get atom data table helper<br>
&gt;&nbsp;&nbsp; drm/amdgpu: move get_index_into_master_table macro into<br=
>
&gt; atomfirmware<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; header<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement read_pptable_from_vbios funct=
ion for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: update pptable header for smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add data structure of bootup values<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement get_vbios_bootup_values funct=
ion for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement get_clk_info_from_vbios funct=
ion for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add vega20 pptable function file<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add append_powerplay_table function<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add get_max_sustainable_clock function<=
br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add the function to set deep sleep dcef=
clk<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add two interfaces to set_active_displa=
y_count and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; store_cc6_data<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add smu display configuration change fu=
nction<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add get_clock_by_type interface for dis=
play<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get max high clocks fo=
r display<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get clock by type with=
 latency for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; display (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get clock by type with=
 voltage for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; display<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to request display clock =
voltage<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get dal power level<br=
>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get performance level<=
br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get current shallow sl=
eep clocks<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to get current clocks for=
 display<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add interface to notify smu enable pme =
restore<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; register<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement interface to set watermarks f=
or clock<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; ranges<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: remove unnecessary checking in smu_hw_f=
ini<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: don't check hwmgr while using the sw sm=
u<br>
&gt; <br>
&gt; Kevin Wang (38):<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu send message functions fo=
r smu11<br>
&gt; (v3)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement check_fw_status function for =
smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement check_fw_version function for=
 smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_init[fini]_smc_tables for=
 smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu dpm context functions for=
 smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_init[fini]_power function=
 for smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_init(fini)_fb_allocations=
 function<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: remove header of smu_v11_0_pptable<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_alloc[free]_memory pool f=
unction<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement notify_memory_pool_location f=
unction<br>
&gt; for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add enum smu_msg_type to header<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu vega20_message_map for ve=
ga20<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: use virtual msg index to replace asic-r=
elated msg<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; index<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: replace SMU_MSG_XXX with PPSMC_MSG_XXX<=
br>
&gt; message<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; index for smu11 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_init_display for smu11<br=
>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_run_afll_btc function<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu feature functions<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement feature get&amp;set functions=
<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu_notify_display_change fun=
ction for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement get_current_clk_freq for smu1=
1<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement smu update table function<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement is_support_sw_smu function fo=
r new smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sysfs of amdgpu_get_busy_perc=
ent for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sysfs of pp_table for smu11<b=
r>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sensor of SCLK and MCLK for s=
mu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sensor of thermal_get_tempera=
ture for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sensor of get_gpu_power for s=
mu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sensor of get_gfx_vdd for smu=
11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sensor of get feature mask<br=
>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sysfs of get num states funct=
ion<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sysfs of pp_cur_state functio=
n<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sysfs of pp_force_state for s=
w-smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement update enabled feature state =
to smc for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: hwmon don't check powerplay when sw smu=
 is<br>
&gt; enabled<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement uvd &amp; vce dpm enable func=
tions<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement sensor of uvd &amp; vce power=
 state for<br>
&gt; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: implement dpm enable functions of uvd &=
amp; vce for<br>
&gt; smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: enable amdgpu dpm for smu<br>
&gt; <br>
&gt; Likun Gao (33):<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: init microcode for smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to parse pptable for smu11=
<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to check pptable for smu11=
<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: update hw fini function to relase some =
memory<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to populate smc pptable fo=
r smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to write pptable for smu11=
 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to set min dcef deep sleep=
 for smu11<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to set tool table location=
 for smu11<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: expose the function of smu read argumen=
t<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: Change the allocate method of dpm conte=
xt for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11.<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: set defalut dpm table for smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to populate umd state clk.=
<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to get power limit for smu=
11 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: print clock levels for smu11 (v2)<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to get thermal range<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to set thermal range<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to enable thermal alert<br=
>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to set fan table to contro=
l thermal<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to start thermal control<b=
r>
&gt;&nbsp;&nbsp; drm/amd/powerplay: upload dpm level for smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: force clock levels for smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to store overdrive informa=
tion for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to set default overdrive s=
ettings<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add golden dpm table to backup default =
DPM table<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: print overdrive percentage information =
for smu11<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: get overdrive clock and voltage informa=
tion<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add sys interface for pcie for smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add function to update overdrive settin=
gs<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add sys interface for set sclk_od/mclk_=
od for smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: add sys interface to set pp_od_clk_volt=
age for smu<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: adjust power state when set od_clk<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: dpm clk can be set only when performanc=
e level is<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; manual<br>
&gt;&nbsp;&nbsp; drm/amd/powerplay: Unify smu handle task function<br>
&gt; <br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
&nbsp; 4 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp;&nbsp; |&n=
bsp;&nbsp; 12 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h&nbsp;&nbsp; |&n=
bsp;&nbsp;&nbsp; 2 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 11 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 364 &#43;&#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp;&nbsp; 9 &#43;-<br>
&gt;&nbsp; .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c&nbsp;&nbsp; |&n=
bsp;&nbsp; 99 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 3 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/atomfirmware.h&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 44 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 &#43;-=
<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 1198 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 732 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 89 &#43;<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h&nbsp;&nbsp;&nbsp=
; |&nbsp; 128 &#43;&#43;<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h&nbsp; |&nbsp; =
147 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1683<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 2146<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/vega20_ppt.h&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 129 &#43;&#43;<br>
&gt;&nbsp; 19 files changed, 6624 insertions(&#43;), 185 deletions(-)<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br=
>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.=
h<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h=
<br>
&gt;&nbsp; create mode 100644<br>
&gt; drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h<br>
&gt;&nbsp; create mode 100644<br>
&gt; drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br=
>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/powerplay/vega20_ppt.h<br=
>
&gt; <br>
&gt; --<br>
&gt; 2.7.4<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180934267E1E1D5FC0607FD0F77D0BN6PR12MB1809namp_--

--===============2036855734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2036855734==--
