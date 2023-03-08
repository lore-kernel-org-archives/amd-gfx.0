Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA36C6FD1E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 15:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B7210E12A;
	Wed,  8 Mar 2023 15:19:12 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2333610E12A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 15:19:10 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id be16so5688810oib.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678288749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2g76tWrTfwNqxONd6SVxwxzWqwtutO8i0Nci4fbT49A=;
 b=J/pBegGx5yq+pbyT+r5kR3GP6z8V211hALinRgscyMgMeAmJ4r401a8eud+4pxaHih
 +fZPJj94H024gVN50qqMgGmsmq9i1g+mAgm+MwEaUsZqLf1M1GIM+nGL7PspsoVbV2br
 7YHNZP3q0tTXjyBEeUECRJJjLgmaMWobkJYSpPWgx67UtRaNVpJFMtUta9+iiDpl9RyO
 GRIVQEQdd1/0RSYmp6CzHvlKlTjFHXnj8NnF6tPRhDlaT6ORBSGZlKHvehU2Xxjcpmdk
 X0mdhRezFvFMjHMt+CKL47MOrMqJ7ucgnOo/w7U2s/Y80mKlnIZenbthUMd528RCY8Ht
 OTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678288749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2g76tWrTfwNqxONd6SVxwxzWqwtutO8i0Nci4fbT49A=;
 b=gFA848hseJQd4s7p/Fy87jUi4jib/HRz+voJYj7tJOzV6o27G5A53+x8U8ZhQAiAob
 I/lOL+t163vWVGCkRjdIb3xz4LKr1roffHlfDC/DnV1XM8SIa82ZEYdGPrJzznnepURO
 hi4jGDhvQ6WR2Yf5GrLn5aU5p3dpe38lWrGRYSwBj7RxdHd5biqL/ko/nKASQ9rPdksc
 zMozSLQPIX8dgfb/fKw2RkkSn4zyXdoyodt+nyaAUOfqc4d0jYHPn2VBKR76GlsPdVMO
 BoUo6qib7f/lx29jECYSazHr4NRKIa48vncLOlaK9uSwZZqO7d6cpaKSlTt7oWXU2Uqn
 NnKA==
X-Gm-Message-State: AO0yUKUI/eqEzwJEyQVqBoen13FHmZoUsXDUewvcAsObn3ehL1weCAmY
 Nh3yrS7cBsU37xpDAX3qcu1n9ETTrASvUouV548=
X-Google-Smtp-Source: AK7set+lvUqx/+tk7seP/njxL9zMezJjhvEETh1ysBsI2Yh9ETqznArvfBSyTQu+OqO5Mq8pOSJWYcYGoSb9Rrt/gs8=
X-Received: by 2002:a05:6808:354:b0:384:692c:56c9 with SMTP id
 j20-20020a056808035400b00384692c56c9mr6047607oie.3.1678288749360; Wed, 08 Mar
 2023 07:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20230308145817.717169-1-veerabadhran.gopalakrishnan@amd.com>
In-Reply-To: <20230308145817.717169-1-veerabadhran.gopalakrishnan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Mar 2023 10:18:58 -0500
Message-ID: <CADnq5_PTB9hrOWp=QLwVCbZz_MS-fYmmP+v3n62NSo8ubs1Udw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc21: Add video cap query support for
 VCN_4_0_4
To: veerabadhran.gopalakrishnan@amd.com
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
Cc: Alexander.Deucher@amd.com, leo.liu@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 8, 2023 at 9:58 AM <veerabadhran.gopalakrishnan@amd.com> wrote:
>
> From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
>
> Added the video capability query support for VCN version 4_0_4
>
> Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 9df223600..061793d39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -111,6 +111,7 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
>         switch (adev->ip_versions[UVD_HWIP][0]) {
>         case IP_VERSION(4, 0, 0):
>         case IP_VERSION(4, 0, 2):
> +       case IP_VERSION(4, 0, 4):
>                 if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
>                         if (encode)
>                                 *codecs = &vcn_4_0_0_video_codecs_encode_vcn1;
> --
> 2.34.1
>
