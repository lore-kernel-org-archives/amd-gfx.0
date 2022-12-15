Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EA5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 21:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A653810E0DF;
	Thu, 15 Dec 2022 21:14:05 +0000 (UTC)
X-Greylist: delayed 450 seconds by postgrey-1.36 at gabe;
 Thu, 15 Dec 2022 19:53:43 UTC
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr
 [80.12.242.22])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8FE1710E563
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 19:53:43 +0000 (UTC)
Received: from [192.168.1.18] ([86.243.100.34]) by smtp.orange.fr with ESMTPA
 id 5uB9pvVWgQkxd5uB9pr0fK; Thu, 15 Dec 2022 20:46:06 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 Dec 2022 20:46:06 +0100
X-ME-IP: 86.243.100.34
Message-ID: <bca79bc1-9e7c-b145-0b0b-0ce725d58821@wanadoo.fr>
Date: Thu, 15 Dec 2022 20:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amd/pm: avoid large variable on kernel stack
Content-Language: fr, en-US
To: arnd@kernel.org
References: <20221215163649.386750-1-arnd@kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221215163649.386750-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Dec 2022 21:14:00 +0000
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
Cc: llvm@lists.linux.dev, Jack.Gui@amd.com, KevinYang.Wang@amd.com,
 kenneth.feng@amd.com, Xinhui.Pan@amd.com, ndesaulniers@google.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, nathan@kernel.org,
 arnd@arndb.de, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 trix@redhat.com, alexander.deucher@amd.com, evan.quan@amd.com,
 airlied@gmail.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Le 15/12/2022 à 17:36, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> 
> The activity_monitor_external[] array is too big to fit on the
> kernel stack, resulting in this warning with clang:
> 
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1438:12: error: stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_power_profile_mode' [-Werror,-Wframe-larger-than]
> 
> Use dynamic allocation instead. It should also be possible to
> have single element here instead of the array, but this seems
> easier.
> 
> Fixes: 334682ae8151 ("drm/amd/pm: enable workload type change on smu_v13_0_7")
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 21 ++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c270f94a1b86..7eba854e09ec 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1439,7 +1439,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>   
>   static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
>   {
> -	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
> +	DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
>   	uint32_t i, j, size = 0;
>   	int16_t workload_type = 0;
>   	int result = 0;
> @@ -1447,6 +1447,12 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>   	if (!buf)
>   		return -EINVAL;
>   
> +	activity_monitor_external = kcalloc(sizeof(activity_monitor_external),

Hi,

Before, 'activity_monitor_external' was not initialized.
Maybe kcalloc() is enough?

sizeof(*activity_monitor_external)?
      ~~~~

> +					    PP_SMC_POWER_PROFILE_COUNT,
> +					    GFP_KERNEL);
> +	if (!activity_monitor_external)
> +		return -ENOMEM;
> +
>   	size += sysfs_emit_at(buf, size, "                              ");
>   	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)

Unrelated, but wouldn't it be more straightforward with "< 
PP_SMC_POWER_PROFILE_COUNT"?

>   		size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
> @@ -1459,15 +1465,17 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>   		workload_type = smu_cmn_to_asic_specific_index(smu,
>   							       CMN2ASIC_MAPPING_WORKLOAD,
>   							       i);
> -		if (workload_type < 0)
> -			return -EINVAL;
> +		if (workload_type < 0) {
> +			result = -EINVAL;
> +			goto out;
> +		}
>   
>   		result = smu_cmn_update_table(smu,
>   					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
>   					  (void *)(&activity_monitor_external[i]), false);
>   		if (result) {
>   			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return result;
> +			goto out;
>   		}
>   	}
>   
> @@ -1495,7 +1503,10 @@ do {													\
>   	PRINT_DPM_MONITOR(Fclk_BoosterFreq);
>   #undef PRINT_DPM_MONITOR
>   
> -	return size;
> +	result = size;
> +out:
> +	kfree(activity_monitor_external);
> +	return result;
>   }
>   
>   static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)

