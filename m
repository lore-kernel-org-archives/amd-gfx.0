From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
Date: Fri, 17 May 2019 16:44:30 +0000
Message-ID: <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0836305734=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
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
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Quan, Evan" <Evan.Quan@amd.com>
Cc: "xiaolinkui@kylinos.cn" <xiaolinkui@kylinos.cn>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0836305734==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800A7AEC22121C8704CBB09870B0SN6PR12MB2800namp_"

--_000_SN6PR12MB2800A7AEC22121C8704CBB09870B0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am going to put more members which are also array after this struct, not =
only obj[].  Looks like this struct_size did not help on multiple array cas=
e. Thanks anyway.
________________________________
From: xiaolinkui <xiaolinkui@kylinos.cn>
Sent: Friday, May 17, 2019 4:46:00 PM
To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airlied@l=
inux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan
Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-k=
ernel@vger.kernel.org; xiaolinkui@kylinos.cn
Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()

[CAUTION: External Email]

Use struct_size() helper to keep code simple.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 22bd21e..4717a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
        if (con)
                return 0;

-       con =3D kmalloc(sizeof(struct amdgpu_ras) +
-                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT=
,
+       con =3D kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
                        GFP_KERNEL|__GFP_ZERO);
        if (!con)
                return -ENOMEM;
--
2.7.4




--_000_SN6PR12MB2800A7AEC22121C8704CBB09870B0SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
I am going to put more members which are also array after this struct, not =
only obj[].&nbsp; Looks like this struct_size did not help on multiple arra=
y case. Thanks anyway.</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> xiaolinkui &lt;xiao=
linkui@kylinos.cn&gt;<br>
<b>Sent:</b> Friday, May 17, 2019 4:46:00 PM<br>
<b>To:</b> Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); ai=
rlied@linux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; =
linux-kernel@vger.kernel.org; xiaolinkui@kylinos.cn<br>
<b>Subject:</b> [PATCH] gpu: drm: use struct_size() in kmalloc()</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">[CAUTION: External Email]<br>
<br>
Use struct_size() helper to keep code simple.<br>
<br>
Signed-off-by: xiaolinkui &lt;xiaolinkui@kylinos.cn&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 &#43;--<br>
&nbsp;1 file changed, 1 insertion(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 22bd21e..4717a64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -1375,8 &#43;1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (con)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con =3D kmalloc(sizeof(struct amdgpu_=
ras) &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct ra=
s_manager) * AMDGPU_RAS_BLOCK_COUNT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con =3D kmalloc(struct_size(con, =
objs, AMDGPU_RAS_BLOCK_COUNT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL|=
__GFP_ZERO);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!con)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -ENOMEM;<br>
--<br>
2.7.4<br>
<br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_SN6PR12MB2800A7AEC22121C8704CBB09870B0SN6PR12MB2800namp_--

--===============0836305734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0836305734==--
