From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Thu, 22 Feb 2018 09:37:38 +0100
Message-ID: <CAGtoiRiSNHOVUnHDrD9_E41Zunciy_3sMTWFpD_RowZ_D7mAcA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268977108=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MDSKX8M+seffLxjdNaF3c6WtwY5Pz03YqBSdg6zG=QkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0268977108==
Content-Type: multipart/alternative; boundary="089e0820ed58cb8d550565c8f40e"

--089e0820ed58cb8d550565c8f40e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 6:22 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:

> On Wed, Feb 21, 2018 at 7:43 AM, Christian K=C3=B6nig
> <christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
> >> The failed VCE resume (-22) seems to be caused by
> >>
> >>         if (rdev->vce.vcpu_bo =3D=3D NULL)
> >>                 return -EINVAL;
> >>
> >> in radeon_vce.c line 226.
> >
> >
> > Yeah, you don't seem to have the VCE firmware installed. But as long as
> you
> > don't want to do any advanced video encoding with the hardware we can
> simply
> > ignore that for now.
> >
> >> Any idea where to look from there?
> >
> >
> > Unfortunately not the slightest.
> >
> > What's a bit suspicious is that the CPU addresses for the fence locatio=
ns
> > look odd:
> >>
> >> [   11.350779] radeon 0001:01:00.0: fence driver on ring 0 use gpu add=
r
> >> 0x0000000080000c00 and cpu addr 0x000000007408d6c9
> >> [   11.360274] radeon 0001:01:00.0: fence driver on ring 1 use gpu add=
r
> >> 0x0000000080000c04 and cpu addr 0x0000000013c11aeb
> >> [   11.369770] radeon 0001:01:00.0: fence driver on ring 2 use gpu add=
r
> >> 0x0000000080000c08 and cpu addr 0x00000000d4ddd131
> >> [   11.379267] radeon 0001:01:00.0: fence driver on ring 3 use gpu add=
r
> >> 0x0000000080000c0c and cpu addr 0x00000000263a4d29
> >> [   11.388763] radeon 0001:01:00.0: fence driver on ring 4 use gpu add=
r
> >> 0x0000000080000c10 and cpu addr 0x000000006ceb1503
> >> [   11.399277] radeon 0001:01:00.0: fence driver on ring 5 use gpu add=
r
> >> 0x0000000000075a18 and cpu addr 0x000000008935a463
> >
> > But could as well be that we don't correctly print them.
> >
> > Apart from that I don't have any good idea any more why that shouldn't
> work.
>
> Does your platform properly handle DMA masks?  Most radeon hw only
> supports a 40 bit DMA mask.  If there are relevant bits in the upper
> bits of the address, they will be lost when the hw tries to use the
> address.  On at least some powerpc hw, I believe there is some memory
> routing related info in the high bits.
>

On 4.1 (without the hashing algorithm when printing pointers), The rings
are placed thus:

[   11.002673] radeon 0002:01:00.0: fence driver on ring 0 use gpu addr
0x0000000080000c00 and cpu addr 0xc00000007c0c8c00
[   11.012165] radeon 0002:01:00.0: fence driver on ring 1 use gpu addr
0x0000000080000c04 and cpu addr 0xc00000007c0c8c04
[   11.021657] radeon 0002:01:00.0: fence driver on ring 2 use gpu addr
0x0000000080000c08 and cpu addr 0xc00000007c0c8c08
[   11.031152] radeon 0002:01:00.0: fence driver on ring 3 use gpu addr
0x0000000080000c0c and cpu addr 0xc00000007c0c8c0c
[   11.040644] radeon 0002:01:00.0: fence driver on ring 4 use gpu addr
0x0000000080000c10 and cpu addr 0xc00000007c0c8c10
[   11.051919] radeon 0002:01:00.0: fence driver on ring 5 use gpu addr
0x0000000000075a18 and cpu addr 0x8000080088db5a18

It's also using bit 63 & 62. So this might be something to look into.

Bas Vermeulen

--089e0820ed58cb8d550565c8f40e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 21, 2018 at 6:22 PM, Alex Deucher <span dir=3D"ltr">&lt;<a href=3D"=
mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Wed, Feb 21, 2018 at 7:43=
 AM, Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a=
