From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] drm/amdgpu: Prefer pcie_capability_read_word()
Date: Thu, 18 Jul 2019 07:58:52 -0500
Message-ID: <CAErSpo5S=VyyV6Euzf7qhO0zukU_mnXqJgEhy9fwR0AYf4LTpA@mail.gmail.com>
References: <20190718020745.8867-1-fred@fredlawl.com> <20190718020745.8867-2-fred@fredlawl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718020745.8867-2-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederick Lawler <fred@fredlawl.com>
Cc: David Airlie <airlied@linux.ie>, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, DRI mailing list <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jul 17, 2019 at 9:08 PM Frederick Lawler <fred@fredlawl.com> wrote:
>
> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
> added accessors for the PCI Express Capability so that drivers didn't
> need to be aware of differences between v1 and v2 of the PCI
> Express Capability.
>
> Replace pci_read_config_word() and pci_write_config_word() calls with
> pcie_capability_read_word() and pcie_capability_write_word().
>
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>

> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
> +                               pcie_capability_read_word(adev->pdev,
> +                                                         PCI_EXP_LNKCTL2,
> +                                                         &tmp16);
>                                 tmp16 &= ~((1 << 4) | (7 << 9));
>                                 tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));

Same comments as for radeon.  Looks like a lot of similar code between
radeon and amdgpu.
