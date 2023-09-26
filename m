Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B7EE7E631
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 13:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BDE10E3DD;
	Tue, 26 Sep 2023 13:02:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD0C10E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695724543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IN3gjXP/ulM4+M4Osvjbx+CJvR8HzZe/I6zVYXrFanI=;
 b=Rf+Tsyo9nFmDD+rYhjdXFUxYfmZ+t2Wa0PvyowojhCy2F4MhYLpCRaXycLHQB4QEZAtBHZ
 fVfx6e0JccrzYpG7WXXYjH5UUnsPO+pnXmzaAaxOyXx7QVK9yuFsW0lg8hCphDEVBAFddM
 nAC4XBbwjxEBxzNDpAHvUg52eOvC8+o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-abeRZMFjNQSkfQIcTE4mRA-1; Tue, 26 Sep 2023 06:35:41 -0400
X-MC-Unique: abeRZMFjNQSkfQIcTE4mRA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5039413f4f9so13059284e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 03:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695724540; x=1696329340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IN3gjXP/ulM4+M4Osvjbx+CJvR8HzZe/I6zVYXrFanI=;
 b=pv86x5O2jlEhdpkSKgHq2FXSF+6K7tgfGiyI8Ef9SnD5DTGr6HOvqTEymP8YquyKCH
 U41AhbEbgtzTb6dShzd3rUEiblIOJ/2NzmGeT9R6CApJJ1dcaEZzIS8vfN6/CzlErF2f
 AozvEMfAhW/DfKBv/ZFjJpsq9kI7EdHq1nt7Did0aACdoL/9TcjEOp0weizsUJBExnWi
 zAb7ihBJLjum7oDsn9EDfvaUY04Hp1TVFFg9VmH4/tvwCtGpZFIXittyQ0jIlNimLvDO
 eXyna3FCZnZaHBpwgCc9LbF2Yu5PXEJ/h+b9ktzgSLsJRbONzRCj8tbu7L8cs8CFV144
 VgIA==
X-Gm-Message-State: AOJu0YwyAIsV8LwmkzPdQ7JrQnwDI0AavpCvEXKMT8LPbST4lAw9ukw1
 mjFGTFOwtqA7aiwCBYjZTfzOVsfU8FrT2ACGe35xO4fdFZ3MkuE27jS58ohWn8MfBKDfC4bu4tn
 eDyW3ZuAUc5rc770grr8HPM1a4g==
X-Received: by 2002:a05:6512:3d21:b0:503:655:12e7 with SMTP id
 d33-20020a0565123d2100b00503065512e7mr10393181lfv.62.1695724539856; 
 Tue, 26 Sep 2023 03:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn3ozsYpRq6AuJvRaLBGJ3+5/IVA5BsFnkHEF6nwZAP0ixv8ZfQALU7T1Ot7RrjwRGez4gGg==
X-Received: by 2002:a05:6512:3d21:b0:503:655:12e7 with SMTP id
 d33-20020a0565123d2100b00503065512e7mr10393157lfv.62.1695724539418; 
 Tue, 26 Sep 2023 03:35:39 -0700 (PDT)
Received: from [192.168.1.217] ([109.37.154.108])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a056402121300b0052e9b50dafdsm6556318edw.33.2023.09.26.03.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 03:35:38 -0700 (PDT)
Message-ID: <2e201a3b-d75f-916d-5135-b084ad5da23e@redhat.com>
Date: Tue, 26 Sep 2023 12:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/15] platform/x86/amd/pmf: Add PMF-AMDGPU set interface
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, markgross@kernel.org,
 basavaraj.natikar@amd.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
References: <20230922175056.244940-1-Shyam-sundar.S-k@amd.com>
 <20230922175056.244940-14-Shyam-sundar.S-k@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230922175056.244940-14-Shyam-sundar.S-k@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 26 Sep 2023 13:02:52 +0000
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
Cc: amd-gfx@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Patil.Reddy@amd.com,
 linux-input@vger.kernel.org, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 9/22/23 19:50, Shyam Sundar S K wrote:
