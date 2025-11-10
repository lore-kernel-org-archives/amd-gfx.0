Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E27BCD1297
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 22:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E2B10E08B;
	Mon, 10 Nov 2025 22:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PXvbE+bs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D548F89D60;
 Mon, 10 Nov 2025 22:53:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0986260195;
 Mon, 10 Nov 2025 22:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB51C4CEF5;
 Mon, 10 Nov 2025 22:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762815228;
 bh=niFGSKVsL+zl2v1NgWvR+689qDLujQv0fgthWWg1O2s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=PXvbE+bsYdzImXhOzu4GtEnYN7ofgLNYfZq6A8so+Li1RSjxOKuGL8LZOL/Y96AEj
 PVoIK6AisVdB+f9xIOngJs+DYlN3QCss5Nl2oGrhyy8C+5rqF6ZgCg0Hu0rxwAyEZO
 D9VF3zs+P4D3nM98QMAU2jvZA7ID3lwGxBQdwn1SrdqcRryjUQ0GmamkMlhIgXglJ/
 ik7YMOzthsQ0JMcBwyhJ1QaJUZ6PXO32fdi/FEYuwY7Psr9Ct/rbXJPXkKQBce7SPx
 ZxJnOT3CdRfA++/LkUYKx/CollXuexELu9G+dA81aSS/kxdyE3TTNss7g+95QhykaW
 Nl7h2j6lz21IQ==
Date: Mon, 10 Nov 2025 16:53:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Simon Richter <Simon.Richter@hogyros.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] drm/i915: Remove driver side BAR release before resize
Message-ID: <20251110225347.GA2141838@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028173551.22578-8-ilpo.jarvinen@linux.intel.com>
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

i915 folks, any objection to this?

On Tue, Oct 28, 2025 at 07:35:49PM +0200, Ilpo Järvinen wrote:
> PCI core handles releasing device's resources and their rollback in
> case of failure of a BAR resizing operation. Releasing resource prior
> to calling pci_resize_resource() prevents PCI core from restoring the
> BARs as they were.
> 
> Remove driver-side release of BARs from the i915 driver.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> index 51bb27e10a4f..ca3de61451a3 100644
> --- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> +++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> @@ -18,16 +18,6 @@
>  #include "gt/intel_gt_regs.h"
>  
>  #ifdef CONFIG_64BIT
> -static void _release_bars(struct pci_dev *pdev)
> -{
> -	int resno;
> -
> -	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
> -		if (pci_resource_len(pdev, resno))
> -			pci_release_resource(pdev, resno);
> -	}
> -}
> -
>  static void
>  _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
>  {
> @@ -35,8 +25,6 @@ _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
>  	int bar_size = pci_rebar_bytes_to_size(size);
>  	int ret;
>  
> -	_release_bars(pdev);
> -
>  	ret = pci_resize_resource(pdev, resno, bar_size);
>  	if (ret) {
>  		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
> -- 
> 2.39.5
> 
