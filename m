From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove duplicated power source update
Date: Thu, 23 Aug 2018 12:58:44 +0000
Message-ID: <BN6PR12MB1809BD70D6B51612F450D5BAF7370@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1535006303-11339-1-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_PSD=jQJcudfmshYHQyRNW6jWKsSqzN4jq7J7823otjzA@mail.gmail.com>,
 <BYAPR12MB2775DA189D7393E5400E3A1DFB370@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0783093185=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2775DA189D7393E5400E3A1DFB370-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0783093185==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BD70D6B51612F450D5BAF7370BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BD70D6B51612F450D5BAF7370BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In that case,

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 23, 2018 8:41:28 AM
To: Alex Deucher
Cc: Wu, Hersen; amd-gfx list
Subject: RE: [PATCH] drm/amdgpu: Remove duplicated power source update

Hi Alex,

We get initial state in amdgpu_device_init.

Best Regards
Rex



> -----Original Message-----
> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Thursday, August 23, 2018 8:37 PM
> To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Wu, Hersen
> <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [PATCH] drm/amdgpu: Remove duplicated power source update
>
> On Thu, Aug 23, 2018 at 2:40 AM Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> >
> > when ac/dc switch, driver will be notified by acpi event.
> > then the power source will be updated. so don't need to get power
> > source when set power state.
>
> Don't we need this to get the initial state?  Maybe we should move this t=
o
> one of the init functions if we don't already check there.
>
> Alex
>
> >
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index daa55fb..3e51e9c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -1933,14 +1933,6 @@ void amdgpu_pm_compute_clocks(struct
> amdgpu_device *adev)
> >                         amdgpu_fence_wait_empty(ring);
> >         }
> >
> > -       mutex_lock(&adev->pm.mutex);
> > -       /* update battery/ac status */
> > -       if (power_supply_is_system_supplied() > 0)
> > -               adev->pm.ac_power =3D true;
> > -       else
> > -               adev->pm.ac_power =3D false;
> > -       mutex_unlock(&adev->pm.mutex);
> > -
> >         if (adev->powerplay.pp_funcs->dispatch_tasks) {
> >                 if (!amdgpu_device_has_dc_support(adev)) {
> >                         mutex_lock(&adev->pm.mutex);
> > --
> > 1.9.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BD70D6B51612F450D5BAF7370BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">In that case, </p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
<b>Sent:</b> Thursday, August 23, 2018 8:41:28 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> Wu, Hersen; amd-gfx list<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Remove duplicated power source upda=
te</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Alex,<br>
<br>
We get initial state in amdgpu_device_init.<br>
<br>
Best Regards<br>
Rex<br>
<br>
&nbsp;<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Thursday, August 23, 2018 8:37 PM<br>
&gt; To: Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Wu, Hersen<br>
&gt; &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Remove duplicated power source update=
<br>
&gt; <br>
&gt; On Thu, Aug 23, 2018 at 2:40 AM Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:=
<br>
&gt; &gt;<br>
&gt; &gt; when ac/dc switch, driver will be notified by acpi event.<br>
&gt; &gt; then the power source will be updated. so don't need to get power=
<br>
&gt; &gt; source when set power state.<br>
&gt; <br>
&gt; Don't we need this to get the initial state?&nbsp; Maybe we should mov=
e this to<br>
&gt; one of the init functions if we don't already check there.<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 8 --------<br>
&gt; &gt;&nbsp; 1 file changed, 8 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; index daa55fb..3e51e9c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; @@ -1933,14 &#43;1933,6 @@ void amdgpu_pm_compute_clocks(struct<b=
r>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_fence_wait_empty(ring);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm=
.mutex);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update battery/ac status=
 */<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (power_supply_is_system_=
supplied() &gt; 0)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;pm.ac_power =3D true;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;pm.ac_power =3D false;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;=
pm.mutex);<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powe=
rplay.pp_funcs-&gt;dispatch_tasks) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_support(adev)) {<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &gt; --<br>
&gt; &gt; 1.9.1<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809BD70D6B51612F450D5BAF7370BN6PR12MB1809namp_--

--===============0783093185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0783093185==--
