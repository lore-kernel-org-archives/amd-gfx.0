From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 -
 Update 2
Date: Wed, 7 Feb 2018 16:41:04 +0000
Message-ID: <BN6PR12MB1652466CDC52B856E92AD172F7FC0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <CAEzXK1o+FewfiG84pCj8c_1Xz5KVsOOU7EX13LWaFVxK7s66fg@mail.gmail.com>
 <d755cd12-1a1e-ce98-2b0d-ea4b5eafc483@amd.com>
 <CAEzXK1qCfnHUvnuuViTP5fZQx2StjecV6o_QfJ2uJk603_9nhA@mail.gmail.com>
 <CAEzXK1oUyHsSGHeXS9qzWBSDL-FfRq2h-EiQMCfa=5BroO50gg@mail.gmail.com>
 <8bcdc933-050b-12ca-46e6-54bb66b6824d@gmail.com>
 <CAEzXK1pPzRM=EpL8fKQ5SdDvEePR+_KPhrtPMPiArt==BsJspA@mail.gmail.com>
 <99a9e27e-f166-f969-416f-f128b0673388@daenzer.net>
 <CAEzXK1rb6ngg=3MHo6yT+ed-a_1xr3ASwLPtsK4CpSMBk3xKgw@mail.gmail.com>
 <CAEzXK1qFh-Y6zCoVpRVRcLEe_hLFueqntrjaAwgfKyLGd2u27A@mail.gmail.com>
 <CAEzXK1rixP9spSTBY4V5GWxyUWJdf23Nbis2gbKgfxz4A6w2rQ@mail.gmail.com>
 <BN6PR12MB1652E01048ABD6A307E80B8DF7E40@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAEzXK1rbmaNifg00RY+GPdUgLtysLsF1mciPekbotWfT0gagJA@mail.gmail.com>
 <CAEzXK1ok5BsSMY2t4+D0575QSAqEkzKPC7cnWEVmg0OhCFcgcA@mail.gmail.com>
 <CADnq5_NPWa5s+dJwinBFLTzcGfycuuuin_YFp7CJnt_8A2p9eA@mail.gmail.com>
 <CAEzXK1rsnm318e6tE+9f=A3pAB4fHw3XUY0dMgvno4yUcoxgjA@mail.gmail.com>
 <c9d12d8c-a186-4041-ea41-1ccabe41eb29@gmail.com>
 <CAEzXK1rWeUYoSvd-T5JRSZnZSMcSCdpHDy6Eh5wkH=Qr=Gz2Bw@mail.gmail.com>
 <CAEzXK1p3feNO1O-Kf=TCqU8sq1Xz=z3Sav1kfDB6e-1hxe+YMQ@mail.gmail.com>,
 <CAEzXK1rni05EQGJaZVFc08LqwdbAX-8no-ARK255WCVt7AcH9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0961300785=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1rni05EQGJaZVFc08LqwdbAX-8no-ARK255WCVt7AcH9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?iso-8859-1?Q?Lu=EDs_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0961300785==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652466CDC52B856E92AD172F7FC0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652466CDC52B856E92AD172F7FC0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We haven't had a chance to look yet.


Alex

________________________________
From: Lu=EDs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, February 7, 2018 10:50:48 AM
To: Koenig, Christian
Cc: Alex Deucher; Deucher, Alexander; Zhou, David(ChunMing); Michel D=E4nze=
r; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 =
- Update 2

Hi Christian, Alexander,

Kmemleak reported leaked data structures and the GPU hung a bit after.
Could this be caused from DC?
Info in attachments.


I'm not sure if my previous email got overlooked, or if simply, there
are no suggestions at this moment. Sorry for kind of re-sending the
email.


Regards,
Lu=EDs

