From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Tue, 10 Jul 2018 23:06:06 +0100
Message-ID: <CAEzXK1rL-ycG4idajcWNK8QJcgYWCMJZLKiE9rWE4-Ks1Q1YOQ@mail.gmail.com>
References: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA@mail.gmail.com>
 <CY4PR12MB13045EA9BCBFAB20D698BA86FE860@CY4PR12MB1304.namprd12.prod.outlook.com>
 <CAEzXK1rJbXSpLUm=XQTLvySM4HJ45G9fQ0WCTPhnvdPETwUaYA@mail.gmail.com>
 <53cc38f2-e94a-1514-0a03-303101db2f88@daenzer.net>
 <CAEzXK1qHtfOBgismLvNy_x+NcMw78288AuwovBR-JmRwqpDmGQ@mail.gmail.com>
 <CAEzXK1oM6b1bV3R3ezwD4eYrJXWV9+cdUFMC4q5+1bPkpmJFqQ@mail.gmail.com>
 <CAEzXK1qRWkL67rG40jk4Odqm8AjbDvnnaCsDycLPRcPXXPL-KQ@mail.gmail.com>
 <22178876-688c-b4fe-d40e-1bab28024603@daenzer.net>
 <CAEzXK1q+pMZgg7a7TMkNaDPhe90NkCc7MtAfE98vRY5tGDfW4A@mail.gmail.com>
 <CAEzXK1pZqFMZ8Qos3h7E-aYdmBE18GKFSamPV+0ZsXu=CatKRA@mail.gmail.com>
 <CAEzXK1qtjy+OaBh5rkzOXrTYe4Zq1w5bzdzTSRuCuDcm-kx-fA@mail.gmail.com>
 <CAEzXK1ryiqqrxTr5mn+Y4VvNAn-LtQb-0cBTitKKoQb+4B1=Qg@mail.gmail.com>
 <CAEzXK1ob33a28y_jwj_8ovr_ZDiowMAiUrnAQxS4vM5PK3NzzQ@mail.gmail.com>
 <CAEzXK1oTc9p5hS97qNQHaW3Z82FXsDprSpfG4qVDhwT6VAaOhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1912015616=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1oTc9p5hS97qNQHaW3Z82FXsDprSpfG4qVDhwT6VAaOhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1912015616==
Content-Type: multipart/alternative; boundary="0000000000003311230570ac56b9"

--0000000000003311230570ac56b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Issue remains in kernel 4.17.5, tested with SAPPHIRE RX 550 4GB running
same OpenCL kernel.

[  227.443025] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
timeout, last signaled seq=3D22, last emitted seq=3D25
[  227.443112] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1
timeout, last signaled seq=3D22, last emitted seq=3D24
[  227.443117] [drm] IP block:gmc_v8_0 is hung!
[  227.443120] [drm] IP block:tonga_ih is hung!
[  227.443123] [drm] IP block:gfx_v8_0 is hung!
[  227.443124] [drm] IP block:gmc_v8_0 is hung!
[  227.443126] [drm] IP block:tonga_ih is hung!
[  227.443127] [drm] IP block:sdma_v3_0 is hung!
[  227.443128] [drm] IP block:uvd_v6_0 is hung!
[  227.443130] [drm] IP block:gfx_v8_0 is hung!
[  227.443132] [drm] IP block:sdma_v3_0 is hung!
[  227.443133] [drm] IP block:vce_v3_0 is hung!
[  227.443134] [drm] GPU recovery disabled.
[  227.443137] [drm] IP block:uvd_v6_0 is hung!
[  227.443140] [drm] IP block:vce_v3_0 is hung!
[  227.443141] [drm] GPU recovery disabled.

Regards,
Lu=C3=ADs

On Tue, Jun 26, 2018 at 10:03 AM, Lu=C3=ADs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
wrote:

