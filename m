From: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
 unavailable
Date: Sat, 26 Nov 2016 15:14:07 +0100
Message-ID: <20161126141407.GB25175@al>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHbf0-GjBMb2GfFoTADxYjfuLU=+hkJ8AcZCbh70zrpn56cD8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Found the problem.

amdgpu_atpx_pci_probe_handle is used to detect the ATPX handle, but this
does not necessarily have to be on the dGPU. In fact, on your machine it
is located on the Intel iGPU (00:02.0):

[  134.760509] vga_switcheroo: detected switching method \_SB_.PCI0.GFX0.ATPX handle

The parent device of the iGPU (00:00.0) is the root port which has no
PCIe capability, hence bridge_d3 evaluated to false.

Can you try the attached patch?

Kind regards,
Peter

On Sat, Nov 26, 2016 at 01:49:08PM +0000, Mike Lothian wrote:
> I can confirm the patch allows my machine to boot again
> 
> On Sat, 26 Nov 2016 at 11:39 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
> 
> > Hi Mike,
> >
> > To grab console output, you could also try to blacklist amdgpu at
> > startup and load it later.
> >
> > Can you provide your acpidump (and lspci -nn, especially if you do not
> > have a dmesg).
> >
> > This is the call chain:
> >
> > + amdgpu_atpx_detect
> >   + amdgpu_atpx_pci_probe_handle
> >     + return if ATPX ACPI handle cannot be found
> >     + set amdgpu_atpx_priv.bridge_pm_usable
> >   + amdgpu_atpx_init
> >     + amdgpu_atpx_validate
> >       + use amdgpu_atpx_priv.bridge_pm_usable
> >
> > I wonder whether newer devices remove ATPX completely. If that is the
> > case (please provide acpidump!), can you try this hack:
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > index 951addf..5c23382 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > @@ -487,6 +487,7 @@ static bool amdgpu_atpx_pci_probe_handle(struct
> > pci_dev *pdev)
> >         status = acpi_get_handle(dhandle, "ATPX", &atpx_handle);
> >         if (ACPI_FAILURE(status)) {
> >                 amdgpu_atpx_priv.other_handle = dhandle;
> > +               amdgpu_atpx_priv.bridge_pm_usable = true;
> >                 return false;
> >         }
> >         amdgpu_atpx_priv.dhandle = dhandle;
> >
> > This is not intended for merging, but just testing a hypothesis.
> >
> > Kind regards,
> > Peter
> >
> > On Sat, Nov 26, 2016 at 11:20:28AM +0000, Mike Lothian wrote:
> > > He's some screen shots of the booting screens, apologies they're not that
> > > clear
> > >
> > > https://imgur.com/a/V7mRA
> > >
> > > On Sat, 26 Nov 2016 at 11:00 Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org> wrote:
> > >
> > > > Hi
> > > >
> > > > The previous working kernel, was the patch before this - reverting
> > fixes it
> > > >
> > > > My bios date is quite new 08/05/2016
> > > >
> > > > Most of the messages fly straight off the screen, the journal isn't
> > kept
> > > > and the wifi driver also complains, will see if I can get a slow motion
> > > > capture of the errors and screen shot them
> > > >
> > > > Regards
> > > >
> > > > Mike
> > > >
> > > > On Sat, 26 Nov 2016 at 10:20 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
> > > >
> > > > Hi Mike,
> > > >
> > > > On Sat, Nov 26, 2016 at 12:36:27AM +0000, Mike Lothian wrote:
> > > > > This patch is preventing my laptop from booting, I'm getting D3 error
> > > > > messages and atom bios stuck messages
> > > >
> > > > Can you post a dmesg and acpidump? What was the previous working
> > kernel?
> > > > I suppose your BIOS date (/sys/class/dmi/id/bios_date) is pre-2015?
> > > > Does booting with runpm=0 work?
> > > >
> > > > > I mistakenly saw the v2 patch and didn't realise it was for radeon
> > not
> > > > > amdgpu - this branch and Linus's tree are currently not booting for
> > me
> > > >
> > > > What do you mean by this?
> > > >
> > > > Kind regards,
> > > > Peter
> > > >
> > > > > On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander <
> > > > Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> > > > > wrote:
> > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Peter Wu [mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org]
> > > > > > > Sent: Wednesday, November 23, 2016 12:13 PM
> > > > > > > To: Alex Deucher
> > > > > > > Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh
> > > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port
> > pm is
> > > > > > > unavailable
> > > > > > >
> > > > > > > On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher wrote:
> > > > > > > >  On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu <
> > peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > > > > wrote:
> > > > > > > > > When PCIe port PM is not enabled (system BIOS is pre-2015 or
> > the
> > > > > > > > > pcie_port_pm=off parameter is set), legacy ATPX PM should
> > still
> > > > be
> > > > > > > > > marked as supported. Otherwise the GPU can fail to power on
> > after
> > > > > > > > > runtime suspend. This affected a Dell Inspiron 5548.
> > > > > > > > >
> > > > > > > > > Ideally the BIOS date in the PCI core is lowered to 2013 (the
> > > > first
> > > > > > year
> > > > > > > > > where hybrid graphics platforms using power resources was
> > > > > > introduced),
> > > > > > > > > but that seems more risky at this point and would not solve
> > the
> > > > > > > > > pcie_port_pm=off issue.
> > > > > > > > >
> > > > > > > > > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98505
> > > > > > > > > Reported-and-tested-by: Nayan Deshmukh
> > > > > > > <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > > > > > Signed-off-by: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
> > > > > > > > > ---
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > This patch is already three weeks old. One alternative idea
> > was
> > > > > > lowering
> > > > > > > BIOS
> > > > > > > > > date in PCI core, but as pcie_port_pm=force did not have the
> > > > desired
> > > > > > > effect, I
> > > > > > > > > do not think that this would help though.
> > > > > > > >
> > > > > > > > Thanks for doing this.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I have also not contacted linux-pci or Mika about lowering
> > the
> > > > year
> > > > > > due to
> > > > > > > the
> > > > > > > > > lack of a good reason.  Might do it later though once ACPICA
> > bug
> > > > > > 1333 is
> > > > > > > sorted
> > > > > > > > > out such that lowering the year actually has benefits for a
> > > > Nvidia
> > > > > > laptop
> > > > > > > (or if
> > > > > > > > > some amdgpu problem can be solved by this).
> > > > > > > > >
> > > > > > > > > Both patches should probably be Cc stable (4.8+), fixing
> > > > > > 2f5af82eeab2 and
> > > > > > > > > b8c9fd5ad4b4 ("track whether if this is a hybrid graphics
> > > > > > platform"). There
> > > > > > > have
> > > > > > > > > been some ifdef 0's and reverts in between, so I was not
> > sure if
> > > > > > adding
> > > > > > > the
> > > > > > > > > Fixes tag is appropriate.
> > > > > > > >
> > > > > > > > I don't think we need to cc stable.  In kernel 4.8 we don't
> > > > attempt to
> > > > > > > > do d3cold at all.  4.8 and older kernels have:
> > > > > > > > c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: work
> > around
> > > > > > > lack
> > > > > > > > of upstream ACPI support for D3cold)
> > > > > > > > which was reverted for 4.9.
> > > > > > >
> > > > > > > That patch was already reverted in 4.8 as far as I can see:
> > > > > > >
> > > > > > > $ git tag --contains c39b487f195b93235ee76384427467786f7bf29f |
> > grep
> > > > v4.8
> > > > > > > v4.8
> > > > > > >
> > > > > > > Can you double-check? v4.8 was the first kernel with D3cold
> > support
> > > > in
> > > > > > > PCI core.
> > > > > >
> > > > > > You are right.  I was thinking d3cold went upstream in 4.9, so
> > yes, we
> > > > > > should apply this to 4.8.
> > > > > >
> > > > > > Alex
> > > > > >
> > > > > > >
> > > > > > > > Series is:
> > > > > > > > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
> > > > > > > Kind regards,
> > > > > > > Peter
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Kind regards,
> > > > > > > > > Peter
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 9
> > ++++++++-
> > > > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > > index 10b5ddf..951addf 100644
> > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > > > > > > > > @@ -33,6 +33,7 @@ struct amdgpu_atpx {
> > > > > > > > >
> > > > > > > > >  static struct amdgpu_atpx_priv {
> > > > > > > > >         bool atpx_detected;
> > > > > > > > > +       bool bridge_pm_usable;
> > > > > > > > >         /* handle for device - and atpx */
> > > > > > > > >         acpi_handle dhandle;
> > > > > > > > >         acpi_handle other_handle;
> > > > > > > > > @@ -200,7 +201,11 @@ static int amdgpu_atpx_validate(struct
> > > > > > > amdgpu_atpx *atpx)
> > > > > > > > >         atpx->is_hybrid = false;
> > > > > > > > >         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> > > > > > > > >                 printk("ATPX Hybrid Graphics\n");
> > > > > > > > > -               atpx->functions.power_cntl = false;
> > > > > > > > > +               /*
> > > > > > > > > +                * Disable legacy PM methods only when pcie
> > port
> > > > PM
> > > > > > is usable,
> > > > > > > > > +                * otherwise the device might fail to power
> > off
> > > > or
> > > > > > power on.
> > > > > > > > > +                */
> > > > > > > > > +               atpx->functions.power_cntl =
> > > > > > > !amdgpu_atpx_priv.bridge_pm_usable;
> > > > > > > > >                 atpx->is_hybrid = true;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > @@ -471,6 +476,7 @@ static int amdgpu_atpx_power_state(enum
> > > > > > > vga_switcheroo_client_id id,
> > > > > > > > >   */
> > > > > > > > >  static bool amdgpu_atpx_pci_probe_handle(struct pci_dev
> > *pdev)
> > > > > > > > >  {
> > > > > > > > > +       struct pci_dev *parent_pdev =
> > pci_upstream_bridge(pdev);
> > > > > > > > >         acpi_handle dhandle, atpx_handle;
> > > > > > > > >         acpi_status status;
> > > > > > > > >
> > > > > > > > > @@ -485,6 +491,7 @@ static bool
> > > > > > > amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
> > > > > > > > >         }
> > > > > > > > >         amdgpu_atpx_priv.dhandle = dhandle;
> > > > > > > > >         amdgpu_atpx_priv.atpx.handle = atpx_handle;
> > > > > > > > > +       amdgpu_atpx_priv.bridge_pm_usable = parent_pdev &&
> > > > > > > parent_pdev->bridge_d3;
> > > > > > > > >         return true;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.10.2

--WIyZ46R2i8wDzkSu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-drm-amdgpu-fix-check-for-port-PM-availability.patch"

>From 483607ff5c5dc6932e2f854d205cf41f9fbf26c8 Mon Sep 17 00:00:00 2001
From: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Date: Sat, 26 Nov 2016 15:05:01 +0100
Subject: [PATCH] drm/amdgpu: fix check for port PM availability

The ATPX method does not always exist on the dGPU, it may be located at
the iGPU. The parent device of the iGPU is the root port for which
bridge_d3 is false. This accidentally enables the legacy PM method which
conflicts with port PM and prevented the dGPU from powering on.

Fixes: 1db4496f167b ("drm/amdgpu: fix power state when port pm is unavailable")
Reported-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Signed-off-by: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 951addf..1ed085f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -476,7 +476,6 @@ static int amdgpu_atpx_power_state(enum vga_switcheroo_client_id id,
  */
 static bool amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
 {
-	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
 	acpi_handle dhandle, atpx_handle;
 	acpi_status status;
 
@@ -491,7 +490,6 @@ static bool amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
 	}
 	amdgpu_atpx_priv.dhandle = dhandle;
 	amdgpu_atpx_priv.atpx.handle = atpx_handle;
-	amdgpu_atpx_priv.bridge_pm_usable = parent_pdev && parent_pdev->bridge_d3;
 	return true;
 }
 
@@ -553,17 +551,25 @@ static bool amdgpu_atpx_detect(void)
 	struct pci_dev *pdev = NULL;
 	bool has_atpx = false;
 	int vga_count = 0;
+	bool d3_supported = false;
+	struct pci_dev *parent_pdev;
 
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
 		vga_count++;
 
 		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
+
+		parent_pdev = pci_upstream_bridge(pdev);
+		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
 	}
 
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		vga_count++;
 
 		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
+
+		parent_pdev = pci_upstream_bridge(pdev);
+		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
 	}
 
 	if (has_atpx && vga_count == 2) {
@@ -571,6 +577,7 @@ static bool amdgpu_atpx_detect(void)
 		printk(KERN_INFO "vga_switcheroo: detected switching method %s handle\n",
 		       acpi_method_name);
 		amdgpu_atpx_priv.atpx_detected = true;
+		amdgpu_atpx_priv.bridge_pm_usable = d3_supported;
 		amdgpu_atpx_init();
 		return true;
 	}
-- 
2.10.2


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--WIyZ46R2i8wDzkSu--
