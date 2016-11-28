From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when port pm is
 unavailable
Date: Mon, 28 Nov 2016 17:28:00 -0500
Message-ID: <CADnq5_MfLP+Ym+beD+Oak+CTxvyMVYfb9+DQDZuR9pbBWqwQtA@mail.gmail.com>
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
 <CAHbf0-HzBPXOqS_XLctTu-eTuxUUwP62_TcODVPwKb8T2PFrFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11473b8a09775e054263fc0a
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-HzBPXOqS_XLctTu-eTuxUUwP62_TcODVPwKb8T2PFrFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--001a11473b8a09775e054263fc0a
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 28, 2016 at 12:48 AM, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org> wrote:
> The attached patch allows my machine to boot also
>
> Thanks
>
> Mike
>
> On Sat, 26 Nov 2016 at 14:14 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
>>
>> Found the problem.
>>
>> amdgpu_atpx_pci_probe_handle is used to detect the ATPX handle, but this
>> does not necessarily have to be on the dGPU. In fact, on your machine it
>> is located on the Intel iGPU (00:02.0):
>>
>> [  134.760509] vga_switcheroo: detected switching method
>> \_SB_.PCI0.GFX0.ATPX handle
>>
>> The parent device of the iGPU (00:00.0) is the root port which has no
>> PCIe capability, hence bridge_d3 evaluated to false.
>>
>> Can you try the attached patch?

Looks good to me.  Patch for radeon included as well.

Alex

