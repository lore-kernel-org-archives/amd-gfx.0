Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C786C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466A46102A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 466A46102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C399A6ECDB;
	Wed, 10 Nov 2021 03:03:02 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124B06ECDB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 03:03:01 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id n66so2524194oia.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Nov 2021 19:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JkomUqZUrxX5RXzUdGc7diObXwShiUd9Xsji2Ukq9g0=;
 b=S+rjdopd+ImHAJ2hvBAZnaSbHhDo/Yhspv1wEfLpL49ia6BCzt3CeUQbFPfs7OOUxu
 MoMrueoKhGitvd0yMzie+cBIOpX18o8gvpmM14MLHCgXdxcuZMOskS5rMQ7CVpZzo9hK
 lMBqsuWLj0vHn4Ucg5e6lxZYVPCkE+LVY0d6BTFIGdBtUfzlGPG0DbVtFYeK1uN8oA0q
 KGoTmKEyTEFpmcLynslsWyFliilft1A8gdIWRMFIXuUsJpjPa+LcpSiED7uI0+k492a+
 sU7oo7Ys5VEu/E4EdaDHaNPYCa2ZZEbkjpLNzGEuTVL+zPeen4N36qlboUuGQtonL3ZM
 kmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JkomUqZUrxX5RXzUdGc7diObXwShiUd9Xsji2Ukq9g0=;
 b=iyGSZzYif1Rw8PJBxUZfiLRUIWAvf/B6/JkShRHfXYgzxf4jbySbzAPpEaamOXkGLj
 ijAtpHhvv9O/florIH2cLVnY5YvLnA00kYAAV1zF9/FqPAUdHFqsl2jSn/oQrO+BVsdE
 JG+spQlOUaXb97hYe4ALCg3WA2OgfhpoWbExQuyerOvtsXdOuEnATiw3hd8asuYsn3m6
 I/A+DW/Z74dqgggsN9u0GKTRyuvjUD0NKslqIzLYCPbvicukiO6E/5JoCFX+JjFfRUkv
 dHKsZcMuEwe3j7cDl3zH8SHTWnYesJLOCeLP/G//JCzNCTSzjBJ4Bcor3Bv7znPuzbS8
 mbGQ==
X-Gm-Message-State: AOAM532wb2kkbcPyXTvreMEMBnHtN5dPrqEW01TV9QgOXXjetCq+3iVO
 L3LXHb4yBgCYaCxY5EQcYFvl1K8VwE2FxD6jys4=
X-Google-Smtp-Source: ABdhPJy5hF7oPSVy63d+HXQgFuGpuoqRvEYj0cHgcI0N0GRVJS8WV8KnOc1VCQxMPridfiwpL/JgZwNkTl/cKtRc9dM=
X-Received: by 2002:aca:e08a:: with SMTP id
 x132mr10068822oig.120.1636513381038; 
 Tue, 09 Nov 2021 19:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20211110021337.27171-1-guchun.chen@amd.com>
In-Reply-To: <20211110021337.27171-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Nov 2021 22:02:50 -0500
Message-ID: <CADnq5_ObnSaf+dCnSu82wN_AOcW2LHD6KcBRP+4a-FZfXVGv1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop jpeg IP initialization in SRIOV case
To: Guchun Chen <guchun.chen@amd.com>
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
 xinhui pan <xinhui.pan@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 9, 2021 at 9:14 PM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Fixes: 67a765c6352d("drm/amdgpu: clean up set IP function")
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index d7c8d9e3c203..a20d21409c95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -867,7 +867,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                 case IP_VERSION(2, 0, 2):
>                 case IP_VERSION(2, 2, 0):
>                         amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> -                       amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> +                       if (!amdgpu_sriov_vf(adev))
> +                               amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
>                         break;
>                 case IP_VERSION(2, 0, 3):
>                         break;
> --
> 2.17.1
>
