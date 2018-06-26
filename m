From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Tue, 26 Jun 2018 10:03:17 +0100
Message-ID: <CAEzXK1oTc9p5hS97qNQHaW3Z82FXsDprSpfG4qVDhwT6VAaOhQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1088566279=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1ob33a28y_jwj_8ovr_ZDiowMAiUrnAQxS4vM5PK3NzzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1088566279==
Content-Type: multipart/alternative; boundary="000000000000e30ab3056f87c4ce"

--000000000000e30ab3056f87c4ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've tested Ubuntu 18.04 with kernel 4.17.2 using libdrm-2.4.92 and
mesa-18.1.0 and AMD RX 550 4GB is still hanging when running the identified
OpenCL kernels.

[  548.704916] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
timeout, last signaled seq=3D30, last emitted seq=3D33
[  548.704988] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1
timeout, last signaled seq=3D29, last emitted seq=3D31
[  548.704992] [drm] IP block:gmc_v8_0 is hung!
[  548.704994] [drm] IP block:tonga_ih is hung!
[  548.704996] [drm] IP block:gmc_v8_0 is hung!
[  548.704997] [drm] IP block:gfx_v8_0 is hung!
[  548.704998] [drm] IP block:sdma_v3_0 is hung!
[  548.704999] [drm] IP block:tonga_ih is hung!
[  548.705000] [drm] IP block:uvd_v6_0 is hung!
[  548.705001] [drm] IP block:gfx_v8_0 is hung!
[  548.705002] [drm] IP block:sdma_v3_0 is hung!
[  548.705003] [drm] IP block:uvd_v6_0 is hung!
[  548.705004] [drm] IP block:vce_v3_0 is hung!
[  548.705005] [drm] GPU recovery disabled.
[  548.705006] [drm] IP block:vce_v3_0 is hung!
[  548.705007] [drm] GPU recovery disabled.

Are there any new regarding this issue?

Regards,
Lu=C3=ADs

On Fri, May 25, 2018 at 11:23 AM, Lu=C3=ADs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
wrote:

> I've just tested Ubuntu 18.04 with kernel 4.17-rc6 using libdrm-2.4.92 an=
d
> mesa-18.1.0.
> Now both sdma0 and sdma1 timeout as can be seen in the attached logs.
>
> ~agd5f -b drm-next-4.18 doesn't improve also.
>
> I have also tried amdgpu-pro 18.20 both on Ubuntu 18.04 and 16.04, but no
> improvements.
> I have tried amdgpu-pro 18.10 and 17.50 and also no improvements.
>
> ./amdgpu-pro-install -opencl=3Dlegacy,pal --headless
>
> On Thu, May 24, 2018 at 11:18 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail.c=
om>
> wrote:
>
>> Additional update...
>>
>> I was able to boot and enter X by installing an NVIDIA GTX 1050 Ti as th=
e
>> primary display card and using an AMD RX 550 as the secondary card on th=
e
>> Tyan S7025 with the same Ubuntu 18.04 and the same Linux kernel 4.17-rc6=
.
>> However once I try to run an OpenCL kernel on RX 550 I get a sdma1
>> timeout and the GPU hangs, which likely what is happening when I boot wi=
th
>> RX 550 as the single GPU card on the system.
>>
>> This means it is not an issue introduced in 4.17-rc6, it just means that
>> I didn't notice the effect of the system with the two GPUs vs system wit=
h
>> single AMD GPU.
>>
>> The dmesg log follows attached.
>>
>> Lu=C3=ADs
>>
>> On Thu, May 24, 2018 at 10:13 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail.=
com>
>> wrote:
>>
>>> Hi Michel,
>>>
>>> I also work as a researcher at a university and we are considering
>>> buying AMD cards to do OpenCL computations for numerical modelling, but
>>> currently I am unable to give a try at the AMD cards I have at home.
>>> I couldn't find any working driver for them... also amdgpu-pro drivers
>>> don't work, or at least I have been unable to make them work.
>>>
>>> Regards,
>>> Lu=C3=ADs
>>>
>>> On Thu, May 24, 2018 at 10:01 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail=
.com>
>>> wrote:
>>>
>>>> Hi Michel,
>>>>
>>>> So summarizing with Linux kernel 4.17-rc6 on Ubuntu 18.04 using AMD RX
>>>> 460/RX 550 I am not able to enter X.
>>>> The same system with AMD Radeon R7 240 not only enters X as also runs
>>>> the OpenCL kernel that RX 460 / RX 550 are unable to run for all the
>>>> kernels that I have tested.
>>>> Could this also be a Mesa issue, regarding OpenCL on RX 460?
>>>>
>>>> Regards,
>>>> Lu=C3=ADs
>>>>
>>>> On Thu, May 24, 2018 at 9:55 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail=
.com>
>>>> wrote:
>>>>
>>>>> Hi Michel,
>>>>>
>>>>> I will have to check previous rc releases of 4.17 to see if it wasn't
>>>>> already happening, before trying any possible git bisect.
>>>>> As an update I can say that an AMD Radeon R7 240 works fine on the
>>>>> same system with the same kernel and I am able to run the OpenCL kern=
els,
>>>>> that I couldn't with RX 460/RX 550.
>>>>>
>>>>> Regards,
>>>>> Lu=C3=ADs
>>>>>
>>>>> On Thu, May 24, 2018 at 9:30 AM, Michel D=C3=A4nzer <michel@daenzer.n=
et>
>>>>> wrote:
>>>>>
>>>>>> On 2018-05-24 12:06 AM, Lu=C3=ADs Mendes wrote:
>>>>>> > I've tried Linux 4.17-rc6 with Ubuntu 18.04 on Tyan S7002 and I am
>>>>>> not even
>>>>>> > able see lightdm/gdm3 as system hangs when starting X.
>>>>>> > Having SR-IOV enabled or disabled makes no difference.
>>>>>> > Tested with AMD RX 460.
>>>>>> > When X is supposed to start the system hangs and only a rectangula=
r
>>>>>> region
>>>>>> > on the top left corner screen remains with console text messages
>>>>>> from the
>>>>>> > boot process while the remaining of the screen is just black. I am
>>>>>> unable
>>>>>> > to do anything with the keyboard, switching to console does not
>>>>>> work,
>>>>>> > ctrl-alt-del also doesn't work. I've to do a cold reset.
>>>>>>
>>>>>> Can you isolate which change introduced this new issue with git
>>>>>> bisect?
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Earthling Michel D=C3=A4nzer               |
>>>>>> http://www.amd.com
>>>>>> Libre software enthusiast             |             Mesa and X
>>>>>> developer
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>
>

