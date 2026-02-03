Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB21E83EF9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E24210E4DF;
	Wed,  4 Feb 2026 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewi/tLdW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EB810E694
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:52:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FFC040A4F;
 Tue,  3 Feb 2026 14:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04759C16AAE;
 Tue,  3 Feb 2026 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1770130340;
 bh=QwEIeEKpwyUYysR33TYAJDVz/kfO8UKNBpifO8v/BYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ewi/tLdWUFx8NfTW42yfQD+E2Zr4Rmg3uY7evwTH9wh/6fI5MLLAMd0tyw7J46jgk
 ZSMsAVdOtV45EAzKgwD91akAhpePF3NCiOevJQ53aO3ClMs6fL/hPdy7hEcp5XgKoH
 ENIjn0SWRldIXMKKT6mHtFG/xoNtHbjzkA/rrHQs=
Date: Tue, 3 Feb 2026 15:52:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6.18.8] Revert "drm/amd: Check if ASPM is enabled from
 PCIe subsystem"
Message-ID: <2026020308-darling-corroding-d951@gregkh>
References: <20260201002508.1293510-1-spasswolf@web.de>
 <2026020334-vividly-cognitive-e0b6@gregkh>
 <2fcded69-e458-431d-886b-b76c7e3fd9d0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcded69-e458-431d-886b-b76c7e3fd9d0@amd.com>
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

On Tue, Feb 03, 2026 at 08:42:15AM -0600, Mario Limonciello wrote:
> On 2/3/26 8:39 AM, Greg KH wrote:
> > On Sun, Feb 01, 2026 at 01:25:06AM +0100, Bert Karwatzki wrote:
> > > This reverts commit 7294863a6f01248d72b61d38478978d638641bee.
> > > 
> > > This commit was erroneously applied again after commit 0ab5d711ec74
> > > ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
> > > removed it, leading to very hard to debug crashes, when used with a system with two
> > > AMD GPUs of which only one supports ASPM.
> > > 
> > > Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@web.de/
> > > Link: https://github.com/acpica/acpica/issues/1060
> > > Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
> > > 
> > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
> > >   1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 7333e19291cf..ec9516d6ae97 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2334,9 +2334,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> > >   			return -ENODEV;
> > >   	}
> > > -	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> > > -		amdgpu_aspm = 0;
> > > -
> > >   	if (amdgpu_virtual_display ||
> > >   	    amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
> > >   		supports_atomic = true;
> > > -- 
> > > 2.47.3
> > > 
> > > 
> > 
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> FWIW I added a stable tag to the patch when applied to amd-staging-drm-next
> for this.  So it should come back to stable once it merges in Linus' tree.

Great, thanks!

greg k-h
