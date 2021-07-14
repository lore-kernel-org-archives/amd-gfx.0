Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4443C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAED6128D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAED6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC4389951;
	Wed, 14 Jul 2021 15:48:36 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2FB6E3F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:48:34 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 n187-20020a4a40c40000b029025e72bdf5d6so732070ooa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EY7Kl9hK3SlkUsEY4G3iYR95mKPJH8NWkHLSvlipd0M=;
 b=CCav+Oarc9Wx+6oOF5CDGi3JVGwMxjj4jUTlrQo9kUn2V8+tSm0wAkHf2Z8ZVb8bo4
 JquRrJkLHcxPjrBp/ID+Mn8sSUs+tda8qq8i2IitOPSj/fCW93Yofi51bs9AJmmBGVTp
 NpQAN6a7ZeSPvn8VQLKO7cOiNJ4CgCfqchkTuRe8wffj7RvrjK0zWGarn97lOysNDbj0
 oINW0vMVyzH9cePsTc5B09i69/oAZkkkWa2i8dc1I7yNlqDdKFUAXGcvtbQITVDP+3Z9
 66cAwVu8KOYWmrxxtpD1FBJebnwNq7iokC/3tuBy9eHzZcgm66Iq8adGDydzeJ20lS51
 Wi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EY7Kl9hK3SlkUsEY4G3iYR95mKPJH8NWkHLSvlipd0M=;
 b=VriO5RDDb/PFSbG22tF4rV4ogEPFogIBMCQDN+rY/OLJEvQNC8sU3QoQ8q5RfPuApS
 QV5HewsudAvn9XvSBsgTX+AalvNwh+D6LazzFMf5xoEK7m1rG5dSHIl+7Cmcz1MQML/h
 iVQXZc0DGT2gvDzfOUbbejVA7aZq3IdEQK7N/s7TfvKp/nBLptW6t3eW6ZElGZfF6w1F
 N8KHkkUowSkssVMrQlcDfBvOFaX39UPNJfVs1yPis+eHFCPUBmNgmxDtM+L9khloEMPJ
 HInC0klCXTD+BDciOXn1vGeGJeweF7hI7cPQBEG7NjHmzMSokNYj0Bypz1zUa1tk1AYi
 GHHg==
X-Gm-Message-State: AOAM531SV0Kwpxgwr4tTaHhkHRfcT3VHwklXJ9a7PyRLiUWAEm5c0q6u
 xBYi/TOSExC0gF0LbHRb3ckC/IDm1/eMDurYkKE=
X-Google-Smtp-Source: ABdhPJzIfartnvqF5m2m4i5LcskCHAnaID8Kcd/0wXwGoynwKiWswwebfK7ox0L4FkNxzgQ3K8mMgaxLrBRtAWg6MHQ=
X-Received: by 2002:a4a:be93:: with SMTP id o19mr8541658oop.61.1626277714094; 
 Wed, 14 Jul 2021 08:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jul 2021 11:48:23 -0400
Message-ID: <CADnq5_PE+K2eTtA7-RZqKuqc+8QhEm-v55Mbe8XdbhWeLevEwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message
To: Oak Zeng <Oak.Zeng@amd.com>
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
Cc: Feifei Xu <feifei.xu@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Leo Liu <leo.liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> The printing message "PSP loading VCN firmware" is mis-leading because
> people might think driver is loading VCN firmware. Actually when this
> message is printed, driver is just preparing some VCN ucode, not loading
> VCN firmware yet. The actual VCN firmware loading will be in the PSP block
> hw_init. Fix the printing message
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42..1f8e902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 1.0: Will use PSP to load VCN firmware\n");
>         }
>
>         r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c..ebe4f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.0: Will use PSP to load VCN firmware\n");

While you are here, switch to dev_info() so we get the device
information in the output (in case we have multiple GPUs in a system).

Alex

>         }
>
>         r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 888b17d..5741504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
>                         adev->firmware.fw_size +=
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.5: Will use PSP to load VCN firmware\n");
>         }
>
>         r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de..b81eae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                         adev->firmware.fw_size +=
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 3.0: Will use PSP to load VCN firmware\n");
>         }
>
>         r = amdgpu_vcn_resume(adev);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
