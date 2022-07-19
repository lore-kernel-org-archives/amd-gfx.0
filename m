Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40774C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 08:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC5611BD57;
	Tue, 19 Jul 2022 08:32:00 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8065C11BD38
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 08:31:59 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-10d6cdf829aso2627297fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y5IvVQE2GIvZssdvw5g7Hs+9VggyKyBykTyXW5l5Xhk=;
 b=pcvRENBXm6fRSGKsAcUwSMzEd1nT1e52dK9DAf61s88C1vhtJq749sq3cPncGC1Wq+
 O3D25sBTrDHCXWWcxVRyaxlFJJMlehHyx4kdN1enDVbqnyUZtv3ldtngzl882gHgNTQP
 tHEXaDSy6WF5BRMi/LSRI0lq7k/wSYKpOv3OUlNWyw7ySQ0HSFtj/rreuHwMUbmJKps+
 H9/QiuYxKuUrERsKpsXtccw5LKJ9YXyLRA+feD8LTCHkq9dpVz2YRlfhzBWODuSIS7mk
 WuzQOcEsMUcXBcJNmYm/HeORZMMkYrroUCCYlUs0sdp3bgYlrbGLSr+GpNx+uJTxdWrU
 9aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y5IvVQE2GIvZssdvw5g7Hs+9VggyKyBykTyXW5l5Xhk=;
 b=OiwKGZisgSZZBYq2Bs9RxxTR5/7d0C78pSIlB6MQKyRVYL1opdKtE3ZMGW3NkyxQgE
 oOMo7Rh1cETEZJpO3228LZJIwmbmTwy0mwDKCnSArLRXoy+FM2CShAEafCTmABE9wLkL
 1IE085jv8FHZ1bi6E+x1FqbpZG6PwlHK6ZZb1D8Kpk6nh+YutKoUr1UvOWo09kvak3O3
 EujGKC45gos/6IKzumtdvs+ZFLtdkTRi/hR1SHv2DFabmNVKVyrUhOZjP01rX78/SrBQ
 Q4aK+W5l85oFDYRvROhCbRahHiey6NK5tA75ENy99YZyCBnNwRa6npCtw936nKwm9kNo
 5hhw==
X-Gm-Message-State: AJIora/zEtZUbDOt+sBHTpiifIuj/mU0zgGetd/Mgtfk6m75EuHrxA9Q
 FPNZJJows0YOroCP2jdUXIqZXvu24z8+Szr3CCOjag==
X-Google-Smtp-Source: AGRyM1ueHPBVbiZNOIS8zI2YXg8/yEHyXSxRV616QrpBFaX8nNdxBNyTxJWWYGdtMupS6bQddiY6yal2IG1vsR54qwk=
X-Received: by 2002:a05:6870:f113:b0:10d:36fd:7575 with SMTP id
 k19-20020a056870f11300b0010d36fd7575mr6936349oac.148.1658219518693; Tue, 19
 Jul 2022 01:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220708015346.3027-1-xinhui.pan@amd.com>
In-Reply-To: <20220708015346.3027-1-xinhui.pan@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 19 Jul 2022 09:31:47 +0100
Message-ID: <CAHbf0-Fo4qE1RCaH2uHHW1YTkHb-yFCMnix0rjsq+K1RCMQxSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove one duplicated ef removal
To: xinhui pan <xinhui.pan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With this patch applied on Linus's tree 5.18-rc7 I get the following warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1367:20: warning:
unused variable 'pd' [-Wunused-variable]
       struct amdgpu_bo *pd = vm->root.bo;
                         ^
1 warning generated.

It does fix the nullpointer though :D


On Fri, 8 Jul 2022 at 02:55, xinhui pan <xinhui.pan@amd.com> wrote:
>
> That has been done in BO release notify.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0f9811d02f61..49536fa8d269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1583,11 +1583,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>         if (!process_info)
>                 return;
>
> -       /* Release eviction fence from PD */
> -       amdgpu_bo_reserve(pd, false);
> -       amdgpu_bo_fence(pd, NULL, false);
> -       amdgpu_bo_unreserve(pd);
> -
>         /* Update process info */
>         mutex_lock(&process_info->lock);
>         process_info->n_vms--;
> --
> 2.34.1
>
