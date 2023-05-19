Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BF4C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 16:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0355E10E53B;
	Fri, 19 May 2023 16:56:33 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D328010E53B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 16:56:29 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-38ede2e0e69so1920519b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684515388; x=1687107388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pso7ilYJS4gACr2ZhN+4vIJVUrwKX3IgOssmIyXKg+k=;
 b=bxlXbrPpQEo67LIBNpCl15Sj6bCUTTkPIAPXyWk4SUa2A8RADtaCw7rHoGMhdw/mdd
 Wb+SPQTQudTWb9t1lDDRDqMxXlPbl6E3i8VPLEWaWnR8/ct8HobL5Diap5eh6aSBToxp
 fDP1zbnTdAZRfwGhMKgJ4Ih4+CUl/rxZ40oqQ/G/9jJpWyCtBsAuqRmuaym+n2aqlqsK
 Q1qEF02+JSAdD4Z2TGG4AJWXMIb6sCfCOUAbCi3mqaVVhK2k/4FIhEjf+thaR9+HKoYE
 MJe3nDnY+uzcdDmLOxELKg6Ew0LVoT55vhzSV1QuLqwleFzDwOwgf61HrXATZtwJbV5T
 PMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515388; x=1687107388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pso7ilYJS4gACr2ZhN+4vIJVUrwKX3IgOssmIyXKg+k=;
 b=Jwz4rC+J1vbhVfW+kV3EmL6LzF6c369hz9wDdcPYVauREgxzC6oefqEsPeysd/FJPC
 uSC2z0ZqGGXj344ThXV4zI3Ag+kQRe/auRSdY/figDasDJ1sxBRArZh49CXEzdYNm4cK
 s3Lln66x+CvpiEvgPvs014lMrYrMTU7cpWLKlXsk7yAftnCyU/bypzvc9L0Ul4iMfayY
 PuTkPpudvvkrIwrRy42m5fBuuL3JoLyFhFuJ0dcg6BNZC4a+0vDm7jtKEU0FPdEo9imC
 5dOpGQhx5EkF+Lswnq6+kX+juRwHp0KL2iKrpZFYcsHOXClD8enD/S1IzLLhVK2/3Kx6
 xFlw==
X-Gm-Message-State: AC+VfDyTm4gA3UWZ4mXgNdg9EQbV6L8xwe8QaeHBwdD+ILo5kqQA6hNU
 zEadSIPSlHb417ATEROE4VnmnuZrs/Bjo3Z+z3yd2ArY
X-Google-Smtp-Source: ACHHUZ48M1oBbMILGdxbvnjMkTYz1j2B667MaArriN5VHi4CfRE1JL1MnxXdK0clcQYEO0nDIjKKfU+K06s+meVk1HU=
X-Received: by 2002:a54:400c:0:b0:395:f7d3:d4b8 with SMTP id
 x12-20020a54400c000000b00395f7d3d4b8mr1372348oie.36.1684515388492; Fri, 19
 May 2023 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230519051712.23462-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519051712.23462-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 12:56:17 -0400
Message-ID: <CADnq5_N3SRQamDO9fZZL4naM88BPr7ox-eZuriALk4778J__+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix uninitalized variable in
 kgd2kfd_device_init
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, May 19, 2023 at 1:17=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:613:4: error: variable =
'num_xcd' is uninitialized when used here [-Werror,-Wuninitialized]
>                         num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
>                         ^~~~~~~
> include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
>         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__=
VA_ARGS__)
>                                                                        ^~=
~~~~~~~~~
> include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_=
index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                                     ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:597:13: note: initializ=
e the variable 'num_xcd' to silence this warning
>         int num_xcd, partition_mode;
>                    ^
>                     =3D 0
> 1 error generated.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Mukul Joshi <mukul.joshi@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 986543a000bf..e92b93b2c14c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -594,7 +594,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>         struct kfd_node *node;
>         uint32_t first_vmid_kfd, last_vmid_kfd, vmid_num_kfd;
>         unsigned int max_proc_per_quantum;
> -       int num_xcd, partition_mode;
> +       int partition_mode;
>         int xcp_idx;
>
>         kfd->mec_fw_version =3D amdgpu_amdkfd_get_fw_version(kfd->adev,
> @@ -609,8 +609,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>         if (kfd->num_nodes =3D=3D 0) {
>                 dev_err(kfd_device,
> -                       "KFD num nodes cannot be 0, GC inst: %d, num_xcc_=
in_node: %d\n",
> -                       num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
> +                       "KFD num nodes cannot be 0, num_xcc_in_node: %d\n=
",
> +                       kfd->adev->gfx.num_xcc_per_xcp);
>                 goto out;
>         }
>
> --
> 2.25.1
>
