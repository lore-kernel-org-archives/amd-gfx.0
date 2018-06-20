From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs
Date: Wed, 20 Jun 2018 14:37:23 +0000
Message-ID: <CY4PR12MB13046D5BAB0653158D96EFAAFE770@CY4PR12MB1304.namprd12.prod.outlook.com>
References: <20180620123149.18399-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1652835513=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180620123149.18399-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1652835513==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB13046D5BAB0653158D96EFAAFE770CY4PR12MB1304namp_"

--_000_CY4PR12MB13046D5BAB0653158D96EFAAFE770CY4PR12MB1304namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I see some functions in amdgpu_pm.c have function level documentation, so t=
hat it would be good to have this for newly added functions.


Another comment is inline.


>From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom St =
Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

>Sent: Wednesday, June 20, 2018 8:31 AM
>To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>Cc: StDenis, Tom
>Subject: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs
>
>This adds what should be a stable interface to read GPU
>load from userspace.
>
>Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 41 +++++++++++++++++++++++++++++=
+++++
> 1 file changed, 41 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_pm.c
>index 113edffb5960..d57b414ac228 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>@@ -918,6 +918,37 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struc=
t device *dev,
>         return -EINVAL;
> }
>
>+static ssize_t amdgpu_get_busy_level(struct device *dev,
>+               struct device_attribute *attr,
>+               char *buf)
>+{
>+       struct drm_device *ddev =3D dev_get_drvdata(dev);
>+       struct amdgpu_device *adev =3D ddev->dev_private;
>+       int r, value, size =3D sizeof(value);
>+
>+       /* sanity check PP is enabled */
>+       if (!(adev->powerplay.pp_funcs &&
>+             adev->powerplay.pp_funcs->read_sensor))
>+               return -EINVAL;
>+
>+       /* get the temperature */

Is load is the same thing as temperature?

[snap]


Slava A

--_000_CY4PR12MB13046D5BAB0653158D96EFAAFE770CY4PR12MB1304namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 12pt;">=
I see some functions in amdgpu_pm.c have function level documentation, so t=
hat it would be good to have this for newly added functions.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 12pt;">=
<br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 12pt;">=
Another comment is inline.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 12pt;">=
&gt;From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf o=
f Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>&gt;Sent: Wednesday, June 20, 2018 8:31 AM</div>
<div>&gt;To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</div>
<div>&gt;Cc: StDenis, Tom</div>
<div>&gt;Subject: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs</di=
v>
<div>&gt;&nbsp;</div>
<div>&gt;This adds what should be a stable interface to read GPU</div>
<div>&gt;load from userspace.</div>
<div>&gt;</div>
<div>&gt;Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div>&gt;---</div>
<div>&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 41 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<=
/div>
<div>&gt; 1 file changed, 41 insertions(&#43;)</div>
<div>&gt;</div>
<div>&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_pm.c</div>
<div>&gt;index 113edffb5960..d57b414ac228 100644</div>
<div>&gt;--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c</div>
<div>&gt;&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c</div>
<div>&gt;@@ -918,6 &#43;918,37 @@ static ssize_t amdgpu_set_pp_power_profil=
e_mode(struct device *dev,</div>
<div>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;</div>
<div>&gt; }</div>
<div>&gt;&nbsp;</div>
<div>&gt;&#43;static ssize_t amdgpu_get_busy_level(struct device *dev,</div=
>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct=
 device_attribute *attr,</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char *=
buf)</div>
<div>&gt;&#43;{</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;struct drm_device *ddev =3D dev_ge=
t_drvdata(dev);</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;struct amdgpu_device *adev =3D dde=
v-&gt;dev_private;</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;int r, value, size =3D sizeof(valu=
e);</div>
<div>&gt;&#43;</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;/* sanity check PP is enabled */</=
div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;if (!(adev-&gt;powerplay.pp_funcs =
&amp;&amp;</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;adev-&gt;powe=
rplay.pp_funcs-&gt;read_sensor))</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return=
 -EINVAL;</div>
<div>&gt;&#43;</div>
<div>&gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;/* get the temperature */</div>
<div><br>
</div>
<div>Is load is the same thing as temperature?</div>
<div><br>
</div>
<div>[snap]</div>
<div><br>
</div>
<div><br>
</div>
<div>Slava A</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB13046D5BAB0653158D96EFAAFE770CY4PR12MB1304namp_--

--===============1652835513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1652835513==--