>
> I've tested Ubuntu 18.04 with kernel 4.17.2 using libdrm-2.4.92 and
> mesa-18.1.0 and AMD RX 550 4GB is still hanging when running the identifi=
ed
> OpenCL kernels.
>
> [  548.704916] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> timeout, last signaled seq=3D30, last emitted seq=3D33
> [  548.704988] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1
> timeout, last signaled seq=3D29, last emitted seq=3D31
> [  548.704992] [drm] IP block:gmc_v8_0 is hung!
> [  548.704994] [drm] IP block:tonga_ih is hung!
> [  548.704996] [drm] IP block:gmc_v8_0 is hung!
> [  548.704997] [drm] IP block:gfx_v8_0 is hung!
> [  548.704998] [drm] IP block:sdma_v3_0 is hung!
> [  548.704999] [drm] IP block:tonga_ih is hung!
> [  548.705000] [drm] IP block:uvd_v6_0 is hung!
> [  548.705001] [drm] IP block:gfx_v8_0 is hung!
> [  548.705002] [drm] IP block:sdma_v3_0 is hung!
> [  548.705003] [drm] IP block:uvd_v6_0 is hung!
> [  548.705004] [drm] IP block:vce_v3_0 is hung!
> [  548.705005] [drm] GPU recovery disabled.
> [  548.705006] [drm] IP block:vce_v3_0 is hung!
> [  548.705007] [drm] GPU recovery disabled.
>
> Are there any new regarding this issue?
>
> Regards,
> Lu=C3=ADs
>
> On Fri, May 25, 2018 at 11:23 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail.c=
om>
> wrote:
>
>> I've just tested Ubuntu 18.04 with kernel 4.17-rc6 using libdrm-2.4.92
>> and mesa-18.1.0.
>> Now both sdma0 and sdma1 timeout as can be seen in the attached logs.
>>
>> ~agd5f -b drm-next-4.18 doesn't improve also.
>>
>> I have also tried amdgpu-pro 18.20 both on Ubuntu 18.04 and 16.04, but n=
o
>> improvements.
>> I have tried amdgpu-pro 18.10 and 17.50 and also no improvements.
>>
>> ./amdgpu-pro-install -opencl=3Dlegacy,pal --headless
>>
>> On Thu, May 24, 2018 at 11:18 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail.=
com>
>> wrote:
>>
>>> Additional update...
>>>
>>> I was able to boot and enter X by installing an NVIDIA GTX 1050 Ti as
>>> the primary display card and using an AMD RX 550 as the secondary card =
on
>>> the Tyan S7025 with the same Ubuntu 18.04 and the same Linux kernel
>>> 4.17-rc6.
>>> However once I try to run an OpenCL kernel on RX 550 I get a sdma1
>>> timeout and the GPU hangs, which likely what is happening when I boot w=
ith
>>> RX 550 as the single GPU card on the system.
>>>
>>> This means it is not an issue introduced in 4.17-rc6, it just means tha=
t
>>> I didn't notice the effect of the system with the two GPUs vs system wi=
th
>>> single AMD GPU.
>>>
>>> The dmesg log follows attached.
>>>
>>> Lu=C3=ADs
>>>
>>> On Thu, May 24, 2018 at 10:13 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail=
.com>
>>> wrote:
>>>
>>>> Hi Michel,
>>>>
>>>> I also work as a researcher at a university and we are considering
>>>> buying AMD cards to do OpenCL computations for numerical modelling, bu=
t
>>>> currently I am unable to give a try at the AMD cards I have at home.
>>>> I couldn't find any working driver for them... also amdgpu-pro drivers
>>>> don't work, or at least I have been unable to make them work.
>>>>
>>>> Regards,
>>>> Lu=C3=ADs
>>>>
>>>> On Thu, May 24, 2018 at 10:01 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmai=
l.com>
>>>> wrote:
>>>>
>>>>> Hi Michel,
>>>>>
>>>>> So summarizing with Linux kernel 4.17-rc6 on Ubuntu 18.04 using AMD R=
X
>>>>> 460/RX 550 I am not able to enter X.
>>>>> The same system with AMD Radeon R7 240 not only enters X as also runs
>>>>> the OpenCL kernel that RX 460 / RX 550 are unable to run for all the
>>>>> kernels that I have tested.
>>>>> Could this also be a Mesa issue, regarding OpenCL on RX 460?
>>>>>
>>>>> Regards,
>>>>> Lu=C3=ADs
>>>>>
>>>>> On Thu, May 24, 2018 at 9:55 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmai=
l.com>
>>>>> wrote:
>>>>>
>>>>>> Hi Michel,
>>>>>>
>>>>>> I will have to check previous rc releases of 4.17 to see if it wasn'=
t
>>>>>> already happening, before trying any possible git bisect.
>>>>>> As an update I can say that an AMD Radeon R7 240 works fine on the
>>>>>> same system with the same kernel and I am able to run the OpenCL ker=
nels,
>>>>>> that I couldn't with RX 460/RX 550.
>>>>>>
>>>>>> Regards,
>>>>>> Lu=C3=ADs
>>>>>>
>>>>>> On Thu, May 24, 2018 at 9:30 AM, Michel D=C3=A4nzer <michel@daenzer.=
net>
>>>>>> wrote:
>>>>>>
>>>>>>> On 2018-05-24 12:06 AM, Lu=C3=ADs Mendes wrote:
>>>>>>> > I've tried Linux 4.17-rc6 with Ubuntu 18.04 on Tyan S7002 and I a=
m
>>>>>>> not even
>>>>>>> > able see lightdm/gdm3 as system hangs when starting X.
>>>>>>> > Having SR-IOV enabled or disabled makes no difference.
>>>>>>> > Tested with AMD RX 460.
>>>>>>> > When X is supposed to start the system hangs and only a
>>>>>>> rectangular region
>>>>>>> > on the top left corner screen remains with console text messages
>>>>>>> from the
>>>>>>> > boot process while the remaining of the screen is just black. I a=
m
>>>>>>> unable
>>>>>>> > to do anything with the keyboard, switching to console does not
>>>>>>> work,
>>>>>>> > ctrl-alt-del also doesn't work. I've to do a cold reset.
>>>>>>>
>>>>>>> Can you isolate which change introduced this new issue with git
>>>>>>> bisect?
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Earthling Michel D=C3=A4nzer               |
>>>>>>> http://www.amd.com
>>>>>>> Libre software enthusiast             |             Mesa and X
>>>>>>> developer
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>