> For the Smart PC Solution to fully work, it has to enact to the actions
> coming from TA. Add the initial code path for set interface to AMDGPU.
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmf.c | 21 +++++++++++++++++++++
>  drivers/platform/x86/amd/pmf/pmf.h      |  2 ++
>  drivers/platform/x86/amd/pmf/tee-if.c   | 19 +++++++++++++++++--
>  include/linux/amd-pmf-io.h              |  1 +
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmf.c
> index 232d11833ddc..5c567bff0548 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmf.c
> @@ -68,3 +68,24 @@ int amd_pmf_get_gfx_data(struct amd_gpu_pmf_data *pmf)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(amd_pmf_get_gfx_data);
> +
> +int amd_pmf_set_gfx_data(struct amd_gpu_pmf_data *pmf)
> +{
> +	struct drm_device *drm_dev = pci_get_drvdata(pmf->gpu_dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +	struct backlight_device *bd;
> +
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		DRM_ERROR("PMF-AMDGPU interface not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	bd = backlight_device_get_by_type(BACKLIGHT_RAW);
> +	if (!bd)
> +		return -ENODEV;

This assumes that the backlight is always controller by the amdgpu's
native backlight driver, but it might e.g. also be handled by
eacpi-video or by nvidia_wmi_ec_backlight (when using an AMD APU +
nvidia dgpu).

For now what should be done here is to call acpi_video_get_backlight_type()
and then translate the return value from this into a backlight-type:

        acpi_backlight_video		-> BACKLIGHT_FIRMWARE
        acpi_backlight_vendor,		-> BACKLIGHT_PLATFORM
        acpi_backlight_native,		-> BACKLIGHT_RAW
        acpi_backlight_nvidia_wmi_ec,	-> BACKLIGHT_FIRMWARE
        acpi_backlight_apple_gmux,	-> BACKLIGHT_PLATFORM

Also I'm worried about probe order here, this code currently assumes
that the GPU or other backlight driver has loaded before this runs,
which is not necessarily the case.

I think that if the backlight_device_get_by_type() fails this
should be retried say every 10 seconds from some delayed workqueue
for at least a couple of minutes after boot.

Regards,

Hans




> +
> +	backlight_device_set_brightness(bd, pmf->brightness);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_pmf_set_gfx_data);
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index 9032df4ba48a..ce89cc0daa5a 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -73,6 +73,7 @@
>  #define PMF_POLICY_STT_SKINTEMP_APU				7
>  #define PMF_POLICY_STT_SKINTEMP_HS2				8
>  #define PMF_POLICY_SYSTEM_STATE					9
> +#define PMF_POLICY_DISPLAY_BRIGHTNESS				12
>  #define PMF_POLICY_P3T						38
>  
>  /* TA macros */
> @@ -480,6 +481,7 @@ enum ta_pmf_error_type {
>  };
>  
>  struct pmf_action_table {
> +	unsigned long display_brightness;
>  	enum system_state system_state;
>  	unsigned long spl; /* in mW */
>  	unsigned long sppt; /* in mW */
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 1608996654e8..eefffff83a4c 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -79,10 +79,10 @@ static int amd_pmf_update_uevents(struct amd_pmf_dev *dev, u16 event)
>  	return 0;
>  }
>  
> -static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_result *out)
> +static int amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_result *out)
>  {
>  	u32 val, event = 0;
> -	int idx;
> +	int idx, ret;
>  
>  	for (idx = 0; idx < out->actions_count; idx++) {
>  		val = out->actions_list[idx].value;
> @@ -160,8 +160,23 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  				dev->prev_data->system_state = 0;
>  			}
>  			break;
> +
> +		case PMF_POLICY_DISPLAY_BRIGHTNESS:
> +			ret = amd_pmf_get_gfx_data(&dev->gfx_data);
> +			if (ret)
> +				return ret;
> +
> +			dev->prev_data->display_brightness = dev->gfx_data.brightness;
> +			if (dev->prev_data->display_brightness != val) {
> +				dev->gfx_data.brightness = val;
> +				amd_pmf_set_gfx_data(&dev->gfx_data);
> +				dev_dbg(dev->dev, "update DISPLAY_BRIGHTNESS : %d\n", val);
> +			}
> +			break;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static int amd_pmf_invoke_cmd_enact(struct amd_pmf_dev *dev)
> diff --git a/include/linux/amd-pmf-io.h b/include/linux/amd-pmf-io.h
> index a2d4af231362..ecae387ddaa6 100644
> --- a/include/linux/amd-pmf-io.h
> +++ b/include/linux/amd-pmf-io.h
> @@ -25,4 +25,5 @@ struct amd_gpu_pmf_data {
>  };
>  
>  int amd_pmf_get_gfx_data(struct amd_gpu_pmf_data *pmf);
> +int amd_pmf_set_gfx_data(struct amd_gpu_pmf_data *pmf);
>  #endif

