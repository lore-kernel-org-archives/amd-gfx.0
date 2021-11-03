Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FB060F9D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71FB060F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF857378E;
	Wed,  3 Nov 2021 15:40:52 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2367378D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 15:40:50 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 x16-20020a9d7050000000b00553d5d169f7so4046832otj.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Nov 2021 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wbD6izzNIrbYC0ZkCY3lT1l52A9QbQ3Br+Rv/RAbkbI=;
 b=QlXPlZEfr8OzSIKRUFWmj/e1h/Y24ObpqNmgq96E2QFTHzehzysFGuM9WVd1Pnp78f
 5Z1ZmCbnUsAGEQW3POkThZdUeJeF2rj1HYDsMACxTcaTSUn9V4LomhFJoUBreUiTUNgl
 25XtrC53Al3jwwRcDWf5rW1s9GZWQeV7IElz1FkPYwYfK14QXrS0O4zc2kXk+T/SpCdu
 0t7cHy/H4cdVgclcrKaXIc8GVDRUvbSZgFrCgQTNNWuY46bPLARAHTeonFpcXKcpYy2N
 3DeIvCOdufHhTvPGk4G39Yow3dKIJjLwKdDlc2CgxnKJDsB1d9xPbVbNB+ENRuq9uabO
 zOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wbD6izzNIrbYC0ZkCY3lT1l52A9QbQ3Br+Rv/RAbkbI=;
 b=5xsc4Wr2+X4kNrNHkbrXIRR0ZcVYdugWQNTdRezVdgLjSPTHz45OOay2JUz85QzKn2
 95tuOF93MwjJeuUVut6nj9oKDhWg004PTd3557o5o7yvthzOKAAVUEtGX7hKnxTDOWAz
 CRz7wR/PHObnJ+gOE4IshAHmGVddlD4gH0sd5NM/Hb+Ab83rKwSRSwbEiVgl49Foquyp
 N069hYosEC2xpN7kaGWDcTSGLB6xGM5Tl9gWil5t07qbjPibOgKUqb8EaUX4xoNYAEab
 0GdijDa82nWCWrJU6tfM6H5cEVwfmKhKh7DlBFZEw3Pbaqfar6Ct+SCnSMQ5SLga0O/k
 vjRA==
X-Gm-Message-State: AOAM531nT/oD4abnadeFHx8w5SjQR2mLSpu7SRTu7cC/2l6fgnr4/pI5
 TF3sFcCxo83IYCBUfJIW+Sg2bI3cN0T6xJL3wRs=
X-Google-Smtp-Source: ABdhPJwSRmcoNw79uZC8wg4PYpuFCZ3FHyNcznGvLlREHxfhpN1q4vfCMLR4HEy3agd3pKdiyqNaVatAeJoL5FEtoHQ=
X-Received: by 2002:a9d:2d87:: with SMTP id g7mr4182833otb.299.1635954050067; 
 Wed, 03 Nov 2021 08:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211103013350.6015-1-James.Zhu@amd.com>
In-Reply-To: <20211103013350.6015-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Nov 2021 11:40:39 -0400
Message-ID: <CADnq5_NaMWrjofG9CKAcey0PKwYobYmyXCbkCC73u52BBSD43A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove duplicated kfd_resume_iommu
To: James Zhu <James.Zhu@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, James Zhu <jzhums@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Ken Moffat <zarniwhoop@ntlworld.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 2, 2021 at 9:34 PM James Zhu <James.Zhu@amd.com> wrote:
>
> Remove duplicated kfd_resume_iommu which already runs
> in mdgpu_amdkfd_device_init.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e56bc925afcf..f77823ce7ae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>         if (!adev->gmc.xgmi.pending_reset)
>                 amdgpu_amdkfd_device_init(adev);
>
> -       r = amdgpu_amdkfd_resume_iommu(adev);
> -       if (r)
> -               goto init_failed;
> -
>         amdgpu_fru_get_product_info(adev);
>
>  init_failed:
> --
> 2.25.1
>
