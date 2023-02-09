Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F06C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6412F10EB0B;
	Thu,  9 Feb 2023 14:37:07 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE3E10EB0B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:37:05 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 f47-20020a05600c492f00b003dc584a7b7eso4010561wmp.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 06:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pdOZfET4qceEOi/K/83aQmI/pTJrRKgm0cyP+Q36SXQ=;
 b=d8Q1075yJ6YkhKhXcEjDVayDh3Tv45WPpd1jKPO/e2+B3lkxFgKkyHMg+vjg0YJxEb
 /9s3L6Z5XNVI6NrcKuFx6KJcy55fwDQnZQ5u1zCGNjc4kezVRrIqi7Q7NetGWJoSsHGU
 ldABLUUNvGyXSvb+4wBDkGVgx+RxAzNoxKVJCd+yhDjrvGYR/zo6oPewnIuxHmGIoRM8
 A4+GTBjy8R1Gxi8Pf6/bXd4WDjrj7ljb2dORX/jYiMTNMVHEtKsMdIs5jZNokQJZahYv
 lwbzqoGr/nmOCRngK54Q7HnzAy2DAK4loQ6YPLQmRh5Fv/jouI/ron+FUdDmGxamqNTZ
 27Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pdOZfET4qceEOi/K/83aQmI/pTJrRKgm0cyP+Q36SXQ=;
 b=lO8q1x1NEVkKkvCCsoPvpLjB7NmqyaHRsiQgcrtl9ytFE0YlpEWCL12wW7/vEZahCx
 cFcyqDkhpZPWlSPjayvUq7u9bcFYEKAOh47XDW5apBVI259DanCmBOSw8ks+mim7BorI
 3uq4X8Uw9lKvhwqwr5vqKcHTq/gAo6+WrR1JixtXg/wtLAFEtelN2vWq1mZrSgU/XRos
 8X9IUoWhV+1kVm+ckIEb48EYMcTT6lmdi+u4kPqs+T/+Qvm5ARnbgJyurueqaD/QH4/0
 Ob38UTwev8Ws2Rdr9zlGDXRmvFZTXFD3ERW07w78kyFqI4dQH3zhVnzCByJ49ai4EwyB
 e3jQ==
X-Gm-Message-State: AO0yUKXjrq6n71mtLmu0ZzJwwIk6Ci7CIREi94dUqXzW3U8d22MexZ/A
 YauZcejUD1s/5Whu7x68pkQ=
X-Google-Smtp-Source: AK7set8oAubLlVlOhPVKU6zjg5qksgSCKoJJYkjxZkoQPoIutABSx/oYN78XtNs/FNiryhopJAKUug==
X-Received: by 2002:a05:600c:340a:b0:3dc:45a7:2b8a with SMTP id
 y10-20020a05600c340a00b003dc45a72b8amr10136380wmp.10.1675953423977; 
 Thu, 09 Feb 2023 06:37:03 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c468d00b003e001afa274sm2300201wmo.2.2023.02.09.06.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Feb 2023 06:37:03 -0800 (PST)
Message-ID: <0a4e57da-5960-0955-8fc9-a4cc1a28b9d7@gmail.com>
Date: Thu, 9 Feb 2023 15:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] drm/amdgpu: add S/G display parameter
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230209141150.612825-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230209141150.612825-1-alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.02.23 um 15:11 schrieb Alex Deucher:
> Some users have reported flickerng with S/G display.  We've
> tried extensively to reproduce and debug the issue on a wide
> variety of platform configurations (DRAM bandwidth, etc.) and
> a variety of monitors, but so far have not been able to.  We
> disabled S/G display on a number of platforms to address this
> but that leads to failure to pin framebuffers errors and
> blank displays when there is memory pressure or no displays
> at all on systems with limited carveout (e.g., Chromebooks).
> Add a option to disable this as a debugging option as a
> way for users to disable this, depending on their use case,
> and for us to help debug this further.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
>   3 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 64f9cc6fbbf0..187597024c1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -242,6 +242,7 @@ extern int amdgpu_num_kcq;
>   
>   #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>   extern int amdgpu_vcnfw_log;
> +extern int amdgpu_sg_display;
>   
>   extern int amdgpu_force_sg_display;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index fa3788bb6a2c..afa5c39c9c74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -188,6 +188,7 @@ int amdgpu_num_kcq = -1;
>   int amdgpu_smartshift_bias;
>   int amdgpu_use_xgmi_p2p = 1;
>   int amdgpu_vcnfw_log;
> +int amdgpu_sg_display = -1; /* auto */
>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -933,6 +934,16 @@ module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>   MODULE_PARM_DESC(vcnfw_log, "Enable vcnfw log(0 = disable (default value), 1 = enable)");
>   module_param_named(vcnfw_log, amdgpu_vcnfw_log, int, 0444);
>   
> +/**
> + * DOC: sg_display (int)
> + * Disable S/G (scatter/gather) display (i.e., display from system memory).
> + * This option is only relevant on APUs.  Set this option to 0 to disable
> + * S/G display if you experience flickering or other issues under memory
> + * pressure and report the issue.
> + */
> +MODULE_PARM_DESC(sg_display, "S/G Display (-1 = auto (default), 0 = disable)");
> +module_param_named(sg_display, amdgpu_sg_display, int, 0444);
> +
>   /**
>    * DOC: smu_pptable_id (int)
>    * Used to override pptable id. id = 0 use VBIOS pptable.
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bf06875e6a01..1babdfaa789a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1576,6 +1576,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		}
>   		break;
>   	}
> +	if (init_data.flags.gpu_vm_support &&
> +	    (amdgpu_sg_display == 0))
> +		adev->mode_info.gpu_vm_support = false;
>   
>   	if (init_data.flags.gpu_vm_support)
>   		adev->mode_info.gpu_vm_support = true;

