Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BCFC433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 22:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C186A2078E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqK3n5m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C186A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFA089230;
	Wed,  2 Sep 2020 22:05:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AC989230
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 22:05:57 +0000 (UTC)
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EAAF120767;
 Wed,  2 Sep 2020 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599084357;
 bh=vUMU7CmVTVCz8o4uU7zzGcNh6uiY0ZNHAp6BfETb2/A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=cqK3n5m8o4grCOQsJASgiZ+7zgEkDZSzNdS/LNhBa3mfroODdxjhKCyJEWJHPIdzf
 t+8OFa1ZAkLF1AWFUVwNhOcyC4V9lLJdf+uyttzSv75iBY6vk6MxhdnM96SmClS/3v
 w7ofI+Vlnz8IK1XfJs46az203Ty3v9UphJ5YQmCA=
Date: Wed, 2 Sep 2020 17:05:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v4 3/8] drm/amdgpu: Fix SMU error failure
Message-ID: <20200902220550.GA271051@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599072130-10043-4-git-send-email-andrey.grodzovsky@amd.com>
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

On Wed, Sep 02, 2020 at 02:42:05PM -0400, Andrey Grodzovsky wrote:
> Wait for HW/PSP initiated ASIC reset to complete before
> starting the recovery operations.
> 
> v2: Remove typo
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e999f1f..412d07e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4838,14 +4838,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> -	int r;
> +	int r, i;
>  	bool vram_lost;
> +	u32 memsize;
>  
>  	DRM_INFO("PCI error: slot reset callback!!\n");
>  
> +	/* wait for asic to come out of reset */

I know it's totally OCD, but it is a minor speed bump to read "asic"
here and "ASIC" in the commit log above and the new comment below.

> +	msleep(500);
> +
>  	pci_restore_state(pdev);
>  
> -	adev->in_pci_err_recovery = true;
> +	/* confirm  ASIC came out of reset */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		memsize = amdgpu_asic_get_config_memsize(adev);
> +
> +		if (memsize != 0xffffffff)

I guess this is a spot where you actually depend on an MMIO read
returning 0xffffffff because adev->in_pci_err_recovery is false at
this point, so amdgpu_mm_rreg() will actually *do* the MMIO read
instead of returning 0.  Right?

> +			break;
> +		udelay(1);
> +	}
> +	if (memsize == 0xffffffff) {
> +		r = -ETIME;
> +		goto out;
> +	}
> +
> +	/* TODO Call amdgpu_pre_asic_reset instead */
> +	adev->in_pci_err_recovery = true;	
>  	r = amdgpu_device_ip_suspend(adev);
>  	adev->in_pci_err_recovery = false;
>  	if (r)
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
