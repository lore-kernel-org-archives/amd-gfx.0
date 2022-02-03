Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EE8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 23:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24F010E6D4;
	Thu,  3 Feb 2022 23:16:23 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C955A10E3BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 23:16:22 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id y23so6421908oia.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Feb 2022 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HogeXIdHRWsd6XAKxHsi8wvSlU4dTShMRmVW42UR3Os=;
 b=aCr3WOa54YlOr9RuHyWZsBdUaihdIh3OEKRT05se+1TeLJ5/UIQV2YWs9AqevXIDHw
 VH6WHhOuyMl1exL7eD79+tICoY5vlSaHU4JKvjPK3y1H8w346bnks/b1atNHHf2MuTbI
 epcTcGMvMLVJDoc/aI6GTt0qseFESAbiJeuDXMQXDXCADXe8fPbYK5HWjo5qeXyWeBIA
 2AZr8POM3lMR4tcw9OvuJ8guKpzHSr1EqzYXivPEgg0eASN2kLjfXgSNdspeiGtVFYLf
 G9YSCSUCKOSkK9u5tvyrHhKpImL+sGja5YyARqfnpw99TWoROTU5B4AJ5i05LVssJdql
 DOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HogeXIdHRWsd6XAKxHsi8wvSlU4dTShMRmVW42UR3Os=;
 b=5CwgQLm4WQ/z/Apd74W6kAxbE67r56rgVdpyIKXXUf89yRiCs7TznUzqNrLInzDxxF
 dX7cxSTIbXnFehV3EhL5I/1AO/crbN1uah46p7fxFJ4L27pF5cMDJFNboXKCrR+m7HeG
 HVYU7+r7lwPlaGGqICasQCgf4wbPOyukVb8VPPl53TBukcTx0LOPtGCs//wQeEFf2pRx
 RsM3YZ5KS3XLQhRFq5F5yJRuAPKF7rtwOHyj+1raNkgicGcXER9JNiLytABNysclf5as
 Tr2Z5YaycZDxdjR14ViBW0cF4Fq7BXuZc39QmaENYddFkZ3qZhoLTq3mkRy8EGmkZRKp
 VSMg==
X-Gm-Message-State: AOAM532OauABpg+PASwZL4y01kH/jfg7QbOPl1mBEwaepDz0Omm+Fc8u
 jg5nXVjl19WdVshl6XTr65ufWd9dbiu+t4Kd4zkyTFAO
X-Google-Smtp-Source: ABdhPJwVyDDwPDMwI3pLQOlJtW0IoE9B71N138gTXs4Kn8ZoXUsNgYCZgi6wfE70soS9LF22TzO/1TqOlMeSvHeJH+c=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr18028oiw.132.1643930182086; 
 Thu, 03 Feb 2022 15:16:22 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5144C64B0B4E525FC97EB522F7289@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20220203231320.114539-1-luben.tuikov@amd.com>
In-Reply-To: <20220203231320.114539-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Feb 2022 18:16:11 -0500
Message-ID: <CADnq5_PpfcHhEx+S-02SE0cL-SJPg8h6VGdXuKMud3CLC-LXpw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: Print once if RAS unsupported
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Tao Zhou <tao.zhou1@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 yipechai <YiPeng.Chai@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 3, 2022 at 6:14 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> MESA polls for errors every 2-3 seconds. Printing with dev_info() causes
> the dmesg log to fill up with the same message, e.g,
>
> [18028.206676] amdgpu 0000:0b:00.0: amdgpu: df doesn't config ras function.
>
> Make it dev_dbg_once(), as it isn't something correctible during boot or
> thereafter, so printing just once is sufficient. Also sanitize the message.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: yipechai <YiPeng.Chai@amd.com>
> Fixes: e93ea3d0cf434b ("drm/amdgpu: Modify gfx block to fit for the unified ras block data and ops")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 9d7c778c1a2d8e..e440a5268acecf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -952,8 +952,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>         } else {
>                 block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
>                 if (!block_obj || !block_obj->hw_ops)   {
> -                       dev_info(adev->dev, "%s doesn't config ras function.\n",
> -                                       get_ras_block_str(&info->head));
> +                       dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +                                    get_ras_block_str(&info->head));
>                         return -EINVAL;
>                 }
>
> @@ -1028,8 +1028,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
>                 return -EINVAL;
>
>         if (!block_obj || !block_obj->hw_ops)   {
> -               dev_info(adev->dev, "%s doesn't config ras function.\n",
> -                               ras_block_str(block));
> +               dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +                            ras_block_str(block));
>                 return -EINVAL;
>         }
>
> @@ -1066,8 +1066,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>                 return -EINVAL;
>
>         if (!block_obj || !block_obj->hw_ops)   {
> -               dev_info(adev->dev, "%s doesn't config ras function.\n",
> -                                       get_ras_block_str(&info->head));
> +               dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +                            get_ras_block_str(&info->head));
>                 return -EINVAL;
>         }
>
> @@ -1717,8 +1717,8 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
>                                         info->head.sub_block_index);
>
>         if (!block_obj || !block_obj->hw_ops) {
> -               dev_info(adev->dev, "%s doesn't config ras function.\n",
> -                       get_ras_block_str(&info->head));
> +               dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +                            get_ras_block_str(&info->head));
>                 return;
>         }
>
>
> base-commit: cf33ae90884f254d683436fc2538b99dc4932447
> --
> 2.35.0.3.gb23dac905b
>
