Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2529C43217
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 19:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2561510E623;
	Wed,  9 Nov 2022 19:07:33 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D3010E621
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 19:07:30 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-13d9a3bb27aso19921142fac.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Nov 2022 11:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8OyLmtmYu3srxyssw7eCYUrnU4idKuCd7+kNIKkwABw=;
 b=Dq8Suajz5wcrSZEk4GtDXt6YBQePxxDLBaZfFIW7gSeRy7zOMS1bcfUoGLkif9bo/8
 pSiVjhWJGp3Xv+7m/Mrg8j96yQU+jgYJ7OgfbnFoe14xXFiMG/aYwe6MDXYTJTyNCY9A
 Wq26eI6+yyl38HmWv+eQB8BV7W7JLAfTbBo54/Heu2nTHb53YJGK539p4ufs6T1o/Uyi
 KFVPimGfFQD+ObwiYvSrP08OTaTtSX7e4D74aS+m3QJG2YkUfmyAdw9FCGPQWi39/ZzQ
 3lbMnPGRshk4eyAvgStQeTWMKPnupP8c9yD6JLinSWv2eOr7L42IS8wCzZAtMzeEPmFa
 QXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8OyLmtmYu3srxyssw7eCYUrnU4idKuCd7+kNIKkwABw=;
 b=oNA3XyAedkvTAgmstkTkG55+lHVP0boMUpCbEavGLjFe1Fpe+3GVPXLNyAW06JH0HP
 P1q/QCtttriGM3DAD3mh9770C8F+MuDWVkJBv2LCKAIceOtbhPaNs4n0ItjpDAoI2AX9
 +CsmeQigl3+Q3FOUrjVXI0mbJs7L/BLTsnRc5ZjE94LrQonl/DJZpYIcDRFbvV9EQpnS
 3UY32Bo/Uii2ertMZEZQWCTa96L612w+uIXlCgn39/zr/s+ThtEhzkf7Zh5pjOLgBrkt
 h3LrKN4T30FwyPuXzLxjXVa2I55C6NnHD+wQfYOosAu3aNfUK0C/z+0qkZTCAf2gg/ex
 j+lQ==
X-Gm-Message-State: ACrzQf0adPTAV+Byz+mP8G4xuwbObiBomSI9nevvLvwGPUB+bn2rh+Jy
 Vr7SvHWvvdqcngIgd0qBhEaHb39/HqL61OLtKiU=
X-Google-Smtp-Source: AMsMyM4W73vM67AzU2zNJdV/8/V4c2T4eqnlmiY8CNw6et0dGIcX9zkKGB/kjXyQx4gpLvzW8znI+klib+rfle56NnE=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr37078874oao.96.1668020849736; Wed, 09
 Nov 2022 11:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20221109182422.21924-1-Gavin.Wan@amd.com>
In-Reply-To: <20221109182422.21924-1-Gavin.Wan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Nov 2022 14:07:18 -0500
Message-ID: <CADnq5_O_qeNZDju-uffzfZRYcgK763atyOt2ZCQ7s-f9tE+t+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.
To: Gavin Wan <Gavin.Wan@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 9, 2022 at 1:24 PM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
> For SRIOV, the guest driver should not do stop rlc. The host
> handles programing RLC.
>
> On SRIOV, the stop rlc will be hang (RLC related registers are
> blocked by policy) when the RLCG interface is not enabled.
>
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: Iac31332e2c958aae9506759de1d3a311b5c84942> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4fe75dd2b329..0e9529b95d35 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1517,7 +1517,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>         }
>
>         if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) &&
> -           adev->gfx.rlc.funcs->stop)
> +           !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
>                 adev->gfx.rlc.funcs->stop(adev);
>
>         return ret;
> --
> 2.34.1
>