--000000000000e30ab3056f87c4ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>I&#39;ve tested Ubuntu 18.04 with kern=
el 4.17.2 using libdrm-2.4.92 and mesa-18.1.0 and AMD RX 550 4GB is still h=
anging when running the identified OpenCL kernels.</div><div><br></div><div=
>[=C2=A0 548.704916] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 =
timeout, last signaled seq=3D30, last emitted seq=3D33<br>[=C2=A0 548.70498=
8] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 timeout, last sign=
aled seq=3D29, last emitted seq=3D31<br>[=C2=A0 548.704992] [drm] IP block:=
gmc_v8_0 is hung!<br>[=C2=A0 548.704994] [drm] IP block:tonga_ih is hung!<b=
r>[=C2=A0 548.704996] [drm] IP block:gmc_v8_0 is hung!<br>[=C2=A0 548.70499=
7] [drm] IP block:gfx_v8_0 is hung!<br>[=C2=A0 548.704998] [drm] IP block:s=
dma_v3_0 is hung!<br>[=C2=A0 548.704999] [drm] IP block:tonga_ih is hung!<b=
r>[=C2=A0 548.705000] [drm] IP block:uvd_v6_0 is hung!<br>[=C2=A0 548.70500=
1] [drm] IP block:gfx_v8_0 is hung!<br>[=C2=A0 548.705002] [drm] IP block:s=
dma_v3_0 is hung!<br>[=C2=A0 548.705003] [drm] IP block:uvd_v6_0 is hung!<b=
r>[=C2=A0 548.705004] [drm] IP block:vce_v3_0 is hung!<br>[=C2=A0 548.70500=
5] [drm] GPU recovery disabled.<br>[=C2=A0 548.705006] [drm] IP block:vce_v=
3_0 is hung!<br>[=C2=A0 548.705007] [drm] GPU recovery disabled.<br></div><=
div><br></div><div>Are there any new regarding this issue?</div><div><br></=
div><div>Regards,</div><div>Lu=C3=ADs<br></div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Fri, May 25, 2018 at 11:23 AM, Lu=C3=
=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"ltr"><div>I&#39;ve just tested Ubuntu =
18.04 with kernel 4.17-rc6 using libdrm-2.4.92 and mesa-18.1.0.</div><div>N=
ow both sdma0 and sdma1 timeout as can be seen in the attached logs.</div><=
div><br></div><div>~agd5f -b drm-next-4.18 doesn&#39;t improve also.</div><=
div><br></div><div>I have also tried amdgpu-pro 18.20 both on Ubuntu 18.04 =
and 16.04, but no improvements.</div><div>I have tried amdgpu-pro 18.10 and=
 17.50 and also no improvements.</div><div><br></div><div>./amdgpu-pro-inst=
