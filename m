Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158FCC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 16:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9843A899DC;
	Thu, 17 Feb 2022 16:49:35 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B274899DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 16:49:34 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 u47-20020a4a9732000000b00316d0257de0so238848ooi.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Ak8J2lfIkTj6OgGGZbJVSzhEA6GuV5ZpORtuVPyDlw=;
 b=mE4j3C7CUuvVxIgr6DgV0BuFU3Gv2uy2ewy0aGUhkIwPQkdQFzuRgI22BqQttrdAc9
 2fopfflw85bHlSV75HzVq9QaNzJw/AheH3Up8iB2OqZPqN86nGY/2YAhxFTyJvGWGjq8
 IUfo5m8IVxQ7CuSOPEpXwh82MWFReK9u0Yx3L7GHuQ6s+b+uR4WXvC7KwV42cIlo/qyJ
 pKDXSMvWlgHOkprs/8l9UagKpAOUSskcxJPaRok9fOYOblPWOANC8o3l/FbqGImwdkXE
 TUP7dXiZhHmWepihv/LJ7QStfWtmRcxvWLTuJGOY1RtKX58o23ILy2L9dN7K/Co3pVgW
 cUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Ak8J2lfIkTj6OgGGZbJVSzhEA6GuV5ZpORtuVPyDlw=;
 b=13rbMGXYpBWN2awhyhFTkeKhoId3sKygUP3Z2soFMiCZ63HL87iAUV/E+8gtRK7oUS
 c2BUPL2bs9BwBv2Aap2Sn1bikkIGX2V5N1wdoL1DHgIXXJH4A3w3YYnzf/R1r9skdwF3
 HG3EzTuxBRWwYMj9LLjfEpxkvvoEai6AUmwvQzrll62ve5FiIeHEsDA+tlnEXg63qSqC
 KH4LWRP1AcnCiIQTxiijaPsyWlnwX64TnJa+/S2cecmEg9fw9m4Zt2VVxPu3e8WZOlac
 kJBDdaciVnzhMEch4gv9BkQP7LqpNEXeJzmbBRarRZ8NVaqtGfdp9kkBOgvhUj1lwldc
 P4Pg==
X-Gm-Message-State: AOAM531mjbSetZnCXp6pW7jl3MAthvSPRo4w/g06xfYUTfQr8J4mWDFp
 1PAQfGiOMYGeQQT/Oqx24qVq6su0iwVpAnyht/ZzM9ff
X-Google-Smtp-Source: ABdhPJwQbSbG6YMV4bvMoa21TL7ObNJDXraP7XyLS1H1FsYEvXrR+9bw9RC2is5JsQOp5n2dPfvbYmfb9B8qBZV1e/I=
X-Received: by 2002:a05:6870:912c:b0:d3:44be:7256 with SMTP id
 o44-20020a056870912c00b000d344be7256mr1396074oae.73.1645116573838; Thu, 17
 Feb 2022 08:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20220217163556.6491-1-luben.tuikov@amd.com>
In-Reply-To: <20220217163556.6491-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Feb 2022 11:49:23 -0500
Message-ID: <CADnq5_OFoU=kDLdL_QUjRQG32hPHrHEuqyK3-zUz-asrznVV+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 17, 2022 at 11:36 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Dynamically initialize IP instance attributes. This eliminates bugs
> stemming from adding new attributes to an IP instance.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Reported-by: Tom StDenis <tom.stdenis@amd.com>
> Fixes: c10b6aa7417b0a ("drm/amdgpu: Add "harvest" to IP discovery sysfs")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher ,alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 6c7ec058125e1d..5848fec5c39251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -482,16 +482,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
>         __ATTR_RO(base_addr),
>  };
>
> -static struct attribute *ip_hw_instance_attrs[] = {
> -       &ip_hw_attr[0].attr,
> -       &ip_hw_attr[1].attr,
> -       &ip_hw_attr[2].attr,
> -       &ip_hw_attr[3].attr,
> -       &ip_hw_attr[4].attr,
> -       &ip_hw_attr[5].attr,
> -       &ip_hw_attr[6].attr,
> -       NULL,
> -};
> +static struct attribute *ip_hw_instance_attrs[ARRAY_SIZE(ip_hw_attr) + 1];
>  ATTRIBUTE_GROUPS(ip_hw_instance);
>
>  #define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
> @@ -789,7 +780,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
>  static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>  {
>         struct kset *die_kset;
> -       int res;
> +       int res, ii;
>
>         adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
>         if (!adev->ip_top)
> @@ -814,6 +805,10 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>                 goto Err;
>         }
>
> +       for (ii = 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
> +               ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
> +       ip_hw_instance_attrs[ii] = NULL;
> +
>         res = amdgpu_discovery_sysfs_recurse(adev);
>
>         return res;
>
> base-commit: f736148ca7bf82654141a4411409c2d7a9e2269b
> --
> 2.35.1.129.gb80121027d
>
