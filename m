From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
Date: Sat, 26 Oct 2019 10:00:32 +0200
Message-ID: <20191026080032.GA554748@kroah.com>
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Sender: stable-owner@vger.kernel.org
To: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc: alexander.deucher@amd.com, stable@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 25, 2019 at 03:40:50PM -0500, KyleMahlkuch wrote:
> From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
> 
> During kexec some adapters hit an EEH since they are not properly
> shut down in the radeon_pci_shutdown() function. Adding
> radeon_suspend_kms() fixes this issue.
> Enabled only on PPC because this patch causes issues on some other
> boards.
> 
> Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
