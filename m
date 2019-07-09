From: "Abramov, Slava" <Slava.Abramov@amd.com>
Subject: Re: [PATCH] drm/amd/display: avoid 64-bit division
Date: Tue, 9 Jul 2019 16:31:53 +0000
Message-ID: <DM6PR12MB320967C48957C4F2F0E92438FEF10@DM6PR12MB3209.namprd12.prod.outlook.com>
References: <20190708135238.651483-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0514748226=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190708135238.651483-1-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Park, Chris" <Chris.Park@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Francis,
 David" <David.Francis@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Lei,
 Jun" <Jun.Lei@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, "Koo,
 Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0514748226==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB320967C48957C4F2F0E92438FEF10DM6PR12MB3209namp_"

--_000_DM6PR12MB320967C48957C4F2F0E92438FEF10DM6PR12MB3209namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Arnd!


Thanks for bisecting this issue.


I wonder whether you are going to commit your patch or planning to update i=
t and it's still in your work queue.  We have one of our 32-bit builds fail=
ing because of this issue, so that I would like either to fix it or wait to=
 your fix if it has chances to go upstream today.


Sincerely,



Slava Abramov

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Arnd Ber=
gmann <arnd@arndb.de>
Sent: Monday, July 8, 2019 9:52:08 AM
To: Wentland, Harry; Li, Sun peng (Leo); Deucher, Alexander; Koenig, Christ=
ian; Zhou, David(ChunMing); David Airlie; Daniel Vetter
Cc: Liu, Charlene; Park, Chris; Arnd Bergmann; Cheng, Tony; Francis, David;=
 linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org; Cornij, Nikol=
a; Laktyushkin, Dmytro; dri-devel@lists.freedesktop.org; Lei, Jun; Lakha, B=
hawanpreet; Koo, Anthony
Subject: [PATCH] drm/amd/display: avoid 64-bit division

On 32-bit architectures, dividing a 64-bit integer in the kernel
leads to a link error:

ERROR: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__divdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

Change the two recently introduced instances to a multiply+shift
operation that is also much cheaper on 32-bit architectures.
We can do that here, since both of them are really 32-bit numbers
that change a few percent.

Fixes: bedbbe6af4be ("drm/amd/display: Move link functions from dc to dc_li=
nk")
Fixes: f18bc4e53ad6 ("drm/amd/display: update calculated bounding box logic=
 for NV")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index c17db5c144aa..8dbf759eba45 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3072,8 +3072,8 @@ uint32_t dc_link_bandwidth_kbps(
                  * but the difference is minimal and is in a safe directio=
n,
                  * which all works well around potential ambiguity of DP 1=
.4a spec.
                  */
-               long long fec_link_bw_kbps =3D link_bw_kbps * 970LL;
-               link_bw_kbps =3D (uint32_t)(fec_link_bw_kbps / 1000LL);
+               link_bw_kbps =3D mul_u64_u32_shr(BIT_ULL(32) * 970LL / 1000=
,
+                                              link_bw_kbps, 32);
         }
 #endif

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b35327bafbc5..70ac8a95d2db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2657,7 +2657,7 @@ static void update_bounding_box(struct dc *dc, struct=
 _vcs_dpi_soc_bounding_box_
                 calculated_states[i].dram_speed_mts =3D uclk_states[i] * 1=
6 / 1000;

                 // FCLK:UCLK ratio is 1.08
-               min_fclk_required_by_uclk =3D ((unsigned long long)uclk_sta=
tes[i]) * 1080 / 1000000;
+               min_fclk_required_by_uclk =3D mul_u64_u32_shr(BIT_ULL(32) *=
 1080 / 1000000, uclk_states[i], 32);

                 calculated_states[i].fabricclk_mhz =3D (min_fclk_required_=
by_uclk < min_dcfclk) ?
                                 min_dcfclk : min_fclk_required_by_uclk;
--
2.20.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB320967C48957C4F2F0E92438FEF10DM6PR12MB3209namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Arnd!</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks for bisecting this issue.<=
/p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I wonder whether you are going to=
 commit your patch or planning to update it and it's still in your work que=
ue.&nbsp; We have one of our 32-bit builds failing because of this issue, s=
o that I would like either to fix it or
 wait to your fix if it has chances to go upstream today.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Sincerely,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Slava Abramov</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Arnd Bergmann &lt;arnd@arndb.=
de&gt;<br>
<b>Sent:</b> Monday, July 8, 2019 9:52:08 AM<br>
<b>To:</b> Wentland, Harry; Li, Sun peng (Leo); Deucher, Alexander; Koenig,=
 Christian; Zhou, David(ChunMing); David Airlie; Daniel Vetter<br>
<b>Cc:</b> Liu, Charlene; Park, Chris; Arnd Bergmann; Cheng, Tony; Francis,=
 David; linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org; Cornij=
, Nikola; Laktyushkin, Dmytro; dri-devel@lists.freedesktop.org; Lei, Jun; L=
akha, Bhawanpreet; Koo, Anthony<br>
<b>Subject:</b> [PATCH] drm/amd/display: avoid 64-bit division</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 32-bit architectures, dividing a 64-bit integer=
 in the kernel<br>
leads to a link error:<br>
<br>
ERROR: &quot;__udivdi3&quot; [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefin=
ed!<br>
ERROR: &quot;__divdi3&quot; [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefine=
d!<br>
<br>
Change the two recently introduced instances to a multiply&#43;shift<br>
operation that is also much cheaper on 32-bit architectures.<br>
We can do that here, since both of them are really 32-bit numbers<br>
that change a few percent.<br>
<br>
Fixes: bedbbe6af4be (&quot;drm/amd/display: Move link functions from dc to =
dc_link&quot;)<br>
Fixes: f18bc4e53ad6 (&quot;drm/amd/display: update calculated bounding box =
logic for NV&quot;)<br>
Signed-off-by: Arnd Bergmann &lt;arnd@arndb.de&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 &#43;-<br>
&nbsp;2 files changed, 3 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index c17db5c144aa..8dbf759eba45 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -3072,8 &#43;3072,8 @@ uint32_t dc_link_bandwidth_kbps(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * but the difference is minimal and is in a saf=
e direction,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * which all works well around potential ambigui=
ty of DP 1.4a spec.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; long long fec_link_bw_kbps =3D link_bw_kbps * 970LL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_bw_kbps =3D (uint32_t)(fec_link_bw_kbps / 1000LL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; link_bw_kbps =3D mul_u64_u32_shr(BIT_ULL(32) * 970LL / 1000,=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_bw_kbps, 32);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;#endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
index b35327bafbc5..70ac8a95d2db 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
@@ -2657,7 &#43;2657,7 @@ static void update_bounding_box(struct dc *dc, st=
ruct _vcs_dpi_soc_bounding_box_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; calculated_states[i].dram_speed_mts =3D uclk_states[i=
] * 16 / 1000;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; // FCLK:UCLK ratio is 1.08<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; min_fclk_required_by_uclk =3D ((unsigned long long)uclk_states[i=
]) * 1080 / 1000000;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; min_fclk_required_by_uclk =3D mul_u64_u32_shr(BIT_ULL(32) * =
1080 / 1000000, uclk_states[i], 32);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; calculated_states[i].fabricclk_mhz =3D (min_fclk_requ=
ired_by_uclk &lt; min_dcfclk) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_dcfclk : min_fclk_required_b=
y_uclk;<br>
-- <br>
2.20.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB320967C48957C4F2F0E92438FEF10DM6PR12MB3209namp_--

--===============0514748226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0514748226==--
