From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: avoid passing enum as NULL pointer
Date: Thu, 7 Mar 2019 13:43:12 +0000
Message-ID: <BN6PR12MB1809432B5133D15EFCBCA2B1F74C0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190307103454.1637485-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0640650313=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190307103454.1637485-1-arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Cyr, Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Bayan Zabihiyan <Bayan.Zabihiyan-5C7GfCeVMHo@public.gmane.org>, Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Tatla,
 Harmanprit" <Harmanprit.Tatla-5C7GfCeVMHo@public.gmane.org>, "Cheng,
 Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, "Kumarasamy, Sivapiriyan" <Sivapiriyan.Kumarasamy-5C7GfCeVMHo@public.gmane.org>, "Chalmers,
 Kenneth" <Ken.Chalmers-5C7GfCeVMHo@public.gmane.org>

--===============0640650313==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809432B5133D15EFCBCA2B1F74C0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809432B5133D15EFCBCA2B1F74C0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch.  We already have the fix queued:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5.2-wip&id=
=3D672e78cab819ebe31e3b9b8abac367be8a110472

Alex
________________________________
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Sent: Thursday, March 7, 2019 5:34 AM
To: Wentland, Harry; Li, Sun peng (Leo); Deucher, Alexander; Koenig, Christ=
ian; Zhou, David(ChunMing)
Cc: Nick Desaulniers; Arnd Bergmann; David Airlie; Daniel Vetter; Koo, Anth=
ony; Cyr, Aric; Tatla, Harmanprit; Chalmers, Kenneth; Kumarasamy, Sivapiriy=
an; Kees Cook; Bayan Zabihiyan; Cheng, Tony; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;=
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amd/display: avoid passing enum as NULL pointer

The mod_freesync_build_vrr_infopacket() function uses rather obscure
calling conventions, where an enum is passed in through a pointer,
and a NULL pointer is expected to behave the same way as the zero-value
(TRANSFER_FUNC_UNKNOWN).

Trying to build this with clang results in a warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4601:3: error: =
expression which evaluates to zero treated
      as a null pointer constant of type 'const enum color_transfer_func *'=
 [-Werror,-Wnon-literal-null-conversion]

Passing it by value instead of by reference makes the code simpler
and more conventional but should not change the behavior at all.

