From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/3] drm: introduce DRIVER_FORCE_AUTH
Date: Wed, 3 Jul 2019 13:48:15 +0000
Message-ID: <9237e00e-2e10-4961-a759-19f0cb75a1fb@email.android.com>
References: <20190703133104.3211-1-emil.l.velikov@gmail.com>,
 <20190703133104.3211-2-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0740157233=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190703133104.3211-2-emil.l.velikov@gmail.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0740157233==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_9237e00e2e104961a75919f0cb75a1fbemailandroidcom_"

--_000_9237e00e2e104961a75919f0cb75a1fbemailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Well this is still a NAK.

As stated previously please just don't remove DRM_AUTH and keep the functio=
nality as it is.

I absolutely don't see the point to add a new flag to remove the same funct=
ionality a different flag provides.

Christian.

Am 03.07.2019 15:30 schrieb Emil Velikov <emil.l.velikov@gmail.com>:
From: Emil Velikov <emil.velikov@collabora.com>

With earlier commits we've removed DRM_AUTH for driver ioctls annotated
with DRM_AUTH | DRM_RENDER_ALLOW, as the protection it introduces is
effectively not existent.

With next commit, we'll effectively do the same for DRM core.

Yet the AMD developers have voiced concerns that by doing so, developers
working on the closed source user-space driver might remove render node
support.

Since we do _not_ want that to happen, add workaround for those two
drivers

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
Christian, Alex this is the cleaner way to handle AMDGPU/radeon although
if you prefer alternative methods let me know.

Review, acks and others are appreciated, since I'd like to get this
through the drm-misc tree.

Thanks
Emil

Unrelated:
The USE_AGP flag in AMDGPU should be nuked. While for radeon, one can
copy in the driver the 10-20 lines worth of agp_init/release and also
drop the flag.

