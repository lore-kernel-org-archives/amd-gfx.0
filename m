Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F50C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 13:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E603810E104;
	Tue, 25 Oct 2022 13:21:25 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9FF10E104
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 13:21:23 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id u132so1054073oib.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yfrIO0mOH+sd40sYfDiQXUmNkWQjPrXHtNzjJOtodbY=;
 b=EU87trjORuaSvibX1WlZOT+rUt9kUSSV+v3ztsw65PWzzs+jErONyTYC2iHXWULIWM
 iOgtI72rksicdyZVCtEcJn350Ws/SOa5reHT0yHTeu3Xt+IluwqqIwh750snu4i9UoZV
 WKlog+5yp7g5zhtUZEn+/kHVP8Rwk5L3dXJFYhDzaEsAveqJFzpPc+DwZDnpnDMvsLwB
 8Ry82XU+tIXti9GWU5gfUqu/8AlhJIR5rTOwip0RAZ9+9jb/TSxtEgRMSNnTKQdxlhjN
 RbO7wgW+/2lAaDPFSLVHqBSvnwJKGQV8srVofHqOZ/xZPMIMUkYu0VQ+YBtxAfbgufxS
 B9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yfrIO0mOH+sd40sYfDiQXUmNkWQjPrXHtNzjJOtodbY=;
 b=A/LiVIpM99tspftJmKxjp/PrXTW+0+IqEh2yuGNS8zvgAZjtElY9gmb27cfBUCj9Oz
 /WxCx4lVe1jqeLfbPTuBmA5q238VWaBR93KiAqkKMfOZRRULqurKDxga+JyZLmfRmplx
 G3KkAvRX22Y56fXOl5drBvdEGHMoApjAdJ+ZQDpZLRcfeq40KRdVsMxh1rb/9n4tftJY
 ZsNHE2XM+mIUfLqRn+s+NPgZWzN0ioeyDsStHR6ZWoh/hLzwVsI0eskFmxDO+mxbC0Jc
 qDo62VtiPVmks/VmegeuJF2QGoiqQOBBif4YrndmsXAH9G20yJ8Shm81LWhc6gBWCiEH
 DJ6Q==
X-Gm-Message-State: ACrzQf0ij+F6apz/+OCTpkifBmmEJ5HVxmzy78bV2hKvp0JpQoXzpGy9
 T44vZfLuJWwNbZ+QxOyydWX0NOtdjIDkatadZGM=
X-Google-Smtp-Source: AMsMyM5O5GdzE044MWBGV/2GeIl4mdEeXzCwwXJ/L3ZtBSXaOdfzoNpkuNXsTuh1zalRM84V86FHIyVZBXlwtbM8PXY=
X-Received: by 2002:aca:ac88:0:b0:355:200f:b5ac with SMTP id
 v130-20020acaac88000000b00355200fb5acmr27107894oie.46.1666704082931; Tue, 25
 Oct 2022 06:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221025090547.1571171-1-Yifan.Zha@amd.com>
In-Reply-To: <20221025090547.1571171-1-Yifan.Zha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Oct 2022 09:21:07 -0400
Message-ID: <CADnq5_M1Mx_bDNj5fhmNaR3-OuQQro5Jz40uBfDe8KMEHDZPKw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip access GRBM_CNTL under SRIOV on gfx_v11
To: Yifan Zha <Yifan.Zha@amd.com>
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
Cc: Alexander.Deucher@amd.com, Horace.Chen@amd.com, haijun.chang@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 25, 2022 at 5:06 AM Yifan Zha <Yifan.Zha@amd.com> wrote:
>
> [Why]
> GRBM_CNTL is a PF_only register on gfx_v11.
> RLCG interface will return "out of range" under SRIOV VF.
>
> [How]
> Skip access GRBM_CNTL under gfx_v11 SRIOV VF.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index e3842dc100d6..1330768df0b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1626,7 +1626,8 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
>         u32 tmp;
>         int i;
>
> -       WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
> +       if (!amdgpu_sriov_vf(adev))
> +               WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
>
>         gfx_v11_0_setup_rb(adev);
>         gfx_v11_0_get_cu_info(adev, &adev->gfx.cu_info);
> --
> 2.25.1
>
