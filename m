From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 19 Mar 2018 16:26:59 -0400
Message-ID: <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0193380322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--===============0193380322==
Content-Type: multipart/alternative; boundary="00000000000016f6500567c9ca13"

--00000000000016f6500567c9ca13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When Mesa wants a buffer in VRAM, it always sets VRAM. It relies on BO move
throttling to prevent unnecessary BO moves.

My questions are:
- what should Mesa do differently for tiny VRAM?
- what is a tiny VRAM?
- if VRAM is tiny, which allocations should we put there?

Marek

On Mon, Mar 19, 2018 at 4:15 PM, Deucher, Alexander <
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:

> s/not/now/.  I meant to say, =E2=80=9Cwe have NOW excluded the possibilit=
y of
> ever setting displays anywhere else without a kernel update=E2=80=9D.
>
>
>
> Alex
>
>
>
> *From:* amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On Behalf
> Of *Deucher, Alexander
> *Sent:* Monday, March 19, 2018 4:13 PM
>
> *To:* Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <
> Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Cc:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Michel D=C3=A4nzer <
> michel-otUistvHUpPR7s880joybQ@public.gmane.org>; amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
> support
>
>
>
> I'm not sure what you mean by the 3 scenarios.  Generally userspace
> selects what domains it wants a buffer to be in, vram, gtt, or both (don'=
t
> care).  I'd rather not have the kernel second guess the UMDs if we can he=
lp
> it.  I'd rather leave the kernel for cases where we have to force things
> due to hw bugs, or hw restrictions, etc.  If we force all display buffers
> to be in gtt in the kernel, we have not excluded the possibility of ever
> setting displays anywhere else without a kernel update.  E.g., to my
> earlier point, there may be cases where it is advantageous to put display
> buffers in vram even if s/g display is supported.  That was the point I w=
as
> trying to make about user mode selecting the domain (vram of gtt or
> vram|gtt).  Say you have a board with 2 GB of ram and 1 GB is carved out
> for "vram".  In that case, it would make sense to put the buffer in vram
> because otherwise you are wasting a comparatively scarce resource.
>
>
>
> Alex
> ------------------------------
>
> *From:* Li, Samuel
> *Sent:* Monday, March 19, 2018 3:58:52 PM
> *To:* Deucher, Alexander; Koenig, Christian; Marek Ol=C5=A1=C3=A1k
> *Cc:* Alex Deucher; Michel D=C3=A4nzer; amd-gfx list
> *Subject:* RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
> support
>
>
>
> Alex,
>
>
>
> I assume you are talking the three scenarios here, 1)VRAM, 2)GTT,
> 3)VRAM/GTT.
>
> But kernel will need the decision too(amdgpufb). I think it shall be
> better to do it in kernel, instead of different clients(mesa, ddx, kernel=
 =E2=80=A6)
