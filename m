From: "Abramov, Slava" <Slava.Abramov@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix off-by-one array bounds check
Date: Fri, 28 Jun 2019 15:15:37 +0000
Message-ID: <DM6PR12MB32096A72A966E48A2139FC05FEFC0@DM6PR12MB3209.namprd12.prod.outlook.com>
References: <20190628142402.2771-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0223147492=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190628142402.2771-1-colin.king@canonical.com>
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
To: Colin King <colin.king@canonical.com>, Rex Zhu <rex.zhu@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0223147492==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB32096A72A966E48A2139FC05FEFC0DM6PR12MB3209namp_"

--_000_DM6PR12MB32096A72A966E48A2139FC05FEFC0DM6PR12MB3209namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Slava Abramov <slava.abramov@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Colin Ki=
ng <colin.king@canonical.com>
Sent: Friday, June 28, 2019 10:24:02 AM
To: Rex Zhu; Quan, Evan; Deucher, Alexander; Koenig, Christian; Zhou, David=
(ChunMing); David Airlie; Daniel Vetter; amd-gfx@lists.freedesktop.org; dri=
-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: fix off-by-one array bounds check

From: Colin Ian King <colin.king@canonical.com>

The array bounds check for index is currently off-by-one and should
be using >=3D rather than > on the upper bound. Fix this.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: b3490673f905 ("drm/amd/powerplay: introduce the navi10 pptable imple=
mentation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 27e5c80..f678700 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -210,7 +210,7 @@ static int navi10_workload_map[] =3D {
 static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t inde=
x)
 {
         int val;
-       if (index > SMU_MSG_MAX_COUNT)
+       if (index >=3D SMU_MSG_MAX_COUNT)
                 return -EINVAL;

         val =3D navi10_message_map[index];
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB32096A72A966E48A2139FC05FEFC0DM6PR12MB3209namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, serif, EmojiFont; font-size: 16px;">Acked-by: Sl=
ava Abramov &lt;slava.abramov@amd.com&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Colin King &lt;colin.king@can=
onical.com&gt;<br>
<b>Sent:</b> Friday, June 28, 2019 10:24:02 AM<br>
<b>To:</b> Rex Zhu; Quan, Evan; Deucher, Alexander; Koenig, Christian; Zhou=
, David(ChunMing); David Airlie; Daniel Vetter; amd-gfx@lists.freedesktop.o=
rg; dri-devel@lists.freedesktop.org<br>
<b>Cc:</b> kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org<br=
>
<b>Subject:</b> [PATCH] drm/amd/powerplay: fix off-by-one array bounds chec=
k</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Colin Ian King &lt;colin.king@canonical.com&=
gt;<br>
<br>
The array bounds check for index is currently off-by-one and should<br>
be using &gt;=3D rather than &gt; on the upper bound. Fix this.<br>
<br>
Addresses-Coverity: (&quot;Out-of-bounds read&quot;)<br>
Fixes: b3490673f905 (&quot;drm/amd/powerplay: introduce the navi10 pptable =
implementation&quot;)<br>
Signed-off-by: Colin Ian King &lt;colin.king@canonical.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 27e5c80..f678700 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -210,7 &#43;210,7 @@ static int navi10_workload_map[] =3D {<br>
&nbsp;static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t=
 index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int val;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt; SMU_MSG_MAX_COUNT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D SMU_MSG_MAX_COU=
NT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D navi10_message_map=
[index];<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB32096A72A966E48A2139FC05FEFC0DM6PR12MB3209namp_--

--===============0223147492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0223147492==--
