From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: Trying to run AMD E9260 (Polaris 11) on NXP LS1012A-RDB
Date: Fri, 18 Jan 2019 14:21:14 +0100
Message-ID: <CAGtoiRiOACskJTtMEzX5gts_Lo1RrySjPNyEuLCcw+8k31wk2g@mail.gmail.com>
References: <CAGtoiRiubNF5fCwGvYbC_sxzFk10Ceg79ZsK2fPLXUzFvm_QZw@mail.gmail.com>
 <CADnq5_MC9PLzvouWT=4J_RXkmsAy7NF1bpB-geEgxa-XV1dgQQ@mail.gmail.com>
 <CAGtoiRjahq_zC=QbS3gNCQB-nA++=gs=kKVJhWKNXEY0QQ8y=g@mail.gmail.com>
 <CAGtoiRiPHW8a3afkO3ui5FtLP-OztBjVz6CgMgLifgLvnk4QOg@mail.gmail.com>
 <5ae96345-680a-221f-1b04-678cb61f7eca@gmail.com>
 <CAGtoiRiY-TK+_YHwk=f_2vMxJJ6Ucv9AQ2vuoxtufFakKp=hAA@mail.gmail.com>
 <20720365-641e-ac3e-1cfb-9c16133905be@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2023426172=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20720365-641e-ac3e-1cfb-9c16133905be-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2023426172==
Content-Type: multipart/alternative; boundary="00000000000049bb70057fbb638b"

--00000000000049bb70057fbb638b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've since replaced the LS1012ARDB with a LS1046ARDB, and this works out of
the box.
The LS1012ARDB does not have an SMMU, which handles hardware coherency on
ARM.
So amdgpu won't work on any ARM without an SMMU.

Bas Vermeulen

On Thu, Jan 10, 2019 at 2:38 PM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org=
>
wrote:

> Am 10.01.19 um 14:31 schrieb Bas Vermeulen:
>
> On Thu, Jan 10, 2019 at 11:59 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> The PCI Express controller as instantiated on this chip does not support
>> hardware coherency. All incoming PCI Express transactions are made non
>> IO-coherent.
>>
>> Would AMDGPU still work with that PCI Express controller, or is this a
>> show-stopper?
>>
>>
>> I'm really wondering what this comment in the documentation means.
>>
>> As far as I know PCIe doesn't support cache coherency in the downstream
>> and supporting it in the up stream is a must have.
>>
> So what exactly is meant here with IO-coherent?
>>
>
> I believe IO Coherent means that when PCIe writes something to CPU memory=
,
> the caches are flushed or updated
> (or in this case they aren't). I found
> https://community.arm.com/processors/b/blog/posts/extended-system-coheren=
cy---part-1---cache-coherency-fundamentals
>
> with this explanation.
>
>
> Yeah, but as I said this upstream memory coherency is mandatory for PCIe.
>
> When a controller doesn't have that it can't call itself a PCIe
> controller. The spec is pretty clear about that :)
>
> And to answer the original question: Yes, that would be a totally
> show-stopper.
>
> Regards,
> Christian.
>
>
> Regards,
>
> Bas Vermeulen
>
>
>

--00000000000049bb70057fbb638b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve since replaced the LS1012ARDB with a LS1046ARDB, =
and this works out of the box.<div>The LS1012ARDB does not have an SMMU, wh=
ich handles hardware coherency on ARM.</div><div>So amdgpu won&#39;t work o=
n any ARM without an SMMU.</div><div><br></div><div>Bas Vermeulen</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, Jan 10, 2019 at 2:38 PM Koenig, Christian &lt;<a href=3D"mailto:Christi=
an.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">



<div bgcolor=3D"#FFFFFF">
<div class=3D"gmail-m_7847254306218368447moz-cite-prefix">Am 10.01.19 um 14=
:31 schrieb Bas Vermeulen:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">On Thu, Jan 10, 2019 at 11:59 AM Christian K=C3=B6nig &lt;=
<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoen=
ig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
</div>
<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"gmail-m_7847254306218368447gmail-m_9195313590891012054moz-cit=
e-prefix">
<blockquote type=3D"cite">The PCI Express controller as instantiated on thi=
s chip does not support hardware coherency. All incoming PCI Express transa=
ctions are made non IO-coherent.
<div><br>
</div>
<div>Would AMDGPU still work with that PCI Express controller, or is this a=
 show-stopper?</div>
</blockquote>
<br>
I&#39;m really wondering what this comment in the documentation means.<br>
<br>
As far as I know PCIe doesn&#39;t support cache coherency in the downstream=
 and supporting it in the up stream is a must have.<br>
</div>
</div>
</blockquote>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"gmail-m_7847254306218368447gmail-m_9195313590891012054moz-cit=
e-prefix">So what exactly is meant here with IO-coherent?<br>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>I believe IO Coherent means that when PCIe writes something to CPU mem=
ory, the caches are flushed or updated<br>
(or in this case they aren&#39;t). I found=C2=A0<a href=3D"https://communit=
y.arm.com/processors/b/blog/posts/extended-system-coherency---part-1---cach=
e-coherency-fundamentals" target=3D"_blank">https://community.arm.com/proce=
ssors/b/blog/posts/extended-system-coherency---part-1---cache-coherency-fun=
damentals</a>=C2=A0</div>
<div>with this explanation.</div>
</div>
</div>
</div>
</blockquote>
<br>
Yeah, but as I said this upstream memory coherency is mandatory for PCIe.<b=
r>
<br>
When a controller doesn&#39;t have that it can&#39;t call itself a PCIe con=
troller. The spec is pretty clear about that :)<br>
<br>
And to answer the original question: Yes, that would be a totally show-stop=
per.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div><br>
</div>
<div>Regards,</div>
<div><br>
</div>
<div>Bas Vermeulen</div>
</div>
</div>
</div>
</blockquote>
<br>
</div>

</blockquote></div>

--00000000000049bb70057fbb638b--

--===============2023426172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2023426172==--
