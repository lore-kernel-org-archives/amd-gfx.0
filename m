Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B859C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 08:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37C610ED2F;
	Fri,  6 May 2022 08:14:43 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A642D10ED4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 08:14:42 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aed56.dynamic.kabel-deutschland.de
 [95.90.237.86])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7DF4A61EA192C;
 Fri,  6 May 2022 10:14:40 +0200 (CEST)
Message-ID: <41c39720-c0a5-1e6b-05b3-dac6b98427fa@molgen.mpg.de>
Date: Fri, 6 May 2022 10:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] amdgpu/pm: Disable managing power profiles on SRIOV for
 Sienna Cichlid
Content-Language: en-US
To: Danijel Slivka <danijel.slivka@amd.com>
References: <20220506075239.3466527-1-danijel.slivka@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220506075239.3466527-1-danijel.slivka@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Danijel,


Am 06.05.22 um 09:52 schrieb Danijel Slivka:

Please add a reasoning/motivation in the commit message body.


Kind regards,

Paul


> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 70a0aad05426..59a662aeaaf3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2025,6 +2025,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>   		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
>   			*states = ATTR_STATE_UNSUPPORTED;
> +		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
> +			*states = ATTR_STATE_UNSUPPORTED;
>   	}
>   
>   	switch (gc_ver) {
> @@ -2038,6 +2040,13 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			dev_attr->store = NULL;
>   		}
>   		break;
> +	case IP_VERSION(10, 3, 0):
> +		if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
> +		    amdgpu_sriov_vf(adev)) {
> +			dev_attr->attr.mode &= ~S_IWUGO;
> +			dev_attr->store = NULL;
> +		}
> +		break;
>   	default:
>   		break;
>   	}
