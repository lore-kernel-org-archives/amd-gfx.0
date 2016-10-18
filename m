From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] x86/pat: export io memory reserve/free api.
Date: Tue, 18 Oct 2016 18:29:30 +1000
Message-ID: <CAPM=9tx2iBaHt-bg_WjUHE3wPprs2GvNt1LZNLngF-GLH2U_Zw@mail.gmail.com>
References: <1476771193-2759-1-git-send-email-airlied@gmail.com>
 <1476771193-2759-2-git-send-email-airlied@gmail.com>
 <d5dcf484-d760-8fe6-bc00-4d6db3ef9d05@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1538487487=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d5dcf484-d760-8fe6-bc00-4d6db3ef9d05-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1538487487==
Content-Type: multipart/alternative; boundary=001a11478364d69910053f1f7d24

--001a11478364d69910053f1f7d24
Content-Type: text/plain; charset=UTF-8

On 18 Oct. 2016 17:23, "Edward O'Callaghan" <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
wrote:
>
> NACK,
>
> I think you want to use 'iomap_create_wc()' instead to avoid aliasing.

Please explain what can alias here?

Dave.

>
> Kind Regards,
> Edward.
>
> On 10/18/2016 05:13 PM, Dave Airlie wrote:
> > From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >
> > These functions are needed for gpu/ttm drivers to reserve the
> > VRAM area as write combined. In a lot of places we don't ioremap
> > but still need to insert pfn from it into a VMA using vm_insert_mixed,
> > but a recent change in mixed insertion means we need to reserve
> > VRAM as WC upfront, so we need these APIs exported.
> >
> > Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/x86/mm/pat.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
> > index 170cc4f..5ce2fbb 100644
> > --- a/arch/x86/mm/pat.c
> > +++ b/arch/x86/mm/pat.c
> > @@ -719,6 +719,7 @@ out_free:
> >  out_err:
> >       return ret;
> >  }
> > +EXPORT_SYMBOL(io_reserve_memtype);
> >
> >  /**
> >   * io_free_memtype - Release a memory type mapping for a region of
memory
> > @@ -729,6 +730,7 @@ void io_free_memtype(resource_size_t start,
resource_size_t end)
> >  {
> >       free_memtype(start, end);
> >  }
> > +EXPORT_SYMBOL(io_free_memtype);
> >
> >  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >                               unsigned long size, pgprot_t vma_prot)
> >
>

--001a11478364d69910053f1f7d24
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On 18 Oct. 2016 17:23, &quot;Edward O&#39;Callaghan&quot; &l=
t;<a href=3D"mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">funfunctor-dczkZgxz+BNOTv0TxJ7zrQ@public.gmane.org=
t</a>&gt; wrote:<br>
&gt;<br>
&gt; NACK,<br>
&gt;<br>
&gt; I think you want to use &#39;iomap_create_wc()&#39; instead to avoid a=
liasing.</p>
<p dir=3D"ltr">Please explain what can alias here?</p>
<p dir=3D"ltr">Dave.</p>
<p dir=3D"ltr">&gt;<br>
&gt; Kind Regards,<br>
&gt; Edward.<br>
&gt;<br>
&gt; On 10/18/2016 05:13 PM, Dave Airlie wrote:<br>
&gt; &gt; From: Dave Airlie &lt;<a href=3D"mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">airli=
ed-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; These functions are needed for gpu/ttm drivers to reserve the<br>
&gt; &gt; VRAM area as write combined. In a lot of places we don&#39;t iore=
map<br>
&gt; &gt; but still need to insert pfn from it into a VMA using vm_insert_m=
ixed,<br>
&gt; &gt; but a recent change in mixed insertion means we need to reserve<b=
r>
&gt; &gt; VRAM as WC upfront, so we need these APIs exported.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Dave Airlie &lt;<a href=3D"mailto:airlied@redhat.c=
om">airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 arch/x86/mm/pat.c | 2 ++<br>
&gt; &gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c<br>
&gt; &gt; index 170cc4f..5ce2fbb 100644<br>
&gt; &gt; --- a/arch/x86/mm/pat.c<br>
&gt; &gt; +++ b/arch/x86/mm/pat.c<br>
&gt; &gt; @@ -719,6 +719,7 @@ out_free:<br>
&gt; &gt;=C2=A0 out_err:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; +EXPORT_SYMBOL(io_reserve_memtype);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 /**<br>
&gt; &gt;=C2=A0 =C2=A0* io_free_memtype - Release a memory type mapping for=
 a region of memory<br>
&gt; &gt; @@ -729,6 +730,7 @@ void io_free_memtype(resource_size_t start, r=
esource_size_t end)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free_memtype(start, end);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; +EXPORT_SYMBOL(io_free_memtype);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 pgprot_t phys_mem_access_prot(struct file *file, unsigned l=
ong pfn,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long size, pgprot_t v=
ma_prot)<br>
&gt; &gt;<br>
&gt;</p>

--001a11478364d69910053f1f7d24--

--===============1538487487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1538487487==--
