From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Regression_with_kernel_4=2E18_=2D_AMD_RX_550?=
 =?UTF-8?Q?_fails_IB_ring_test_on_power=2Dup?=
Date: Sat, 20 Oct 2018 18:58:10 +0100
Message-ID: <CAEzXK1p+Y16+6rcBXMywF3q+QDNpdZoHDsbkZD_T3J3rivhQPA@mail.gmail.com>
References: <CAEzXK1ofHUGNcZXM+Ys4xU9g0cSrdr63fxMVTCSq2-X4jwKfNw@mail.gmail.com>
 <CAEzXK1oftbBGeuzJEsn7bEJUmuiviq5h6cmmP0hP2+U77otZKA@mail.gmail.com>
 <DM3PR12MB0873E055CAF457DE917EC238995A0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <CAEzXK1pnvjJfe2Q0WVeGToyZNDH_GQD1eMJnf3R=GNQTbK8pjw@mail.gmail.com>
 <a0bbadba-18bb-12dd-a577-305c5178ddb8@amd.com>
 <CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w@mail.gmail.com>
 <45e7a84e-941a-fd7b-e08e-c9444ea1d77c@amd.com>
 <CAEzXK1rZfDL6JOZ08oES5Cpq+OxR+cj9Y_WYvT904m-xR2n3jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2070553393=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1rZfDL6JOZ08oES5Cpq+OxR+cj9Y_WYvT904m-xR2n3jQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: jimqu <jimqu-5C7GfCeVMHo@public.gmane.org>
Cc: "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2070553393==
Content-Type: multipart/alternative; boundary="00000000000008dce10578acc47c"

--00000000000008dce10578acc47c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The problems remains with Linux 4.18 and Linux 4.19 kernels. I am unable to
use AMD RX 460 and AMD RX 550 on my x64 Linux platforms.

I've installed Windows 10 in the same machine along with
win10-64bit-radeon-software-adrenalin-edition-18.10.1-oct18.exe and under
Windows the same RX 460 card *works fine* and I am able to run OpenCL
applications.

The driver is hanging since kernel 4.15, I am getting:
[   33.504100] [drm:drm_atomic_helper_wait_for_flip_done [drm_kms_helper]]
*ERROR* [CRTC:42:crtc-0] flip_done timed out
[   43.744094] [drm:drm_atomic_helper_wait_for_dependencies
[drm_kms_helper]] *ERROR* [CRTC:42:crtc-0] flip_done timed
out
[   53.984089] [drm:drm_atomic_helper_wait_for_dependencies
[drm_kms_helper]] *ERROR* [CONNECTOR:54:HDMI-A-1] flip_done timed
out
[   64.224036] [drm:drm_atomic_helper_wait_for_dependencies
[drm_kms_helper]] *ERROR* [PLANE:40:plane-4] flip_done timed
out
[   64.224141] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR*
amdgpu_dm_commit_planes: acrtc 0, already busy

And after commit: drm/amdgpu: defer test IBs on the rings at boot (V3)

