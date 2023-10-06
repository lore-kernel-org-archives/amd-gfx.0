Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AE5E92FF9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 08:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37DB10E4C6;
	Fri,  6 Oct 2023 08:14:28 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8C510E4C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 08:14:27 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5068692b0d9so386958e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696580065; x=1697184865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZsBFdULJ4WAjMzNi1stpCQzDOCHEAZXHUVwky+B9QY=;
 b=b6Eoj7kBS/iKV03PzptTMG7nW9ex2bovX1kCKEEphCiF45hbq/2EMwxAxzEzNZz1WB
 sqD9sBKIHs6n5XlrlVz3jXP7HPu3zqnOCfpD9HXgjffz+D+8A9jFrTF5leXmwNkwyT6U
 k48COQADi4Wc5v6iRR6wZsfTHSmrkELrhVvt7Py+Zs6TBPTsscw73EbpH0iGhWgvjd1w
 DQfALEYG94YdotylnOfkto/9ROEOCqhSz1bkbXS2YqGCyJFkPEgTZHTbIESdmWPv6BWf
 S4o3cr+aYZa8PXf4TT9Gsqm0AyuGKVWuyY2wxW+SxGLg+VCNT8+6o5Ifkkx5JsHvlEyD
 Z/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696580065; x=1697184865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZsBFdULJ4WAjMzNi1stpCQzDOCHEAZXHUVwky+B9QY=;
 b=B9dcUln4lQIA/GIYavemph2aQdMpNgCqv7FzMYY7FSOAm8aH0IL59cTY5WPtba46U+
 /u+YPuAn7bOOCE9hv29Ctc4bvmo56XKja8dHFozQs5YJ8kQUfMWdnBQPaAbuWkn3h3//
 OCXmdG//Ocoo+iuNzZlif7ziNpT6duAUCny1p330oCYpboM+yM8njWDu8eUKF9aqmG4f
 M1jpoWXQGb4pB60wLrhBkGfL0xH/YSvH0OpVdLDUIU1IiX/O0fy/Id1NlPO++BRaTqqJ
 JC1BkaEU+CTOp7VbiQbKeT2NUZuYQVIKIfalwL7gvBOcshu9WZbR6UO5GERH4R7rZidJ
 ygRw==
X-Gm-Message-State: AOJu0Yx/AVI/UZH+jPaa9v17wDnk3bsw2NYNgMSbk2J4tTB5LCk46+gp
 oIw096/oh11S34ZjVC4kWRtMv0YQdt8=
X-Google-Smtp-Source: AGHT+IFXh60wghTzYbiPBSKp7yetSxW1Kre6gX8sr4sDtE/nm6R2LZNWC/SaaiP5+pV5TGereo2BDw==
X-Received: by 2002:a05:6512:745:b0:505:7896:18de with SMTP id
 c5-20020a056512074500b00505789618demr5584958lfs.45.1696580065357; 
 Fri, 06 Oct 2023 01:14:25 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a05600c320200b0040641ce36a8sm3239037wmp.1.2023.10.06.01.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:14:24 -0700 (PDT)
Message-ID: <007b0fed-4982-4978-95e3-6763d114a97e@gmail.com>
Date: Fri, 6 Oct 2023 10:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd/pm: Add sysfs attribute to get pm log
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <20231006052149.1566154-4-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231006052149.1566154-4-lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 07:21 schrieb Lijo Lazar:
> Add sysfs attribute to read power management log. A snapshot is
> captured to the buffer when the attribute is read.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>
> v2: Pass PAGE_SIZE as the max size of input buffer
>
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 40 ++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 4c65a2fac028..5a1d21c52672 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1794,6 +1794,44 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
>   	return count;
>   }
>   
> +static int amdgpu_pmlog_attr_update(struct amdgpu_device *adev,
> +				    struct amdgpu_device_attr *attr,
> +				    uint32_t mask,
> +				    enum amdgpu_device_attr_states *states)
> +{
> +	if (amdgpu_dpm_get_pm_log(adev, NULL, 0) == -EOPNOTSUPP)
> +		*states = ATTR_STATE_UNSUPPORTED;
> +
> +	return 0;
> +}
> +
> +static ssize_t amdgpu_get_pmlog(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	int ret;
> +
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;

Please stop using amdgpu_in_reset() for stuff like that altogether.

When this is reset critical it should grab the reset rw semaphore. If it 
isn't than that check isn't necessary.

Regards,
Christian.

> +	if (adev->in_suspend && !adev->in_runpm)
> +		return -EPERM;
> +
> +	ret = pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	size = amdgpu_dpm_get_pm_log(adev, buf, PAGE_SIZE);
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	return size;
> +}
> +
>   /**
>    * DOC: gpu_metrics
>    *
> @@ -2091,6 +2129,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>   	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
>   			      .attr_update = ss_bias_attr_update),
>   	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
> +	AMDGPU_DEVICE_ATTR_RO(pmlog,					ATTR_FLAG_BASIC,
> +			      .attr_update = amdgpu_pmlog_attr_update),
>   };
>   
>   static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,

