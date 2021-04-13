Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C30CC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBE061369
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBE061369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFCC89E47;
	Tue, 13 Apr 2021 13:20:30 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5D689E47
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 13:20:28 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id w3so25916351ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=a4KHmV2EGiQwKgxR4omqFvMl4vM/gaGFJjJY9uTn0A8=;
 b=qxsn0tS2+tkyl9XZqO46tZMLAEf3odr3WMvKqbgyfIs6oC36MBb8io7WmsErFy0d13
 aqmsQNMQ3mIuTI3w7akm5HVfg7lcq1wDgMSONkM0XV2rueEzyyZTdrnk+CPSUH7KmPeH
 xeVxOSFenFlWMiQPUT+jqGbwnxKzii2V4xLYu/TAq0hYcvNdRaWgK4IS0/D+X5fF7r6N
 Bp7c0R4AFO2NjEvNySmC2iY4GfRQgwyJypkcRvWgCNkKISHJM55euZ0Z+xbFhocoalKj
 kl8C7LyCHniCWdEnUaMzesfIrhKO62V9D24bzuGZDt5infco7cnmf5sQBJGJMKZ+7t1r
 vJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=a4KHmV2EGiQwKgxR4omqFvMl4vM/gaGFJjJY9uTn0A8=;
 b=murJhMO32g3d2/HVNQzB7bZxIaSlDQh+r3ZaOMaXFWBLGsykZdwbw3LNDDyG5e2N5W
 F/myY5VaYQs1tKZL4Kaxr1qvzavmmIxilR6ZhTO5V21rCHwlGsc4pBr7B8ys8HTIoUVP
 q8zAPrqgbrEEGwnw2POU4uuAPAJno79czjw31/i01G9bRzGJHUknQhVdnGFzUsXSUJIp
 17fDpOJ/I13Tz8hGq1ev8/lqGLtc/tLGHZUTn/YIoHjTphL2w4d1uwVmo/F6adhUFu34
 mn1nghToFMN14RVSCDf+lcKUJaMI6VmArIiUxsleYQeP7r9nGswSjADd77xkzDUd6PlN
 lGCA==
X-Gm-Message-State: AOAM531Km5sn6oaVf8zQ9ouqLv+ErixhhlLsDuVSUOjG7aa9xAkEt9YQ
 vl2WMD3qLJBvYJWQvdnsmruWCr4yp9o=
X-Google-Smtp-Source: ABdhPJypjrFnJoE05Tqast1dzzploPeMev9VWpDNPc1N7FobBOILLpUocbXjDkCgwFcw+CCmk8Hz/g==
X-Received: by 2002:a17:906:af84:: with SMTP id
 mj4mr13035420ejb.195.1618320027257; 
 Tue, 13 Apr 2021 06:20:27 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587?
 ([2a02:908:1252:fb60:acbc:5f44:93b6:4587])
 by smtp.gmail.com with ESMTPSA id q2sm7941146eje.24.2021.04.13.06.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 06:20:26 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: Expose some power info through AMDGPU_INFO
To: "Sun, Roy" <Roy.Sun@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210412121505.23787-1-Roy.Sun@amd.com>
 <CY4PR12MB16062ED181829A47D1B4EC1DFF4F9@CY4PR12MB1606.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a27997fc-e635-299a-417b-eb70c2bde408@gmail.com>
Date: Tue, 13 Apr 2021 15:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CY4PR12MB16062ED181829A47D1B4EC1DFF4F9@CY4PR12MB1606.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 13.04.21 um 15:09 schrieb Sun, Roy:
> [AMD Official Use Only - Internal Distribution Only]
>
> ping
>
> -----Original Message-----
> From: Roy Sun <Roy.Sun@amd.com>
> Sent: Monday, April 12, 2021 8:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sun, Roy <Roy.Sun@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: Expose some power info through AMDGPU_INFO
>
> Add interface to get the mm clock, temperature and memory load
>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 50 +++++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h           | 12 ++++++
>   2 files changed, 62 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b2e774aeab45..e5b16e0819ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -971,6 +971,56 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			}
>   			ui32 /= 100;
>   			break;
> +		case AMDGPU_INFO_SENSOR_UVD_VCLK:
> +			/* get mm vclk in Mhz */

Maybe drop the comment, it looks redundant.

> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_UVD_VCLK,

In general I would not repeat that code over and over again, but rather 
translate the parameter and then call amdgpu_dpm_read_sensor() once.

But this is just my top level view on code I don't know well.

Regards,
Christian.

> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			ui32 /= 100;
> +			break;
> +		case AMDGPU_INFO_SENSOR_UVD_DCLK:
> +			/* get mm dclk in Mhz */
> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_UVD_DCLK,
> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			ui32 /= 100;
> +			break;
> +		case AMDGPU_INFO_SENSOR_HOTSPOT_TEMP:
> +			/* get junction temperature */
> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			break;
> +		case AMDGPU_INFO_SENSOR_EDGE_TEMP:
> +			/* get current edge temperature */
> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_EDGE_TEMP,
> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			break;
> +		case AMDGPU_INFO_SENSOR_MEM_TEMP:
> +			/* get current memory temperature */
> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_MEM_TEMP,
> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			break;
> +		case AMDGPU_INFO_SENSOR_MEM_LOAD:
> +			/* get memory load */
> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_MEM_LOAD,
> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			break;
>   		default:
>   			DRM_DEBUG_KMS("Invalid request %d\n",
>   				      info->sensor_info.type);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 8b832f7458f2..484c72e17c72 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -780,6 +780,18 @@ struct drm_amdgpu_cs_chunk_data {
>   	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_SCLK		0x8
>   	/* Subquery id: Query GPU stable pstate memory clock */
>   	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_MCLK		0x9
> +	/* Subquery id: Query GPU mm vclk */
> +	#define AMDGPU_INFO_SENSOR_UVD_VCLK		0xa
> +	/* Subquery id: Query GPU mm dclk */
> +	#define AMDGPU_INFO_SENSOR_UVD_DCLK		0xb
> +	/* Subquery id: Query junction temperature */
> +	#define AMDGPU_INFO_SENSOR_HOTSPOT_TEMP		0xc
> +	/* Subquery id: Query edge temperature */
> +	#define AMDGPU_INFO_SENSOR_EDGE_TEMP		0xd
> +	/* Subquery id: Query memory temperature */
> +	#define AMDGPU_INFO_SENSOR_MEM_TEMP		0xe
> +	/* Subquery id: Query Memory load */
> +	#define AMDGPU_INFO_SENSOR_MEM_LOAD		0xf
>   /* Number of VRAM page faults on CPU access. */
>   #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
>   #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
> --
> 2.31.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