>
>
>
> Regards,
>
> Samuel Li
>
>
>
> *From:* Deucher, Alexander
> *Sent:* Monday, March 19, 2018 3:54 PM
> *To:* Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <
> Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Cc:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Michel D=C3=A4nzer <
> michel-otUistvHUpPR7s880joybQ@public.gmane.org>; amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
> support
>
>
>
> My personal preference is still to plumb this through to mesa rather than
> forcing it in the kernel.
>
>
>
> Alex
> ------------------------------
>
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Li,
> Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Monday, March 19, 2018 3:50:34 PM
> *To:* Koenig, Christian; Marek Ol=C5=A1=C3=A1k
> *Cc:* Alex Deucher; Michel D=C3=A4nzer; amd-gfx list
> *Subject:* RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
> support
>
>
>
> Christian,
>
>
>
> You misunderstood Alex=E2=80=99s comments,
>
>
>
> >Regardless of which scenarios we need to support, I think we also need
>
> >to really plumb this through to mesa however since user space is who
>
> >ultimately requests the location.  Overriding it in the kernel gets
>
> >tricky and can lead to ping-ponging as others have noted.  Better to
>
>
>
> Here Alex mentioned the scenarios is 1)VRAM, 2)GTT, 3)VRAM/GTT.
>
> His concern is this might cause ping-pong, not about preferred domain.
> Since preferred domain can solve the ping-pong issue, it shall address hi=
s
> concern here.
>
>
>
> Regards,
>
> Samuel Li
>
>
>
> *From:* Christian K=C3=B6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>]
> *Sent:* Monday, March 19, 2018 3:45 PM
> *To:* Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com>;
> Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> *Cc:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Michel D=C3=A4nzer <
> michel-otUistvHUpPR7s880joybQ@public.gmane.org>; amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
> support
>
>
>
> Quoting Alex:
>
> Regardless of which scenarios we need to support, I think we also need
>
> to really plumb this through to mesa however since user space is who
>
> ultimately requests the location.  Overriding it in the kernel gets
>
> tricky and can lead to ping-ponging as others have noted.  Better to
>
> have user space know what chips support it or not and request display
>
> buffers in GTT or VRAM from the start.
>
> And I completely agree with Alex here. So overriding the domain in the
> kernel is a serious NAK from my side as well.
>
> Please implement the necessary bits in Mesa, shouldn't be more than a few
> lines of code anyway.
>
> Regards,
> Christian.
>
> Am 19.03.2018 um 20:42 schrieb Li, Samuel:
>
> Agreed.
>
>
>
> >I think that the consensus with Alex and me is that we should avoid
> exactly that.
> Christian, Alex=E2=80=99s concern is about ping-pong, not about the prefe=
rred
> domain.
>
> Regards,
>
> Samuel Li
>
>
>
> *From:* Marek Ol=C5=A1=C3=A1k [mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
]
> *Sent:* Monday, March 19, 2018 3:39 PM
> *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> *Cc:* Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org> <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Michel D=C3=A4n=
zer
> <michel-otUistvHUpPR7s880joybQ@public.gmane.org> <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Alex Deucher
> <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx list
> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
> support
>
>
>
> On Mon, Mar 19, 2018 at 3:27 PM, Christian K=C3=B6nig <christian.koenig@a=
md.com>
> wrote:
>
> I think that the consensus with Alex and me is that we should avoid
> exactly that.
>
> Overriding the preferred domain in the kernel is a no-go for that patch
> set, so please implement the discussed changes in Mesa.
>
>
>
> I don't see how Mesa can make a smarter decision than the kernel. If you
> overwrite the preferred domain of the buffer in the kernel, there will be
> no ping-ponging between domains. Mesa never changes the initial preferred
> domain.
>
>
>
> Marek
>
>
>
>
>
>
> Regards,
> Christian.
>
>
>
> Am 19.03.2018 um 20:22 schrieb Li, Samuel:
>
> I agree with Marek/Michel: since kernel sets the domain before scanning
> out, it shall update the preferred domain here too.
>
> Regards,
> Samuel Li
>
> -----Original Message-----
> From: Koenig, Christian
> Sent: Thursday, March 08, 2018 4:07 AM
> To: Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Li, Samuel
> <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display suppor=
t
>
> Am 08.03.2018 um 09:35 schrieb Michel D=C3=A4nzer:
>
> On 2018-03-07 10:47 AM, Christian K=C3=B6nig wrote:
>
> Am 07.03.2018 um 09:42 schrieb Michel D=C3=A4nzer:
>
> On 2018-03-06 07:23 PM, Christian K=C3=B6nig wrote:
>
> E.g. the last time I tested it placing things into GTT still
> resulted in quite a performance penalty for rendering.
>
> FWIW, I think the penalty is most likely IOMMU related. Last time I
> tested, I couldn't measure a big difference with IOMMU disabled.
>
> No, the penalty I'm talking about came from the ping/pong we did with
> the scanout buffers.
>
> See when I tested this the DDX and Mesa where unmodified, so both
> still assumed VRAM as placement for scanout BOs, but the kernel
> forced scanout BOs into GTT for testing.
>
> So what happened was that on scanout we moved the VRAM BO to GTT
>
> and
>
> after unpinning it on the first command submission which used the BO
> we moved it back to VRAM again.
>
> In the meantime, I've had the same idea as Marek: Can't the kernel
> driver simply change the BO's preferred domain to GTT when scanning
> out from it? Then it won't move back to VRAM.
>
> Yes, I've considered this as well.
>
> But I think making the decision in Mesa is the cleaner approach.
>
> E.g. so far we only override the placement decision of userspace for two
> reasons:
> 1. We where running out of memory in VRAM.
> 2. We have a hardware restriction which makes VRAM usage mandatory.
>
> And even then we never adjust the placement permanently, we just
> temporary moved the buffer where it was needed and moved it back after
> the operation completed.
>
> Additional to that Mesa might want to set even more flags and/or changes
> it's behavior. E.g. use a tilling mode which both importer and export in =
an
> A+A laptop understands etc...
>
> Regards,
> Christian.
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
>
> _______________________________________________
>
> amd-gfx mailing list
>
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>

