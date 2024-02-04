Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C52C48286
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Feb 2024 07:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6D110EEF5;
	Sun,  4 Feb 2024 07:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ASaMiiWh";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE21F10EEF5
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Feb 2024 07:08:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D66B460C73;
 Sun,  4 Feb 2024 07:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B1C433C7;
 Sun,  4 Feb 2024 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707030513;
 bh=mqmUJhwMC+hGcCJ5oR07vsws9DjOZ4c7Y8U7ECmQp/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ASaMiiWhSgJ2CqyvHxc9ihtjwFqfRghZNAxwiJDRhCqFqhM5Y4XxX+pSM55YgHRPU
 gjmi4ZnMtGXLjiIfLw2/V0TyCGdMOlMVXbunn7zQzEVZibyORaJ7ZSW2SFZMrpMsto
 TLQT7N8KZSY9MhNWZAkvjv2G/Kh/T7oKqDz3uaBbtnEVUpa6jPhr4bqxNBtajSnitY
 gSienoP7Rj6HOpU4BWsoJhWdHrE3gOO/qZJoabUG8y2APql/Z3lQXBPBnkUuzNeO5A
 1d5j3KXJs+RQnST33R/H+JvNbTYp3FBB7e3Z57dH2jPTa1Ic7aGqaSqZUg15DMyliz
 RIgl3uhPFui0A==
Date: Sun, 4 Feb 2024 00:08:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Emily Deng <Emily.Deng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Add vf reset notification for pf
Message-ID: <Zb8371oj6Xju_2gU@kbusch-mbp.mynextlight.net>
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
> @@ -926,6 +926,7 @@ struct pci_driver {
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
> +	void  (*sriov_vf_reset_notification)(struct pci_dev *pf, struct pci_dev *vf);

You've created a new callback, but there is no user. Could you resubmit
this with an in-kernel use case?
