From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
 unavailable
Date: Sat, 26 Nov 2016 11:00:50 +0000
Message-ID: <CAHbf0-HfHGt5HvAosxgVf=rgevPK3KqBCQt4cJqjDiEaQWM1pQ@mail.gmail.com>
References: <20161123012225.11586-1-peter@lekensteyn.nl>
 <CADnq5_On72XmLrE3wjD0u1=tmwghv6GofzfEGM5mhGoVtJav+Q@mail.gmail.com>
 <20161123171255.GA18537@al>
 <MWHPR12MB16949832E9DB44C53995493AF7B70@MWHPR12MB1694.namprd12.prod.outlook.com>
 <CAHbf0-FgRU=6tYe2SYcm8E0ZvJuRFoqPpk77_DZdQKXdxZSsGg@mail.gmail.com>
 <20161126101942.GA20829@al>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1622737113=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161126101942.GA20829@al>
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
To: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============1622737113==
Content-Type: multipart/alternative; boundary=001a114425d66c419005423227d3

--001a114425d66c419005423227d3
Content-Type: text/plain; charset=UTF-8

Hi

The previous working kernel, was the patch before this - reverting fixes it

My bios date is quite new 08/05/2016

Most of the messages fly straight off the screen, the journal isn't kept
and the wifi driver also complains, will see if I can get a slow motion
capture of the errors and screen shot them

Regards

Mike

On Sat, 26 Nov 2016 at 10:20 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:

