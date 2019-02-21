From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: s2idle not working
Date: Thu, 21 Feb 2019 15:39:17 +0530
Message-ID: <CAHD83QeMtLVmCo_guJq2Jhyyo9FnTepd5L2agmT4taPPeWtbDg@mail.gmail.com>
References: <CAHD83Qc9D5L-B-2R9nYWtckK=WrKkw9Hha5dwDqWt4DCAhAPSQ@mail.gmail.com>
 <CAHD83Qdhw5Jn1Wh1Q52i5UoGMCmNqnYXV=DqmZWCB28606U1iw@mail.gmail.com>
 <CADnq5_N9okwWV0B+D9p6p9D6DPToGpk_a1LbH9xFSTcxVXXA2Q@mail.gmail.com>
 <CAHD83QdHAd5Q5HCiOOg4JU2g9=Bp3uGzTstQY2sst7xQt+jFNg@mail.gmail.com>
 <CADnq5_Oxy_16yGqcfy8eyOYMaCkdL6d_Ny3qZTXdKi3bizwc1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1973219318=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Oxy_16yGqcfy8eyOYMaCkdL6d_Ny3qZTXdKi3bizwc1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1973219318==
Content-Type: multipart/alternative; boundary="00000000000058c2d1058264ab82"

--00000000000058c2d1058264ab82
Content-Type: text/plain; charset="UTF-8"

HI Alex,

I will check with your patch. if it doesn't work i will raise bug .

Regards,
Sk shahul.

