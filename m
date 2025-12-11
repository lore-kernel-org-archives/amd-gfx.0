Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CF3D43346
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 20:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F02310E820;
	Thu, 11 Dec 2025 20:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MpJRiFf6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A1810E2F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 20:26:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CAF641B43;
 Thu, 11 Dec 2025 20:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C10C4CEF7;
 Thu, 11 Dec 2025 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765484792;
 bh=s9AivZNlbhTTOTScLRLe+VKFq9pyJ0d3s/YRhY/vDxg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MpJRiFf6PW9YOaYD1dXAcvbHKpbxH+d6GdMQiusj15anCHZMV7qEdUVK8Rq1i7hJq
 X5l0m0R2llDj7YG84Ku1eUNsQZJSd2KmrTeLqrWMh3iQ7QTQi+NTyyX36K/NJrWd1b
 wAp+yWyfJ5wjgtpQEwp2YIBpb32jHahNPrEYnq+ZhG4UhCoUlSkYjqeZXBq4vBfttY
 IL5YdoddrGgu3xTxYOoV/oDR+NXY5Pn6zLarfE0uWCjVleuvYqUnYqJtcglMS02e/s
 r3AW7+P1r9v2W0FtHgUBo/sOBADMKqB+85HN34UE6gVqYm7tUl2Nkjyqh1coA8y7gp
 EbhUZ71Aab/5w==
Message-ID: <78617cac-b2d9-4234-a0ff-f06a31c76e68@kernel.org>
Date: Thu, 11 Dec 2025 14:26:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix SMU warning during isp
 suspend-resume
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251211201631.1360423-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251211201631.1360423-1-pratap.nirujogi@amd.com>
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

On 12/11/25 2:16 PM, Pratap Nirujogi wrote:
> ISP mfd child devices are using genpd and the system suspend-resume
> operations between genpd and amdgpu parent device which uses only
> runtime suspend-resume are not in sync.
> 
> Linux power manager during suspend-resume resuming the genpd devices
> earlier than the amdgpu parent device. This is resulting in the below
> warning as SMU is in suspended state when genpd attempts to resume ISP.
> 
> WARNING: CPU: 13 PID: 5435 at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398 smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
> 
> To fix this warning isp suspend-resume is handled as part of amdgpu
> parent device suspend-resume instead of genpd sequence. Each ISP MFD
> child device is marked as dev_pm_syscore_device to skip genpd
> suspend-resume and use pm_runtime_force api's to suspend-resume
> the devices when callbacks from amdgpu are received.
> 
> Co-developed-by: Gjorgji Rosikopulos <grosikop@amd.com>
> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
> Signed-off-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 41 +++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 37270c4dab8d..532f83d783d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
>   }
>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>   
> +static int isp_resume(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_isp *isp = &adev->isp;
> +
> +	if (isp->funcs->hw_resume)
> +		return isp->funcs->hw_resume(isp);
> +
> +	return -ENODEV;
> +}
> +
> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_isp *isp = &adev->isp;
> +
> +	if (isp->funcs->hw_suspend)
> +		return isp->funcs->hw_suspend(isp);
> +
> +	return -ENODEV;
> +}
> +
>   static const struct amd_ip_funcs isp_ip_funcs = {
>   	.name = "isp_ip",
>   	.early_init = isp_early_init,
>   	.hw_init = isp_hw_init,
>   	.hw_fini = isp_hw_fini,
>   	.is_idle = isp_is_idle,
> +	.suspend = isp_suspend,
> +	.resume = isp_resume,
>   	.set_clockgating_state = isp_set_clockgating_state,
>   	.set_powergating_state = isp_set_powergating_state,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> index d6f4ffa4c97c..9a5d2b1dff9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>   struct isp_funcs {
>   	int (*hw_init)(struct amdgpu_isp *isp);
>   	int (*hw_fini)(struct amdgpu_isp *isp);
> +	int (*hw_suspend)(struct amdgpu_isp *isp);
> +	int (*hw_resume)(struct amdgpu_isp *isp);
>   };
>   
>   struct amdgpu_isp {
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 4258d3e0b706..0002bcc6c4ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -26,6 +26,7 @@
>    */
>   
>   #include <linux/gpio/machine.h>
> +#include <linux/pm_runtime.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>   		return -ENODEV;
>   	}
>   
> +	/* The devices will be managed by the pm ops from the parent */
> +	dev_pm_syscore_device(dev, true);
> +
>   exit:
>   	/* Continue to add */
>   	return 0;
> @@ -177,12 +181,47 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>   		drm_err(&adev->ddev, "Failed to remove dev from genpd %d\n", ret);
>   		return -ENODEV;
>   	}
> +	dev_pm_syscore_device(dev, false);
>   
>   exit:
>   	/* Continue to remove */
>   	return 0;
>   }
>   
> +static int isp_suspend_device(struct device *dev, void *data)
> +{
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int isp_resume_device(struct device *dev, void *data)
> +{
> +	return pm_runtime_force_resume(dev);
> +}
> +
> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
> +{
> +	int r;
> +
> +	r = device_for_each_child(isp->parent, NULL,
> +				  isp_suspend_device);
> +	if (r)
> +		dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
> +
> +	return r;
> +}
> +
> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
> +{
> +	int r;
> +
> +	r = device_for_each_child(isp->parent, NULL,
> +				  isp_resume_device);
> +	if (r)
> +		dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
> +
> +	return r;
> +}
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	const struct software_node *amd_camera_node, *isp4_node;
> @@ -369,6 +408,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
>   static const struct isp_funcs isp_v4_1_1_funcs = {
>   	.hw_init = isp_v4_1_1_hw_init,
>   	.hw_fini = isp_v4_1_1_hw_fini,
> +	.hw_suspend = isp_v4_1_1_hw_suspend,
> +	.hw_resume = isp_v4_1_1_hw_resume,
>   };
>   
>   void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)