> Hi Mike,
>
> On Sat, Nov 26, 2016 at 12:36:27AM +0000, Mike Lothian wrote:
> > This patch is preventing my laptop from booting, I'm getting D3 error
> > messages and atom bios stuck messages
>
> Can you post a dmesg and acpidump? What was the previous working kernel?
> I suppose your BIOS date (/sys/class/dmi/id/bios_date) is pre-2015?
> Does booting with runpm=0 work?
>
> > I mistakenly saw the v2 patch and didn't realise it was for radeon not
> > amdgpu - this branch and Linus's tree are currently not booting for me
>
> What do you mean by this?
>
> Kind regards,
> Peter
>
> > On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander <
> Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> > wrote:
> >
> > > > -----Original Message-----
> > > > From: Peter Wu [mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org]
> > > > Sent: Wednesday, November 23, 2016 12:13 PM
> > > > To: Alex Deucher
> > > > Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh
> > > > Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
> > > > unavailable
> > > >
> > > > On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher wrote:
> > > > >  On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > wrote:
> > > > > > When PCIe port PM is not enabled (system BIOS is pre-2015 or the
> > > > > > pcie_port_pm=off parameter is set), legacy ATPX PM should still
> be
> > > > > > marked as supported. Otherwise the GPU can fail to power on after
> > > > > > runtime suspend. This affected a Dell Inspiron 5548.
> > > > > >
> > > > > > Ideally the BIOS date in the PCI core is lowered to 2013 (the
> first
> > > year
> > > > > > where hybrid graphics platforms using power resources was
> > > introduced),
> > > > > > but that seems more risky at this point and would not solve the
> > > > > > pcie_port_pm=off issue.
> > > > > >
> > > > > > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98505
> > > > > > Reported-and-tested-by: Nayan Deshmukh
> > > > <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > > Signed-off-by: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > > > > ---
> > > > > > Hi,
> > > > > >
> > > > > > This patch is already three weeks old. One alternative idea was
> > > lowering
> > > > BIOS
> > > > > > date in PCI core, but as pcie_port_pm=force did not have the
> desired
> > > > effect, I
> > > > > > do not think that this would help though.
> > > > >
> > > > > Thanks for doing this.
> > > > >
> > > > > >
> > > > > > I have also not contacted linux-pci or Mika about lowering the
> year
> > > due to
> > > > the
> > > > > > lack of a good reason.  Might do it later though once ACPICA bug
> > > 1333 is
> > > > sorted
> > > > > > out such that lowering the year actually has benefits for a
> Nvidia
> > > laptop
> > > > (or if
> > > > > > some amdgpu problem can be solved by this).
> > > > > >
> > > > > > Both patches should probably be Cc stable (4.8+), fixing
> > > 2f5af82eeab2 and
> > > > > > b8c9fd5ad4b4 ("track whether if this is a hybrid graphics
> > > platform"). There
> > > > have
> > > > > > been some ifdef 0's and reverts in between, so I was not sure if
> > > adding
> > > > the
> > > > > > Fixes tag is appropriate.
> > > > >
> > > > > I don't think we need to cc stable.  In kernel 4.8 we don't
> attempt to
> > > > > do d3cold at all.  4.8 and older kernels have:
> > > > > c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: work around
> > > > lack
> > > > > of upstream ACPI support for D3cold)
> > > > > which was reverted for 4.9.
> > > >
> > > > That patch was already reverted in 4.8 as far as I can see:
> > > >
> > > > $ git tag --contains c39b487f195b93235ee76384427467786f7bf29f | grep
> v4.8
> > > > v4.8
> > > >
> > > > Can you double-check? v4.8 was the first kernel with D3cold support
> in
> > > > PCI core.
> > >
> > > You are right.  I was thinking d3cold went upstream in 4.9, so yes, we
> > > should apply this to 4.8.
> > >
> > > Alex
> > >
> > > >
> > > > > Series is:
> > > > > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > > >
> > > > Thanks!
> > > >
> > > > Kind regards,
> > > > Peter
> > > >
> > > > >
> > > > > >
> > > > > > Kind regards,
> > > > > > Peter
> > > > > > ---
> > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 9 ++++++++-
> > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > index 10b5ddf..951addf 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > @@ -33,6 +33,7 @@ struct amdgpu_atpx {
> > > > > >
> > > > > >  static struct amdgpu_atpx_priv {
> > > > > >         bool atpx_detected;
> > > > > > +       bool bridge_pm_usable;
> > > > > >         /* handle for device - and atpx */
> > > > > >         acpi_handle dhandle;
> > > > > >         acpi_handle other_handle;
> > > > > > @@ -200,7 +201,11 @@ static int amdgpu_atpx_validate(struct
> > > > amdgpu_atpx *atpx)
> > > > > >         atpx->is_hybrid = false;
> > > > > >         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> > > > > >                 printk("ATPX Hybrid Graphics\n");
> > > > > > -               atpx->functions.power_cntl = false;
> > > > > > +               /*
> > > > > > +                * Disable legacy PM methods only when pcie port
> PM
> > > is usable,
> > > > > > +                * otherwise the device might fail to power off
> or
> > > power on.
> > > > > > +                */
> > > > > > +               atpx->functions.power_cntl =
> > > > !amdgpu_atpx_priv.bridge_pm_usable;
> > > > > >                 atpx->is_hybrid = true;
> > > > > >         }
> > > > > >
> > > > > > @@ -471,6 +476,7 @@ static int amdgpu_atpx_power_state(enum
> > > > vga_switcheroo_client_id id,
> > > > > >   */
> > > > > >  static bool amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
> > > > > >  {
> > > > > > +       struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > > > > >         acpi_handle dhandle, atpx_handle;
> > > > > >         acpi_status status;
> > > > > >
> > > > > > @@ -485,6 +491,7 @@ static bool
> > > > amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
> > > > > >         }
> > > > > >         amdgpu_atpx_priv.dhandle = dhandle;
> > > > > >         amdgpu_atpx_priv.atpx.handle = atpx_handle;
> > > > > > +       amdgpu_atpx_priv.bridge_pm_usable = parent_pdev &&
> > > > parent_pdev->bridge_d3;
> > > > > >         return true;
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.10.2
>

--001a114425d66c419005423227d3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>The previous working kernel, was the=
 patch before this - reverting fixes it</div><div><br></div><div>My bios da=
te is quite new=C2=A0<span style=3D"font-family:monospace">08/05/2016</span=
></div><span style=3D"font-family:monospace"><br></span><div>Most of the me=
ssages fly straight off the screen, the journal isn&#39;t kept and the wifi=
 driver also complains, will see if I can get a slow motion capture of the =
errors and screen shot them</div><div><br></div><div>Regards</div><div><br>=
</div><div>Mike</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Sat, 26 Nov 2016 at 10:20 Peter Wu &lt;<a href=3D"mailto:peter@lekenstey=
n.nl">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Hi Mike,<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
On Sat, Nov 26, 2016 at 12:36:27AM +0000, Mike Lothian wrote:<br class=3D"g=
mail_msg">
&gt; This patch is preventing my laptop from booting, I&#39;m getting D3 er=
ror<br class=3D"gmail_msg">
&gt; messages and atom bios stuck messages<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Can you post a dmesg and acpidump? What was the previous working kernel?<br=
 class=3D"gmail_msg">
I suppose your BIOS date (/sys/class/dmi/id/bios_date) is pre-2015?<br clas=
s=3D"gmail_msg">
Does booting with runpm=3D0 work?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; I mistakenly saw the v2 patch and didn&#39;t realise it was for radeon=
 not<br class=3D"gmail_msg">
&gt; amdgpu - this branch and Linus&#39;s tree are currently not booting fo=
r me<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
What do you mean by this?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Kind regards,<br class=3D"gmail_msg">
Peter<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander &lt;<a href=3D"mailto:=
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">Alexander.=
Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; wrote:<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; -----Original Message-----<br class=3D"gmail_msg">
&gt; &gt; &gt; From: Peter Wu [mailto:<a href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org=
" class=3D"gmail_msg" target=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>]<br class=
=3D"gmail_msg">
&gt; &gt; &gt; Sent: Wednesday, November 23, 2016 12:13 PM<br class=3D"gmai=
l_msg">
&gt; &gt; &gt; To: Alex Deucher<br class=3D"gmail_msg">
&gt; &gt; &gt; Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt; Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when po=
rt pm is<br class=3D"gmail_msg">
&gt; &gt; &gt; unavailable<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher wrote=
:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;=C2=A0 On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu &lt;<a =
href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">p=
eter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; When PCIe port PM is not enabled (system BIOS is p=
re-2015 or the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; pcie_port_pm=3Doff parameter is set), legacy ATPX =
PM should still be<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; marked as supported. Otherwise the GPU can fail to=
 power on after<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; runtime suspend. This affected a Dell Inspiron 554=
8.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Ideally the BIOS date in the PCI core is lowered t=
o 2013 (the first<br class=3D"gmail_msg">
&gt; &gt; year<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; where hybrid graphics platforms using power resour=
ces was<br class=3D"gmail_msg">
&gt; &gt; introduced),<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; but that seems more risky at this point and would =
not solve the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; pcie_port_pm=3Doff issue.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Bugzilla: <a href=3D"https://bugs.freedesktop.org/=
show_bug.cgi?id=3D98505" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_=
blank">https://bugs.freedesktop.org/show_bug.cgi?id=3D98505</a><br class=3D=
"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Reported-and-tested-by: Nayan Deshmukh<br class=3D=
"gmail_msg">
&gt; &gt; &gt; &lt;<a href=3D"mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=3D"gm=
ail_msg" target=3D"_blank">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br class=3D"gm=
ail_msg">
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Peter Wu &lt;<a href=3D"mailto:pete=
r@lekensteyn.nl" class=3D"gmail_msg" target=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org<=
/a>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Hi,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; This patch is already three weeks old. One alterna=
tive idea was<br class=3D"gmail_msg">
&gt; &gt; lowering<br class=3D"gmail_msg">
&gt; &gt; &gt; BIOS<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; date in PCI core, but as pcie_port_pm=3Dforce did =
not have the desired<br class=3D"gmail_msg">
&gt; &gt; &gt; effect, I<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; do not think that this would help though.<br class=
=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Thanks for doing this.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; I have also not contacted linux-pci or Mika about =
lowering the year<br class=3D"gmail_msg">
&gt; &gt; due to<br class=3D"gmail_msg">
&gt; &gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; lack of a good reason.=C2=A0 Might do it later tho=
ugh once ACPICA bug<br class=3D"gmail_msg">
&gt; &gt; 1333 is<br class=3D"gmail_msg">
&gt; &gt; &gt; sorted<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; out such that lowering the year actually has benef=
its for a Nvidia<br class=3D"gmail_msg">
&gt; &gt; laptop<br class=3D"gmail_msg">
&gt; &gt; &gt; (or if<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; some amdgpu problem can be solved by this).<br cla=
ss=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Both patches should probably be Cc stable (4.8+), =
fixing<br class=3D"gmail_msg">
&gt; &gt; 2f5af82eeab2 and<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; b8c9fd5ad4b4 (&quot;track whether if this is a hyb=
rid graphics<br class=3D"gmail_msg">
&gt; &gt; platform&quot;). There<br class=3D"gmail_msg">
&gt; &gt; &gt; have<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; been some ifdef 0&#39;s and reverts in between, so=
 I was not sure if<br class=3D"gmail_msg">
&gt; &gt; adding<br class=3D"gmail_msg">
&gt; &gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Fixes tag is appropriate.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; I don&#39;t think we need to cc stable.=C2=A0 In kernel=
 4.8 we don&#39;t attempt to<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; do d3cold at all.=C2=A0 4.8 and older kernels have:<br =
class=3D"gmail_msg">
&gt; &gt; &gt; &gt; c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: w=
ork around<br class=3D"gmail_msg">
&gt; &gt; &gt; lack<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; of upstream ACPI support for D3cold)<br class=3D"gmail_=
msg">
&gt; &gt; &gt; &gt; which was reverted for 4.9.<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; That patch was already reverted in 4.8 as far as I can see:<=
br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; $ git tag --contains c39b487f195b93235ee76384427467786f7bf29=
f | grep v4.8<br class=3D"gmail_msg">
&gt; &gt; &gt; v4.8<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Can you double-check? v4.8 was the first kernel with D3cold =
support in<br class=3D"gmail_msg">
&gt; &gt; &gt; PCI core.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; You are right.=C2=A0 I was thinking d3cold went upstream in 4.9, =
so yes, we<br class=3D"gmail_msg">
&gt; &gt; should apply this to 4.8.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Alex<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Series is:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexand=
er.deucher-5C7GfCeVMHo@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">alexander.deucher=
@amd.com</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Thanks!<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handl=
er.c | 9 ++++++++-<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(=
-)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atp=
x_handler.c<br class=3D"gmail_msg">
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br class=
=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; index 10b5ddf..951addf 100644<br class=3D"gmail_ms=
g">
&gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handl=
er.c<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handl=
er.c<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; @@ -33,6 +33,7 @@ struct amdgpu_atpx {<br class=3D=
"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 static struct amdgpu_atpx_priv {<br class=3D=
"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool atpx_detecte=
d;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool bridge_pm_usable;=
<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* handle for dev=
ice - and atpx */<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle dhand=
le;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle other=
_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; @@ -200,7 +201,11 @@ static int amdgpu_atpx_valida=
te(struct<br class=3D"gmail_msg">
&gt; &gt; &gt; amdgpu_atpx *atpx)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atpx-&gt;is_hybri=
d =3D false;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (valid_bits &a=
mp; ATPX_MS_HYBRID_GFX_SUPPORTED) {<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0printk(&quot;ATPX Hybrid Graphics\n&quot;);<br class=3D"gmail_=
msg">
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0atpx-&gt;functions.power_cntl =3D false;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/*<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * Disable legacy PM methods only when pcie port PM<br class=3D"gmail=
_msg">
&gt; &gt; is usable,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * otherwise the device might fail to power off or<br class=3D"gmail_=
msg">
&gt; &gt; power on.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 */<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0atpx-&gt;functions.power_cntl =3D<br class=3D"gmail_msg">
&gt; &gt; &gt; !amdgpu_atpx_priv.bridge_pm_usable;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0atpx-&gt;is_hybrid =3D true;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gma=
il_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; @@ -471,6 +476,7 @@ static int amdgpu_atpx_power_s=
tate(enum<br class=3D"gmail_msg">
&gt; &gt; &gt; vga_switcheroo_client_id id,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0*/<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 static bool amdgpu_atpx_pci_probe_handle(str=
uct pci_dev *pdev)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 {<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *parent=
_pdev =3D pci_upstream_bridge(pdev);<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle dhand=
le, atpx_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_status statu=
s;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; @@ -485,6 +491,7 @@ static bool<br class=3D"gmail_=
msg">
&gt; &gt; &gt; amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)<br class=
=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gma=
il_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.=
dhandle =3D dhandle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.=
atpx.handle =3D atpx_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.bridg=
e_pm_usable =3D parent_pdev &amp;&amp;<br class=3D"gmail_msg">
&gt; &gt; &gt; parent_pdev-&gt;bridge_d3;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br c=
lass=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;=C2=A0 }<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; --<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; 2.10.2<br class=3D"gmail_msg">
</blockquote></div>

--001a114425d66c419005423227d3--

--===============1622737113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1622737113==--
