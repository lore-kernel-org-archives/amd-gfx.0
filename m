Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73DDC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 18:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4E410E865;
	Tue, 14 Mar 2023 18:13:07 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0792310E865
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 18:13:06 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-17aa62d0a4aso3343603fac.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678817585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZ8Y7SX2RhnBYAfK1XYDwRaRgc9WldrxzgXNtGD5ZDE=;
 b=RCiWdEafD40K0Yyt+wmeyYxVFcYKySljsGXd18mVmVyek7URZuMZaEbuj2weLRoG0j
 b4GOpEPc0CS3dqc7ZcWg3Io04eO8maDN374mIj8JjE7VzfGvhP4xRQ4xV4oeUQjFscOe
 zPrKMbM9zgoaL+yvyUxtuV2X+dVZzBCpULqfQXtlXS6Q8oGTmXMO2BVJVGNvOC42jpxz
 kXWHxDHbtzQOZsJJVHqx4+Qrjzr2OOOlUBjlgn2rkQ40FGhOAiJnzGkH8uE7HWP0L1Lf
 x8a4uQf650E4hsJ+b08fQ1UFBYZgYOI3gveMGYS8l4AHiFp7+Q/ZQj5hzNIsqlWx8Ig0
 0CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678817585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ8Y7SX2RhnBYAfK1XYDwRaRgc9WldrxzgXNtGD5ZDE=;
 b=5X/YoFamoTMwk6tA/g6E7fQ/W7FyLD+fjNxnvgelDI4+1fsBflfjH2s5zeIcJ4Si5B
 Z3jQ30L+oexl2/P57QKC2Hu907NN4OyRLJ2tIt1vzkw8mA8DnTLRgtwjYD8gSOR6Ip/I
 UGXg79Fd6Gz+2ct/fRccFPoYty8tBIvPfODTFynREb4aW56q+nPHI7XPlj3/1FEoUd9T
 6OppKkn6+kmkBnRKIlodaJmulRHSoDSb2KxHGNz8XibOKZoQSLhzMxWN9q/gJgr7Yh/K
 5AW8baPD7kmMaK6UWFhJpKkvwl0QfQzPDVcQh7EmFgxn+osZbK8mTzNpceVO3cYwl/nb
 2MTA==
X-Gm-Message-State: AO0yUKXfoXCBumk1ddXjQoTYlyvWgrZEirff/Rj4hAn7CLeBgcY758Dq
 QvRxUZmDWtone8MMsmfxdfn56dhFLjVWLYbZClU=
X-Google-Smtp-Source: AK7set8hqYbu9aicHcAU1i61SQ4F7yWByq+Z5XrqTc+jG0eg4YkvV00Gd2f6PZsun2JBCIT0LFFt01fso29UZu4DZ50=
X-Received: by 2002:a05:6870:814:b0:177:a289:46b1 with SMTP id
 fw20-20020a056870081400b00177a28946b1mr3332556oab.3.1678817584025; Tue, 14
 Mar 2023 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230314175359.1747662-1-Felix.Kuehling@amd.com>
In-Reply-To: <20230314175359.1747662-1-Felix.Kuehling@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Mar 2023 14:12:51 -0400
Message-ID: <CADnq5_MzJybKAOdztx=F=G+MFVqofYOkgLFSyA3wRp+h_5=tbg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Don't resume IOMMU after incomplete init
To: Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: stable@vger.kernel.org,
 Linux regression tracking <regressions@leemhuis.info>,
 Vasant Hegde <vasant.hegde@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 14, 2023 at 1:54=E2=80=AFPM Felix Kuehling <Felix.Kuehling@amd.=
com> wrote:
>
> Check kfd->init_complete in kgd2kfd_iommu_resume, consistent with other
> kgd2kfd calls. This should fix IOMMU errors on resume from suspend when
> KFD IOMMU initialization failed.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217170
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2454
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.i=
nfo>
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 521dfa88aad8..989c6aa2620b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -60,6 +60,7 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigne=
d int buf_size,
>                                 unsigned int chunk_size);
>  static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>
> +static int kfd_resume_iommu(struct kfd_dev *kfd);
>  static int kfd_resume(struct kfd_dev *kfd);
>
>  static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
> @@ -625,7 +626,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>         svm_migrate_init(kfd->adev);
>
> -       if (kgd2kfd_resume_iommu(kfd))
> +       if (kfd_resume_iommu(kfd))
>                 goto device_iommu_error;
>
>         if (kfd_resume(kfd))
> @@ -773,6 +774,14 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  }
>
>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
> +{
> +       if (!kfd->init_complete)
> +               return 0;
> +
> +       return kfd_resume_iommu(kfd);
> +}
> +
> +static int kfd_resume_iommu(struct kfd_dev *kfd)
>  {
>         int err =3D 0;
>
> --
> 2.34.1
>
