From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: s2idle not working
Date: Thu, 21 Feb 2019 10:44:40 +0530
Message-ID: <CAHD83QffiF2HGdGTNSrrV8P9y9sX4Q203C-7twradN22-FO_xA@mail.gmail.com>
References: <CAHD83Qc9D5L-B-2R9nYWtckK=WrKkw9Hha5dwDqWt4DCAhAPSQ@mail.gmail.com>
 <CAHD83Qdhw5Jn1Wh1Q52i5UoGMCmNqnYXV=DqmZWCB28606U1iw@mail.gmail.com>
 <CADnq5_N9okwWV0B+D9p6p9D6DPToGpk_a1LbH9xFSTcxVXXA2Q@mail.gmail.com>
 <CAHD83QdHAd5Q5HCiOOg4JU2g9=Bp3uGzTstQY2sst7xQt+jFNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956425112=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHD83QdHAd5Q5HCiOOg4JU2g9=Bp3uGzTstQY2sst7xQt+jFNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1956425112==
Content-Type: multipart/alternative; boundary="000000000000b783bf0582608d11"

--000000000000b783bf0582608d11
Content-Type: text/plain; charset="UTF-8"

Hi All,
Below error also got

amdgpu 0000:04:00.0: couldn't schedule ib on ring <sdma0>
[  148.782052] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs
(-22)
[  148.782054] amdgpu 0000:04:00.0: couldn't schedule ib on ring <sdma0>
[  148.782107] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs
(-22)
[  148.782120] amdgpu 0000:04:00.0: couldn't schedule ib on ring <sdma0>
[  148.782173] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs
(-22)
[  148.782175] amdgpu 0000:04:00.0: couldn't schedule ib on ring <sdma0>
[  148.782228] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs
(-22)

Regards,
Skshahul.

