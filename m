Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F37C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 02:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C2160EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 02:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7C2160EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3128E6E0D2;
	Wed,  3 Nov 2021 02:02:00 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3E16E0D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 02:01:58 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 x16-20020a9d7050000000b00553d5d169f7so1484048otj.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NoVjT6r1AMrVbOi2ZBOWNvFAv8l/Kxa+cbCDf89iuxs=;
 b=SiThYrQBu89cdoGhonPgXF4qlxiCs5W04uPGlvk7Wa1DY1r30BGkdX79WLRu1EG+0/
 k9erREE13/wTGcoBY7b8YsCY/ufnVY7LNbe3t2ffGGDkRu/glsEGzCU0YDlehV3YhkGe
 Physem84riCMVBImnEQs8C+NAFgJw5n5ZSYGHQQkMGTbSkJoi6QVlKY6v+YMKgrwBsEJ
 t1S3fTfmYFhU2Ibv8d01YoMyKrYEB/4liV5wm4tvth+zURcx25WtnUSV2BkDruwb1m8k
 ueiBemRCvyQ/D0OAGTQfL+CtJ9Pxp8cGUNj95WU8IaTuzkvRFLPqT5SC4b1GMWxyJWZY
 dNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NoVjT6r1AMrVbOi2ZBOWNvFAv8l/Kxa+cbCDf89iuxs=;
 b=yGgptpyY7KVbAXlM6UkH0V9RlxrIxHNeizPyvy2C8L8/m6l8wNj/4B7Iv7iL3qhVOZ
 pbk/l4B0QBi/03Gt2b729io36y1Ke0wD8zH3vdxoVFhy6+ykofomye84SMJ9DX4xwedQ
 9NbZ/4SZPhOiD1VeA4QuU22grGW6BB/ylKeCem1t0uXyVUaQ/86SFp6ZsIdzyEMribuW
 cQcyaiV0fcFkQQg4NdZ9ySo6oMmYauQFIplvY2MxhMl+dLg47IJA8+KwDJGzBVKfM2fX
 4xyDy5FLnUHCyRX6bUV7CLS/jQGxyrYYY8Hh8RN40l/2z05LVBzLpEmuRlEREitxmSmE
 fBKg==
X-Gm-Message-State: AOAM531cMbuqaPvEFbLMjekiJd3iQtu2Swg4IHuxG96Cqxufo8fn1xDh
 XE7SXBQ/E18vilfqJsIQFjnpHCTGnbh0Mj52aCc=
X-Google-Smtp-Source: ABdhPJwPYMqAbBFiKruMS6khUc9djK7+nbkTaaxdqR+qiYuSi4tHtvIeLL8WYdOt7QtNiVGHpP1LA9P1dPPgJVem1VM=
X-Received: by 2002:a9d:61d9:: with SMTP id h25mr30978895otk.357.1635904917686; 
 Tue, 02 Nov 2021 19:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211103013350.6015-1-James.Zhu@amd.com>
In-Reply-To: <20211103013350.6015-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Nov 2021 22:01:46 -0400
Message-ID: <CADnq5_OurPZjmq2SbRZzw4MWRO2uFT7H=+F75czmwgG0MgGAiQ@mail.gmail.com>
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

Once you get confirmation, please add:
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=214859
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1770

Acked-by: Alex Deucher <alexander.deucher@amd.com>


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
