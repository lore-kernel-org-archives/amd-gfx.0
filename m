Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0757C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 18:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE8B10F5DE;
	Tue,  7 Jun 2022 18:36:17 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D6C10F587;
 Tue,  7 Jun 2022 18:36:16 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id r206so25014981oib.8;
 Tue, 07 Jun 2022 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=et5d4DM7Qkz5qPPCoiTPlM6P1258hTgQ0iEkTPrpV+I=;
 b=PuFBuqldb4cHgsAojupGIYPzKREKfkNatPa7bNJQ3T7Y+VXcNNgnWsYkvgJ/efgrh3
 6Tn3ounWD12Wg3D59zmyEuUSXPLON+5y+Nue/CWFFSBVH4f/G7rc7jpirEo3w6c2wPxC
 xHFhs/2y9CqjlPp5zehXBRxbhz6Hoz43R/XOkXaUR/jU++0Rvqfu/8tpLqh0ykZLOqCM
 E7ev37DY+9K9VrD5xzMbiLXP5yu8PUfmJjpJ3AjJKgAR28c36eSF84wSsYmuVxp65Dy0
 ocOiAaBGBT87tJfATIkqFQLfoCX1V2jcq2zXGsnmZpjMeZ56p2G8QVcGYYZG4KFtFwo8
 JjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=et5d4DM7Qkz5qPPCoiTPlM6P1258hTgQ0iEkTPrpV+I=;
 b=qTYjaL1ghn7XQZ3pozi9MLzIwRc7QDRd73wxdUdKRUQJqUO4GsCLvRihUO/2rc1S+a
 2n1UP4mbCCPKD5G3X6vncfQZYNCCakALfYuuS601CUHZGGz6qNgDEmOvtrFDJ01Ad1Ux
 A2rgOtOx6bahe/7ae54ylAxzrKh0YpFUTtdOQnqU8LgaelfnkX3xLDbRyu/OHVP+H3S3
 8tZ7fRrJi/ITjDDfmU8a2iZdUXFLispRWebyWqb84+kDO9oKS/ntGGjBMgc3J+TUgEtU
 cSjYkoIBP8hy5FI74Itc4pMals5yzE7SG3PhghsQJpzBialxNUTChJn/nfuTl/3VmVlF
 zsjw==
X-Gm-Message-State: AOAM533LhasK8pwI/VIhrPNz2sb6x+icHEwvfql6laX1jhSkTrbxjOws
 i+L7+Pbs0oEA4Qm2oTRlLwt9vVfjqh9y3xNZwCQ=
X-Google-Smtp-Source: ABdhPJzmUwUQfQ1DjEveyo8nz4KlADt9ph70/XrvL3Meqmc0UgfuQHYvRofrgjdJ+ret0rbkQJflWwhjvu8RZcC6Ftk=
X-Received: by 2002:a54:4f01:0:b0:32e:726c:bced with SMTP id
 e1-20020a544f01000000b0032e726cbcedmr128014oiy.253.1654626973764; Tue, 07 Jun
 2022 11:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220607151933.32850-1-xiaohuizhang@ruc.edu.cn>
In-Reply-To: <20220607151933.32850-1-xiaohuizhang@ruc.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 14:36:02 -0400
Message-ID: <CADnq5_MiHN=iXt4E5AKSixRqMR5bkqwoxXd_KUj02DFtcwhS6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/radeon: Initialize fences array entries in
 radeon_sa_bo_next_hole
To: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
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
Cc: David Airlie <airlied@linux.ie>, xinhui pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Jun 7, 2022 at 12:04 PM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
>
> Similar to the handling of amdgpu_sa_bo_next_hole in commit 6a15f3ff19a8
> ("drm/amdgpu: Initialize fences array entries in amdgpu_sa_bo_next_hole"),
> we thought a patch might be needed here as well.
>
> The entries were only initialized once in radeon_sa_bo_new. If a fence
> wasn't signalled yet in the first radeon_sa_bo_next_hole call, but then
> got signalled before a later radeon_sa_bo_next_hole call, it could
> destroy the fence but leave its pointer in the array, resulting in
> use-after-free in radeon_sa_bo_new.
>
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_sa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
> index 310c322c7112..0981948bd9ed 100644
> --- a/drivers/gpu/drm/radeon/radeon_sa.c
> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> @@ -267,6 +267,8 @@ static bool radeon_sa_bo_next_hole(struct radeon_sa_manager *sa_manager,
>         for (i = 0; i < RADEON_NUM_RINGS; ++i) {
>                 struct radeon_sa_bo *sa_bo;
>
> +               fences[i] = NULL;
> +
>                 if (list_empty(&sa_manager->flist[i])) {
>                         continue;
>                 }
> @@ -332,10 +334,8 @@ int radeon_sa_bo_new(struct radeon_device *rdev,
>
>         spin_lock(&sa_manager->wq.lock);
>         do {
> -               for (i = 0; i < RADEON_NUM_RINGS; ++i) {
> -                       fences[i] = NULL;
> +               for (i = 0; i < RADEON_NUM_RINGS; ++i)
>                         tries[i] = 0;
> -               }
>
>                 do {
>                         radeon_sa_bo_try_free(sa_manager);
> --
> 2.17.1
>
