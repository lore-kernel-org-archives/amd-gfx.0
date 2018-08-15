From: =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub-tTKE4kgLzBBAfugRpC6u6w@public.gmane.org>
Subject: Re: Making a GDS Allocation for NGG
Date: Wed, 15 Aug 2018 14:33:09 +0200
Message-ID: <CADTJRYe5e83_DOh8S_W=ZLgHkoGEneUHv0CpA+X0HAfRfe_TOQ@mail.gmail.com>
References: <CADTJRYdMXzoFN75JF9VBcWmB+ee85PQFJ6UsCKC=Pep4sJUN4Q@mail.gmail.com>
 <DM5PR12MB15291FF96F65867EC066903FAB3F0@DM5PR12MB1529.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271420544=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB15291FF96F65867EC066903FAB3F0-2J9CzHegvk9c1F9zY4ibCgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Jin, Jian-Rong" <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1271420544==
Content-Type: multipart/alternative; boundary="00000000000020e30005737888c1"

--00000000000020e30005737888c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jian-Rong,

Will gfx9 get support from KMD and LLPC by the time gfx10 releases, or is
it only going to be a gfx10-and-forward feature?

If not, is there something missing in gfx9 hardware? Are you allowed to say=
?

Thanks,
Jakub

On Wed, 15 Aug 2018 at 08:36 Jin, Jian-Rong <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Jakub=E3=80=82
> Both KMD and LLPC are not ready to support NGG for gfx9. We are going to
> support NGG in amdvlk for next generation GPU.
>
> Thanks
> Jian-Rong JIN
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Jakub
> Oko=C5=84ski
> Sent: 2018=E5=B9=B48=E6=9C=8814=E6=97=A5 21:31
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Making a GDS Allocation for NGG
>
> Hi folks,
>
> I was trying to play around with NGG on Vega using the open source AMDVLK
> stack.
> After fetching all the code, I disabled an override in PAL, under
> gfx9SettingsLoader.cpp that disables the NGG setting. I've put a new opti=
on
> in my
> amdPalSettings.cfg: `NggMode,7` and that was enough to enable it.
>
> When I ran a small vulkan application, it crashed with a "Not implemented=
"
> error in Pal::Linux::Device::AllocateGds. The comment there says:
>
>     // TODO: implement it once amdgpu is ready.
>
> I couldn't find anything specific to GDS allocation in upstream kernel, s=
o
> I looked at agd5f/amd-staging-drm-next and found some code related to
> AMDGPU_GEM_DOMAIN_GDS and allocating a bo object. This is in
> amdgpu_gem_create_ioctl, so I think it's accessible to userspace, with a
> small change in libdrm, probably.
>
> Is this what is needed to make a GDS allocation that NGG would accept, or
> is it unrelated? Do you know if there are any other blockers for NGG
> besides this?
>
> Regards,
> Jakub
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000020e30005737888c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Jian-Rong,</div><div><br></div><div>Will gfx9 get=
 support from KMD and LLPC by the time gfx10 releases, or is it only going =
to be a gfx10-and-forward feature?</div><div><br></div><div>If not, is ther=
e something missing in gfx9 hardware? Are you allowed to say?<br></div><div=
><br></div><div>Thanks,</div><div>Jakub<br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr">On Wed, 15 Aug 2018 at 08:36 Jin, Jian-Rong &lt;<a hr=
ef=3D"mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Jakub=E3=80=82<b=
r>
Both KMD and LLPC are not ready to support NGG for gfx9. We are going to su=
pport NGG in amdvlk for next generation GPU.<br>
<br>
Thanks<br>
Jian-Rong JIN<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" =
target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf O=
f Jakub Oko=C5=84ski<br>
Sent: 2018=E5=B9=B48=E6=9C=8814=E6=97=A5 21:31<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
Subject: Making a GDS Allocation for NGG<br>
<br>
Hi folks,<br>
<br>
I was trying to play around with NGG on Vega using the open source AMDVLK s=
tack.<br>
After fetching all the code, I disabled an override in PAL, under gfx9Setti=
ngsLoader.cpp that disables the NGG setting. I&#39;ve put a new option in m=
y<br>
amdPalSettings.cfg: `NggMode,7` and that was enough to enable it.<br>
<br>
When I ran a small vulkan application, it crashed with a &quot;Not implemen=
ted&quot; error in Pal::Linux::Device::AllocateGds. The comment there says:=
<br>
<br>
=C2=A0 =C2=A0 // TODO: implement it once amdgpu is ready.<br>
<br>
I couldn&#39;t find anything specific to GDS allocation in upstream kernel,=
 so I looked at agd5f/amd-staging-drm-next and found some code related to A=
MDGPU_GEM_DOMAIN_GDS and allocating a bo object. This is in amdgpu_gem_crea=
te_ioctl, so I think it&#39;s accessible to userspace, with a small change =
in libdrm, probably.<br>
<br>
Is this what is needed to make a GDS allocation that NGG would accept, or i=
s it unrelated? Do you know if there are any other blockers for NGG besides=
 this?<br>
<br>
Regards,<br>
Jakub<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div></div>

--00000000000020e30005737888c1--

--===============1271420544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1271420544==--
