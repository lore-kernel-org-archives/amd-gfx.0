Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4BCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 06:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C8510E5DD;
	Wed, 23 Mar 2022 06:31:46 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2E410E5DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 06:31:44 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae903.dynamic.kabel-deutschland.de
 [95.90.233.3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1268E61EA1928;
 Wed, 23 Mar 2022 07:31:43 +0100 (CET)
Message-ID: <5ff658f8-35b3-aca6-25d6-0c041065bd0e@molgen.mpg.de>
Date: Wed, 23 Mar 2022 07:31:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd:Check use_xgmi_p2p before reporting hive_id
Content-Language: en-US
To: Divya Shikre <DivyaUday.Shikre@amd.com>
References: <20220322192326.1716698-1-DivyaUday.Shikre@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220322192326.1716698-1-DivyaUday.Shikre@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Divya,


Thank you for your patch.

Am 22.03.22 um 20:23 schrieb Divya Shikre:

Please add a space after the colon in the commit message summary.

> XGMI iolinks will not be created in KFD topology when use_xgmi_p2p module parameter
> is disabled in a dGPU.

1.  Is “will not be” the current problem, or the result of your patch? 
Please start by describing the current problem, how to reproduce it.

2.  Please wrap lines after 75 characters, and add a blank line between 
paragraphs.

The script `scripts/checkpatch.pl`, you should run on all your patches 
before submitting them, also warns about the first issue:

     WARNING: Possible unwrapped commit description (prefer a maximum 75 
chars per line)

> In this case PCIe p2p links will be used instead.

Is this a regression, and fixes another commit? If so, please add a 
Fixes line.

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

Is hive_id now unset?

>   	kfd->noretry = kfd->adev->gmc.noretry;
>   


Kind regards,

Paul