On Thu, Feb 21, 2019 at 12:01 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Wed, Feb 20, 2019 at 11:56 PM shahul hameed
> <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hi All,
> >
> > I did below exoeriments:
> >
> > -> S2idle is working in software rendering mode(disable AMDGPU driver).
> >
> > -> For experiment purpose i commented suspend/resume calls of amdgpu
> driver, in this case S2idle worked.
> >
> > With above experiments it is clear that my platform supports s2idel.
> > Some issue in AMDGPU suspend/resume sequence for s2idle.
> > So can you please help me.
>
> I'd suggest filing a bug (https://bugs.freedesktop.org) and attaching
> your full dmesg output.  I'm not too familiar with s2idle and what
> pmops paths it uses.  I suspect what is happening is that the power is
> not getting fully cut the the device when s2idle is invoked, and it's
> left in a bad state on resume.  Maybe something like the attached
> patch might help.  That said, if the platform is not properly cutting
> power to the device at s2idle time, you probably aren't saving any
> power anyway.
>
> Alex
>
> >
> > Thanks & Regards,
> > Sk shahul.
> >
> > On Thu, Feb 21, 2019 at 3:32 AM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> On Wed, Feb 20, 2019 at 4:59 PM shahul hameed
> >> <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> >
> >> > Hi
> >> >
> >> > I am facing below issue. Can any one please help me to resolve it.
> >>
> >> As I mentioned previously, please make sure the platform supports
> >> s2idle and that it is enabled in the sbios.  Does s2idle work on other
> >> devices and the platform itself?
> >>
> >> Alex
> >>
> >> >
> >> > Regards,
> >> > Sk shahul
> >> >
> >> > ---------- Forwarded message ---------
> >> > From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> > Date: Wed, Feb 20, 2019, 3:13 PM
> >> > Subject: s2idle not working
> >> > To: <shirish.s-5C7GfCeVMHo@public.gmane.org>
> >> >
> >> >
> >> > Hi Shirish
> >> >
> >> > I am porting Android_N and keenel 4.19.2 to Ryzen platform. Graphic
> card is gfx9.
> >> > Porting is done successfully. Now i am working on suspend/resume.
> >> > Suspend/resume is working fine in deep mode.
> >> > But suspend/resume is not working in s2idle (Suspend to idle) mode.
> >> >
> >> > during resume i found error in gpu driver.
> >> >
> >> > [  105.862161] [drm:gfx_v9_0_hw_init [amdgpu]] *ERROR* KCQ enable
> failed (scratch(0xC040)=0xCAFEDEAD)
> >> > [  105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR*
> resume of IP block <gfx_v9_0> failed -22
> >> > [  105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERROR*
> amdgpu_device_ip_resume failed (-22).
> >> > [  105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd6 returns -22
> >> > [  105.862345] PM: Device 0000:03:00.0 failed to resume async: error
> -22
> >> >
> >> > same issue is reproduced with ubuntu16.04.
> >> >
> >> > Can you please help me to resolve this issue.
> >> > Thanks in Advance,
> >> > Regards,
> >> > Sk shahul.
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000058c2d1058264ab82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>HI Alex,</div><div><br></div><div>I will check with y=
our patch. if it doesn&#39;t work i will raise bug .</div><div><br></div><d=
iv>Regards,</div><div>Sk shahul.<br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 21, 2019 at 12:01 PM =
Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Wed, Feb 20, 2019 at 11:56 PM shahul hameed<br>
&lt;<a href=3D"mailto:shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">shahulh=
ameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi All,<br>
&gt;<br>
&gt; I did below exoeriments:<br>
&gt;<br>
&gt; -&gt; S2idle is working in software rendering mode(disable AMDGPU driv=
er).<br>
&gt;<br>
&gt; -&gt; For experiment purpose i commented suspend/resume calls of amdgp=
u driver, in this case S2idle worked.<br>
&gt;<br>
&gt; With above experiments it is clear that my platform supports s2idel.<b=
r>
&gt; Some issue in AMDGPU suspend/resume sequence for s2idle.<br>
&gt; So can you please help me.<br>
<br>
I&#39;d suggest filing a bug (<a href=3D"https://bugs.freedesktop.org" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org</a>) and att=
aching<br>
your full dmesg output.=C2=A0 I&#39;m not too familiar with s2idle and what=
<br>
pmops paths it uses.=C2=A0 I suspect what is happening is that the power is=
<br>
not getting fully cut the the device when s2idle is invoked, and it&#39;s<b=
r>
left in a bad state on resume.=C2=A0 Maybe something like the attached<br>
patch might help.=C2=A0 That said, if the platform is not properly cutting<=
br>
power to the device at s2idle time, you probably aren&#39;t saving any<br>
power anyway.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt; Sk shahul.<br>
&gt;<br>
&gt; On Thu, Feb 21, 2019 at 3:32 AM Alex Deucher &lt;<a href=3D"mailto:ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<=
br>
&gt;&gt;<br>
&gt;&gt; On Wed, Feb 20, 2019 at 4:59 PM shahul hameed<br>
&gt;&gt; &lt;<a href=3D"mailto:shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank=
">shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am facing below issue. Can any one please help me to resolv=
e it.<br>
&gt;&gt;<br>
&gt;&gt; As I mentioned previously, please make sure the platform supports<=
br>
&gt;&gt; s2idle and that it is enabled in the sbios.=C2=A0 Does s2idle work=
 on other<br>
&gt;&gt; devices and the platform itself?<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; Sk shahul<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ---------- Forwarded message ---------<br>
&gt;&gt; &gt; From: shahul hameed &lt;<a href=3D"mailto:shahulhameed.481@gm=
ail.com" target=3D"_blank">shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt; Date: Wed, Feb 20, 2019, 3:13 PM<br>
&gt;&gt; &gt; Subject: s2idle not working<br>
&gt;&gt; &gt; To: &lt;<a href=3D"mailto:shirish.s-5C7GfCeVMHo@public.gmane.org" target=3D"_blank=
">shirish.s-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi Shirish<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am porting Android_N and keenel 4.19.2 to Ryzen platform. G=
raphic card is gfx9.<br>
&gt;&gt; &gt; Porting is done successfully. Now i am working on suspend/res=
ume.<br>
&gt;&gt; &gt; Suspend/resume is working fine in deep mode.<br>
&gt;&gt; &gt; But suspend/resume is not working in s2idle (Suspend to idle)=
 mode.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; during resume i found error in gpu driver.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [=C2=A0 105.862161] [drm:gfx_v9_0_hw_init [amdgpu]] *ERROR* K=
CQ enable failed (scratch(0xC040)=3D0xCAFEDEAD)<br>
&gt;&gt; &gt; [=C2=A0 105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdg=
pu]] *ERROR* resume of IP block &lt;gfx_v9_0&gt; failed -22<br>
&gt;&gt; &gt; [=C2=A0 105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERRO=
R* amdgpu_device_ip_resume failed (-22).<br>
&gt;&gt; &gt; [=C2=A0 105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd=
6 returns -22<br>
&gt;&gt; &gt; [=C2=A0 105.862345] PM: Device 0000:03:00.0 failed to resume =
async: error -22<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; same issue is reproduced with ubuntu16.04.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Can you please help me to resolve this issue.<br>
&gt;&gt; &gt; Thanks in Advance,<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; Sk shahul.<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; amd-gfx mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_b=
lank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a><br>
</blockquote></div>

--00000000000058c2d1058264ab82--

--===============1973219318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1973219318==--
