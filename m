Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC597C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 17:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B02010E161;
	Tue, 27 Dec 2022 17:12:22 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2CC10E161
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 17:12:20 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id v70so12912357oie.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SL357caI1UL/x2zhaPumDoPpl1s1nwy/3Cvw92QMwWE=;
 b=plBufmV+UdWVGh9lMa4+Cfc3sCW5I0PEfXrBRgAsSsblY6aQz8vtSl1YVBnWPZKIn6
 /EZzIwCBtIE5KXpGoz1jCg3cmFbAF5sq1jD/QTmVN7MUkh4KwjPte15FwL4xFnnagWG4
 tK/jgYWa2701wsRVD5T3ejMuthMNCb8vcWgHjvb0j+Y/rJUyH1ne+BTheyeLzrNkrhvs
 emS1miP7p3OpSbX+yJLKqnp6EQGVUdsmef4hf8HavAiQWvfyRWsB3viyR5VCj/5oW/xi
 8VLF1iXSEaeQ/YsZqZW0WGPyhlcVDRGr8Gmvx3dazC/tEJQIJznuZY/kZsb8OBJE51AS
 TDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SL357caI1UL/x2zhaPumDoPpl1s1nwy/3Cvw92QMwWE=;
 b=ntozBFGWgA7p0DglJt7748pIuI7HDJv3fpBKBTE8xudrlEyVvPWU3n2t2iTDNl8i/O
 RjTBjZ6iQKvxZ88MisZ5FvEnuLXd/wqklKQ0hR/z//UNBZLWWE7baOCYBgIcAmNxskXt
 jrNpw6S/7DQLQg9yzsyf1mGnFu2Fvmn7sMlf/4melCtO64GQNhZ6GusL7R8QEUrtwT2C
 SGfWc3vgy3gbYM1xzop3rm2wUVWp2/bnXzjY2Nwz4rrSIGvRB9ShAE4GKee12ZEdJjeP
 bwWc1h4YrTYL/Me17p/h42bPUr77PYnNo6AVL8IjBQXn6jostMQjU0OJa3xRPp7nh2fo
 W1pg==
X-Gm-Message-State: AFqh2kqDnUJGgGPw+H7kSGaWUobljaXos6m/UOLDSCUpYfr1giaw5sUj
 HXL2w+sxEpjrhH0F9B2LcvbgzsI/N7mW8HIjDGm/2eUH
X-Google-Smtp-Source: AMrXdXsSxzDz/Q/Kuz1+43NUA2yyu+j+MJ9Qh803Pt58UQdrPE1y36D18hMm5M+XyVQWMx+xEsWQjrH56Gw7q9FDCSU=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr1415342oiw.96.1672161139557; Tue, 27 Dec
 2022 09:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20221227171020.106726-1-alexander.deucher@amd.com>
In-Reply-To: <20221227171020.106726-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Dec 2022 12:12:08 -0500
Message-ID: <CADnq5_ORmj8T83Xq08PLoHi-_zN4vZaXWpRw=Z4SXsqVEaZwGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: simplify cases
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 27, 2022 at 12:10 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> A number of of the gfx8 cases where the same.  Clean them
> up.

typos here fixed up locally.

Alex

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 091fc2bb8ce5..521dfa88aad8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -263,23 +263,12 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>                         f2g = &gfx_v8_kfd2kgd;
>                 break;
>         case CHIP_FIJI:
> -               gfx_target_version = 80003;
> -               f2g = &gfx_v8_kfd2kgd;
> -               break;
>         case CHIP_POLARIS10:
>                 gfx_target_version = 80003;
>                 f2g = &gfx_v8_kfd2kgd;
>                 break;
>         case CHIP_POLARIS11:
> -               gfx_target_version = 80003;
> -               if (!vf)
> -                       f2g = &gfx_v8_kfd2kgd;
> -               break;
>         case CHIP_POLARIS12:
> -               gfx_target_version = 80003;
> -               if (!vf)
> -                       f2g = &gfx_v8_kfd2kgd;
> -               break;
>         case CHIP_VEGAM:
>                 gfx_target_version = 80003;
>                 if (!vf)
> --
> 2.38.1
>
