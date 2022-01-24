Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302D1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 20:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5E610EA50;
	Mon, 24 Jan 2022 20:28:58 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E52C10E918
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 20:21:24 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id b9so3273366lfq.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 12:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wyMvRdYooGkNnpiPbja1/uSfdA1/U9snsdIqkkHvJEc=;
 b=htyyJ1Z3GRsmUZan58N3Prr0pEBcELIKOR7HkjpOyyQX11oHKKsVhGziUzHRAk9gAQ
 qKIJ1la4FQPjdeduY0TumzsXC1keATPYK+6nRTIgrBg2Yx3j+qLswnmWYNKKkUD32SGa
 NEUVgy1cbCWp9ftv9S/S5W24Xf77OuvIUUPVXQgqfByM1wogeIS6Un6jOyUF9MMCkpXG
 teWa0koFmo2WyVhH9ii5kbYSuulkh24QTq4DkaKRlSHApSrAqcmB2KzC4vQu8X9FU9gv
 2EOV8xLbbtvhhc9TN8f/mQhQ6bw3lBLH/4ZukkYU7sfiq5QPCY/xyIFbbSA1hYPq/sPZ
 OO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wyMvRdYooGkNnpiPbja1/uSfdA1/U9snsdIqkkHvJEc=;
 b=sgroqVhRpyowuaNdUUnrVwqSD7Ne0FIRPwjPlWTLZfqqFCYYpLY4jLh19Cq+bDVMfQ
 HXKTdHVX0l9derl93MJzqF9B74hfBSVRB6p54U1rj+rXLtG3IRBnnictjPUJ8BVkeiOJ
 ozwn/A9BdL+L8QOTNM/Mhk/EGNbRfwscc2094yM1CnohiWVZFg0PJ+4+lFUQQKjgwOyN
 I+TiPDc2uMLP5FFQr7bV3o6o7/f7mdJiYhIcdIUUn0FIWTbloZEUJeGpN8bMrt8e83In
 oFibKAEdO3ysr/NYyOyI+UkVHKGAQ/OsEV+h2wGj+2fMmOsxztfP5c1GJEkF5T2atMf7
 QLUg==
X-Gm-Message-State: AOAM530SbJGUAlHIOCNTPyMXvoSACIaV0xQAN3qsJoVG5hRcutlZEho9
 WzKbodtSSTbbIC4icHaSET/ap1Tp5muuxmDQA5EUcA==
X-Google-Smtp-Source: ABdhPJzNbWHLfVK0G4oHmQubeJbQeEM15S/l2in0t/MpUPzxIWlbk0Bzs9ERTx3WfdkjIX9h30ubfENOdawlZCrT2bU=
X-Received: by 2002:a19:ad02:: with SMTP id t2mr14058303lfc.82.1643055680456; 
 Mon, 24 Jan 2022 12:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20220119224628.123084-1-colin.i.king@gmail.com>
In-Reply-To: <20220119224628.123084-1-colin.i.king@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 24 Jan 2022 12:21:07 -0800
Message-ID: <CAKwvOdnMibw77AvvWw7seB2PPamS_OLMUarSjdsa4w4OP1isKg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove redundant assignment to reg
To: Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 24 Jan 2022 20:28:57 +0000
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
Cc: llvm@lists.linux.dev, David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 19, 2022 at 2:46 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The pointer reg is being assigned a value that is not read, the
> exit path via label 'out' never accesses it. The assignment is
> redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/gpu/drm/radeon/radeon_object.c:570:3: warning: Value
> stored to 'reg' is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/radeon/radeon_object.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> index 56ede9d63b12..87536d205593 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -567,7 +567,6 @@ int radeon_bo_get_surface_reg(struct radeon_bo *bo)
>                 return 0;
>
>         if (bo->surface_reg >= 0) {
> -               reg = &rdev->surface_regs[bo->surface_reg];
>                 i = bo->surface_reg;
>                 goto out;
>         }
> --
> 2.33.1
>
>


-- 
Thanks,
~Nick Desaulniers
