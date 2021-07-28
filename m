Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28868C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 13:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BE260FE7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 13:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8BE260FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F52D6E051;
	Wed, 28 Jul 2021 13:21:58 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DE56E051
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 13:21:57 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id o20so3647499oiw.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qj3Fqf0U5fEA/MhT4e8HiR/Ogs65SJFFl/Qc+nbEe3U=;
 b=OdgWrnxh440UN3g6KWt0T6OQat2M4coRHUH7KMBu2HPvWGykm4IvjXVKzJgWylP1Jw
 l9DW3BlzC/MZ9lT/zyJQinQ7lXyUMuntnFXDbiXtfitj0lZWtwFgsmV4U7kmyQRUAYdk
 NTOM2s6qXXBCDCsxDLKpXLAkXc6zSgchPS1m9irUurLcB1rQ33JcN+7mJcC3j9FjKjjT
 627QAM9vDELN1zGWXvPa99qCcklOxRbv1Iurq2BMJ+vwvEUGaai69jD/s1ArUBpDx2hW
 DOx3LjqVRsaAnD7KSUAtlAaQ6ngQ9+wJRzi87KBFaamqLqgbfVKol9HhCgvo1EbZYw2M
 V7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qj3Fqf0U5fEA/MhT4e8HiR/Ogs65SJFFl/Qc+nbEe3U=;
 b=SptLYBeUMR5ac/WNXjLFhDZKLWDtDZBrcDSnB6+eedZLRbUnansBg9Pyt2z/L0U6P1
 HDc92wqvN3L8Q4hCISGoeY97sOWLMRsqX31WdgnCQrX9CTID5De7tHKBQv2KxuBqLLlK
 tFWxeykfWfGsVnkA6ccJLP1CGly1uL4SO7O05Tirkn2wKaQKdhJE7ZSN5md+RKMYzgfa
 yhY2ybW+akuIMneRz6ZFuUJULes/VgPyUNGLIgHhhCfWRDs0Ys7p7epF29mquovOgGN1
 Y541evN2zrmMb4eYhXlH/9OTnKq8fYWZiFZKtofqnx2TSNJlPx3BoZrvFNUi9NOp5eFr
 EX4Q==
X-Gm-Message-State: AOAM533ibk0AR3fx/iLiGymcJnFSA8UowlxjYPu4AISTbmHwuIjKXSyI
 X4/yay8iGOG3jg81d/9+H+2CJTEaHw04iecUI6k=
X-Google-Smtp-Source: ABdhPJyc0gzgRvQ6absHeY7nl49MbdCdKtNoLEdSg+LPH3zzz0GTo+i7zt/zDpaVYQClnWm/dzSHtXv9j59m0ZfUV2g=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr18211214oiw.123.1627478517109; 
 Wed, 28 Jul 2021 06:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
In-Reply-To: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jul 2021 09:21:46 -0400
Message-ID: <CADnq5_N_bhbpi83Y3RSh_f3AcQmDzdfNTHCMDR5j44uVEjiKbg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues
 for raven
To: Changfeng <Changfeng.Zhu@amd.com>
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
Cc: Yifan Zhang <Yifan1.Zhang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 28, 2021 at 2:36 AM Changfeng <Changfeng.Zhu@amd.com> wrote:
>
> From: changzhu <Changfeng.Zhu@amd.com>
>
> From: Changfeng <Changfeng.Zhu@amd.com>
>
> It can't find any issues with noretry=1 except two SVM migrate issues.
> Oppositely, it will cause most SVM cases fail with noretry=0.
> The two SVM migrate issues also happen with noretry=0. So it can set
> default noretry=1 for raven firstly to fix most SVM fails.
>
> Change-Id: Idb5cb3c1a04104013e4ab8aed2ad4751aaec4bbc
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

I would suggest testing this on a wide variety of raven systems,
including some OEM ones if possible.  Last time we did this it caused
tons of stability issues with raven systems.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 09edfb64cce0..d7f69dbd48e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -606,19 +606,20 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>                  * noretry = 0 will cause kfd page fault tests fail
>                  * for some ASICs, so set default to 1 for these ASICs.
>                  */
> +       case CHIP_RAVEN:
> +               /*
> +                * TODO: Raven currently can fix most SVM issues with
> +                * noretry =1. However it has two issues with noretry = 1
> +                * on kfd migrate tests. It still needs to root causes
> +                * with these two migrate fails on raven with noretry = 1.
> +                */
>                 if (amdgpu_noretry == -1)
>                         gmc->noretry = 1;
>                 else
>                         gmc->noretry = amdgpu_noretry;
>                 break;
> -       case CHIP_RAVEN:
>         default:
> -               /* Raven currently has issues with noretry
> -                * regardless of what we decide for other
> -                * asics, we should leave raven with
> -                * noretry = 0 until we root cause the
> -                * issues.
> -                *
> +               /*
>                  * default this to 0 for now, but we may want
>                  * to change this in the future for certain
>                  * GPUs as it can increase performance in
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