--00000000000016f6500567c9ca13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>When Mesa wants a buffer in VRAM, it always sets VRAM=
. It relies on BO move throttling to prevent unnecessary BO moves.<br></div=
><div><br></div><div>My questions are:</div><div>- what should Mesa do diff=
erently for tiny VRAM?</div><div>- what is a tiny VRAM?</div><div>- if VRAM=
 is tiny, which allocations should we put there?<br></div><div><br></div>Ma=
rek<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On M=
on, Mar 19, 2018 at 4:15 PM, Deucher, Alexander <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Alexander.Deucher=
@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div link=3D"blue" vlink=3D"purple" lang=3D"EN-US">
<div class=3D"m_-7819403152211467846WordSection1">
<p class=3D"MsoNormal">s/not/now/.=C2=A0 I meant to say, =E2=80=9C<span sty=
le=3D"font-size:12.0pt;color:black">we have NOW excluded the possibility of=
 ever setting displays anywhere else without a kernel update=E2=80=9D.<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><u></u><u></u></p>
<p class=3D"MsoNormal"><a name=3D"m_-7819403152211467846__MailEndCompose"><=
u></u>=C2=A0<u></u></a></p>
<span></span>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx [mailto:<a href=3D"mailto:amd-g=
fx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-bounces@lists.<=
wbr>freedesktop.org</a>]
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Monday, March 19, 2018 4:13 PM</p><div><div class=3D"h5"><br>
<b>To:</b> Li, Samuel &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_b=
lank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Ch=
ristian.Koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;=
 Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;; Michel D=C3=A4nzer &lt;<a href=
