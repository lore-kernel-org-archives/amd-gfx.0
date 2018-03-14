From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 14 Mar 2018 17:35:14 +0100
Message-ID: <CAGtoiRgQEZnz_QynL9Jo6z8iHL0vb3bw0qGb0a1KjbccAWdoLA@mail.gmail.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <CAGtoiRjqaseQSw7utV5Ncru1ggrq+p2OAg7weULzzSt0DWNoaA@mail.gmail.com>
 <9b9704ee-05ae-8586-bdf8-0e37171d8829@daenzer.net>
 <CAGtoiRgJsoETCpE7R+LwQ-941vgifCWQ+9GdDe_-NiNaJK-78A@mail.gmail.com>
 <8950aedc-29db-ae1b-96c9-20be3c8177eb@gmail.com>
 <CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA@mail.gmail.com>
 <4b7d2add-456f-5e0e-5aea-15439d2b76e3@amd.com>
 <CAGtoiRhjUShyxeHRuhx_g4zoTYLig=5R_9f-bHAUOcfVO7C0FQ@mail.gmail.com>
 <0f2a9449-b81a-2103-cd6b-df8e7e4b1d60@amd.com>
 <CADnq5_MDSKX8M+seffLxjdNaF3c6WtwY5Pz03YqBSdg6zG=QkA@mail.gmail.com>
 <CAGtoiRiSNHOVUnHDrD9_E41Zunciy_3sMTWFpD_RowZ_D7mAcA@mail.gmail.com>
 <808b67da-30df-ed8b-f266-34a449d3f4ab@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789304825=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <808b67da-30df-ed8b-f266-34a449d3f4ab-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1789304825==
Content-Type: multipart/alternative; boundary="f403045d585aa7c8b8056761f5f6"

--f403045d585aa7c8b8056761f5f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have the radeon driver working on the T2080, and am currently running
into a problem with gallium/mesa. My problem was a mismatch
between u-boot and my device-tree that caused PCI Express to misbehave.

When I run a program calling OpenCL, I get a segfault. The cause for this
particular crash in src/gallium/drivers/radeonsi/si_state_draw.c:474
is the use of bit fields in union si_vgt_param_key
(from src/gallium/drivers/radeonsi/si_pipe.h:310). I'm fairly sure there
will be other instances.

Is there a best practice on resolving this? Point me in the right direction
and I'll create some patches to get this fixed.

Bas Vermeulen

On Thu, Feb 22, 2018 at 9:51 AM, Christian K=C3=B6nig <christian.koenig@amd=
.com>
wrote:

> Am 22.02.2018 um 09:37 schrieb Bas Vermeulen:
>
> On Wed, Feb 21, 2018 at 6:22 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> On Wed, Feb 21, 2018 at 7:43 AM, Christian K=C3=B6nig
>> [SNIP]
>> > Apart from that I don't have any good idea any more why that shouldn't
>> work.
>>
>> Does your platform properly handle DMA masks?  Most radeon hw only
>> supports a 40 bit DMA mask.  If there are relevant bits in the upper
>> bits of the address, they will be lost when the hw tries to use the
>> address.  On at least some powerpc hw, I believe there is some memory
>> routing related info in the high bits.
>>
>
> On 4.1 (without the hashing algorithm when printing pointers), The rings
> are placed thus:
>
> [   11.002673] radeon 0002:01:00.0: fence driver on ring 0 use gpu addr
> 0x0000000080000c00 and cpu addr 0xc00000007c0c8c00
> [   11.012165] radeon 0002:01:00.0: fence driver on ring 1 use gpu addr
> 0x0000000080000c04 and cpu addr 0xc00000007c0c8c04
> [   11.021657] radeon 0002:01:00.0: fence driver on ring 2 use gpu addr
> 0x0000000080000c08 and cpu addr 0xc00000007c0c8c08
> [   11.031152] radeon 0002:01:00.0: fence driver on ring 3 use gpu addr
> 0x0000000080000c0c and cpu addr 0xc00000007c0c8c0c
> [   11.040644] radeon 0002:01:00.0: fence driver on ring 4 use gpu addr
> 0x0000000080000c10 and cpu addr 0xc00000007c0c8c10
> [   11.051919] radeon 0002:01:00.0: fence driver on ring 5 use gpu addr
> 0x0000000000075a18 and cpu addr 0x8000080088db5a18
>
> It's also using bit 63 & 62. So this might be something to look into.
>
>
> No, that is just the virtual address of the buffer in kernel space and
> perfectly ok.
>
> What you could try is to force the need_dma32 flag to true, see
> drivers/gpu/drm/radeon/radeon_ttm.c and search for need_dma32.
>
> Regards,
> Christian.
>
>
> Bas Vermeulen
>
>
>

