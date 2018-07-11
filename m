From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Regression_with_kernel_4=2E18_=2D_AMD_RX_550?=
 =?UTF-8?Q?_fails_IB_ring_test_on_power=2Dup?=
Date: Wed, 11 Jul 2018 22:27:31 +0100
Message-ID: <CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w@mail.gmail.com>
References: <CAEzXK1ofHUGNcZXM+Ys4xU9g0cSrdr63fxMVTCSq2-X4jwKfNw@mail.gmail.com>
 <CAEzXK1oftbBGeuzJEsn7bEJUmuiviq5h6cmmP0hP2+U77otZKA@mail.gmail.com>
 <DM3PR12MB0873E055CAF457DE917EC238995A0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <CAEzXK1pnvjJfe2Q0WVeGToyZNDH_GQD1eMJnf3R=GNQTbK8pjw@mail.gmail.com>
 <a0bbadba-18bb-12dd-a577-305c5178ddb8@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0144072517=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a0bbadba-18bb-12dd-a577-305c5178ddb8-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0144072517==
Content-Type: multipart/alternative; boundary="0000000000001900af0570bfeadc"

--0000000000001900af0570bfeadc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jim,

I followed your suggestion and was able to bisect the kernel patches.
The offending patch is: drm/amdgpu: defer test IBs on the rings at boot (V3=
)
commit:

2c773de2ecb8c327f2448bd1eecad224e9227087
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?h=3Dv4.18-rc4&id=3D2c773de2ecb8c327f2448bd1eecad224e9227087>

After reverting this patch the IB test succeeded with kernel v4.18-rc4 on
both systems and the amdgpu driver was correctly loaded both on SAPPHIRE
RX550 4GB and on SAPPHIRE RX460 2GB.

The GPU hang remains, however.
 I will try to configure a remote IPMI connection to see what is happening
with the kernel boot or setup a serial console for the Kernel.

Thanks & Regards,
Lu=C3=ADs

On Wed, Jul 11, 2018 at 10:56 AM, jimqu <jimqu-5C7GfCeVMHo@public.gmane.org> wrote:

