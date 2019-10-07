From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: unlock on error in smu_resume()
Date: Mon, 7 Oct 2019 10:28:55 +0000
Message-ID: <MN2PR12MB3296695EB3D9799B10971184A29B0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191007090454.GE3865@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0764867736=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191007090454.GE3865@mwanda>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Cc: David Airlie <airlied@linux.ie>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0764867736==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296695EB3D9799B10971184A29B0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296695EB3D9799B10971184A29B0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Dan Carp=
enter <dan.carpenter@oracle.com>
Sent: Monday, October 7, 2019 5:04 PM
To: Rex Zhu <rex.zhu@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Zhou, David(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linu=
x.ie>; kernel-janitors@vger.kernel.org <kernel-janitors@vger.kernel.org>; a=
md-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@lis=
ts.freedesktop.org <dri-devel@lists.freedesktop.org>; Daniel Vetter <daniel=
@ffwll.ch>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christi=
an <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amd/powerplay: unlock on error in smu_resume()

This function needs to drop the mutex before returning.

Fixes: f7e3a5776fa6 ("drm/amd/powerplay: check SMU engine readiness before =
proceeding on S3 resume")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 6a64f765fcd4..f1fbbc8b77ee 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1384,7 +1384,7 @@ static int smu_resume(void *handle)
         ret =3D smu_start_smc_engine(smu);
         if (ret) {
                 pr_err("SMU is not ready yet!\n");
-               return ret;
+               goto failed;
         }

         ret =3D smu_smc_table_hw_init(smu, false);
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296695EB3D9799B10971184A29B0MN2PR12MB3296namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Dan Carpenter &lt;dan.carpent=
er@oracle.com&gt;<br>
<b>Sent:</b> Monday, October 7, 2019 5:04 PM<br>
<b>To:</b> Rex Zhu &lt;rex.zhu@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.co=
m&gt;<br>
<b>Cc:</b> Zhou, David(ChunMing) &lt;David1.Zhou@amd.com&gt;; David Airlie =
&lt;airlied@linux.ie&gt;; kernel-janitors@vger.kernel.org &lt;kernel-janito=
rs@vger.kernel.org&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fre=
edesktop.org&gt;; dri-devel@lists.freedesktop.org &lt;dri-devel@lists.freed=
esktop.org&gt;;
 Daniel Vetter &lt;daniel@ffwll.ch&gt;; Deucher, Alexander &lt;Alexander.De=
ucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: unlock on error in smu_resume()<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This function needs to drop the mutex before retur=
ning.<br>
<br>
Fixes: f7e3a5776fa6 (&quot;drm/amd/powerplay: check SMU engine readiness be=
fore proceeding on S3 resume&quot;)<br>
Signed-off-by: Dan Carpenter &lt;dan.carpenter@oracle.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 6a64f765fcd4..f1fbbc8b77ee 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1384,7 &#43;1384,7 @@ static int smu_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_start_smc_engi=
ne(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SMU is not ready yet!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_table_hw_i=
nit(smu, false);<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296695EB3D9799B10971184A29B0MN2PR12MB3296namp_--

--===============0764867736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0764867736==--
