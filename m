Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28005C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 20:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42AED46D6;
	Mon, 15 Aug 2022 20:32:05 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654F8D46CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 20:31:57 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 l5-20020a05683004a500b0063707ff8244so6157904otd.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=jgGIGjbFJQC66lxyfOo+nrbQUotD6MOMR0R9hwj6v/A=;
 b=Pk9lwJ46K3r4X7dHVmfSfmAfG7HXoO46JDDhEna0TSykTX0/6nmfp7mPxjr7iYe85M
 NPuyGzCNdo/GpIBO4hRkE3uvjvGks0Gvy11Oqh9x/VeuhJX2/2P7TtWMlmCe5fGgjDkv
 NdgHMNaDeUd7nUkkah5uUteiKEpu+fDMElpOxxY7lsyKI7LXJ3YKrnPkKHTKPZKTh0ws
 ZNq0YQLM5ZzEirTJITJCqqSCLU9MAMa44QHwrgJIU36x2MxMmy822Wfk18dgr2F6heBD
 zBlakht3Sx8/icI7eyZMikuCS0A5tQ3Qez6qhKLDaMYF/06+geUOMueR/WpxFhF6DBYh
 dk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=jgGIGjbFJQC66lxyfOo+nrbQUotD6MOMR0R9hwj6v/A=;
 b=n9a4ittQOX/s3k2feHWLi3XYMVbUUFs0PLSV0oEwRyw8kZU5nsLeVDHbccb4zA0YQm
 Vi5CF3XKm+oZmXR5IExYs1hVZW6oo6m6xYf5igr1Pt3GdbJrqrRKjO5SJQykJ2zR7uLB
 33KBiNfq7+uf/io2yjeioeoJEoiiJEpD1hAedCZFj1ZKgYyS9uFDl5g7L5Tf/xYXh+xQ
 ss+IJ6S/J9p17vpmJnTO0QbFLkkhprX2zLING+/KCmJjsyr2m9jHJpF+HgnSAeibmvcD
 ExULMnEMaiU/AxBJ5d+E9PvnjWkHbxrKPdO0sPb9JohZM/WAuHlrEvPeAS0vhyxnD9EN
 AaXw==
X-Gm-Message-State: ACgBeo1XD3L7IECGqB/rus7J/24kwsKC8LLXEvJoI5Jp6noYD+8zwoDb
 FNFPnqNsq7qML1CICP3c1Tz3e9NX0WAzV5hWNoY=
X-Google-Smtp-Source: AA6agR45b7xgXW7A6pjsCLH+ySsn7uGUrrubP+Ho3DKPS+8wUEwlUGT1VIlSeMvZ3rTXhQQAF6nFk1zw1c+WX1k/OR4=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr6646655otr.12.1660595516663; Mon, 15 Aug
 2022 13:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220811204327.411709-1-tales.aparecida@gmail.com>
 <20220811204327.411709-3-tales.aparecida@gmail.com>
In-Reply-To: <20220811204327.411709-3-tales.aparecida@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Aug 2022 16:31:45 -0400
Message-ID: <CADnq5_PiXKXaaLbkT4yCNUqREqxrL2Vh7AoxQXQ7PkOEFj=yZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: fix minor codestyle problems
To: Tales Aparecida <tales.aparecida@gmail.com>
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
Cc: Daniel Vetter <daniel@ffwll.ch>, siqueirajordao@riseup.net,
 magalilemes00@gmail.com, Leo Li <sunpeng.li@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 David Airlie <airlied@linux.ie>, Isabella Basso <isabbasso@riseup.net>,
 davidgow@google.com, Alex Deucher <alexander.deucher@amd.com>,
 mairacanal@riseup.net, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied the series.  Thanks!

Alex

On Thu, Aug 11, 2022 at 4:44 PM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Fixes five checkpatch warnings:
>
> CHECK: Please don't use multiple blank lines
> +
> +
>
> ERROR: Macros with complex values should be enclosed in parentheses
> +#define MAX_I64 \
> +       (int64_t)((1ULL << 63) - 1)
>
> WARNING: Missing a blank line after declarations
> +       struct bw_fixed res;
> +       ASSERT(value < BW_FIXED_MAX_I32 && value > BW_FIXED_MIN_I32);
>
> ERROR: that open brace { should be on the previous line
> +               do
> +               {
>
> ERROR: that open brace { should be on the previous line
> +                       if (remainder >= arg2_value)
> +                       {
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> index 2d46bc527b21..3aa8dd0acd5e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> @@ -25,9 +25,8 @@
>  #include "dm_services.h"
>  #include "bw_fixed.h"
>
> -
>  #define MAX_I64 \
> -       (int64_t)((1ULL << 63) - 1)
> +       ((int64_t)((1ULL << 63) - 1))
>
>  #define MIN_I64 \
>         (-MAX_I64 - 1)
> @@ -49,6 +48,7 @@ static uint64_t abs_i64(int64_t arg)
>  struct bw_fixed bw_int_to_fixed_nonconst(int64_t value)
>  {
>         struct bw_fixed res;
> +
>         ASSERT(value < BW_FIXED_MAX_I32 && value > BW_FIXED_MIN_I32);
>         res.value = value << BW_FIXED_BITS_PER_FRACTIONAL_PART;
>         return res;
> @@ -78,14 +78,12 @@ struct bw_fixed bw_frc_to_fixed(int64_t numerator, int64_t denominator)
>         {
>                 uint32_t i = BW_FIXED_BITS_PER_FRACTIONAL_PART;
>
> -               do
> -               {
> +               do {
>                         remainder <<= 1;
>
>                         res_value <<= 1;
>
> -                       if (remainder >= arg2_value)
> -                       {
> +                       if (remainder >= arg2_value) {
>                                 res_value |= 1;
>                                 remainder -= arg2_value;
>                         }
> --
> 2.37.0
>