> HI Luis,
>
>
> Let us trace the issue one by one.
>
>
> IB test fail:
>
> This should be regression issue on 4.18, you can bisect the kernel patche=
s.
>
> GPU hang:
>
> Fix IB test fail first.
>
>
> Thanks
>
> JimQu
>
>
>
> On 2018=E5=B9=B407=E6=9C=8811=E6=97=A5 17:34, Lu=C3=ADs Mendes wrote:
>
> Hi Jim,
>
> Thanks for your interest in this issue. Actually this is a multiple
> issue... not only the IB ring test is failing... as I am having quite som=
e
> trouble getting the cards SAPPHIRE RX 550 4GB on a Tyan S7025 and SAPPHIR=
E
> RX 460 2GB on a TYAN S7002 to work, both systems using same Ubuntu 18.04
> with vanilla kernel.
>
> *1. May you also test earlier kernel? v4.17 or v4.16.*
> I've tested kernels v4.17.5 and v4.16.6 with same system and both are abl=
e
> to pass the IB ring test and system boots into X using NVIDIA as the
> display connected card.
> dmesg log attached for kernel 4.17.5, file TYAN_S7025_kernelv4.17.5_
> amdgpu_IB_ring_test_OK.txt.
>
> *2. May you test the issue only with amdgpu?*
> - I've tested on a TYAN S7002 system with a single SAPPHIRE RX 460 2GB,
> on-board VGA enabled and used as primary display.
> Kernel v4.18-rc4 fails the IB ring test, system is able to enter X throug=
h
> the on-board VGA.
> dmesg log attached for kernel 4.18-rc4, file TYAN_S7002_kernel_v4.18-rc4_
> IB_ring_test_fail.txt.
>
> - Same TYAN S7002 system, but now with on-board VGA disabled and using RX
> 460 as display connected card.
> Kernels v4.17.5 and v4.16.6 are able to pass the IB ring test, but GPU
> hangs before entering X. Don't have logs for these yet.
>
> Regards,
> Lu=C3=ADs Mendes
> Aparapi contributor and MSc Researcher
>
>
>
>
>
> On Wed, Jul 11, 2018 at 3:49 AM, Qu, Jim <Jim.Qu-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> Hi Luis,
>>
>> 1. May you also test earlier kernel? v4.17 or v4.16.
>> 2. May you test the issue only with amdgpu?
>>
>> Thanks
>> JimQu
>>
>> ________________________________________
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org> =E4=BB=A3=E8=A1=A8 Lu=C3=ADs Mendes <
>> luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B47=E6=9C=8811=E6=97=A5=
 6:04:00
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Michel D=C3=A4nzer; Koenig, Christian; amd-=
gfx list
>> =E4=B8=BB=E9=A2=98: Re: Regression with kernel 4.18 - AMD RX 550 fails I=
B ring test on
>> power-up
>>
>> Hi,
>>
>> Issue remains in kernel 4.18-rc4 using SAPPHIRE RX 550 4GB.
>>
>> Logs follow attached.
>>
>> Regards,
>> Luis
>>
>> On Tue, Jun 26, 2018 at 10:08 AM, Lu=C3=ADs Mendes <luis.p.mendes@gmail.=
com
>> <mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>> Hi,
>>
>> I've tried kernel 4.18-rc2 on a system with a NVIDIA GTX 1050 Ti and an
>> AMD RX 550 4GB and the RX 550 card is failing the IB ring test.
>>
>> [    5.033217] [drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR* amdgpu: ib
>> test failed (scratch(0xC040)=3D0xFFFFFFFF)
>> [    5.033264] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* amdgpu: faile=
d
>> testing IB on ring 6 (-22).
>>
>> Please see the attached log.
>>
>> Regards,
>> Lu=C3=ADs
>>
>>
>
>

--0000000000001900af0570bfeadc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jim,</div><div><br></div><div>I followed your sugg=
estion and was able to bisect the kernel patches.</div><div>The offending p=
atch is: drm/amdgpu: defer test IBs on the rings at boot (V3)<br></div><div=
>commit:<table summary=3D"commit info" class=3D"gmail-commit-info"><tbody><=
tr><th><br></th><td colspan=3D"2" class=3D"gmail-sha1"><a href=3D"https://g=
it.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=3Dv4.18=
-rc4&amp;id=3D2c773de2ecb8c327f2448bd1eecad224e9227087">2c773de2ecb8c327f24=
48bd1eecad224e9227087</a></td></tr></tbody></table></div><div><br></div><di=
v>After reverting this patch the IB test succeeded with kernel v4.18-rc4 on=
 both systems and the amdgpu driver was correctly loaded both on SAPPHIRE R=
X550 4GB and on SAPPHIRE RX460 2GB.</div><div><br></div><div>The GPU hang r=
emains, however.<br></div><div>=C2=A0I will try to configure a remote IPMI =
connection to see what is happening with the kernel boot or setup a serial =
console for the Kernel.</div><div><br></div><div>Thanks &amp; Regards,</div=
><div>Lu=C3=ADs<br></div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Wed, Jul 11, 2018 at 10:56 AM, jimqu <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jimqu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">jimqu-5C7GfCeVMHo@public.gmane.org</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>HI Luis,</p>
    <p><br>
    </p>
    <p>Let us trace the issue one by one.</p>
    <p><br>
    </p>
    <p>IB test fail:</p>
    <p>This should be regression issue on 4.18, you can bisect the
      kernel patches.</p>
    <p>GPU hang:</p>
    <p>Fix IB test fail first.</p>
    <p><br>
    </p>
    <p>Thanks</p><span class=3D"HOEnZb"><font color=3D"#888888">
    <p>JimQu<br>
    </p></font></span><div><div class=3D"h5">
    <p><br>
    </p>
    <br>
    <div class=3D"m_-5542977703135971300moz-cite-prefix">On 2018=E5=B9=B407=
=E6=9C=8811=E6=97=A5 17:34, Lu=C3=ADs Mendes
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>Hi Jim,</div>
        <div><br>
        </div>
        <div>Thanks for your interest in this issue. Actually this is a
          multiple issue... not only the IB ring test is failing... as I
          am having quite some trouble getting the cards SAPPHIRE RX 550
          4GB on a Tyan S7025 and SAPPHIRE RX 460 2GB on a TYAN S7002 to
          work, both systems using same Ubuntu 18.04 with vanilla
          kernel.<br>
        </div>
        <div><br>
        </div>
        <div><b>1. May you also test earlier kernel? v4.17 or v4.16.</b><br=
>
        </div>
        <div>I&#39;ve tested kernels v4.17.5 and v4.16.6 with same system
          and both are able to pass the IB ring test and system boots
          into X using NVIDIA as the display connected card.</div>
        <div>dmesg log attached for kernel 4.17.5, file
          TYAN_S7025_kernelv4.17.5_<wbr>amdgpu_IB_ring_test_OK.txt.<br>
        </div>
        <div><br>
        </div>
        <div><b>2. May you test the issue only with amdgpu?</b></div>
        <div>
          <div>- I&#39;ve tested on a TYAN S7002 system with a single
            SAPPHIRE RX 460 2GB, on-board VGA enabled and used as
            primary display.</div>
          <div>Kernel v4.18-rc4 fails the IB ring test, system is able
            to enter X through the on-board VGA. <br>
          </div>
          <div>dmesg log attached for kernel 4.18-rc4, file
            TYAN_S7002_kernel_v4.18-rc4_<wbr>IB_ring_test_fail.txt.</div>
          <div><br>
          </div>
          <div>- Same TYAN S7002 system, but now with on-board VGA
            disabled and using RX 460 as display connected card.<br>
          </div>
          <div>
            <div>Kernels v4.17.5 and v4.16.6 are able to pass the IB
              ring test, but GPU hangs before entering X. Don&#39;t have
              logs for these yet.<br>
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
        <div class=3D"gmail_quote">On Wed, Jul 11, 2018 at 3:49 AM, Qu,
          Jim <span dir=3D"ltr">&lt;<a href=3D"mailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org" targe=
t=3D"_blank">Jim.Qu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Hi Luis,<br>
            <br>
            1. May you also test earlier kernel? v4.17 or v4.16.<br>
            2. May you test the issue only with amdgpu?<br>
            <br>
            Thanks<br>
            JimQu<br>
            <br>
            ______________________________<wbr>__________<br>
            =E5=8F=91=E4=BB=B6=E4=BA=BA: amd-gfx &lt;<a href=3D"mailto:amd-=
gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-bounces@lists.=
freedes<wbr>ktop.org</a>&gt;
            =E4=BB=A3=E8=A1=A8 Lu=C3=ADs Mendes &lt;<a href=3D"mailto:luis.=
p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
            =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B47=E6=9C=8811=
=E6=97=A5 6:04:00<br>
            =E6=94=B6=E4=BB=B6=E4=BA=BA: Michel D=C3=A4nzer; Koenig, Christ=
ian; amd-gfx list<br>
            =E4=B8=BB=E9=A2=98: Re: Regression with kernel 4.18 - AMD RX 55=
0 fails IB
            ring test on power-up<br>
            <span class=3D"m_-5542977703135971300im m_-5542977703135971300H=
OEnZb"><br>
              Hi,<br>
              <br>
              Issue remains in kernel 4.18-rc4 using SAPPHIRE RX 550
              4GB.<br>
              <br>
              Logs follow attached.<br>
              <br>
              Regards,<br>
              Luis<br>
              <br>
            </span>
            <div class=3D"m_-5542977703135971300HOEnZb">
              <div class=3D"m_-5542977703135971300h5">On Tue, Jun 26, 2018 =
at 10:08 AM, Lu=C3=ADs
                Mendes &lt;<a href=3D"mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targe=
t=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&lt;mailt<wbr>o:<a href=3D"mailto:l=
uis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&g=
t;
                wrote:<br>
                Hi,<br>
                <br>
                I&#39;ve tried kernel 4.18-rc2 on a system with a NVIDIA GT=
X
                1050 Ti and an AMD RX 550 4GB and the RX 550 card is
                failing the IB ring test.<br>
                <br>
                [=C2=A0 =C2=A0 5.033217] [drm:gfx_v8_0_ring_test_ib [amdgpu=
]]
                *ERROR* amdgpu: ib test failed
                (scratch(0xC040)=3D0xFFFFFFFF)<br>
                [=C2=A0 =C2=A0 5.033264] [drm:amdgpu_ib_ring_tests [amdgpu]=
]
                *ERROR* amdgpu: failed testing IB on ring 6 (-22).<br>
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
  </div></div></div>

</blockquote></div><br></div>

--0000000000001900af0570bfeadc--

--===============0144072517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0144072517==--
