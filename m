Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BABBC48286
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Feb 2024 11:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F8A112171;
	Sun,  4 Feb 2024 11:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+YYUSPc";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FBC112171
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Feb 2024 11:20:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C7C3DCE022B;
 Sun,  4 Feb 2024 11:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE51C433C7;
 Sun,  4 Feb 2024 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707045649;
 bh=gyDst7/eGUNtEbvcd5veYryHJOS12fm91uoZLHb14BY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R+YYUSPcUyCeeEuzTDppzp9xZG+icLMMEHXtSxhqpkft2PiUdh6qYQ8whR9lTiSR0
 xHd9H7MwMkCMQ+EL9PoGwVO/JnyNa0EPBNX53KzLDzT1pNJvxOVIBZX9XkCT+sE8Fo
 Zmlwjrew/UHuoA3lfBzKb0QJiTxlWnuqZLZc46v26gNvYNRUZYIiEriEkJZM/mc4kJ
 4mmjp+8GPE77M62rfoXXKzxZAojqHYr+ti8z0Qh+93RLe/w9Td2Eaz0h6SOd490ROU
 SIZksWQZ9rB6stHZf+L87+F4o+8Kuf6R/ICWa3SIrgUXdXvsQj4GFpn2a+plNns+e9
 qOAErYX3CzUUA==
Date: Sun, 4 Feb 2024 13:20:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Emily Deng <Emily.Deng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Add vf reset notification for pf
Message-ID: <20240204112044.GC5400@unreal>
References: <20240204061257.1408243-1-Emily.Deng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204061257.1408243-1-Emily.Deng@amd.com>
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

On Sun, Feb 04, 2024 at 02:12:57PM +0800, Emily Deng wrote:
> When a vf has been reset, the pf wants to get notification to remove the vf
> out of schedule.

It is very questionable if this is right thing to do. The idea of SR-IOV
is that VFs represent a physical device and they should be treated
separately from the PF.

In addition to that Keith said, this patch needs better justification.

Thanks

> 
> Solution:
> Add the callback function in pci_driver sriov_vf_reset_notification. When
> vf reset happens, then call this callback function.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/pci/pci.c   | 8 ++++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..aca937b05531 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4780,6 +4780,14 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> +	struct pci_dev *pf_dev;
> +
> +	if (dev->is_virtfn) {
> +		pf_dev = dev->physfn;
> +		if (pf_dev->driver->sriov_vf_reset_notification)
> +			pf_dev->driver->sriov_vf_reset_notification(pf_dev, dev);
> +	}
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..4fa31d9b0aa7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -926,6 +926,7 @@ struct pci_driver {
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
> +	void  (*sriov_vf_reset_notification)(struct pci_dev *pf, struct pci_dev *vf);
>  	const struct pci_error_handlers *err_handler;
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;
> -- 
> 2.36.1
> 
> 
