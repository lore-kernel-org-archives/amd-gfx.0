Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B8AC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B34613C5
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B34613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9AA66E420;
	Wed, 14 Jul 2021 15:28:28 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468F06E423
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:28:27 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 f8-20020a1c1f080000b029022d4c6cfc37so2853382wmf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ApMe0Hnkw73/pQCIaVQnLCgKC8T4DeftTE0H5FMAibY=;
 b=u3XNPShL4pWO4a/f60iNTC6yUaJBH5XogH1fZGGCF7Cl0ceeIlHoi4+hSSejC6Okys
 IPSVLAgoBitPDmq35CMTH5jSmV17U5jHZjCFEo/pwzlYSHUIV2Jfcv82QXA1HAA1zlbC
 ICpi+Aq8bYfFmKCTSYJ8pjiza+5MV1cr1qCE9fDGJ+PGxw4c0lxPfus9t9/C3ibsdJ0K
 6HN9QcOu8J0OiOJ6o/ZzuxN48+S73QaZ046sm8ZG6qlRSWmVtmn6HdYQAtBIm2Dou07F
 gonwNiFzJZKweFabu4RapcX+GbadfGFGg4/5vJKHKww+dSZznU0Lrr3xxS38rS5kAKL7
 hDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ApMe0Hnkw73/pQCIaVQnLCgKC8T4DeftTE0H5FMAibY=;
 b=IPcMMtB9cdJE9t47Nw4l9tYG7LrsN8j2IzvhxbyXmap2hLdDOSxQspgmozMJXXAXNl
 HCi0rwhG/dd6wQ762YA/6f8D96YBsshYIEiXpZFwvIUj9QLaBx83NemSoGquz5+4Cch+
 rGA6lGaMckgbOt3ORlVNuqizNrP1GfrG8GXJ8wVqIPRpYRxClEwN1i2cQOpvLda5BXYd
 BFtlp3eb8V/XnqZuDHpgwpLl/E9PdzpKrUJulY0Y9pb+Uu73uca61EIz0IAzsQGFWVTG
 9LuXy/2SQQ77ScAbPbXMByqZ9R678NUMd/bo1rsXjNAkftlM2/7QYYKwrDdssWWw9AS4
 wsug==
X-Gm-Message-State: AOAM531higDKy6uDi+eu0wuz38i/ozfkXN+SVXQiqcguEzVv+1ugud5L
 PWApNA07Sshov1QhCMp6mG4=
X-Google-Smtp-Source: ABdhPJx9kn8D3Rnr+SUfMoGYPneew8MBF5DDNedaIYB46FCLBe771z8pc5FsrQ/gI6QnynL6lhv5ig==
X-Received: by 2002:a05:600c:19d1:: with SMTP id
 u17mr11681860wmq.177.1626276505902; 
 Wed, 14 Jul 2021 08:28:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:36d5:a331:b1c9:384b?
 ([2a02:908:1252:fb60:36d5:a331:b1c9:384b])
 by smtp.gmail.com with ESMTPSA id i15sm3197336wro.3.2021.07.14.08.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 08:28:25 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <679271ba-86ff-7fcb-2aaf-e76a80666f89@gmail.com>
Date: Wed, 14 Jul 2021 17:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 14.07.21 um 17:25 schrieb Oak Zeng:
> The printing message "PSP loading VCN firmware" is mis-leading because
> people might think driver is loading VCN firmware. Actually when this
> message is printed, driver is just preparing some VCN ucode, not loading
> VCN firmware yet. The actual VCN firmware loading will be in the PSP block
> hw_init. Fix the printing message
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42..1f8e902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
>   		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
>   		adev->firmware.fw_size +=
>   			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -		DRM_INFO("PSP loading VCN firmware\n");
> +		DRM_INFO("VCN 1.0: Will use PSP to load VCN firmware\n");

Good to have, but I'm not sure if we should have the VCN 1.0 prefix here.

Christian.

>   	}
>   
>   	r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c..ebe4f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
>   		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
>   		adev->firmware.fw_size +=
>   			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -		DRM_INFO("PSP loading VCN firmware\n");
> +		DRM_INFO("VCN 2.0: Will use PSP to load VCN firmware\n");
>   	}
>   
>   	r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 888b17d..5741504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
>   			adev->firmware.fw_size +=
>   				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>   		}
> -		DRM_INFO("PSP loading VCN firmware\n");
> +		DRM_INFO("VCN 2.5: Will use PSP to load VCN firmware\n");
>   	}
>   
>   	r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de..b81eae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   			adev->firmware.fw_size +=
>   				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>   		}
> -		DRM_INFO("PSP loading VCN firmware\n");
> +		DRM_INFO("VCN 3.0: Will use PSP to load VCN firmware\n");
>   	}
>   
>   	r = amdgpu_vcn_resume(adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