--f403045d585aa7c8b8056761f5f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have the radeon driver working on the T2080, and am curr=
ently running into a problem with gallium/mesa. My problem was a mismatch<d=
iv>between u-boot and my device-tree that caused PCI Express to misbehave.<=
br><div><br></div><div>When I run a program calling OpenCL, I get a segfaul=
t. The cause for this particular crash in=C2=A0src/gallium/drivers/radeonsi=
/si_state_draw.c:474=C2=A0</div><div>is the use of bit fields in=C2=A0union=
 si_vgt_param_key (from=C2=A0src/gallium/drivers/radeonsi/si_pipe.h:310). I=
&#39;m fairly sure there will be other instances.</div><div><br></div><div>=
Is there a best practice on resolving this? Point me in the right direction=
 and I&#39;ll create some patches to get this fixed.</div><div><br></div><d=
iv>Bas Vermeulen</div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, Feb 22, 2018 at 9:51 AM, Christian K=C3=B6nig <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <div class=3D"m_7914511615307514869moz-cite-prefix">Am 22.02.2018 um 09=
:37 schrieb Bas
      Vermeulen:<br>
    </div>
    </span><blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote"><span class=3D"">On Wed, Feb 21, 2018 =
at 6:22 PM, Alex
            Deucher <span dir=3D"ltr">&lt;<a href=3D"mailto:alexdeucher@gma=
il.com" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            </span><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div class=3D"m_7914511615307514869gmail-HOEnZb">
                <div class=3D"m_7914511615307514869gmail-h5"><span class=3D=
"">On Wed, Feb 21, 2018 at 7:43 AM,
                  Christian K=C3=B6nig<br></span>
                  [SNIP]<span class=3D""><br>
                  &gt; Apart from that I don&#39;t have any good idea any
                  more why that shouldn&#39;t work.<br>
                  <br>
                </span></div>
              </div><span class=3D"">
              Does your platform properly handle DMA masks?=C2=A0 Most rade=
on
              hw only<br>
              supports a 40 bit DMA mask.=C2=A0 If there are relevant bits =
in
              the upper<br>
              bits of the address, they will be lost when the hw tries
              to use the<br>
              address.=C2=A0 On at least some powerpc hw, I believe there i=
s
              some memory<br>
              routing related info in the high bits.<br>
            </span></blockquote><span class=3D"">
            <div><br>
            </div>
            <div>On 4.1 (without the hashing algorithm when printing
              pointers), The rings are placed thus:</div>
            <div><br>
            </div>
            <div>
              <div>[=C2=A0 =C2=A011.002673] radeon 0002:01:00.0: fence driv=
er on
                ring 0 use gpu addr 0x0000000080000c00 and cpu addr
                0xc00000007c0c8c00</div>
              <div>[=C2=A0 =C2=A011.012165] radeon 0002:01:00.0: fence driv=
er on
                ring 1 use gpu addr 0x0000000080000c04 and cpu addr
                0xc00000007c0c8c04</div>
              <div>[=C2=A0 =C2=A011.021657] radeon 0002:01:00.0: fence driv=
er on
                ring 2 use gpu addr 0x0000000080000c08 and cpu addr
                0xc00000007c0c8c08</div>
              <div>[=C2=A0 =C2=A011.031152] radeon 0002:01:00.0: fence driv=
er on
                ring 3 use gpu addr 0x0000000080000c0c and cpu addr
                0xc00000007c0c8c0c</div>
              <div>[=C2=A0 =C2=A011.040644] radeon 0002:01:00.0: fence driv=
er on
                ring 4 use gpu addr 0x0000000080000c10 and cpu addr
                0xc00000007c0c8c10</div>
              <div>[=C2=A0 =C2=A011.051919] radeon 0002:01:00.0: fence driv=
er on
                ring 5 use gpu addr 0x0000000000075a18 and cpu addr
                0x8000080088db5a18</div>
            </div>
            <div><br>
            </div>
            <div>It&#39;s also using bit 63 &amp; 62. So this might be
              something to look into.</div>
          </span></div>
        </div>
      </div>
    </blockquote>
    <br>
    No, that is just the virtual address of the buffer in kernel space
    and perfectly ok.<br>
    <br>
    What you could try is to force the need_dma32 flag to true, see
    drivers/gpu/drm/radeon/radeon_<wbr>ttm.c and search for need_dma32.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div><br>
            </div>
            <div>Bas Vermeulen</div>
            <div><br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div><br></div>

--f403045d585aa7c8b8056761f5f6--

--===============1789304825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1789304825==--
