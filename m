From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
 unavailable
Date: Sat, 26 Nov 2016 00:36:27 +0000
Message-ID: <CAHbf0-FgRU=6tYe2SYcm8E0ZvJuRFoqPpk77_DZdQKXdxZSsGg@mail.gmail.com>
References: <20161123012225.11586-1-peter@lekensteyn.nl>
 <CADnq5_On72XmLrE3wjD0u1=tmwghv6GofzfEGM5mhGoVtJav+Q@mail.gmail.com>
 <20161123171255.GA18537@al>
 <MWHPR12MB16949832E9DB44C53995493AF7B70@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0015194520=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16949832E9DB44C53995493AF7B70-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0015194520==
Content-Type: multipart/alternative; boundary=001a1130cf06813f790542296ed1

--001a1130cf06813f790542296ed1
Content-Type: text/plain; charset=UTF-8

This patch is preventing my laptop from booting, I'm getting D3 error
messages and atom bios stuck messages

I mistakenly saw the v2 patch and didn't realise it was for radeon not
amdgpu - this branch and Linus's tree are currently not booting for me

On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

> > -----Original Message-----
> > From: Peter Wu [mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org]
> > Sent: Wednesday, November 23, 2016 12:13 PM
> > To: Alex Deucher
> > Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh
> > Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
> > unavailable
> >
> > On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher wrote:
> > >  On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> wrote:
> > > > When PCIe port PM is not enabled (system BIOS is pre-2015 or the
> > > > pcie_port_pm=off parameter is set), legacy ATPX PM should still be
> > > > marked as supported. Otherwise the GPU can fail to power on after
> > > > runtime suspend. This affected a Dell Inspiron 5548.
> > > >
> > > > Ideally the BIOS date in the PCI core is lowered to 2013 (the first
> year
> > > > where hybrid graphics platforms using power resources was
> introduced),
> > > > but that seems more risky at this point and would not solve the
> > > > pcie_port_pm=off issue.
> > > >
> > > > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98505
> > > > Reported-and-tested-by: Nayan Deshmukh
> > <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > Signed-off-by: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > > ---
> > > > Hi,
> > > >
> > > > This patch is already three weeks old. One alternative idea was
> lowering
> > BIOS
> > > > date in PCI core, but as pcie_port_pm=force did not have the desired
> > effect, I
> > > > do not think that this would help though.
> > >
> > > Thanks for doing this.
> > >
> > > >
> > > > I have also not contacted linux-pci or Mika about lowering the year
> due to
> > the
> > > > lack of a good reason.  Might do it later though once ACPICA bug
> 1333 is
> > sorted
> > > > out such that lowering the year actually has benefits for a Nvidia
> laptop
> > (or if
> > > > some amdgpu problem can be solved by this).
> > > >
> > > > Both patches should probably be Cc stable (4.8+), fixing
> 2f5af82eeab2 and
> > > > b8c9fd5ad4b4 ("track whether if this is a hybrid graphics
> platform"). There
> > have
> > > > been some ifdef 0's and reverts in between, so I was not sure if
> adding
> > the
> > > > Fixes tag is appropriate.
> > >
> > > I don't think we need to cc stable.  In kernel 4.8 we don't attempt to
> > > do d3cold at all.  4.8 and older kernels have:
> > > c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: work around
> > lack
> > > of upstream ACPI support for D3cold)
> > > which was reverted for 4.9.
> >
> > That patch was already reverted in 4.8 as far as I can see:
> >
> > $ git tag --contains c39b487f195b93235ee76384427467786f7bf29f | grep v4.8
> > v4.8
> >
> > Can you double-check? v4.8 was the first kernel with D3cold support in
> > PCI core.
>
> You are right.  I was thinking d3cold went upstream in 4.9, so yes, we
> should apply this to 4.8.
>
> Alex
>
> >
> > > Series is:
> > > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> >
> > Thanks!
> >
> > Kind regards,
> > Peter
> >
> > >
> > > >
> > > > Kind regards,
> > > > Peter
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > index 10b5ddf..951addf 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > @@ -33,6 +33,7 @@ struct amdgpu_atpx {
> > > >
> > > >  static struct amdgpu_atpx_priv {
> > > >         bool atpx_detected;
> > > > +       bool bridge_pm_usable;
> > > >         /* handle for device - and atpx */
> > > >         acpi_handle dhandle;
> > > >         acpi_handle other_handle;
> > > > @@ -200,7 +201,11 @@ static int amdgpu_atpx_validate(struct
> > amdgpu_atpx *atpx)
> > > >         atpx->is_hybrid = false;
> > > >         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> > > >                 printk("ATPX Hybrid Graphics\n");
> > > > -               atpx->functions.power_cntl = false;
> > > > +               /*
> > > > +                * Disable legacy PM methods only when pcie port PM
> is usable,
> > > > +                * otherwise the device might fail to power off or
> power on.
> > > > +                */
> > > > +               atpx->functions.power_cntl =
> > !amdgpu_atpx_priv.bridge_pm_usable;
> > > >                 atpx->is_hybrid = true;
> > > >         }
> > > >
> > > > @@ -471,6 +476,7 @@ static int amdgpu_atpx_power_state(enum
> > vga_switcheroo_client_id id,
> > > >   */
> > > >  static bool amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
> > > >  {
> > > > +       struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > > >         acpi_handle dhandle, atpx_handle;
> > > >         acpi_status status;
> > > >
> > > > @@ -485,6 +491,7 @@ static bool
> > amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
> > > >         }
> > > >         amdgpu_atpx_priv.dhandle = dhandle;
> > > >         amdgpu_atpx_priv.atpx.handle = atpx_handle;
> > > > +       amdgpu_atpx_priv.bridge_pm_usable = parent_pdev &&
> > parent_pdev->bridge_d3;
> > > >         return true;
> > > >  }
> > > >
> > > > --
> > > > 2.10.2
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a1130cf06813f790542296ed1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This patch is preventing my laptop from booting, I&#39;m g=
etting D3 error messages and atom bios stuck messages<div><br></div><div>I =
mistakenly saw the v2 patch and didn&#39;t realise it was for radeon not am=
dgpu - this branch and Linus&#39;s tree are currently not booting for me</d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, 23 Nov 201=
6 at 17:16 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">&gt; -----Original Message-----<br class=3D"gmail_msg">
&gt; From: Peter Wu [mailto:<a href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D=
"gmail_msg" target=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>]<br class=3D"gmail_ms=
g">
&gt; Sent: Wednesday, November 23, 2016 12:13 PM<br class=3D"gmail_msg">
&gt; To: Alex Deucher<br class=3D"gmail_msg">
&gt; Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh<br class=3D"gmail=
_msg">
&gt; Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is<b=
r class=3D"gmail_msg">
&gt; unavailable<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher wrote:<br class=
=3D"gmail_msg">
&gt; &gt;=C2=A0 On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu &lt;<a href=3D"ma=
ilto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">peter@leken=
steyn.nl</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; When PCIe port PM is not enabled (system BIOS is pre-2015 or=
 the<br class=3D"gmail_msg">
&gt; &gt; &gt; pcie_port_pm=3Doff parameter is set), legacy ATPX PM should =
still be<br class=3D"gmail_msg">
&gt; &gt; &gt; marked as supported. Otherwise the GPU can fail to power on =
after<br class=3D"gmail_msg">
&gt; &gt; &gt; runtime suspend. This affected a Dell Inspiron 5548.<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Ideally the BIOS date in the PCI core is lowered to 2013 (th=
e first year<br class=3D"gmail_msg">
&gt; &gt; &gt; where hybrid graphics platforms using power resources was in=
troduced),<br class=3D"gmail_msg">
&gt; &gt; &gt; but that seems more risky at this point and would not solve =
the<br class=3D"gmail_msg">
&gt; &gt; &gt; pcie_port_pm=3Doff issue.<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Bugzilla: <a href=3D"https://bugs.freedesktop.org/show_bug.c=
gi?id=3D98505" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">htt=
ps://bugs.freedesktop.org/show_bug.cgi?id=3D98505</a><br class=3D"gmail_msg=
">
&gt; &gt; &gt; Reported-and-tested-by: Nayan Deshmukh<br class=3D"gmail_msg=
">
&gt; &lt;<a href=3D"mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=3D"gmail_msg" t=
arget=3D"_blank">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Signed-off-by: Peter Wu &lt;<a href=3D"mailto:peter@lekenste=
yn.nl" class=3D"gmail_msg" target=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt;<br=
 class=3D"gmail_msg">
&gt; &gt; &gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt; Hi,<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; This patch is already three weeks old. One alternative idea =
was lowering<br class=3D"gmail_msg">
&gt; BIOS<br class=3D"gmail_msg">
&gt; &gt; &gt; date in PCI core, but as pcie_port_pm=3Dforce did not have t=
he desired<br class=3D"gmail_msg">
&gt; effect, I<br class=3D"gmail_msg">
&gt; &gt; &gt; do not think that this would help though.<br class=3D"gmail_=
msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Thanks for doing this.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; I have also not contacted linux-pci or Mika about lowering t=
he year due to<br class=3D"gmail_msg">
&gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; lack of a good reason.=C2=A0 Might do it later though once A=
CPICA bug 1333 is<br class=3D"gmail_msg">
&gt; sorted<br class=3D"gmail_msg">
&gt; &gt; &gt; out such that lowering the year actually has benefits for a =
Nvidia laptop<br class=3D"gmail_msg">
&gt; (or if<br class=3D"gmail_msg">
&gt; &gt; &gt; some amdgpu problem can be solved by this).<br class=3D"gmai=
l_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Both patches should probably be Cc stable (4.8+), fixing 2f5=
af82eeab2 and<br class=3D"gmail_msg">
&gt; &gt; &gt; b8c9fd5ad4b4 (&quot;track whether if this is a hybrid graphi=
cs platform&quot;). There<br class=3D"gmail_msg">
&gt; have<br class=3D"gmail_msg">
&gt; &gt; &gt; been some ifdef 0&#39;s and reverts in between, so I was not=
 sure if adding<br class=3D"gmail_msg">
&gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; Fixes tag is appropriate.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; I don&#39;t think we need to cc stable.=C2=A0 In kernel 4.8 we do=
n&#39;t attempt to<br class=3D"gmail_msg">
&gt; &gt; do d3cold at all.=C2=A0 4.8 and older kernels have:<br class=3D"g=
mail_msg">
&gt; &gt; c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: work around=
<br class=3D"gmail_msg">
&gt; lack<br class=3D"gmail_msg">
&gt; &gt; of upstream ACPI support for D3cold)<br class=3D"gmail_msg">
&gt; &gt; which was reverted for 4.9.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; That patch was already reverted in 4.8 as far as I can see:<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; $ git tag --contains c39b487f195b93235ee76384427467786f7bf29f | grep v=
4.8<br class=3D"gmail_msg">
&gt; v4.8<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Can you double-check? v4.8 was the first kernel with D3cold support in=
<br class=3D"gmail_msg">
&gt; PCI core.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
You are right.=C2=A0 I was thinking d3cold went upstream in 4.9, so yes, we=
 should apply this to 4.8.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Alex<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &gt; Series is:<br class=3D"gmail_msg">
