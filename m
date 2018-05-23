From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Wed, 23 May 2018 23:06:28 +0100
Message-ID: <CAEzXK1qRWkL67rG40jk4Odqm8AjbDvnnaCsDycLPRcPXXPL-KQ@mail.gmail.com>
References: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA@mail.gmail.com>
 <CY4PR12MB13045EA9BCBFAB20D698BA86FE860@CY4PR12MB1304.namprd12.prod.outlook.com>
 <CAEzXK1rJbXSpLUm=XQTLvySM4HJ45G9fQ0WCTPhnvdPETwUaYA@mail.gmail.com>
 <53cc38f2-e94a-1514-0a03-303101db2f88@daenzer.net>
 <CAEzXK1qHtfOBgismLvNy_x+NcMw78288AuwovBR-JmRwqpDmGQ@mail.gmail.com>
 <CAEzXK1oM6b1bV3R3ezwD4eYrJXWV9+cdUFMC4q5+1bPkpmJFqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0630725629=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1oM6b1bV3R3ezwD4eYrJXWV9+cdUFMC4q5+1bPkpmJFqQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0630725629==
Content-Type: multipart/alternative; boundary="0000000000003041a3056ce6bffd"

--0000000000003041a3056ce6bffd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've tried Linux 4.17-rc6 with Ubuntu 18.04 on Tyan S7002 and I am not even
able see lightdm/gdm3 as system hangs when starting X.
Having SR-IOV enabled or disabled makes no difference.
Tested with AMD RX 460.
When X is supposed to start the system hangs and only a rectangular region
on the top left corner screen remains with console text messages from the
boot process while the remaining of the screen is just black. I am unable
to do anything with the keyboard, switching to console does not work,
ctrl-alt-del also doesn't work. I've to do a cold reset.


Regards,
Lu=C3=ADs


On Fri, May 11, 2018 at 1:15 PM, Lu=C3=ADs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi Michel,
>
> Just made a fresh Ubuntu 18.04 LTS install for armhf with ubuntu
> default mesa, libdrm and libclc, with the same 4.16.7 kernel and it
> runs fine with the OpenCL applications that cause the hang on x86_64.
> So it is surely a kernel or mesa issue exclusive to x86_64, libraries
> versions are the same on both systems now, as well as the kernel.
> I have even tried amdgpu-pro-18.20 with ubuntu 18.04 on x86_64 and it
> hangs just the same.
>
> Regards,
> Lu=C3=ADs
>
> On Mon, May 7, 2018 at 1:31 PM, Lu=C3=ADs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> wrote:
> > Hi Michel,
> >
> > No, I haven't tried the exact same versions of Mesa, nor libclc, nor
> > LLVM on x86, however on armhf I have been able to use several
> > combinations of Linux kernel versions and mesa versions which are able
> > to run the OpenCL kernels in question. I will try to see if the same
> > happens with the exact same Ubuntu 18.04 LTS base installation on
> > armhf, but won't be able to test it today.
> >
> > Lu=C3=ADs
> >
> > On Mon, May 7, 2018 at 10:38 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org=
>
> wrote:
> >> On 2018-05-05 01:15 AM, Lu=C3=ADs Mendes wrote:
> >>>
> >>> - On another system with armhf 32 bits, 1GB ram, 512GB SSD, AMD RX 48=
0
> >>> or AMD RX 550
> >>>   with Ubuntu 17.10, vanilla kernel 4.16.7, mesa-18.0.2,
> >>> libdrm-2.4.92-git, libclc-git at commit
> >>> 3d994f2ff2cbb4531223fe2657144cb19f0c5328 (15/Nov/2017)
> >>>
> >>>   The kernels work properly on the same AMD cards.
> >>
> >> Have you tried those exact same versions of the kernel, Mesa, libclc a=
nd
> >> LLVM on x86?
> >>
> >>
> >> --
> >> Earthling Michel D=C3=A4nzer               |
> http://www.amd.com
> >> Libre software enthusiast             |             Mesa and X develop=
er
>

--0000000000003041a3056ce6bffd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve tried Linux 4.17-rc6 with Ubuntu 18.04 on Ty=
an S7002 and I am not even able see lightdm/gdm3 as system hangs when start=
ing X.</div><div>Having SR-IOV enabled or disabled makes no difference.</di=
v><div>Tested with AMD RX 460. <br></div><div>When X is supposed to start t=
he system hangs and only a rectangular region on the top left corner screen=
 remains with console text messages from the boot process while the remaini=
ng of the screen is just black. I am unable to do anything with the keyboar=
d, switching to console does not work, ctrl-alt-del also doesn&#39;t work. =
I&#39;ve to do a cold reset. <br></div><div><br></div><div><br></div><div>R=
egards,</div><div>Lu=C3=ADs<br></div><div><br></div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Fri, May 11, 2018 at 1:15 PM, L=
u=C3=ADs Mendes <span dir=3D"ltr">&lt;<a href=3D"mailto:luis.p.mendes@gmail=
.com" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Hi Michel,<br>
<br>
Just made a fresh Ubuntu 18.04 LTS install for armhf with ubuntu<br>
default mesa, libdrm and libclc, with the same 4.16.7 kernel and it<br>
runs fine with the OpenCL applications that cause the hang on x86_64.<br>
So it is surely a kernel or mesa issue exclusive to x86_64, libraries<br>
versions are the same on both systems now, as well as the kernel.<br>
I have even tried amdgpu-pro-18.20 with ubuntu 18.04 on x86_64 and it<br>
hangs just the same.<br>
<br>
Regards,<br>
Lu=C3=ADs<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Mon, May 7, 2018 at 1:31 PM, Lu=C3=ADs Mendes &lt;<a href=3D"mailto:luis=
.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi Michel,<br>
&gt;<br>
&gt; No, I haven&#39;t tried the exact same versions of Mesa, nor libclc, n=
or<br>
&gt; LLVM on x86, however on armhf I have been able to use several<br>
&gt; combinations of Linux kernel versions and mesa versions which are able=
<br>
&gt; to run the OpenCL kernels in question. I will try to see if the same<b=
r>
&gt; happens with the exact same Ubuntu 18.04 LTS base installation on<br>
&gt; armhf, but won&#39;t be able to test it today.<br>
&gt;<br>
&gt; Lu=C3=ADs<br>
&gt;<br>
&gt; On Mon, May 7, 2018 at 10:38 AM, Michel D=C3=A4nzer &lt;<a href=3D"mai=
lto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; On 2018-05-05 01:15 AM, Lu=C3=ADs Mendes wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - On another system with armhf 32 bits, 1GB ram, 512GB SSD, AM=
D RX 480<br>
&gt;&gt;&gt; or AMD RX 550<br>
&gt;&gt;&gt;=C2=A0 =C2=A0with Ubuntu 17.10, vanilla kernel 4.16.7, mesa-18.=
0.2,<br>
&gt;&gt;&gt; libdrm-2.4.92-git, libclc-git at commit<br>
&gt;&gt;&gt; 3d994f2ff2cbb4531223fe2657144c<wbr>b19f0c5328 (15/Nov/2017)<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0The kernels work properly on the same AMD cards.<b=
r>
&gt;&gt;<br>
&gt;&gt; Have you tried those exact same versions of the kernel, Mesa, libc=
lc and<br>
&gt;&gt; LLVM on x86?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a=
 href=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://ww=
w.amd.com</a><br>
&gt;&gt; Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X develope=
r<br>
</div></div></blockquote></div><br></div>

--0000000000003041a3056ce6bffd--

--===============0630725629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0630725629==--
