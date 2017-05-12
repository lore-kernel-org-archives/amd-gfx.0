From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amd/powerplay/smu7: add vblank check for mclk
 switching
Date: Fri, 12 May 2017 09:52:19 +0200
Message-ID: <CA+nq7Ds1vf8W_DLaZ3aLVSqYstZ8sqFLKFVEOv4-0O67vzNEkA@mail.gmail.com>
References: <1494525521-20864-1-git-send-email-alexander.deucher@amd.com>
 <1494525521-20864-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0637678384=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494525521-20864-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0637678384==
Content-Type: multipart/alternative; boundary="94eb2c196cf421e2e2054f4efc96"

--94eb2c196cf421e2e2054f4efc96
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Comment below

Den 11 maj 2017 7:59 em skrev "Alex Deucher" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

Check to make sure the vblank period is long enough to support
mclk switching.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=96868

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 31
+++++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index a74a3db..d745065 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -2655,6 +2655,28 @@ static int smu7_get_power_state_size(struct pp_hwmgr
*hwmgr)
        return sizeof(struct smu7_power_state);
 }

+static int smu7_vblank_too_short(struct pp_hwmgr *hwmgr,
+                                uint32_t vblank_time_us)
+{
+       struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+       uint32_t switch_limit_us = data->is_memory_gddr5 ? 450 : 150;


This assignment is overwritten below.

BR
Nils

+
+       switch (hwmgr->chip_id) {
+       case CHIP_POLARIS10:
+       case CHIP_POLARIS11:
+       case CHIP_POLARIS12:
+               switch_limit_us = data->is_memory_gddr5 ? 190 : 150;
+               break;
+       default:
+               switch_limit_us = data->is_memory_gddr5 ? 450 : 150;
+               break;
+       }
+
+       if (vblank_time_us < switch_limit_us)
+               return true;
+       else
+               return false;
+}

 static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
                                struct pp_power_state *request_ps,
