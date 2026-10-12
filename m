Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193BFCA9EDE
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 19:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9459C10F314;
	Mon, 12 Oct 2026 19:06:16 +0000 (UTC)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB0B10F2F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 19:06:15 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout3.hostsharing.net (Postfix) with ESMTPS id DA4C62A87;
 Mon, 12 Oct 2026 21:06:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 94FDF600E1CF; Mon, 12 Oct 2026 21:06:13 +0200 (CEST)
Date: Mon, 12 Oct 2026 21:06:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <aditya.garg@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 amd-gfx@lists.freedesktop.org, Jason Perlow <jperlow@gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip unmasking Advisory Non-Fatal
 Errors on T2 SEP
Message-ID: <as0vpb8EVlo_8Gx1@wunner.de>
References: <20261010172301.12764-1-aditya.garg@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010172301.12764-1-aditya.garg@linux.dev>
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

On Sat, Oct 10, 2026 at 10:53:01PM +0530, Aditya Garg wrote:
> Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
> Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering
> off a few seconds after every boot. He also found the PCI Device
> 106b:1802, which corresponds to the Apple T2 Secure Enclave Processor was
> misbehaving and the most likely reason is that the device is ANFE
> incompatible due to Apple's custom hardware.

Nit:  Not sure what "misbehaving" means beyond the sudden power-off?

> +++ b/drivers/pci/pcie/aer.c
> @@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
>  	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
>  	 * 7.8.4.6).
>  	 */
> -	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
> +	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
> +		!dev->no_aer_anfe)
>  		pci_clear_and_set_config_dword(dev,
>  					       dev->aer_cap + PCI_ERR_COR_MASK,
>  					       PCI_ERR_COR_ADV_NFAT, 0);

Nit: The "!dev->no_aer_anfe" is not aligned with the opening brace.

It's probably not necessary to respin for the nits alone because
Bjorn may resolve them when applying the patch.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