all -opencl=3Dlegacy,pal --headless<br></div></div><div class=3D"HOEnZb"><d=
iv class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Thu, May 24, 2018 at 11:18 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a =
href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes@gma=
il.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr"><div>Additional update...</div><div><br></div><div>I was able to boot =
and enter X by installing an NVIDIA GTX 1050 Ti as the primary display card=
 and using an AMD RX 550 as the secondary card on the Tyan S7025 with the s=
ame Ubuntu 18.04 and the same Linux kernel 4.17-rc6.</div><div>However once=
 I try to run an OpenCL kernel on RX 550 I get a sdma1 timeout and the GPU =
hangs, which likely what is happening when I boot with RX 550 as the single=
 GPU card on the system.</div><div><br></div><div>This means it is not an i=
ssue introduced in 4.17-rc6, it just means that I didn&#39;t notice the eff=
ect of the system with the two GPUs vs system with single AMD GPU.<br></div=
><div><br></div><div>The dmesg log follows attached.</div><span class=3D"m_=
-2792494690060611914HOEnZb"><font color=3D"#888888"><div><br></div><div>Lu=
=C3=ADs<br></div></font></span><div><div class=3D"m_-2792494690060611914h5"=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 24, =
2018 at 10:13 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:=
luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi Mi=
chel,</div><div><br></div><div>I also work as a researcher at a university =
and we are considering buying AMD cards to do OpenCL computations for numer=
ical modelling, but currently I am unable to give a try at the AMD cards I =
have at home. <br></div><div>I couldn&#39;t find any working driver for the=
m... also amdgpu-pro drivers don&#39;t work, or at least I have been unable=
 to make them work.</div><div><br></div><div>Regards,</div><div>Lu=C3=ADs<b=
r></div></div><div class=3D"m_-2792494690060611914m_-7330547345245497836HOE=
nZb"><div class=3D"m_-2792494690060611914m_-7330547345245497836h5"><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 24, 2018 at 1=
0:01 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:luis.p.me=
ndes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi Michel,</di=
v><div><br></div><div>So summarizing with Linux kernel 4.17-rc6 on Ubuntu 1=
8.04 using AMD RX 460/RX 550 I am not able to enter X.</div><div>The same s=
ystem with AMD Radeon R7 240 not only enters X as also runs the OpenCL kern=
el that RX 460 / RX 550 are unable to run for all the kernels that I have t=
ested.</div><div>Could this also be a Mesa issue, regarding OpenCL on RX 46=
0?</div><div><br></div><div>Regards,</div><div>Lu=C3=ADs<br></div></div><di=
v class=3D"m_-2792494690060611914m_-7330547345245497836m_-25897409122049898=
14HOEnZb"><div class=3D"m_-2792494690060611914m_-7330547345245497836m_-2589=
740912204989814h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Thu, May 24, 2018 at 9:55 AM, Lu=C3=ADs Mendes <span dir=3D"ltr">&lt;<=
a href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes@g=
mail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div>Hi Michel,</div><div><br></div><div>I will have to check prev=
ious rc releases of 4.17 to see if it wasn&#39;t already happening, before =
trying any possible git bisect.</div><div>As an update I can say that an AM=
D Radeon R7 240 works fine on the same system with the same kernel and I am=
 able to run the OpenCL kernels, that I couldn&#39;t with RX 460/RX 550.</d=
iv><div><br></div><div>Regards,</div><div>Lu=C3=ADs<br></div></div><div cla=
ss=3D"m_-2792494690060611914m_-7330547345245497836m_-2589740912204989814m_-=
8831467556420229668HOEnZb"><div class=3D"m_-2792494690060611914m_-733054734=
5245497836m_-2589740912204989814m_-8831467556420229668h5"><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Thu, May 24, 2018 at 9:30 AM, M=
ichel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel-otUistvHUpNNg+MwTxZMZA@public.gmane.org=
t" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><span>On 2018-05-24 12:06 AM, Lu=C3=ADs Mendes wrote:<=
br>
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
<div class=3D"m_-2792494690060611914m_-7330547345245497836m_-25897409122049=
89814m_-8831467556420229668m_-6894958231640817724HOEnZb"><div class=3D"m_-2=
792494690060611914m_-7330547345245497836m_-2589740912204989814m_-8831467556=
420229668m_-6894958231640817724h5"><br>
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

--000000000000e30ab3056f87c4ce--

--===============1088566279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1088566279==--
