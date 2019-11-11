From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: Clean up code in radeon_pci_shutdown()
Date: Mon, 11 Nov 2019 15:35:58 -0500
Message-ID: <CADnq5_PL1y0O=w6DcZ4uq7B8tJxFx-KpTEr+m2-vVz+d64sVbQ@mail.gmail.com>
References: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc: Chunming Zhou <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Nov 11, 2019 at 3:29 PM Kyle Mahlkuch
<kmahlkuc@linux.vnet.ibm.com> wrote:
>
> From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
>
> This fixes the formatting on one comment and consolidates the
> pci_get_drvdata() into the radeon_suspend_kms().
>
> Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 4528f4d..357d29a 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -379,10 +379,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> -#ifdef CONFIG_PPC64
> -       struct drm_device *ddev = pci_get_drvdata(pdev);
> -#endif
> -
>         /* if we are running in a VM, make sure the device
>          * torn down properly on reboot/shutdown
>          */
> @@ -390,13 +386,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>                 radeon_pci_remove(pdev);
>
>  #ifdef CONFIG_PPC64
> -       /* Some adapters need to be suspended before a
> +       /*
> +        * Some adapters need to be suspended before a
>          * shutdown occurs in order to prevent an error
>          * during kexec.
>          * Make this power specific becauase it breaks
>          * some non-power boards.
>          */
> -       radeon_suspend_kms(ddev, true, true, false);
> +       radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
>  #endif
>  }
>
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