&gt; &gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher=
@amd.com" class=3D"gmail_msg" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</=
a>&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Thanks!<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Kind regards,<br class=3D"gmail_msg">
&gt; Peter<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt; &gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 9 +=
+++++++-<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.=
c<br class=3D"gmail_msg">
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br class=3D"gmail_m=
sg">
&gt; &gt; &gt; index 10b5ddf..951addf 100644<br class=3D"gmail_msg">
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br cl=
ass=3D"gmail_msg">
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br cl=
ass=3D"gmail_msg">
&gt; &gt; &gt; @@ -33,6 +33,7 @@ struct amdgpu_atpx {<br class=3D"gmail_msg=
">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 static struct amdgpu_atpx_priv {<br class=3D"gmail_msg=
">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool atpx_detected;<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool bridge_pm_usable;<br class=
=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* handle for device - and =
atpx */<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle dhandle;<br cla=
ss=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle other_handle;<b=
r class=3D"gmail_msg">
&gt; &gt; &gt; @@ -200,7 +201,11 @@ static int amdgpu_atpx_validate(struct<=
br class=3D"gmail_msg">
&gt; amdgpu_atpx *atpx)<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atpx-&gt;is_hybrid =3D fals=
e;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (valid_bits &amp; ATPX_M=
S_HYBRID_GFX_SUPPORTED) {<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0printk(&quot;ATPX Hybrid Graphics\n&quot;);<br class=3D"gmail_msg">
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atpx=
-&gt;functions.power_cntl =3D false;<br class=3D"gmail_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<b=
r class=3D"gmail_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * D=
isable legacy PM methods only when pcie port PM is usable,<br class=3D"gmai=
l_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * o=
therwise the device might fail to power off or power on.<br class=3D"gmail_=
msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<=
br class=3D"gmail_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atpx=
-&gt;functions.power_cntl =3D<br class=3D"gmail_msg">
&gt; !amdgpu_atpx_priv.bridge_pm_usable;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0atpx-&gt;is_hybrid =3D true;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; @@ -471,6 +476,7 @@ static int amdgpu_atpx_power_state(enum<=
br class=3D"gmail_msg">
&gt; vga_switcheroo_client_id id,<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0*/<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 static bool amdgpu_atpx_pci_probe_handle(struct pci_de=
v *pdev)<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 {<br class=3D"gmail_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *parent_pdev =3D =
pci_upstream_bridge(pdev);<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle dhandle, atpx_h=
andle;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_status status;<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; @@ -485,6 +491,7 @@ static bool<br class=3D"gmail_msg">
&gt; amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)<br class=3D"gmail_m=
sg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.dhandle =
=3D dhandle;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.atpx.handl=
e =3D atpx_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.bridge_pm_usabl=
e =3D parent_pdev &amp;&amp;<br class=3D"gmail_msg">
&gt; parent_pdev-&gt;bridge_d3;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br class=3D"gm=
ail_msg">
&gt; &gt; &gt;=C2=A0 }<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; --<br class=3D"gmail_msg">
&gt; &gt; &gt; 2.10.2<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div>

--001a1130cf06813f790542296ed1--

--===============0015194520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0015194520==--
