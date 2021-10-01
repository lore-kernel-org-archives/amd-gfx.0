Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C64C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 20:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCFF619EC
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BCFF619EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B200B6F3C0;
	Fri,  1 Oct 2021 20:20:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2BB6F3C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
 Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=n2kNhiEukmvyDLYw7N+7YvlO4e+TV5txKFOXEIdgosM=; b=dE3ccQ0PkojqGouXrWB8uo1zcw
 4vLT/eQG1V8IpOa4eDAvgCbexApuW8qySZuYZFaZyl0tQzhYYt56O8YBkhaLINcSymThBVNxTFRJP
 bnch+e2ZeoS10nTK4v3EyRqV1JizfKOFF9oHBtnsK/TAV+XmU+NkZLDF+oYM7hc8F9jT3gkyyejjp
 0cYgzAvnbNyTOaDUBrJAfoQSdh3g5PvZTZ3K6R6mfPy1S7SOr5faWx86zsDPXSFJ0uj3Zpg6mMGWv
 DmcmTHcoJfsnuSgliNjSKxpO9xvx+I610aYmr6TTOHHq1bWqefgDqWmuY6KuPbzthRmn6BE2vd8GH
 1dQynqZw==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWOyx-001G9O-LM; Fri, 01 Oct 2021 20:18:11 +0000
Subject: Re: [PATCH] drm/amdgpu/nv: add missing CONFIG_DRM_AMD_DC check
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211001194822.1818798-1-alexander.deucher@amd.com>
 <20211001194822.1818798-2-alexander.deucher@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0eb9a32e-b50b-7ff9-915e-1d69473a32fe@infradead.org>
Date: Fri, 1 Oct 2021 13:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001194822.1818798-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 01 Oct 2021 20:20:11 +0000
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

On 10/1/21 12:48 PM, Alex Deucher wrote:
> Check was missing for cyan skillfish.
> 
> Fixes: 82d96c34b0d49b ("drm/amd/display: add cyan_skillfish display support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 96975c8cc026..898e688be63c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -891,8 +891,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>   		}
>   		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
>   			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
> +#if defined(CONFIG_DRM_AMD_DC)
>   		else if (amdgpu_device_has_dc_support(adev))
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
> +#endif
>   		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>   		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
>   		break;
> 


-- 
~Randy
