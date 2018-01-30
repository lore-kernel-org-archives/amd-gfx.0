From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 -
 Update 2
Date: Tue, 30 Jan 2018 18:44:18 +0000
Message-ID: <BN6PR12MB1652E01048ABD6A307E80B8DF7E40@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <CAEzXK1o+FewfiG84pCj8c_1Xz5KVsOOU7EX13LWaFVxK7s66fg@mail.gmail.com>
 <1ca083a5-f33c-7be0-a3c8-c2996a087f70@amd.com>
 <CAEzXK1odkDX-D3MOGHLFJuKNHh0RjSfsFL8PtB=6YQRDf1+Tkw@mail.gmail.com>
 <d755cd12-1a1e-ce98-2b0d-ea4b5eafc483@amd.com>
 <CAEzXK1qCfnHUvnuuViTP5fZQx2StjecV6o_QfJ2uJk603_9nhA@mail.gmail.com>
 <CAEzXK1oUyHsSGHeXS9qzWBSDL-FfRq2h-EiQMCfa=5BroO50gg@mail.gmail.com>
 <8bcdc933-050b-12ca-46e6-54bb66b6824d@gmail.com>
 <CAEzXK1pPzRM=EpL8fKQ5SdDvEePR+_KPhrtPMPiArt==BsJspA@mail.gmail.com>
 <99a9e27e-f166-f969-416f-f128b0673388@daenzer.net>
 <CAEzXK1rb6ngg=3MHo6yT+ed-a_1xr3ASwLPtsK4CpSMBk3xKgw@mail.gmail.com>
 <CAEzXK1qFh-Y6zCoVpRVRcLEe_hLFueqntrjaAwgfKyLGd2u27A@mail.gmail.com>,
 <CAEzXK1rixP9spSTBY4V5GWxyUWJdf23Nbis2gbKgfxz4A6w2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1051600992=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1rixP9spSTBY4V5GWxyUWJdf23Nbis2gbKgfxz4A6w2rQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?iso-8859-1?Q?Lu=EDs_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1051600992==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652E01048ABD6A307E80B8DF7E40BN6PR12MB1652namp_"

--_000_BN6PR12MB1652E01048ABD6A307E80B8DF7E40BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Fixed with this patch:

https://lists.freedesktop.org/archives/amd-gfx/2018-January/018472.html


Alex

________________________________
From: Lu=EDs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, January 30, 2018 1:30 PM
To: Michel D=E4nzer; Koenig, Christian
Cc: Deucher, Alexander; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 =
- Update 2

Hi everyone,

I've tested the kernel from amd-drm-next-4.17-wip at commit
9ab2894122275a6d636bb2654a157e88a0f7b9e2 (
drm/amdgpu: set DRIVER_ATOMIC flag early) on ARMv7l, and the reported
issues seem now to have gone. I haven't checked from which commit this
is fixed, but it is now fixed! I also noticed a performance
improvement in one of the glmark2 tests.

There seem to be some other small issues, possibly unrelated, such
that sometimes the screen becomes black and the sound stops while
playing the video for a second or less and then normal playback is
recovered, this happens rarely and at most once per power cycle, while
using X and Kodi, despite I have played many individual videos and
power cycled the machine sometimes.

I've also observed what was already reported, when watching non-VP9 videos:
[  591.729558] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.740255] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.750968] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.761628] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.772248] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.782672] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.793172] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.803681] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.814129] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.824560] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.835054] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.845437] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.855860] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.866415] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.876945] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!
[  591.887454] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:
writing more dwords to the ring than expected!

Regards,
Lu=EDs Mendes

