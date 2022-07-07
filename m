Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728FAC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 03:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE27111268D;
	Thu,  7 Jul 2022 03:01:35 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB4911268D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 03:01:35 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id g26so30128931ejb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jul 2022 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KpPHVF1nfIeVtEHZNbPLRqXXa3Dp4YpbMkHQTFDRuUo=;
 b=J9e7SAvUCUkGd6931X1OEIC5+60UPxzm21JoMh48KVXhwqQgWyZ9wu6D7eDmPPDcAS
 p41O5ciwHSgI/T4zpoxBb5aDZKLdelyPn4F5ljPPvQw2s+H8HPyhXf2/LvqySPp2dnDK
 w346k5oIfA5hJ9TrEIuFBfmsbIY9vsnzInLIz1WjvAe38eLVRvRnh3cUIYSrO0cLCix2
 HUtrqvVcl34Mw97VDg3+39dVeeiVkrXXXJdI88PlE8wmbF3tzwESJYXLmlIlaq9UfaUL
 WzhSbdgiHcrb+KjI9QtbAg9kK5QU6nlnesKlAOgKxOrk7CokjhqEvhmokeykqRcRwQxh
 mhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KpPHVF1nfIeVtEHZNbPLRqXXa3Dp4YpbMkHQTFDRuUo=;
 b=6YgOH9LxnhVxCmcbC7Fe0APXnDHcH2bFZGO24GhoS5KVTk13Frki7Ui0B+3Fc/fa5H
 nmAbcQ1WT4z1CokGUHtyxLs1Y+TCaTykvCP/Q8NTkK1q28PlRm1sneVhXa1HPinqe5kV
 5fLe5JKxOxsIRI4+vaPI5kOTlL7wUvQL6yVzTlXu46eaZiDOou9SyjOXN+jEiBf8grnt
 rAKOp5LFeIYPIhJhp0iA41V6AjAMVAKzRzIP4GZ1B53COWj3lXz9SBKfqo5ky1BHRuD+
 sMJrhSnpk2SxHkL+KHYPzZuX/yF+cJjqiD/o8Ul3mgNRQ2AlBlhXQ1LyNtlWGCJn8T/o
 KeUA==
X-Gm-Message-State: AJIora8yCLQg7UASafx3PK4SeW7VRK3p04Q2kNx+FclaKsRXjmPD2TiZ
 DX478SXGao0+TyFb4U73q42RVVybiLjwrkjSzm4=
X-Google-Smtp-Source: AGRyM1vODdBJq8KNJdTZSUSjqm0nrDPUaTiK1pGT1+dx84E4uwwjm0XH0jrQSF32WXUUfHL5HEhUsPX50jrcliA2T20=
X-Received: by 2002:a17:907:d22:b0:726:dbb1:8828 with SMTP id
 gn34-20020a1709070d2200b00726dbb18828mr43421645ejc.722.1657162893654; Wed, 06
 Jul 2022 20:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220707024531.90263-1-evan.quan@amd.com>
In-Reply-To: <20220707024531.90263-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Jul 2022 23:01:21 -0400
Message-ID: <CADnq5_Mv2iwJK2035-8dU6-7jhZpyAFsrK5veK5coUpZRuRXFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: correct idle_power_optimizations
 disablement return value
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 "for 3.8" <Stable@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 6, 2022 at 10:46 PM Evan Quan <evan.quan@amd.com> wrote:
>
> [Why]
> The return value indicates whether the operation(disable/enable) succeeded
> or not. The existing logic reports wrong result even if the disablement was
> performed successfully. That will make succeeding reenablement abandoned
> as dc->idle_optimizations_allowed is always true.
>
> [How]
> Correct the return value to reflect the real result of disablement.
>
> Fixes: e40fcd4a ("drm/amd/display: add DCN32/321 specific files for Display Core")

Need 12 places for the git hash:
Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files
for Display Core")

> Cc: <Stable@vger.kernel.org>

This doesn't need to go to stable.  These changes are queued up for 5.20.

Patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: If87d4cf76f6cfb36d607f051ff32f9c7870b4d6d
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index d53cbfef3558..1acd74fa4e55 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -373,7 +373,7 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
>         dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
>         dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
>
> -       return false;
> +       return true;
>  }
>
>  /* Send DMCUB message with SubVP pipe info
> --
> 2.29.0
>
