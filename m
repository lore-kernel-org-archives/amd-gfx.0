From: Andrew Stone <andrewstone97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PROBLEM: linux-firmware provided firmware files do not support
 AMDVLK driver
Date: Wed, 18 Apr 2018 14:43:51 +0000
Message-ID: <CABVSYoeR04XNJrrOjru77LppAi-GWt0d5Sfib1vAdzj-tGmcEA@mail.gmail.com>
References: <CABVSYof5NhbY51LYTqnVcv=TFoVPO1QTWuP2XVJed2wBnv7oQA@mail.gmail.com>
 <CADnq5_MjEKLVBB13g5F1CE_Fp5x7ZrJvR00_9GT48mQEvLqTZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0450286746=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MjEKLVBB13g5F1CE_Fp5x7ZrJvR00_9GT48mQEvLqTZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0450286746==
Content-Type: multipart/alternative; boundary="0000000000005e4f56056a207cfd"

--0000000000005e4f56056a207cfd
Content-Type: text/plain; charset="UTF-8"

Thanks. I wasn't aware of that issue. The updated firmware seems to work
fine with Radeon drivers on my machine. (After updating the firmware, I
booted with Radeon.si_support=1 Radeon.cik_support=1 amdgpu.si_support=0
amdgpu.cik_support=0) though I've messed with my system a lot to get AMDVLK
working so I'm not sure it's really using radeon. It should be. And the GL
version is 1.4 now. I obviously can't speak for other cards and I haven't
done extensive testing by any means, but it seems to work.

On Tue, Apr 17, 2018, 21:58 Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, Apr 17, 2018 at 11:16 PM, boomboom psh <andrewstone97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > [1.] linux-firmware provided firmware files do not support AMDVLK driver
> > [2.] Full description of the problem/report: Vulkan instance fails to
> load
> > on the AMDVLK driver, using a radeon HD7770 card. It throws a
> > VK_ERROR_OUT_OF_HOST_MEMORY. This appears to be due to an outdated
> > firmware, as replacing the firmware with the firmware provided by the
> > amdgpu-pro driver fixes the issue (
> > https://github.com/GPUOpen-Drivers/AMDVLK/issues/17). The issue appears
> to
> > also be present on pitcairn cards. (
> > https://github.com/GPUOpen-Drivers/AMDVLK/issues/25)
> > [3.] firmware, AMDVLK, vulkan, SI, verde, pitcairn
> > [4.1.] Linux version 4.15.15-1-ARCH (builduser@heftig-4572) (gcc version
> > 7.3.1 20180312 (GCC)) #1 SMP PREEMPT Sat Mar 31 23:59:25 UTC 2018
> > [7.] vulkaninfo from
> > https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers
> > demonstrates the problem
> > [8.] AMD Ryzen 3 1200, 8GB DDR4, Radeon HD7770 1GB
> > [X.] Workaround: copy firmware from amdgpupro driver, however this must
> be
> > redone every time there is an update to linux-firmware.
>
> The newer SI firmware only works with amdgpu right now.  At the moment
> the upstream SI firmware is shared with radeon.  We'd need to use
> separate firmwares for radeon and amdgpu for SI.  No one has gotten
> around to switching it yet.
>
> Alex
>

--0000000000005e4f56056a207cfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks. I wasn&#39;t aware of that issue. The updated fir=
mware seems to work fine with Radeon drivers on my machine. (After updating=
 the firmware, I booted with Radeon.si_support=3D1 Radeon.cik_support=3D1 a=
mdgpu.si_support=3D0 amdgpu.cik_support=3D0) though I&#39;ve messed with my=
 system a lot to get AMDVLK working so I&#39;m not sure it&#39;s really usi=
ng radeon. It should be. And the GL version is 1.4 now. I obviously can&#39=
;t speak for other cards and I haven&#39;t done extensive testing by any me=
ans, but it seems to work.</div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr">On Tue, Apr 17, 2018, 21:58 Alex Deucher &lt;<a href=3D"mailto:alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Apr 17, 2018=
 at 11:16 PM, boomboom psh &lt;<a href=3D"mailto:andrewstone97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" r=
el=3D"noreferrer noreferrer" target=3D"_blank">andrewstone97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt; wrote:<br>
&gt; [1.] linux-firmware provided firmware files do not support AMDVLK driv=
er<br>
&gt; [2.] Full description of the problem/report: Vulkan instance fails to =
load<br>
&gt; on the AMDVLK driver, using a radeon HD7770 card. It throws a<br>
&gt; VK_ERROR_OUT_OF_HOST_MEMORY. This appears to be due to an outdated<br>
&gt; firmware, as replacing the firmware with the firmware provided by the<=
br>
&gt; amdgpu-pro driver fixes the issue (<br>
&gt; <a href=3D"https://github.com/GPUOpen-Drivers/AMDVLK/issues/17" rel=3D=
"noreferrer noreferrer noreferrer" target=3D"_blank">https://github.com/GPU=
Open-Drivers/AMDVLK/issues/17</a>). The issue appears to<br>
&gt; also be present on pitcairn cards. (<br>
&gt; <a href=3D"https://github.com/GPUOpen-Drivers/AMDVLK/issues/25" rel=3D=
"noreferrer noreferrer noreferrer" target=3D"_blank">https://github.com/GPU=
Open-Drivers/AMDVLK/issues/25</a>)<br>
&gt; [3.] firmware, AMDVLK, vulkan, SI, verde, pitcairn<br>
&gt; [4.1.] Linux version 4.15.15-1-ARCH (builduser@heftig-4572) (gcc versi=
on<br>
&gt; 7.3.1 20180312 (GCC)) #1 SMP PREEMPT Sat Mar 31 23:59:25 UTC 2018<br>
&gt; [7.] vulkaninfo from<br>
&gt; <a href=3D"https://github.com/KhronosGroup/Vulkan-LoaderAndValidationL=
ayers" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://g=
ithub.com/KhronosGroup/Vulkan-LoaderAndValidationLayers</a><br>
&gt; demonstrates the problem<br>
&gt; [8.] AMD Ryzen 3 1200, 8GB DDR4, Radeon HD7770 1GB<br>
&gt; [X.] Workaround: copy firmware from amdgpupro driver, however this mus=
t be<br>
&gt; redone every time there is an update to linux-firmware.<br>
<br>
The newer SI firmware only works with amdgpu right now.=C2=A0 At the moment=
<br>
the upstream SI firmware is shared with radeon.=C2=A0 We&#39;d need to use<=
br>
separate firmwares for radeon and amdgpu for SI.=C2=A0 No one has gotten<br=
>
around to switching it yet.<br>
<br>
Alex<br>
</blockquote></div>

--0000000000005e4f56056a207cfd--

--===============0450286746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0450286746==--
