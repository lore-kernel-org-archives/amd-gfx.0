From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: fix Polaris 12 bw bounding box
Date: Thu, 22 Mar 2018 18:51:53 +0000
Message-ID: <BN6PR12MB1809CA5F7C24F5115B7A8A3AF7A90@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180320191259.14453-10-harry.wentland@amd.com>,
 <20180322183957.11419-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1795752483=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180322183957.11419-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Laktyushkin, Dmytro" <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

--===============1795752483==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809CA5F7C24F5115B7A8A3AF7A90BN6PR12MB1809namp_"

--_000_BN6PR12MB1809CA5F7C24F5115B7A8A3AF7A90BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, March 22, 2018 2:39:57 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Laktyushkin, Dmytro; Wentland, Harry
Subject: [PATCH v2] drm/amd/display: fix Polaris 12 bw bounding box

From: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Acked-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 121 +++++++++++++++++++=
+++-
 drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h   |   1 +
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu=
/drm/amd/display/dc/calcs/dce_calcs.c
index 0cbab81ab304..821502b1acba 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -52,10 +52,11 @@ static enum bw_calcs_version bw_calcs_version_from_asic=
_id(struct hw_asic_id asi
                 return BW_CALCS_VERSION_CARRIZO;

         case FAMILY_VI:
+               if (ASIC_REV_IS_POLARIS12_V(asic_id.hw_internal_rev))
+                       return BW_CALCS_VERSION_POLARIS12;
                 if (ASIC_REV_IS_POLARIS10_P(asic_id.hw_internal_rev))
                         return BW_CALCS_VERSION_POLARIS10;
-               if (ASIC_REV_IS_POLARIS11_M(asic_id.hw_internal_rev) ||
-                               ASIC_REV_IS_POLARIS12_V(asic_id.hw_internal=
_rev))
+               if (ASIC_REV_IS_POLARIS11_M(asic_id.hw_internal_rev))
                         return BW_CALCS_VERSION_POLARIS11;
                 return BW_CALCS_VERSION_INVALID;

@@ -2373,6 +2374,122 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
                 dceip.scatter_gather_pte_request_rows_in_tiling_mode =3D 2=
;
                 dceip.mcifwr_all_surfaces_burst_time =3D bw_int_to_fixed(0=
);
                 break;
+       case BW_CALCS_VERSION_POLARIS12:
+               vbios.memory_type =3D bw_def_gddr5;
+               vbios.dram_channel_width_in_bits =3D 32;
+               vbios.number_of_dram_channels =3D asic_id.vram_width / vbio=
s.dram_channel_width_in_bits;
+               vbios.number_of_dram_banks =3D 8;
+               vbios.high_yclk =3D bw_int_to_fixed(6000);
+               vbios.mid_yclk =3D bw_int_to_fixed(3200);
+               vbios.low_yclk =3D bw_int_to_fixed(1000);
+               vbios.low_sclk =3D bw_int_to_fixed(678);
+               vbios.mid1_sclk =3D bw_int_to_fixed(864);
+               vbios.mid2_sclk =3D bw_int_to_fixed(900);
+               vbios.mid3_sclk =3D bw_int_to_fixed(920);
+               vbios.mid4_sclk =3D bw_int_to_fixed(940);
+               vbios.mid5_sclk =3D bw_int_to_fixed(960);
+               vbios.mid6_sclk =3D bw_int_to_fixed(980);
+               vbios.high_sclk =3D bw_int_to_fixed(1049);
+               vbios.low_voltage_max_dispclk =3D bw_int_to_fixed(459);
+               vbios.mid_voltage_max_dispclk =3D bw_int_to_fixed(654);
+               vbios.high_voltage_max_dispclk =3D bw_int_to_fixed(1108);
+               vbios.low_voltage_max_phyclk =3D bw_int_to_fixed(540);
+               vbios.mid_voltage_max_phyclk =3D bw_int_to_fixed(810);
+               vbios.high_voltage_max_phyclk =3D bw_int_to_fixed(810);
+               vbios.data_return_bus_width =3D bw_int_to_fixed(32);
+               vbios.trc =3D bw_int_to_fixed(48);
+               if (vbios.number_of_dram_channels =3D=3D 2) // 64-bit
+                       vbios.dmifmc_urgent_latency =3D bw_int_to_fixed(4);
+               else
+                       vbios.dmifmc_urgent_latency =3D bw_int_to_fixed(3);
+               vbios.stutter_self_refresh_exit_latency =3D bw_int_to_fixed=
(5);
+               vbios.stutter_self_refresh_entry_latency =3D bw_int_to_fixe=
d(0);
+               vbios.nbp_state_change_latency =3D bw_int_to_fixed(250);
+               vbios.mcifwrmc_urgent_latency =3D bw_int_to_fixed(10);
+               vbios.scatter_gather_enable =3D false;
+               vbios.down_spread_percentage =3D bw_frc_to_fixed(5, 10);
+               vbios.cursor_width =3D 32;
+               vbios.average_compression_rate =3D 4;
+               vbios.number_of_request_slots_gmc_reserves_for_dmif_per_cha=
nnel =3D 256;
+               vbios.blackout_duration =3D bw_int_to_fixed(0); /* us */
+               vbios.maximum_blackout_recovery_time =3D bw_int_to_fixed(0)=
;
+
+               dceip.max_average_percent_of_ideal_port_bw_display_can_use_=
in_normal_system_operation =3D 100;
+               dceip.max_average_percent_of_ideal_drambw_display_can_use_i=
n_normal_system_operation =3D 100;
+               dceip.percent_of_ideal_port_bw_received_after_urgent_latenc=
y =3D 100;
+               dceip.large_cursor =3D false;
+               dceip.dmif_request_buffer_size =3D bw_int_to_fixed(768);
+               dceip.dmif_pipe_en_fbc_chunk_tracker =3D false;
+               dceip.cursor_max_outstanding_group_num =3D 1;
+               dceip.lines_interleaved_into_lb =3D 2;
+               dceip.chunk_width =3D 256;
+               dceip.number_of_graphics_pipes =3D 5;
+               dceip.number_of_underlay_pipes =3D 0;
+               dceip.low_power_tiling_mode =3D 0;
+               dceip.display_write_back_supported =3D true;
+               dceip.argb_compression_support =3D true;
+               dceip.underlay_vscaler_efficiency6_bit_per_component =3D
+                       bw_frc_to_fixed(35556, 10000);
+               dceip.underlay_vscaler_efficiency8_bit_per_component =3D
+                       bw_frc_to_fixed(34286, 10000);
+               dceip.underlay_vscaler_efficiency10_bit_per_component =3D
+                       bw_frc_to_fixed(32, 10);
+               dceip.underlay_vscaler_efficiency12_bit_per_component =3D
+                       bw_int_to_fixed(3);
+               dceip.graphics_vscaler_efficiency6_bit_per_component =3D
+                       bw_frc_to_fixed(35, 10);
+               dceip.graphics_vscaler_efficiency8_bit_per_component =3D
+                       bw_frc_to_fixed(34286, 10000);
+               dceip.graphics_vscaler_efficiency10_bit_per_component =3D
+                       bw_frc_to_fixed(32, 10);
+               dceip.graphics_vscaler_efficiency12_bit_per_component =3D
+                       bw_int_to_fixed(3);
+               dceip.alpha_vscaler_efficiency =3D bw_int_to_fixed(3);
+               dceip.max_dmif_buffer_allocated =3D 4;
+               dceip.graphics_dmif_size =3D 12288;
+               dceip.underlay_luma_dmif_size =3D 19456;
+               dceip.underlay_chroma_dmif_size =3D 23552;
+               dceip.pre_downscaler_enabled =3D true;
+               dceip.underlay_downscale_prefetch_enabled =3D true;
+               dceip.lb_write_pixels_per_dispclk =3D bw_int_to_fixed(1);
+               dceip.lb_size_per_component444 =3D bw_int_to_fixed(245952);
+               dceip.graphics_lb_nodownscaling_multi_line_prefetching =3D =
true;
+               dceip.stutter_and_dram_clock_state_change_gated_before_curs=
or =3D
+                       bw_int_to_fixed(1);
+               dceip.underlay420_luma_lb_size_per_component =3D bw_int_to_=
fixed(
+                       82176);
+               dceip.underlay420_chroma_lb_size_per_component =3D
+                       bw_int_to_fixed(164352);
+               dceip.underlay422_lb_size_per_component =3D bw_int_to_fixed=
(
+                       82176);
+               dceip.cursor_chunk_width =3D bw_int_to_fixed(64);
+               dceip.cursor_dcp_buffer_lines =3D bw_int_to_fixed(4);
+               dceip.underlay_maximum_width_efficient_for_tiling =3D
+                       bw_int_to_fixed(1920);
+               dceip.underlay_maximum_height_efficient_for_tiling =3D
+                       bw_int_to_fixed(1080);
+               dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_=
displays_or_single_rotated_display =3D
+                       bw_frc_to_fixed(3, 10);
+               dceip.peak_pte_request_to_eviction_ratio_limiting_single_di=
splay_no_rotation =3D
+                       bw_int_to_fixed(25);
+               dceip.minimum_outstanding_pte_request_limit =3D bw_int_to_f=
ixed(
+                       2);
+               dceip.maximum_total_outstanding_pte_requests_allowed_by_saw=
 =3D
+                       bw_int_to_fixed(128);
+               dceip.limit_excessive_outstanding_dmif_requests =3D true;
+               dceip.linear_mode_line_request_alternation_slice =3D
+                       bw_int_to_fixed(64);
+               dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mod=
e =3D
+                       32;
+               dceip.display_write_back420_luma_mcifwr_buffer_size =3D 122=
88;
+               dceip.display_write_back420_chroma_mcifwr_buffer_size =3D 8=
192;
+               dceip.request_efficiency =3D bw_frc_to_fixed(8, 10);
+               dceip.dispclk_per_request =3D bw_int_to_fixed(2);
+               dceip.dispclk_ramping_factor =3D bw_frc_to_fixed(105, 100);
+               dceip.display_pipe_throughput_factor =3D bw_frc_to_fixed(10=
5, 100);
+               dceip.scatter_gather_pte_request_rows_in_tiling_mode =3D 2;
+               dceip.mcifwr_all_surfaces_burst_time =3D bw_int_to_fixed(0)=
;
+               break;
         case BW_CALCS_VERSION_STONEY:
                 vbios.memory_type =3D bw_def_gddr5;
                 vbios.dram_channel_width_in_bits =3D 64;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h b/drivers/gpu/d=
rm/amd/display/dc/inc/dce_calcs.h
index a9bfe9ff8ce6..0bd87f24fc06 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h
@@ -42,6 +42,7 @@ enum bw_calcs_version {
         BW_CALCS_VERSION_CARRIZO,
         BW_CALCS_VERSION_POLARIS10,
         BW_CALCS_VERSION_POLARIS11,
+       BW_CALCS_VERSION_POLARIS12,
         BW_CALCS_VERSION_STONEY,
         BW_CALCS_VERSION_VEGA10
 };
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809CA5F7C24F5115B7A8A3AF7A90BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.went=
land-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 22, 2018 2:39:57 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Laktyushkin, Dmytro; Wentland, Harry<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: fix Polaris 12 bw bounding box<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Dmytro Laktyushkin &lt;Dmytro.Laktyushkin@am=
d.com&gt;<br>
<br>
Signed-off-by: Dmytro Laktyushkin &lt;Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 121 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h&nbsp;&nbsp; |&nbsp;&nb=
sp; 1 &#43;<br>
&nbsp;2 files changed, 120 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu=
/drm/amd/display/dc/calcs/dce_calcs.c<br>
index 0cbab81ab304..821502b1acba 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c<br>
@@ -52,10 &#43;52,11 @@ static enum bw_calcs_version bw_calcs_version_from_=
asic_id(struct hw_asic_id asi<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return BW_CALCS_VERSION_CARRIZO;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_VI:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ASIC_REV_IS_POLARIS12_V(asic_id.hw_internal_rev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BW_CA=
LCS_VERSION_POLARIS12;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASIC_REV_IS_POLARIS10_P(asic_id.hw_internal_rev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n BW_CALCS_VERSION_POLARIS10;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ASIC_REV_IS_POLARIS11_M(asic_id.hw_internal_rev) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASIC_REV_IS_POLARIS12_V(asic_id.hw_internal=
_rev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ASIC_REV_IS_POLARIS11_M(asic_id.hw_internal_rev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n BW_CALCS_VERSION_POLARIS11;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return BW_CALCS_VERSION_INVALID;<br>
&nbsp;<br>
@@ -2373,6 &#43;2374,122 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dc=
eip,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dceip.scatter_gather_pte_request_rows_in_tiling_mode =
=3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dceip.mcifwr_all_surfaces_burst_time =3D bw_int_to_fi=
xed(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case BW_CALCS_VERSION_POLARIS12:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.memory_type =3D bw_def_gddr5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.dram_channel_width_in_bits =3D 32;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.number_of_dram_channels =3D asic_id.vram_width / vbios=
.dram_channel_width_in_bits;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.number_of_dram_banks =3D 8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.high_yclk =3D bw_int_to_fixed(6000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid_yclk =3D bw_int_to_fixed(3200);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.low_yclk =3D bw_int_to_fixed(1000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.low_sclk =3D bw_int_to_fixed(678);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid1_sclk =3D bw_int_to_fixed(864);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid2_sclk =3D bw_int_to_fixed(900);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid3_sclk =3D bw_int_to_fixed(920);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid4_sclk =3D bw_int_to_fixed(940);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid5_sclk =3D bw_int_to_fixed(960);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid6_sclk =3D bw_int_to_fixed(980);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.high_sclk =3D bw_int_to_fixed(1049);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.low_voltage_max_dispclk =3D bw_int_to_fixed(459);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid_voltage_max_dispclk =3D bw_int_to_fixed(654);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.high_voltage_max_dispclk =3D bw_int_to_fixed(1108);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.low_voltage_max_phyclk =3D bw_int_to_fixed(540);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mid_voltage_max_phyclk =3D bw_int_to_fixed(810);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.high_voltage_max_phyclk =3D bw_int_to_fixed(810);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.data_return_bus_width =3D bw_int_to_fixed(32);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.trc =3D bw_int_to_fixed(48);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (vbios.number_of_dram_channels =3D=3D 2) // 64-bit<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios.dmifmc=
_urgent_latency =3D bw_int_to_fixed(4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios.dmifmc=
_urgent_latency =3D bw_int_to_fixed(3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.stutter_self_refresh_exit_latency =3D bw_int_to_fixed(=
5);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.stutter_self_refresh_entry_latency =3D bw_int_to_fixed=
(0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.nbp_state_change_latency =3D bw_int_to_fixed(250);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.mcifwrmc_urgent_latency =3D bw_int_to_fixed(10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.scatter_gather_enable =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.down_spread_percentage =3D bw_frc_to_fixed(5, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.cursor_width =3D 32;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.average_compression_rate =3D 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.number_of_request_slots_gmc_reserves_for_dmif_per_chan=
nel =3D 256;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.blackout_duration =3D bw_int_to_fixed(0); /* us */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vbios.maximum_blackout_recovery_time =3D bw_int_to_fixed(0);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.max_average_percent_of_ideal_port_bw_display_can_use_i=
n_normal_system_operation =3D 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.max_average_percent_of_ideal_drambw_display_can_use_in=
_normal_system_operation =3D 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.percent_of_ideal_port_bw_received_after_urgent_latency=
 =3D 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.large_cursor =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.dmif_request_buffer_size =3D bw_int_to_fixed(768);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.dmif_pipe_en_fbc_chunk_tracker =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.cursor_max_outstanding_group_num =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.lines_interleaved_into_lb =3D 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.chunk_width =3D 256;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.number_of_graphics_pipes =3D 5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.number_of_underlay_pipes =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.low_power_tiling_mode =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.display_write_back_supported =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.argb_compression_support =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_vscaler_efficiency6_bit_per_component =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(35556, 10000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_vscaler_efficiency8_bit_per_component =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(34286, 10000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_vscaler_efficiency10_bit_per_component =3D<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(32, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_vscaler_efficiency12_bit_per_component =3D<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.graphics_vscaler_efficiency6_bit_per_component =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(35, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.graphics_vscaler_efficiency8_bit_per_component =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(34286, 10000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.graphics_vscaler_efficiency10_bit_per_component =3D<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(32, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.graphics_vscaler_efficiency12_bit_per_component =3D<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.alpha_vscaler_efficiency =3D bw_int_to_fixed(3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.max_dmif_buffer_allocated =3D 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.graphics_dmif_size =3D 12288;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_luma_dmif_size =3D 19456;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_chroma_dmif_size =3D 23552;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.pre_downscaler_enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_downscale_prefetch_enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.lb_write_pixels_per_dispclk =3D bw_int_to_fixed(1);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.lb_size_per_component444 =3D bw_int_to_fixed(245952);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.graphics_lb_nodownscaling_multi_line_prefetching =3D t=
rue;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.stutter_and_dram_clock_state_change_gated_before_curso=
r =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay420_luma_lb_size_per_component =3D bw_int_to_f=
ixed(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 82176);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay420_chroma_lb_size_per_component =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(164352);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay422_lb_size_per_component =3D bw_int_to_fixed(=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 82176);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.cursor_chunk_width =3D bw_int_to_fixed(64);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.cursor_dcp_buffer_lines =3D bw_int_to_fixed(4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_maximum_width_efficient_for_tiling =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(1920);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.underlay_maximum_height_efficient_for_tiling =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(1080);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_d=
isplays_or_single_rotated_display =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_frc_to_fi=
xed(3, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.peak_pte_request_to_eviction_ratio_limiting_single_dis=
play_no_rotation =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(25);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.minimum_outstanding_pte_request_limit =3D bw_int_to_fi=
xed(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(128);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.limit_excessive_outstanding_dmif_requests =3D true;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.linear_mode_line_request_alternation_slice =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_int_to_fi=
xed(64);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode=
 =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.display_write_back420_luma_mcifwr_buffer_size =3D 1228=
8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.display_write_back420_chroma_mcifwr_buffer_size =3D 81=
92;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.request_efficiency =3D bw_frc_to_fixed(8, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.dispclk_per_request =3D bw_int_to_fixed(2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.dispclk_ramping_factor =3D bw_frc_to_fixed(105, 100);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.display_pipe_throughput_factor =3D bw_frc_to_fixed(105=
, 100);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.scatter_gather_pte_request_rows_in_tiling_mode =3D 2;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dceip.mcifwr_all_surfaces_burst_time =3D bw_int_to_fixed(0);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case BW_CALCS_VERSION_STON=
EY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vbios.memory_type =3D bw_def_gddr5;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vbios.dram_channel_width_in_bits =3D 64;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h b/drivers/gpu/d=
rm/amd/display/dc/inc/dce_calcs.h<br>
index a9bfe9ff8ce6..0bd87f24fc06 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h<br>
@@ -42,6 &#43;42,7 @@ enum bw_calcs_version {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_CALCS_VERSION_CARRIZO,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_CALCS_VERSION_POLARIS10=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_CALCS_VERSION_POLARIS11=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_CALCS_VERSION_POLARIS12,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_CALCS_VERSION_STONEY,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_CALCS_VERSION_VEGA10<br=
>
&nbsp;};<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809CA5F7C24F5115B7A8A3AF7A90BN6PR12MB1809namp_--

--===============1795752483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1795752483==--
