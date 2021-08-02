Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE00C432BE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A1A60232
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00A1A60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019216E21D;
	Mon,  2 Aug 2021 19:00:57 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0046E19C;
 Mon,  2 Aug 2021 19:00:55 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id n16so18712613oij.2;
 Mon, 02 Aug 2021 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nbrc0x7cBePFWpue6P0CQy4Z2rROhmn1R5Qbq29mtWk=;
 b=mY2MMpizcw6Sj9yi5PQnA4xrr7aT0f6pxShy7s9f0RQOhanYcGVkoRA07y0Bsh/qdd
 iw3MGtB6UYkz0tF6he4rhTl55dZGVYybvR8zgCA83a9FRZ1GBA49B+oXHnmoJ+g+bWrd
 tieUmLjeOuOtAky2s6peDZa6+VRmk/G1HE+gUPm6KdCZV6QmQKaLHSRmkLssIocoUMlq
 1qE2c5pqlgz5udxH1R6ceMM2x8fGx9wiYYuCHZBuo+rniDizQeXX7eOOnGKsVfKDyvWy
 ox2+aU/PmObjbPbBh7fasmhEbAAfrPoeQFAtm07GAuTKd1VKrPgESJoWOrFtNZb+Ztkv
 72EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nbrc0x7cBePFWpue6P0CQy4Z2rROhmn1R5Qbq29mtWk=;
 b=D5JKg+R4EuVo5i1amFriDkHMO43MyxavTRefrk638KJx5tPc/cn9aspUe0Dn8StBwo
 iwK8P5ZJooVsxhaxdu3AqYKaJo7wMmjGXdNs1DERgSm2YetVDnS8N2D/ITYy5ZWROuvN
 fA4nIExw2xpVbn81rgnCdl2gQzayKCxHlLgWuxXf7rRkxbzMnpPCPzV8M60yAyJoC9Rm
 zAtuniixjurLNlAaWpprO4RIWWb0jxJOgHS6OGvEMC5MSc3memt9iMbykjh8pOr50Ku/
 UCUehEFYj/T5JIMUF0UrQ8QyAgjzYmINNWczgvp3ysNEX0ZbPorXegSRjsxiJKeMFVCG
 eoGw==
X-Gm-Message-State: AOAM533mpGZwekf2xWXSuysiNC2KwuOQMq0jX7HzAZxJOB2AMdm/S1XE
 j0KTiab9WEBm5z2gi0B6sdndYX/RmawpvyLLPLg=
X-Google-Smtp-Source: ABdhPJzvruV9/L01NSfd/N3KeYc5cMMjB7KrWCYzZhNaVKsPAtHsNwOUIPCfEfaY2OjNgL+guDmnHj/A6MELoI80HOs=
X-Received: by 2002:aca:53ca:: with SMTP id h193mr320764oib.5.1627930854745;
 Mon, 02 Aug 2021 12:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <1627889555-56431-1-git-send-email-zhouchuangao@vivo.com>
In-Reply-To: <1627889555-56431-1-git-send-email-zhouchuangao@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Aug 2021 15:00:43 -0400
Message-ID: <CADnq5_Peu054E8AOZ0Wo5Sg-ADR0F_pwaT6_e5PmN_ji3=BmWw@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/amd: Remove duplicated include of drm_drv.h
To: zhouchuangao <zhouchuangao@vivo.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, John Clements <john.clements@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Jinzhou Su <Jinzhou.Su@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>, 
 Victor Zhao <Victor.Zhao@amd.com>, Kevin Wang <kevin1.wang@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 2, 2021 at 3:32 AM zhouchuangao <zhouchuangao@vivo.com> wrote:
>
> Duplicate include header file <drm/drm_drv.h>
> line 28: #include <drm/drm_drv.h>
> line 44: #include <drm/drm_drv.h>
>
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3ec5099..05f864f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -41,8 +41,6 @@
>  #include "amdgpu_securedisplay.h"
>  #include "amdgpu_atomfirmware.h"
>
> -#include <drm/drm_drv.h>
> -
>  static int psp_sysfs_init(struct amdgpu_device *adev);
>  static void psp_sysfs_fini(struct amdgpu_device *adev);
>
> --
> 2.7.4
>
