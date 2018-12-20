From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: Trying to run AMD E9260 (Polaris 11) on NXP LS1012A-RDB
Date: Thu, 20 Dec 2018 17:11:54 +0100
Message-ID: <CAGtoiRjahq_zC=QbS3gNCQB-nA++=gs=kKVJhWKNXEY0QQ8y=g@mail.gmail.com>
References: <CAGtoiRiubNF5fCwGvYbC_sxzFk10Ceg79ZsK2fPLXUzFvm_QZw@mail.gmail.com>
 <CADnq5_MC9PLzvouWT=4J_RXkmsAy7NF1bpB-geEgxa-XV1dgQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1607777983=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MC9PLzvouWT=4J_RXkmsAy7NF1bpB-geEgxa-XV1dgQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1607777983==
Content-Type: multipart/alternative; boundary="0000000000003f19ac057d76643a"

--0000000000003f19ac057d76643a
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

I already have a similar patch in, that doesn't fix it just yet. I'll
investigate some more.

Bas Vermeulen

On Thu, Dec 20, 2018 at 4:27 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Dec 20, 2018 at 9:06 AM Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org> wrote:
> >
> > Hi all,
> >
> > I have connected an E9260 (Polaris 11 based) to a mini-PCIe slot on my
> NXP LS1012ARDB.
> > The GPU is seen, all the BARs are correctly assigned (but there's not
> enough PCIe memory space for the big BARs).
> >
> > When I try to load the amdgpu module, I can't get the driver to enable
> the acceleration (the scratch register check fails).
> >
> > The E9260 is connected to a PCIe x1 (Gen2) slot.
> >
> > Anyone have an idea on where to look or how to fix this? This is a
> test-bed before we get an LS1046ARDB with quad core A72's.
> >
> > Any help would be appreciated,
>
> Something like this patch should fix it assuming this is an ARM based
> platform:
> https://patchwork.freedesktop.org/patch/269367/
>
> Alex
>
> >
> > Bas Vermeulen
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000003f19ac057d76643a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div>I already have a similar patch=
 in, that doesn&#39;t fix it just yet. I&#39;ll investigate some more.</div=
><div><br></div><div>Bas Vermeulen</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Thu, Dec 20, 2018 at 4:27 PM Alex Deucher &lt;<a href=
=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Dec 20, 2018=
 at 9:06 AM Bas Vermeulen &lt;<a href=3D"mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org" target=3D=
"_blank">bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I have connected an E9260 (Polaris 11 based) to a mini-PCIe slot on my=
 NXP LS1012ARDB.<br>
&gt; The GPU is seen, all the BARs are correctly assigned (but there&#39;s =
not enough PCIe memory space for the big BARs).<br>
&gt;<br>
&gt; When I try to load the amdgpu module, I can&#39;t get the driver to en=
able the acceleration (the scratch register check fails).<br>
&gt;<br>
&gt; The E9260 is connected to a PCIe x1 (Gen2) slot.<br>
&gt;<br>
&gt; Anyone have an idea on where to look or how to fix this? This is a tes=
t-bed before we get an LS1046ARDB with quad core A72&#39;s.<br>
&gt;<br>
&gt; Any help would be appreciated,<br>
<br>
Something like this patch should fix it assuming this is an ARM based platf=
orm:<br>
<a href=3D"https://patchwork.freedesktop.org/patch/269367/" rel=3D"noreferr=
er" target=3D"_blank">https://patchwork.freedesktop.org/patch/269367/</a><b=
r>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Bas Vermeulen<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--0000000000003f19ac057d76643a--

--===============1607777983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1607777983==--
