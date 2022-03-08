Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A140BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 07:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2FA10EB37;
	Tue,  8 Mar 2022 07:06:30 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B3F10EB37
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 07:06:28 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so36981016ejc.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Mar 2022 23:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zfIzXHB8eQPVxYcrKW3GvEaJTrTBz4Am7TA3vHEq3Kk=;
 b=keU2BlP1ekvh15Bas7BsG8DkbFlhkcVoxlGorQWDiaeSaJ73PkKUyVDO9Y6gdS1A28
 MPIm6IAV+ggxTM81WFaNSFwwoNNmUauB6rvb9tBv9fwcfwSEaGHTU9aLMiRTivjNcoqN
 muLxH4UCBiqqfRdrWOpnUwQiTieSuLaZnRYl+czfyEK5e4oU3Fb/+9nmOVnIR7K1dFYo
 +OQyhFvK4BGIQX9dMLQXqEMks7/hkka6OzSbFkGD76jeAvLZR/IYOBVDOvAWOMo+Kb20
 /MoJIakok3pnpadj5JQ2e0VgNg75Ma4ikx7O7+xPP8T0IvIO1GRdY8b/tOp3njwabCiz
 eQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zfIzXHB8eQPVxYcrKW3GvEaJTrTBz4Am7TA3vHEq3Kk=;
 b=23Pwx9aQ6Z6mV3rcIH8U+bt8qLQQXB7LM8xUCKY2pFA1NaZ9TfSqHQRRLcvTBJ5xxV
 g6UbjUMT/LTtCbaTjMK2nYrY+y80IgozCqzf1miKWEmEF4cRWOwJ59UWYI2UKDxfPuOx
 xhdVES8WxW8SPIOjx+8vq8njmzzCculYuX1s/fl7nsshT3tgHh9VatpcJ2hY9nmKrtVH
 900/v3VxFpOYFG6Sd/ht3D8w7/APtult1Zy+ydG05qICD5/jEeUX0IM70kPdigTit3fs
 HGps7uFdBW+LZP+DFMCKeO6F+bv31uG1UyHxd4NOX961yo5HaFY3bRDNb4nuLEw7HVpA
 8qnA==
X-Gm-Message-State: AOAM533Nl/sjD3IXKiI/p1IJT9ra3y7PbJHw/QpErA5R3aDHWHQrn3me
 TisG8Z1LeGut7eSIQ1ACtqg=
X-Google-Smtp-Source: ABdhPJwHh/oni5cps45smiSkvyGdEHSXy2JHE922u0yBYOedmnhUAv0yMsdghyqaIN46bFMsvZT8fg==
X-Received: by 2002:a17:906:974d:b0:6db:5745:e170 with SMTP id
 o13-20020a170906974d00b006db5745e170mr262426ejy.276.1646723186415; 
 Mon, 07 Mar 2022 23:06:26 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 sa13-20020a1709076d0d00b006ce3ef8e1d4sm5404702ejc.31.2022.03.07.23.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 23:06:26 -0800 (PST)
Message-ID: <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
Date: Tue, 8 Mar 2022 08:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
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
Cc: Alexandar Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.03.22 um 17:26 schrieb Shashank Sharma:
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> This patch adds a new sysfs event, which will indicate
> the userland about a GPU reset, and can also provide
> some information like:
> - which PID was involved in the GPU reset
> - what was the GPU status (using flags)
>
> This patch also introduces the first flag of the flags
> bitmap, which can be appended as and when required.

Make sure to CC the dri-devel mailing list when reviewing this.

>
> Cc: Alexandar Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>   include/drm/drm_sysfs.h     |  3 +++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..52a015161431 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>   
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
> + * @dev: DRM device
> + * @pid: The process ID involve with the reset
> + * @flags: Any other information about the GPU status
> + *
> + * Send a uevent for the DRM device specified by @dev. This indicates
> + * user that a GPU reset has occurred, so that the interested client
> + * can take any recovery or profiling measure, when required.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t flags)

The PID is usually only 32bit, but even better would be to use pid_t.

> +{
> +	unsigned char pid_str[21], flags_str[15];
> +	unsigned char reset_str[] = "RESET=1";
> +	char *envp[] = { reset_str, pid_str, flags_str, NULL };
> +
> +	DRM_DEBUG("generating reset event\n");
> +
> +	snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
> +	snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +EXPORT_SYMBOL(drm_sysfs_reset_event);
> +
>   /**
>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any connector
>    * change
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 6273cac44e47..63f00fe8054c 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -2,6 +2,8 @@
>   #ifndef _DRM_SYSFS_H_
>   #define _DRM_SYSFS_H_
>   
> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)

Probably better to define that the other way around, e.g. 
DRM_GPU_RESET_FLAG_VRAM_LOST.

Apart from that looks good to me.

Christian.

> +
>   struct drm_device;
>   struct device;
>   struct drm_connector;
> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>   void drm_class_device_unregister(struct device *dev);
>   
>   void drm_sysfs_hotplug_event(struct drm_device *dev);
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t reset_flags);
>   void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>   void drm_sysfs_connector_status_event(struct drm_connector *connector,
>   				      struct drm_property *property);

