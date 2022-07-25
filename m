Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FD1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 13:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7026411B0A3;
	Mon, 25 Jul 2022 13:36:01 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E0414B396
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 13:35:59 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id t3so13995180edd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvrK94lGLpIbhCOdWbzjY4GCkQX4Bxfw5jfbcDao4T8=;
 b=DOOihBoan+j/EnmbVQBbEyMmfLYGy/ohK0hb0FZ5pJRNvWXJHISeU/ADZGpzT9LyLA
 0+NhenjXLYTMfZbfJfaEa+QCdhxJxaqbjk/BDJgM1kpbwpXbRp/evUrCQURvc7MO+EUp
 XFErxo7ZpjW6436i8ebXLq1op8IHnmveO3+p8feMam9oVdkjLvqHEMbfmS1CTy+gZPgm
 EBqtKR2TMkzp5kUaEUpD6hoyIG/ZPi6BPlZLr9ys3WtEUgxekBFePOXS4suhvr3e0GYp
 6ivmcNv0+jyOS5lxDynfW07hTEzzOnLPKg7n8VEZlMi/LOr2wjavO1k7PkYliWXCQzzC
 BlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvrK94lGLpIbhCOdWbzjY4GCkQX4Bxfw5jfbcDao4T8=;
 b=62ydva884GZ3P39UwrG4J0AfhAFO0uKyaFtnrr6NI2OvGUbTNuS5qi1K1UGckjplod
 2NE4/9+yn5dsgSABbR44x76hsiwWo9TKsWQgadw7yQ4HbZ5wumYET0LoxjaNIanIGjal
 0DsoVhuH4xBTKSg+ulmp/JstCUErh6Ji92DjwyN6FFNlCP+y02+awxvCLIjyiMU7kY0a
 VkubEO98h/iKJ3uAG/NpXcuyDdHh3yjGGEwhL1DRqMm0KvTtyjTe7dBazVY4ph4PFQyy
 sbIC0H/+cULLKMHvhDGQBGAoWNavAwfnAA4mZkbear9m/kfpWJzE2dJ+7ltUs3dMH3Sw
 az4g==
X-Gm-Message-State: AJIora/m4W14+ZVogGeOESz6fORqweaYYPVILhCOtga/0OhTdMgIWxzw
 Lvf5QBAYLFB00zdObbkuwE96766ganFj7TfCx7I=
X-Google-Smtp-Source: AGRyM1sr8dytd69o81SMZ9hX73I6iWZXjWLSW7wAG/1fadj6QiVuJNaQLlTNw+b6Rf8RdV+6QeFEWPxcSQk6ZBFvs2k=
X-Received: by 2002:a05:6402:d0a:b0:437:f9a1:8493 with SMTP id
 eb10-20020a0564020d0a00b00437f9a18493mr13426497edb.226.1658756158119; Mon, 25
 Jul 2022 06:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220722045646.106225-1-Roy.Sun@amd.com>
 <DM6PR12MB5534F34CAB5A844675A344D6FF959@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB5534F34CAB5A844675A344D6FF959@DM6PR12MB5534.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Jul 2022 09:35:46 -0400
Message-ID: <CADnq5_N9sfqf4GRUBC2XEBBvjwZLrR57DVr1KDVO1hYiNy-=iw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
To: "Sun, Roy" <Roy.Sun@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jul 25, 2022 at 3:29 AM Sun, Roy <Roy.Sun@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Ping
>
> -----Original Message-----
> From: Roy Sun <Roy.Sun@amd.com>
> Sent: Friday, July 22, 2022 12:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sun, Roy <Roy.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix the incomplete product number
>
> The comments say that the product number is a 16-digit HEX string so the buffer needs to be at least 17 characters to hold the NUL terminator. Expand the buffer size to 20 to avoid the alignment issues.
>
> The comment:Product number should only be 16 characters. Any more,and something could be wrong. Cap it at 16 to be safe
>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9f729a648005..187e3dae3965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,7 +1019,7 @@ struct amdgpu_device {
>         bool                            psp_sysfs_en;
>
>         /* Chip product information */
> -       char                            product_number[16];
> +       char                            product_number[20];
>         char                            product_name[AMDGPU_PRODUCT_NAME_LEN];
>         char                            serial[20];
>
> --
> 2.34.1
