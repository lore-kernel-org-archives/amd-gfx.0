From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] drm: replace incorrect Compliance/Margin magic
 numbers with PCI_EXP_LNKCTL2 definitions
Date: Tue, 12 Nov 2019 11:19:15 -0600
Message-ID: <20191112171915.GA167243@google.com>
References: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Nov 12, 2019 at 05:45:15PM +0100, Michel Dänzer wrote:
> On 2019-11-11 8:29 p.m., Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Add definitions for these PCIe Link Control 2 register fields:
> > 
> >   Enter Compliance
> >   Transmit Margin
> > 
> > and use them in amdgpu and radeon.
> > 
> > NOTE: This is a functional change because "7 << 9" was apparently a typo.
> > That mask included the high order bit of Transmit Margin, the Enter
> > Modified Compliance bit, and the Compliance SOS bit, but I think what
> > was intended was the 3-bit Transmit Margin field at bits 9:7.
> 
> Can you split out the functional change into a separate patch 1? That
> could make things easier for anyone who bisects the functional change
> for whatever reason.

Great idea, thanks!  Wish I'd thought of that.

While fixing that, I also noticed I missed one case in
amdgpu/si.c.  I'll post a v3.