--0000000000003311230570ac56b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Issue remains in kernel =
4.17.5, tested with SAPPHIRE RX 550 4GB running same OpenCL kernel.</div><d=
iv><br></div><div>[=C2=A0 227.443025] [drm:amdgpu_job_timedout [amdgpu]] *E=
RROR* ring sdma0 timeout, last signaled seq=3D22, last emitted seq=3D25<br>=
[=C2=A0 227.443112] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 t=
imeout, last signaled seq=3D22, last emitted seq=3D24<br>[=C2=A0 227.443117=
] [drm] IP block:gmc_v8_0 is hung!<br>[=C2=A0 227.443120] [drm] IP block:to=
nga_ih is hung!<br>[=C2=A0 227.443123] [drm] IP block:gfx_v8_0 is hung!<br>=
[=C2=A0 227.443124] [drm] IP block:gmc_v8_0 is hung!<br>[=C2=A0 227.443126]=
 [drm] IP block:tonga_ih is hung!<br>[=C2=A0 227.443127] [drm] IP block:sdm=
a_v3_0 is hung!<br>[=C2=A0 227.443128] [drm] IP block:uvd_v6_0 is hung!<br>=
[=C2=A0 227.443130] [drm] IP block:gfx_v8_0 is hung!<br>[=C2=A0 227.443132]=
 [drm] IP block:sdma_v3_0 is hung!<br>[=C2=A0 227.443133] [drm] IP block:vc=
