From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs
Date: Wed, 20 Jun 2018 14:41:04 +0000
Message-ID: <CY4PR12MB13044BA8CF357D8794289827FE770@CY4PR12MB1304.namprd12.prod.outlook.com>
References: <20180620123149.18399-1-tom.stdenis@amd.com>
 <CY4PR12MB13046D5BAB0653158D96EFAAFE770@CY4PR12MB1304.namprd12.prod.outlook.com>,
 <8a588c4f-48d8-4095-9d27-f360bafa3f9b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0425437007=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8a588c4f-48d8-4095-9d27-f360bafa3f9b-5C7GfCeVMHo@public.gmane.org>
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

--===============0425437007==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB13044BA8CF357D8794289827FE770CY4PR12MB1304namp_"

--_000_CY4PR12MB13044BA8CF357D8794289827FE770CY4PR12MB1304namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Should the comment then say 'get the load' instead of 'get the temperature'=
?

________________________________
From: StDenis, Tom
Sent: Wednesday, June 20, 2018 10:39:25 AM
To: Abramov, Slava; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs



On 06/20/2018 10:37 AM, Abramov, Slava wrote:
> I see some functions in amdgpu_pm.c have function level documentation,
> so that it would be good to have this for newly added functions.

Sure I can add some comments/docs.

> Another comment is inline.
>
>
>>From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom St=
 Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>
>  >Sent: Wednesday, June 20, 2018 8:31 AM
>  >To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>  >Cc: StDenis, Tom
>  >Subject: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs
>  >
>  >This adds what should be a stable interface to read GPU
>  >load from userspace.
>  >
>  >Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>  >---
>  > drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 41
> ++++++++++++++++++++++++++++++++++
>  > 1 file changed, 41 insertions(+)
>  >
>  >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>  >index 113edffb5960..d57b414ac228 100644
>  >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>  >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>  >@@ -918,6 +918,37 @@ static ssize_t
> amdgpu_set_pp_power_profile_mode(struct device *dev,
>  >         return -EINVAL;
>  > }
>  >
>  >+static ssize_t amdgpu_get_busy_level(struct device *dev,
>  >+               struct device_attribute *attr,
>  >+               char *buf)
>  >+{
>  >+       struct drm_device *ddev =3D dev_get_drvdata(dev);
>  >+       struct amdgpu_device *adev =3D ddev->dev_private;
>  >+       int r, value, size =3D sizeof(value);
>  >+
>  >+       /* sanity check PP is enabled */
>  >+       if (!(adev->powerplay.pp_funcs &&
>  >+             adev->powerplay.pp_funcs->read_sensor))
>  >+               return -EINVAL;
>  >+
>  >+       /* get the temperature */
>
> Is load is the same thing as temperature?


Nope, there is a separate sensor for that but it is included in hwmon
and Alex would rather not duplicate it.

GPU_LOAD is a value returned by firmware based on the RLC busy status (I
think...).

Tom

--_000_CY4PR12MB13044BA8CF357D8794289827FE770CY4PR12MB1304namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Should the comment then say 'get =
the load' instead of 'get the temperature'?</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> StDenis, Tom<br>
<b>Sent:</b> Wednesday, June 20, 2018 10:39:25 AM<br>
<b>To:</b> Abramov, Slava; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 06/20/2018 10:37 AM, Abramov, Slava wrote:<br>
&gt; I see some functions in amdgpu_pm.c have function level documentation,=
 <br>
&gt; so that it would be good to have this for newly added functions.<br>
<br>
Sure I can add some comments/docs.<br>
<br>
&gt; Another comment is inline.<br>
&gt; <br>
&gt; <br>
&gt;&gt;From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on beha=
lf of Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt;&nbsp; &gt;Sent: Wednesday, June 20, 2018 8:31 AM<br>
&gt;&nbsp; &gt;To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&nbsp; &gt;Cc: StDenis, Tom<br>
&gt;&nbsp; &gt;Subject: [PATCH] drm/amd/amdgpu: Add a GPU_LOAD entry to sys=
fs<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;This adds what should be a stable interface to read GPU<br>
&gt;&nbsp; &gt;load from userspace.<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&nbsp; &gt;---<br>
&gt;&nbsp; &gt; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 41 <br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; &gt; 1 file changed, 41 insertions(&#43;)<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt;&nbsp; &gt;index 113edffb5960..d57b414ac228 100644<br>
&gt;&nbsp; &gt;--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt;&nbsp; &gt;&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt;&nbsp; &gt;@@ -918,6 &#43;918,37 @@ static ssize_t <br>
&gt; amdgpu_set_pp_power_profile_mode(struct device *dev,<br>
&gt;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
&gt;&nbsp; &gt; }<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;&#43;static ssize_t amdgpu_get_busy_level(struct device *dev=
,<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
struct device_attribute *attr,<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
char *buf)<br>
&gt;&nbsp; &gt;&#43;{<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;struct drm_device *ddev =3D =
dev_get_drvdata(dev);<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;struct amdgpu_device *adev =
=3D ddev-&gt;dev_private;<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;int r, value, size =3D sizeo=
f(value);<br>
&gt;&nbsp; &gt;&#43;<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;/* sanity check PP is enable=
d */<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;if (!(adev-&gt;powerplay.pp_=
funcs &amp;&amp;<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;adev-&g=
t;powerplay.pp_funcs-&gt;read_sensor))<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
return -EINVAL;<br>
&gt;&nbsp; &gt;&#43;<br>
&gt;&nbsp; &gt;&#43;&nbsp; &nbsp; &nbsp; &nbsp;/* get the temperature */<br=
>
&gt; <br>
&gt; Is load is the same thing as temperature?<br>
<br>
<br>
Nope, there is a separate sensor for that but it is included in hwmon <br>
and Alex would rather not duplicate it.<br>
<br>
GPU_LOAD is a value returned by firmware based on the RLC busy status (I <b=
r>
think...).<br>
<br>
Tom<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB13044BA8CF357D8794289827FE770CY4PR12MB1304namp_--

--===============0425437007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0425437007==--
