Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF538CF8562
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 07:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3AA10E7C3;
	Thu,  3 Oct 2024 07:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="ZOyPWkPv";
	dkim-atps=neutral
X-Greylist: delayed 488 seconds by postgrey-1.36 at gabe;
 Wed, 02 Oct 2024 19:28:15 UTC
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
 by gabe.freedesktop.org (Postfix) with ESMTP id C310B10E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 19:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
 t=1727896805; bh=9mOuSM3QA6siPYW6wWOV6L98zTSHnGFLCNk7MAKndlY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZOyPWkPvYxxStXn5wW5HKKyPXO2D076mb6cixtiDvzkBWvvrI3BgPi1F4a4K5rtsQ
 rI4crWKkgROcsGnMBaUY/pWNJf8cgDU01WvbH5vhhExZC6Yiz5h8E91SZYg8jkU5ni
 iDUiakcd97sZTcg8OszAq7WMhIpCDDu4gw1EeOE9Z343w21v7v0Wa5I2xjDm2/cMuH
 NznYQEaoz51olKcRs9WFyt12LrXoprHmrI2A8GxIQuS7yLpVCqOudVle+d3qtJZxzc
 cxMbtPTIjDsw1Lxgy66j8lLPCUByfH6sXQWRJD3YBFDFI56JHzkmqoUpBPgxvkThxd
 8N6LzhXsIPkWCiaADKucdbC9ge7D0L0LtQ1lSRy8/xb/h1pYDnEcPISX5IOoFnE0La
 UNiUMsqUrqrj0PYC0wbD5WLzQNL4UMRHaP4yafMSOU1cEOWAIOV80EwQAPhBDFDB1Z
 A3a+I1OGRkTG8N1VXIZ3lphnoN2PIrwGE9dx3hubVzRvOs+3O5K5uO3FZD7X4cd77Y
 VXH7nhyDB1GUV8QUx1jNrXLW/n3ZxZbztwSIBog6/5L8abhbbw0GdnSFpb4GOMdhOs
 N/q109ICfgc+E0hwcyBYmJDklxy1qFQU501AaYNQMdX3LclYPlBwDc7hCJYICmsVPk
 naZZkamQXSq328U0FizAhbAg=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl
 [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
 by bout3.ijzerbout.nl (Postfix) with ESMTPSA id E9F24167DD8;
 Wed,  2 Oct 2024 21:20:04 +0200 (CEST)
Message-ID: <f42cfa4b-047c-472f-8263-f8fe632d8bd5@ijzerbout.nl>
Date: Wed, 2 Oct 2024 21:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20240910143146.1942083-1-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20240910143146.1942083-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 03 Oct 2024 07:37:22 +0000
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

Op 10-09-2024 om 16:31 schreef Sathishkumar S:
> JPEG_4_0_3 has up to 32 jpeg cores and a single mjpeg video decode
> will use all available cores on the hardware. This debugfs entry
> helps to disable or enable job submission to a cluster of cores or
> one specific core in the ip for debugging. The entry is populated
> only if there is at least two or more cores in the jpeg ip.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    | 71 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h    |  1 +
>   3 files changed, 74 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index cbef720de779..37d8657f0776 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2095,6 +2095,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	if (amdgpu_umsch_mm & amdgpu_umsch_mm_fwlog)
>   		amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
>   
> +	amdgpu_debugfs_jpeg_sched_mask_init(adev);
> +
>   	amdgpu_ras_debugfs_create_all(adev);
>   	amdgpu_rap_debugfs_init(adev);
>   	amdgpu_securedisplay_debugfs_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 6df99cb00d9a..edf0a50dd345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -342,3 +342,74 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>   
>   	return psp_execute_ip_fw_load(&adev->psp, &ucode);
>   }
> +
> +/*
> + * debugfs for to enable/disable jpeg job submission to specific core.
> + */
> +#if defined(CONFIG_DEBUG_FS)
> +static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *) data;
> +	uint32_t i, j;
> +	uint64_t mask = 0;
> +	struct amdgpu_ring *ring;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
This expression "1 << ..." is evaluated as 32 bits because of the plain 
"1". If
the shift is more than 32 then the result of the shift will be 0.

I suggest to change the expression to something like this (assuming ULL 
makes it 64 bits)
mask = (1ULL << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
or
mask = ((u64)1 << (adev->jpeg.num_jpeg_inst * 
adev->jpeg.num_jpeg_rings)) - 1;

> [...]
>
