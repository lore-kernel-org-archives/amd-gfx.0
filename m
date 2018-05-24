From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Thu, 24 May 2018 10:01:57 +0100
Message-ID: <CAEzXK1pZqFMZ8Qos3h7E-aYdmBE18GKFSamPV+0ZsXu=CatKRA@mail.gmail.com>
References: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA@mail.gmail.com>
 <CY4PR12MB13045EA9BCBFAB20D698BA86FE860@CY4PR12MB1304.namprd12.prod.outlook.com>
 <CAEzXK1rJbXSpLUm=XQTLvySM4HJ45G9fQ0WCTPhnvdPETwUaYA@mail.gmail.com>
 <53cc38f2-e94a-1514-0a03-303101db2f88@daenzer.net>
 <CAEzXK1qHtfOBgismLvNy_x+NcMw78288AuwovBR-JmRwqpDmGQ@mail.gmail.com>
 <CAEzXK1oM6b1bV3R3ezwD4eYrJXWV9+cdUFMC4q5+1bPkpmJFqQ@mail.gmail.com>
 <CAEzXK1qRWkL67rG40jk4Odqm8AjbDvnnaCsDycLPRcPXXPL-KQ@mail.gmail.com>
 <22178876-688c-b4fe-d40e-1bab28024603@daenzer.net>
 <CAEzXK1q+pMZgg7a7TMkNaDPhe90NkCc7MtAfE98vRY5tGDfW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0859423397=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1q+pMZgg7a7TMkNaDPhe90NkCc7MtAfE98vRY5tGDfW4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0859423397==
Content-Type: multipart/alternative; boundary="00000000000056c9d9056cefe76c"

--00000000000056c9d9056cefe76c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michel,

So summarizing with Linux kernel 4.17-rc6 on Ubuntu 18.04 using AMD RX
460/RX 550 I am not able to enter X.
The same system with AMD Radeon R7 240 not only enters X as also runs the
OpenCL kernel that RX 460 / RX 550 are unable to run for all the kernels
that I have tested.
Could this also be a Mesa issue, regarding OpenCL on RX 460?

Regards,
Lu=C3=ADs

On Thu, May 24, 2018 at 9:55 AM, Lu=C3=ADs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi Michel,
>
> I will have to check previous rc releases of 4.17 to see if it wasn't
> already happening, before trying any possible git bisect.
> As an update I can say that an AMD Radeon R7 240 works fine on the same
> system with the same kernel and I am able to run the OpenCL kernels, that=
 I
> couldn't with RX 460/RX 550.
>
> Regards,
> Lu=C3=ADs
>
> On Thu, May 24, 2018 at 9:30 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> =
wrote:
>
>> On 2018-05-24 12:06 AM, Lu=C3=ADs Mendes wrote:
>> > I've tried Linux 4.17-rc6 with Ubuntu 18.04 on Tyan S7002 and I am not
>> even
>> > able see lightdm/gdm3 as system hangs when starting X.
>> > Having SR-IOV enabled or disabled makes no difference.
>> > Tested with AMD RX 460.
>> > When X is supposed to start the system hangs and only a rectangular
>> region
>> > on the top left corner screen remains with console text messages from
>> the
>> > boot process while the remaining of the screen is just black. I am
>> unable
>> > to do anything with the keyboard, switching to console does not work,
>> > ctrl-alt-del also doesn't work. I've to do a cold reset.
>>
>> Can you isolate which change introduced this new issue with git bisect?
>>
>>
>> --
>> Earthling Michel D=C3=A4nzer               |               http://www.am=
d.com
>> Libre software enthusiast             |             Mesa and X developer
>>
>
>

--00000000000056c9d9056cefe76c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michel,</div><div><br></div><div>So summarizing wi=
th Linux kernel 4.17-rc6 on Ubuntu 18.04 using AMD RX 460/RX 550 I am not a=
ble to enter X.</div><div>The same system with AMD Radeon R7 240 not only e=
nters X as also runs the OpenCL kernel that RX 460 / RX 550 are unable to r=
un for all the kernels that I have tested.</div><div>Could this also be a M=
esa issue, regarding OpenCL on RX 460?</div><div><br></div><div>Regards,</d=
iv><div>Lu=C3=ADs<br></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, May 24, 2018 at 9:55 AM, Lu=C3=ADs Mendes <span di=
r=3D"ltr">&lt;<a href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">=
luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div dir=3D"ltr"><div>Hi Michel,</div><div><br></div><div>I will have =
to check previous rc releases of 4.17 to see if it wasn&#39;t already happe=
ning, before trying any possible git bisect.</div><div>As an update I can s=
ay that an AMD Radeon R7 240 works fine on the same system with the same ke=
rnel and I am able to run the OpenCL kernels, that I couldn&#39;t with RX 4=
60/RX 550.</div><div><br></div><div>Regards,</div><div>Lu=C3=ADs<br></div><=
/div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Thu, May 24, 2018 at 9:30 AM, Michel D=C3=A4=
nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"=
_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span>On 2018-05-24 12:06 AM, Lu=C3=ADs Mendes wrote:<br>
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
<div class=3D"m_-6894958231640817724HOEnZb"><div class=3D"m_-68949582316408=
17724h5"><br>
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

--00000000000056c9d9056cefe76c--

--===============0859423397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0859423397==--
