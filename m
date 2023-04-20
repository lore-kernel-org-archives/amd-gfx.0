Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A64C77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 12:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D7C10E2B8;
	Thu, 20 Apr 2023 12:57:10 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C5410E2B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 12:57:09 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5424b046c6bso237492eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681995428; x=1684587428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l+VkzWJYwo9Su3rCiFGuDRyaUZnbCgXEf0lkT1lQ/Y=;
 b=jP+fhpidMbUj2w8gNJd/1G+WJ6a3W0+hreMhFZasQwoCbHLGseACTOlOgsXzJoq6DA
 J9Ef0HKPnNDp4MdbdMCIP/X+u6Ji5JryhuTqTuOlS343PvkBqUO/hhJGZ6rND1sLH5Vv
 gQkPhHbLzHnNwauN3ibtAyz+Y5YtrTe0th7ozlIvn2cl+N/o6OhM6Bs4bCV0fpDSf/K4
 dqLsQEKFy5K/M4FtX6qRrPt3W1wC9BXGDy/YLKanJDTDVO8/qAdl9blsKhR5YIhVYDNp
 WHZRXJ3FKXev7QRTPQ/Scqtl+A6DacK0Y4qaZ72ebp51+hXk7W8fM/jdhLujCkNEz6Ad
 gd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681995428; x=1684587428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1l+VkzWJYwo9Su3rCiFGuDRyaUZnbCgXEf0lkT1lQ/Y=;
 b=Q3OB34/StUsd5AoM9jkdU5pztX+KKIUhL8v1Y9+tV2tEONplVHQVVxAREMWdNPgZ7b
 oCvHYfnHRBw00V+Llse1oqRKMFX8pFqAn/S77ssnlMrDVMZY7JJc79IsIoM3NZZ34KpZ
 mHKfqtiqQIqGaIbxvmJBIPS1rJRkGfWBryCMNfR7LPTqUPryHvxLyQH/GzqbiPtNMijB
 E7YV1RnJd2FZ6b8oWC1eleeYmewv/Ghlbrz/lFIC2uYIZ09AK+eSaGVkZ/zVLMWtUOB2
 FLdRw914BbvIu8uqt3m9qD4s9m6EA7n+nnrnWdu+lVVwjB8uRUeuUu23y47huAMXDr4V
 DmKw==
X-Gm-Message-State: AAQBX9cH4z2bbTG+OgU6PTm6bVg6a45ooPUXddz4bwqhJfyzEHTY5wng
 qjzdONkalCBEST0vCnuyxNx7nvM5lZOH+4l6sQE=
X-Google-Smtp-Source: AKy350Y00aYeANR1a7LV4jUr9ZlW6/L1rmlGQMv9WvmMxGEXxMVyZAZud1Y8ZUULUGM9UGag/YI5ni5XuDIDO62nHP4=
X-Received: by 2002:a05:6870:4603:b0:184:3a9:9c4d with SMTP id
 z3-20020a056870460300b0018403a99c4dmr926182oao.17.1681995427970; Thu, 20 Apr
 2023 05:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230420091942.5981-1-Feifei.Xu@amd.com>
In-Reply-To: <20230420091942.5981-1-Feifei.Xu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Apr 2023 08:56:56 -0400
Message-ID: <CADnq5_OkR-34GappsZNH5sSrRFOJ36J5_cykreckErekz=bxSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: extend the default timeout for kernel compute
 queues
To: Feifei Xu <Feifei.Xu@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 20, 2023 at 5:19=E2=80=AFAM Feifei Xu <Feifei.Xu@amd.com> wrote=
:
>
> Extend to 120s. The default timeout value should also extend if compute
> shader execution time extended. Otherwise some stress test will trigger
> compute ring timeout in software.

I think that's probably too long.  2 minutes is a long time to have a
hung system.  I think we should rework the tests or use ROCm for long
running test cases.

Alex

>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e536886f6d42..1f98b4b0a549 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3475,7 +3475,7 @@ static int amdgpu_device_get_job_timeout_settings(s=
truct amdgpu_device *adev)
>
>         /*
>          * By default timeout for non compute jobs is 10000
> -        * and 60000 for compute jobs.
> +        * and 120000 for compute jobs.
>          * In SR-IOV or passthrough mode, timeout for compute
>          * jobs are 60000 by default.
>          */
> @@ -3485,7 +3485,7 @@ static int amdgpu_device_get_job_timeout_settings(s=
truct amdgpu_device *adev)
>                 adev->compute_timeout =3D amdgpu_sriov_is_pp_one_vf(adev)=
 ?
>                                         msecs_to_jiffies(60000) : msecs_t=
o_jiffies(10000);
>         else
> -               adev->compute_timeout =3D  msecs_to_jiffies(60000);
> +               adev->compute_timeout =3D  msecs_to_jiffies(120000);
>
>         if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>                 while ((timeout_setting =3D strsep(&input, ",")) &&
> --
> 2.34.1
>
