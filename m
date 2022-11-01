Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE1DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 13:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44D410E06E;
	Tue,  1 Nov 2022 13:23:34 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BFD10E06E
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 13:23:32 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-13b23e29e36so16748385fac.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Nov 2022 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g7gnpnG78Z6+Hduel7LE01gMEpf5wpz4BDoE86wNIz8=;
 b=HtgX27oi/kMItTCgQ/CL3eGvcOYxpsUl+BJsafZHNxXGr8SREwA0SmbgaxBZ7Iy/1u
 y2HGC93BxhPgQal18JMvVCWhbfY7nOuk5ft1MnKajU8A5FVy1DHJm3x3a0yvctd07DPG
 BQqdHubzK8NUB83OQ4rpPkAB3ST+nNpa2XSczRo/FpHx1GH5q31MidgbGUj1YvpUBb+D
 T8NWENBdZvnCLHpcSlLRJMxTaLv1I38eBIakMwvoor9RXE2Q0JdK4XzIiqK6hEI9AsH+
 pGOOdVSFj0eTnbNYjqJil5Qcy+cbnyZDG6pK7ArzENcxHiydUXxXM3LMmr5LWDZUoVLl
 ayDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7gnpnG78Z6+Hduel7LE01gMEpf5wpz4BDoE86wNIz8=;
 b=HYLu/Nl5zIGYRLTzzQh1so4VY7n4Xu5ZoDNXJ3fN5s5qsmLrI/h4GE7ukDsn7LEdPR
 mJKyGlPMoQ4PJsN58CTfZJwdQTNhsqjkvn4BfDQicaZ62FVsgFmVK9KUujDmFl+SqP7o
 1UKZJGthqyFKm4lAThDvoxIQepiBm0ORIuRHlK0jLgur1Mvu6y6fmDNDlZCPoRLfagBY
 7k88EpaZ516jE8EeilCpyS/eZiTh4P6cNfciEnXwPwaif9MDKnZYFHeMfepsKzoqFGrd
 KWcOaC2+REEhNu137cSqfBe2zASmiNjZgKd0YOugLegEjO78gdw60LXKdcAlssMnODhe
 HsTA==
X-Gm-Message-State: ACrzQf37Fp7rfZq/w48YuLxWw6Rx1KtU5uflMrUgZihrzFDADPs/eCt5
 f6/HqvRdfbeGyFPSd6SFXl0hOTHDU6aLWSVO9Nk=
X-Google-Smtp-Source: AMsMyM6T2m67uMJVUT3tS59XDNBAVpmZXxFOjG6yMfVohITcdaiqHSYAmB3Ey6IlPnYl/7Qk2E30capAkhgrk5jI7fU=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr11210157oao.96.1667309011319; Tue, 01
 Nov 2022 06:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221101051450.1261693-1-Perry.Yuan@amd.com>
 <20221101051450.1261693-2-Perry.Yuan@amd.com>
In-Reply-To: <20221101051450.1261693-2-Perry.Yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Nov 2022 09:23:19 -0400
Message-ID: <CADnq5_M-Xa=4E5M8HdBrYnd4CT2cRabwJ=2kNrBTbFj81ETdag@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 1, 2022 at 1:16 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> Add the missing apu flag for Vangogh when using IP discovery code path
> to initialize IPs
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Swap the order of the patches.  With that, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 3993e6134914..52a92add12ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2161,6 +2161,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
