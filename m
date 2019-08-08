From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Regression] "drm/amdgpu: enable gfxoff again on raven series
 (v2)"
Date: Thu, 8 Aug 2019 15:03:46 +0000
Message-ID: <BN6PR12MB1809CF339E9855E854551552F7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
 <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
 <624BFB8F-B586-492E-BEA6-4B138DAEC831@canonical.com>
 <MN2PR12MB3309680845257BC66644133CECD70@MN2PR12MB3309.namprd12.prod.outlook.com>
 <615a4948-d0f9-46fc-f43e-2025455e9af6@daenzer.net>,
 <MN2PR12MB3309A9960E429AA5B0A8AD19ECD70@MN2PR12MB3309.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0345816301=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3309A9960E429AA5B0A8AD19ECD70-rweVpJHSKTpWdvXm18W95QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0345816301==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809CF339E9855E854551552F7D70BN6PR12MB1809namp_"

--_000_BN6PR12MB1809CF339E9855E854551552F7D70BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Maybe we can check if iommu is enabled in the driver and do the appropriate=
 thing with respect to gfxoff, assuming this is not platform specific.

Alex
________________________________
From: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 8, 2019 4:14 AM
To: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Kai-Heng Feng <kai.heng.feng@cano=
nical.com>; Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>
Cc: Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; LKML <linux-kernel-fy+rA21nqHI@public.gmane.org=
rnel.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
>; Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>; amd-gfx list <amd-gfx@lists.f=
reedesktop.org>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Ch=
ristian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [Regression] "drm/amdgpu: enable gfxoff again on raven series =
(v2)"

> -----Original Message-----
> From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> Sent: Thursday, August 08, 2019 4:10 PM
> To: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Kai-Heng Feng
> <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> Cc: Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; LKML <linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Anthony Wong
> <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>; amd-gfx list <amd-
> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher, Alexander
> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [Regression] "drm/amdgpu: enable gfxoff again on raven serie=
s
> (v2)"
>
> On 2019-08-08 8:29 a.m., Huang, Ray wrote:
> >> From: Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> at 00:03, Huang,
> >> Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org> wrote:
> >>
> >>> May I know the all firmware version in your system?
> >
> > Seems to the issue we encountered with IOMMU enabled. Could you
> please disable iommu in SBIOS or GRUB?
>
> The driver needs to work with the IOMMU enabled. If nothing else, ROCm
> only works with IOMMU I think.
>

Yes. ROCm in APU required IOMMU v2. So far, I am asking Kai-Heng to do some=
 tests to make sure the issue that was encountered by us before. (+ Marek)

Thanks,
Ray

>
> --
> Earthling Michel D=E4nzer               |              https://www.amd.co=
m
> Libre software enthusiast             |             Mesa and X developer

--_000_BN6PR12MB1809CF339E9855E854551552F7D70BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Maybe we can check if iommu is enabled in the driver and do the appropriate=
 thing with respect to gfxoff, assuming this is not platform specific.</div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 8, 2019 4:14 AM<br>
<b>To:</b> Michel D=E4nzer &lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;; Kai-Heng Feng &lt;ka=
i.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;; Olsak, Marek &lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Zhou, David(ChunMing) &lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;; LKML &lt;linu=
x-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel=
@lists.freedesktop.org&gt;; Anthony Wong &lt;anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;=
; amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher,
 Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christi=
an.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [Regression] &quot;drm/amdgpu: enable gfxoff again on r=
aven series (v2)&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: Michel D=E4nzer &lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
&gt; Sent: Thursday, August 08, 2019 4:10 PM<br>
&gt; To: Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Kai-Heng Feng<br>
&gt; &lt;kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;<br>
&gt; Cc: Zhou, David(ChunMing) &lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;; LKML &lt;linux-=
<br>
&gt; kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Anthony W=
ong<br>
&gt; &lt;anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;; amd-gfx list &lt;amd-<br>
&gt; gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian<br>
&gt; &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: [Regression] &quot;drm/amdgpu: enable gfxoff again on rav=
en series<br>
&gt; (v2)&quot;<br>
&gt; <br>
&gt; On 2019-08-08 8:29 a.m., Huang, Ray wrote:<br>
&gt; &gt;&gt; From: Kai-Heng Feng &lt;kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt; at 00=
:03, Huang,<br>
&gt; &gt;&gt; Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; May I know the all firmware version in your system?<br>
&gt; &gt;<br>
&gt; &gt; Seems to the issue we encountered with IOMMU enabled. Could you<b=
r>
&gt; please disable iommu in SBIOS or GRUB?<br>
&gt; <br>
&gt; The driver needs to work with the IOMMU enabled. If nothing else, ROCm=
<br>
&gt; only works with IOMMU I think.<br>
&gt; <br>
<br>
Yes. ROCm in APU required IOMMU v2. So far, I am asking Kai-Heng to do some=
 tests to make sure the issue that was encountered by us before. (&#43; Mar=
ek)<br>
<br>
Thanks,<br>
Ray<br>
<br>
&gt; <br>
&gt; --<br>
&gt; Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://www.amd.com=
">
https://www.amd.com</a><br>
&gt; Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809CF339E9855E854551552F7D70BN6PR12MB1809namp_--

--===============0345816301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0345816301==--
