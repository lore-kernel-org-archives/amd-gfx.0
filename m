From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 29/37] PCI: Add pci_enable_atomic_ops_to_root
Date: Tue, 12 Dec 2017 16:42:43 -0700
Message-ID: <20171212234243.GD16603@ziepe.ca>
References: <1512792555-26042-1-git-send-email-Felix.Kuehling@amd.com>
 <1512792555-26042-30-git-send-email-Felix.Kuehling@amd.com>
 <20171212232707.GF53955@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212232707.GF53955@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, oded.gabbay@gmail.com, amd-gfx@lists.freedesktop.org, Jay Cornwall <Jay.Cornwall@amd.com>, linux-pci@vger.kernel.org, Ram Amrani <Ram.Amrani@cavium.com>, Doug Ledford <dledford@redhat.com>, Michal Kalderon <Michal.Kalderon@cavium.com>, Ariel Elior <Ariel.Elior@cavium.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Dec 12, 2017 at 05:27:07PM -0600, Bjorn Helgaas wrote:
> [+cc Ram, Michal, Ariel, Doug, Jason]
> 
> The [29/37] in the subject makes it look like this is part of a larger
> series, but I can't find the rest of it on linux-pci or linux-kernel.

Didn't find the cover letter, but the AMD patchworks captured the series..

https://patchwork.freedesktop.org/project/amd-xorg-ddx/patches/

> I don't want to merge a new interface unless there's an in-tree user
> of it.  I assume the rest of the series includes a user.

Looks like it.

I would also guess we will see users in drivers/infiniband emerge as
CPU coherent atomics are also a topic our hardware drivers will be
interested in. But I am not aware of any pending patches.

Jason