Fixes: c2791297013e ("drm/amd/display: Add color bit info to freesync infof=
rame")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
 drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/driv=
ers/gpu/drm/amd/display/modules/freesync/freesync.c
index 94a84bc57c7a..6f32fe129880 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -724,7 +724,7 @@ static void build_vrr_infopacket_v1(enum signal_type si=
gnal,

 static void build_vrr_infopacket_v2(enum signal_type signal,
                 const struct mod_vrr_params *vrr,
-               const enum color_transfer_func *app_tf,
+               const enum color_transfer_func app_tf,
                 struct dc_info_packet *infopacket)
 {
         unsigned int payload_size =3D 0;
@@ -732,8 +732,7 @@ static void build_vrr_infopacket_v2(enum signal_type si=
gnal,
         build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
         build_vrr_infopacket_data(vrr, infopacket);

-       if (app_tf !=3D NULL)
-               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
+       build_vrr_infopacket_fs2_data(app_tf, infopacket);

         build_vrr_infopacket_checksum(&payload_size, infopacket);

@@ -757,7 +756,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_frees=
ync *mod_freesync,
                 const struct dc_stream_state *stream,
                 const struct mod_vrr_params *vrr,
                 enum vrr_packet_type packet_type,
-               const enum color_transfer_func *app_tf,
+               const enum color_transfer_func app_tf,
                 struct dc_info_packet *infopacket)
 {
         /* SPD info packet for FreeSync
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drive=
rs/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 4222e403b151..645793b924cf 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_frees=
ync *mod_freesync,
                 const struct dc_stream_state *stream,
                 const struct mod_vrr_params *vrr,
                 enum vrr_packet_type packet_type,
-               const enum color_transfer_func *app_tf,
+               const enum color_transfer_func app_tf,
                 struct dc_info_packet *infopacket);

 void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
--
2.20.0


--_000_BN6PR12MB1809432B5133D15EFCBCA2B1F74C0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for the patch.&nbsp; We already have the fix queued:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5=
.2-wip&amp;id=3D672e78cab819ebe31e3b9b8abac367be8a110472" id=3D"LPlnk729262=
">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5.2-wip&am=
p;id=3D672e78cab819ebe31e3b9b8abac367be8a110472</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Arnd Bergmann &lt;arn=
d@arndb.de&gt;<br>
<b>Sent:</b> Thursday, March 7, 2019 5:34 AM<br>
<b>To:</b> Wentland, Harry; Li, Sun peng (Leo); Deucher, Alexander; Koenig,=
 Christian; Zhou, David(ChunMing)<br>
<b>Cc:</b> Nick Desaulniers; Arnd Bergmann; David Airlie; Daniel Vetter; Ko=
o, Anthony; Cyr, Aric; Tatla, Harmanprit; Chalmers, Kenneth; Kumarasamy, Si=
vapiriyan; Kees Cook; Bayan Zabihiyan; Cheng, Tony; amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amd/display: avoid passing enum as NULL pointer=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The mod_freesync_build_vrr_infopacket() function u=
ses rather obscure<br>
calling conventions, where an enum is passed in through a pointer,<br>
and a NULL pointer is expected to behave the same way as the zero-value<br>
(TRANSFER_FUNC_UNKNOWN).<br>
<br>
Trying to build this with clang results in a warning:<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4601:3: error: =
expression which evaluates to zero treated<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as a null pointer constant of type 'const en=
um color_transfer_func *' [-Werror,-Wnon-literal-null-conversion]<br>
<br>
Passing it by value instead of by reference makes the code simpler<br>
and more conventional but should not change the behavior at all.<br>
<br>
Fixes: c2791297013e (&quot;drm/amd/display: Add color bit info to freesync =
infoframe&quot;)<br>
Signed-off-by: Arnd Bergmann &lt;arnd-r2nGTMty4D4@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 &#43;&#43=
;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h&nbsp; | 2 &#43=
;-<br>
&nbsp;2 files changed, 4 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/driv=
ers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
index 94a84bc57c7a..6f32fe129880 100644<br>
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<b=
r>
@@ -724,7 &#43;724,7 @@ static void build_vrr_infopacket_v1(enum signal_typ=
e signal,<br>
&nbsp;<br>
&nbsp;static void build_vrr_infopacket_v2(enum signal_type signal,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct mod_vrr_params *vrr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const enum color_transfer_func *app_tf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const enum color_transfer_func app_tf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_info_packet *infopacket)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int payload_size =
=3D 0;<br>
@@ -732,8 &#43;732,7 @@ static void build_vrr_infopacket_v2(enum signal_typ=
e signal,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_vrr_infopacket_heade=
r_v2(signal, infopacket, &amp;payload_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_vrr_infopacket_data(=
vrr, infopacket);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (app_tf !=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; build_vrr_infopacket_fs2_data(*app_tf, infopacket);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_vrr_infopacket_fs2_data(app=
_tf, infopacket);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_vrr_infopacket_check=
sum(&amp;payload_size, infopacket);<br>
&nbsp;<br>
@@ -757,7 &#43;756,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_f=
reesync *mod_freesync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct dc_stream_state *stream,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct mod_vrr_params *vrr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum vrr_packet_type packet_type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const enum color_transfer_func *app_tf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const enum color_transfer_func app_tf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_info_packet *infopacket)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SPD info packet for Fre=
eSync<br>
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drive=
rs/gpu/drm/amd/display/modules/inc/mod_freesync.h<br>
index 4222e403b151..645793b924cf 100644<br>
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h<br=
>
@@ -145,7 &#43;145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_f=
reesync *mod_freesync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct dc_stream_state *stream,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct mod_vrr_params *vrr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum vrr_packet_type packet_type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const enum color_transfer_func *app_tf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const enum color_transfer_func app_tf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_info_packet *infopacket);<br>
&nbsp;<br>
&nbsp;void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,=
<br>
-- <br>
2.20.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809432B5133D15EFCBCA2B1F74C0BN6PR12MB1809namp_--

--===============0640650313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0640650313==--