On Mon, Feb 5, 2018 at 12:40 PM, Lu=EDs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Hi everyone,
>
> I have some updates. I left the system idle most of the time during
> the weekend and from time to time I played a video on youtube and
> turned off the screen. Yesterday night I did the same and today
> morning I checked the system and it got hung up during the night. This
> time it took a lot longer to hang, but I think it was related to a
> Flash animation add that was only present on the youtube page the last
> time I switched off the screen. The amdgpu always seem to hang when
> that flash animation is present, from all the crash attempts I have
> made.
> There is a memory leak according to kmemleak which I attach along with
> the crash dmesg log.
>
> The kernel and patches are the same as on my previous email. I ended
> up not changing either the mesa version, nor the kernel version and
> patches.
>
> Regards,
> Lu=EDs
>
>
> On Fri, Feb 2, 2018 at 6:46 PM, Lu=EDs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>> Hi Christian, Alexander,
>>
>> I have enabled kmemleak, but memleak didn't detect anything special,
>> in fact this time, I don't know why, I didn't get any allocation
>> failure at all, but the GPU did hang after around 4h 6m of uptime with
>> Xorg.
>> The log can be found in attachment. I will try again to see if the
>> allocation failure reappears, or if it has become less apparent due to
>> kmemleak scans.
>>
>> The kernel stack trace is similar to the GPU hangs I was getting on
>> earlier kernel versions with Kodi, or Firefox when watching videos
>> with either one, but if I left Xorg idle, it would remain up and
>> available without hanging for more than one day.
>> This stack trace also looks quite similar to what Daniel Andersson
>> reported in "[BUG] Intermittent hang/deadlock when opening browser tab
>> with Vega gpu", looks like another demonstration of the same bug on
>> different architectures.
>>
>> Regards,
>> Lu=EDs
>>
>> On Fri, Feb 2, 2018 at 7:48 AM, Christian K=F6nig
>> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Hi Luis,
>>>
>>> please enable kmemleak in your build and watch out for any suspicious
>>> messages in the system log.
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>> Am 02.02.2018 um 00:03 schrieb Lu=EDs Mendes:
>>>>
>>>> Hi Alexander,
>>>>
>>>> I didn't notice improvements on this issue with that particular patch
>>>> applied. It still ends up failing to allocate kernel memory after a
>>>> few hours of uptime with Xorg.
>>>>
>>>> I will try to upgrade to mesa 18.0.0-rc3 and to amd-staging-drm-next
>>>> head, to see if the issue still occurs with those versions.
>>>>
>>>> If you have additional suggestions I'll be happy to try them.
>>>>
>>>> Regards,
>>>> Lu=EDs Mendes
>>>>
>>>> On Thu, Feb 1, 2018 at 2:30 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> wrote:
>>>>>
>>>>> On Wed, Jan 31, 2018 at 6:57 PM, Lu=EDs Mendes <luis.p.mendes@gmail.c=
om>
>>>>> wrote:
>>>>>>
>>>>>> Hi everyone,
>>>>>>
>>>>>> I am getting a new issue with amdgpu with RX460, that is, now I can
>>>>>> play any videos with Kodi or play web videos with firefox and run
>>>>>> OpenGL applications without running into any issues, however after
>>>>>> some uptime with XOrg even when almost inactive I get a kmalloc
>>>>>> allocation failure, normally followed by a GPU hang a while after th=
e
>>>>>> the allocation failure.
>>>>>> I had a terminal window under Ubuntu Mate 17.10 and I was compiling
>>>>>> code when I got the kernel messages that can be found in attachment.
>>>>>>
>>>>>> I am using the kernel as identified on my previous email, which can =
be
>>>>>> found below.
>>>>>
>>>>> does this patch help?
>>>>> https://patchwork.freedesktop.org/patch/198258/
>>>>>
>>>>> Alex
>>>>>
>>>>>> Regards,
>>>>>> Lu=EDs Mendes
>>>>>>
>>>>>> On Wed, Jan 31, 2018 at 12:47 PM, Lu=EDs Mendes <luis.p.mendes@gmail=
.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hi Alexander,
>>>>>>>
>>>>>>> I've cherry picked the patch you pointed out into kernel from
>>>>>>> amd-drm-next-4.17-wip at commit
>>>>>>> 9ab2894122275a6d636bb2654a157e88a0f7b9e2 ( drm/amdgpu: set
>>>>>>> DRIVER_ATOMIC flag early) and tested it on ARMv7l and the problem h=
as
>>>>>>> gone indeed.
>>>>>>>
>>>>>>>
>>>>>>> Working great on ARMv7l with AMD RX460.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lu=EDs Mendes
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Jan 30, 2018 at 6:44 PM, Deucher, Alexander
>>>>>>> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:
>>>>>>>>
>>>>>>>> Fixed with this patch:
>>>>>>>>
>>>>>>>>
>>>>>>>> https://lists.freedesktop.org/archives/amd-gfx/2018-January/018472=
.html
>>>>>>>>
>>>>>>>>
>>>>>>>> Alex
>>>>>>
>>>>>> <>
>>>>>>>>
>>>>>>>> __________________
>>>>>>
>>>>>> _______________________________________________
>>>>>> amd-gfx mailing list
>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>

