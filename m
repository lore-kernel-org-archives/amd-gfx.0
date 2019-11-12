From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH V3 0/3] drm: replace magic numbers
Date: Tue, 12 Nov 2019 15:52:49 -0600
Message-ID: <20191112215249.GA214212@google.com>
References: <CY4PR12MB1813200B2297DB19D1921A83F7770@CY4PR12MB1813.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CY4PR12MB1813200B2297DB19D1921A83F7770@CY4PR12MB1813.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Frederick Lawler <fred@fredlawl.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Nov 12, 2019 at 07:35:53PM +0000, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Bjorn Helgaas
> > Sent: Tuesday, November 12, 2019 12:35 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> > <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> > <daniel@ffwll.ch>
> > Cc: Frederick Lawler <fred@fredlawl.com>; linux-pci@vger.kernel.org;
> > Michel Dänzer <michel@daenzer.net>; linux-kernel@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; Bjorn Helgaas
> > <bhelgaas@google.com>; Ilia Mirkin <imirkin@alum.mit.edu>
> > Subject: [PATCH V3 0/3] drm: replace magic numbers
> > 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > amdgpu and radeon do a bit of mucking with the PCIe Link Control 2 register,
> > some of it using hard-coded magic numbers.  The idea here is to replace
> > those with #defines.
> > 
> > Since v2:
> >   - Fix a gpu_cfg2 case in amdgpu/si.c that I had missed
> >   - Separate out the functional changes for better bisection (thanks,
> >     Michel!)
> >   - Add #defines in a patch by themselves (so a GPU revert wouldn't break
> >     other potential users)
> >   - Squash all the magic number -> #define changes into one patch
> > 
> > Since v1:
> >   - Add my signed-off-by and Alex's reviewed-by.
> > 
> 
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> I'm happy to have it go through whatever tree is easiest for you.

OK, thanks!  I applied your reviewed-by and put these on my pci/misc
branch for v5.5, in hopes that we might get a followup patch from Fred
along the lines of 6133b9204c0a ("cxgb4: Prefer
pcie_capability_read_word()")

> > Bjorn Helgaas (3):
> >   PCI: Add #defines for Enter Compliance, Transmit Margin
> >   drm: correct Transmit Margin masks
> >   drm: replace numbers with PCI_EXP_LNKCTL2 definitions
> > 
> >  drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
> > drivers/gpu/drm/amd/amdgpu/si.c  | 22 ++++++++++++++--------
> >  drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
> >  drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
> >  include/uapi/linux/pci_regs.h    |  2 ++
> >  5 files changed, 58 insertions(+), 32 deletions(-)
> > 
> > --
> > 2.24.0.rc1.363.gb1bccd3e3d-goog
> > 
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
