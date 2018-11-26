From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device
 initialization
Date: Mon, 26 Nov 2018 16:02:25 +0000
Message-ID: <BN6PR12MB180989D8B99769C89F6F710FF7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542815518-8124-1-git-send-email-ozeng@amd.com>
 <1542815518-8124-5-git-send-email-ozeng@amd.com>
 <CADnq5_PKauwpBumDu8CigT33vC2QSMUCvTw0wzxd1_11LfoiUg@mail.gmail.com>
 <CADnq5_O-ajV9xMFF5BsKUei48LLY1dGV3C_i+oDy+5J+Y2VwHA@mail.gmail.com>,
 <BN6PR12MB165183EC3AAC7436C0E6846C80D70@BN6PR12MB1651.namprd12.prod.outlook.com>,
 <BN6PR12MB1809D7A7892DC1A246F47750F7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1415131652=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809D7A7892DC1A246F47750F7D70-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1415131652==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180989D8B99769C89F6F710FF7D70BN6PR12MB1809namp_"

--_000_BN6PR12MB180989D8B99769C89F6F710FF7D70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Maybe it would be better to add this as a callback to struct amdgpu_asic_fu=
ncs to avoid adding asic specific code to amdgpu_device.c


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 26, 2018 10:59:02 AM
To: Zeng, Oak; Alex Deucher
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization


Ah, ok.  no problem.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zeng, Oa=
k <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 26, 2018 10:31:04 AM
To: Alex Deucher
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization

Yes, that was my first version. But during debug, I found amdgpu_device_doo=
rbell_init uses adev->doorbell_index.max_assignment which is initialized in=
 *_doorbell_index_init. So I have to call *_doorbell_index_init before amdg=
pu_device_doorbell_init. *_set_ip_blocks() is too late.

In a later version, I moved calling of *_doorbell_index_init to the top of =
amdgpu_device_doorbell_init.

thanks,
Oak

-----Original Message-----
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Sunday, November 25, 2018 1:43 PM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: Fwd: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device in=
itialization

---------- Forwarded message ---------
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, Nov 21, 2018 at 11:21 AM
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization
To: <ozeng-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Oak Zeng <Oak.Zeng-urvtwAKJhsc@public.gmane.org=
m>


On Wed, Nov 21, 2018 at 10:52 AM Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Change-Id: I2f004bbbe2565035460686f4fc16e86b77a2a9b5
> Signed-off-by: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

I think it would be cleaner to add this to the *_set_ip_blocks() functions =
in cik.c, vi.c, and soc15.c so it aligns with the
*_reg_base_init() calls.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cb06e68..a942a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -513,6 +513,13 @@ void amdgpu_device_pci_config_reset(struct amdgpu_de=
vice *adev)
>   */
>  static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)  {
> +       if (adev->asic_type < CHIP_VEGA10)
> +               vi_doorbell_index_init(adev);
> +       else if (adev->asic_type =3D=3D CHIP_VEGA10)
> +               vega10_doorbell_index_init(adev);
> +       else
> +               vega12_doorbell_index_init(adev);
> +
>         /* No doorbell on SI hardware generation */
>         if (adev->asic_type < CHIP_BONAIRE) {
>                 adev->doorbell.base =3D 0;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180989D8B99769C89F6F710FF7D70BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Maybe it would be better to add t=
his as a callback to
<span>struct amdgpu_asic_funcs</span> to avoid adding asic specific code to=
 amdgpu_device.c</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, November 26, 2018 10:59:02 AM<br>
<b>To:</b> Zeng, Oak; Alex Deucher<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on dev=
ice initialization</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Ah, ok.&nbsp; no problem.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Alex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zeng, Oak &lt;Oak.Zeng@amd.=
com&gt;<br>
<b>Sent:</b> Monday, November 26, 2018 10:31:04 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 5/7] drm/amdgpu: Call doorbell index init on dev=
ice initialization</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Yes, that was my first version. But during debug=
, I found amdgpu_device_doorbell_init uses adev-&gt;doorbell_index.max_assi=
gnment which is initialized in *_doorbell_index_init. So I have to call *_d=
oorbell_index_init before amdgpu_device_doorbell_init.
 *_set_ip_blocks() is too late.<br>
<br>
In a later version, I moved calling of *_doorbell_index_init to the top of =
amdgpu_device_doorbell_init.<br>
<br>
thanks,<br>
Oak<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; <br>
Sent: Sunday, November 25, 2018 1:43 PM<br>
To: Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: Fwd: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device in=
itialization<br>
<br>
---------- Forwarded message ---------<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
Date: Wed, Nov 21, 2018 at 11:21 AM<br>
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization<br>
To: &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;, Oak Zeng &lt;Oak.Ze=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<br>
On Wed, Nov 21, 2018 at 10:52 AM Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; Change-Id: I2f004bbbe2565035460686f4fc16e86b77a2a9b5<br>
&gt; Signed-off-by: Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Suggested-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Suggested-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
I think it would be cleaner to add this to the *_set_ip_blocks() functions =
in cik.c, vi.c, and soc15.c so it aligns with the<br>
*_reg_base_init() calls.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 7 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index cb06e68..a942a88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -513,6 &#43;513,13 @@ void amdgpu_device_pci_config_reset(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static int amdgpu_device_doorbell_init(struct amdgpu_device *ade=
v)&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &lt; =
CHIP_VEGA10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vi_doorbell_index_init(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;asic_type =
=3D=3D CHIP_VEGA10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega10_doorbell_index_init(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega12_doorbell_index_init(adev);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No doorbell on SI h=
ardware generation */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type=
 &lt; CHIP_BONAIRE) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.base =3D 0;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB180989D8B99769C89F6F710FF7D70BN6PR12MB1809namp_--

--===============1415131652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1415131652==--
