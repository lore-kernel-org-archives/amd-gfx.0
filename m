Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B5C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BEB611BF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BEB611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F73A6E03D;
	Mon, 17 May 2021 10:40:08 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6625E6E03D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 10:40:06 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id di13so6282150edb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=yB85b4FUVtW0Ba3RlkDf2vjxczHAM42Zh6c8fdKQbyE=;
 b=aZDRxq3lcALnlG4Ap1hftoeEYdOCinCrwAdBAAPeb0JJD88fTcAhb/krDaRl1iD6HM
 OFg3CibBS5Y3p83DOLEvu9tNs9PciGeoXqsbhQkfD+uc7s48MYWERJWoulhhcNPa05NE
 5IEE/SiMcgLUIJO2Rpr7H3tB9hkPUbUbwWqlJiosfxFrwYjqGqPR2cUIOGwfSQ+CSBOJ
 muK14S1CmlE55fOlry2bZUwgQAK1896dPMZno1DOkyacrCs/hhcULX5v7br4KRMqGep6
 MFwu1MAw16GCDXfymoIenLb7okj9z7t5kv0iLe2cloMpHuC99JCh0Ihl2DI4bR+ehqT4
 xrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yB85b4FUVtW0Ba3RlkDf2vjxczHAM42Zh6c8fdKQbyE=;
 b=lRVlWPxtdkR1G20Ux9PTAYKHmgkxnseuve/ITAn2lIaHCfmdsvEa+rB0UYATbgxe9W
 0mFMtnJOszmyfesV/9K1nCsNbRDztvOt+kHDkMcKolfBvipRmq+36TfCK6LySCGly0nT
 /DV08HfMV8B0nOs2Q3reG4JjmnLGLkd7FvaWv3ZLI9JdUpye54bRGuGhIX0e2KsTcT2T
 oPExFrfNf5vG35l35jib6Z3qrb2/8qBMYrWC3rnRcsJghIu8ZMeK+7fUCzXJILokU3Tz
 xuJiV+v7WbPqZ3iKR3CX/J3+f47r+9kGdKWzUShkxHNaFSdfcCuAh8CU7TtUGGLQHp0v
 94jg==
X-Gm-Message-State: AOAM531PUCe8rWhW4URj/cw8vZtrDpPQ7wAhJu/CoF+0WA5OI2dCF36T
 fwidzNkLcm9/S+Sz9ALUAPk=
X-Google-Smtp-Source: ABdhPJw6ryporFh/y2KtfpnC/a2njJvW2Y7bwZlnn1t8kTMNd+9o4pxkTdiCV+KQonT1DeIJ5UAPzA==
X-Received: by 2002:aa7:c745:: with SMTP id c5mr10090345eds.136.1621248005076; 
 Mon, 17 May 2021 03:40:05 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d?
 ([2a02:908:1252:fb60:6bbe:b48c:2de1:422d])
 by smtp.gmail.com with ESMTPSA id n25sm10682204edb.26.2021.05.17.03.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 03:40:04 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add vbios version string
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>, "maraeo@gmail.com"
 <maraeo@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210517102155.23753-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51567775116DFAFB29E43821F82D9@CH0PR12MB5156.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cf6db643-7eaa-c0e9-dfc0-d0fa86e17059@gmail.com>
Date: Mon, 17 May 2021 12:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CH0PR12MB51567775116DFAFB29E43821F82D9@CH0PR12MB5156.namprd12.prod.outlook.com>
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jiawei,

yes agree and additional to that we need to go a step back here.

First of all once uAPI headers are added you are not allowed to change 
them again.

So this iterative approach where more and more fields to the structure 
is really a NO-GO.

Instead please revert all patches already pushed amd-staging-drm-next 
and then squash together all patches and send the result to the mailing 
list for discussion.

This way we can review and verify the uAPI as a whole and not in 
individual steps.

Regards,
Christian.

Am 17.05.21 um 12:28 schrieb Gu, JiaWei (Will):
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi all,
>
> I know the vbios ioctl discussion is not settled down yet.
> Please just regard this patch as a proposal to include vbios version string info into discussion.
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Monday, May 17, 2021 6:22 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Add vbios version string
>
> Expose XXX.XXX.XXX.XXX.XXXXXX vbios version string in AMDGPU_INFO_VBIOS_INFO ioctl
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/atom.c          | 16 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/atom.h          |  1 +
>   drivers/gpu/drm/amd/include/atomfirmware.h |  1 +
>   include/uapi/drm/amdgpu_drm.h              |  1 +
>   5 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index e1008a79b441..30e4fed3de22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -870,6 +870,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
>   			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
>   			vbios_info.version = atom_context->version;
> +			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
> +						sizeof(atom_context->vbios_ver_str));
>   			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
>   			vbios_info.serial = adev->unique_id;
>   			vbios_info.dev_id = adev->pdev->device; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 0e2f0ea13b40..542b2c2414e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1438,6 +1438,21 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
>   	}
>   }
>   
> +static void atom_get_vbios_version(struct atom_context *ctx) {
> +	unsigned char *vbios_ver;
> +
> +	/* find anchor ATOMBIOSBK-AMD */
> +	vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
> +	if (vbios_ver != NULL) {
> +		/* skip ATOMBIOSBK-AMD VER */
> +		vbios_ver += 18;
> +		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> +	} else {
> +		ctx->vbios_ver_str[0] = '\0';
> +	}
> +}
> +
>   struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)  {
>   	int base;
> @@ -1511,6 +1526,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
>   	atom_get_vbios_name(ctx);
>   	atom_get_vbios_pn(ctx);
>   	atom_get_vbios_date(ctx);
> +	atom_get_vbios_version(ctx);
>   
>   	return ctx;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
> index c729f7ceba4f..6463ce6e756d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -148,6 +148,7 @@ struct atom_context {
>   	uint8_t name[STRLEN_LONG];
>   	uint8_t vbios_pn[STRLEN_LONG];
>   	uint32_t version;
> +	uint8_t vbios_ver_str[STRLEN_NORMAL];
>   	uint8_t date[STRLEN_NORMAL];
>   	uint32_t sub_dev_id;
>   	uint32_t sub_ved_id;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 14d0d7d58255..28deecc2f990 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -198,6 +198,7 @@ enum atom_dp_vs_preemph_def{  };
>   
>   #define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
>   #define BIOS_STRING_LENGTH 43
>   
>   /*
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 2d9e84658bbc..e0f98ca9a755 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -956,6 +956,7 @@ struct drm_amdgpu_info_vbios {
>   	__u32 dbdf;
>   	__u8 vbios_pn[64];
>   	__u32 version;
> +	__u8 vbios_ver_str[32];
>   	__u8 date[32];
>   	__u64 serial;
>   	__u32 dev_id;
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
