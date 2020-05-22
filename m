Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AC8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE17206C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBVHe+gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE17206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C866EA1A;
	Fri, 22 May 2020 18:07:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09C66EA1A;
 Fri, 22 May 2020 18:07:20 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l11so11065296wru.0;
 Fri, 22 May 2020 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=93lHuKjSOpUJm9qcBgsEQEeev3s+aLgQZS3xLE3PBVc=;
 b=NBVHe+gPt5+hwmNSzqlQpXMGvkD6RmLKIwg06tb+MU5Rw/pWZBSt0hO6RbFdOw+0o9
 GQshyiWpyQD1vL+wXLRCvzo7o7iw0+Zqy85PslvQB8/dQ85zgwGz3hN5tBHoPAMTl+jw
 0BKSELtB77IkBlLFgjsBl+NyDAPLkYoJ/oM+4/HdZu6FhlwJgVbSr52EfD9EMqb0W919
 obpgdiML5afToGsMG0AvBHNeH6Ue4SrORP3IJoVOeq55YI2/73fX9sV67CeG5P5Wnqcf
 4fk4r+ZueA8/Ao7DslGJDfFOyN682Xq7UZCZBGWcSYh2IzNYcrG/Nsn4k9ry1i0g+1me
 a0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=93lHuKjSOpUJm9qcBgsEQEeev3s+aLgQZS3xLE3PBVc=;
 b=k4Hvujenx6xH/zFhQxiTC2UAiRPpz7e+wXmK1XOcBpJnzyWtvHiNrUna/tVXXyDuxM
 X0/QFlT2/gjcf+lFZTvUssa17qYuu0ZPoLTfPmO7djqOW1bWRiPhXCL4EaWIHClypLI7
 XuCDaPcHUWi8rPrqq5ql5MdGAZl640KfYs7/LF8VzaQK0KVFU5Flsh/4m7yb1V6QvPds
 dQ6Y3mvmZEoKhIbl77w/BHDQe9bBZD7ZKGNkJnUgCtSnkC5M5FqkLt0VfLmxya4dpnkC
 wyDOLH4nlBRo7U+jla/usQ5BtMk5VAB2bcQNGq/961hXYmS6iucz9K3EPQYVoakNY8oZ
 ugIA==
X-Gm-Message-State: AOAM530TWek+bQs/0iU858KCgBmniZDN5kyd20Lz3T0DbHZZjahJWXpt
 tyH1lgnfUkyCDirtQpJdEpsck04eSzr5ZSicULQ=
X-Google-Smtp-Source: ABdhPJwIhvF9Fis6pbQ0FJq61OaaurC/QA/KpTpRunMMZ7744HdxYgsYvG6/+mTVj0z6X9bbMCKQnhv3R3Ob7cI0XBA=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr4481054wrq.374.1590170839532; 
 Fri, 22 May 2020 11:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200522174355.GA4406@embeddedor>
In-Reply-To: <20200522174355.GA4406@embeddedor>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 May 2020 14:07:08 -0400
Message-ID: <CADnq5_NuDA9tT05B0bDqfCi0v=j3emjxLGxKA6hTTuAjRoM4xA@mail.gmail.com>
Subject: Re: [PATCH] drm/[radeon|amdgpu]: Replace one-element array and use
 struct_size() helper
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 22, 2020 at 1:39 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>     int length;
>     u8 data[1];
> };
>
> struct something *instance;
>
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
>
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct SISLANDS_SMC_SWSTATE.
>
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c       | 5 ++---
>  drivers/gpu/drm/amd/amdgpu/sislands_smc.h | 2 +-
>  drivers/gpu/drm/radeon/si_dpm.c           | 5 ++---
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index c00ba4b23c9a6..0fc56c5bac080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -5715,10 +5715,9 @@ static int si_upload_sw_state(struct amdgpu_device *adev,
>         int ret;
>         u32 address = si_pi->state_table_start +
>                 offsetof(SISLANDS_SMC_STATETABLE, driverState);
> -       u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
> -               ((new_state->performance_level_count - 1) *
> -                sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
>         SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
> +       size_t state_size = struct_size(smc_state, levels,
> +                                       new_state->performance_level_count);
>
>         memset(smc_state, 0, state_size);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h b/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
> index d2930eceaf3c8..a089dbf8f7a93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
> @@ -186,7 +186,7 @@ struct SISLANDS_SMC_SWSTATE
>      uint8_t                             levelCount;
>      uint8_t                             padding2;
>      uint8_t                             padding3;
> -    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
> +    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
>  };
>
>  typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index a167e1c36d243..bab01ca864c63 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5253,10 +5253,9 @@ static int si_upload_sw_state(struct radeon_device *rdev,
>         int ret;
>         u32 address = si_pi->state_table_start +
>                 offsetof(SISLANDS_SMC_STATETABLE, driverState);
> -       u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
> -               ((new_state->performance_level_count - 1) *
> -                sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
>         SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
> +       size_t state_size = struct_size(smc_state, levels,
> +                                       new_state->performance_level_count);
>
>         memset(smc_state, 0, state_size);
>
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
