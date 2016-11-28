From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
 unavailable
Date: Mon, 28 Nov 2016 05:48:58 +0000
Message-ID: <CAHbf0-HzBPXOqS_XLctTu-eTuxUUwP62_TcODVPwKb8T2PFrFg@mail.gmail.com>
References: <20161123012225.11586-1-peter@lekensteyn.nl>
 <CADnq5_On72XmLrE3wjD0u1=tmwghv6GofzfEGM5mhGoVtJav+Q@mail.gmail.com>
 <20161123171255.GA18537@al>
 <MWHPR12MB16949832E9DB44C53995493AF7B70@MWHPR12MB1694.namprd12.prod.outlook.com>
 <CAHbf0-FgRU=6tYe2SYcm8E0ZvJuRFoqPpk77_DZdQKXdxZSsGg@mail.gmail.com>
 <20161126101942.GA20829@al>
 <CAHbf0-HfHGt5HvAosxgVf=rgevPK3KqBCQt4cJqjDiEaQWM1pQ@mail.gmail.com>
 <CAHbf0-HHFFthD3Li0wM8x5rciRreeWoE0SkQOvsENT9+ZRFEcg@mail.gmail.com>
 <20161126113853.GA25175@al>
 <CAHbf0-GjBMb2GfFoTADxYjfuLU=+hkJ8AcZCbh70zrpn56cD8A@mail.gmail.com>
 <20161126141407.GB25175@al>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1701085781=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161126141407.GB25175@al>
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

--===============1701085781==
Content-Type: multipart/alternative; boundary=001a11423f44d9235e0542560765

--001a11423f44d9235e0542560765
Content-Type: text/plain; charset=UTF-8

The attached patch allows my machine to boot also

Thanks

Mike

On Sat, 26 Nov 2016 at 14:14 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:

