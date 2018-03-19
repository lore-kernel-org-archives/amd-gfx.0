From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 19 Mar 2018 19:01:46 -0400
Message-ID: <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
 <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
 <12178e4c-6b48-2c3b-9970-2ca30624a5bb@gmail.com>
 <29dba5ab-f4f3-551b-ec94-2d6433e8aa21@daenzer.net>
 <1141c511-597e-c81b-6ffd-800ff846f2c1@gmail.com>
 <1b643a78-d86a-b3bf-5f92-089a43201dd5@daenzer.net>
 <06e9160c-b4d4-6c3a-ff9f-04b40b94c7a0@amd.com>
 <BY1PR12MB0504A300C476CC31C59BFE97F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <2c995c37-0d0b-8fde-0118-57d7a62630ef@amd.com>
 <CAAxE2A5kq2oZtJRm2df1fjtb_p1m2_nvCmzv9y8mbO-GS8cGrw@mail.gmail.com>
 <BY1PR12MB0504183ED35A54559D22E041F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <f25ebe1d-0b19-e972-5eba-84570e625456@gmail.com>
 <BY1PR12MB05044A2A50F2580904C8AFB5F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1442304323=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--===============1442304323==
Content-Type: multipart/alternative; boundary="001a113f139ca55b150567cbf333"

--001a113f139ca55b150567cbf333
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In theory, Mesa doesn't have to do anything. It can continue setting VRAM
and if the kernel has to put a display buffer into GTT, it doesn't matter
(for Mesa). Whether the VRAM placement is really used is largely determined
by BO priorities.

The way I understand scather/gather is that it only allows the GTT
placement. It doesn't force the GTT placement. Mesa also doesn't force the
GTT placement.

Marek

On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:

> On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org> wrote:
> >>to my earlier point, there may be cases where it is advantageous to put
> >> display buffers in vram even if s/g display is supported
> >
> > Agreed. That is also why the patch has the options to let user select
> where
> > to put display buffers.
> >
> > As whether to put the option in Mesa or kernel, it seems the difference
> is
> > not much. Also, since amdgpufb can request even without mesa, kernel
> might
> > be a better choice. In addition, putting in the kernel can save client=
=E2=80=99s
> > duplicate work(mesa, ogl, vulkan, 2d, kernel=E2=80=A6)
>
> Why do we even expose different memory pools to the UMDs in the first
> place ;)  Each pool has performance characteristics that may be
> relevant for a particular work load.  Only the UMDs really know the
> finer points of those workloads. In general, you don't want the kernel
> dictating policy if you can avoid it.  The kernel exposes
> functionality and userspace sets the policy.  With the location set in
> userspace, each app/user can have whatever policy makes sense for
> their use case all at the same time without needing to tweak their
> kernel for every use case.
>
> Alex
>

--001a113f139ca55b150567cbf333
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">In t=
heory, Mesa doesn&#39;t have to do anything. It can continue setting VRAM a=
nd if the kernel has to put a display buffer into GTT, it doesn&#39;t matte=
r (for Mesa). Whether the VRAM placement is really used is largely determin=
ed by BO priorities.<br></div><div class=3D"gmail_quote"><br></div><div cla=
ss=3D"gmail_quote">The way I understand scather/gather is that it only allo=
ws the GTT placement. It doesn&#39;t force the GTT placement. Mesa also doe=
sn&#39;t force the GTT placement.<br></div><div class=3D"gmail_quote"><br><=
/div><div class=3D"gmail_quote">Marek<br></div><div class=3D"gmail_quote"><=
br></div><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 5:12 PM, Alex D=
eucher <span dir=3D"ltr">&lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targe=
t=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><span>On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel &lt;<a hr=
ef=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;=
 wrote:<br>
&gt;&gt;to my earlier point, there may be cases where it is advantageous to=
 put<br>
&gt;&gt; display buffers in vram even if s/g display is supported<br>
&gt;<br>
&gt; Agreed. That is also why the patch has the options to let user select =
where<br>
&gt; to put display buffers.<br>
&gt;<br>
&gt; As whether to put the option in Mesa or kernel, it seems the differenc=
e is<br>
&gt; not much. Also, since amdgpufb can request even without mesa, kernel m=
ight<br>
&gt; be a better choice. In addition, putting in the kernel can save client=
=E2=80=99s<br>
&gt; duplicate work(mesa, ogl, vulkan, 2d, kernel=E2=80=A6)<br>
<br>
</span>Why do we even expose different memory pools to the UMDs in the firs=
t<br>
place ;)=C2=A0 Each pool has performance characteristics that may be<br>
relevant for a particular work load.=C2=A0 Only the UMDs really know the<br=
>
finer points of those workloads. In general, you don&#39;t want the kernel<=
br>
dictating policy if you can avoid it.=C2=A0 The kernel exposes<br>
functionality and userspace sets the policy.=C2=A0 With the location set in=
<br>
userspace, each app/user can have whatever policy makes sense for<br>
their use case all at the same time without needing to tweak their<br>
kernel for every use case.<br>
<span class=3D"m_4947926278827078055HOEnZb"><font color=3D"#888888"><br>
Alex</font></span><br></blockquote></div></div></div>

--001a113f139ca55b150567cbf333--

--===============1442304323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1442304323==--
