Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C26C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 14:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD3010E8CD;
	Thu, 24 Mar 2022 14:52:44 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799B310E8D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 14:52:43 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5ae8e8.dynamic.kabel-deutschland.de
 [95.90.232.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2FF3461EA1923;
 Thu, 24 Mar 2022 15:52:41 +0100 (CET)
Message-ID: <07fdc495-53a3-c723-a1b7-0e0c9e1ebc6d@molgen.mpg.de>
Date: Thu, 24 Mar 2022 15:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdkfd: Check use_xgmi_p2p before reporting hive_id
Content-Language: en-US
To: Divya Shikre <DivyaUday.Shikre@amd.com>
References: <20220323142016.1810918-1-DivyaUday.Shikre@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220323142016.1810918-1-DivyaUday.Shikre@amd.com>
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
Cc: Alex.Sierra@amd.com, Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Divya,


Am 23.03.22 um 15:20 schrieb Divya Shikre:
> Recently introduced commit "845ebd6b7c32 drm/amdgpu: Add
> use_xgmi_p2p module parameter" did not update XGMI iolinks
> when use_xgmi_p2p is disabled. Add fix to not create XGMI
> iolinks in KFD topology when this parameter is disabled.

Thank you for rerolling the patch. Please also add:

Fixes: 845ebd6b7c32 ("drm/amdgpu: Add use_xgmi_p2p module parameter")

> Signed-off-by: Divya Shikre <DivyaUday.Shikre@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 339e12c94cff..d5536e33b3d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -536,7 +536,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   		goto kfd_doorbell_error;
>   	}
>   
> -	kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
> +	if (amdgpu_use_xgmi_p2p)
> +		kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
>   
>   	kfd->noretry = kfd->adev->gmc.noretry;
>   

The rest looks good.


Kind regards,

Paul