> Found the problem.
>
> amdgpu_atpx_pci_probe_handle is used to detect the ATPX handle, but this
> does not necessarily have to be on the dGPU. In fact, on your machine it
> is located on the Intel iGPU (00:02.0):
>
> [  134.760509] vga_switcheroo: detected switching method
> \_SB_.PCI0.GFX0.ATPX handle
>
> The parent device of the iGPU (00:00.0) is the root port which has no
> PCIe capability, hence bridge_d3 evaluated to false.
>
> Can you try the attached patch?
>
> Kind regards,
> Peter
>
> On Sat, Nov 26, 2016 at 01:49:08PM +0000, Mike Lothian wrote:
> > I can confirm the patch allows my machine to boot again
> >
> > On Sat, 26 Nov 2016 at 11:39 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
> >
> > > Hi Mike,
> > >
> > > To grab console output, you could also try to blacklist amdgpu at
> > > startup and load it later.
> > >
> > > Can you provide your acpidump (and lspci -nn, especially if you do not
> > > have a dmesg).
> > >
> > > This is the call chain:
> > >
> > > + amdgpu_atpx_detect
> > >   + amdgpu_atpx_pci_probe_handle
> > >     + return if ATPX ACPI handle cannot be found
> > >     + set amdgpu_atpx_priv.bridge_pm_usable
> > >   + amdgpu_atpx_init
> > >     + amdgpu_atpx_validate
> > >       + use amdgpu_atpx_priv.bridge_pm_usable
> > >
> > > I wonder whether newer devices remove ATPX completely. If that is the
> > > case (please provide acpidump!), can you try this hack:
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > index 951addf..5c23382 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > @@ -487,6 +487,7 @@ static bool amdgpu_atpx_pci_probe_handle(struct
> > > pci_dev *pdev)
> > >         status = acpi_get_handle(dhandle, "ATPX", &atpx_handle);
> > >         if (ACPI_FAILURE(status)) {
> > >                 amdgpu_atpx_priv.other_handle = dhandle;
> > > +               amdgpu_atpx_priv.bridge_pm_usable = true;
> > >                 return false;
> > >         }
> > >         amdgpu_atpx_priv.dhandle = dhandle;
> > >
> > > This is not intended for merging, but just testing a hypothesis.
> > >
> > > Kind regards,
> > > Peter
> > >
> > > On Sat, Nov 26, 2016 at 11:20:28AM +0000, Mike Lothian wrote:
> > > > He's some screen shots of the booting screens, apologies they're not
> that
> > > > clear
> > > >
> > > > https://imgur.com/a/V7mRA
> > > >
> > > > On Sat, 26 Nov 2016 at 11:00 Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
> wrote:
> > > >
> > > > > Hi
> > > > >
> > > > > The previous working kernel, was the patch before this - reverting
> > > fixes it
> > > > >
> > > > > My bios date is quite new 08/05/2016
> > > > >
> > > > > Most of the messages fly straight off the screen, the journal isn't
> > > kept
> > > > > and the wifi driver also complains, will see if I can get a slow
> motion
> > > > > capture of the errors and screen shot them
> > > > >
> > > > > Regards
> > > > >
> > > > > Mike
> > > > >
> > > > > On Sat, 26 Nov 2016 at 10:20 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
> > > > >
> > > > > Hi Mike,
> > > > >
> > > > > On Sat, Nov 26, 2016 at 12:36:27AM +0000, Mike Lothian wrote:
> > > > > > This patch is preventing my laptop from booting, I'm getting D3
> error
> > > > > > messages and atom bios stuck messages
> > > > >
> > > > > Can you post a dmesg and acpidump? What was the previous working
> > > kernel?
> > > > > I suppose your BIOS date (/sys/class/dmi/id/bios_date) is pre-2015?
> > > > > Does booting with runpm=0 work?
> > > > >
> > > > > > I mistakenly saw the v2 patch and didn't realise it was for
> radeon
> > > not
> > > > > > amdgpu - this branch and Linus's tree are currently not booting
> for
> > > me
> > > > >
> > > > > What do you mean by this?
> > > > >
> > > > > Kind regards,
> > > > > Peter
> > > > >
> > > > > > On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander <
> > > > > Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> > > > > > wrote:
> > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Peter Wu [mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org]
> > > > > > > > Sent: Wednesday, November 23, 2016 12:13 PM
> > > > > > > > To: Alex Deucher
> > > > > > > > Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh
> > > > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when
> port
> > > pm is
> > > > > > > > unavailable
> > > > > > > >
> > > > > > > > On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher wrote:
> > > > > > > > >  On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu <
> > > peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > > > > > wrote:
> > > > > > > > > > When PCIe port PM is not enabled (system BIOS is
> pre-2015 or
> > > the
> > > > > > > > > > pcie_port_pm=off parameter is set), legacy ATPX PM should
> > > still
> > > > > be
> > > > > > > > > > marked as supported. Otherwise the GPU can fail to power
> on
> > > after
> > > > > > > > > > runtime suspend. This affected a Dell Inspiron 5548.
> > > > > > > > > >
> > > > > > > > > > Ideally the BIOS date in the PCI core is lowered to 2013
> (the
> > > > > first
> > > > > > > year
> > > > > > > > > > where hybrid graphics platforms using power resources was
> > > > > > > introduced),
> > > > > > > > > > but that seems more risky at this point and would not
> solve
> > > the
> > > > > > > > > > pcie_port_pm=off issue.
> > > > > > > > > >
> > > > > > > > > > Bugzilla:
> https://bugs.freedesktop.org/show_bug.cgi?id=98505
> > > > > > > > > > Reported-and-tested-by: Nayan Deshmukh
> > > > > > > > <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > > > > > > Signed-off-by: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > > > > > > > > ---
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > This patch is already three weeks old. One alternative
> idea
> > > was
> > > > > > > lowering
> > > > > > > > BIOS
> > > > > > > > > > date in PCI core, but as pcie_port_pm=force did not have
> the
> > > > > desired
> > > > > > > > effect, I
> > > > > > > > > > do not think that this would help though.
> > > > > > > > >
> > > > > > > > > Thanks for doing this.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I have also not contacted linux-pci or Mika about
> lowering
> > > the
> > > > > year
> > > > > > > due to
> > > > > > > > the
> > > > > > > > > > lack of a good reason.  Might do it later though once
> ACPICA
> > > bug
> > > > > > > 1333 is
> > > > > > > > sorted
> > > > > > > > > > out such that lowering the year actually has benefits
> for a
> > > > > Nvidia
> > > > > > > laptop
> > > > > > > > (or if
> > > > > > > > > > some amdgpu problem can be solved by this).
> > > > > > > > > >
> > > > > > > > > > Both patches should probably be Cc stable (4.8+), fixing
> > > > > > > 2f5af82eeab2 and
> > > > > > > > > > b8c9fd5ad4b4 ("track whether if this is a hybrid graphics
> > > > > > > platform"). There
> > > > > > > > have
> > > > > > > > > > been some ifdef 0's and reverts in between, so I was not
> > > sure if
> > > > > > > adding
> > > > > > > > the
> > > > > > > > > > Fixes tag is appropriate.
> > > > > > > > >
> > > > > > > > > I don't think we need to cc stable.  In kernel 4.8 we don't
> > > > > attempt to
> > > > > > > > > do d3cold at all.  4.8 and older kernels have:
> > > > > > > > > c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: work
> > > around
> > > > > > > > lack
> > > > > > > > > of upstream ACPI support for D3cold)
> > > > > > > > > which was reverted for 4.9.
> > > > > > > >
> > > > > > > > That patch was already reverted in 4.8 as far as I can see:
> > > > > > > >
> > > > > > > > $ git tag --contains
> c39b487f195b93235ee76384427467786f7bf29f |
> > > grep
> > > > > v4.8
> > > > > > > > v4.8
> > > > > > > >
> > > > > > > > Can you double-check? v4.8 was the first kernel with D3cold
> > > support
> > > > > in
> > > > > > > > PCI core.
> > > > > > >
> > > > > > > You are right.  I was thinking d3cold went upstream in 4.9, so
> > > yes, we
> > > > > > > should apply this to 4.8.
> > > > > > >
> > > > > > > Alex
> > > > > > >
> > > > > > > >
> > > > > > > > > Series is:
> > > > > > > > > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > > > > > > >
> > > > > > > > Thanks!
> > > > > > > >
> > > > > > > > Kind regards,
> > > > > > > > Peter
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Kind regards,
> > > > > > > > > > Peter
> > > > > > > > > > ---
> > > > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 9
> > > ++++++++-
> > > > > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > > > index 10b5ddf..951addf 100644
> > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > > > @@ -33,6 +33,7 @@ struct amdgpu_atpx {
> > > > > > > > > >
> > > > > > > > > >  static struct amdgpu_atpx_priv {
> > > > > > > > > >         bool atpx_detected;
> > > > > > > > > > +       bool bridge_pm_usable;
> > > > > > > > > >         /* handle for device - and atpx */
> > > > > > > > > >         acpi_handle dhandle;
> > > > > > > > > >         acpi_handle other_handle;
> > > > > > > > > > @@ -200,7 +201,11 @@ static int
> amdgpu_atpx_validate(struct
> > > > > > > > amdgpu_atpx *atpx)
> > > > > > > > > >         atpx->is_hybrid = false;
> > > > > > > > > >         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> > > > > > > > > >                 printk("ATPX Hybrid Graphics\n");
> > > > > > > > > > -               atpx->functions.power_cntl = false;
> > > > > > > > > > +               /*
> > > > > > > > > > +                * Disable legacy PM methods only when
> pcie
> > > port
> > > > > PM
> > > > > > > is usable,
> > > > > > > > > > +                * otherwise the device might fail to
> power
> > > off
> > > > > or
> > > > > > > power on.
> > > > > > > > > > +                */
> > > > > > > > > > +               atpx->functions.power_cntl =
> > > > > > > > !amdgpu_atpx_priv.bridge_pm_usable;
> > > > > > > > > >                 atpx->is_hybrid = true;
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > @@ -471,6 +476,7 @@ static int
> amdgpu_atpx_power_state(enum
> > > > > > > > vga_switcheroo_client_id id,
> > > > > > > > > >   */
> > > > > > > > > >  static bool amdgpu_atpx_pci_probe_handle(struct pci_dev
> > > *pdev)
> > > > > > > > > >  {
> > > > > > > > > > +       struct pci_dev *parent_pdev =
> > > pci_upstream_bridge(pdev);
> > > > > > > > > >         acpi_handle dhandle, atpx_handle;
> > > > > > > > > >         acpi_status status;
> > > > > > > > > >
> > > > > > > > > > @@ -485,6 +491,7 @@ static bool
> > > > > > > > amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
> > > > > > > > > >         }
> > > > > > > > > >         amdgpu_atpx_priv.dhandle = dhandle;
> > > > > > > > > >         amdgpu_atpx_priv.atpx.handle = atpx_handle;
> > > > > > > > > > +       amdgpu_atpx_priv.bridge_pm_usable = parent_pdev
> &&
> > > > > > > > parent_pdev->bridge_d3;
> > > > > > > > > >         return true;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.10.2
>

--001a11423f44d9235e0542560765
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The attached patch allows my machine to boot also<div><br>=
</div><div>Thanks</div><div><br></div><div>Mike</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">On Sat, 26 Nov 2016 at 14:14 Peter Wu &lt=
;<a href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Found the problem.<br class=3D"gmai=
l_msg">
<br class=3D"gmail_msg">
amdgpu_atpx_pci_probe_handle is used to detect the ATPX handle, but this<br=
 class=3D"gmail_msg">
does not necessarily have to be on the dGPU. In fact, on your machine it<br=
 class=3D"gmail_msg">
is located on the Intel iGPU (00:02.0):<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
[=C2=A0 134.760509] vga_switcheroo: detected switching method \_SB_.PCI0.GF=
X0.ATPX handle<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
The parent device of the iGPU (00:00.0) is the root port which has no<br cl=
ass=3D"gmail_msg">
PCIe capability, hence bridge_d3 evaluated to false.<br class=3D"gmail_msg"=
>
<br class=3D"gmail_msg">
Can you try the attached patch?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Kind regards,<br class=3D"gmail_msg">
Peter<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
On Sat, Nov 26, 2016 at 01:49:08PM +0000, Mike Lothian wrote:<br class=3D"g=
mail_msg">
&gt; I can confirm the patch allows my machine to boot again<br class=3D"gm=
ail_msg">
&gt;<br class=3D"gmail_msg">
&gt; On Sat, 26 Nov 2016 at 11:39 Peter Wu &lt;<a href=3D"mailto:peter@leke=
nsteyn.nl" class=3D"gmail_msg" target=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt=
; wrote:<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &gt; Hi Mike,<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; To grab console output, you could also try to blacklist amdgpu at=
<br class=3D"gmail_msg">
&gt; &gt; startup and load it later.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Can you provide your acpidump (and lspci -nn, especially if you d=
o not<br class=3D"gmail_msg">
&gt; &gt; have a dmesg).<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; This is the call chain:<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; + amdgpu_atpx_detect<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0+ amdgpu_atpx_pci_probe_handle<br class=3D"gmail_msg"=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+ return if ATPX ACPI handle cannot be found<b=
r class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+ set amdgpu_atpx_priv.bridge_pm_usable<br cla=
ss=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0+ amdgpu_atpx_init<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+ amdgpu_atpx_validate<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+ use amdgpu_atpx_priv.bridge_pm_usable=
<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; I wonder whether newer devices remove ATPX completely. If that is=
 the<br class=3D"gmail_msg">
&gt; &gt; case (please provide acpidump!), can you try this hack:<br class=
=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br =
class=3D"gmail_msg">
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br class=3D"gm=
ail_msg">
&gt; &gt; index 951addf..5c23382 100644<br class=3D"gmail_msg">
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br class=
=3D"gmail_msg">
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c<br class=
=3D"gmail_msg">
&gt; &gt; @@ -487,6 +487,7 @@ static bool amdgpu_atpx_pci_probe_handle(stru=
ct<br class=3D"gmail_msg">
&gt; &gt; pci_dev *pdev)<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D acpi_get_handle(dhand=
le, &quot;ATPX&quot;, &amp;atpx_handle);<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ACPI_FAILURE(status)) {<br c=
lass=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdg=
pu_atpx_priv.other_handle =3D dhandle;<br class=3D"gmail_msg">
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_at=
px_priv.bridge_pm_usable =3D true;<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn false;<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_atpx_priv.dhandle =3D dha=
ndle;<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; This is not intended for merging, but just testing a hypothesis.<=
br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; On Sat, Nov 26, 2016 at 11:20:28AM +0000, Mike Lothian wrote:<br =
class=3D"gmail_msg">
&gt; &gt; &gt; He&#39;s some screen shots of the booting screens, apologies=
 they&#39;re not that<br class=3D"gmail_msg">
&gt; &gt; &gt; clear<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; <a href=3D"https://imgur.com/a/V7mRA" rel=3D"noreferrer" cla=
ss=3D"gmail_msg" target=3D"_blank">https://imgur.com/a/V7mRA</a><br class=
=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; On Sat, 26 Nov 2016 at 11:00 Mike Lothian &lt;<a href=3D"mai=
lto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">mike@firebur=
n.co.uk</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Hi<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; The previous working kernel, was the patch before this =
- reverting<br class=3D"gmail_msg">
&gt; &gt; fixes it<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; My bios date is quite new 08/05/2016<br class=3D"gmail_=
msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Most of the messages fly straight off the screen, the j=
ournal isn&#39;t<br class=3D"gmail_msg">
&gt; &gt; kept<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; and the wifi driver also complains, will see if I can g=
et a slow motion<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; capture of the errors and screen shot them<br class=3D"=
gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Regards<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Mike<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; On Sat, 26 Nov 2016 at 10:20 Peter Wu &lt;<a href=3D"ma=
ilto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">peter@leken=
steyn.nl</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Hi Mike,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; On Sat, Nov 26, 2016 at 12:36:27AM +0000, Mike Lothian =
wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; This patch is preventing my laptop from booting, I=
&#39;m getting D3 error<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; messages and atom bios stuck messages<br class=3D"=
gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Can you post a dmesg and acpidump? What was the previou=
s working<br class=3D"gmail_msg">
&gt; &gt; kernel?<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; I suppose your BIOS date (/sys/class/dmi/id/bios_date) =
is pre-2015?<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Does booting with runpm=3D0 work?<br class=3D"gmail_msg=
">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; I mistakenly saw the v2 patch and didn&#39;t reali=
se it was for radeon<br class=3D"gmail_msg">
&gt; &gt; not<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; amdgpu - this branch and Linus&#39;s tree are curr=
ently not booting for<br class=3D"gmail_msg">
&gt; &gt; me<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; What do you mean by this?<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander &l=
t;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; <a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" class=3D"g=
mail_msg" target=3D"_blank">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=3D"g=
mail_msg">
&gt; &gt; &gt; &gt; &gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; -----Original Message-----<br class=3D"g=
mail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; From: Peter Wu [mailto:<a href=3D"mailto=
:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">peter@lekenstey=
n.nl</a>]<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Sent: Wednesday, November 23, 2016 12:13=
 PM<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; To: Alex Deucher<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Cc: amd-gfx list; Deucher, Alexander; Na=
yan Deshmukh<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Subject: Re: [PATCH 1/2] drm/amdgpu: fix=
 power state when port<br class=3D"gmail_msg">
&gt; &gt; pm is<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; unavailable<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Wed, Nov 23, 2016 at 12:01:55PM -0500=
, Alex Deucher wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 On Tue, Nov 22, 2016 at 8:22 =
PM, Peter Wu &lt;<br class=3D"gmail_msg">
&gt; &gt; <a href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; When PCIe port PM is not enabl=
ed (system BIOS is pre-2015 or<br class=3D"gmail_msg">
&gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; pcie_port_pm=3Doff parameter i=
s set), legacy ATPX PM should<br class=3D"gmail_msg">
&gt; &gt; still<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; be<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; marked as supported. Otherwise=
 the GPU can fail to power on<br class=3D"gmail_msg">
&gt; &gt; after<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; runtime suspend. This affected=
 a Dell Inspiron 5548.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Ideally the BIOS date in the P=
CI core is lowered to 2013 (the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; first<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; year<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; where hybrid graphics platform=
s using power resources was<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; introduced),<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; but that seems more risky at t=
his point and would not solve<br class=3D"gmail_msg">
&gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; pcie_port_pm=3Doff issue.<br c=
lass=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Bugzilla: <a href=3D"https://b=
ugs.freedesktop.org/show_bug.cgi?id=3D98505" rel=3D"noreferrer" class=3D"gm=
ail_msg" target=3D"_blank">https://bugs.freedesktop.org/show_bug.cgi?id=3D9=
8505</a><br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Reported-and-tested-by: Nayan =
Deshmukh<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" class=3D"gmail_msg" target=3D"_blank">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a=
>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Signed-off-by: Peter Wu &lt;<a=
 href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">=
peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hi,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; This patch is already three we=
eks old. One alternative idea<br class=3D"gmail_msg">
&gt; &gt; was<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; lowering<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; BIOS<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; date in PCI core, but as pcie_=
port_pm=3Dforce did not have the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; desired<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; effect, I<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; do not think that this would h=
elp though.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks for doing this.<br class=3D"=
gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I have also not contacted linu=
x-pci or Mika about lowering<br class=3D"gmail_msg">
&gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; year<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; due to<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; lack of a good reason.=C2=A0 M=
ight do it later though once ACPICA<br class=3D"gmail_msg">
&gt; &gt; bug<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; 1333 is<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; sorted<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; out such that lowering the yea=
r actually has benefits for a<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; Nvidia<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; laptop<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; (or if<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; some amdgpu problem can be sol=
ved by this).<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Both patches should probably b=
e Cc stable (4.8+), fixing<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; 2f5af82eeab2 and<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; b8c9fd5ad4b4 (&quot;track whet=
her if this is a hybrid graphics<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; platform&quot;). There<br class=3D"gmail_msg"=
>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; have<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; been some ifdef 0&#39;s and re=
verts in between, so I was not<br class=3D"gmail_msg">
&gt; &gt; sure if<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; adding<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; the<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Fixes tag is appropriate.<br c=
lass=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I don&#39;t think we need to cc sta=
ble.=C2=A0 In kernel 4.8 we don&#39;t<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; attempt to<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; do d3cold at all.=C2=A0 4.8 and old=
er kernels have:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; c63695cc5e5f685e924e25a8f9555f6e846=
f1fc6 (drm/amdgpu: work<br class=3D"gmail_msg">
&gt; &gt; around<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; lack<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; of upstream ACPI support for D3cold=
)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; which was reverted for 4.9.<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; That patch was already reverted in 4.8 a=
s far as I can see:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; $ git tag --contains c39b487f195b93235ee=
76384427467786f7bf29f |<br class=3D"gmail_msg">
&gt; &gt; grep<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; v4.8<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; v4.8<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Can you double-check? v4.8 was the first=
 kernel with D3cold<br class=3D"gmail_msg">
&gt; &gt; support<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; in<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; PCI core.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; You are right.=C2=A0 I was thinking d3cold we=
nt upstream in 4.9, so<br class=3D"gmail_msg">
&gt; &gt; yes, we<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; should apply this to 4.8.<br class=3D"gmail_m=
sg">
&gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; Alex<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Series is:<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Reviewed-by: Alex Deucher &lt;<a hr=
ef=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" class=3D"gmail_msg" target=3D"_blan=
k">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks!<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Kind regards,<br class=3D"gmai=
l_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdg=
pu/amdgpu_atpx_handler.c | 9<br class=3D"gmail_msg">
&gt; &gt; ++++++++-<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 8 insert=
ions(+), 1 deletion(-)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/a=
md/amdgpu/amdgpu_atpx_handler.c<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx=
_handler.c<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; index 10b5ddf..951addf 100644<=
br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdg=
pu/amdgpu_atpx_handler.c<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_atpx_handler.c<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -33,6 +33,7 @@ struct amdgp=
u_atpx {<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 static struct amdgpu_atp=
x_priv {<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bool atpx_detected;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol bridge_pm_usable;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* handle for device - and atpx */<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0acpi_handle dhandle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0acpi_handle other_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -200,7 +201,11 @@ static in=
t amdgpu_atpx_validate(struct<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; amdgpu_atpx *atpx)<br class=3D"gmail_msg=
">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0atpx-&gt;is_hybrid =3D false;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (valid_bits &amp; ATPX_MS_HYBRID_GFX_SUPPORTED) {<br class=3D"gmail_m=
sg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;ATPX Hybrid Graphics\n&quot;);<=
br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0atpx-&gt;functions.power_cntl =3D false;<br clas=
s=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Disable legacy PM methods only when pcie<br c=
lass=3D"gmail_msg">
&gt; &gt; port<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; PM<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; is usable,<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * otherwise the device might fail to power<br c=
lass=3D"gmail_msg">
&gt; &gt; off<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; or<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; power on.<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0atpx-&gt;functions.power_cntl =3D<br class=3D"gm=
ail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; !amdgpu_atpx_priv.bridge_pm_usable;<br c=
lass=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atpx-&gt;is_hybrid =3D true;<br class=3D"gma=
il_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -471,6 +476,7 @@ static int=
 amdgpu_atpx_power_state(enum<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; vga_switcheroo_client_id id,<br class=3D=
"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0*/<br class=3D"gma=
il_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 static bool amdgpu_atpx_=
pci_probe_handle(struct pci_dev<br class=3D"gmail_msg">
&gt; &gt; *pdev)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 {<br class=3D"gmail_msg"=
>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct pci_dev *parent_pdev =3D<br class=3D"gmail_msg">
&gt; &gt; pci_upstream_bridge(pdev);<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0acpi_handle dhandle, atpx_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0acpi_status status;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -485,6 +491,7 @@ static boo=
l<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; amdgpu_atpx_pci_probe_handle(struct pci_=
dev *pdev)<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0amdgpu_atpx_priv.dhandle =3D dhandle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0amdgpu_atpx_priv.atpx.handle =3D atpx_handle;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0am=
dgpu_atpx_priv.bridge_pm_usable =3D parent_pdev &amp;&amp;<br class=3D"gmai=
l_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; parent_pdev-&gt;bridge_d3;<br class=3D"g=
mail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return true;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 }<br class=3D"gmail_msg"=
>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --<br class=3D"gmail_msg">
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; 2.10.2<br class=3D"gmail_msg">
</blockquote></div>

--001a11423f44d9235e0542560765--

--===============1701085781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1701085781==--
