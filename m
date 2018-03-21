From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 21 Mar 2018 01:08:50 -0400
Message-ID: <CAAxE2A4gcwdGiApoh=sa-SMPtMpm6M2+LmvafhVVnW=kntPPKw@mail.gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
 <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>
 <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0@gmail.com>
 <DM5PR12MB18205326885F0857CEC4FAA6F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
 <7bbc4bc8-1b44-efc3-44b7-47ebcb4b9c76@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0134674721=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7bbc4bc8-1b44-efc3-44b7-47ebcb4b9c76-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--===============0134674721==
Content-Type: multipart/alternative; boundary="001a113fbf5438fbec0567e532f0"

--001a113fbf5438fbec0567e532f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 4:16 PM, Christian K=C3=B6nig <christian.koenig@amd=
.com>
wrote:

> That's what I meant with use up the otherwise unused VRAM. I don't see an=
y
> disadvantage of always setting GTT as second domain on APUs.
>
> My assumption was that we dropped this in userspace for displayable
> surfaces, but Marek proved that wrong.
>
> So what we should do is actually to add GTT as fallback to all BOs on APU=
s
> in Mesa and only make sure that the kernel is capable of handling GTT wit=
h
> optimal performance (e.g. have user huge pages etc..).
>

VRAM|GTT is practically as good as GTT. VRAM with BO priorities and
eviction throttling is the true "VRAM|GTT".

I don't know how else to make use of VRAM intelligently.

Marek

--001a113fbf5438fbec0567e532f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Mar 20, 2018 at 4:16 PM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koenig=
@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_4643584645760816653moz-cite-prefix">That&#39;s what I m=
eant with use up the
      otherwise unused VRAM. I don&#39;t see any disadvantage of always
      setting GTT as second domain on APUs.<br>
      <br>
      My assumption was that we dropped this in userspace for
      displayable surfaces, but Marek proved that wrong.<br>
      <br>
      So what we should do is actually to add GTT as fallback to all BOs
      on APUs in Mesa and only make sure that the kernel is capable of
      handling GTT with optimal performance (e.g. have user huge pages
      etc..).<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></sp=
an></div></div></blockquote><div><br></div><div>VRAM|GTT is practically as =
good as GTT. VRAM with BO priorities and eviction throttling is the true &q=
uot;VRAM|GTT&quot;.<br><br></div><div>I don&#39;t know how else to make use=
 of VRAM intelligently.</div><div><br></div><div>Marek<br></div></div></div=
></div>

--001a113fbf5438fbec0567e532f0--

--===============0134674721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0134674721==--