=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;=
; amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><wbr>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport<u></u><u></u></div></div><p></p>
</div>
</div><div><div class=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div id=3D"m_-7819403152211467846divtagdefaultwrapper">
<p><span style=3D"color:black">I&#39;m not sure what you mean by the 3 scen=
arios.=C2=A0 Generally userspace selects what domains it wants a buffer to =
be in, vram, gtt, or both (don&#39;t care).=C2=A0=C2=A0I&#39;d rather not h=
ave the kernel second guess the UMDs if we can help it.=C2=A0 I&#39;d
 rather leave the kernel for cases where we have to force things due to hw =
bugs, or hw restrictions, etc.=C2=A0 If we force all display buffers to be =
in gtt in the kernel, we have not excluded the possibility of ever setting =
displays anywhere else without a kernel
 update.=C2=A0 E.g., to my earlier point, there may be cases where it is ad=
vantageous to put display buffers in vram even if s/g display is supported.=
=C2=A0 That was the point I was trying to make about user mode selecting th=
e domain (vram of gtt or vram|gtt).=C2=A0 Say you
 have a board with 2 GB of ram and 1 GB is carved out for &quot;vram&quot;.=
=C2=A0 In that case, it would make sense to put the buffer in vram because =
otherwise you are wasting a comparatively scarce resource.<u></u><u></u></s=
pan></p>
<p><span style=3D"color:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"color:black">Alex<u></u><u></u></span></p>
</div>
<div class=3D"MsoNormal" style=3D"text-align:center" align=3D"center">
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div id=3D"m_-7819403152211467846divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Li, Samuel<br>
<b>Sent:</b> Monday, March 19, 2018 3:58:52 PM<br>
<b>To:</b> Deucher, Alexander; Koenig, Christian; Marek Ol=C5=A1=C3=A1k<br>
<b>Cc:</b> Alex Deucher; Michel D=C3=A4nzer; amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span>
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
</div>
<div>
<div>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">Alex,</span><u=
></u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">=C2=A0</span><=
u></u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">I assume you a=
re talking the three scenarios here, 1)VRAM, 2)GTT, 3)VRAM/GTT.</span><u></=
u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">But kernel wil=
l need the decision too(amdgpufb). I think it shall be better to do it in k=
ernel, instead of different clients(mesa, ddx, kernel =E2=80=A6)</span><u><=
/u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">=C2=A0</span><=
u></u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">Regards,</span=
><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">Samuel Li</spa=
n><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xmsonormal"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2f5496">=C2=A0</span><=
u></u><u></u></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"m_-7819403152211467846xmsonormal"><b><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> Deucher=
, Alexander
<br>
<b>Sent:</b> Monday, March 19, 2018 3:54 PM<br>
<b>To:</b> Li, Samuel &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_b=
lank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Ch=
ristian.Koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;=
 Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;; Michel D=C3=A4nzer &lt;<a href=
=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;=
; amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><wbr>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span><u></u><u></u></p>
</div>
</div>
<p class=3D"m_-7819403152211467846xmsonormal">=C2=A0<u></u><u></u></p>
<div id=3D"m_-7819403152211467846x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">M=
y personal preference is still to plumb this through to mesa rather than fo=
rcing it in the kernel.</span><u></u><u></u></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">=
=C2=A0</span><u></u><u></u></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">A=
lex</span><u></u><u></u></p>
</div>
<div class=3D"MsoNormal" style=3D"text-align:center" align=3D"center"><span=
 style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,serif">
<hr width=3D"98%" size=3D"2" align=3D"center">
</span></div>
<div id=3D"m_-7819403152211467846x_divRplyFwdMsg">
<p class=3D"m_-7819403152211467846xmsonormal"><b><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span><=
/b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org" target=3D"_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>=
&gt;
 on behalf of Li, Samuel &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D=
"_blank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, March 19, 2018 3:50:34 PM<br>
<b>To:</b> Koenig, Christian; Marek Ol=C5=A1=C3=A1k<br>
<b>Cc:</b> Alex Deucher; Michel D=C3=A4nzer; amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span>
<u></u><u></u></p>
<div>
<p class=3D"m_-7819403152211467846xmsonormal">=C2=A0<u></u><u></u></p>
</div>
</div>
<div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Christian,</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">You misunderstood Alex=E2=80=99s comments,</span><u></u><u></=
u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<pre style=3D"background:white">&gt;Regardless of which scenarios we need t=
o support, I think we also need<u></u><u></u></pre>
<pre style=3D"background:white">&gt;to really plumb this through to mesa ho=
wever since user space is who<u></u><u></u></pre>
<pre style=3D"background:white">&gt;ultimately requests the location.=C2=A0=
 Overriding it in the kernel gets<u></u><u></u></pre>
<pre style=3D"background:white">&gt;tricky and can lead to ping-ponging as =
others have noted.=C2=A0 Better to<u></u><u></u></pre>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Here Alex mentioned the scenarios is 1)VRAM, 2)GTT, 3)VRAM/GT=
T.</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">His concern is this might cause ping-pong, not about preferre=
d domain. Since preferred domain can solve the ping-pong issue, it shall
 address his concern here.</span><u></u><u></u></p>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Regards,</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Samuel Li</span><u></u><u></u></p>