e_v3_0 is hung!<br>[=C2=A0 227.443134] [drm] GPU recovery disabled.<br>[=C2=
=A0 227.443137] [drm] IP block:uvd_v6_0 is hung!<br>[=C2=A0 227.443140] [dr=
m] IP block:vce_v3_0 is hung!<br>[=C2=A0 227.443141] [drm] GPU recovery dis=
abled.<br></div><div><br></div><div>Regards,</div><div>Lu=C3=ADs<br></div><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jun =
26, 2018 at 10:03 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><=
br></div><div>I&#39;ve tested Ubuntu 18.04 with kernel 4.17.2 using libdrm-=
2.4.92 and mesa-18.1.0 and AMD RX 550 4GB is still hanging when running the=
 identified OpenCL kernels.</div><div><br></div><div>[=C2=A0 548.704916] [d=
rm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 timeout, last signaled =
seq=3D30, last emitted seq=3D33<br>[=C2=A0 548.704988] [drm:amdgpu_job_time=
dout [amdgpu]] *ERROR* ring sdma1 timeout, last signaled seq=3D29, last emi=
tted seq=3D31<br>[=C2=A0 548.704992] [drm] IP block:gmc_v8_0 is hung!<br>[=
=C2=A0 548.704994] [drm] IP block:tonga_ih is hung!<br>[=C2=A0 548.704996] =
[drm] IP block:gmc_v8_0 is hung!<br>[=C2=A0 548.704997] [drm] IP block:gfx_=
v8_0 is hung!<br>[=C2=A0 548.704998] [drm] IP block:sdma_v3_0 is hung!<br>[=
=C2=A0 548.704999] [drm] IP block:tonga_ih is hung!<br>[=C2=A0 548.705000] =
[drm] IP block:uvd_v6_0 is hung!<br>[=C2=A0 548.705001] [drm] IP block:gfx_=
v8_0 is hung!<br>[=C2=A0 548.705002] [drm] IP block:sdma_v3_0 is hung!<br>[=
=C2=A0 548.705003] [drm] IP block:uvd_v6_0 is hung!<br>[=C2=A0 548.705004] =
[drm] IP block:vce_v3_0 is hung!<br>[=C2=A0 548.705005] [drm] GPU recovery =
disabled.<br>[=C2=A0 548.705006] [drm] IP block:vce_v3_0 is hung!<br>[=C2=
=A0 548.705007] [drm] GPU recovery disabled.<br></div><div><br></div><div>A=
re there any new regarding this issue?</div><div><br></div><div>Regards,</d=
iv><div>Lu=C3=ADs<br></div></div><div class=3D"HOEnZb"><div class=3D"h5"><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, May 25, 201=
8 at 11:23 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:lui=
s.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>I&#39;ve=
 just tested Ubuntu 18.04 with kernel 4.17-rc6 using libdrm-2.4.92 and mesa=
-18.1.0.</div><div>Now both sdma0 and sdma1 timeout as can be seen in the a=
ttached logs.</div><div><br></div><div>~agd5f -b drm-next-4.18 doesn&#39;t =
improve also.</div><div><br></div><div>I have also tried amdgpu-pro 18.20 b=
oth on Ubuntu 18.04 and 16.04, but no improvements.</div><div>I have tried =
amdgpu-pro 18.10 and 17.50 and also no improvements.</div><div><br></div><d=
iv>./amdgpu-pro-install -opencl=3Dlegacy,pal --headless<br></div></div><div=
 class=3D"m_4906582418008722898HOEnZb"><div class=3D"m_4906582418008722898h=
5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 24=
, 2018 at 11:18 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Add=
itional update...</div><div><br></div><div>I was able to boot and enter X b=
y installing an NVIDIA GTX 1050 Ti as the primary display card and using an=
 AMD RX 550 as the secondary card on the Tyan S7025 with the same Ubuntu 18=
.04 and the same Linux kernel 4.17-rc6.</div><div>However once I try to run=
 an OpenCL kernel on RX 550 I get a sdma1 timeout and the GPU hangs, which =
likely what is happening when I boot with RX 550 as the single GPU card on =
the system.</div><div><br></div><div>This means it is not an issue introduc=
ed in 4.17-rc6, it just means that I didn&#39;t notice the effect of the sy=
stem with the two GPUs vs system with single AMD GPU.<br></div><div><br></d=
iv><div>The dmesg log follows attached.</div><span class=3D"m_4906582418008=
722898m_-2792494690060611914HOEnZb"><font color=3D"#888888"><div><br></div>=
<div>Lu=C3=ADs<br></div></font></span><div><div class=3D"m_4906582418008722=
898m_-2792494690060611914h5"><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Thu, May 24, 2018 at 10:13 AM, Lu=C3=ADs Mendes <span dir=3D=
"ltr">&lt;<a href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis=
.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div dir=3D"ltr"><div>Hi Michel,</div><div><br></div><div>I also work as a=
 researcher at a university and we are considering buying AMD cards to do O=
penCL computations for numerical modelling, but currently I am unable to gi=
ve a try at the AMD cards I have at home. <br></div><div>I couldn&#39;t fin=
d any working driver for them... also amdgpu-pro drivers don&#39;t work, or=
 at least I have been unable to make them work.</div><div><br></div><div>Re=
gards,</div><div>Lu=C3=ADs<br></div></div><div class=3D"m_49065824180087228=
98m_-2792494690060611914m_-7330547345245497836HOEnZb"><div class=3D"m_49065=
82418008722898m_-2792494690060611914m_-7330547345245497836h5"><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 24, 2018 at 10:01 =
AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:luis.p.mendes@=
gmail.com" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi Michel,</div><di=
v><br></div><div>So summarizing with Linux kernel 4.17-rc6 on Ubuntu 18.04 =
using AMD RX 460/RX 550 I am not able to enter X.</div><div>The same system=
 with AMD Radeon R7 240 not only enters X as also runs the OpenCL kernel th=
at RX 460 / RX 550 are unable to run for all the kernels that I have tested=
.</div><div>Could this also be a Mesa issue, regarding OpenCL on RX 460?</d=
iv><div><br></div><div>Regards,</div><div>Lu=C3=ADs<br></div></div><div cla=
ss=3D"m_4906582418008722898m_-2792494690060611914m_-7330547345245497836m_-2=
589740912204989814HOEnZb"><div class=3D"m_4906582418008722898m_-27924946900=
60611914m_-7330547345245497836m_-2589740912204989814h5"><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Thu, May 24, 2018 at 9:55 AM, Lu=
=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:luis.p.mendes@gmail.=
com" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi Michel,</div><div><br>=
</div><div>I will have to check previous rc releases of 4.17 to see if it w=
asn&#39;t already happening, before trying any possible git bisect.</div><d=
iv>As an update I can say that an AMD Radeon R7 240 works fine on the same =
system with the same kernel and I am able to run the OpenCL kernels, that I=
 couldn&#39;t with RX 460/RX 550.</div><div><br></div><div>Regards,</div><d=
iv>Lu=C3=ADs<br></div></div><div class=3D"m_4906582418008722898m_-279249469=
0060611914m_-7330547345245497836m_-2589740912204989814m_-883146755642022966=
8HOEnZb"><div class=3D"m_4906582418008722898m_-2792494690060611914m_-733054=
7345245497836m_-2589740912204989814m_-8831467556420229668h5"><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 24, 2018 at 9:30 AM=
, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@daenzer=
.net" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><span>On 2018-05-24 12:06 AM, Lu=C3=ADs Mendes wrot=
e:<br>
&gt; I&#39;ve tried Linux 4.17-rc6 with Ubuntu 18.04 on Tyan S7002 and I am=
 not even<br>
&gt; able see lightdm/gdm3 as system hangs when starting X.<br>
&gt; Having SR-IOV enabled or disabled makes no difference.<br>
&gt; Tested with AMD RX 460.<br>
&gt; When X is supposed to start the system hangs and only a rectangular re=
gion<br>
&gt; on the top left corner screen remains with console text messages from =
the<br>
&gt; boot process while the remaining of the screen is just black. I am una=
ble<br>
&gt; to do anything with the keyboard, switching to console does not work,<=
br>
&gt; ctrl-alt-del also doesn&#39;t work. I&#39;ve to do a cold reset.<br>
<br>
</span>Can you isolate which change introduced this new issue with git bise=
ct?<br>
<div class=3D"m_4906582418008722898m_-2792494690060611914m_-733054734524549=
7836m_-2589740912204989814m_-8831467556420229668m_-6894958231640817724HOEnZ=
b"><div class=3D"m_4906582418008722898m_-2792494690060611914m_-733054734524=
5497836m_-2589740912204989814m_-8831467556420229668m_-6894958231640817724h5=
"><br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div></div></div></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--0000000000003311230570ac56b9--

--===============1912015616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1912015616==--