Bonus points of agp_init code gets a LEGACY check alongside the USE_AGP
one.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/radeon/radeon_drv.c     |  2 +-
 include/drm/drm_drv.h                   | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 8e1b269351e8..cfc2ef11330c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1307,7 +1307,7 @@ amdgpu_get_crtc_scanout_position(struct drm_device *d=
ev, unsigned int pipe,

 static struct drm_driver kms_driver =3D {
         .driver_features =3D
-           DRIVER_USE_AGP | DRIVER_ATOMIC |
+           DRIVER_USE_AGP | DRIVER_ATOMIC | DRIVER_FORCE_AUTH |
             DRIVER_GEM |
             DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ,
         .load =3D amdgpu_driver_load_kms,
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/r=
adeon_drv.c
index 4403e76e1ae0..5a1bfad1ad5e 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -538,7 +538,7 @@ radeon_get_crtc_scanout_position(struct drm_device *dev=
, unsigned int pipe,

 static struct drm_driver kms_driver =3D {
         .driver_features =3D
-           DRIVER_USE_AGP | DRIVER_GEM | DRIVER_RENDER,
+           DRIVER_USE_AGP | DRIVER_GEM | DRIVER_RENDER | DRIVER_FORCE_AUTH=
,
         .load =3D radeon_driver_load_kms,
         .open =3D radeon_driver_open_kms,
         .postclose =3D radeon_driver_postclose_kms,
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b33f2cee2099..5fb2846396bc 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -92,6 +92,16 @@ enum drm_driver_feature {
          * synchronization of command submission.
          */
         DRIVER_SYNCOBJ_TIMELINE         =3D BIT(6),
+       /**
+        * @DRIVER_FORCE_AUTH:
+        *
+        * Driver mandates that DRM_AUTH is honoured, even if the same ioct=
l
+        * is exposed via the render node - aka any of an "authentication" =
is
+        * a fallacy.
+        *
+        * Used only by amdgpu and radeon. Do not use.
+        */
+       DRIVER_FORCE_AUTH               =3D BIT(7),

         /* IMPORTANT: Below are all the legacy flags, add new ones above. =
*/

--
2.21.0


--_000_9237e00e2e104961a75919f0cb75a1fbemailandroidcom_
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
<div dir=3D"auto">Well this is still a NAK.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">As stated previously please just don't remove DRM_AUTH an=
d keep the functionality as it is.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I absolutely don't see the point to add a new flag to rem=
ove the same functionality a different flag provides.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 03.07.2019 15:30 schrieb Emil Velikov &lt;e=
mil.l.velikov@gmail.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">From: Emil Velikov &lt;emil.velikov@collabora.com&=
gt;<br>
<br>
With earlier commits we've removed DRM_AUTH for driver ioctls annotated<br>
with DRM_AUTH | DRM_RENDER_ALLOW, as the protection it introduces is<br>
effectively not existent.<br>
<br>
With next commit, we'll effectively do the same for DRM core.<br>
<br>
Yet the AMD developers have voiced concerns that by doing so, developers<br=
>
working on the closed source user-space driver might remove render node<br>
support.<br>
<br>
Since we do _not_ want that to happen, add workaround for those two<br>
drivers<br>
<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: amd-gfx@lists.freedesktop.org<br>
Cc: Daniel Vetter &lt;daniel@ffwll.ch&gt;<br>
Signed-off-by: Emil Velikov &lt;emil.velikov@collabora.com&gt;<br>
---<br>
Christian, Alex this is the cleaner way to handle AMDGPU/radeon although<br=
>
if you prefer alternative methods let me know.<br>
<br>
Review, acks and others are appreciated, since I'd like to get this<br>
through the drm-misc tree.<br>
<br>
Thanks<br>
Emil<br>
<br>
Unrelated:<br>
The USE_AGP flag in AMDGPU should be nuked. While for radeon, one can<br>
copy in the driver the 10-20 lines worth of agp_init/release and also<br>
drop the flag.<br>
<br>
Bonus points of agp_init code gets a LEGACY check alongside the USE_AGP<br>
one.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/radeon/radeon_drv.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2=
 &#43;-<br>
&nbsp;include/drm/drm_drv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 12 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 8e1b269351e8..cfc2ef11330c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1307,7 &#43;1307,7 @@ amdgpu_get_crtc_scanout_position(struct drm_devic=
e *dev, unsigned int pipe,<br>
&nbsp;<br>
&nbsp;static struct drm_driver kms_driver =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver_features =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_USE_AG=
P | DRIVER_ATOMIC |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_US=
E_AGP | DRIVER_ATOMIC | DRIVER_FORCE_AUTH |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DR=
IVER_GEM |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DR=
IVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load =3D amdgpu_driver_lo=
ad_kms,<br>
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/r=
adeon_drv.c<br>
index 4403e76e1ae0..5a1bfad1ad5e 100644<br>
--- a/drivers/gpu/drm/radeon/radeon_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/radeon/radeon_drv.c<br>
@@ -538,7 &#43;538,7 @@ radeon_get_crtc_scanout_position(struct drm_device =
*dev, unsigned int pipe,<br>
&nbsp;<br>
&nbsp;static struct drm_driver kms_driver =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver_features =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_USE_AG=
P | DRIVER_GEM | DRIVER_RENDER,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_US=
E_AGP | DRIVER_GEM | DRIVER_RENDER | DRIVER_FORCE_AUTH,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load =3D radeon_driver_lo=
ad_kms,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D radeon_driver_op=
en_kms,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .postclose =3D radeon_driv=
er_postclose_kms,<br>
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h<br>
index b33f2cee2099..5fb2846396bc 100644<br>
--- a/include/drm/drm_drv.h<br>
&#43;&#43;&#43; b/include/drm/drm_drv.h<br>
@@ -92,6 &#43;92,16 @@ enum drm_driver_feature {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * synchronization of=
 command submission.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_SYNCOBJ_TIMELINE&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D BIT(6),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @DRIVER_FORCE_AUTH:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver mandates that DRM_=
AUTH is honoured, even if the same ioctl<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is exposed via the render=
 node - aka any of an &quot;authentication&quot; is<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * a fallacy.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Used only by amdgpu and r=
adeon. Do not use.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_FORCE_AUTH&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D BI=
T(7),<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IMPORTANT: Below are al=
l the legacy flags, add new ones above. */<br>
&nbsp;<br>
-- <br>
2.21.0<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_9237e00e2e104961a75919f0cb75a1fbemailandroidcom_--

--===============0740157233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0740157233==--