On Thu, Feb 21, 2019 at 10:26 AM shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi All,
>
> I did below exoeriments:
>
> -> S2idle is working in software rendering mode(disable AMDGPU driver).
>
> -> For experiment purpose i commented suspend/resume calls of amdgpu
> driver, in this case S2idle worked.
> With above experiments it is clear that my platform supports s2idel.
> Some issue in AMDGPU suspend/resume sequence for s2idle.
> So can you please help me.
>
> Thanks & Regards,
> Sk shahul.
>
> On Thu, Feb 21, 2019 at 3:32 AM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> On Wed, Feb 20, 2019 at 4:59 PM shahul hameed
>> <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >
>> > Hi
>> >
>> > I am facing below issue. Can any one please help me to resolve it.
>>
>> As I mentioned previously, please make sure the platform supports
>> s2idle and that it is enabled in the sbios.  Does s2idle work on other
>> devices and the platform itself?
>>
>> Alex
>>
>> >
>> > Regards,
>> > Sk shahul
>> >
>> > ---------- Forwarded message ---------
>> > From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > Date: Wed, Feb 20, 2019, 3:13 PM
>> > Subject: s2idle not working
>> > To: <shirish.s-5C7GfCeVMHo@public.gmane.org>
>> >
>> >
>> > Hi Shirish
>> >
>> > I am porting Android_N and keenel 4.19.2 to Ryzen platform. Graphic
>> card is gfx9.
>> > Porting is done successfully. Now i am working on suspend/resume.
>> > Suspend/resume is working fine in deep mode.
>> > But suspend/resume is not working in s2idle (Suspend to idle) mode.
>> >
>> > during resume i found error in gpu driver.
>> >
>> > [  105.862161] [drm:gfx_v9_0_hw_init [amdgpu]] *ERROR* KCQ enable
>> failed (scratch(0xC040)=0xCAFEDEAD)
>> > [  105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR*
>> resume of IP block <gfx_v9_0> failed -22
>> > [  105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERROR*
>> amdgpu_device_ip_resume failed (-22).
>> > [  105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd6 returns -22
>> > [  105.862345] PM: Device 0000:03:00.0 failed to resume async: error -22
>> >
>> > same issue is reproduced with ubuntu16.04.
>> >
>> > Can you please help me to resolve this issue.
>> > Thanks in Advance,
>> > Regards,
>> > Sk shahul.
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>

--000000000000b783bf0582608d11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi All,</div><div>Below error also g=
ot</div><div><br></div><div>amdgpu 0000:04:00.0: couldn&#39;t schedule ib o=
n ring &lt;sdma0&gt;<br>[=C2=A0 148.782052] [drm:amdgpu_job_run [amdgpu]] *=
ERROR* Error scheduling IBs (-22)<br>[=C2=A0 148.782054] amdgpu 0000:04:00.=
0: couldn&#39;t schedule ib on ring &lt;sdma0&gt;<br>[=C2=A0 148.782107] [d=
rm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)<br>[=C2=A0 1=
48.782120] amdgpu 0000:04:00.0: couldn&#39;t schedule ib on ring &lt;sdma0&=
gt;<br>[=C2=A0 148.782173] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error sche=
duling IBs (-22)<br>[=C2=A0 148.782175] amdgpu 0000:04:00.0: couldn&#39;t s=
chedule ib on ring &lt;sdma0&gt;<br>[=C2=A0 148.782228] [drm:amdgpu_job_run=
 [amdgpu]] *ERROR* Error scheduling IBs (-22)<br></div><div><br></div><div>=
Regards,</div><div>Skshahul.<br></div></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 21, 2019 at 10:26 A=
M shahul hameed &lt;<a href=3D"mailto:shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">shahulham=
eed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div>Hi All,</div><div><br></div><div>I d=
id below exoeriments:<br></div><div><p>-&gt; S2idle is working in software =
rendering mode(disable AMDGPU driver).</p>

<p>-&gt; For experiment purpose i commented suspend/resume calls of amdgpu =
driver, in this case S2idle worked.</p>With above experiments it is clear t=
hat my platform supports s2idel.</div><div>Some issue in AMDGPU suspend/res=
ume sequence for s2idle.</div><div>So can you please help me. <br></div><di=
v><br></div><div>Thanks &amp; Regards,</div><div>Sk shahul.<br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Feb 21, 2019 at 3:32 AM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gm=
ail.com" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Feb 20, 2019 at 4:5=
9 PM shahul hameed<br>
&lt;<a href=3D"mailto:shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">shahulh=
ameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi<br>
&gt;<br>
&gt; I am facing below issue. Can any one please help me to resolve it.<br>
<br>
As I mentioned previously, please make sure the platform supports<br>
s2idle and that it is enabled in the sbios.=C2=A0 Does s2idle work on other=
<br>
devices and the platform itself?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Sk shahul<br>
&gt;<br>
&gt; ---------- Forwarded message ---------<br>
&gt; From: shahul hameed &lt;<a href=3D"mailto:shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; Date: Wed, Feb 20, 2019, 3:13 PM<br>
&gt; Subject: s2idle not working<br>
&gt; To: &lt;<a href=3D"mailto:shirish.s-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">shirish=
.s@amd.com</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Shirish<br>
&gt;<br>
&gt; I am porting Android_N and keenel 4.19.2 to Ryzen platform. Graphic ca=
rd is gfx9.<br>
&gt; Porting is done successfully. Now i am working on suspend/resume.<br>
&gt; Suspend/resume is working fine in deep mode.<br>
&gt; But suspend/resume is not working in s2idle (Suspend to idle) mode.<br=
>
&gt;<br>
&gt; during resume i found error in gpu driver.<br>
&gt;<br>
&gt; [=C2=A0 105.862161] [drm:gfx_v9_0_hw_init [amdgpu]] *ERROR* KCQ enable=
 failed (scratch(0xC040)=3D0xCAFEDEAD)<br>
&gt; [=C2=A0 105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERR=
OR* resume of IP block &lt;gfx_v9_0&gt; failed -22<br>
&gt; [=C2=A0 105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu=
_device_ip_resume failed (-22).<br>
&gt; [=C2=A0 105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd6 returns=
 -22<br>
&gt; [=C2=A0 105.862345] PM: Device 0000:03:00.0 failed to resume async: er=
ror -22<br>
&gt;<br>
&gt; same issue is reproduced with ubuntu16.04.<br>
&gt;<br>
&gt; Can you please help me to resolve this issue.<br>
&gt; Thanks in Advance,<br>
&gt; Regards,<br>
&gt; Sk shahul.<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>
</blockquote></div>

--000000000000b783bf0582608d11--

--===============1956425112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1956425112==--