>&gt; wrote:<br>
&gt;&gt; The failed VCE resume (-22) seems to be caused by<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;vce.vcpu_bo =3D=3D N=
ULL)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
&gt;&gt;<br>
&gt;&gt; in radeon_vce.c line 226.<br>
&gt;<br>
&gt;<br>
&gt; Yeah, you don&#39;t seem to have the VCE firmware installed. But as lo=
ng as you<br>
&gt; don&#39;t want to do any advanced video encoding with the hardware we =
can simply<br>
&gt; ignore that for now.<br>
&gt;<br>
&gt;&gt; Any idea where to look from there?<br>
&gt;<br>
&gt;<br>
&gt; Unfortunately not the slightest.<br>
&gt;<br>
&gt; What&#39;s a bit suspicious is that the CPU addresses for the fence lo=
cations<br>
&gt; look odd:<br>
&gt;&gt;<br>
&gt;&gt; [=C2=A0 =C2=A011.350779] radeon 0001:01:00.0: fence driver on ring=
 0 use gpu addr<br>
&gt;&gt; 0x0000000080000c00 and cpu addr 0x000000007408d6c9<br>
&gt;&gt; [=C2=A0 =C2=A011.360274] radeon 0001:01:00.0: fence driver on ring=
 1 use gpu addr<br>
&gt;&gt; 0x0000000080000c04 and cpu addr 0x0000000013c11aeb<br>
&gt;&gt; [=C2=A0 =C2=A011.369770] radeon 0001:01:00.0: fence driver on ring=
 2 use gpu addr<br>
&gt;&gt; 0x0000000080000c08 and cpu addr 0x00000000d4ddd131<br>
&gt;&gt; [=C2=A0 =C2=A011.379267] radeon 0001:01:00.0: fence driver on ring=
 3 use gpu addr<br>
&gt;&gt; 0x0000000080000c0c and cpu addr 0x00000000263a4d29<br>
&gt;&gt; [=C2=A0 =C2=A011.388763] radeon 0001:01:00.0: fence driver on ring=
 4 use gpu addr<br>
&gt;&gt; 0x0000000080000c10 and cpu addr 0x000000006ceb1503<br>
&gt;&gt; [=C2=A0 =C2=A011.399277] radeon 0001:01:00.0: fence driver on ring=
 5 use gpu addr<br>
&gt;&gt; 0x0000000000075a18 and cpu addr 0x000000008935a463<br>
&gt;<br>
&gt; But could as well be that we don&#39;t correctly print them.<br>
&gt;<br>
&gt; Apart from that I don&#39;t have any good idea any more why that shoul=
dn&#39;t work.<br>
<br>
</div></div>Does your platform properly handle DMA masks?=C2=A0 Most radeon=
 hw only<br>
supports a 40 bit DMA mask.=C2=A0 If there are relevant bits in the upper<b=
r>
bits of the address, they will be lost when the hw tries to use the<br>
address.=C2=A0 On at least some powerpc hw, I believe there is some memory<=
br>
routing related info in the high bits.<br></blockquote><div><br></div><div>=
On 4.1 (without the hashing algorithm when printing pointers), The rings ar=
e placed thus:</div><div><br></div><div><div>[=C2=A0 =C2=A011.002673] radeo=
n 0002:01:00.0: fence driver on ring 0 use gpu addr 0x0000000080000c00 and =
cpu addr 0xc00000007c0c8c00</div><div>[=C2=A0 =C2=A011.012165] radeon 0002:=
01:00.0: fence driver on ring 1 use gpu addr 0x0000000080000c04 and cpu add=
r 0xc00000007c0c8c04</div><div>[=C2=A0 =C2=A011.021657] radeon 0002:01:00.0=
: fence driver on ring 2 use gpu addr 0x0000000080000c08 and cpu addr 0xc00=
000007c0c8c08</div><div>[=C2=A0 =C2=A011.031152] radeon 0002:01:00.0: fence=
 driver on ring 3 use gpu addr 0x0000000080000c0c and cpu addr 0xc00000007c=
0c8c0c</div><div>[=C2=A0 =C2=A011.040644] radeon 0002:01:00.0: fence driver=
 on ring 4 use gpu addr 0x0000000080000c10 and cpu addr 0xc00000007c0c8c10<=
/div><div>[=C2=A0 =C2=A011.051919] radeon 0002:01:00.0: fence driver on rin=
g 5 use gpu addr 0x0000000000075a18 and cpu addr 0x8000080088db5a18</div></=
div><div><br></div><div>It&#39;s also using bit 63 &amp; 62. So this might =
be something to look into.</div><div><br></div><div>Bas Vermeulen</div><div=
><br></div></div></div></div>

--089e0820ed58cb8d550565c8f40e--

--===============0268977108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0268977108==--
