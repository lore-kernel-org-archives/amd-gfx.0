Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5DCC79FAA
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 03:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288B210E536;
	Tue,  8 Sep 2026 03:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BjorvTFA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C346210E536
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 03:55:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CBA7601DB;
 Tue,  8 Sep 2026 03:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83471F00A3E;
 Tue,  8 Sep 2026 03:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788839757;
 bh=jUeVX2knLP9sFnsr3pT3F8QUkckA7ehgQOz+lrE71Tc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BjorvTFAGvBT/cuTdaysRBKKaFdeh4sGx0Z7xiZTDcte+yThaTIRlevNep+k+hCub
 otNbMR0Mxgk3iqqlv8kS80ME4BmqYt2njESylSGiotvK8xNiHPJSIYV7x5mN576fbJ
 08EQCHTdgJ+WDBscvpwmVmadD39Idvf/fR33VelGSYvGOkQdcLxTvFh6WadWt2AAss
 Ll6HUDaImzu3w0svJgCgEm63mOW7CYDDWLixJTf4fZ+cYlSwKm9VT/xapYhit+1iWB
 8oQDdIZzIbIzPeqoPQw3xv6G78Ha/TBZj9pB7hjG/4l5eIyX5AZd4PDNKYfPLgj1r1
 Mo2kPSLfYEMYw==
Message-ID: <81ace942-3e71-43e3-b898-22d373d38ce9@kernel.org>
Date: Mon, 7 Sep 2026 22:55:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] drm/amdgpu: avoid NULL deref in isp_genpd_remove_device
Content-Language: en-US
To: Bin Du <Bin.Du@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
Cc: Benjamin.Chan@amd.com, King.Li@amd.com, Pratap.Nirujogi@amd.com
References: <20260907061138.59606-1-Bin.Du@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260907061138.59606-1-Bin.Du@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 9/7/26 01:11, Bin Du wrote:
> hw_fini passes NULL as device_for_each_child() data, but the callback
> derived adev from that pointer for logging and oopsed on unbind. Drop
> the unused genpd lookup, log against the child device, keep walking
> on remove failure, and only clear syscore after a successful detach.
> 
> Fixes: fd1478607102 ("drm/amd/amdgpu: Add ISP Generic PM Domain (genpd) support")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5746
> Signed-off-by: Bin Du <Bin.Du@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 28 ++++++-------------------
>   1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 485ecdec9618..26dbfe2d2739 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -156,35 +156,19 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>   
>   static int isp_genpd_remove_device(struct device *dev, void *data)
>   {
> -	struct generic_pm_domain *gpd = data;
> -	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
> -	struct amdgpu_isp *isp = container_of(gpd, struct amdgpu_isp, ispgpd);
> -	struct amdgpu_device *adev = isp->adev;
>   	int ret;
>   
> -	if (!pdev)
> -		return -EINVAL;
> -
> -	if (!dev->type || !dev->type->name) {
> -		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
> -		goto exit;
> -	}
> -
> -	if (strcmp(dev->type->name, "mfd_device")) {
> -		drm_dbg(&adev->ddev, "Invalid isp mfd device %s to remove\n",
> -			pdev->mfd_cell->name);
> -		goto exit;
> -	}
> +	if (!dev->type || !dev->type->name ||
> +	    strcmp(dev->type->name, "mfd_device"))
> +		return 0;
>   
>   	ret = pm_genpd_remove_device(dev);
>   	if (ret) {
> -		drm_err(&adev->ddev, "Failed to remove dev from genpd %d\n", ret);
> -		return -ENODEV;
> +		dev_err(dev, "Failed to remove dev from genpd %d\n", ret);
> +		return 0;
>   	}
> -	dev_pm_syscore_device(dev, false);
>   
> -exit:
> -	/* Continue to remove */
> +	dev_pm_syscore_device(dev, false);
>   	return 0;
>   }
>   

