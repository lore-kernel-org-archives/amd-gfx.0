Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C07BC11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6FB6148E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6FB6148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BDF6E8DB;
	Thu,  1 Jul 2021 08:32:49 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51A56E0CF;
 Thu,  1 Jul 2021 08:32:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DC0D6148E;
 Thu,  1 Jul 2021 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625128367;
 bh=jeJo7YphenF8Dg8KYPz7nEazVfWUMoZvNuna2aAEVg8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=LZjaMP8QrJ6JKOUBckUbp7ZuMObXoKNSP43iQTNxorimi/8RANwU1LtjM9hJKGmr/
 0cWoFCKufK6527GwZO5prrsJls4/R3jeGEEWBn/U3GbALL3vVexlCHH+WimhccdIfd
 0gAzFamC8FBXUpcAU5a4miyqDLKa+YrUGo4IxU13vJA3OrddiHHHHAF1906S3QR4vj
 +26Uk7UvGyIOubYhuONMPQXikPKtUBVfI89YKpDo6IqpAScyFSvNqj67quMhUsCKz4
 UtwJzBWa5L6AJ6E7xmWnx6bZA8rRZGS1sldsAcw1yEjEOpHeEmJkoyNAiok/jp9lYF
 e7pCyKe+rqojQ==
Date: Thu, 1 Jul 2021 10:32:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/amdgpu: Fix resource leak on probe error path
In-Reply-To: <nycvar.YFH.7.76.2106241319430.18969@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2107011030030.18969@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2106241319430.18969@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
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
Cc: Vojtech Pavlik <vojtech@ucw.cz>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 24 Jun 2021, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> This reverts commit 4192f7b5768912ceda82be2f83c87ea7181f9980.
> 
> It is not true (as stated in the reverted commit changelog) that we never 
> unmap the BAR on failure; it actually does happen properly on 
> amdgpu_driver_load_kms() -> amdgpu_driver_unload_kms() -> 
> amdgpu_device_fini() error path.
> 
> What's worse, this commit actually completely breaks resource freeing on 
> probe failure (like e.g. failure to load microcode), as 
> amdgpu_driver_unload_kms() notices adev->rmmio being NULL and bails too 
> early, leaving all the resources that'd normally be freed in 
> amdgpu_acpi_fini() and amdgpu_device_fini() still hanging around, leading 
> to all sorts of oopses when someone tries to, for example, access the 
> sysfs and procfs resources which are still around while the driver is 
> gone.
> 
> Fixes: 4192f7b57689 ("drm/amdgpu: unmap register bar on device init failure")
> Reported-by: Vojtech Pavlik <vojtech@ucw.cz>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Friendly ping on this one (as it's easily triggerable in the wild by just 
missing proper firwmare).

Thanks.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57ec108b5972..0f1c0e17a587 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3414,13 +3414,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	r = amdgpu_device_get_job_timeout_settings(adev);
>  	if (r) {
>  		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
> -		goto failed_unmap;
> +		return r;
>  	}
>  
>  	/* early init functions */
>  	r = amdgpu_device_ip_early_init(adev);
>  	if (r)
> -		goto failed_unmap;
> +		return r;
>  
>  	/* doorbell bar mapping and doorbell index init*/
>  	amdgpu_device_doorbell_init(adev);
> @@ -3646,10 +3646,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  failed:
>  	amdgpu_vf_error_trans_all(adev);
>  
> -failed_unmap:
> -	iounmap(adev->rmmio);
> -	adev->rmmio = NULL;
> -
>  	return r;
>  }
>  
> -- 
> 2.12.3
> 
> 

-- 
Jiri Kosina
SUSE Labs

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