@@ -2669,6 +2691,7 @@ static int smu7_apply_state_adjust_rules(struct
pp_hwmgr *hwmgr,
        bool disable_mclk_switching;
        bool disable_mclk_switching_for_frame_lock;
        struct cgs_display_info info = {0};
+       struct cgs_mode_info mode_info = {0};
        const struct phm_clock_and_voltage_limits *max_limits;
        uint32_t i;
        struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2677,6 +2700,7 @@ static int smu7_apply_state_adjust_rules(struct
pp_hwmgr *hwmgr,
        int32_t count;
        int32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;

+       info.mode_info = &mode_info;
        data->battery_state = (PP_StateUILabel_Battery ==
                        request_ps->classification.ui_label);

@@ -2703,8 +2727,6 @@ static int smu7_apply_state_adjust_rules(struct
pp_hwmgr *hwmgr,

        cgs_get_active_displays_info(hwmgr->device, &info);

-       /*TO DO result = PHM_CheckVBlankTime(hwmgr, &vblankTooShort);*/
-
        minimum_clocks.engineClock = hwmgr->display_config.min_
core_set_clock;
        minimum_clocks.memoryClock = hwmgr->display_config.min_mem_
set_clock;

@@ -2769,8 +2791,9 @@ static int smu7_apply_state_adjust_rules(struct
pp_hwmgr *hwmgr,
                                    PHM_PlatformCaps_
DisableMclkSwitchingForFrameLock);


-       disable_mclk_switching = (1 < info.display_count) ||
-                                   disable_mclk_switching_for_frame_lock;
+       disable_mclk_switching = ((1 < info.display_count) ||
+                                 disable_mclk_switching_for_frame_lock ||
+                                 smu7_vblank_too_short(hwmgr,
mode_info.vblank_time_us));

        sclk = smu7_ps->performance_levels[0].engine_clock;
        mclk = smu7_ps->performance_levels[0].memory_clock;
--
2.5.5

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c196cf421e2e2054f4efc96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Alex,</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Comment below<br><div class=3D"gmail_extra" dir=3D"auto"><br><div=
 class=3D"gmail_quote">Den 11 maj 2017 7:59 em skrev &quot;Alex Deucher&quo=
t; &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t;:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Check to make sure the=
 vblank period is long enough to support<br>
mclk switching.<br>
<br>
bug: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D96868" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org/<wbr>show_bu=
g.cgi?id=3D96868</a><br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/powerplay/<wbr>hwmgr/smu7_hwmgr.c | 31 ++++++++++=
+++++++++++---<br>
=C2=A01 file changed, 27 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c<br>
index a74a3db..d745065 100644<br>
--- a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -2655,6 +2655,28 @@ static int smu7_get_power_state_size(<wbr>struct pp_=
hwmgr *hwmgr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sizeof(struct smu7_power_state);<br>
=C2=A0}<br>
<br>
+static int smu7_vblank_too_short(struct pp_hwmgr *hwmgr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t vblank_time_us)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct smu7_hwmgr *data =3D (struct smu7_hwmgr =
*)(hwmgr-&gt;backend);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t switch_limit_us =3D data-&gt;is_memory=
_gddr5 ? 450 : 150;<br></blockquote></div></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">This assignment is overwritten below.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">BR</div><div dir=3D"auto">Nils</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra" di=
r=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (hwmgr-&gt;chip_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS10:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS11:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS12:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch_limit_us =3D=
 data-&gt;is_memory_gddr5 ? 190 : 150;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch_limit_us =3D=
 data-&gt;is_memory_gddr5 ? 450 : 150;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vblank_time_us &lt; switch_limit_us)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+}<br>
<br>
=C2=A0static int smu7_apply_state_adjust_rules(<wbr>struct pp_hwmgr *hwmgr,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pp_power_state *request_ps,<b=
r>
@@ -2669,6 +2691,7 @@ static int smu7_apply_state_adjust_rules(<wbr>struct =
pp_hwmgr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool disable_mclk_switching;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool disable_mclk_switching_for_<wbr>frame_lock=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cgs_display_info info =3D {0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cgs_mode_info mode_info =3D {0};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct phm_clock_and_voltage_limits *max_=
limits;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct smu7_hwmgr *data =3D (struct smu7_hwmgr =
*)(hwmgr-&gt;backend);<br>
@@ -2677,6 +2700,7 @@ static int smu7_apply_state_adjust_rules(<wbr>struct =
pp_hwmgr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t stable_pstate_sclk =3D 0, stable_pstate=
_mclk =3D 0;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0info.mode_info =3D &amp;mode_info;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;battery_state =3D (PP_StateUILabel_Bat=
tery =3D=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 request_ps-&gt;classification.ui_<wbr>label);<br>
<br>
@@ -2703,8 +2727,6 @@ static int smu7_apply_state_adjust_rules(<wbr>struct =
pp_hwmgr *hwmgr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cgs_get_active_displays_info(<wbr>hwmgr-&gt;dev=
ice, &amp;info);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*TO DO result =3D PHM_CheckVBlankTime(hwmgr, &=
amp;vblankTooShort);*/<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum_clocks.engineClock =3D hwmgr-&gt;displa=
y_config.min_<wbr>core_set_clock;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum_clocks.memoryClock =3D hwmgr-&gt;displa=
y_config.min_mem_<wbr>set_clock;<br>
<br>
@@ -2769,8 +2791,9 @@ static int smu7_apply_state_adjust_rules(<wbr>struct =
pp_hwmgr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PHM_PlatformCaps_<wbr>=
DisableMclkSwitchingForFrameLo<wbr>ck);<br>
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_mclk_switching =3D (1 &lt; info.display=
_count) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_mclk_switching_=
for_<wbr>frame_lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_mclk_switching =3D ((1 &lt; info.displa=
y_count) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_mclk_switching_for_<wb=
r>frame_lock ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu7_vblank_too_short(hwmgr, m=
ode_info.vblank_time_us));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sclk =3D smu7_ps-&gt;performance_levels[0]<wbr>=
.engine_clock;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mclk =3D smu7_ps-&gt;performance_levels[0]<wbr>=
.memory_clock;<br>
<font color=3D"#888888">--<br>
2.5.5<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></blockquote></div><br></div></div></div>

--94eb2c196cf421e2e2054f4efc96--

--===============0637678384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0637678384==--