</div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:windowtext">From:</span></b><span style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif;color:windowtext"> Christian K=C3=B6nig=
 [<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">mai=
lto:ckoenig.<wbr>leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
<b>Sent:</b> Monday, March 19, 2018 3:45 PM<br>
<b>To:</b> Li, Samuel &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_b=
lank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;; Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailt=
o:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;; Koenig, Chr=
istian &lt;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Ch=
ristian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;; Michel D=C3=A4nzer &lt;<a href=
=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;=
; amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><wbr>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span><u></u><u></u></p>
</div>
</div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"margin-bottom:12.0p=
t;background:white">Quoting Alex:<u></u><u></u></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre style=3D"background:white">Regardless of which scenarios we need to su=
pport, I think we also need<u></u><u></u></pre>
<pre style=3D"background:white">to really plumb this through to mesa howeve=
r since user space is who<u></u><u></u></pre>
<pre style=3D"background:white">ultimately requests the location.=C2=A0 Ove=
rriding it in the kernel gets<u></u><u></u></pre>
<pre style=3D"background:white">tricky and can lead to ping-ponging as othe=
rs have noted.=C2=A0 Better to<u></u><u></u></pre>
<pre style=3D"background:white">have user space know what chips support it =
or not and request display<u></u><u></u></pre>
<pre style=3D"background:white">buffers in GTT or VRAM from the start.<u></=
u><u></u></pre>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">A=
nd I completely agree with Alex here. So overriding the domain in the kerne=
l is a serious NAK from my side as well.<br>
<br>
Please implement the necessary bits in Mesa, shouldn&#39;t be more than a f=
ew lines of code anyway.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 19.03.2018 um 20:42 schrieb Li, Samuel:<u></u><u></u></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Agreed.</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"margin-bottom:12.0p=
t;background:white">&gt;I think that the consensus with Alex and me is that=
 we should avoid exactly that.<br>
Christian, Alex=E2=80=99s concern is about ping-pong, not about the preferr=
ed domain. <u></u>
<u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Regards,</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">Samuel Li</span><u></u><u></u></p>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#2f5496">=C2=A0</span><u></u><u></u></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif"> Marek Ol=C5=A1=C3=A1k [<a href=3D"mailto:maraeo@gmail.=
com" target=3D"_blank">mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
<b>Sent:</b> Monday, March 19, 2018 3:39 PM<br>
<b>To:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" ta=
rget=3D"_blank">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Cc:</b> Li, Samuel <a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank=
">&lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>; Michel D=C3=A4nzer
<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">&lt;michel@daenzer.=
net&gt;</a>; Alex Deucher <a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">
&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; amd-gfx list <a href=3D"mailto:amd-gfx@l=
ists.freedesktop.org" target=3D"_blank">
&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org<wbr>org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span><u></u><u></u></p>
</div>
</div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
<div>
<div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">O=
n Mon, Mar 19, 2018 at 3:27 PM, Christian K=C3=B6nig &lt;<a href=3D"mailto:=
christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt=
; wrote:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">I=
 think that the consensus with Alex and me is that we should avoid exactly =
that.<br>
<br>
Overriding the preferred domain in the kernel is a no-go for that patch set=
, so please implement the discussed changes in Mesa.<u></u><u></u></p>
</blockquote>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">I=
 don&#39;t see how Mesa can make a smarter decision than the kernel. If you=
 overwrite the preferred domain of the buffer in the kernel, there will be =
no ping-ponging between domains. Mesa never changes the initial
 preferred domain.<u></u><u></u></p>
</div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">M=
arek<u></u><u></u></p>
</div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
br>
Regards,<br>
Christian.<u></u><u></u></p>
<div>
<div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
br>
<br>
Am 19.03.2018 um 20:22 schrieb Li, Samuel:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"margin-bottom:12.0p=
t;background:white">I agree with Marek/Michel: since kernel sets the domain=
 before scanning out, it shall update the preferred domain here too.<br>
<br>
Regards,<br>
Samuel Li<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">-=
----Original Message-----<br>
From: Koenig, Christian<br>
Sent: Thursday, March 08, 2018 4:07 AM<br>
To: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"=
_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;; Li, Samuel<br>
&lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Samuel.Li-urvtwAKJhsc@public.gmane.org=
m</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targe=
t=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><wbr>&gt;<br>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support<=
br>
<br>
Am 08.03.2018 um 09:35 schrieb Michel D=C3=A4nzer:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">O=
n 2018-03-07 10:47 AM, Christian K=C3=B6nig wrote:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">A=
m 07.03.2018 um 09:42 schrieb Michel D=C3=A4nzer:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"margin-bottom:12.0p=
t;background:white">On 2018-03-06 07:23 PM, Christian K=C3=B6nig wrote:<u><=
/u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">E=
.g. the last time I tested it placing things into GTT still<br>
resulted in quite a performance penalty for rendering.<u></u><u></u></p>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">F=
WIW, I think the penalty is most likely IOMMU related. Last time I<br>
tested, I couldn&#39;t measure a big difference with IOMMU disabled.<u></u>=
<u></u></p>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">N=
o, the penalty I&#39;m talking about came from the ping/pong we did with<br=
>
the scanout buffers.<br>
<br>
See when I tested this the DDX and Mesa where unmodified, so both<br>
still assumed VRAM as placement for scanout BOs, but the kernel<br>
forced scanout BOs into GTT for testing.<br>
<br>
So what happened was that on scanout we moved the VRAM BO to GTT<u></u><u><=
/u></p>
</blockquote>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">a=
nd<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">a=
fter unpinning it on the first command submission which used the BO<br>
we moved it back to VRAM again.<u></u><u></u></p>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">I=
n the meantime, I&#39;ve had the same idea as Marek: Can&#39;t the kernel<b=
r>
driver simply change the BO&#39;s preferred domain to GTT when scanning<br>
out from it? Then it won&#39;t move back to VRAM.<u></u><u></u></p>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">Y=
es, I&#39;ve considered this as well.<br>
<br>
But I think making the decision in Mesa is the cleaner approach.<br>
<br>
E.g. so far we only override the placement decision of userspace for two<br=
>
reasons:<br>
1. We where running out of memory in VRAM.<br>
2. We have a hardware restriction which makes VRAM usage mandatory.<br>
<br>
And even then we never adjust the placement permanently, we just<br>
temporary moved the buffer where it was needed and moved it back after<br>
the operation completed.<br>
<br>
Additional to that Mesa might want to set even more flags and/or changes<br=
>
it&#39;s behavior. E.g. use a tilling mode which both importer and export i=
n an<br>
A+A laptop understands etc...<br>
<br>
Regards,<br>
Christian.<u></u><u></u></p>
</blockquote>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white"><=
br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>=
<u></u><u></u></p>
</div>
</div>
</blockquote>
</div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
</div>
</div>
</div>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"margin-bottom:12.0p=
t;background:white"><u></u>=C2=A0<u></u></p>
<pre style=3D"background:white">______________________________<wbr>________=
_________<u></u><u></u></pre>
<pre style=3D"background:white">amd-gfx mailing list<u></u><u></u></pre>
<pre style=3D"background:white"><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><u></u><u></u></pr=
e>
<pre style=3D"background:white"><a href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx" target=3D"_blank">https://lists.freedesktop.org/<wb=
r>mailman/listinfo/amd-gfx</a><u></u><u></u></pre>
</blockquote>
<p class=3D"m_-7819403152211467846xxmsonormal" style=3D"background:white">=
=C2=A0<u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>

--00000000000016f6500567c9ca13--

--===============0193380322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0193380322==--
