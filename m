Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C9AC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 12:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9824922CB9
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 12:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9824922CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233A389FA6;
	Wed,  6 Jan 2021 12:54:06 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7459B89FA6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 12:54:04 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aea67.dynamic.kabel-deutschland.de
 [95.90.234.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A15F920646219;
 Wed,  6 Jan 2021 13:54:02 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: For sriov multiple VF, set compute timeout to
 10s
To: Emily Deng <Emily.Deng@amd.com>
References: <20210106114157.566182-1-Emily.Deng@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <1b4eca35-6aa4-f463-ccc5-a4144bd325dc@molgen.mpg.de>
Date: Wed, 6 Jan 2021 13:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106114157.566182-1-Emily.Deng@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Emily,


Am 06.01.21 um 12:41 schrieb Emily.Deng:

Could you please remove the dot your name in your git configuration?

     git config --global user.name "Emily Deng"

For the summary, maybe amend it to:

     Decrease compute timeout to 10 s for sriov multiple VF

> For multiple VF, after engine hang,as host driver will first

Nit: Please add a space after the comma.

> encounter FLR, so has no meanning to set compute to 60s.

meaning

How can this be tested?

> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b69c34074d8d..ed36bf97df29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3117,8 +3117,10 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>   	 */
>   	adev->gfx_timeout = msecs_to_jiffies(10000);
>   	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
> -	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
> +	if ((amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) || amdgpu_passthrough(adev))
>   		adev->compute_timeout =  msecs_to_jiffies(60000);
> +	else if (amdgpu_sriov_vf(adev))
> +		adev->compute_timeout =  msecs_to_jiffies(10000);

Maybe split up the first if condition to group the condition and not he 
timeout values. At least for me that would be less confusing:

     if (amdgpu_sriov_vf(adev))
     	adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ? 
msecs_to_jiffies(60000) : msecs_to_jiffies(10000)
     else if (amdgpu_passthrough(adev))
     	adev->compute_timeout =  msecs_to_jiffies(60000);

>   	else
>   		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;


Kind regards,

Paul
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