2c773de2ecb8c327f2448bd1eecad224e9227087
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?h=3Dv4.18-rc4&id=3D2c773de2ecb8c327f2448bd1eecad224e9227087>
I get with kernels 4.18 and 4.19 as well as Ubuntu 18.10 stock kernel
(can't even install Ubuntu 18.10 because it hangs with amdgpu):
[drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR* amdgpu: IB test timed out.
[drm_amdgpu_ib_ring_tests [amdgpu]] *ERROR* amdgpu: failed testing IB on
GFX ring (-110).
[drm:amdgpu_device_ip_late_init_func_handler [amdgpu]] *ERROR* ib ring test
failed (-110).
[drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 timeout, last
signalled seq=3D0, last emitted seq=3D1
and the kernel blocks indefinitely:
task plymouthd:449 blocked for more than 120 seconds.

Is there any hope on getting this fixed?


On Thu, Jul 12, 2018 at 2:56 PM Lu=C3=ADs Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:

> Hi Jim,
>
> Replies in between.
>
> Regards,
> Lu=C3=ADs
>
> On Thu, Jul 12, 2018 at 3:16 AM, jimqu <jimqu-5C7GfCeVMHo@public.gmane.org> wrote:
>
>>
>>
>> On 2018=E5=B9=B407=E6=9C=8812=E6=97=A5 05:27, Lu=C3=ADs Mendes wrote:
>>
>> Hi Jim,
>>
>> I followed your suggestion and was able to bisect the kernel patches.
>> The offending patch is: drm/amdgpu: defer test IBs on the rings at boot
>> (V3)
>> commit:
>>
>> 2c773de2ecb8c327f2448bd1eecad224e9227087
>> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv4.18-rc4&id=3D2c773de2ecb8c327f2448bd1eecad224e9227087>
>>
>> After reverting this patch the IB test succeeded with kernel v4.18-rc4 o=
n
>> both systems and the amdgpu driver was correctly loaded both on SAPPHIRE
>> RX550 4GB and on SAPPHIRE RX460 2GB.
>>
>>
>> Alex, Christian, What do you think about the patch?
>>
>> The GPU hang remains, however.
>>  I will try to configure a remote IPMI connection to see what is
>> happening with the kernel boot or setup a serial console for the Kernel.
>>
>>
>> *You can set up remote connection by ssh, and also you can add amdgpu to
>> blacklist first, and manually modprobe amdgpu.*
>>
> R: I was able to setup a remote serial console with console=3DttyS0,11520=
n8
> kernel parameter.
> Boot log follows attached as file kernel_bisected_v4.18-rc4_log.txt.
> First noticeable issue seems to be:
> [    6.131989] amdgpu: [powerplay]
> [    6.131989]  last message was failed ret is 65535
> ...
> and later hangs with:
> [   33.504100] [drm:drm_atomic_helper_wait_for_flip_done [drm_kms_helper]=
]
> *ERROR* [CRTC:42:crtc-0] flip_done timed out
> [   43.744094] [drm:drm_atomic_helper_wait_for_dependencies
> [drm_kms_helper]] *ERROR* [CRTC:42:crtc-0] flip_done timed
> out
> [   53.984089] [drm:drm_atomic_helper_wait_for_dependencies
> [drm_kms_helper]] *ERROR* [CONNECTOR:54:HDMI-A-1] flip_done timed
> out
> [   64.224036] [drm:drm_atomic_helper_wait_for_dependencies
> [drm_kms_helper]] *ERROR* [PLANE:40:plane-4] flip_done timed
> out
> [   64.224141] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR*
> amdgpu_dm_commit_planes: acrtc 0, already
> busy
>
>
>
>> *What's about xinit? What is MESA driver version on your platform?*
>>
> R: I am running Ubuntu 18.04 with bisected kernel 4.18-rc4 using
> libdrm-2.4.92 and mesa-18.1.0.
> xinit output follows attached as xinit_log.txt
>
>
>>
>> Thanks & Regards,
>> Lu=C3=ADs
>>
>> On Wed, Jul 11, 2018 at 10:56 AM, jimqu <jimqu-5C7GfCeVMHo@public.gmane.org> wrote:
>>
>>> HI Luis,
>>>
>>>
>>> Let us trace the issue one by one.
>>>
>>>
>>> IB test fail:
>>>
>>> This should be regression issue on 4.18, you can bisect the kernel
>>> patches.
>>>
>>> GPU hang:
>>>
>>> Fix IB test fail first.
>>>
>>>
>>> Thanks
>>>
>>> JimQu
>>>
>>>
>>>
>>> On 2018=E5=B9=B407=E6=9C=8811=E6=97=A5 17:34, Lu=C3=ADs Mendes wrote:
>>>
>>> Hi Jim,
>>>
>>> Thanks for your interest in this issue. Actually this is a multiple
>>> issue... not only the IB ring test is failing... as I am having quite s=
ome
>>> trouble getting the cards SAPPHIRE RX 550 4GB on a Tyan S7025 and SAPPH=
IRE
>>> RX 460 2GB on a TYAN S7002 to work, both systems using same Ubuntu 18.0=
4
>>> with vanilla kernel.
>>>
>>> *1. May you also test earlier kernel? v4.17 or v4.16.*
>>> I've tested kernels v4.17.5 and v4.16.6 with same system and both are
>>> able to pass the IB ring test and system boots into X using NVIDIA as t=
he
>>> display connected card.
>>> dmesg log attached for kernel 4.17.5, file
>>> TYAN_S7025_kernelv4.17.5_amdgpu_IB_ring_test_OK.txt.
>>>
>>> *2. May you test the issue only with amdgpu?*
>>> - I've tested on a TYAN S7002 system with a single SAPPHIRE RX 460 2GB,
>>> on-board VGA enabled and used as primary display.
>>> Kernel v4.18-rc4 fails the IB ring test, system is able to enter X
>>> through the on-board VGA.
>>> dmesg log attached for kernel 4.18-rc4, file
>>> TYAN_S7002_kernel_v4.18-rc4_IB_ring_test_fail.txt.
>>>
>>> - Same TYAN S7002 system, but now with on-board VGA disabled and using
>>> RX 460 as display connected card.
>>> Kernels v4.17.5 and v4.16.6 are able to pass the IB ring test, but GPU
>>> hangs before entering X. Don't have logs for these yet.
>>>
>>> Regards,
>>> Lu=C3=ADs Mendes
>>> Aparapi contributor and MSc Researcher
>>>
>>>
>>>
>>>
>>>
>>> On Wed, Jul 11, 2018 at 3:49 AM, Qu, Jim <Jim.Qu-5C7GfCeVMHo@public.gmane.org> wrote:
>>>
>>>> Hi Luis,
>>>>
>>>> 1. May you also test earlier kernel? v4.17 or v4.16.
>>>> 2. May you test the issue only with amdgpu?
>>>>
>>>> Thanks
>>>> JimQu
>>>>
>>>> ________________________________________
>>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org> =E4=BB=A3=E8=A1=A8 Lu=C3=ADs Mendes <
>>>> luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B47=E6=9C=8811=E6=97=
=A5 6:04:00
>>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Michel D=C3=A4nzer; Koenig, Christian; am=
d-gfx list
>>>> =E4=B8=BB=E9=A2=98: Re: Regression with kernel 4.18 - AMD RX 550 fails=
 IB ring test on
>>>> power-up
>>>>
>>>> Hi,
>>>>
>>>> Issue remains in kernel 4.18-rc4 using SAPPHIRE RX 550 4GB.
>>>>
>>>> Logs follow attached.
>>>>
>>>> Regards,
>>>> Luis
>>>>
>>>> On Tue, Jun 26, 2018 at 10:08 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmai=
l.com
>>>> <mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>> Hi,
>>>>
>>>> I've tried kernel 4.18-rc2 on a system with a NVIDIA GTX 1050 Ti and a=
n
>>>> AMD RX 550 4GB and the RX 550 card is failing the IB ring test.
>>>>
>>>> [    5.033217] [drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR* amdgpu: ib
>>>> test failed (scratch(0xC040)=3D0xFFFFFFFF)
>>>> [    5.033264] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* amdgpu:
>>>> failed testing IB on ring 6 (-22).
>>>>
>>>> Please see the attached log.
>>>>
>>>> Regards,
>>>> Lu=C3=ADs
>>>>
>>>>
>>>
>>>
>>
>>
>

--00000000000008dce10578acc47c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>The problems remains with Linux 4.18=
 and Linux 4.19 kernels. I am unable to use AMD RX 460 and AMD RX 550 on my=
 x64 Linux platforms.</div><div><br></div><div>I&#39;ve installed Windows 1=
0 in the same machine along with win10-64bit-radeon-software-adrenalin-edit=
ion-18.10.1-oct18.exe and under Windows the same RX 460 card *works fine* a=
nd I am able to run OpenCL applications.<br></div><div><br></div><div>The d=
river is hanging since kernel 4.15, I am getting:</div><div>[=C2=A0=C2=A0 3=
3.504100] [drm:drm_atomic_helper_wait_for_flip_done [drm_kms_helper]] *ERRO=
R* [CRTC:42:crtc-0] flip_done timed out<br>[=C2=A0=C2=A0 43.744094] [drm:dr=
m_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR* [CRTC:42:cr=
tc-0] flip_done timed out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>[=C2=A0=C2=A0 53.984089] =
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR* [CON=
NECTOR:54:HDMI-A-1] flip_done timed out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 <br>[=C2=A0=C2=A0 64.224036] [drm:drm_atomic_helper_wait_fo=
r_dependencies [drm_kms_helper]] *ERROR* [PLANE:40:plane-4] flip_done timed=
 out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 <br>[=C2=A0=C2=A0 64.224141] [drm:amdgpu_dm_atomic_commit_tail=
 [amdgpu]] *ERROR* amdgpu_dm_commit_planes: acrtc 0, already busy=C2=A0=C2=
=A0=C2=A0 <br></div><div><br></div><div>And after commit: drm/amdgpu: defer=
 test IBs on the
          rings at boot (V3)<span class=3D"gmail-im"><span class=3D"gmail-m=
_-1883418404528318335gmail-"></span></span><br><span class=3D"gmail-im"><sp=
an class=3D"gmail-m_-1883418404528318335gmail-"><div><table summary=3D"comm=
it info" class=3D"gmail-m_-1883418404528318335gmail-m_3173675840618728897gm=
ail-commit-info">
            <tbody>
              <tr>
                <th><br>
                </th>
                <td colspan=3D"2" class=3D"gmail-m_-1883418404528318335gmai=
l-m_3173675840618728897gmail-sha1"><a href=3D"https://git.kernel.org/pub/sc=
m/linux/kernel/git/torvalds/linux.git/commit/?h=3Dv4.18-rc4&amp;id=3D2c773d=
e2ecb8c327f2448bd1eecad224e9227087" target=3D"_blank">2c773de2ecb8c327f2448=
bd1eecad224e9227087</a></td></tr></tbody></table></div><div>I get with kern=
els 4.18 and 4.19 as well as Ubuntu 18.10 stock kernel (can&#39;t even inst=
all Ubuntu 18.10 because it hangs with amdgpu):<br></div><div><div>[drm:gfx=
_v8_0_ring_test_ib [amdgpu]] *ERROR* amdgpu: IB test timed out.</div><div>[=
drm_amdgpu_ib_ring_tests [amdgpu]] *ERROR* amdgpu: failed testing IB on GFX=
 ring (-110).</div><div>[drm:amdgpu_device_ip_late_init_func_handler [amdgp=
u]] *ERROR* ib ring test failed (-110).</div><div>[drm:amdgpu_job_timedout =
[amdgpu]] *ERROR* ring sdma1 timeout, last signalled seq=3D0, last emitted =
seq=3D1</div><div>and the kernel blocks indefinitely:</div><div>task plymou=
thd:449 blocked for more than 120 seconds.</div><div><br></div><div>Is ther=
e any hope on getting this fixed?<br></div></div></span></span></div><br></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Jul 12, 2=
018 at 2:56 PM Lu=C3=ADs Mendes &lt;<a href=3D"mailto:luis.p.mendes@gmail.c=
om">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr"><div>Hi Jim,</div><div><br></div><div>Replies in b=
etween.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Regards,</div><div class=3D"gmail_extra">Lu=C3=ADs<br></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jul 12, 2018 at 3:16 A=
M, jimqu <span dir=3D"ltr">&lt;<a href=3D"mailto:jimqu-5C7GfCeVMHo@public.gmane.org" target=3D"_=
blank">jimqu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF"><span class=3D"m_-1883418404528318335gmail-">
    <p><br>
    </p>
    <br>
    <div class=3D"m_-1883418404528318335gmail-m_3173675840618728897moz-cite=
-prefix">On 2018=E5=B9=B407=E6=9C=8812=E6=97=A5 05:27, Lu=C3=ADs Mendes
      wrote:<br>
    </div>
    </span><blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>Hi Jim,</div>
        <div><br>
        </div><span class=3D"m_-1883418404528318335gmail-">
        <div>I followed your suggestion and was able to bisect the
          kernel patches.</div>
        <div>The offending patch is: drm/amdgpu: defer test IBs on the
          rings at boot (V3)<br>
        </div>
        <div>commit:
          <table summary=3D"commit info" class=3D"m_-1883418404528318335gma=
il-m_3173675840618728897gmail-commit-info">
            <tbody>
              <tr>
                <th><br>
                </th>
                <td colspan=3D"2" class=3D"m_-1883418404528318335gmail-m_31=
73675840618728897gmail-sha1"><a href=3D"https://git.kernel.org/pub/scm/linu=
x/kernel/git/torvalds/linux.git/commit/?h=3Dv4.18-rc4&amp;id=3D2c773de2ecb8=
c327f2448bd1eecad224e9227087" target=3D"_blank">2c773de2ecb8c327f2448bd1eec=
ad224e9227087</a></td>
              </tr>
            </tbody>
          </table>
        </div>
        <div><br>
        </div>
        <div>After reverting this patch the IB test succeeded with
          kernel v4.18-rc4 on both systems and the amdgpu driver was
          correctly loaded both on SAPPHIRE RX550 4GB and on SAPPHIRE
          RX460 2GB.</div>
        <div><br>
        </div>
      </span></div>
    </blockquote>
    <br>
    Alex, Christian, What do you think about the patch?<span class=3D"m_-18=
83418404528318335gmail-"><br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>The GPU hang remains, however.<br>
        </div>
        <div>=C2=A0I will try to configure a remote IPMI connection to see
          what is happening with the kernel boot or setup a serial
          console for the Kernel.</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    <br></span>
    <b>You can set up remote connection by ssh, and also you can add amdgpu
    to blacklist first, and manually modprobe amdgpu.</b><br></div></blockq=
uote><div>R: I was able to setup a remote serial console with console=3Dtty=
S0,11520n8 kernel parameter. <br></div><div>Boot log follows attached as fi=
le kernel_bisected_v4.18-rc4_log.txt. <br></div><div>First noticeable issue=
 seems to be:</div><div>[=C2=A0=C2=A0=C2=A0 6.131989] amdgpu: [powerplay] <=
br>[=C2=A0=C2=A0=C2=A0 6.131989]=C2=A0 last message was failed ret is 65535=
<br>...</div><div>and later hangs with:</div><div>[=C2=A0=C2=A0 33.504100] =
[drm:drm_atomic_helper_wait_for_flip_done [drm_kms_helper]] *ERROR* [CRTC:4=
2:crtc-0] flip_done timed out<br>[=C2=A0=C2=A0 43.744094] [drm:drm_atomic_h=
elper_wait_for_dependencies [drm_kms_helper]] *ERROR* [CRTC:42:crtc-0] flip=
_done timed out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>[=C2=A0=C2=A0 53.984089] [drm:drm_ato=
mic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR* [CONNECTOR:54:HD=
MI-A-1] flip_done timed out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 <br>[=C2=A0=C2=A0 64.224036] [drm:drm_atomic_helper_wait_for_dependenci=
es [drm_kms_helper]] *ERROR* [PLANE:40:plane-4] flip_done timed out=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 <br>[=C2=A0=C2=A0 64.224141] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *=
ERROR* amdgpu_dm_commit_planes: acrtc 0, already busy=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"=
#FFFFFF">
    <b>What&#39;s about xinit? What is MESA driver version on your platform=
?</b></div></blockquote><div>R: I am running Ubuntu 18.04 with bisected ker=
nel 4.18-rc4 using libdrm-2.4.92 and mesa-18.1.0.</div><div>xinit output fo=
llows attached as xinit_log.txt<br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF"><div><div class=
=3D"m_-1883418404528318335gmail-h5"><br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>Thanks &amp; Regards,</div>
        <div>Lu=C3=ADs<br>
        </div>
      </div>
      <div class=3D"gmail_extra"><br>
        <div class=3D"gmail_quote">On Wed, Jul 11, 2018 at 10:56 AM, jimqu
          <span dir=3D"ltr">&lt;<a href=3D"mailto:jimqu-5C7GfCeVMHo@public.gmane.org" target=3D"=
_blank">jimqu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div bgcolor=3D"#FFFFFF">
              <p>HI Luis,</p>
              <p><br>
              </p>
              <p>Let us trace the issue one by one.</p>
              <p><br>
              </p>
              <p>IB test fail:</p>
              <p>This should be regression issue on 4.18, you can bisect
                the kernel patches.</p>
              <p>GPU hang:</p>
              <p>Fix IB test fail first.</p>
              <p><br>
              </p>
              <p>Thanks</p>
              <span class=3D"m_-1883418404528318335gmail-m_3173675840618728=
897HOEnZb"><font color=3D"#888888">
                  <p>JimQu<br>
                  </p>
                </font></span>
              <div>
                <div class=3D"m_-1883418404528318335gmail-m_317367584061872=
8897h5">
                  <p><br>
                  </p>
                  <br>
                  <div class=3D"m_-1883418404528318335gmail-m_3173675840618=
728897m_-5542977703135971300moz-cite-prefix">On
                    2018=E5=B9=B407=E6=9C=8811=E6=97=A5 17:34, Lu=C3=ADs Me=
ndes wrote:<br>
                  </div>
                  <blockquote type=3D"cite">
                    <div dir=3D"ltr">
                      <div>Hi Jim,</div>
                      <div><br>
                      </div>
                      <div>Thanks for your interest in this issue.
                        Actually this is a multiple issue... not only
                        the IB ring test is failing... as I am having
                        quite some trouble getting the cards SAPPHIRE RX
                        550 4GB on a Tyan S7025 and SAPPHIRE RX 460 2GB
                        on a TYAN S7002 to work, both systems using same
                        Ubuntu 18.04 with vanilla kernel.<br>
                      </div>
                      <div><br>
                      </div>
                      <div><b>1. May you also test earlier kernel? v4.17
                          or v4.16.</b><br>
                      </div>
                      <div>I&#39;ve tested kernels v4.17.5 and v4.16.6 with
                        same system and both are able to pass the IB
                        ring test and system boots into X using NVIDIA
                        as the display connected card.</div>
                      <div>dmesg log attached for kernel 4.17.5, file
                        TYAN_S7025_kernelv4.17.5_amdgpu_IB_ring_test_OK.txt=
.<br>
                      </div>
                      <div><br>
                      </div>
                      <div><b>2. May you test the issue only with
                          amdgpu?</b></div>
                      <div>
                        <div>- I&#39;ve tested on a TYAN S7002 system with =
a
                          single SAPPHIRE RX 460 2GB, on-board VGA
                          enabled and used as primary display.</div>
                        <div>Kernel v4.18-rc4 fails the IB ring test,
                          system is able to enter X through the on-board
                          VGA. <br>
                        </div>
                        <div>dmesg log attached for kernel 4.18-rc4,
                          file TYAN_S7002_kernel_v4.18-rc4_IB_ring_test_fai=
l.txt.</div>
                        <div><br>
                        </div>
                        <div>- Same TYAN S7002 system, but now with
                          on-board VGA disabled and using RX 460 as
                          display connected card.<br>
                        </div>
                        <div>
                          <div>Kernels v4.17.5 and v4.16.6 are able to
                            pass the IB ring test, but GPU hangs before
                            entering X. Don&#39;t have logs for these yet.<=
br>
                          </div>
                          <br>
                          <div>Regards,</div>
                          <div>Lu=C3=ADs Mendes</div>
                          <div>Aparapi contributor and MSc Researcher<br>
                          </div>
                          <div><br>
                          </div>
                          <div><br>
                          </div>
                          <br>
                        </div>
                        <br>
                      </div>
                    </div>
                    <div class=3D"gmail_extra"><br>
                      <div class=3D"gmail_quote">On Wed, Jul 11, 2018 at
                        3:49 AM, Qu, Jim <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Jim.Qu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                        wrote:<br>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Luis,<br>
                          <br>
                          1. May you also test earlier kernel? v4.17 or
                          v4.16.<br>
                          2. May you test the issue only with amdgpu?<br>
                          <br>
                          Thanks<br>
                          JimQu<br>
                          <br>
                          ________________________________________<br>
                          =E5=8F=91=E4=BB=B6=E4=BA=BA: amd-gfx &lt;<a href=
=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                          =E4=BB=A3=E8=A1=A8 Lu=C3=ADs Mendes &lt;<a href=
=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes@gmail.c=
om</a>&gt;<br>
                          =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=
=B47=E6=9C=8811=E6=97=A5 6:04:00<br>
                          =E6=94=B6=E4=BB=B6=E4=BA=BA: Michel D=C3=A4nzer; =
Koenig, Christian; amd-gfx
                          list<br>
                          =E4=B8=BB=E9=A2=98: Re: Regression with kernel 4.=
18 - AMD RX
                          550 fails IB ring test on power-up<br>
                          <span class=3D"m_-1883418404528318335gmail-m_3173=
675840618728897m_-5542977703135971300im m_-1883418404528318335gmail-m_31736=
75840618728897m_-5542977703135971300HOEnZb"><br>
                            Hi,<br>
                            <br>
                            Issue remains in kernel 4.18-rc4 using
                            SAPPHIRE RX 550 4GB.<br>
                            <br>
                            Logs follow attached.<br>
                            <br>
                            Regards,<br>
                            Luis<br>
                            <br>
                          </span>
                          <div class=3D"m_-1883418404528318335gmail-m_31736=
75840618728897m_-5542977703135971300HOEnZb">
                            <div class=3D"m_-1883418404528318335gmail-m_317=
3675840618728897m_-5542977703135971300h5">On
                              Tue, Jun 26, 2018 at 10:08 AM, Lu=C3=ADs Mend=
es
                              &lt;<a href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&lt;mailto:<a href=3D"mailto=
:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;=
&gt;
                              wrote:<br>
                              Hi,<br>
                              <br>
                              I&#39;ve tried kernel 4.18-rc2 on a system
                              with a NVIDIA GTX 1050 Ti and an AMD RX
                              550 4GB and the RX 550 card is failing the
                              IB ring test.<br>
                              <br>
                              [=C2=A0 =C2=A0 5.033217] [drm:gfx_v8_0_ring_t=
est_ib
                              [amdgpu]] *ERROR* amdgpu: ib test failed
                              (scratch(0xC040)=3D0xFFFFFFFF)<br>
                              [=C2=A0 =C2=A0 5.033264] [drm:amdgpu_ib_ring_=
tests
                              [amdgpu]] *ERROR* amdgpu: failed testing
                              IB on ring 6 (-22).<br>
                              <br>
                              Please see the attached log.<br>
                              <br>
                              Regards,<br>
                              Lu=C3=ADs<br>
                              <br>
                            </div>
                          </div>
                        </blockquote>
                      </div>
                      <br>
                    </div>
                  </blockquote>
                  <br>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </div></div></div>

</blockquote></div><br></div></div>
</blockquote></div>

--00000000000008dce10578acc47c--

--===============2070553393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2070553393==--
