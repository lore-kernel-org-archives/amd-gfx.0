From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Chrome crash on 4.18.1
Date: Mon, 20 Aug 2018 12:21:20 -0300
Message-ID: <CAJri6_u1Z9juWs6XEoH2mhAiAZVH86EgfMaRzv5C+3kora+Gew@mail.gmail.com>
References: <CAJri6_t0K4uxjbmU=xeTFntbxr67f+FeTmBLbnL2yXmdXnBqpg@mail.gmail.com>
 <554056cb-3754-9885-5882-ef801cc3badf@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1483744388=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <554056cb-3754-9885-5882-ef801cc3badf-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1483744388==
Content-Type: multipart/alternative; boundary="000000000000c668700573df7514"

--000000000000c668700573df7514
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

Em seg, 20 de ago de 2018 12:17, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
escreveu:

> On 2018-08-18 12:39 AM, Br=C3=A1ulio Bhavamitra wrote:
> > Chrome freezed and had to be killed, error on dmesg below.
> >
> > [...]
> >
> > [ 5898.208262] ------------[ cut here ]------------
> > [ 5898.208272] kernel BUG at drivers/dma-buf/reservation.c:234!
> > [ 5898.208305] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > [ 5898.208314] CPU: 6 PID: 2988 Comm: chromium Tainted: G         C O
> > 4.18.1-arch1-1-ARCH #1
> > [ 5898.208317] Hardware name: HP HP ENVY x360 Convertible 15m-bq1xx/83C=
6,
> > BIOS F.17 03/29/2018
> > [ 5898.208334] RIP: 0010:reservation_object_add_shared_fence+0x31b/0x37=
0
> > [ 5898.208336] Code: ff 4c 89 7d 18 c7 45 10 01 00 00 00 e9 e2 fd ff ff
> e8
> > 46 8c a8 ff e9 0c fe ff ff b8 18 00 00 00 ba 01 00 00 00 e9 c0 fd ff ff
> > <0f> 0b 8d 50 01 48 8d 04 c5 18 00 00 00 48 01 d8 45 31 f6 4c 89 38
> > [ 5898.208373] RSP: 0018:ffffa1b1ca9abb38 EFLAGS: 00010246
> > [ 5898.208377] RAX: 0000000000000004 RBX: ffff9236f1c71580 RCX:
> > 0000000000000001
> > [ 5898.208380] RDX: 0000000000000001 RSI: ffff92371223da60 RDI:
> > ffff9236b196ba18
> > [ 5898.208382] RBP: 0000000000000000 R08: ffff9236bc7c3c80 R09:
> > ffff92374aba2378
> > [ 5898.208385] R10: ffff9237374cded8 R11: ffff9237374cdec8 R12:
> > ffff9236b196ba18
> > [ 5898.208387] R13: ffff9236b1ac0130 R14: ffff9236bfe3c000 R15:
> > ffff92371223da60
> > [ 5898.208390] FS:  00007fffe08c2180(0000) GS:ffff92374ab80000(0000)
> > knlGS:0000000000000000
> > [ 5898.208393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5898.208395] CR2: 0000265eadacf000 CR3: 00000004794e4000 CR4:
> > 00000000003406e0
> > [ 5898.208398] Call Trace:
> > [ 5898.208519]  amdgpu_vm_update_directories+0x2a8/0x3e0 [amdgpu]
>
> This should be fixed with the changes merged by Linus for the 4.19
> release. The relevant fixes were marked for backporting to stable, so
> they should appear in future 4.18.y releases as well.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--000000000000c668700573df7514
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">Em seg, 20 de ag=
o de 2018 12:17, Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpNNg+MwTxZMZA@public.gmane.org=
t">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; escreveu:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">On 2018-08-18 12:39 AM, Br=C3=A1ulio Bhavamitra wrote:<br>
&gt; Chrome freezed and had to be killed, error on dmesg below.<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt; [ 5898.208262] ------------[ cut here ]------------<br>
&gt; [ 5898.208272] kernel BUG at drivers/dma-buf/reservation.c:234!<br>
&gt; [ 5898.208305] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI<br>
&gt; [ 5898.208314] CPU: 6 PID: 2988 Comm: chromium Tainted: G=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0C O<br>
&gt; 4.18.1-arch1-1-ARCH #1<br>
&gt; [ 5898.208317] Hardware name: HP HP ENVY x360 Convertible 15m-bq1xx/83=
C6,<br>
&gt; BIOS F.17 03/29/2018<br>
&gt; [ 5898.208334] RIP: 0010:reservation_object_add_shared_fence+0x31b/0x3=
70<br>
&gt; [ 5898.208336] Code: ff 4c 89 7d 18 c7 45 10 01 00 00 00 e9 e2 fd ff f=
f e8<br>
&gt; 46 8c a8 ff e9 0c fe ff ff b8 18 00 00 00 ba 01 00 00 00 e9 c0 fd ff f=
f<br>
&gt; &lt;0f&gt; 0b 8d 50 01 48 8d 04 c5 18 00 00 00 48 01 d8 45 31 f6 4c 89=
 38<br>
&gt; [ 5898.208373] RSP: 0018:ffffa1b1ca9abb38 EFLAGS: 00010246<br>
&gt; [ 5898.208377] RAX: 0000000000000004 RBX: ffff9236f1c71580 RCX:<br>
&gt; 0000000000000001<br>
&gt; [ 5898.208380] RDX: 0000000000000001 RSI: ffff92371223da60 RDI:<br>
&gt; ffff9236b196ba18<br>
&gt; [ 5898.208382] RBP: 0000000000000000 R08: ffff9236bc7c3c80 R09:<br>
&gt; ffff92374aba2378<br>
&gt; [ 5898.208385] R10: ffff9237374cded8 R11: ffff9237374cdec8 R12:<br>
&gt; ffff9236b196ba18<br>
&gt; [ 5898.208387] R13: ffff9236b1ac0130 R14: ffff9236bfe3c000 R15:<br>
&gt; ffff92371223da60<br>
&gt; [ 5898.208390] FS:=C2=A0 00007fffe08c2180(0000) GS:ffff92374ab80000(00=
00)<br>
&gt; knlGS:0000000000000000<br>
&gt; [ 5898.208393] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<=
br>
&gt; [ 5898.208395] CR2: 0000265eadacf000 CR3: 00000004794e4000 CR4:<br>
&gt; 00000000003406e0<br>
&gt; [ 5898.208398] Call Trace:<br>
&gt; [ 5898.208519]=C2=A0 amdgpu_vm_update_directories+0x2a8/0x3e0 [amdgpu]=
<br>
<br>
This should be fixed with the changes merged by Linus for the 4.19<br>
release. The relevant fixes were marked for backporting to stable, so<br>
they should appear in future 4.18.y releases as well.<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div>

--000000000000c668700573df7514--

--===============1483744388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1483744388==--