--_000_BN6PR12MB1652466CDC52B856E92AD172F7FC0BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">We haven't had a chance to look y=
et.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lu=EDs Mendes &lt;lui=
s.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, February 7, 2018 10:50:48 AM<br>
<b>To:</b> Koenig, Christian<br>
<b>Cc:</b> Alex Deucher; Deucher, Alexander; Zhou, David(ChunMing); Michel =
D=E4nzer; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Deadlocks with multiple applications on AMD RX 460 and =
RX 550 - Update 2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Christian, Alexander,<br>
<br>
Kmemleak reported leaked data structures and the GPU hung a bit after.<br>
Could this be caused from DC?<br>
Info in attachments.<br>
<br>
<br>
I'm not sure if my previous email got overlooked, or if simply, there<br>
are no suggestions at this moment. Sorry for kind of re-sending the<br>
email.<br>
<br>
<br>
Regards,<br>
Lu=EDs<br>
<br>
On Mon, Feb 5, 2018 at 12:40 PM, Lu=EDs Mendes &lt;luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&=
gt; wrote:<br>
&gt; Hi everyone,<br>
&gt;<br>
&gt; I have some updates. I left the system idle most of the time during<br=
>
&gt; the weekend and from time to time I played a video on youtube and<br>
&gt; turned off the screen. Yesterday night I did the same and today<br>
&gt; morning I checked the system and it got hung up during the night. This=
<br>
&gt; time it took a lot longer to hang, but I think it was related to a<br>
&gt; Flash animation add that was only present on the youtube page the last=
<br>
&gt; time I switched off the screen. The amdgpu always seem to hang when<br=
>
&gt; that flash animation is present, from all the crash attempts I have<br=
>
&gt; made.<br>
&gt; There is a memory leak according to kmemleak which I attach along with=
<br>
&gt; the crash dmesg log.<br>
&gt;<br>
&gt; The kernel and patches are the same as on my previous email. I ended<b=
r>
&gt; up not changing either the mesa version, nor the kernel version and<br=
>
&gt; patches.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Lu=EDs<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Feb 2, 2018 at 6:46 PM, Lu=EDs Mendes &lt;luis.p.mendes@gmail.=
com&gt; wrote:<br>
&gt;&gt; Hi Christian, Alexander,<br>
&gt;&gt;<br>
&gt;&gt; I have enabled kmemleak, but memleak didn't detect anything specia=
l,<br>
&gt;&gt; in fact this time, I don't know why, I didn't get any allocation<b=
r>
&gt;&gt; failure at all, but the GPU did hang after around 4h 6m of uptime =
with<br>
&gt;&gt; Xorg.<br>
&gt;&gt; The log can be found in attachment. I will try again to see if the=
<br>
&gt;&gt; allocation failure reappears, or if it has become less apparent du=
e to<br>
&gt;&gt; kmemleak scans.<br>
&gt;&gt;<br>
&gt;&gt; The kernel stack trace is similar to the GPU hangs I was getting o=
n<br>
&gt;&gt; earlier kernel versions with Kodi, or Firefox when watching videos=
<br>
&gt;&gt; with either one, but if I left Xorg idle, it would remain up and<b=
r>
&gt;&gt; available without hanging for more than one day.<br>
&gt;&gt; This stack trace also looks quite similar to what Daniel Andersson=
<br>
&gt;&gt; reported in &quot;[BUG] Intermittent hang/deadlock when opening br=
owser tab<br>
&gt;&gt; with Vega gpu&quot;, looks like another demonstration of the same =
bug on<br>
&gt;&gt; different architectures.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Lu=EDs<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Feb 2, 2018 at 7:48 AM, Christian K=F6nig<br>
&gt;&gt; &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt;&gt;&gt; Hi Luis,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; please enable kmemleak in your build and watch out for any sus=
picious<br>
&gt;&gt;&gt; messages in the system log.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 02.02.2018 um 00:03 schrieb Lu=EDs Mendes:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Alexander,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I didn't notice improvements on this issue with that parti=
cular patch<br>
&gt;&gt;&gt;&gt; applied. It still ends up failing to allocate kernel memor=
y after a<br>
&gt;&gt;&gt;&gt; few hours of uptime with Xorg.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I will try to upgrade to mesa 18.0.0-rc3 and to amd-stagin=
g-drm-next<br>
&gt;&gt;&gt;&gt; head, to see if the issue still occurs with those versions=
.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If you have additional suggestions I'll be happy to try th=
em.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt; Lu=EDs Mendes<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, Feb 1, 2018 at 2:30 AM, Alex Deucher &lt;alexdeuch=
er-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Wed, Jan 31, 2018 at 6:57 PM, Lu=EDs Mendes &lt;lui=
s.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi everyone,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I am getting a new issue with amdgpu with RX460, t=
hat is, now I can<br>
&gt;&gt;&gt;&gt;&gt;&gt; play any videos with Kodi or play web videos with =
firefox and run<br>
&gt;&gt;&gt;&gt;&gt;&gt; OpenGL applications without running into any issue=
s, however after<br>
&gt;&gt;&gt;&gt;&gt;&gt; some uptime with XOrg even when almost inactive I =
get a kmalloc<br>
&gt;&gt;&gt;&gt;&gt;&gt; allocation failure, normally followed by a GPU han=
g a while after the<br>
&gt;&gt;&gt;&gt;&gt;&gt; the allocation failure.<br>
&gt;&gt;&gt;&gt;&gt;&gt; I had a terminal window under Ubuntu Mate 17.10 an=
d I was compiling<br>
&gt;&gt;&gt;&gt;&gt;&gt; code when I got the kernel messages that can be fo=
und in attachment.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I am using the kernel as identified on my previous=
 email, which can be<br>
&gt;&gt;&gt;&gt;&gt;&gt; found below.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; does this patch help?<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://patchwork.freedesktop.org/patch/198=
258/">https://patchwork.freedesktop.org/patch/198258/</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Alex<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt;&gt; Lu=EDs Mendes<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Jan 31, 2018 at 12:47 PM, Lu=EDs Mendes &l=
t;luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Alexander,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I've cherry picked the patch you pointed out i=
nto kernel from<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-drm-next-4.17-wip at commit<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; 9ab2894122275a6d636bb2654a157e88a0f7b9e2 ( drm=
/amdgpu: set<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; DRIVER_ATOMIC flag early) and tested it on ARM=
v7l and the problem has<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; gone indeed.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Working great on ARMv7l with AMD RX460.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Lu=EDs Mendes<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Jan 30, 2018 at 6:44 PM, Deucher, Alex=
ander<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Fixed with this patch:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/a=
rchives/amd-gfx/2018-January/018472.html">
https://lists.freedesktop.org/archives/amd-gfx/2018-January/018472.html</a>=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Alex<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; __________________<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; _______________________________________________<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/=
amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1652466CDC52B856E92AD172F7FC0BN6PR12MB1652namp_--

--===============0961300785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0961300785==--
