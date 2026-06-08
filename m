Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964ECD8CAE
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD23310E119;
	Tue,  9 Jun 2026 07:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="KIxVW0iQ";
	dkim-atps=neutral
X-Greylist: delayed 1523 seconds by postgrey-1.36 at gabe;
 Mon, 08 Jun 2026 09:29:12 UTC
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3404010F051
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U7Df9sJZwkFi8dKXbP5+VW1scr39okO9krfcmqkDa/s=; b=KIxVW0iQ5zEV17WXgrJuByNg4z
 +oirNjFpciCreeyYKxJkEx4enTTKqgv7wZbEElHvr6KIFHDX61e53iCyo6/rtmRmhACPZLDiB1Z+9
 a90kt4n94MP94gDg1vOc1lPZ5pFwSpZH8MoOLD0OvF7dFAkrk78cwntpbKdMRs66XWVQ/twWVbQam
 MUPZh1vhIR5Qa/qxe7xR+Rl38OIuFyhO2zLbcHcKnuf4ztKm8l6OIzZ4FB0M5rznc4HMSdsOShIa3
 rEEQMnhKoHVQW2emgIcaJYNawhrza09jKvL9kbPn+oN4+j2wrtcOwVyA68Z84n/qm2V7hudhVJyH1
 wfCLrI2g==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr
 ([90.63.246.187]:37593 helo=archlinux)
 by pf-012.whm.fr-par.scw.cloud with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
 id 1wWVtc-0000000G1UZ-2FeG; Mon, 08 Jun 2026 11:03:47 +0200
Date: Mon, 8 Jun 2026 11:03:46 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Asad Kamal <asad.kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, 
 hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com, Tom.StDenis@amd.com
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Message-ID: <aiaEMl-b5qo6dmL6@archlinux>
References: <20260603114459.938031-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603114459.938031-1-asad.kamal@amd.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id:
 nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:41 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 03, 2026 at 07:44:59PM +0800, Asad Kamal wrote:
> amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow
> arbitrary MMIO read/write via RREG32/WREG32 without checking
> security_locked_down(). On kernel_lockdown=integrity systems
> this bypasses the same restrictions as /dev/mem and PCI config
> space sysfs.
> 
> Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
> debugfs handler that performs direct register access.
> 
> v2: Use consistent check as per previous check to use
> LOCKDOWN_DEBUGFS(Lijo)
> 
> v3: Do not create any entry from amdgpu_debugfs_regs_init() if
> LOCKDOWN_PCI_ACCESS is active and log once. (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0ce6e2e4342c..5c4d4ff001ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/kthread.h>
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
> +#include <linux/security.h>
>  #include <linux/pm_runtime.h>
>  
>  #include "amdgpu.h"
> @@ -1739,6 +1740,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>  	struct dentry *ent, *root = minor->debugfs_root;
>  	unsigned int i;
>  
> +	if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {
> +		drm_info(adev_to_drm(adev),
> +			 "amdgpu: HW debugfs nodes disabled (kernel lockdown)\n");
> +		return 0;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>  		ent = debugfs_create_file(debugfs_regs_names[i],
>  					  S_IFREG | 0400, root,
> -- 
> 2.46.0
> 

Hi,

Lockdown denies opening of debugfs files but those with the
following conditions :

- The file must only be opened for reading.
- The file must have mode 00444.
- The file must not have ioctl methods fops.
- The file must not have mmap fops.

I might be missing something, but how are you able to write in those ?

Best regards,

Nicolas
