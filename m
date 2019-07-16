From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix EEH during kexec
Date: Tue, 16 Jul 2019 14:17:52 -0400
Message-ID: <CADnq5_NvBrRd61=a5XxvVKMs_+_JgBK8ALh_CgOTiG2ZVCEGKQ@mail.gmail.com>
References: <1563300606-28434-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563300606-28434-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc: Chunming Zhou <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 16, 2019 at 2:15 PM KyleMahlkuch
<kmahlkuc@linux.vnet.ibm.com> wrote:
>
> During kexec some adapters hit an EEH since they are not properly
> shut down in the radeon_pci_shutdown() function. Adding
> radeon_suspend_kms() fixes this issue.
>
> Since radeon.h is now included in radeon_drv.c radeon_init() needs
> a new name. I chose radeon_initl(). This can be changed if there is
> another suggestion for a name.
>
> Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 2e96c88..550f9b0 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -32,6 +32,7 @@
>  #include <drm/drmP.h>
>  #include <drm/radeon_drm.h>
>  #include "radeon_drv.h"
> +#include "radeon.h"
>
>  #include <drm/drm_pciids.h>
>  #include <linux/console.h>
> @@ -344,11 +345,21 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> +       struct drm_device *ddev = pci_get_drvdata(pdev);
> +       struct radeon_device *rdev = ddev->dev_private;
> +
>         /* if we are running in a VM, make sure the device
>          * torn down properly on reboot/shutdown
>          */
>         if (radeon_device_is_virtual())
>                 radeon_pci_remove(pdev);
> +
> +       /* Some adapters need to be suspended before a
> +       * shutdown occurs in order to prevent an error
> +       * during kexec.
> +       */
> +       if (rdev->family == CHIP_CAICOS)

You really should be suspending for all asics, not just CAICOS,
otherwise, you may have engines in use.

Alex

> +               radeon_suspend_kms(ddev, true, true, false);
>  }
>
>  static int radeon_pmops_suspend(struct device *dev)
> @@ -589,7 +600,7 @@ static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigne
>         .driver.pm = &radeon_pm_ops,
>  };
>
> -static int __init radeon_init(void)
> +static int __init radeon_initl(void)
>  {
>         if (vgacon_text_force() && radeon_modeset == -1) {
>                 DRM_INFO("VGACON disable radeon kernel modesetting.\n");
> @@ -621,7 +632,7 @@ static void __exit radeon_exit(void)
>         radeon_unregister_atpx_handler();
>  }
>
> -module_init(radeon_init);
> +module_init(radeon_initl);
>  module_exit(radeon_exit);
>
>  MODULE_AUTHOR(DRIVER_AUTHOR);
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