On Wed, Jan 3, 2018 at 11:08 PM, Lu=EDs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Hi Michel, Christian,
>
> Michel, I have tested amd-staging-drm-next at commit "drm/amdgpu/gfx9:
> only init the apertures used by KGD (v2)" -
> 0e4946409d11913523d30bc4830d10b388438c7a and the issues remain, both
> on ARMv7 and on x86 amd64.
>
> Christian, in fact if I replay the apitraces obtained on the ARMv7
> platform on the AMD64 I am also able to reproduce the GPU hang! So it
> is not ARM platform specific. Should I send/upload the apitraces? I
> have two of them, typically when one doesn't hang the gpu the other
> hangs. One takes about 1GB of disk space while the other takes 2.3GB.
> ...
> [   69.019381] ISO 9660 Extensions: RRIP_1991A
> [  213.292094] DMAR: DRHD: handling fault status reg 2
> [  213.292102] DMAR: [INTR-REMAP] Request device [00:00.0] fault index
> 1c [fault reason 38] Blocked an interrupt request due to source-id
> verification failure
> [  223.406919] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> timeout, last signaled seq=3D25158, last emitted seq=3D25160
> [  223.406926] [drm] IP block:tonga_ih is hung!
> [  223.407167] [drm] GPU recovery disabled.
>
> Regards,
> Lu=EDs
>
>
> On Wed, Jan 3, 2018 at 5:47 PM, Lu=EDs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>> Hi Michel, Christian,
>>
>> Christian, I have followed your suggestion and I have just submitted a
>> bug to fdo at https://bugs.freedesktop.org/show_bug.cgi?id=3D104481 -
>> GPU lockup Polaris 11 - AMD RX 460 and RX 550 on amd64 and on ARMv7
>> platforms while playing video.
>>
>> Michel, amdgpu.dc=3D0 seems to make no difference. I will try
>> amd-staging-drm-next and report back.
>>
>> Regards,
>> Lu=EDs
>>
>> On Wed, Jan 3, 2018 at 5:09 PM, Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wro=
te:
>>> On 2018-01-03 12:02 PM, Lu=EDs Mendes wrote:
>>>>
>>>> What I believe it seems to be the case is that the GPU lock up only
>>>> happens when doing a page flip, since the kernel locks with:
>>>> [  243.693200] kworker/u4:3    D    0    89      2 0x00000000
>>>> [  243.693232] Workqueue: events_unbound commit_work [drm_kms_helper]
>>>> [  243.693251] [<80b8c6d4>] (__schedule) from [<80b8cdd0>] (schedule+0=
x4c/0xac)
>>>> [  243.693259] [<80b8cdd0>] (schedule) from [<80b91024>]
>>>> (schedule_timeout+0x228/0x444)
>>>> [  243.693270] [<80b91024>] (schedule_timeout) from [<80886738>]
>>>> (dma_fence_default_wait+0x2b4/0x2d8)
>>>> [  243.693276] [<80886738>] (dma_fence_default_wait) from [<80885d60>]
>>>> (dma_fence_wait_timeout+0x40/0x150)
>>>> [  243.693284] [<80885d60>] (dma_fence_wait_timeout) from [<80887b1c>]
>>>> (reservation_object_wait_timeout_rcu+0xfc/0x34c)
>>>> [  243.693509] [<80887b1c>] (reservation_object_wait_timeout_rcu) from
>>>> [<7f331988>] (amdgpu_dm_do_flip+0xec/0x36c [amdgpu])
>>>> [  243.693789] [<7f331988>] (amdgpu_dm_do_flip [amdgpu]) from
>>>> [<7f33309c>] (amdgpu_dm_atomic_commit_tail+0xbfc/0xe58 [amdgpu])
>>>> ...
>>>
>>> Does the problem also occur if you disable DC with amdgpu.dc=3D0 on the
>>> kernel command line?
>>>
>>> Does it also happen with a kernel built from the amd-staging-drm-next
>>> branch instead of drm-next-4.16?
>>>
>>>
>>> --
>>> Earthling Michel D=E4nzer               |               http://www.amd.=
com
>>> Libre software enthusiast             |             Mesa and X develope=
r

