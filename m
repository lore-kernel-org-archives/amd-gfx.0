Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B653C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 18:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF18222B3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 18:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF18222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4369D6E50E;
	Fri, 15 Jan 2021 18:23:10 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5DE6E50E;
 Fri, 15 Jan 2021 18:23:09 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id p5so10501744oif.7;
 Fri, 15 Jan 2021 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tpWBTznuZUcZAzRcrI6A4hvRemlBsfvV9VTskIiTxqs=;
 b=r4ItQkShTWFZzgNdjP8hyF+E54DMf5V43oiwMlZk8cSAA1/Yy5b6ThpPrkNw/Q0MOC
 31DpJ6w4I5eniQaODuloEV3I/wKF4nNROthpuHi/DUl6SqGtT3sFp7EDRQ+cciiH6DJa
 E+P74Uci89IOAg597D/E194PQsRxCA4dHfL2R1ta4NYV+XR5Ta/pGBGdvPG8H/q7vdNO
 ggStMgkohzJMTm4aBIKpzA4zbCYjStOH8UiUpy1LoWdmC+AOrLJtV1WJdfEBjSyZNjXo
 Ey/aFoHcSYqWs382PaCyuzb9uy6K6lvtw0HLUFjDK5fq5mz3WdrWYJzSCRJR18SK0tFV
 SAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tpWBTznuZUcZAzRcrI6A4hvRemlBsfvV9VTskIiTxqs=;
 b=OMP93b04fYzkt7/tXZCLG6u9VKNAcgcvCfSCBh+RFDMWbURW5wyo2xEcQIPJgkyjDX
 YSYyHIRXFLg1T0a6FQvvuR32euE5XpYa7VOis+HwUa/9+r0+tiIJUZ9YCuZDX2arZIPl
 oY37s7Udyzyj7kRrWuDeemQ8zMpLn1Ey6MTNUmD7ZxzUA4HKbyXOe1KwyeopngjeLhaX
 Kvta2MKcUc1FCxtpyalX3yQ/zOqNfi+lFZj6e0SZDq3DnWGfGsYhHarkm0xMWXpoeZMd
 +QkcWMIa7wv9Oja/IUi2lxK84sOm2cso/Mv6O6mEUYsui1VDD/H+4HmsdHya6Zo9tNGL
 g4Rg==
X-Gm-Message-State: AOAM53384wdx/h0rqM3el9E2u64QlacI+x/QuEE0iK5z38NKggfET4m5
 wXuH22pJP4Jzh5HYon9KnwzNV0Zp6aCGG/Od4WY=
X-Google-Smtp-Source: ABdhPJztGGkhnXM/NF2imQJbEBr/K/vQ1PEj3u+KGHvjd0QNy8GJX1MVCyD1SYKE37RrJO+k2Tt/L+DnEGv4YL0gnuk=
X-Received: by 2002:a54:4083:: with SMTP id i3mr6470473oii.120.1610734988375; 
 Fri, 15 Jan 2021 10:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20210115034152.1800769-1-zhangzhijie@loongson.cn>
In-Reply-To: <20210115034152.1800769-1-zhangzhijie@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Jan 2021 13:22:57 -0500
Message-ID: <CADnq5_MMW7CpGiAu_oDqt6XRP+9NJt8gTMV0aMk2NxGSCRqqZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu:this forword declear maybe not used
To: "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 15, 2021 at 3:55 AM ZhiJie.Zhang <zhangzhijie@loongson.cn> wrote:
>
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>

Applied with a cleaned up commit message.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2ee6edb3df93..ef4acb1d4a80 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -58,10 +58,10 @@
>  /* Forward declarations */
>  struct amdgpu_device;
>  struct drm_device;
> -struct amdgpu_dm_irq_handler_data;
>  struct dc;
>  struct amdgpu_bo;
>  struct dmub_srv;
> +struct dc_plane_state;
>
>  struct common_irq_params {
>         struct amdgpu_device *adev;
> @@ -438,11 +438,6 @@ struct amdgpu_dm_connector {
>
>  extern const struct amdgpu_ip_block_version dm_ip_block;
>
> -struct amdgpu_framebuffer;
> -struct amdgpu_display_manager;
> -struct dc_validation_set;
> -struct dc_plane_state;
> -
>  struct dm_plane_state {
>         struct drm_plane_state base;
>         struct dc_plane_state *dc_state;
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
