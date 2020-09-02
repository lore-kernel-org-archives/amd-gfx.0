Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA12AC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 21:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774492098B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 21:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLtC+RrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774492098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C646E0EA;
	Wed,  2 Sep 2020 21:56:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CA26E0EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 21:56:13 +0000 (UTC)
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FDB2208C7;
 Wed,  2 Sep 2020 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599083773;
 bh=d+rQ7xmqiTjn/8WtG7+CiHQNlFpV1Vx+xClMhlXgkSI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=RLtC+RrVT6dtacmvbzVE+hAxl+BEhhULzt2i/gefdp/KQPyu0JtQiOvpdkZwOcH2V
 g3B5Zm1ytGaVKQQdIEw9aLSHnbnY/PUEdOxy/m+Ktj4tWPefPxOQWYte6gJfgXpGPR
 1oO/n1f6hEIGKlY2cwdzNFOSTl73hswMbAm9Dg4o=
Date: Wed, 2 Sep 2020 16:56:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
Message-ID: <20200902215612.GA271679@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
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

On Wed, Sep 02, 2020 at 02:42:03PM -0400, Andrey Grodzovsky wrote:
> At this point the ASIC is already post reset by the HW/PSP
> so the HW not in proper state to be configured for suspension,
> some blocks might be even gated and so best is to avoid touching it.
> 
> v2: Rename in_dpc to more meaningful name
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>  6 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c311a3c..b20354f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,7 @@ struct amdgpu_device {
>  	atomic_t			throttling_logging_enabled;
>  	struct ratelimit_state		throttling_logging_rs;
>  	uint32_t			ras_features;
> +	bool                            in_pci_err_recovery;
>  };
>  
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 74a1c03..1fbf8a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>  	uint32_t ret;
>  
> +	if (adev->in_pci_err_recovery)
> +		return 0;

I don't know the whole scheme of this, but this looks racy.

It looks like the normal path through this function is the readl(),
which I assume is an MMIO read from the PCI device.  If this is called
after a PCI error occurs, but before amdgpu_pci_slot_reset() sets
adev->in_pci_err_recovery, the readl() will return 0xffffffff.

If this is called after amdgpu_pci_slot_reset() sets
adev->in_pci_err_recovery, it will return 0.  Do you really want those
two different cases?

>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>  		return amdgpu_kiq_rreg(adev, reg);

> @@ -4773,7 +4809,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  
>  	pci_restore_state(pdev);
>  
> +	adev->in_pci_err_recovery = true;
>  	r = amdgpu_device_ip_suspend(adev);
> +	adev->in_pci_err_recovery = false;
>  	if (r)
>  		goto out;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
