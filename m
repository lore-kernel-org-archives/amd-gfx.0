From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
Date: Wed, 30 Oct 2019 21:35:10 +1100
Message-ID: <87o8xyfrmp.fsf@mpe.ellerman.id.au>
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: alexander.deucher@amd.com
Cc: linuxppc-dev@lists.ozlabs.org, Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Hi Kyle,

KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com> writes:
> From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
>
> During kexec some adapters hit an EEH since they are not properly
> shut down in the radeon_pci_shutdown() function. Adding
> radeon_suspend_kms() fixes this issue.
> Enabled only on PPC because this patch causes issues on some other
> boards.

Which adapters hit the issues?

And do we know why they're not shut down correctly in
radeon_pci_shutdown()? That seems like the root cause no?


> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 9e55076..4528f4d 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -379,11 +379,25 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> +#ifdef CONFIG_PPC64
> +	struct drm_device *ddev = pci_get_drvdata(pdev);
> +#endif

This local serves no real purpose and could be avoided, which would also
avoid this ifdef.

>  	/* if we are running in a VM, make sure the device
>  	 * torn down properly on reboot/shutdown
>  	 */
>  	if (radeon_device_is_virtual())
>  		radeon_pci_remove(pdev);
> +
> +#ifdef CONFIG_PPC64
> +	/* Some adapters need to be suspended before a

AFAIK drm uses normal kernel comment style, so this should be:

	/*
	 * Some adapters need to be suspended before a
> +	 * shutdown occurs in order to prevent an error
> +	 * during kexec.
> +	 * Make this power specific becauase it breaks
> +	 * some non-power boards.
> +	 */
> +	radeon_suspend_kms(ddev, true, true, false);

ie, instead do:

	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);

> +#endif
>  }
>  
>  static int radeon_pmops_suspend(struct device *dev)
> -- 
> 1.8.3.1

cheers
