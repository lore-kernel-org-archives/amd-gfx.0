Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C120C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB4B10EB0A;
	Wed,  1 Jun 2022 17:27:42 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F0410EB0A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:27:41 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id y131so3514115oia.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wg6orlg+XsSyaqSL8V4px68IgaSxU4Kozik5MJGZ39w=;
 b=odFPjh0BxNB2g1UelnVuR7Pn0CPifrzb2VnlSuxMjW4Yl5dz5UsS4+8Ceagh3OrqeP
 qkwSSm3tyf+f1ZHwCecE8wB8lOdb7mwW1muOoHWFqSW10Wp2tZQVCOfkVniQY31ezDfy
 9SuunDYuOeCMUGbrHpV3NN0NHzjzbWWDVv16M+2JFV5gSvBvs/ofluNCOeghf7YRb4GL
 F+kST7Ct6gbxuANxkJHoFzja8knH7aHvajfJ+E8ksU6ySIOTpwiqcbwj6dDNyecYXZG+
 dV4LUYi4+7rj3pV6MVWf+jLBZfYL+aXAMtKAbZIz2xLUj2yPLxJ1U2jgExAzIKB9KxHs
 xoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wg6orlg+XsSyaqSL8V4px68IgaSxU4Kozik5MJGZ39w=;
 b=aDVsVKp3SeVBXRRa1VMbpCaeQWbuqWntXY41fGOKgvxq0XQmC3hSTeUPNVChOJWrhK
 zyf5XAu+tMsnvXByI6R37LnIiDbb4RNdf9k+OQrsbgFwaltwQi/nz1h5k7SDpbQXOcL0
 EumpHEMnkGvs7ExYN4ptCSPiDdTgpAJeLxjFeoxWaDoL0g8+ufnQ+bDg42pDcAWiddL7
 1h10EJK8/0Cn84yuB0XVO/YIlaEcaN8hwpWRwCj/P754ZO6Lo0KtMgMHo9YsapTBcpjT
 5R/tPpkSemhKX/YbITI1vj5cAQWX7AWrWh4u6oI2GsXXYCMFd/AJ3eq4G8Nmnc1o0b56
 Yg4g==
X-Gm-Message-State: AOAM530mcog8DbWAluceDBcKd78ikadQWlOzAeIdc+bw21BBKUqfgDiK
 zqF3GQeoMDriUIVYsBONmh+6q6MlXkRz71WG5Ch/3Ti7
X-Google-Smtp-Source: ABdhPJyQbIKgFQMqMfPhB5MuOfpC1DiGz/8kFlUI6CwwquBnGeyddtY6J7nLYJUT/VTyFem5BcIFymL2dChNwDsSifk=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr15216019oiu.200.1654104460866; Wed, 01
 Jun 2022 10:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220531022722.2516610-1-sunil.khatri@amd.com>
In-Reply-To: <20220531022722.2516610-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 13:27:30 -0400
Message-ID: <CADnq5_PMYjpqiGCntGuT=5xopa7iD0n173ugkjqW7F2YU_8WEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable tmz by default for GC 10.3.7
To: Sunil Khatri <sunil.khatri@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 30, 2022 at 10:27 PM Sunil Khatri <sunil.khatri@amd.com> wrote:
>
> Add IP GC 10.3.7 in the list of target to have
> tmz enabled by default.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Assuming this is validated and working,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 798c56214a23..aebc384531ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(9, 1, 0):
>         /* RENOIR looks like RAVEN */
>         case IP_VERSION(9, 3, 0):
> +       /* GC 10.3.7 */
> +       case IP_VERSION(10, 3, 7):
>                 if (amdgpu_tmz == 0) {
>                         adev->gmc.tmz_enabled = false;
>                         dev_info(adev->dev,
> @@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 1):
>         /* YELLOW_CARP*/
>         case IP_VERSION(10, 3, 3):
> -       /* GC 10.3.7 */
> -       case IP_VERSION(10, 3, 7):
>                 /* Don't enable it by default yet.
>                  */
>                 if (amdgpu_tmz < 1) {
> --
> 2.25.1
>
