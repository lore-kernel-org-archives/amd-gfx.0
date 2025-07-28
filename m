Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693F6C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 18:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A01410E569;
	Mon, 28 Jul 2025 18:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dohGltkv";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0127610E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 18:09:51 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-31ec2ac984eso265003a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753726191; x=1754330991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPg50feDtI8/IvSrda/qSYd4awYvwi84/NVEtGDysic=;
 b=dohGltkvRQKhGXBUYd/OxAWEJ00YQqCQDgPZpj6g/kNlTpi6LOkZQUoS7RR2YeVxiR
 6kZR9Ay12+SW/XXOCHl07LQuju15/gZYZ9tp+zjvawN9V8QCO2gzOBpyE52FoVxQ2ibN
 RQllJ2wf7sxKtlo5aC+wPJXcJoF7zvHevU4empIP0MIiO78GgegovVDGonILPJLzaSVP
 xHiV1/lVkiCt/dbktKPoR7lMIvRL5nmwm8d6hwmpm1fvFoQYxHIWWHfeD/OZY24Yl7MO
 rUTekjsYY9dPpRmJytTD4ULdgf0plk9SSjlJex9DRp0JBnYMUhI6guhsEmAoF3pr90eS
 jOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726191; x=1754330991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPg50feDtI8/IvSrda/qSYd4awYvwi84/NVEtGDysic=;
 b=BGK2j4RM2Zj1WIGa2r0+DOHTBFrQBnQtuo1imSmU+tGvNoZ+BFhq8S43c7sXnJsuzr
 sHPHMAvQ/7ChszKN98/XnLHzzv9X/Hf9WnsE9MutsbguOqUO2qe68TYtRk+fKicOa7JV
 OlJPHj2mm/RDEv8933EKcPZaspuIloqaf/0vrXF83JKzxDyDv57OxfAeALHv991+oKSR
 sIc60BrEgyg7b04SaMcz6Fkh7PZFJ42olpp6VLkFkYDeyps0Tsk1w8EyM85IenHT0uwv
 Xjt92C6MoP2wkfZJjCNA3Yci/Uez7nRL03c8okqdCpNazr6ehiYRdgansRL260otwIrA
 P94A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoDuzL9MNod5P3GpKZV4SXOKXxn+OpLgdxd8qZAV4fAIpz5rflvSJJ3nr2dP1lVJKmbvDBLTWq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCeEgU4tgdirr38IfVVlRgaEgihul06/fgkAp2iaY5i4dEIyG8
 Nt4jJ9fYZIKqheH14CsMgmsW264LYdHfEoWnXFXV7iM0y51GezOF5cEHf5oAs7wGvs0K+kcE4TV
 LQz2viKVntFCfHm3reDmf0jSb/h/I/oc=
X-Gm-Gg: ASbGncvw/j3W98mIwoLcxoV2mpVcd1tooro2loCQxC5UULglMkA/puTK8UL3vVanJjN
 7WWllyW0ycwKJpiiPF2uZ0Y8OQ5RZX3pLmi62p31BJeRr4tlluxJDI88nGLT2HsP6vIpgKAB6/J
 rAmtAh8YqlI2XITfqUzgpkz2DLKYHUQI6d4wnMIoeo3jUT7PukDNHLUucydBi2iInsdAn9X/lUj
 RmBF2pW
X-Google-Smtp-Source: AGHT+IFKvsCzAT5JdE5vaicE+pfXucubRBYvat/fgye+DMROiqjpDO69Auc02D3msd2yxl/NtDhV3jq7IXncfm6cNj4=
X-Received: by 2002:a17:90a:e7c3:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31e776ab52bmr7586661a91.0.1753726191407; Mon, 28 Jul 2025
 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250723090624.53536-1-YuanShang.Mao@amd.com>
 <PH0PR12MB5420F1D3878389D200D4E419E05AA@PH0PR12MB5420.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5420F1D3878389D200D4E419E05AA@PH0PR12MB5420.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 14:09:40 -0400
X-Gm-Features: Ac12FXxCLlWpB7SxsK8B173Hcg9lpAj1KugONa54WRcJ46Wx_zmzE606QYJLZfI
Message-ID: <CADnq5_MBSe2tuczKGwigygErxYUXg=O+H63NcnFnMd_C0qLwpA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "cao,
 lin" <lin.cao@amd.com>, 
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 28, 2025 at 5:01=E2=80=AFAM YuanShang Mao (River)
<YuanShang.Mao@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alexander
>
>         Since Christian is on vacation. Could you help review the below p=
atch?
>         If set job->vm to null in amdgpu_job_prepare_job, the job which s=
hould be skipped in amdgpu_job_run will be submitted unexpectedly.

I think we can just remove the amdgpu_vm_generation() check in
amdgpu_job_run().  I didn't think we actually resubmitting jobs
anymore.  How are we ending up trying to resubmit in the first place?

Alex

>
> Thanks
> River
>
>
> -----Original Message-----
> From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
> Sent: Wednesday, July 23, 2025 5:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; YuanShang Mao (River) <=
YuanShang.Mao@amd.com>
> Subject: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
>
> job->vm is used in function amdgpu_job_run to get the page
> table re-generation counter and decide whether the job should be skipped.
>
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 45febdc2f349..18998343815e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -360,13 +360,6 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_j=
ob,
>                         dev_err(ring->adev->dev, "Error getting VM ID (%d=
)\n", r);
>                         goto error;
>                 }
> -               /*
> -                * The VM structure might be released after the VMID is
> -                * assigned, we had multiple problems with people trying =
to use
> -                * the VM pointer so better set it to NULL.
> -                */
> -               if (!fence)
> -                       job->vm =3D NULL;
>                 return fence;
>         }
>
> --
> 2.25.1
>
