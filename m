From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: Trying to run AMD E9260 (Polaris 11) on NXP LS1012A-RDB
Date: Thu, 10 Jan 2019 14:31:24 +0100
Message-ID: <CAGtoiRiY-TK+_YHwk=f_2vMxJJ6Ucv9AQ2vuoxtufFakKp=hAA@mail.gmail.com>
References: <CAGtoiRiubNF5fCwGvYbC_sxzFk10Ceg79ZsK2fPLXUzFvm_QZw@mail.gmail.com>
 <CADnq5_MC9PLzvouWT=4J_RXkmsAy7NF1bpB-geEgxa-XV1dgQQ@mail.gmail.com>
 <CAGtoiRjahq_zC=QbS3gNCQB-nA++=gs=kKVJhWKNXEY0QQ8y=g@mail.gmail.com>
 <CAGtoiRiPHW8a3afkO3ui5FtLP-OztBjVz6CgMgLifgLvnk4QOg@mail.gmail.com>
 <5ae96345-680a-221f-1b04-678cb61f7eca@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0167367434=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5ae96345-680a-221f-1b04-678cb61f7eca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0167367434==
Content-Type: multipart/alternative; boundary="000000000000ec9804057f1a98cb"

--000000000000ec9804057f1a98cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 11:59 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> The PCI Express controller as instantiated on this chip does not support
> hardware coherency. All incoming PCI Express transactions are made non
> IO-coherent.
>
> Would AMDGPU still work with that PCI Express controller, or is this a
> show-stopper?
>
>
> I'm really wondering what this comment in the documentation means.
>
> As far as I know PCIe doesn't support cache coherency in the downstream
> and supporting it in the up stream is a must have.
>
So what exactly is meant here with IO-coherent?
>

I believe IO Coherent means that when PCIe writes something to CPU memory,
the caches are flushed or updated
(or in this case they aren't). I found
https://community.arm.com/processors/b/blog/posts/extended-system-coherency=
---part-1---cache-coherency-fundamentals

with this explanation.

Regards,

Bas Vermeulen

--000000000000ec9804057f1a98cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jan 10, 2019 at =
11:59 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"gmail-m_9195313590891012054moz-cite-prefix">
      <blockquote type=3D"cite">The PCI Express controller as instantiated
        on this chip does not
        support hardware coherency. All incoming PCI Express
        transactions are made non IO-coherent.
        <div><br>
        </div>
        <div>Would AMDGPU still work with that PCI Express controller,
          or is this a show-stopper?</div>
      </blockquote>
      <br>
      I&#39;m really wondering what this comment in the documentation means=
.<br>
      <br>
      As far as I know PCIe doesn&#39;t support cache coherency in the
      downstream and supporting it in the up stream is a must have.<br></di=
v></div></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 bgcolor=3D"#FFFFFF"><div class=3D"gmail-m_9195313590891012054moz-cite-pref=
ix">So what exactly is meant here with IO-coherent?<br></div></div></blockq=
uote><div><br></div><div>I believe IO Coherent means that when PCIe writes =
something to CPU memory, the caches are flushed or updated<br>(or in this c=
ase they aren&#39;t). I found=C2=A0<a href=3D"https://community.arm.com/pro=
cessors/b/blog/posts/extended-system-coherency---part-1---cache-coherency-f=
undamentals">https://community.arm.com/processors/b/blog/posts/extended-sys=
tem-coherency---part-1---cache-coherency-fundamentals</a>=C2=A0</div><div>w=
ith this explanation.</div><div><br></div><div>Regards,</div><div><br></div=
><div>Bas Vermeulen</div></div></div></div>

--000000000000ec9804057f1a98cb--

--===============0167367434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0167367434==--
