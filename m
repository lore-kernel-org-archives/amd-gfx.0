From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vcn:Fix uninitialized symbol error
Date: Tue, 16 Oct 2018 15:19:35 +0000
Message-ID: <BN6PR12MB1809EBD647ABAD25213B00A5F7FE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1539699282-2266-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0221723276=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1539699282-2266-1-git-send-email-James.Zhu@amd.com>
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
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "jzhums@gmail.com" <jzhums@gmail.com>, "kbuild@01.org" <kbuild@01.org>, "kbuild-all@01.org" <kbuild-all@01.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0221723276==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809EBD647ABAD25213B00A5F7FE0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809EBD647ABAD25213B00A5F7FE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhu, Jam=
es <James.Zhu@amd.com>
Sent: Tuesday, October 16, 2018 10:15:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: jzhums@gmail.com; dri-devel@lists.freedesktop.org; kbuild@01.org; kbuil=
d-all@01.org; dan.carpenter@oracle.com
Subject: [PATCH] drm/amdgpu/vcn:Fix uninitialized symbol error

ret_code should be initialized with 0. The check of read/write
ptr should be activate when UVD_POWER_STATUS_TILES is off.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index bc64706..eae9092 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1165,14 +1165,14 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_dev=
ice *adev)

 static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
 {
-       int ret_code;
+       int ret_code =3D 0;

         /* Wait for power status to be UVD_POWER_STATUS__UVD_POWER_STATUS_=
TILES_OFF */
         SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
                         UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF,
                         UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code)=
;

-       if (ret_code) {
+       if (!ret_code) {
                 int tmp =3D RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR) & 0x7F=
FFFFFF;
                 /* wait for read ptr to be equal to write ptr */
                 SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFF=
FFF, ret_code);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809EBD647ABAD25213B00A5F7FE0BN6PR12MB1809namp_
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
der.deucher@amd.com&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhu, James &lt;James.Zhu@amd.=
com&gt;<br>
<b>Sent:</b> Tuesday, October 16, 2018 10:15:01 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> jzhums@gmail.com; dri-devel@lists.freedesktop.org; kbuild@01.org=
; kbuild-all@01.org; dan.carpenter@oracle.com<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn:Fix uninitialized symbol error</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">ret_code should be initialized with 0. The check o=
f read/write<br>
ptr should be activate when UVD_POWER_STATUS_TILES is off.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c<br>
index bc64706..eae9092 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
@@ -1165,14 &#43;1165,14 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu=
_device *adev)<br>
&nbsp;<br>
&nbsp;static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret_code;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret_code =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status t=
o be UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(UVD, 0,=
 mmUVD_POWER_STATUS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_P=
OWER_STATUS__UVD_POWER_STATUS_TILES_OFF,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_P=
OWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret_code) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret_code) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int tmp =3D RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR) &=
amp; 0x7FFFFFFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* wait for read ptr to be equal to write ptr */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RBC_RB_RPTR, tmp, 0x=
FFFFFFFF, ret_code);<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809EBD647ABAD25213B00A5F7FE0BN6PR12MB1809namp_--

--===============0221723276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0221723276==--
