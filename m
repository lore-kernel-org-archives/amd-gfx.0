Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613FCC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 13:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F9510E28C;
	Thu,  3 Nov 2022 13:12:50 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE2210E28C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 13:12:48 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 j1-20020a4ad181000000b0049e6e8c13b4so207586oor.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Gunx5KSf9xTRv8jAmxcGHyoc3WyrXw8EcjOPwJcG1g=;
 b=C/zurRRd1XIT3M3AKHpjgnVeH+7GbHy4oD11xfy4hmwttP3v/Jj7YjSEoXVaRNMeNU
 r0WrcR9A3GDfa9zSzhIF7xz8AjVSJE5zJY2vKyaToH5zUrfcy/kk0WJWIIyUOsMVrOos
 KCvNSC79QeuqsPtbM+KM1RTmWrplvzGJaWcYQmjqMe03blsFT8QI5P2YTZFTvdxBTp6e
 emARMaQ+GeNkDOQ6hZI0UnR1sV5of/FfwhAt4cOIajMqxc6DUp7ZHXYuuIuNhFHgdpIE
 2Sxm6j1v1xBhNQMRdnxJcXTK0h9H0iqo4R1Z+9ibkamex+SVFm7pzwH4wv+NKvKNuCHf
 5z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Gunx5KSf9xTRv8jAmxcGHyoc3WyrXw8EcjOPwJcG1g=;
 b=yITPhbpPbMHD+ch4lhNPevSjxWyjJtJt4PjVFTRRRXt264/ip3KBQB1bw4yhrDOQGl
 DOhW+axAc6Lim2X7MfQ0oINlHNVeYs67G1MQwnSbbE/5NGF303uiGj7lSRQCi46YPRzI
 b4OkWd7W3Nrv4IM0NKKAcXtea2jT6UShKB1u2xKI0dohWw84gov5DVu8huSD1/9IyvEG
 4wCCf8RsfgIY4YG1ED++B97DuuUsDAPDKD4tZAkgfO3yLppq9tJn16WYB1KObYnqC9mh
 zDR/x+F336325w9zdj/aser1Md8j7hJAm9zzdS9x4RcJ7c5wZX85/ZkiKncvZrtpEa4f
 JX5Q==
X-Gm-Message-State: ACrzQf3eem/t4thsn7R0CyoIghdRgTbrkeO1VTRDpBwJsJcNG08TWl2a
 sKJhLL2VTkBpP8604egKTcsSkD4hY/fWIlwmbF0=
X-Google-Smtp-Source: AMsMyM4IeeWiHRp2UWeAQk7lBHYL/74kk9T3o6WbtnbgH2FsgXx3fvcQgVPsj7S/uNBTX52haTmp5SxJnz9qw57loTg=
X-Received: by 2002:a05:6820:381:b0:49b:dee1:2677 with SMTP id
 r1-20020a056820038100b0049bdee12677mr7685380ooj.70.1667481167372; Thu, 03 Nov
 2022 06:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221103062056.2162715-1-Perry.Yuan@amd.com>
In-Reply-To: <20221103062056.2162715-1-Perry.Yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Nov 2022 09:12:35 -0400
Message-ID: <CADnq5_PWnQARtaDWDuWkdxUBq_OnvYwQYaU7YWBt3um_WZBwfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/amdgpu: add Vangogh APU flag to IP discovery
 path
To: Perry Yuan <Perry.Yuan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shimmer.Huang@amd.com, richardqi.liang@amd.com, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Nov 3, 2022 at 2:24 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> Add the missing apu flag for Vangogh when using IP discovery code path
> to initialize IPs
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 95d34590cad1..c1b1f223f3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2153,6 +2153,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>                 break;
>         case IP_VERSION(10, 3, 1):
>                 adev->family = AMDGPU_FAMILY_VGH;
> +               adev->apu_flags |= AMD_APU_IS_VANGOGH;
>                 break;
>         case IP_VERSION(10, 3, 3):
>                 adev->family = AMDGPU_FAMILY_YC;
> --
> 2.34.1
>
