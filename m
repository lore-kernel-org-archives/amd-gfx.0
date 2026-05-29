Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF7CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58D610FC66;
	Fri, 29 May 2026 10:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="bbaGVLap";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC4A10FC66
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:07:28 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so6226320f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1780049247; x=1780654047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sojqlcrukPTx/QnDRTHLvnzErc4nZk0D+ubvvE1DRoY=;
 b=bbaGVLap6E4mbyeeGJEOfM2VccMlDe+L4E5b0vUXFjOQ3sLoSstSPf9q52vwcI+szA
 9dJhw7ZRuWf2/mP6qIo4YQonPI13AQiKGb7fR5NFyIKFSdZxKFAs+p9FaZXbyw7pwU5S
 wVdGZEfNM49TGj8HXonQuNJ5oiVzNl5gsRjG5XSBn4TelnptoZrwgVRjEXI5KQXvbSso
 ACP41M27QJ6lsoX8HoH7dWhzm5bFTtDKEGFdcmNjuq4lZmy7mkyXsk3vryz0AFEQzhSn
 ccoTdgL1HTwEIsqftHiW2cpvJwy7WaJPDvm0LrzYzs48jdGeuvYDampI2W8jxirc1WmZ
 qo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049247; x=1780654047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sojqlcrukPTx/QnDRTHLvnzErc4nZk0D+ubvvE1DRoY=;
 b=d7ImBRvsK2wmWD1XppNtn+VgJPIVJbvgtjsG9u+dqasNJe+8QFEk351X3Vw1ULFPQv
 A+xAtzQ3oKZcZ7Ybo/o+fAVeDCdsAvij7dXleTiwCGiNXPXzFQEvo6xBjjujPjrB7L4l
 2BMEEt2iLLGTmco6gcvO06BvWVN144HDA3PKtuEf+e9eT12UOdL2rtkR7h7ikj6eTjYb
 I9Zwe0QDcia1as3zFyyOR+tAPtOupPCfF5ml0DSu/EmWxTGtRcrGhsfPw5RsIrhsW33O
 f53erxm1U007g9kz4AnY2P1FaUQQx6A6RL0NJ1dzrWGMBQMb3I4l8jDSCFPqNN396HeG
 I2BA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9x4JuuD6QX9SQr5rkqOSuCjnbN+KtI5galscQ+1RvaZOYj3DrPFkRyG/46n1TnaiZgcgbDWeFI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycHJ1RoAWsL2DZt0XjArLANVc0DZaC5LCagNn2ulAgjV1Booh/
 gHrwnekbTCg8Aa/Dp/dC+T0p8b0Fd2tU7g8lmJlxPhALNUDOz4qocLw20sAmo8O4bpE=
X-Gm-Gg: Acq92OFf3M0MIJPOwQvA3i2AMLirph7DpGauuOdY/LGV6QtjskGEskROklZ2fMYtGOt
 xu4ut3dInNb0+6wSvDY0eeOJAEDVCTk4/64qOIs56/Fie9m6nmRhOXNVwH8XRYp+q4dUXgbIF4n
 kBGugqk0De489u3go1J9HeAQsAi0Z0A1wvF9KZWDKViYg8/W/wyyAC0Wc6zvlFV7k0zzcp3iaYj
 u5soTZRuWYAUFZcgphx3cjjSXcSayttPpKF87Y82D79UJxVOGrrLkQNJBItxS9M4t0fiqkuNjd7
 JF4grf27XC+/Gj7GZeUyRVP5GZkFg2t2PHnkG5zZFU4whyJd7tx3hiOufHTDEBtVfapUtsPyGGW
 TjOZzE+uIqjnM5AQnDpzyZckiKzNYCuSdbwdNDKhnTkOiFHcF73A19PxfQiDoUbwQpV/HOIZ0zy
 ZXS+WflSl1cJlU857sY4txK1KCFkL9ekmftzCNQmjxza0UjGa4/OrH1n8=
X-Received: by 2002:a05:6000:29d7:b0:45e:9ea3:ce9a with SMTP id
 ffacd0b85a97d-45ef1419850mr2692391f8f.8.1780049246831; 
 Fri, 29 May 2026 03:07:26 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm2662160f8f.9.2026.05.29.03.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 03:07:26 -0700 (PDT)
Message-ID: <f8eac02e-8578-4ea3-a7da-7b8b44f59ce6@ursulin.net>
Date: Fri, 29 May 2026 11:07:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: Add helper for parameter parsing
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 kevinyang.wang@amd.com
References: <20260529093820.1134317-1-lijo.lazar@amd.com>
 <20260529093820.1134317-2-lijo.lazar@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260529093820.1134317-2-lijo.lazar@amd.com>
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


On 29/05/2026 10:38, Lijo Lazar wrote:
> Add a helper function to extract long values passed in a string. The
> string may have values of multiple parameters separated by space char.

Hah! :) Long time ago, in a galaxy not so far away:

https://patchwork.freedesktop.org/series/154657/

Regards,

Tvrtko

> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 116 ++++++++++++-----------------
>   1 file changed, 48 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index ebe0b320ca4f..040839dc6368 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -98,6 +98,37 @@ const char * const amdgpu_pp_profile_name[] = {
>   	"UNCAPPED",
>   };
>   
> +static int amdgpu_pm_parse_long_params(char *str, long *params,
> +				       uint32_t max_params,
> +				       uint32_t *num_params)
> +{
> +	const char delimiter[] = { ' ', '\n', '\0' };
> +	uint32_t count = 0;
> +	char *sub_str;
> +	int ret;
> +
> +	if (!params || !num_params)
> +		return -EINVAL;
> +
> +	while ((sub_str = strsep(&str, delimiter)) != NULL) {
> +		if (strlen(sub_str) == 0)
> +			continue;
> +		if (count >= max_params)
> +			return -EINVAL;
> +		ret = kstrtol(sub_str, 0, &params[count]);
> +		if (ret)
> +			return -EINVAL;
> +		count++;
> +		if (!str)
> +			break;
> +		while (isspace(*str))
> +			str++;
> +	}
> +	*num_params = count;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_pm_dev_state_check - Check if device can be accessed.
>    * @adev: Target device.
> @@ -759,8 +790,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   	long parameter[64];
>   	char buf_cpy[128];
>   	char *tmp_str;
> -	char *sub_str;
> -	const char delimiter[3] = {' ', '\n', '\0'};
>   	uint32_t type;
>   
>   	if (count > 127 || count == 0)
> @@ -795,22 +824,10 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   		tmp_str++;
>   	while (isspace(*++tmp_str));
>   
> -	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
> -		if (strlen(sub_str) == 0)
> -			continue;
> -		if (parameter_size >= ARRAY_SIZE(parameter))
> -			return -EINVAL;
> -		ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
> -		if (ret)
> -			return -EINVAL;
> -		parameter_size++;
> -
> -		if (!tmp_str)
> -			break;
> -
> -		while (isspace(*tmp_str))
> -			tmp_str++;
> -	}
> +	ret = amdgpu_pm_parse_long_params(
> +		tmp_str, parameter, ARRAY_SIZE(parameter), &parameter_size);
> +	if (ret)
> +		return ret;
>   
>   	ret = amdgpu_pm_get_access(adev);
>   	if (ret < 0)
> @@ -1373,11 +1390,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	uint32_t parameter_size = 0;
>   	long parameter[64];
> -	char *sub_str, buf_cpy[128];
> -	char *tmp_str;
> +	char buf_cpy[128];
>   	char tmp[2];
>   	long int profile_mode = 0;
> -	const char delimiter[3] = {' ', '\n', '\0'};
>   
>   	tmp[0] = *(buf++);
>   	tmp[1] = '\0';
> @@ -1391,19 +1406,11 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   		while (isspace(*buf))
>   			buf++;
>   		strscpy(buf_cpy, buf, sizeof(buf_cpy));
> -		tmp_str = buf_cpy;
> -		while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
> -			if (strlen(sub_str) == 0)
> -				continue;
> -			ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
> -			if (ret)
> -				return -EINVAL;
> -			parameter_size++;
> -			if (!tmp_str)
> -				break;
> -			while (isspace(*tmp_str))
> -				tmp_str++;
> -		}
> +		ret = amdgpu_pm_parse_long_params(buf_cpy, parameter,
> +						  ARRAY_SIZE(parameter) - 1,
> +						  &parameter_size);
> +		if (ret)
> +			return ret;
>   	}
>   	parameter[parameter_size] = profile_mode;
>   
> @@ -3928,18 +3935,14 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>   	return size;
>   }
>   
> -static int parse_input_od_command_lines(const char *buf,
> -					size_t count,
> -					u32 *type,
> -					long *params,
> -					size_t params_max,
> +static int parse_input_od_command_lines(const char *buf, size_t count,
> +					u32 *type, long *params,
> +					uint32_t max_params,
>   					uint32_t *num_of_params)
>   {
> -	const char delimiter[3] = {' ', '\n', '\0'};
>   	uint32_t parameter_size = 0;
>   	char buf_cpy[128] = {0};
> -	char *tmp_str, *sub_str;
> -	int ret;
> +	char *tmp_str;
>   
>   	if (count > sizeof(buf_cpy) - 1)
>   		return -EINVAL;
> @@ -3964,28 +3967,8 @@ static int parse_input_od_command_lines(const char *buf,
>   		break;
>   	}
>   
> -	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
> -		if (strlen(sub_str) == 0)
> -			continue;
> -
> -		if (parameter_size >= params_max)
> -			return -EINVAL;
> -
> -		ret = kstrtol(sub_str, 0, &params[parameter_size]);
> -		if (ret)
> -			return -EINVAL;
> -		parameter_size++;
> -
> -		if (!tmp_str)
> -			break;
> -
> -		while (isspace(*tmp_str))
> -			tmp_str++;
> -	}
> -
> -	*num_of_params = parameter_size;
> -
> -	return 0;
> +	return amdgpu_pm_parse_long_params(tmp_str, params, max_params,
> +					   num_of_params);
>   }
>   
>   static int
> @@ -3998,10 +3981,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>   	long parameter[64];
>   	int ret;
>   
> -	ret = parse_input_od_command_lines(in_buf,
> -					   count,
> -					   &cmd_type,
> -					   parameter,
> +	ret = parse_input_od_command_lines(in_buf, count, &cmd_type, parameter,
>   					   ARRAY_SIZE(parameter),
>   					   &parameter_size);
>   	if (ret)

