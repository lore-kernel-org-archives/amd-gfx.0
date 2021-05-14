Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD5AC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 13:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D926145A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 13:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D926145A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039576EE86;
	Fri, 14 May 2021 13:48:45 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C28F6EE86
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 13:48:44 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so16298257otg.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rmaCun4VLjA1+RanZV0XneKarvmOUcG/PbnmW4c15Xs=;
 b=Tn1UbnEPX9mlgBdyfPJ6AQKc5AIZp4tb+T712WwjjTcLMMe6LeQNLA41KD2iT60XXa
 PdtCNC19mEZTHqCiz88LKpoAD30CC2yMfqldPcHuoux0MEQ12+UuAemouvBc3+JlTOVy
 uWdhV1ideGrM3gKKB4Hcbq5Ie8tEs1vbwSwbrhHQ0JiHDxg4kjXKCiuE4LD1MqnifK9g
 oGIiGoFNQa7XeaapfW31S1XEa9XZda1difaZU7HMuogcjOTXQO17DHKB1gqtS+yTC4x5
 Z672Qv/FAO44o5HwvHNer7lgcJ6cuoZMK8Fy6UmVUU65FvlMCxmd7jwYruiwJpi9ijn4
 7VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rmaCun4VLjA1+RanZV0XneKarvmOUcG/PbnmW4c15Xs=;
 b=UineFtNkGQ30SZTHenWz7LoAQ3M9qbK7RiqbVfy7EjML6IXTwUISoVeycS4W52aYzk
 ToTBBQYGpTxLuNaFE33fR6usACxs4IVASn2afh15c1Ud0N/G8kzyk4zPrSZDtVio5o9E
 zV5eCTUh0i/wYo41Aux7tatN0nRFTBGIJGkVN2dcBfj/ScUe927nGBhQGdRsBtggHRtB
 RwOmFqbcZQkiaFMHe2D9n8arKPCHPiz2GuchFn8seoB9EbTbTmtSfIRUms77+PFTmLdF
 mzJqU0OiaKmDscVZPoYQEdfbzjwaAdK04apiIsAgzeTX7q9C4z9XeZB+Uu0MmHa0+LSz
 ks1w==
X-Gm-Message-State: AOAM533YtmLPMNX7lYtjpUiTaOXm6WhGT8+RQoRDAZIBmYNUDbBbeFsB
 ITRsANJ448RC+GXggZ9Y71Fkc1e9noUMENIvOls=
X-Google-Smtp-Source: ABdhPJxkce7gOQHhK2ZwQj7/Z6aY+3qWI49S0W1SBfKpIm0PeHse34Dq0s1jOJcfyi14lWbcLb1JOmh3OV8yeIm+RKk=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr24497790otl.132.1621000123421; 
 Fri, 14 May 2021 06:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210514081645.25863-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210514081645.25863-1-Jiawei.Gu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 09:48:32 -0400
Message-ID: <CADnq5_Pn5FCAP4OcJqDqB830VCt-tQ=B2QFbUK5zg9v8oJYufQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
To: Jiawei Gu <Jiawei.Gu@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Emily Deng <emily.deng@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Nieto, David M" <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 4:17 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> Initialize unique_id from PF2VF under virtualization.
>
> V2: skip smu_get_unique_id() under virtualization
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a57842689d42..96e269cbe326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
>                 adev->virt.reg_access =
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
> +               adev->unique_id =
> +                       ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
>
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 32dadeee9514..9243e5de5bb7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -686,7 +686,8 @@ static int smu_late_init(void *handle)
>                 return ret;
>         }
>
> -       smu_get_unique_id(smu);
> +       if (!amdgpu_sriov_vf(adev))
> +               smu_get_unique_id(smu);
>
>         smu_get_fan_parameters(smu);
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