>>
>> Kind regards,
>> Peter
>>
>> On Sat, Nov 26, 2016 at 01:49:08PM +0000, Mike Lothian wrote:
>> > I can confirm the patch allows my machine to boot again
>> >
>> > On Sat, 26 Nov 2016 at 11:39 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
>> >
>> > > Hi Mike,
>> > >
>> > > To grab console output, you could also try to blacklist amdgpu at
>> > > startup and load it later.
>> > >
>> > > Can you provide your acpidump (and lspci -nn, especially if you do not
>> > > have a dmesg).
>> > >
>> > > This is the call chain:
>> > >
>> > > + amdgpu_atpx_detect
>> > >   + amdgpu_atpx_pci_probe_handle
>> > >     + return if ATPX ACPI handle cannot be found
>> > >     + set amdgpu_atpx_priv.bridge_pm_usable
>> > >   + amdgpu_atpx_init
>> > >     + amdgpu_atpx_validate
>> > >       + use amdgpu_atpx_priv.bridge_pm_usable
>> > >
>> > > I wonder whether newer devices remove ATPX completely. If that is the
>> > > case (please provide acpidump!), can you try this hack:
>> > >
>> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > index 951addf..5c23382 100644
>> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > @@ -487,6 +487,7 @@ static bool amdgpu_atpx_pci_probe_handle(struct
>> > > pci_dev *pdev)
>> > >         status = acpi_get_handle(dhandle, "ATPX", &atpx_handle);
>> > >         if (ACPI_FAILURE(status)) {
>> > >                 amdgpu_atpx_priv.other_handle = dhandle;
>> > > +               amdgpu_atpx_priv.bridge_pm_usable = true;
>> > >                 return false;
>> > >         }
>> > >         amdgpu_atpx_priv.dhandle = dhandle;
>> > >
>> > > This is not intended for merging, but just testing a hypothesis.
>> > >
>> > > Kind regards,
>> > > Peter
>> > >
>> > > On Sat, Nov 26, 2016 at 11:20:28AM +0000, Mike Lothian wrote:
>> > > > He's some screen shots of the booting screens, apologies they're not
>> > > > that
>> > > > clear
>> > > >
>> > > > https://imgur.com/a/V7mRA
>> > > >
>> > > > On Sat, 26 Nov 2016 at 11:00 Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
>> > > > wrote:
>> > > >
>> > > > > Hi
>> > > > >
>> > > > > The previous working kernel, was the patch before this - reverting
>> > > fixes it
>> > > > >
>> > > > > My bios date is quite new 08/05/2016
>> > > > >
>> > > > > Most of the messages fly straight off the screen, the journal
>> > > > > isn't
>> > > kept
>> > > > > and the wifi driver also complains, will see if I can get a slow
>> > > > > motion
>> > > > > capture of the errors and screen shot them
>> > > > >
>> > > > > Regards
>> > > > >
>> > > > > Mike
>> > > > >
>> > > > > On Sat, 26 Nov 2016 at 10:20 Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> wrote:
>> > > > >
>> > > > > Hi Mike,
>> > > > >
>> > > > > On Sat, Nov 26, 2016 at 12:36:27AM +0000, Mike Lothian wrote:
>> > > > > > This patch is preventing my laptop from booting, I'm getting D3
>> > > > > > error
>> > > > > > messages and atom bios stuck messages
>> > > > >
>> > > > > Can you post a dmesg and acpidump? What was the previous working
>> > > kernel?
>> > > > > I suppose your BIOS date (/sys/class/dmi/id/bios_date) is
>> > > > > pre-2015?
>> > > > > Does booting with runpm=0 work?
>> > > > >
>> > > > > > I mistakenly saw the v2 patch and didn't realise it was for
>> > > > > > radeon
>> > > not
>> > > > > > amdgpu - this branch and Linus's tree are currently not booting
>> > > > > > for
>> > > me
>> > > > >
>> > > > > What do you mean by this?
>> > > > >
>> > > > > Kind regards,
>> > > > > Peter
>> > > > >
>> > > > > > On Wed, 23 Nov 2016 at 17:16 Deucher, Alexander <
>> > > > > Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
>> > > > > > wrote:
>> > > > > >
>> > > > > > > > -----Original Message-----
>> > > > > > > > From: Peter Wu [mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org]
>> > > > > > > > Sent: Wednesday, November 23, 2016 12:13 PM
>> > > > > > > > To: Alex Deucher
>> > > > > > > > Cc: amd-gfx list; Deucher, Alexander; Nayan Deshmukh
>> > > > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: fix power state when
>> > > > > > > > port
>> > > pm is
>> > > > > > > > unavailable
>> > > > > > > >
>> > > > > > > > On Wed, Nov 23, 2016 at 12:01:55PM -0500, Alex Deucher
>> > > > > > > > wrote:
>> > > > > > > > >  On Tue, Nov 22, 2016 at 8:22 PM, Peter Wu <
>> > > peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
>> > > > > > > wrote:
>> > > > > > > > > > When PCIe port PM is not enabled (system BIOS is
>> > > > > > > > > > pre-2015 or
>> > > the
>> > > > > > > > > > pcie_port_pm=off parameter is set), legacy ATPX PM
>> > > > > > > > > > should
>> > > still
>> > > > > be
>> > > > > > > > > > marked as supported. Otherwise the GPU can fail to power
>> > > > > > > > > > on
>> > > after
>> > > > > > > > > > runtime suspend. This affected a Dell Inspiron 5548.
>> > > > > > > > > >
>> > > > > > > > > > Ideally the BIOS date in the PCI core is lowered to 2013
>> > > > > > > > > > (the
>> > > > > first
>> > > > > > > year
>> > > > > > > > > > where hybrid graphics platforms using power resources
>> > > > > > > > > > was
>> > > > > > > introduced),
>> > > > > > > > > > but that seems more risky at this point and would not
>> > > > > > > > > > solve
>> > > the
>> > > > > > > > > > pcie_port_pm=off issue.
>> > > > > > > > > >
>> > > > > > > > > > Bugzilla:
>> > > > > > > > > > https://bugs.freedesktop.org/show_bug.cgi?id=98505
>> > > > > > > > > > Reported-and-tested-by: Nayan Deshmukh
>> > > > > > > > <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > > > > > > > > > Signed-off-by: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
>> > > > > > > > > > ---
>> > > > > > > > > > Hi,
>> > > > > > > > > >
>> > > > > > > > > > This patch is already three weeks old. One alternative
>> > > > > > > > > > idea
>> > > was
>> > > > > > > lowering
>> > > > > > > > BIOS
>> > > > > > > > > > date in PCI core, but as pcie_port_pm=force did not have
>> > > > > > > > > > the
>> > > > > desired
>> > > > > > > > effect, I
>> > > > > > > > > > do not think that this would help though.
>> > > > > > > > >
>> > > > > > > > > Thanks for doing this.
>> > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > > I have also not contacted linux-pci or Mika about
>> > > > > > > > > > lowering
>> > > the
>> > > > > year
>> > > > > > > due to
>> > > > > > > > the
>> > > > > > > > > > lack of a good reason.  Might do it later though once
>> > > > > > > > > > ACPICA
>> > > bug
>> > > > > > > 1333 is
>> > > > > > > > sorted
>> > > > > > > > > > out such that lowering the year actually has benefits
>> > > > > > > > > > for a
>> > > > > Nvidia
>> > > > > > > laptop
>> > > > > > > > (or if
>> > > > > > > > > > some amdgpu problem can be solved by this).
>> > > > > > > > > >
>> > > > > > > > > > Both patches should probably be Cc stable (4.8+), fixing
>> > > > > > > 2f5af82eeab2 and
>> > > > > > > > > > b8c9fd5ad4b4 ("track whether if this is a hybrid
>> > > > > > > > > > graphics
>> > > > > > > platform"). There
>> > > > > > > > have
>> > > > > > > > > > been some ifdef 0's and reverts in between, so I was not
>> > > sure if
>> > > > > > > adding
>> > > > > > > > the
>> > > > > > > > > > Fixes tag is appropriate.
>> > > > > > > > >
>> > > > > > > > > I don't think we need to cc stable.  In kernel 4.8 we
>> > > > > > > > > don't
>> > > > > attempt to
>> > > > > > > > > do d3cold at all.  4.8 and older kernels have:
>> > > > > > > > > c63695cc5e5f685e924e25a8f9555f6e846f1fc6 (drm/amdgpu: work
>> > > around
>> > > > > > > > lack
>> > > > > > > > > of upstream ACPI support for D3cold)
>> > > > > > > > > which was reverted for 4.9.
>> > > > > > > >
>> > > > > > > > That patch was already reverted in 4.8 as far as I can see:
>> > > > > > > >
>> > > > > > > > $ git tag --contains
>> > > > > > > > c39b487f195b93235ee76384427467786f7bf29f |
>> > > grep
>> > > > > v4.8
>> > > > > > > > v4.8
>> > > > > > > >
>> > > > > > > > Can you double-check? v4.8 was the first kernel with D3cold
>> > > support
>> > > > > in
>> > > > > > > > PCI core.
>> > > > > > >
>> > > > > > > You are right.  I was thinking d3cold went upstream in 4.9, so
>> > > yes, we
>> > > > > > > should apply this to 4.8.
>> > > > > > >
>> > > > > > > Alex
>> > > > > > >
>> > > > > > > >
>> > > > > > > > > Series is:
>> > > > > > > > > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> > > > > > > >
>> > > > > > > > Thanks!
>> > > > > > > >
>> > > > > > > > Kind regards,
>> > > > > > > > Peter
>> > > > > > > >
>> > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > > Kind regards,
>> > > > > > > > > > Peter
>> > > > > > > > > > ---
>> > > > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 9
>> > > ++++++++-
>> > > > > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
>> > > > > > > > > >
>> > > > > > > > > > diff --git
>> > > > > > > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > > > > > > > > index 10b5ddf..951addf 100644
>> > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
>> > > > > > > > > > @@ -33,6 +33,7 @@ struct amdgpu_atpx {
>> > > > > > > > > >
>> > > > > > > > > >  static struct amdgpu_atpx_priv {
>> > > > > > > > > >         bool atpx_detected;
>> > > > > > > > > > +       bool bridge_pm_usable;
>> > > > > > > > > >         /* handle for device - and atpx */
>> > > > > > > > > >         acpi_handle dhandle;
>> > > > > > > > > >         acpi_handle other_handle;
>> > > > > > > > > > @@ -200,7 +201,11 @@ static int
>> > > > > > > > > > amdgpu_atpx_validate(struct
>> > > > > > > > amdgpu_atpx *atpx)
>> > > > > > > > > >         atpx->is_hybrid = false;
>> > > > > > > > > >         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
>> > > > > > > > > >                 printk("ATPX Hybrid Graphics\n");
>> > > > > > > > > > -               atpx->functions.power_cntl = false;
>> > > > > > > > > > +               /*
>> > > > > > > > > > +                * Disable legacy PM methods only when
>> > > > > > > > > > pcie
>> > > port
>> > > > > PM
>> > > > > > > is usable,
>> > > > > > > > > > +                * otherwise the device might fail to
>> > > > > > > > > > power
>> > > off
>> > > > > or
>> > > > > > > power on.
>> > > > > > > > > > +                */
>> > > > > > > > > > +               atpx->functions.power_cntl =
>> > > > > > > > !amdgpu_atpx_priv.bridge_pm_usable;
>> > > > > > > > > >                 atpx->is_hybrid = true;
>> > > > > > > > > >         }
>> > > > > > > > > >
>> > > > > > > > > > @@ -471,6 +476,7 @@ static int
>> > > > > > > > > > amdgpu_atpx_power_state(enum
>> > > > > > > > vga_switcheroo_client_id id,
>> > > > > > > > > >   */
>> > > > > > > > > >  static bool amdgpu_atpx_pci_probe_handle(struct pci_dev
>> > > *pdev)
>> > > > > > > > > >  {
>> > > > > > > > > > +       struct pci_dev *parent_pdev =
>> > > pci_upstream_bridge(pdev);
>> > > > > > > > > >         acpi_handle dhandle, atpx_handle;
>> > > > > > > > > >         acpi_status status;
>> > > > > > > > > >
>> > > > > > > > > > @@ -485,6 +491,7 @@ static bool
>> > > > > > > > amdgpu_atpx_pci_probe_handle(struct pci_dev *pdev)
>> > > > > > > > > >         }
>> > > > > > > > > >         amdgpu_atpx_priv.dhandle = dhandle;
>> > > > > > > > > >         amdgpu_atpx_priv.atpx.handle = atpx_handle;
>> > > > > > > > > > +       amdgpu_atpx_priv.bridge_pm_usable = parent_pdev
>> > > > > > > > > > &&
>> > > > > > > > parent_pdev->bridge_d3;
>> > > > > > > > > >         return true;
>> > > > > > > > > >  }
>> > > > > > > > > >
>> > > > > > > > > > --
>> > > > > > > > > > 2.10.2

--001a11473b8a09775e054263fc0a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-drm-radeon-fix-check-for-port-PM-availability.patch"
Content-Disposition: attachment;
	filename="0001-drm-radeon-fix-check-for-port-PM-availability.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iw2nafou0

RnJvbSBjZDIxYjUwNTVjY2E0OWIzMGIwY2FhZjExMDdhOWFhZWI2MGE0NDdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMjggTm92IDIwMTYgMTc6MjM6NDAgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vcmFkZW9uOiBmaXggY2hlY2sgZm9yIHBvcnQgUE0gYXZhaWxhYmlsaXR5CgpUaGUgQVRQ
WCBtZXRob2QgZG9lcyBub3QgYWx3YXlzIGV4aXN0IG9uIHRoZSBkR1BVLCBpdCBtYXkgYmUgbG9j
YXRlZCBhdAp0aGUgaUdQVS4gVGhlIHBhcmVudCBkZXZpY2Ugb2YgdGhlIGlHUFUgaXMgdGhlIHJv
b3QgcG9ydCBmb3Igd2hpY2gKYnJpZGdlX2QzIGlzIGZhbHNlLiBUaGlzIGFjY2lkZW50YWxseSBl
bmFibGVzIHRoZSBsZWdhY3kgUE0gbWV0aG9kIHdoaWNoCmNvbmZsaWN0cyB3aXRoIHBvcnQgUE0g
YW5kIHByZXZlbnRlZCB0aGUgZEdQVSBmcm9tIHBvd2VyaW5nIG9uLgoKUG9ydGVkIGZyb20gYW1k
Z3B1IGNvbW1pdDoKZHJtL2FtZGdwdTogZml4IGNoZWNrIGZvciBwb3J0IFBNIGF2YWlsYWJpbGl0
eQpmcm9tIFBldGVyIFd1LgoKRml4ZXM6IGQzYWMzMWYzYjRiZjlmYWQgKGRybS9yYWRlb246IGZp
eCBwb3dlciBzdGF0ZSB3aGVuIHBvcnQgcG0gaXMgdW5hdmFpbGFibGUgKHYyKSkKU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogUGV0ZXIg
V3UgPHBldGVyQGxla2Vuc3RleW4ubmw+CkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA0
LjgrCi0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRweF9oYW5kbGVyLmMgfCAx
MSArKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdHB4X2hh
bmRsZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0cHhfaGFuZGxlci5jCmlu
ZGV4IDQxMjliMTIuLjBhZTEzY2QyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9hdHB4X2hhbmRsZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9hdHB4X2hhbmRsZXIuYwpAQCAtNDc5LDcgKzQ3OSw2IEBAIHN0YXRpYyBpbnQgcmFkZW9uX2F0
cHhfcG93ZXJfc3RhdGUoZW51bSB2Z2Ffc3dpdGNoZXJvb19jbGllbnRfaWQgaWQsCiAgKi8KIHN0
YXRpYyBib29sIHJhZGVvbl9hdHB4X3BjaV9wcm9iZV9oYW5kbGUoc3RydWN0IHBjaV9kZXYgKnBk
ZXYpCiB7Ci0Jc3RydWN0IHBjaV9kZXYgKnBhcmVudF9wZGV2ID0gcGNpX3Vwc3RyZWFtX2JyaWRn
ZShwZGV2KTsKIAlhY3BpX2hhbmRsZSBkaGFuZGxlLCBhdHB4X2hhbmRsZTsKIAlhY3BpX3N0YXR1
cyBzdGF0dXM7CiAKQEAgLTQ5Myw3ICs0OTIsNiBAQCBzdGF0aWMgYm9vbCByYWRlb25fYXRweF9w
Y2lfcHJvYmVfaGFuZGxlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQogCiAJcmFkZW9uX2F0cHhfcHJp
di5kaGFuZGxlID0gZGhhbmRsZTsKIAlyYWRlb25fYXRweF9wcml2LmF0cHguaGFuZGxlID0gYXRw
eF9oYW5kbGU7Ci0JcmFkZW9uX2F0cHhfcHJpdi5icmlkZ2VfcG1fdXNhYmxlID0gcGFyZW50X3Bk
ZXYgJiYgcGFyZW50X3BkZXYtPmJyaWRnZV9kMzsKIAlyZXR1cm4gdHJ1ZTsKIH0KIApAQCAtNTU1
LDExICs1NTMsMTYgQEAgc3RhdGljIGJvb2wgcmFkZW9uX2F0cHhfZGV0ZWN0KHZvaWQpCiAJc3Ry
dWN0IHBjaV9kZXYgKnBkZXYgPSBOVUxMOwogCWJvb2wgaGFzX2F0cHggPSBmYWxzZTsKIAlpbnQg
dmdhX2NvdW50ID0gMDsKKwlib29sIGQzX3N1cHBvcnRlZCA9IGZhbHNlOworCXN0cnVjdCBwY2lf
ZGV2ICpwYXJlbnRfcGRldjsKIAogCXdoaWxlICgocGRldiA9IHBjaV9nZXRfY2xhc3MoUENJX0NM
QVNTX0RJU1BMQVlfVkdBIDw8IDgsIHBkZXYpKSAhPSBOVUxMKSB7CiAJCXZnYV9jb3VudCsrOwog
CiAJCWhhc19hdHB4IHw9IChyYWRlb25fYXRweF9wY2lfcHJvYmVfaGFuZGxlKHBkZXYpID09IHRy
dWUpOworCisJCXBhcmVudF9wZGV2ID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShwZGV2KTsKKwkJZDNf
c3VwcG9ydGVkIHw9IHBhcmVudF9wZGV2ICYmIHBhcmVudF9wZGV2LT5icmlkZ2VfZDM7CiAJfQog
CiAJLyogc29tZSBuZXdlciBQWCBsYXB0b3BzIG1hcmsgdGhlIGRHUFUgYXMgYSBub24tVkdBIGRp
c3BsYXkgZGV2aWNlICovCkBAIC01NjcsNiArNTcwLDkgQEAgc3RhdGljIGJvb2wgcmFkZW9uX2F0
cHhfZGV0ZWN0KHZvaWQpCiAJCXZnYV9jb3VudCsrOwogCiAJCWhhc19hdHB4IHw9IChyYWRlb25f
YXRweF9wY2lfcHJvYmVfaGFuZGxlKHBkZXYpID09IHRydWUpOworCisJCXBhcmVudF9wZGV2ID0g
cGNpX3Vwc3RyZWFtX2JyaWRnZShwZGV2KTsKKwkJZDNfc3VwcG9ydGVkIHw9IHBhcmVudF9wZGV2
ICYmIHBhcmVudF9wZGV2LT5icmlkZ2VfZDM7CiAJfQogCiAJaWYgKGhhc19hdHB4ICYmIHZnYV9j
b3VudCA9PSAyKSB7CkBAIC01NzQsNiArNTgwLDcgQEAgc3RhdGljIGJvb2wgcmFkZW9uX2F0cHhf
ZGV0ZWN0KHZvaWQpCiAJCXByaW50ayhLRVJOX0lORk8gInZnYV9zd2l0Y2hlcm9vOiBkZXRlY3Rl
ZCBzd2l0Y2hpbmcgbWV0aG9kICVzIGhhbmRsZVxuIiwKIAkJICAgICAgIGFjcGlfbWV0aG9kX25h
bWUpOwogCQlyYWRlb25fYXRweF9wcml2LmF0cHhfZGV0ZWN0ZWQgPSB0cnVlOworCQlyYWRlb25f
YXRweF9wcml2LmJyaWRnZV9wbV91c2FibGUgPSBkM19zdXBwb3J0ZWQ7CiAJCXJhZGVvbl9hdHB4
X2luaXQoKTsKIAkJcmV0dXJuIHRydWU7CiAJfQotLSAKMi41LjUKCg==
--001a11473b8a09775e054263fc0a
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--001a11473b8a09775e054263fc0a--