--_000_BN6PR12MB1652E01048ABD6A307E80B8DF7E40BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Fixed with this patch:</p>
<p style=3D"margin-top:0;margin-bottom:0"><a href=3D"https://lists.freedesk=
top.org/archives/amd-gfx/2018-January/018472.html" class=3D"OWAAutoLink" id=
=3D"LPlnk929735" previewremoved=3D"true">https://lists.freedesktop.org/arch=
ives/amd-gfx/2018-January/018472.html</a></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Lu=EDs Mendes &lt;l=
uis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, January 30, 2018 1:30 PM<br>
<b>To:</b> Michel D=E4nzer; Koenig, Christian<br>
<b>Cc:</b> Deucher, Alexander; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org<br>
<b>Subject:</b> Re: Deadlocks with multiple applications on AMD RX 460 and =
RX 550 - Update 2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi everyone,<br>
<br>
I've tested the kernel from amd-drm-next-4.17-wip at commit<br>
9ab2894122275a6d636bb2654a157e88a0f7b9e2 (<br>
drm/amdgpu: set DRIVER_ATOMIC flag early) on ARMv7l, and the reported<br>
issues seem now to have gone. I haven't checked from which commit this<br>
is fixed, but it is now fixed! I also noticed a performance<br>
improvement in one of the glmark2 tests.<br>
<br>
There seem to be some other small issues, possibly unrelated, such<br>
that sometimes the screen becomes black and the sound stops while<br>
playing the video for a second or less and then normal playback is<br>
recovered, this happens rarely and at most once per power cycle, while<br>
using X and Kodi, despite I have played many individual videos and<br>
power cycled the machine sometimes.<br>
<br>
I've also observed what was already reported, when watching non-VP9 videos:=
<br>
[&nbsp; 591.729558] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:=
<br>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.740255] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:=
<br>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.750968] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:=
<br>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.761628] [drm:uvd_v6_0_ring_emit_fence [amdgpu]] *ERROR* amdgpu:=
<br>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.772248] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.782672] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.793172] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.803681] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.814129] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.824560] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.835054] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.845437] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.855860] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.866415] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.876945] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
[&nbsp; 591.887454] [drm:amdgpu_ring_insert_nop [amdgpu]] *ERROR* amdgpu:<b=
r>
writing more dwords to the ring than expected!<br>
<br>
Regards,<br>
Lu=EDs Mendes<br>
<br>
On Wed, Jan 3, 2018 at 11:08 PM, Lu=EDs Mendes &lt;luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&=
gt; wrote:<br>
&gt; Hi Michel, Christian,<br>
&gt;<br>
&gt; Michel, I have tested amd-staging-drm-next at commit &quot;drm/amdgpu/=
gfx9:<br>
&gt; only init the apertures used by KGD (v2)&quot; -<br>
&gt; 0e4946409d11913523d30bc4830d10b388438c7a and the issues remain, both<b=
r>
&gt; on ARMv7 and on x86 amd64.<br>
&gt;<br>
&gt; Christian, in fact if I replay the apitraces obtained on the ARMv7<br>
&gt; platform on the AMD64 I am also able to reproduce the GPU hang! So it<=
br>
&gt; is not ARM platform specific. Should I send/upload the apitraces? I<br=
>
&gt; have two of them, typically when one doesn't hang the gpu the other<br=
>
&gt; hangs. One takes about 1GB of disk space while the other takes 2.3GB.<=
br>
&gt; ...<br>
&gt; [&nbsp;&nbsp; 69.019381] ISO 9660 Extensions: RRIP_1991A<br>
&gt; [&nbsp; 213.292094] DMAR: DRHD: handling fault status reg 2<br>
&gt; [&nbsp; 213.292102] DMAR: [INTR-REMAP] Request device [00:00.0] fault =
index<br>
&gt; 1c [fault reason 38] Blocked an interrupt request due to source-id<br>
&gt; verification failure<br>
&gt; [&nbsp; 223.406919] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gf=
x<br>
&gt; timeout, last signaled seq=3D25158, last emitted seq=3D25160<br>
&gt; [&nbsp; 223.406926] [drm] IP block:tonga_ih is hung!<br>
&gt; [&nbsp; 223.407167] [drm] GPU recovery disabled.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Lu=EDs<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Jan 3, 2018 at 5:47 PM, Lu=EDs Mendes &lt;luis.p.mendes@gmail.=
com&gt; wrote:<br>
&gt;&gt; Hi Michel, Christian,<br>
&gt;&gt;<br>
&gt;&gt; Christian, I have followed your suggestion and I have just submitt=
ed a<br>
&gt;&gt; bug to fdo at <a href=3D"https://bugs.freedesktop.org/show_bug.cgi=
?id=3D104481" id=3D"LPlnk75492" previewremoved=3D"true">
https://bugs.freedesktop.org/show_bug.cgi?id=3D104481</a> -<br>
&gt;&gt; GPU lockup Polaris 11 - AMD RX 460 and RX 550 on amd64 and on ARMv=
7<br>
&gt;&gt; platforms while playing video.<br>
&gt;&gt;<br>
&gt;&gt; Michel, amdgpu.dc=3D0 seems to make no difference. I will try<br>
&gt;&gt; amd-staging-drm-next and report back.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Lu=EDs<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Jan 3, 2018 at 5:09 PM, Michel D=E4nzer &lt;michel@daenzer=
.net&gt; wrote:<br>
&gt;&gt;&gt; On 2018-01-03 12:02 PM, Lu=EDs Mendes wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; What I believe it seems to be the case is that the GPU loc=
k up only<br>
&gt;&gt;&gt;&gt; happens when doing a page flip, since the kernel locks wit=
h:<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693200] kworker/u4:3&nbsp;&nbsp;&nbsp; D&nbsp;=
&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 89&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 0x00000=
000<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693232] Workqueue: events_unbound commit_work =
[drm_kms_helper]<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693251] [&lt;80b8c6d4&gt;] (__schedule) from [=
&lt;80b8cdd0&gt;] (schedule&#43;0x4c/0xac)<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693259] [&lt;80b8cdd0&gt;] (schedule) from [&l=
t;80b91024&gt;]<br>
&gt;&gt;&gt;&gt; (schedule_timeout&#43;0x228/0x444)<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693270] [&lt;80b91024&gt;] (schedule_timeout) =
from [&lt;80886738&gt;]<br>
&gt;&gt;&gt;&gt; (dma_fence_default_wait&#43;0x2b4/0x2d8)<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693276] [&lt;80886738&gt;] (dma_fence_default_=
wait) from [&lt;80885d60&gt;]<br>
&gt;&gt;&gt;&gt; (dma_fence_wait_timeout&#43;0x40/0x150)<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693284] [&lt;80885d60&gt;] (dma_fence_wait_tim=
eout) from [&lt;80887b1c&gt;]<br>
&gt;&gt;&gt;&gt; (reservation_object_wait_timeout_rcu&#43;0xfc/0x34c)<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693509] [&lt;80887b1c&gt;] (reservation_object=
_wait_timeout_rcu) from<br>
&gt;&gt;&gt;&gt; [&lt;7f331988&gt;] (amdgpu_dm_do_flip&#43;0xec/0x36c [amdg=
pu])<br>
&gt;&gt;&gt;&gt; [&nbsp; 243.693789] [&lt;7f331988&gt;] (amdgpu_dm_do_flip =
[amdgpu]) from<br>
&gt;&gt;&gt;&gt; [&lt;7f33309c&gt;] (amdgpu_dm_atomic_commit_tail&#43;0xbfc=
/0xe58 [amdgpu])<br>
&gt;&gt;&gt;&gt; ...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Does the problem also occur if you disable DC with amdgpu.dc=
=3D0 on the<br>
&gt;&gt;&gt; kernel command line?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Does it also happen with a kernel built from the amd-staging-d=
rm-next<br>
&gt;&gt;&gt; branch instead of drm-next-4.16?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http:=
//www.amd.com" id=3D"LPlnk808850" previewremoved=3D"true">
http://www.amd.com</a><br>
&gt;&gt;&gt; Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652E01048ABD6A307E80B8DF7E40BN6PR12MB1652namp_--

--===============1051600992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1051600992==--
