Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF02C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B3761494
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B3761494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D038D6E9B6;
	Tue, 23 Feb 2021 16:30:51 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A360D6E9B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 16:30:50 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id e45so6884563ote.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PEM24RGJDX6dDCiBCvPqh0Zlc7sstkwHmA9PNML8mes=;
 b=SflCGUsUaw/oZ4YuRE1JAHbRkjHUnPWJDY8iTv3jFTWk5USPwgZcb4Ne6Kb3bYZ55y
 gvavrqnIEvtLNVvBE1tfGAnqjigPg8r1f3Cxz4AaTXImTQ3uXR8nHDaSmVkbgC7nf5Y8
 3Xm9caYhNbtp+pYGDiEDwDz1Ykvfdk7uoxiG07Tzeys09SDsir15Nk3IJAOa9+crWVQc
 LN5tuxemdchxNfe0gPj/QWegS11uzT2uUjT3XIhWny6FMWKHxuJ5kprDV1wQof/ieAc4
 m0NmoqKePk9GKFD2HrqGMq6hu/qcceHq6W2taxFNmJvgcr2VCaSrUQEq1czLNujgPXGe
 nX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PEM24RGJDX6dDCiBCvPqh0Zlc7sstkwHmA9PNML8mes=;
 b=NT6A+omVcscj0KqAQHQxET7/tNsaH+S9PhRf9ouVIN8/3u77pbXyW5NlUUQtqo5eNx
 53EuDYrl1hdfQzjZPQaRfsLl7g6vdy829mmj0L4o9ROu/Jn8SoEjTvZ5+4Xs+pCU9oj0
 axQRybqPpA5BbP+Ql6tgsS54KCHWcHtG+t8qRyZBaeuflxAdcjwIq/i0pc0QwokCvMh+
 iQuX8f2If4lFZBNymp+g8f8t5IVsZfyey8AXYKGZ1NoZ8FG51SiVVhVTp2Kw5YLoKwGM
 KGyJDPzQMsSJ8E52Q1PjUsf9lMdHH2fZjqsRHRcRCZSKqabohz91Cnlv8KIOX0MY7nQu
 WiRg==
X-Gm-Message-State: AOAM5322MDNuPC4C0Zdo35MyTZ663fydThUve7Ppw71nkO8iWDV4LTdP
 2NYkeIrLUmY/FrR0DQlWs5BuSxAxJMTTAQvLb4KPkc6jwIA=
X-Google-Smtp-Source: ABdhPJw+x7pkaw4nw7brRmkBAV475mA1XcqS+Dz06Ks0+vkLtSEcjTitV4PQgXsuzBdRRUNMy9K7ixwl2hT0tlSrjmw=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr21037437otl.23.1614097849980; 
 Tue, 23 Feb 2021 08:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20210219011934.28514-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011934.28514-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Feb 2021 11:30:39 -0500
Message-ID: <CADnq5_NHBViu4AGxkqa632LgU-c1RoPsb7tyaxKmQgTKa=2CNQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
To: shaoyunl <shaoyun.liu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 18, 2021 at 8:19 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> amdgpu driver may in reset state duirng init which will not initialize the kfd,

grammer "may be in"
typo duirng -> during

> driver need to initialize the KFD after reset by check the flag
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c5343a5eecbe..a876dc3af017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>                                         adev->doorbell_index.last_non_cp;
>                 }
>
> -               kgd2kfd_device_init(adev->kfd.dev, adev_to_drm(adev), &gpu_resources);
> +               adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
> +                                               adev_to_drm(adev), &gpu_resources);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4687ff2961e1..3182dd97840e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {
>  struct amdgpu_kfd_dev {
>         struct kfd_dev *dev;
>         uint64_t vram_used;
> +       bool init_complete;
>  };
>
>  enum kgd_engine_type {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9f574fd151bc..e898fce96f75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4841,6 +4841,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 /*unlock kfd: SRIOV would do it separately */
>                 if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
>                         amdgpu_amdkfd_post_reset(tmp_adev);
> +
> +               /*kfd_post_reset will do nothing if kfd device is not initialized,
> +                *need to bring up kfd here if it's not be initialized before
> +                */

Fix up the comment here.  Need a space between * and the comment.
E.g., /* kfd_post_reset ...

Also, I think this patch also needs to come before patch 1.

With those comments addressed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +               if (!adev->kfd.init_complete)
> +                       amdgpu_amdkfd_device_init(adev);
> +
>                 if (audio_suspended)
>                         amdgpu_device_resume_display_audio(tmp_adev);
>                 amdgpu_device_unlock_adev(tmp_adev);
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
