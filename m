Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E77C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 22:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F8D207D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 22:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFoXKBHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F8D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BA86E0FE;
	Wed,  2 Sep 2020 22:24:01 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFD76E0F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 22:24:01 +0000 (UTC)
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 026FD2078E;
 Wed,  2 Sep 2020 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599085441;
 bh=5f7lIb4QbY0622F+X0Ir61gDDo4JrTGNJF1iLeYsr5g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=GFoXKBHYPK3IE5Z+NMEBvUGCzp5Fbz0GBdAR1mpA5qJajW74QUuaFBd/7q0PO0/6y
 +QjauDCERpleThcGXm8nwZ8oV8HlFC2pAqU1CggsulTuIdJ8SddxWhHwicr2Xy4teZ
 SIRTl865r5MvpwouDwlDmJ2/otEeFob/4j15e6/w=
Date: Wed, 2 Sep 2020 17:23:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v4 4/8] drm/amdgpu: Fix consecutive DPC recovery failures.
Message-ID: <20200902222359.GA272485@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599072130-10043-5-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org,
 nirmodas@amd.com, amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
 luben.tuikov@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 02, 2020 at 02:42:06PM -0400, Andrey Grodzovsky wrote:
> Cache the PCI state on boot and before each case where we might
> loose it.

s/loose/lose/

> v2: Add pci_restore_state while caching the PCI state to avoid
> breaking PCI core logic for stuff like suspend/resume.
> 
> v3: Extract pci_restore_state from amdgpu_device_cache_pci_state
> to avoid superflous restores during GPU resets and suspend/resumes.
> 
> v4: Style fixes.

Is the DRM convention to keep the v2/v3/v4 stuff in the commit log?  I
keep those below the "---" or manually remove them for PCI, but use
the local convention, of course.

> +	/* Have stored pci confspace at hand for restore in sudden PCI error */

I assume that at least from the perspective of this code, all PCI
errors are "sudden".  Or if they're not, I'm curious about which would
be sudden and which would not.

> +	if (amdgpu_device_cache_pci_state(adev->pdev))
> +		pci_restore_state(pdev);

> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	r = pci_save_state(pdev);
> +	if (!r) {
> +		kfree(adev->pci_state);
> +
> +		adev->pci_state = pci_store_saved_state(pdev);
> +
> +		if (!adev->pci_state) {
> +			DRM_ERROR("Failed to store PCI saved state");
> +			return false;
> +		}
> +	} else {
> +		DRM_WARN("Failed to save PCI state, err:%d\n", r);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	if (!adev->pci_state)
> +		return false;
> +
> +	r = pci_load_saved_state(pdev, adev->pci_state);

I'm a little bit hesitant to pci_load_saved_state() and
pci_store_saved_state() being used here, simply because they're
currently only used by VFIO, Xen, and nvme.  So I don't have a real
objection, but just pointing out that apparently you're doing
something really special that isn't commonly used and tested, so it's
more likely to be broken or incomplete.

There's lots of state that the PCI core *can't* save/restore, and
pci_load_saved_state() doesn't even handle all the architected PCI
state, i.e., we only call pci_add_cap_save_buffer() or
pci_add_ext_cap_save_buffer() for a few of the capabilities.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
