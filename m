Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7AAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE6F6E88D;
	Wed,  8 Dec 2021 19:44:36 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E3B6E88D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:44:35 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id u74so5504355oie.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7ECrupbMHTPE+1nRLDFA7DADoN+yGQTgbBNQe1Fpyyg=;
 b=H09wUMpcVX20dBR5eyB1s3OjZ9Mil3mvRZNUrcyfI1pb91Z4zvD+OrUmk8HZgs/1ND
 urAs+JNgA1dR9lpoxHgT/GxNCBusyxWJ5cov6Fn9vXdn4pLJRRYOJ0+GxYntNhsKXi0z
 hwfbJOyHq/9oVIcuGImP/Ct3TX3qqZXhsEdUfQ1cz6ZPxsUN0ygZsc9h2C80LOLC540L
 qd1jc+IjPjrwnDYjWGQt8oBeA5CnliIZwfGxvb3IRybkRNDdKplMXLCRBSIezAE9epAj
 K+LR1CLsTPi7HDgopDr2lVyE0LOB0D1jy00i9E4bDcKzs2Cq4UFRRGGTa98IyavAEQJE
 bgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7ECrupbMHTPE+1nRLDFA7DADoN+yGQTgbBNQe1Fpyyg=;
 b=F6y3Ip7vgorC56BGbkL1u0l/uxPIX7J/Xs2N+pDrpDm2TXkZRolUv1xknXtVh8dQ6U
 0EHZX3UHHGAexUenppGA0/2rnzTymDmLDiPxDmoCvVA/LquC1hmgSM5nE/ltFan5ngsa
 FefCXDTo3fASlmdjRmuYIkdWKv4RKH8Uz/+Gldy3BgMVWQikdzzxeJz2qjhXxBqvZ8FE
 HsyBey713bKdnw+Hl/hUG38TTY2dkQknlq4n1oXnvEUfYet8b3pHWn3oBmW0y3Wmzx/h
 Gjn3JHRR2G5MrtqTeBp1IC8PYzfw4QxZ58lRMkWHV4Q6IPK5hy9h9DzjAce093qNOJUk
 tdtQ==
X-Gm-Message-State: AOAM533EbYnUWRdgRUyYdhOHuevs5PoL9LzdzBKXnRJ7Dzy4X+5ORqbL
 1zHtvD18KRmQQDK2ha4HCKgQgcp0/qPrFONgaA4=
X-Google-Smtp-Source: ABdhPJyDpt89Mc+N2MvL5/XrG652g2wdSgoCb8ZF0CdRi6H35sDGiUVIpjdafttt5E8b6JDh7hn4gj/T9bRY0XxO3w8=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr1400662oic.123.1638992674208; 
 Wed, 08 Dec 2021 11:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-5-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-5-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:44:23 -0500
Message-ID: <CADnq5_M+c4V5J5ardBKzdXc-DywqjWQDV8HaNYQ+JNJ4nmwGKA@mail.gmail.com>
Subject: Re: [PATCH 04/10] drm/amdgpu: fix function scopes
To: Isabella Basso <isabbasso@riseup.net>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied with minor tweaks to the commit message.  Thanks!

Alex

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote:
>
> This turns previously global functions into static, thus removing
> compile-time warnings such as:
>
>  warning: no previous prototype for 'release_psp_cmd_buf' [-Wmissing-prototypes]
>  521 | void release_psp_cmd_buf(struct psp_context *psp)
>      |      ^~~~~~~~~~~~~~~~~~~
>  ...
>  warning: no previous prototype for 'amdgpu_vkms_output_init' [-Wmissing-prototypes]
>  399 | int amdgpu_vkms_output_init(struct drm_device *dev,
>      |     ^~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index af3a2f8c12b4..96895cccf9e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -411,8 +411,8 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
>         return plane;
>  }
>
> -int amdgpu_vkms_output_init(struct drm_device *dev,
> -                           struct amdgpu_vkms_output *output, int index)
> +static int amdgpu_vkms_output_init(struct drm_device *dev, struct
> +                                  amdgpu_vkms_output *output, int index)
>  {
>         struct drm_connector *connector = &output->connector;
>         struct drm_encoder *encoder = &output->encoder;
> --
> 2.34.1
>
