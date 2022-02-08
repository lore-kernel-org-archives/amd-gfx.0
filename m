Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6768FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 14:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BFA10E4F9;
	Tue,  8 Feb 2022 14:44:24 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2018A10E4F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 14:44:23 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id ay7so6800059oib.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UkylBt8yc1dpWHcaSBNp31nM7sDPsszm5V59/djiX14=;
 b=gMIzpeaR/KLgG3uZrQ61dz+tELSf5MxNZjNz+dcujWKAWKHlKChtQPwvBF/wDfPjnW
 GhOdCL6vIk3vrzNyY1uv4CzHbOZWSTatMPGXSzKQd4dlQTb0Fcdkh8Se1BwnEmSb7U61
 +FJLLbS2EzvhGarcQYoconH+9iy9qM8BtuThxTOyYJmMBIk6GqPXqd/Q/Wiv57RS/77N
 NzQxO8QkrRZgkDVyP5kxV7OG0nzICPebRzbpVcYi16El2KIoDT7kYgomiGTH2rAJJrRr
 kwJh8Ycc0nmZ8EkLU6tkDvw6JS695n3h5FLOanJwQGh5WN5UhUWMxB38yjjdQswq8Fh3
 VVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UkylBt8yc1dpWHcaSBNp31nM7sDPsszm5V59/djiX14=;
 b=Kzor6/fFaudzJOPwhqwhVBkYFc0XEW94P+7q4mbJ4F1U02nH1mOK8RwV4z9AeW/zcK
 XwdeYGPUmX+DkCmabMqmDyuhScXAf42b63KcjwMmTZsnpkI8+KIz9MfyNwHyt88JInq9
 8imxYEqHVFmW3ICMudqWQcMLUj7q1mfiowSPcKjkV3VplH1jT1qlfgzaUouCQXQXukHf
 jR5k1tylF2Ydvy+QJGtAqSpL0jYzxHIM7UAhgCZKHkzBN8lB2e9MRtOrWgXzf/ieziq6
 55wqsnMaeBJ0hlWMIuK76ukGb/uvQUF574LqLRGENtufeZHr6ZclmxNyQzYHNvNbzLb+
 iMtA==
X-Gm-Message-State: AOAM531XLRHbkBDJwinQ7cDa0Qu/L+2hWtw/Bz1WgZ9+EnlVAaoXB0uG
 G1yCrLgC5tXwFgeorz+Zf+DxV88KhWuInWa6V9M=
X-Google-Smtp-Source: ABdhPJx2YmUL7vHkCm7wxOwA7L3gHepyW/BS6nFglrhF1EXPk2U6cpyA1MbnnDwrsjcnhjWkEsIckYz/nEUKv/sSvWY=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr653729oiw.132.1644331461999; 
 Tue, 08 Feb 2022 06:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20220208070828.337043-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220208070828.337043-1-KevinYang.Wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Feb 2022 09:44:11 -0500
Message-ID: <CADnq5_MRzfEKQgfdfBgXzXzsfEb3_vdjoarX7jMtObnYcSv15w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: fix hwmon node of power1_label create issue
To: Yang Wang <KevinYang.Wang@amd.com>
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, "Hou,
 Xiaomeng \(Matthew\)" <xiaomeng.hou@amd.com>,
 Kenneth Feng <Kenneth.feng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Feb 8, 2022 at 2:09 AM Yang Wang <KevinYang.Wang@amd.com> wrote:
>
> it will cause hwmon node of power1_label is not created.
>
> v2:
> the hwmon node of "power1_lable" is always needed for all ASICs.
> and the patch will remove ASIC type check for "power1_label".
>
> Fixes: ae07970a06 ("drm/amd/pm: add support for hwmon control of slow and fast PPT limit on vangogh")
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d68e7132da2c..d6c01c59f32e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3288,7 +3288,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>                  attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
>                  attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
>                  attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
> -                attr == &sensor_dev_attr_power1_label.dev_attr.attr))
> +                attr == &sensor_dev_attr_power2_label.dev_attr.attr))
>                 return 0;
>
>         return effective_mode;
> --
> 2.25.1
>
